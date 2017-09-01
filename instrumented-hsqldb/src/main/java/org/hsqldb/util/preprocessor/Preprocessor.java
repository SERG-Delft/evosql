/* Copyright (c) 2001-2007, The HSQL Development Group
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * Redistributions of source code must retain the above copyright notice, this
 * list of conditions and the following disclaimer.
 *
 * Redistributions in binary form must reproduce the above copyright notice,
 * this list of conditions and the following disclaimer in the documentation
 * and/or other materials provided with the distribution.
 *
 * Neither the name of the HSQL Development Group nor the names of its
 * contributors may be used to endorse or promote products derived from this
 * software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL HSQL DEVELOPMENT GROUP, HSQLDB.ORG,
 * OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */


package org.hsqldb.util.preprocessor;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Stack;

/* $Id: Preprocessor.java 610 2008-12-22 15:54:18Z unsaved $ */

/**
 * Simple text document preprocessor. <p>
 *
 * Aims specifically at transforming the HSQLDB codebase to one of a small
 * number of specific build targets, while keeping complexity and external
 * dependencies to a minimum, yet providing an environment that is
 * sufficiently powerful to solve most easily imaginable preprocessing
 * scenarios.
 *
 * Supports the following (case-sensitive) directives: <p>
 *
 * <ul>
 *  <li>//#def[ine] IDENT (ASSIGN? (STRING | NUMBER | IDENT) )?
 *  <li>//#elif BOOLEXPR
 *  <li>//#elifdef IDENT
 *  <li>//#elifndef IDENT
 *  <li>//#else
 *  <li>//#endif
 *  <li>//#endinclude
 *  <li>//#if BOOLEXPR
 *  <li>//#ifdef IDENT
 *  <li>//#ifndef IDENT
 *  <li>//#include FILEPATH
 *  <li>//#undef[ine] IDENT
 * </ul>
 *
 * where BOOLEXPR is:
 *
 * <pre>
 * ( IDENT
 * | IDENT ( EQ |  LT | LTE | GT | GTE ) VALUE
 * | BOOLEXPR { OR | XOR | AND } BOOLEXPR
 * | NOT BOOLEXPR
 * | LPAREN BOOLEXPR RPAREN )
 *</pre>
 *
 * and VALUE is :
 *
 * <pre>
 * ( STRING
 * | NUMBER
 * | IDENT )
 * </pre>
 *
 * and lexographic elements are :
 *
 * <pre>
 * ASSIGN     : '='
 * EQ         : '=='
 * LT         : '<'
 * LTE        : '<='
 * GT         : '>'
 * GTE        : '>='
 * OR         : ('|' | '||')
 * XOR        : '^'
 * AND        : ('&' | '&&')
 * NOT        : '!'
 * DQUOTE     : '"'
 * LPAREN     : '('
 * RPAREN     : ')'
 * DOT        : '.'
 * DIGIT      : ['0'..'9']
 * EOL        : ('\n' | '\r' | '\n\r')
 * SPACE      : (' ' | '\t')
 * NON_DQUOTE : { ANY_UNICODE_CHARACTER_EXCEPT_DQUOTE_OR_EOL } -- see the unicode spec
 * NON_SPACE  : { ANY_UNICODE_CHARACTER_EXCEPT_SPACE_OR_EOL }  -- see the unicode spec
 * WS         : { JAVA_WS } -- see java.lang.Character
 * NON_WS     : { ANY_UNICODE_CHARACTER_EXCEPT_WS_OR_EOL }
 * STRING     : DQUOTE NON_DQUOTE* DQUOTE
 * NUMBER     : DIGIT+ (DOT DIGIT*)?
 * IDENT      : JAVA_IDENT_START JAVA_IDENT_PART*              -- see java.lang.Character
 * FILEPATH   : NON_SPACE (ANY_UNICODE_CHARACTER* NON_WS)?     -- i.e. trailing SPACE elements are ignored
 * </pre>
 *
 * The lexographic definitions above use the BNF conventions :
 *
 * <pre>
 * '?' -> zero or one
 * '*' -> zero or more
 * '+' -> one or more
 * </pre>
 *
 * Directives may be arbitrarily indented; there is an option (INDENT) to set
 * or unset directive indentation on output. There is also an option (FILTER)
 * to remove directive lines from output.  See {@link Option Option} for other
 * preprocessor options. <p>
 *
 * '//#ifxxx' directives may be nested to arbitrary depth,
 * may be chained with an arbitrary number of '//#elifxxx' directives,
 * may be optionally followed by a single '//#else' directive, and
 * must be terminated by a single '//#endif' directive. <p>
 *
 * Each '//#include' directive must be terminated by an '//#endinclude'
 * directive; lines between '//#include' and '//#endinclude' are replaced
 * by the content retrieved from the specified FILEPATH. <p>
 *
 * Included files are preprocessed in a nested scope that inherits the
 * defined symbols of the including scope. Directive lines in included files
 * are always excluded from output. <p>
 *
 * <b>Design Notes</b><p>
 *
 * There are many better/more sophisticated preprocessors/templating
 * engines out there.  FreeMaker and Velocity come to mind immediately.
 * Another--the NetBeans MIDP preprocessor--was the direct inspiration for
 * this class. <p>
 *
 * Other options were rejected because the work of creating this class appeared
 * to be less than dealing with the complexity and dependency issues of hooking
 * up to external libraries.
 *
 * The NetBeans preprocessor, in particular, was rejected because it was
 * not immediately evident how to invoke it independently from the IDE,
 * how to make it available to non-MIDP projects from within the IDE or how to
 * isolate the correct OpenIDE jars to allow stand-alone operation. <p>
 *
 * @author boucherb@users
 * @version 1.8.1
 * @since 1.8.1
 */
