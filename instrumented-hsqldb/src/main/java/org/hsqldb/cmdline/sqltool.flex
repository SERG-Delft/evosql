/* Copyright (c) 2001-2015, The HSQL Development Group
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


/* @(#)$Id: sqltool.flex 5472 2015-05-22 23:00:58Z fredt $ */

package org.hsqldb.cmdline.sqltool;

import java.io.PrintStream;
import org.hsqldb.lib.FrameworkLogger;

%%
// Defaults to Yylex
%class SqlFileScanner
%implements TokenSource
%{
    static private FrameworkLogger logger =
            FrameworkLogger.getLog(SqlFileScanner.class);
    private StringBuffer commandBuffer = new StringBuffer();
    private boolean interactive;
    private PrintStream psStd = System.out;
    private String magicPrefix;
    private int requestedState = YYINITIAL;
    private String rawLeadinPrompt;
    private boolean specialAppendState;
    // This last is needed for very unique check needed when appending to
    // a SQL command.  Only applies to interactive mode.

    public void setRequestedState(int requestedState) {
        this.requestedState = requestedState;
    }

    /**
     * Really need a way to validate that this is called before using the
     * scanner, like Spring's init-method property.
     * For now, will just check explicitly before using.
     */
    public void setRawLeadinPrompt(String rawLeadinPrompt) {
        this.rawLeadinPrompt = rawLeadinPrompt;
    }

    private void rawLeadinPrompt() {
        if (!interactive) {
            return;
        }
        assert rawLeadinPrompt != null:
            "Internal assertion failed.  "
            + "Scanner's message Resource Bundle not initialized properly";
        psStd.println(rawLeadinPrompt);
    }

    // Trims only the end
    private void trimBuffer() {
        int len = commandBuffer.length();
        commandBuffer.setLength(len -
            ((len > 1 && commandBuffer.charAt(len - 2) == '\r') ? 2 : 1));
    }

    public void setCommandBuffer(String s) {
        commandBuffer.setLength(0);
        commandBuffer.append(s);
    }

    public void setInteractive(boolean interactive) {
        this.interactive = interactive;
    }

    public void setMagicPrefix(String magicPrefix) {
        this.magicPrefix = magicPrefix;
    }

    public void setStdPrintStream(PrintStream psStd) {
        this.psStd = psStd;
    }

    //private String sqlPrompt = "+sql> ";
    private String sqlPrompt = null;
    public void setSqlPrompt(String sqlPrompt)
    {
        this.sqlPrompt = sqlPrompt;
    }
    public String getSqlPrompt() {
        return sqlPrompt;
    }

    //private String sqltoolPrompt = "sql> ";
    private String sqltoolPrompt = null;
    public void setSqltoolPrompt(String sqltoolPrompt)
    {
        this.sqltoolPrompt = sqltoolPrompt;
    }
    public String getSqltoolPrompt() {
        return sqltoolPrompt;
    }
    //private String rawPrompt = "raw> ";
    private String rawPrompt = null;
    public void setRawPrompt(String rawPrompt)
    {
        this.rawPrompt = rawPrompt;
    }
    public String getRawPrompt() {
        return rawPrompt;
    }

    private void debug(String id, String msg) {
        logger.finest(id + ":  [" + msg + ']');
    }

    public String strippedYytext() {
        String lineString = yytext();
        int len = lineString.length();
        len = len - ((len > 1 && lineString.charAt(len - 2) == '\r') ? 2 : 1);
        return (lineString.substring(0, len));
    }

    // Trims only the end
    public void pushbackTrim() {
        String lineString = yytext();
        int len = lineString.length();
        yypushback((len > 1 && lineString.charAt(len - 2) == '\r') ? 2 : 1);
    }

    private void prompt(String s) {
        if (!interactive) return;
        psStd.print(s);
    }

    public void prompt() {
        if (sqltoolPrompt != null) prompt(sqltoolPrompt);
        specialAppendState = (interactive && magicPrefix != null);
        // This tells scanner that if SQL input "looks" empty, it isn't.
        if (interactive && magicPrefix != null) {
            psStd.print(magicPrefix);
            magicPrefix = null;
        }
    }
%}

%public
//%int
%line
%column
%eofclose
%unicode
%type Token
%xstates SQL RAW SQL_SINGLE_QUOTED SQL_DOUBLE_QUOTED GOBBLE SPECIAL PL EDIT
%xstates MACRO PROMPT_CHANGE_STATE
/* Single-quotes Escaped with '',
 * In Oracle, at least, no inner double-quotes (i.e. no escaping)
 * SQL-Embedded comments are passed to SQL engine as part of SQL command */

