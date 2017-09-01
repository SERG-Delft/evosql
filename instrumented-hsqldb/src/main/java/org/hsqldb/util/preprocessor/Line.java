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

/* $Id: Line.java 610 2008-12-22 15:54:18Z unsaved $ */

/**
 * Preprocessor's view of a line in a text document.
 *
 * @author boucherb@users
 * @version 1.8.1
 * @since 1.8.1
 */
class Line  {
    static final String DIRECTIVE_PREFIX = "//#";
    static final String SPACE_CHARS = " \t";
    static final int    DIRECTIVE_PREFIX_LENGTH = DIRECTIVE_PREFIX.length();
    static final int    DIRECTIVE_PREFIX_LENGTH_PLUS_ONE =
            DIRECTIVE_PREFIX_LENGTH + 1;
    static final String HIDE_DIRECTIVE = DIRECTIVE_PREFIX + ' ';

    int    type;
    String sourceText;
    String indent;
    String text;
    String arguments;

    static int indexOfNonTabOrSpace(String line) {
        int pos = 0;
        int len = line.length();

        while (pos < len) {
            char ch = line.charAt(pos);

            if ((ch == ' ') || (ch == '\t')) {
                pos++;
                continue;
            }

            break;
        }

        return pos;
    }

    static int indexOfTabOrSpace(String s, int fromIndex) {
        int spos = s.indexOf(' ', fromIndex);
        int tpos = s.indexOf('\t', fromIndex);

        return (((tpos != -1) && (tpos < spos)) || (spos == -1)) ? tpos : spos;
    }

    Line(String line) throws PreprocessorException {
        setSourceText(line);
    }

    void setSourceText(String line) throws PreprocessorException {
        this.sourceText = line;
        int pos         = indexOfNonTabOrSpace(line);
        this.indent     = line.substring(0, pos);
        line            = line.substring(pos);

        if (!line.startsWith(DIRECTIVE_PREFIX)) {
            this.text      = line;
            this.arguments = null;
            this.type      = LineType.VISIBLE;
        } else if (line.length() == DIRECTIVE_PREFIX_LENGTH){
            this.text      = "";
            this.arguments = null;
            this.type       = LineType.HIDDEN;
        } else  if (SPACE_CHARS.indexOf(line.
                charAt(DIRECTIVE_PREFIX_LENGTH)) != -1) {
            this.text      = line.substring(DIRECTIVE_PREFIX_LENGTH_PLUS_ONE);
            this.arguments = null;
            this.type      = LineType.HIDDEN;
        } else {
            pos = indexOfTabOrSpace(line, DIRECTIVE_PREFIX_LENGTH_PLUS_ONE);

            if (pos == -1) {
                this.text      = line;
                this.arguments = null;
            } else {
                this.text      = line.substring(0, pos);
                this.arguments = line.substring(pos + 1).trim();
            }

            Integer oType = (Integer) LineType.directives().get(text);

            if (oType == null) {
                throw new PreprocessorException("Unknown directive ["
                        + text + "] in [" + line + "]"); // NOI18N
            }

            this.type = oType.intValue();
        }

    }

    String getArguments() throws PreprocessorException {
        if (arguments == null || arguments.length() == 0) {
            throw new PreprocessorException("["+ text
                    + "]: has no argument(s)"); // NOI18N
        }

        return arguments;
    }

    String getSourceText() {
        return sourceText;
    }

    String getIndent() {
        return indent;
    }

    String getText() {
        return text;
    }

    int getType() {
        return type;
    }

    boolean isType(int lineType) {
        return (this.type == lineType);
    }

    public String toString() {
        return LineType.labels()[this.type] + "(" + this.type + "): indent ["
                + this.indent + "] text [" + this.text
                + ((this.arguments == null) ? "]" : ("] args ["
                + this.arguments + "]")) ;
    }
}