public class Preprocessor {

    // =========================================================================
    // ------------------------------- Public API ------------------------------
    // =========================================================================

    /**
     * Preprocesses the specified list of files. <p>
     *
     * @param sourceDir under which input files are located
     * @param targetDir under which output files are to be written
     * @param fileNames to be preprocessed
     * @param altExt to use for output file names
     * @param encoding with which to write output files
     * @param options used to control preprocessing
     * @param defines CSV list of symbol definition expressions
     * @param resolver with which to perform property and path expansions
     * @throws PreprocessorException if an error occurs while loading,
     *      preprocessing or saving the result of preprocessing one of the
     *      specified input files
     */
    public static void preprocessBatch(File sourceDir, File targetDir,
            String[] fileNames, String altExt, String encoding, int options,
            String defines, IResolver resolver) throws PreprocessorException {

        for (int i = 0; i < fileNames.length; i++) {
            String fileName = fileNames[i];

            try {
                preprocessFile(sourceDir, targetDir, fileName, altExt, encoding,
                        options, defines, resolver);
            } catch (PreprocessorException ppe) {

                if (!Option.isVerbose(options)) {
                    log(fileName + " ... not modified, " + ppe.getMessage());
                }

                throw ppe;
            }
        }
    }

    /**
     * Preprocesses a single file. <p>
     *
     * @param sourceDir under which the input file is located
     * @param targetDir under which the output file is to be written
     * @param fileName to be preprocessed
     * @param altExt to use for output file name
     * @param encoding with which to write output file
     * @param options used to control preprocessing
     * @param defines CSV list of symbol definition expressions
     * @param resolver with which to perform property and path expansions
     * @throws PreprocessorException if an error occurs while loading,
     *      preprocessing or saving the result of preprocessing the
     *      specified input file
     */
    public static void preprocessFile(File sourceDir, File targetDir,
            String fileName, String altExt, String encoding, int options,
            String defines, IResolver resolver) throws PreprocessorException {

        String       sourcePath   = translatePath(sourceDir, fileName, null);
        String       targetPath   = translatePath(targetDir, fileName, altExt);
        File         targetFile   = new File(targetPath);
        File         backupFile   = new File(targetPath + "~");
        boolean      sameDir      = sourceDir.equals(targetDir);
        boolean      sameExt      = (altExt ==  null);
        boolean      verbose      = Option.isVerbose(options);
        boolean      testOnly     = Option.isTestOnly(options);
        boolean      backup       = Option.isBackup(options);
        Preprocessor preprocessor = new Preprocessor(sourcePath,
                encoding, options, resolver, defines);

        if (verbose) {
            log("Reading \"" + sourcePath + "\"");
        }

        preprocessor.loadDocument();

        boolean modified = preprocessor.preprocess();
        boolean rewrite  = modified || !sameDir || !sameExt;

        if (!rewrite) {
            if (verbose) {
                log(fileName + " ... not modified");
            }

            return;
        } else if (verbose) {
            log(fileName + " ... modified");
        }

        if (testOnly) {
            return;
        }

        try {
            targetFile.getParentFile().mkdirs();
        } catch (Exception e) {
            throw new PreprocessorException("mkdirs failed \"" + targetFile
                    + "\": " + e); // NOI18N
        }

        backupFile.delete();

        if (targetFile.exists() && !targetFile.renameTo(backupFile)) {
            throw new PreprocessorException("Rename failed: \""
                    + targetFile
                    + "\" => \""
                    + backupFile
                    +"\"" ); // NOI18N
        }

        if (verbose) {
            log("Writing \"" + targetPath + "\"");
        }

        preprocessor.saveDocument(targetPath);

        if (!backup) {
            backupFile.delete();
        }
    }

