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

/* $Id: Token.java 610 2008-12-22 15:54:18Z unsaved $ */

/**
 * Static methods and constants to decode directive tokens.
 *
 * @author boucherb@users
 * @version 1.8.1
 * @since 1.8.1
 */
final class Token {
    static final int EOI     = -1;
    static final int UNKNOWN = 0;
    static final int IDENT   = 1;
    static final int NUMBER  = 2;
    static final int STRING  = 3;
    static final int AND     = '&';
    static final int OR      = '|';
    static final int XOR     = '^';
    static final int NOT     = '!';
    static final int GT      = '>';
    static final int GTE     = '>' + '=';
    static final int LT      = '<';
    static final int LTE     = '<' + '=';
    static final int ASSIGN  = '=';
    static final int EQ      = '=' + '=';
    static final int LPAREN  = '(';
    static final int RPAREN  = ')';

    static boolean isAssignmentOperator(final int type) {
        return (type == ASSIGN);
    }

    static boolean isComparisonOperator(final int type) {
        switch(type) {
            case EQ :
            case LT :
            case GT :
            case LTE :
            case GTE : {
                return true;
            }
            default : {
                return false;
            }
        }
    }

    static boolean isLogicalOperator(final int type) {
        switch(type) {
            case AND :
            case OR :
            case XOR :
            case NOT : {
                return true;
            }
            default : {
                return false;
            }
        }
    }

    static boolean isValue(final int type) {
        switch (type) {
            case IDENT :
            case STRING :
            case NUMBER : {
                return true;
            }
            default : {
                return false;
            }
        }
    }
}
