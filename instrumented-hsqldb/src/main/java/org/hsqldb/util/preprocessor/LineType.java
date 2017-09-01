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

import java.lang.reflect.Field;
import java.util.Hashtable;
import java.util.Locale;

/* $Id: LineType.java 610 2008-12-22 15:54:18Z unsaved $ */

/**
 * Static methods and constants to decode preprocessor line types.
 *
 * @author boucherb@users
 * @version 1.8.1
 * @since 1.8.1
 */
class LineType {
    //
    static final int UNKNOWN    = 0;
    static final int DEF        = 1;
    static final int DEFINE     = 1;
    static final int ELIF       = 2;
    static final int ELIFDEF    = 3;
    static final int ELIFNDEF   = 4;
    static final int ELSE       = 5;
    static final int ENDIF      = 6;
    static final int ENDINCLUDE = 7;
    static final int HIDDEN     = 8;
    static final int IF         = 9;
    static final int IFDEF      = 10;
    static final int IFNDEF     = 11;
    static final int INCLUDE    = 12;
    static final int UNDEF      = 13;
    static final int UNDEFINE   = 13;
    static final int VISIBLE    = 14;

    //
    private static Hashtable directives;
    private static String[]  labels;

    static synchronized String[] labels() {
        if (labels == null) {
            init();
        }

        return labels;
    }

    static synchronized Hashtable directives() {
        if (directives == null) {
            init();
        }

        return directives;
    }

    private static void init() {

        directives     = new Hashtable();
        labels         = new String[17];
        Field[] fields = LineType.class.getDeclaredFields();

        for (int i = 0, j = 0; i < fields.length; i++) {
            Field field = fields[i];

            if (field.getType().equals(Integer.TYPE)) {
                String label = field.getName();

                try {
                    int value = field.getInt(null);

                    labels[value] = label;

                    switch(value) {
                        case VISIBLE :
                        case HIDDEN : {
                            // ignore
                            break;
                        }
                        default : {
                            String key = Line.DIRECTIVE_PREFIX
                                    + label.toLowerCase(Locale.ENGLISH);

                            directives.put(key, new Integer(value));

                            break;
                        }
                    }

                } catch (IllegalArgumentException ex) {
                    // ex.printStackTrace();
                } catch (IllegalAccessException ex) {
                    // ex.printStackTrace();
                }
            }
        }
    }
}