    // =========================================================================
    // ----------------------------- Implementation ----------------------------
    // =========================================================================

    // Fields

    // static
    static final int CONDITION_NONE      = 0;
    static final int CONDITION_ARMED     = 1;
    static final int CONDITION_IN_TRUE   = 2;
    static final int CONDITION_TRIGGERED = 3;

    // optimization - zero new object burn rate for statePush()
    static final Integer[] STATES = new Integer[] {
        new Integer(CONDITION_NONE),
        new Integer(CONDITION_ARMED),
        new Integer(CONDITION_IN_TRUE),
        new Integer(CONDITION_TRIGGERED)
    };

    // instance
    private String    documentPath;
    private String    encoding;
    private int       options;
    private IResolver resolver;
    private Document  document;
    private Defines   defines;
    private Stack     stack;
    private int       state;

    // Constructors

    private Preprocessor(String documentPath,
            String encoding, int options, IResolver resolver,
            String predefined) throws PreprocessorException {

        if (resolver == null) {
            File parentDir = new File(documentPath).getParentFile();

            this.resolver = new BasicResolver(parentDir);
        } else {
            this.resolver = resolver;
        }

        if (predefined == null || predefined.trim().length() == 0) {
            this.defines = new Defines();
        } else {
            predefined   = this.resolver.resolveProperties(predefined);
            this.defines = new Defines(predefined);
        }

        this.documentPath = documentPath;
        this.encoding     = encoding;
        this.options      = options;
        this.document     = new Document();
        this.stack        = new Stack();
        this.state        = CONDITION_NONE;
    }

    private Preprocessor(Preprocessor other, Document include) {
        this.document     = include;
        this.encoding     = other.encoding;
        this.stack        = new Stack();
        this.state        = CONDITION_NONE;
        this.options      = other.options;
        this.documentPath = other.documentPath;
        this.resolver     = other.resolver;
        this.defines      = other.defines;
    }

    // Main entry point

    private boolean preprocess() throws PreprocessorException {
        this.stack.clear();

        this.state = CONDITION_NONE;

        // optimization - eliminates a full document copy and a full document
        //                equality test for files with no preprocessor
        //                directives
        if (!this.document.contains(Line.DIRECTIVE_PREFIX)) {
            return false;
        }

        Document originalDocument = new Document(this.document);

        preprocessImpl();

        if (this.state != CONDITION_NONE) {
            throw new PreprocessorException("Missing final #endif"); // NOI18N
        }

        if (Option.isFilter(options)) {
            // Cleanup all directives.

            for (int i = this.document.size() - 1; i >= 0; i--) {
                Line line = resolveLine(this.document.getSourceLine(i));

                if (!line.isType(LineType.VISIBLE)) {
                    this.document.deleteSourceLine(i);
                }
            }
        }

        return (!this.document.equals(originalDocument));
    }

