/* Copyright (c) 2001-2014, The HSQL Development Group
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


package org.hsqldb.cmdline.sqltool;

import java.util.regex.Pattern;

/* @(#)$Id: Token.java 5337 2014-01-24 19:26:47Z fredt $ */

public class Token {
    public static final int SQL_TYPE = 0;
    public static final int SPECIAL_TYPE = 1;
    public static final int PL_TYPE = 2;
    public static final int EDIT_TYPE = 3;
    public static final int RAW_TYPE = 4;
    public static final int RAWEXEC_TYPE = 5;
    public static final int SYNTAX_ERR_TYPE = 6;
    public static final int UNTERM_TYPE = 7;
    public static final int BUFFER_TYPE = 8;
    public static final int MACRO_TYPE = 9;
    public static final Pattern leadingWhitePattern = Pattern.compile("^\\s+");
    public int line;
    public TokenList nestedBlock = null;

    public String[] typeString = {
        "SQL", "SPECIAL", "PL", "EDIT", "RAW", "RAWEXEC", "SYNTAX",
        "UNTERM", "BUFFER", "MACRO"
    };
    public char[] typeChar = {
        'S', '\\', '*', 'E', 'R', 'X', '!', '<', '>', '/'
    };

    public String getTypeString() {
        return typeString[type];
    }
    public char getTypeChar() {
        return typeChar[type];
    }

    public String val;
    public int type;
    public Token(int inType, String inVal, int inLine) {
        val = inVal; type = inType; line = inLine + 1;
        switch (inType) {
            case SPECIAL_TYPE:
            case EDIT_TYPE:
            case PL_TYPE:
            case MACRO_TYPE:
                // These types must be not null.  May be just whitespace.
                // Will be trimmed.
                if (val == null) throw new IllegalArgumentException(
                        "Null String value for scanner token");
                // Leading white space is always safe for us to trim from these
                // types of commands, but we must preserve trailing whitespace
                // for some commands.
                val = leadingWhitePattern.matcher(val).replaceFirst("");
                break;

            case SYNTAX_ERR_TYPE:
            case BUFFER_TYPE:
            case RAW_TYPE:
            case RAWEXEC_TYPE:
            case UNTERM_TYPE:
                // These types must be not null.  May be just whitespace.
                // Will NOT be trimmed.
                if (val == null) throw new IllegalArgumentException(
                        "Null String value for scanner token");
                break;

            case SQL_TYPE:
                // These types may be anything (null, whitespace, etc.).
                // Will NOT be trimmed
                break;

            default: throw new IllegalArgumentException(
                "Internal error.  Unexpected scanner token type: " + inType);
        }
    }

    public Token(int inType, StringBuffer inBuf, int inLine) {
        this(inType, inBuf.toString(), inLine);
    }

    public Token(int inType, int inLine) {
        this(inType, (String) null, inLine);
    }

    public String toString() { return "@" + line
            + " TYPE=" + getTypeString() + ", VALUE=(" + val + ')';
    }

    public int hashCode() {
        if (val == null) return 0;
        return val.hashCode();
    }

    /**
     * Equality ignores the line number
     */
    public boolean equals(Object other) {
        if (!(other instanceof Token)) return false;
        Token otherToken = (Token) other;
        if (type != otherToken.type) return false;
        if (val == null && otherToken.val != null) return false;
        if (val != null && otherToken.val == null) return false;
        if (val != null && !val.equals(otherToken.val)) return false;
        return true;
    }

    /*
     * Convenience wrapper for brevity.
     */
    public String reconstitute() {
        return reconstitute(false);
    }

    /*
     * A command string generated from val and type which can hopefully be
     * re-executed.
     */
    public String reconstitute(boolean semify) {
        if (val == null) return "";
        switch (type) {
            case Token.SPECIAL_TYPE:
            case Token.PL_TYPE:
                return Character.toString(getTypeChar()) + val;
            case Token.SQL_TYPE:
                return val + (semify ? ";" : "");
        }
        return "? " + val;
    }
}