/* Expressions could be simplified by using "." instead of "[^\r\n]", but
 * the JFlex docs say that "." means "[^n]", therefore this would mess up
 * DOS-style line endings. */

LINETERM_MAC = \r|\n|\r\n
SQL_STARTER = [^\n\r\t\f \\*:\"\']
TRADITIONAL_COMMENT = "/*" ~"*/"
/* CURLY_COMMENT = "{" ~"}"   Purposefully not supporting */

%%
<PROMPT_CHANGE_STATE> {LINETERM_MAC} {
    yybegin(requestedState);
    prompt();
}
<GOBBLE> ~{LINETERM_MAC} {
    yybegin(YYINITIAL);
    debug("Gobbled", yytext());
    prompt();
}
<SQL, SQL_SINGLE_QUOTED, SQL_DOUBLE_QUOTED, SPECIAL, PL, EDIT, MACRO, RAW> <<EOF>> {
    yybegin(YYINITIAL);
    return new Token(Token.UNTERM_TYPE, commandBuffer, yyline);
}
{TRADITIONAL_COMMENT} { /* Ignore top-level traditional comments */
    debug ("/**/ Comment", yytext());
}
[ \f\t]+ { /* Ignore top-level white space */
    debug("Whitespace", yytext());
}
{LINETERM_MAC} {
    prompt();
}
[--][^\n\r]* {
    debug ("-- Comment", yytext());
}
; {
    return new Token(Token.SQL_TYPE, yyline);
}
[Bb][Ee][Gg][Ii][Nn] [\f\t ]* {LINETERM_MAC} |
[Cc][Rr][Ee][Aa][Tt][Ee] [\f\t ]+ [Ff][Uu][Nn][Cc][Tt][Ii][Oo][Nn] [^\n\r]* {LINETERM_MAC} |
[Cc][Rr][Ee][Aa][Tt][Ee] [\f\t ]+ [Pp][Rr][Oo][Cc][Ee][Dd][Uu][Rr][Ee] [^\n\r]* {LINETERM_MAC} |
[Cc][Rr][Ee][Aa][Tt][Ee] [\f\t ]+ [Pp][Aa][Cc][Kk][Aa][Gg][Ee] [^\n\r]* {LINETERM_MAC} |
[Cc][Rr][Ee][Aa][Tt][Ee] [\f\t ]+ [Oo][Rr] [\f\t ]+ [Rr][Ee][Pp][Ll][Aa][Cc][Ee] [\f\t ]+ [Ff][Uu][Nn][Cc][Tt][Ii][Oo][Nn] [^\n\r]* {LINETERM_MAC} |
[Cc][Rr][Ee][Aa][Tt][Ee] [\f\t ]+ [Oo][Rr] [\f\t ]+ [Rr][Ee][Pp][Ll][Aa][Cc][Ee] [\f\t ]+ [Pp][Rr][Oo][Cc][Ee][Dd][Uu][Rr][Ee] [^\n\r]* {LINETERM_MAC} |
[Cc][Rr][Ee][Aa][Tt][Ee] [\f\t ]+ [Oo][Rr] [\f\t ]+ [Rr][Ee][Pp][Ll][Aa][Cc][Ee] [\f\t ]+ [Pp][Aa][Cc][Kk][Aa][Gg][Ee] [^\n\r]* {LINETERM_MAC} |
[Dd][Ee][Cc][Ll][Aa][Rr][Ee] [\f\t ]* {LINETERM_MAC} {
    /* These are commands which may contain nested commands and/or which
     * require the closing semicolon to send to the DB engine.
     * The BEGIN and DECLARE needed for PL/SQL probably do not need to
     * terminate the line, as we have it specified here, but I'd rather not be
     * too liberal with proprietary SQL like this, because it's easy to
     * envision other proprietary or non-proprietary commands beginning with
     * DECLARE or BEGIN. */
    setCommandBuffer(strippedYytext());
    yybegin(RAW);
    rawLeadinPrompt();
    if (rawPrompt != null) prompt(rawPrompt);
}
\* {
    commandBuffer.setLength(0);
    yybegin(PL);
}
\\ {
    commandBuffer.setLength(0);
    yybegin(SPECIAL);
}
\: {
    commandBuffer.setLength(0);
    yybegin(EDIT);
}
\/ {
    commandBuffer.setLength(0);
    yybegin(MACRO);
}
<RAW> {
    [\f\t ]*\.[\f\t ]* ; [\f\t ]* {LINETERM_MAC} {
        yybegin(YYINITIAL);
        prompt();
        return new Token(Token.RAWEXEC_TYPE, commandBuffer, yyline);
    }
    [\f\t ]*\.[\f\t ]* {LINETERM_MAC} {
        yybegin(YYINITIAL);
        prompt();
        return new Token(Token.RAW_TYPE, commandBuffer, yyline);
    }
    ~{LINETERM_MAC} {
        if (commandBuffer.length() > 0) commandBuffer.append('\n');
        commandBuffer.append(strippedYytext());
        if (rawPrompt != null) prompt(rawPrompt);
    }
}
<SPECIAL> {LINETERM_MAC} {
    if (commandBuffer.toString().trim().equals(".")) {
        commandBuffer.setLength(0);
        yybegin(RAW);
        rawLeadinPrompt();
        if (rawPrompt != null) prompt(rawPrompt);
    } else {
        requestedState = YYINITIAL;
        yybegin(PROMPT_CHANGE_STATE);
        pushbackTrim();
        return new Token(Token.SPECIAL_TYPE, commandBuffer, yyline);
    }
}
<PL> {LINETERM_MAC} {
    requestedState = YYINITIAL;
    yybegin(PROMPT_CHANGE_STATE);
    pushbackTrim();
    return new Token(Token.PL_TYPE, commandBuffer, yyline);
}
<MACRO> {LINETERM_MAC} {
    requestedState = YYINITIAL;
    yybegin(PROMPT_CHANGE_STATE);
    pushbackTrim();
    return new Token(Token.MACRO_TYPE, commandBuffer, yyline);
}
<EDIT> {LINETERM_MAC} {
    requestedState = YYINITIAL;
    yybegin(PROMPT_CHANGE_STATE);
    pushbackTrim();
    return new Token(Token.EDIT_TYPE, commandBuffer, yyline);
}
<SPECIAL, PL, MACRO> {
    // Purposefully not allowing comments within :Edit commands
    {TRADITIONAL_COMMENT} {
        /* embedded comment may disable opening closing \n */
        debug("Spl. /**/ Comment", yytext());
    }
    "--" ~{LINETERM_MAC}  {
        pushbackTrim();
        /* embedded comment may disable opening quotes and closing ; */
        debug("Spl. -- Comment", yytext());
    }
}
<SPECIAL, EDIT, PL, MACRO> {
    [^\n\r] {
        commandBuffer.append(yytext());
    }
}
{SQL_STARTER} {
    setCommandBuffer(yytext());
    yybegin(SQL);
}
<SQL> {
    ^[\f\t ]* {LINETERM_MAC} {
        if (interactive && !specialAppendState) {
            requestedState = YYINITIAL;
            yybegin(PROMPT_CHANGE_STATE);
            pushbackTrim();
            trimBuffer();
            return new Token(Token.BUFFER_TYPE, commandBuffer, yyline);
        }
        specialAppendState = false;
        commandBuffer.append(yytext());
    }
    {TRADITIONAL_COMMENT} {
        specialAppendState = false;
        commandBuffer.append(yytext());
        /* embedded comment may disable opening quotes and closing ; */
        debug("SQL /**/ Comment", yytext());
    }
    "--" ~{LINETERM_MAC} {
        specialAppendState = false;
        commandBuffer.append(yytext());
        /* embedded comment may disable opening quotes and closing ; */
        debug("SQL -- Comment", yytext());
    }
    {LINETERM_MAC} {
        specialAppendState = false;
        commandBuffer.append(yytext());
        if (sqlPrompt != null) prompt(sqlPrompt);
    }
    [^\"\';] {
        specialAppendState = false;
        commandBuffer.append(yytext());
    }
    \' {
        specialAppendState = false;
        commandBuffer.append(yytext());
        yybegin(SQL_SINGLE_QUOTED);
    }
    \" {
        specialAppendState = false;
        commandBuffer.append(yytext());
        yybegin(SQL_DOUBLE_QUOTED);
    }
    ; {
        specialAppendState = false;
        yybegin(YYINITIAL);
        return new Token(Token.SQL_TYPE, commandBuffer, yyline);
    }
}
<SQL_SINGLE_QUOTED> {
    [^\']+ {
        commandBuffer.append(yytext());
    }
    \'\' {
        commandBuffer.append(yytext());
    }
    \' {
        commandBuffer.append(yytext());
        debug("SQL '", yytext());
        yybegin(SQL);
    }
}
<SQL_DOUBLE_QUOTED> {
    [^\"]+ {
        commandBuffer.append(yytext());
    }
    \" {
        commandBuffer.append(yytext());
        yybegin(SQL);
        debug("SQL \"", yytext());
    }
}
[^\r\n] {
    yybegin(GOBBLE);
    return new Token(Token.SYNTAX_ERR_TYPE, yytext(), yyline);
}