    private void preprocessImpl() throws PreprocessorException {
        int     includeCount = 0;
        int     lineCount    = 0;

        while (lineCount < this.document.size()) {

            try {
                Line line = resolveLine(this.document.getSourceLine(lineCount));

                switch(line.getType()) {
                    case LineType.INCLUDE : {
                        lineCount = processInclude(lineCount, line);

                        break;
                    }
                    case LineType.VISIBLE :
                    case LineType.HIDDEN : {
                        this.document.setSourceLine(lineCount,
                                toSourceLine(line));

                        if (Option.isVerbose(options)) {
                                log((isHidingLines() ? "Commented: "
                                                     : "Uncommented: ") + line);
                        }

                        lineCount++;

                        break;
                    }
                    default : {
                        processDirective(line);

                        lineCount++;
                    }
                }
            } catch (PreprocessorException ex) {
                throw new PreprocessorException(ex.getMessage() + " at line "
                        + (lineCount + 1)
                        + " in \""
                        + this.documentPath
                        + "\""); // NOI18N
            }
        }
    }

    // -------------------------- Line-level Handlers --------------------------

    private void processIf(boolean condition) {
        statePush();

        this.state = isHidingLines() ? CONDITION_TRIGGERED
                                     : (condition) ? CONDITION_IN_TRUE
                                                   : CONDITION_ARMED;
    }

    private void processElseIf(boolean condition) throws PreprocessorException {
        switch(state) {
            case CONDITION_NONE : {
                throw new PreprocessorException("Unexpected #elif"); // NOI18N
            }
            case CONDITION_ARMED : {
                if (condition) {
                    this.state = CONDITION_IN_TRUE;
                }

                break;
            }
            case CONDITION_IN_TRUE : {
                this.state = CONDITION_TRIGGERED;

                break;
            }
        }
    }

    private void processElse() throws PreprocessorException {
        switch(state) {
            case CONDITION_NONE : {
                throw new PreprocessorException("Unexpected #else"); // NOI18N
            }
            case CONDITION_ARMED : {
                this.state = CONDITION_IN_TRUE;

                break;
            }
            case CONDITION_IN_TRUE : {
                this.state = CONDITION_TRIGGERED;

                break;
            }
        }
    }

    private void processEndIf() throws PreprocessorException {
        if (state == CONDITION_NONE) {
            throw new PreprocessorException("Unexpected #endif"); // NOI18N
        } else {
            statePop();
        }
    }

    private void processDirective(Line line) throws PreprocessorException {
        switch(line.getType()) {
            case LineType.DEFINE : {
                if (!isHidingLines()) {
                    this.defines.defineSingle(line.getArguments());
                }

                break;
            }
            case LineType.UNDEFINE : {
                if (!isHidingLines()) {
                    this.defines.undefine(line.getArguments());
                }

                break;
            }
            case LineType.IF : {
                processIf(this.defines.evaluate(line.getArguments()));

                break;
            }
            case LineType.IFDEF : {
                processIf(this.defines.isDefined(line.getArguments()));

                break;
            }
            case LineType.IFNDEF : {
                processIf(!this.defines.isDefined(line.getArguments()));

                break;
            }
            case LineType.ELIF : {
                processElseIf(this.defines.evaluate(line.getArguments()));

                break;
            }
            case LineType.ELIFDEF : {
                processElseIf(this.defines.isDefined(line.getArguments()));

                break;
            }
            case LineType.ELIFNDEF : {
                processElseIf(!this.defines.isDefined(line.getArguments()));

                break;
            }
            case LineType.ELSE : {
                processElse();

                break;
            }
            case LineType.ENDIF : {
                processEndIf();

                break;
            }
            default : {
                throw new PreprocessorException("Unhandled line type: "
                        + line); // NOI18N
            }
        }
    }

    private int processInclude(int lineCount, Line line)
    throws PreprocessorException {
        String    path   = resolvePath(line.getArguments());
        boolean   hidden = isHidingLines();

        lineCount++;

        while (lineCount < this.document.size()) {
            line = resolveLine(this.document.getSourceLine(lineCount));

            if (line.isType(LineType.ENDINCLUDE)) {
                break;
            }

            this.document.deleteSourceLine(lineCount);
        }

        if (!line.isType(LineType.ENDINCLUDE)) {
            throw new PreprocessorException("Missing #endinclude"); // NOI18N
        }

        if (!hidden) {
            Document     include      = loadInclude(path);
            Preprocessor preprocessor = new Preprocessor(this, include);

            preprocessor.preprocess();

            int count = include.size();

            for (int i = 0; i < count; i++) {
                String sourceLine = include.getSourceLine(i);

                if (resolveLine(sourceLine).isType(LineType.VISIBLE)) {
                    this.document.insertSourceLine(lineCount++, sourceLine);
                }
            }
        }

        lineCount++;

        return lineCount;
    }

