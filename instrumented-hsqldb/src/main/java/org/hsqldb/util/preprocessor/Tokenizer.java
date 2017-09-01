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

/* $Id: Tokenizer.java 610 2008-12-22 15:54:18Z unsaved $ */

/**
 * Simple preprocessor directive tokenizer.
 *
 * @author boucherb@users
 * @version 1.8.1
 * @since 1.8.1
 */
final class Tokenizer {
    private final String command;
    private final int    commandLength;
    private int          tokenType;
    private int          startIndex;
    private int          currentIndex;

    Tokenizer(final String cmd) {
        this.command       = cmd + " ";
        this.commandLength = command.length();
        this.startIndex    = 0;
        this.currentIndex  = 0;
        this.tokenType     = Token.UNKNOWN;
    }

    void skipBlanks() {
        final String cmd = this.command;
        final int    len = this.commandLength;

        top:
            while (currentIndex < len) {

            switch(cmd.charAt(currentIndex)) {
                case ' '  :
                case '\t' : {
                    currentIndex++;
                    continue top;
                }
            }

            break;
            }
    }

    int next() throws PreprocessorException {
        skipBlanks();

        startIndex = currentIndex;

        final String cmd = this.command;
        final int    len = this.commandLength;

        if (currentIndex >= len) {
            tokenType = Token.EOI;

            return tokenType;
        }

        char ch = cmd.charAt(currentIndex);

        if (Character.isJavaIdentifierStart(ch)) {
            tokenType = Token.IDENT;

            currentIndex++;

            while (currentIndex < len &&
                    Character.isJavaIdentifierPart(cmd.charAt(currentIndex))) {
                currentIndex++;
            }

            return tokenType;
        } else if (Character.isDigit(ch)) {
            tokenType = Token.NUMBER;

            currentIndex++;

            while(currentIndex < len &&
                    Character.isDigit(cmd.charAt(currentIndex))) {
                currentIndex++;
            }

            if (currentIndex < len && cmd.charAt(currentIndex) == '.') {
                currentIndex++;
            }

            while(currentIndex < len &&
                    Character.isDigit(cmd.charAt(currentIndex))) {
                currentIndex++;
            }

            return tokenType;
        } else if (ch == '"') {
            tokenType = Token.STRING;

            currentIndex++;

            int pos = cmd.indexOf('"', currentIndex);

            if (pos == -1) {
                throw new PreprocessorException("Unclosed string literal: " +
                        cmd.substring(startIndex)); //NOI18N
            }

            currentIndex = pos + 1;

            return tokenType;
        }


        switch(ch) {
            case Token.LPAREN :
            case Token.RPAREN :
            case Token.XOR :
            case Token.NOT : {
                currentIndex++;

                return (tokenType = ch);
            }
            case Token.ASSIGN : {
                currentIndex++;

                if(currentIndex < len &&
                        cmd.charAt(currentIndex) == Token.ASSIGN) {
                    currentIndex++;

                    tokenType = Token.EQ;
                } else {
                    tokenType = Token.ASSIGN;
                }

                return tokenType;
            }
            case Token.LT : {
                currentIndex++;

                if (currentIndex < len &&
                        cmd.charAt(currentIndex) == Token.ASSIGN) {
                    currentIndex++;

                    tokenType = Token.LTE;
                } else {
                    tokenType = Token.LT;
                }

                return tokenType;
            }
            case Token.GT : {
                currentIndex++;

                if (currentIndex < len &&
                        cmd.charAt(currentIndex) == Token.ASSIGN) {
                    currentIndex++;

                    tokenType = Token.GTE;
                } else {
                    tokenType = Token.GT;
                }

                return tokenType;
            }
            case Token.AND :
            case Token.OR : {
                currentIndex++;

                if (currentIndex < len && cmd.charAt(currentIndex) == ch) {
                    currentIndex++;
                }

                return (tokenType = ch);
            }
            default : {
                throw new PreprocessorException("Syntax error: " +
                        cmd.substring(currentIndex)); //NOI18N
            }
        }
    }

    int getTokenType() {
        return tokenType;
    }

    boolean isToken(final int type) {
        return (this.tokenType == type);
    }

    String getIdent() {
        return isToken(Token.EOI) ? null
                : this.command.substring(startIndex, currentIndex);
    }

    Number getNumber() {
        return (isToken(Token.EOI)) ? null
                : new Double(Double.parseDouble(this.command.
                substring(startIndex, currentIndex)));
    }

    String getString() {
        return isToken(Token.EOI) ? null
                : this.command.substring(startIndex + 1, currentIndex - 1);
    }

    int getStartIndex() {
        return this.startIndex;
    }

    int currentIndex() {
        return this.currentIndex;
    }

    String getSource() {
        return this.command;
    }
}
