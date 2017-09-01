/* Copyright (c) 2001-2016, The HSQL Development Group
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


package org.hsqldb.rowio;

import org.hsqldb.error.Error;
import org.hsqldb.error.ErrorCode;
import org.hsqldb.persist.TextFileSettings;

// fredt@users - 2.3.4 - patch for user-defined quote char by Damjan Jovanovic

/**
 * Fields in the source file need not be quoted. Methods in this class unquote
 * the fields if they are quoted and handle quote character doubling in this
 * case.
 *
 * @author Bob Preston (sqlbob@users dot sourceforge.net)
 * @version 2.3.4
 * @since 1.7.0
 */
public class RowInputTextQuoted extends RowInputText {

    private static final int NORMAL_FIELD   = 0;
    private static final int NEED_END_QUOTE = 1;
    private static final int FOUND_QUOTE    = 2;
    private final char       quoteChar;
    int                      charLength = 0;

    public RowInputTextQuoted(TextFileSettings textFileSettings) {

        super(textFileSettings);

        this.quoteChar = textFileSettings.quoteChar;
    }

    public void setSource(String text, long pos, int byteSize) {

        super.setSource(text, pos, byteSize);

        charLength = text.length();

        for (int i = charLength - 1; i > -1; i--) {
            if (text.charAt(i) == TextFileSettings.CR_CHAR
                    || text.charAt(i) == TextFileSettings.LF_CHAR) {
                charLength--;
            } else {
                break;
            }
        }
    }

    protected String getField(String sep, int sepLen, boolean isEnd) {

        //fredt - now the only supported behaviour is emptyIsNull
        String s = null;

        if (next >= charLength || text.charAt(next) != quoteChar) {
            return super.getField(sep, sepLen, isEnd);
        }

        try {
            field++;

            StringBuffer sb    = new StringBuffer();
            boolean      done  = false;
            int          state = NORMAL_FIELD;
            int          end   = -1;

            if (!isEnd) {
                end = text.indexOf(sep, next);
            }

            for (; next < charLength; next++) {
                switch (state) {

                    case NORMAL_FIELD :
                    default :
                        if (next == end) {
                            next += sepLen;
                            done = true;
                        } else if (text.charAt(next) == quoteChar) {

                            //-- Beginning of field
                            state = NEED_END_QUOTE;
                        } else {
                            sb.append(text.charAt(next));
                        }
                        break;

                    case NEED_END_QUOTE :
                        if (text.charAt(next) == quoteChar) {
                            state = FOUND_QUOTE;
                        } else {
                            sb.append(text.charAt(next));
                        }
                        break;

                    case FOUND_QUOTE :
                        if (text.charAt(next) == quoteChar) {

                            //-- Escaped quote
                            sb.append(text.charAt(next));

                            state = NEED_END_QUOTE;
                        } else {
                            if (!isEnd) {
                                end = text.indexOf(sep, next);

                                if (end < 0) {
                                    end = charLength;
                                }

                                sb.append(text, next, end);

                                next = end + sepLen;
                                done = true;
                            } else {
                                next  += sepLen - 1;
                                state = NORMAL_FIELD;
                            }
                        }
                        break;
                }

                if (done) {
                    break;
                }
            }

            s = sb.toString();
        } catch (Exception e) {
            String message = String.valueOf(field);

            throw Error.error(e, ErrorCode.M_TEXT_SOURCE_FIELD_ERROR, message);
        }

        return s;
    }
}