    // -------------------------- Preprocessor State ---------------------------

    private boolean isHidingLines() {
        switch(state) {
            case CONDITION_ARMED :
            case CONDITION_TRIGGERED: {
                return true;
            }
            default : {
                return false;
            }
        }
    }

    private void statePush() {
        this.stack.push(STATES[this.state]);
    }

    private void statePop() {
        this.state = ((Integer) stack.pop()).intValue();
    }

    // ------------------------------ Resolution -------------------------------

    private Line resolveLine(String line) throws PreprocessorException {
        return new Line(this.resolver.resolveProperties(line));
    }

    private String resolvePath(String path) {
        if (path == null) {
            throw new IllegalArgumentException("path: null");
        }

        String value = this.resolver.resolveProperties(path);
        File   file  = this.resolver.resolveFile(value);
        
        try {
            return file.getCanonicalPath();
        } catch (IOException ex) {
            return file.getAbsolutePath();
        }
    }

    // ------------------------------ Conversion -------------------------------

    private String toSourceLine(Line line) {
        return (isHidingLines())
            ? Option.isIndent(this.options)
                ? line.indent + Line.HIDE_DIRECTIVE + line.text
                : Line.HIDE_DIRECTIVE + line.indent + line.text
            : line.indent + line.text;
    }

    private File toCanonicalOrAbsoluteFile(String path) {
        File file = new File(path);

        if (!file.isAbsolute()) {
            path = (new File(this.documentPath)).getParent()
                    + File.separatorChar
                    + path;

            file = new File(path);
        }

        try {
            return file.getCanonicalFile();
        } catch (Exception e) {
            return file.getAbsoluteFile();
        }
    }

    // ------------------------------ Translation ------------------------------

    private static String translatePath(File dir, String fileName, String ext) {
        return new StringBuffer(dir.getPath()).append(File.separatorChar).
                append(translateFileExtension(fileName,ext)).toString();
    }

    private static String translateFileExtension(String fileName, String ext) {
        if (ext != null) {

            int pos = fileName.lastIndexOf('.');

            fileName = (pos < 0) ? fileName + ext
                                 : fileName.substring(0, pos) + ext;
        }

        return fileName;
    }

    // ---------------------------------- I/O ----------------------------------

    private Document loadInclude(String path) throws PreprocessorException {
        Document include = new Document();
        File     file    = toCanonicalOrAbsoluteFile(path);

        try {
            return include.load(file, this.encoding);
        } catch (UnsupportedEncodingException uee) {
            throw new PreprocessorException("Unsupported encoding \""
                    + this.encoding + "\" loading include \"" + file
                    + "\""); // NOI18N
        } catch (IOException ioe) {
            throw new PreprocessorException("Unable to load include \""
                    + file + "\": " + ioe); // NOI18N
        }
    }

    private void loadDocument() throws PreprocessorException {
        try {
            this.document.load(this.documentPath, this.encoding);
        } catch (UnsupportedEncodingException uee) {
            throw new PreprocessorException("Unsupported encoding \""
                    + this.encoding + "\" reading file \"" + this.documentPath
                    + "\""); // NOI18N
        } catch (IOException ioe) {
            throw new PreprocessorException("Unable to read file \""
                    + this.documentPath + "\": " + ioe); // NOI18N
        }
    }

    private void saveDocument(Object target) throws PreprocessorException {
        try {
            if (this.document.size() > 0) {
                this.document.save(target, this.encoding);
            }
        } catch (UnsupportedEncodingException uee) {
            throw new PreprocessorException("Unsupported encoding \""
                    + this.encoding + "\" writing \"" + target
                    + "\""); // NOI18N
        } catch (IOException ioe) {
            throw new PreprocessorException("Unable to write to \""
                    + target + "\": " + ioe); // NOI18N
        }
    }

    private static void log(Object toLog) {
        System.out.println(toLog);
    }
}
