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

/* $Id: Parser.java 610 2008-12-22 15:54:18Z unsaved $ */

/**
 * Simple preprocessor directive parser. <p>
 *
 * @author boucherb@users
 * @version 1.8.1
 * @since 1.8.1
 */
class Parser  {

    Defines   defines;
    Tokenizer tokenizer;

    Parser(Defines defines, Tokenizer tokenizer) {
        this.defines   = defines;
        this.tokenizer = tokenizer;
    }

    boolean parseExpression() throws PreprocessorException {
        boolean result = parseTerm();

        while (true) {
            switch(this.tokenizer.getTokenType()) {
                case Token.OR : {
                    this.tokenizer.next();

                    result = result | parseTerm();

                    break;
                }
                case Token.XOR : {
                    this.tokenizer.next();

                    result = result ^ parseTerm();

                    break;
                }

                default : {
                    return result;
                }
            }
        }
    }

    boolean parseTerm() throws PreprocessorException {
        boolean result = parseFactor();

        while (this.tokenizer.isToken(Token.AND)) {
            this.tokenizer.next();

            result = result & parseFactor();
        }

        return result;
    }

    boolean parseFactor() throws PreprocessorException {
        boolean result;

        switch(this.tokenizer.getTokenType()) {
            case Token.IDENT : {
                String ident = this.tokenizer.getIdent();
                int    type  = this.tokenizer.next();

                if ((type == Token.EOI) || (type == Token.RPAREN) ||
                        Token.isLogicalOperator(type)) {
                    result = this.defines.isDefined(ident);
                } else if (Token.isComparisonOperator(type)) {
                    result = parseComparison(ident, type);
                } else {
                    throw new PreprocessorException("Logical or comparison "
                            + "operator token required at position "
                            + this.tokenizer.getStartIndex()
                            + " in ["
                            + this.tokenizer.getSource()
                            + "]"); // NOI18N
                }

                break;
            }
            case Token.NOT :{
                this.tokenizer.next();

                result = !parseFactor();

                break;
            }
            case Token.LPAREN : {
                this.tokenizer.next();

                result = parseExpression();

                if (!this.tokenizer.isToken(Token.RPAREN)) {
                    throw new PreprocessorException("RPAREN token required at "
                            + "position "
                            + this.tokenizer.getStartIndex()
                            + " in ["
                            + this.tokenizer.getSource()
                            + "]"); // NOI18N
                }

                this.tokenizer.next();

                break;
            }
            default : {
                throw new PreprocessorException("IDENT, NOT or LPAREN "
                        + "token required at position "
                        + this.tokenizer.getStartIndex()
                        + " in ["
                        + this.tokenizer.getSource()
                        + "]"); // NOI18N
            }
        }

        return result;
    }

    boolean parseComparison(String ident, int opType)
    throws PreprocessorException {
//        checkIsComparisonOperator(opType);

        boolean result;
        Object  lhs    = this.defines.getDefintion(ident);
        int     pos    = this.tokenizer.getStartIndex();
        Object  rhs    = parseValue();

        if (lhs == null) {
            throw new PreprocessorException("IDENT " + ident
                    + " is not defined at position"
                    + pos
                    + "in ["
                    + this.tokenizer.getSource()
                    + "]"); // NOI18N
        }

        switch(opType) {
            case Token.EQ :{
                result = (compare(lhs, rhs) == 0);

                break;
            }
            case Token.LT : {
                result = (compare(lhs, rhs) < 0);

                break;
            }
            case Token.LTE : {
                result = (compare(lhs, rhs) <= 0);

                break;
            }
            case Token.GT : {
                result = (compare(lhs, rhs) > 0);

                break;
            }
            case Token.GTE : {
                result = (compare(lhs, rhs) >= 0);

                break;
            }
            default : {
                // Stupid compiler trick.
                // Can't actually happen because this case will cause an
                // exception to be thrown in method parseFactor (or in
                // method checkIsComparisonOperator when uncommented)
                throw new PreprocessorException("Internal error"); // NOI18N
            }
        }

        this.tokenizer.next();

        return result;
    }

//    void checkIsComparisonOperator(int opType) throws PreprocessorException {
//        if (!Token.isComparisonOperator(opType)) {
//                throw new PreprocessorException("Comparison "
//                        + "operator token required at position "
//                        + tokenizer.getBeginIndex()
//                        + " in ["
//                        + tokenizer.getSource()
//                        + "]"); // NOI18N
//        }
//    }

    static int compare(Object o1, Object o2) {
        // nulls are basically 'illegal' so yes: 
        // we want to throw NPE here if o1 or o2 is null
        if (o1 instanceof Comparable) {
            return (o1.getClass().isAssignableFrom(o2.getClass()))
            ? ((Comparable)o1).compareTo(o2)
            : String.valueOf(o1).compareTo(String.valueOf(o2));
        } else {
            return o1.toString().compareTo(o2.toString());
        }
    }

    Object parseValue() throws PreprocessorException {
        Object value;

        switch(this.tokenizer.next()) {
            case Token.IDENT : {
                String ident = this.tokenizer.getIdent();

                value = this.defines.getDefintion(ident);

                if (value == null) {
                    throw new PreprocessorException("IDENT " + ident
                            + " is not defined at position"
                            + this.tokenizer.getStartIndex()
                            + "in ["
                            + this.tokenizer.getSource()
                            + "]"); // NOI18N
                }

                break;
            }
            case Token.STRING : {
                value = this.tokenizer.getString();

                break;
            }
            case Token.NUMBER : {
                value = this.tokenizer.getNumber();

                break;
            }
            default :{
                throw new PreprocessorException("IDENT, STRING"
                        + "or NUMBER token required at position "
                        + this.tokenizer.getStartIndex()
                        + " in: ["
                        + this.tokenizer.getSource()
                        + "]"); // NOI18N
            }
        }

        return value;
    }
}
