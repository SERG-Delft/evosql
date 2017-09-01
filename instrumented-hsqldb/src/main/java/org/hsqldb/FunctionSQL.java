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


package org.hsqldb;

import org.hsqldb.ParserDQL.CompileContext;
import org.hsqldb.error.Error;
import org.hsqldb.error.ErrorCode;
import org.hsqldb.lib.IntValueHashMap;
import org.hsqldb.lib.OrderedIntHashSet;
import org.hsqldb.map.ValuePool;
import org.hsqldb.types.BinaryData;
import org.hsqldb.types.BinaryType;
import org.hsqldb.types.BlobData;
import org.hsqldb.types.CharacterType;
import org.hsqldb.types.DTIType;
import org.hsqldb.types.DateTimeType;
import org.hsqldb.types.IntervalType;
import org.hsqldb.types.NumberType;
import org.hsqldb.types.Type;
import org.hsqldb.types.Types;

/**
 * Implementation of SQL standard function calls
 *
 * @author Fred Toussi (fredt@users dot sourceforge.net)
 * @version 2.3.3
 * @since 1.9.0
 */
public class FunctionSQL extends Expression {

    protected static final int FUNC_POSITION_CHAR                    = 1;     // numeric
    private static final int   FUNC_POSITION_BINARY                  = 2;
    private static final int   FUNC_OCCURENCES_REGEX                 = 3;
    private static final int   FUNC_POSITION_REGEX                   = 4;
    protected static final int FUNC_EXTRACT                          = 5;
    protected static final int FUNC_BIT_LENGTH                       = 6;
    protected static final int FUNC_CHAR_LENGTH                      = 7;
    protected static final int FUNC_OCTET_LENGTH                     = 8;
    private static final int   FUNC_CARDINALITY                      = 9;
    private static final int   FUNC_MAX_CARDINALITY                  = 10;
    private static final int   FUNC_TRIM_ARRAY                       = 11;
    private static final int   FUNC_ABS                              = 12;
    private static final int   FUNC_MOD                              = 13;
    protected static final int FUNC_LN                               = 14;
    private static final int   FUNC_EXP                              = 15;
    private static final int   FUNC_POWER                            = 16;
    private static final int   FUNC_SQRT                             = 17;
    private static final int   FUNC_FLOOR                            = 20;
    private static final int   FUNC_CEILING                          = 21;
    private static final int   FUNC_WIDTH_BUCKET                     = 22;
    protected static final int FUNC_SUBSTRING_CHAR                   = 23;    // string
    private static final int   FUNC_SUBSTRING_REG_EXPR               = 24;
    private static final int   FUNC_SUBSTRING_REGEX                  = 25;
    protected static final int FUNC_FOLD_LOWER                       = 26;
    protected static final int FUNC_FOLD_UPPER                       = 27;
    private static final int   FUNC_TRANSCODING                      = 28;
    private static final int   FUNC_TRANSLITERATION                  = 29;
    private static final int   FUNC_REGEX_TRANSLITERATION            = 30;
    protected static final int FUNC_TRIM_CHAR                        = 31;
    static final int           FUNC_OVERLAY_CHAR                     = 32;
    private static final int   FUNC_CHAR_NORMALIZE                   = 33;
    private static final int   FUNC_SUBSTRING_BINARY                 = 40;
    private static final int   FUNC_TRIM_BINARY                      = 41;
    private static final int   FUNC_OVERLAY_BINARY                   = 42;
    protected static final int FUNC_CURRENT_DATE                     = 43;    // datetime
    protected static final int FUNC_CURRENT_TIME                     = 44;
    protected static final int FUNC_CURRENT_TIMESTAMP                = 50;
    protected static final int FUNC_LOCALTIME                        = 51;
    protected static final int FUNC_LOCALTIMESTAMP                   = 52;
    private static final int   FUNC_CURRENT_CATALOG                  = 53;    // general
    private static final int   FUNC_CURRENT_DEFAULT_TRANSFORM_GROUP  = 54;
    private static final int   FUNC_CURRENT_PATH                     = 55;
    private static final int   FUNC_CURRENT_ROLE                     = 56;
    private static final int   FUNC_CURRENT_SCHEMA                   = 57;
    private static final int   FUNC_CURRENT_TRANSFORM_GROUP_FOR_TYPE = 58;
    private static final int   FUNC_CURRENT_USER                     = 59;
    private static final int   FUNC_SESSION_USER                     = 60;
    private static final int   FUNC_SYSTEM_USER                      = 61;
    protected static final int FUNC_USER                             = 62;
    private static final int   FUNC_VALUE                            = 63;

    //
    static final short[] noParamList             = new short[]{};
    static final short[] emptyParamList          = new short[] {
        Tokens.OPENBRACKET, Tokens.CLOSEBRACKET
    };
    static final short[] optionalNoParamList     = new short[] {
        Tokens.X_OPTION, 2, Tokens.OPENBRACKET, Tokens.CLOSEBRACKET
    };
    static final short[] optionalSingleParamList = new short[] {
        Tokens.OPENBRACKET, Tokens.X_OPTION, 1, Tokens.QUESTION,
        Tokens.CLOSEBRACKET
    };
    static final short[] singleParamList          = new short[] {
        Tokens.OPENBRACKET, Tokens.QUESTION, Tokens.CLOSEBRACKET
    };
    static final short[] optionalIntegerParamList = new short[] {
        Tokens.X_OPTION, 3, Tokens.OPENBRACKET, Tokens.X_POS_INTEGER,
        Tokens.CLOSEBRACKET
    };
    static final short[] optionalDoubleParamList = new short[] {
        Tokens.OPENBRACKET, Tokens.QUESTION, Tokens.X_OPTION, 2, Tokens.COMMA,
        Tokens.QUESTION, Tokens.CLOSEBRACKET
    };
    static final short[] doubleParamList = new short[] {
        Tokens.OPENBRACKET, Tokens.QUESTION, Tokens.COMMA, Tokens.QUESTION,
        Tokens.CLOSEBRACKET
    };
    static final short[] tripleParamList = new short[] {
        Tokens.OPENBRACKET, Tokens.QUESTION, Tokens.COMMA, Tokens.QUESTION,
        Tokens.COMMA, Tokens.QUESTION, Tokens.CLOSEBRACKET
    };
    static final short[] quadParamList = new short[] {
        Tokens.OPENBRACKET, Tokens.QUESTION, Tokens.COMMA, Tokens.QUESTION,
        Tokens.COMMA, Tokens.QUESTION, Tokens.COMMA, Tokens.QUESTION,
        Tokens.CLOSEBRACKET
    };

    //
    static IntValueHashMap   valueFuncMap            = new IntValueHashMap();
    static IntValueHashMap   regularFuncMap          = new IntValueHashMap();
    static OrderedIntHashSet nonDeterministicFuncSet = new OrderedIntHashSet();

    static {
        regularFuncMap.put(Tokens.T_POSITION, FUNC_POSITION_CHAR);
        /*
        regularFuncMap.put(Token.T_OCCURENCES_REGEX, FUNC_OCCURENCES_REGEX);
        */
        regularFuncMap.put(Tokens.T_POSITION_REGEX, FUNC_POSITION_REGEX);
        regularFuncMap.put(Tokens.T_EXTRACT, FUNC_EXTRACT);
        regularFuncMap.put(Tokens.T_BIT_LENGTH, FUNC_BIT_LENGTH);
        regularFuncMap.put(Tokens.T_CHAR_LENGTH, FUNC_CHAR_LENGTH);
        regularFuncMap.put(Tokens.T_CHARACTER_LENGTH, FUNC_CHAR_LENGTH);
        regularFuncMap.put(Tokens.T_OCTET_LENGTH, FUNC_OCTET_LENGTH);
        regularFuncMap.put(Tokens.T_CARDINALITY, FUNC_CARDINALITY);
        regularFuncMap.put(Tokens.T_MAX_CARDINALITY, FUNC_MAX_CARDINALITY);
        regularFuncMap.put(Tokens.T_TRIM_ARRAY, FUNC_TRIM_ARRAY);
        regularFuncMap.put(Tokens.T_ABS, FUNC_ABS);
        regularFuncMap.put(Tokens.T_MOD, FUNC_MOD);
        regularFuncMap.put(Tokens.T_LN, FUNC_LN);
        regularFuncMap.put(Tokens.T_EXP, FUNC_EXP);
        regularFuncMap.put(Tokens.T_POWER, FUNC_POWER);
        regularFuncMap.put(Tokens.T_SQRT, FUNC_SQRT);
        regularFuncMap.put(Tokens.T_FLOOR, FUNC_FLOOR);
        regularFuncMap.put(Tokens.T_CEILING, FUNC_CEILING);
        regularFuncMap.put(Tokens.T_CEIL, FUNC_CEILING);
        regularFuncMap.put(Tokens.T_WIDTH_BUCKET, FUNC_WIDTH_BUCKET);
        regularFuncMap.put(Tokens.T_SUBSTRING, FUNC_SUBSTRING_CHAR);
        /*
        regularFuncMap.put(Token.T_SUBSTRING_REG_EXPR,
                           FUNC_SUBSTRING_REG_EXPR);
        */
        regularFuncMap.put(Tokens.T_SUBSTRING_REGEX, FUNC_SUBSTRING_REGEX);
        regularFuncMap.put(Tokens.T_LOWER, FUNC_FOLD_LOWER);
        regularFuncMap.put(Tokens.T_UPPER, FUNC_FOLD_UPPER);
        /*
        regularFuncMap.put(Token.T_TRANSCODING, FUNC_TRANSCODING);
        regularFuncMap.put(Token.T_TRANSLITERATION, FUNC_TRANSLITERATION);
        regularFuncMap.put(Token.T_TRASLATION,
                           FUNC_REGEX_TRANSLITERATION);
        */
        regularFuncMap.put(Tokens.T_TRIM, FUNC_TRIM_CHAR);
        regularFuncMap.put(Tokens.T_OVERLAY, FUNC_OVERLAY_CHAR);
        /*
        regularFuncMap.put(Token.T_NORMALIZE, FUNC_CHAR_NORMALIZE);
        */
        regularFuncMap.put(Tokens.T_TRIM, FUNC_TRIM_BINARY);
    }

    static {
        valueFuncMap.put(Tokens.T_CURRENT_DATE, FUNC_CURRENT_DATE);
        valueFuncMap.put(Tokens.T_CURRENT_TIME, FUNC_CURRENT_TIME);
        valueFuncMap.put(Tokens.T_CURRENT_TIMESTAMP, FUNC_CURRENT_TIMESTAMP);
        valueFuncMap.put(Tokens.T_LOCALTIME, FUNC_LOCALTIME);
        valueFuncMap.put(Tokens.T_LOCALTIMESTAMP, FUNC_LOCALTIMESTAMP);
        valueFuncMap.put(Tokens.T_CURRENT_CATALOG, FUNC_CURRENT_CATALOG);
        /*
        valueFuncMap.put(Token.T_CURRENT_DEFAULT_TRANSFORM_GROUP,
                FUNC_CURRENT_DEFAULT_TRANSFORM_GROUP);
        */
        valueFuncMap.put(Tokens.T_CURRENT_PATH, FUNC_CURRENT_PATH);
        valueFuncMap.put(Tokens.T_CURRENT_ROLE, FUNC_CURRENT_ROLE);
        valueFuncMap.put(Tokens.T_CURRENT_SCHEMA, FUNC_CURRENT_SCHEMA);
        /*
        valueFuncMap.put(Token.T_CURRENT_TRANSFORM_GROUP_FOR_TYPE,
                FUNC_CURRENT_TRANSFORM_GROUP_FOR_TYPE);
        */
        valueFuncMap.put(Tokens.T_CURRENT_USER, FUNC_CURRENT_USER);
        valueFuncMap.put(Tokens.T_SESSION_USER, FUNC_SESSION_USER);
        valueFuncMap.put(Tokens.T_SYSTEM_USER, FUNC_SYSTEM_USER);
        valueFuncMap.put(Tokens.T_USER, FUNC_USER);
        valueFuncMap.put(Tokens.T_VALUE, FUNC_VALUE);

        //
        nonDeterministicFuncSet.addAll(valueFuncMap.values());
    }

    //
    int     funcType;
    boolean isDeterministic;
    String  name;
    short[] parseList;
    short[] parseListAlt;
    boolean isSQLValueFunction;

    public static FunctionSQL newSQLFunction(String token,
            CompileContext context) {

        int     id              = regularFuncMap.get(token, -1);
        boolean isValueFunction = false;

        if (id == -1) {
            id              = valueFuncMap.get(token, -1);
            isValueFunction = true;
        }

        if (id == -1) {
            return null;
        }

        FunctionSQL function = new FunctionSQL(id);

        if (id == FUNC_VALUE) {
            if (context.currentDomain == null) {
                return null;
            }

            function.dataType = context.currentDomain;
        } else {
            function.isSQLValueFunction = isValueFunction;
        }

        return function;
    }

    protected FunctionSQL() {

        super(OpTypes.SQL_FUNCTION);

        nodes = Expression.emptyArray;
    }

    protected FunctionSQL(int id) {

        this();

        this.funcType   = id;
        isDeterministic = !nonDeterministicFuncSet.contains(id);

        switch (id) {

            case FUNC_POSITION_CHAR :
            case FUNC_POSITION_BINARY :
                name      = Tokens.T_POSITION;
                parseList = new short[] {
                    Tokens.OPENBRACKET, Tokens.QUESTION, Tokens.IN,
                    Tokens.QUESTION, Tokens.X_OPTION, 5, Tokens.USING,
                    Tokens.X_KEYSET, 2, Tokens.CHARACTERS, Tokens.OCTETS,
                    Tokens.CLOSEBRACKET
                };
                break;

            case FUNC_OCCURENCES_REGEX :
            case FUNC_POSITION_REGEX :
                break;

            case FUNC_EXTRACT :
                name      = Tokens.T_EXTRACT;
                parseList = new short[] {
                    Tokens.OPENBRACKET, Tokens.X_KEYSET, 17, Tokens.YEAR,
                    Tokens.MONTH, Tokens.DAY, Tokens.HOUR, Tokens.MINUTE,
                    Tokens.SECOND, Tokens.DAY_OF_WEEK, Tokens.WEEK_OF_YEAR,
                    Tokens.QUARTER, Tokens.DAY_OF_YEAR, Tokens.DAY_OF_MONTH,
                    Tokens.WEEK_OF_YEAR, Tokens.DAY_NAME, Tokens.MONTH_NAME,
                    Tokens.SECONDS_MIDNIGHT, Tokens.TIMEZONE_HOUR,
                    Tokens.TIMEZONE_MINUTE, Tokens.FROM, Tokens.QUESTION,
                    Tokens.CLOSEBRACKET
                };
                break;

            case FUNC_CHAR_LENGTH :
                name      = Tokens.T_CHAR_LENGTH;
                parseList = new short[] {
                    Tokens.OPENBRACKET, Tokens.QUESTION, Tokens.X_OPTION, 5,
                    Tokens.USING, Tokens.X_KEYSET, 2, Tokens.CHARACTERS,
                    Tokens.OCTETS, Tokens.CLOSEBRACKET
                };
                break;

            case FUNC_BIT_LENGTH :
                name      = Tokens.T_BIT_LENGTH;
                parseList = singleParamList;
                break;

            case FUNC_OCTET_LENGTH :
                name      = Tokens.T_OCTET_LENGTH;
                parseList = singleParamList;
                break;

            case FUNC_CARDINALITY :
                name      = Tokens.T_CARDINALITY;
                parseList = singleParamList;
                break;

            case FUNC_MAX_CARDINALITY :
                name      = Tokens.T_MAX_CARDINALITY;
                parseList = singleParamList;
                break;

            case FUNC_TRIM_ARRAY :
                name      = Tokens.T_TRIM_ARRAY;
                parseList = doubleParamList;
                break;

            case FUNC_ABS :
                name      = Tokens.T_ABS;
                parseList = singleParamList;
                break;

            case FUNC_MOD :
                name      = Tokens.T_MOD;
                parseList = doubleParamList;
                break;

            case FUNC_LN :
                name      = Tokens.T_LN;
                parseList = singleParamList;
                break;

            case FUNC_EXP :
                name      = Tokens.T_EXP;
                parseList = singleParamList;
                break;

            case FUNC_POWER :
                name      = Tokens.T_POWER;
                parseList = doubleParamList;
                break;

            case FUNC_SQRT :
                name      = Tokens.T_SQRT;
                parseList = singleParamList;
                break;

            case FUNC_FLOOR :
                name      = Tokens.T_FLOOR;
                parseList = singleParamList;
                break;

            case FUNC_CEILING :
                name      = Tokens.T_CEILING;
                parseList = singleParamList;
                break;

            case FUNC_WIDTH_BUCKET :
                name      = Tokens.T_WIDTH_BUCKET;
                parseList = quadParamList;
                break;

            case FUNC_SUBSTRING_CHAR :
            case FUNC_SUBSTRING_BINARY :
                name      = Tokens.T_SUBSTRING;
                parseList = new short[] {
                    Tokens.OPENBRACKET, Tokens.QUESTION, Tokens.FROM,
                    Tokens.QUESTION, Tokens.X_OPTION, 2, Tokens.FOR,
                    Tokens.QUESTION, Tokens.X_OPTION, 5, Tokens.USING,
                    Tokens.X_KEYSET, 2, Tokens.CHARACTERS, Tokens.OCTETS,
                    Tokens.CLOSEBRACKET
                };
                parseListAlt = new short[] {
                    Tokens.OPENBRACKET, Tokens.QUESTION, Tokens.COMMA,
                    Tokens.QUESTION, Tokens.X_OPTION, 2, Tokens.COMMA,
                    Tokens.QUESTION, Tokens.CLOSEBRACKET
                };
                break;

            /*
            case FUNCTION_SUBSTRING_REG_EXPR :
                break;
            case FUNCTION_SUBSTRING_REGEX :
                break;
            */
            case FUNC_FOLD_LOWER :
                name      = Tokens.T_LOWER;
                parseList = singleParamList;
                break;

            case FUNC_FOLD_UPPER :
                name      = Tokens.T_UPPER;
                parseList = singleParamList;
                break;

            /*
            case FUNCTION_TRANSCODING :
                break;
            case FUNCTION_TRANSLITERATION :
                break;
            case FUNCTION_REGEX_TRANSLITERATION :
                break;
             */
            case FUNC_TRIM_CHAR :
            case FUNC_TRIM_BINARY :
                name      = Tokens.T_TRIM;
                parseList = new short[] {
                    Tokens.OPENBRACKET, Tokens.X_OPTION, 11,    //
                    Tokens.X_OPTION, 5,                         //
                    Tokens.X_KEYSET, 3, Tokens.LEADING, Tokens.TRAILING,
                    Tokens.BOTH,                                //
                    Tokens.X_OPTION, 1, Tokens.QUESTION,        //
                    Tokens.FROM, Tokens.QUESTION, Tokens.CLOSEBRACKET
                };
                break;

            /*
            case FUNCTION_CHAR_NORMALIZE :
                break;
            */
            case FUNC_OVERLAY_CHAR :
            case FUNC_OVERLAY_BINARY :
                name      = Tokens.T_OVERLAY;
                parseList = new short[] {
                    Tokens.OPENBRACKET, Tokens.QUESTION, Tokens.PLACING,
                    Tokens.QUESTION, Tokens.FROM, Tokens.QUESTION,
                    Tokens.X_OPTION, 2, Tokens.FOR, Tokens.QUESTION,
                    Tokens.X_OPTION, 2, Tokens.USING, Tokens.CHARACTERS,
                    Tokens.CLOSEBRACKET
                };
                break;

            case FUNC_CURRENT_CATALOG :
                name      = Tokens.T_CURRENT_CATALOG;
                parseList = noParamList;
                break;

            /*
            case FUNC_CURRENT_DEFAULT_TRANSFORM_GROUP :
                break;
            case FUNC_CURRENT_PATH :
                break;
            */
            case FUNC_CURRENT_ROLE :
                name      = Tokens.T_CURRENT_ROLE;
                parseList = noParamList;
                break;

            case FUNC_CURRENT_SCHEMA :
                name      = Tokens.T_CURRENT_SCHEMA;
                parseList = noParamList;
                break;

            /*
            case FUNC_CURRENT_TRANSFORM_GROUP_FOR_TYPE :
                break;
            */
            case FUNC_CURRENT_USER :
                name      = Tokens.T_CURRENT_USER;
                parseList = noParamList;
                break;

            case FUNC_SESSION_USER :
                name      = Tokens.T_SESSION_USER;
                parseList = noParamList;
                break;

            case FUNC_SYSTEM_USER :
                name      = Tokens.T_SYSTEM_USER;
                parseList = noParamList;
                break;

            case FUNC_USER :
                name      = Tokens.T_USER;
                parseList = optionalNoParamList;
                break;

            case FUNC_VALUE :
                name      = Tokens.T_VALUE;
                parseList = noParamList;
                break;

            case FUNC_CURRENT_DATE :
                name      = Tokens.T_CURRENT_DATE;
                parseList = noParamList;
                break;

            case FUNC_CURRENT_TIME :
                name      = Tokens.T_CURRENT_TIME;
                parseList = optionalIntegerParamList;
                break;

            case FUNC_CURRENT_TIMESTAMP :
                name      = Tokens.T_CURRENT_TIMESTAMP;
                parseList = optionalIntegerParamList;
                break;

            case FUNC_LOCALTIME :
                name      = Tokens.T_LOCALTIME;
                parseList = optionalIntegerParamList;
                break;

            case FUNC_LOCALTIMESTAMP :
                name      = Tokens.T_LOCALTIMESTAMP;
                parseList = optionalIntegerParamList;
                break;

            default :
                throw Error.runtimeError(ErrorCode.U_S0500, "FunctionSQL");
        }
    }

    public void setArguments(Expression[] newNodes) {
        this.nodes = newNodes;
    }

    public Expression getFunctionExpression() {
        return this;
    }

    /**
     * Evaluates and returns this Function in the context of the session.<p>
     */
    public Object getValue(Session session) {

        Object[] data = ValuePool.emptyObjectArray;

        if (nodes.length > 0) {
            data = new Object[nodes.length];

            for (int i = 0; i < nodes.length; i++) {
                Expression e = nodes[i];

                if (e != null) {
                    data[i] = e.getValue(session, e.dataType);
                }
            }
        }

        return getValue(session, data);
    }

    Object getValue(Session session, Object[] data) {

        switch (funcType) {

            case FUNC_POSITION_CHAR : {
                if (data[0] == null || data[1] == null) {
                    return null;
                }

                long offset = 0;

                if (nodes.length > 3 && nodes[3] != null) {
                    Object value = nodes[3].getValue(session);

                    offset = ((Number) value).longValue() - 1;

                    if (offset < 0) {
                        offset = 0;
                    }
                }

                long result =
                    ((CharacterType) nodes[1].dataType).position(
                        session, data[1], data[0], nodes[0].dataType,
                        offset) + 1;

                if (nodes[2] != null
                        && ((Number) nodes[2].valueData).intValue()
                           == Tokens.OCTETS) {
                    result *= 2;
                }

                return ValuePool.getLong(result);
            }
            case FUNC_POSITION_BINARY : {
                if (data[0] == null || data[1] == null) {
                    return null;
                }

                long result =
                    ((BinaryType) nodes[1].dataType).position(
                        session, (BlobData) data[1], (BlobData) data[0],
                        nodes[0].dataType, 0) + 1;

                if (nodes[2] != null
                        && ((Number) nodes[2].valueData).intValue()
                           == Tokens.OCTETS) {
                    result *= 2;
                }

                return ValuePool.getLong(result);
            }
            /*
            case FUNC_OCCURENCES_REGEX :
            case FUNC_POSITION_REGEX :
            */
            case FUNC_EXTRACT : {
                if (data[1] == null) {
                    return null;
                }

                int part = ((Number) nodes[0].valueData).intValue();

                part = DTIType.getFieldNameTypeForToken(part);

                switch (part) {

                    case Types.SQL_INTERVAL_SECOND : {
                        return ((DTIType) nodes[1].dataType).getSecondPart(
                            data[1]);
                    }
                    case DTIType.MONTH_NAME :
                    case DTIType.DAY_NAME : {
                        return ((DateTimeType) nodes[1].dataType)
                            .getPartString(session, data[1], part);
                    }
                    default : {
                        int value =
                            ((DTIType) nodes[1].dataType).getPart(session,
                                data[1], part);

                        return ValuePool.getInt(value);
                    }
                }
            }
            case FUNC_CHAR_LENGTH : {
                if (data[0] == null) {
                    return null;
                }

                long result = ((CharacterType) nodes[0].dataType).size(session,
                    data[0]);

                return ValuePool.getLong(result);
            }
            case FUNC_BIT_LENGTH : {
                if (data[0] == null) {
                    return null;
                }

                long result;

                if (nodes[0].dataType.isBinaryType()) {
                    result = ((BlobData) data[0]).bitLength(session);
                } else {
                    result =
                        16 * ((CharacterType) nodes[0].dataType).size(session,
                            data[0]);
                }

                return ValuePool.getLong(result);
            }
            case FUNC_OCTET_LENGTH : {
                if (data[0] == null) {
                    return null;
                }

                long result;

                if (nodes[0].dataType.isBinaryType()) {
                    result = ((BlobData) data[0]).length(session);
                } else {
                    result =
                        2 * ((CharacterType) nodes[0].dataType).size(session,
                            data[0]);
                }

                return ValuePool.getLong(result);
            }
            case FUNC_CARDINALITY : {
                if (data[0] == null) {
                    return null;
                }

                int result = nodes[0].dataType.cardinality(session, data[0]);

                return ValuePool.getInt(result);
            }
            case FUNC_MAX_CARDINALITY : {
                if (data[0] == null) {
                    return null;
                }

                int result = nodes[0].dataType.arrayLimitCardinality();

                return ValuePool.getInt(result);
            }
            case FUNC_TRIM_ARRAY : {
                if (data[0] == null) {
                    return null;
                }

                if (data[1] == null) {
                    return null;
                }

                Object[] array  = (Object[]) data[0];
                int      length = ((Number) data[1]).intValue();

                if (length < 0 || length > array.length) {
                    throw Error.error(ErrorCode.X_2202E);
                }

                Object[] newArray = new Object[array.length - length];

                System.arraycopy(array, 0, newArray, 0, newArray.length);

                return newArray;
            }
            case FUNC_ABS : {
                if (data[0] == null) {
                    return null;
                }

                return dataType.absolute(data[0]);
            }
            case FUNC_MOD : {
                if (data[0] == null || data[1] == null) {
                    return null;
                }

                data[0] = nodeDataTypes[0].convertToType(session, data[0],
                        nodes[0].dataType);
                data[1] = nodeDataTypes[1].convertToType(session, data[1],
                        nodes[1].dataType);

                // result type is the same as nodes[1]
                Object value = ((NumberType) nodeDataTypes[0]).modulo(session,
                    data[0], data[1], nodeDataTypes[1]);

                return value;
            }
            case FUNC_LN : {
                if (data[0] == null) {
                    return null;
                }

                double d = ((Number) data[0]).doubleValue();

                if (d <= 0) {
                    throw Error.error(ErrorCode.X_2201E);
                }

                d = Math.log(d);

                return ValuePool.getDouble(Double.doubleToLongBits(d));
            }
            case FUNC_EXP : {
                if (data[0] == null) {
                    return null;
                }

                double val = Math.exp(((Number) data[0]).doubleValue());

                return ValuePool.getDouble(Double.doubleToLongBits(val));
            }
            case FUNC_POWER : {
                if (data[0] == null || data[1] == null) {
                    return null;
                }

                double base     = ((Number) data[0]).doubleValue();
                double exponent = ((Number) data[1]).doubleValue();
                double val;

                if (base == 0) {
                    if (exponent < 0) {
                        throw Error.error(ErrorCode.X_2201F);
                    } else if (exponent == 0) {
                        val = 1;
                    } else {
                        val = 0;
                    }
                } else {
                    val = Math.pow(base, exponent);
                }

                return ValuePool.getDouble(Double.doubleToLongBits(val));
            }
            case FUNC_SQRT : {
                if (data[0] == null) {
                    return null;
                }

                double val = Math.sqrt(((Number) data[0]).doubleValue());

                return ValuePool.getDouble(Double.doubleToLongBits(val));
            }
            case FUNC_FLOOR : {
                if (data[0] == null) {
                    return null;
                }

                return ((NumberType) dataType).floor(data[0]);
            }
            case FUNC_CEILING : {
                if (data[0] == null) {
                    return null;
                }

                return ((NumberType) dataType).ceiling(data[0]);
            }
            case FUNC_WIDTH_BUCKET : {
                for (int i = 0; i < data.length; i++) {
                    if (data[i] == null) {
                        return null;
                    }

                    data[i] = nodeDataTypes[i].convertToType(session, data[i],
                            nodes[i].dataType);
                }

                if (((NumberType) nodeDataTypes[3]).isNegative(data[3])) {
                    throw Error.error(ErrorCode.X_2201G);
                }

                int compare = nodeDataTypes[1].compare(session, data[1],
                                                       data[2]);
                Type   subType;
                Object temp;
                Object temp2;

                if (nodeDataTypes[0].isNumberType()) {
                    subType = nodeDataTypes[0];
                } else {
                    subType = nodeDataTypes[0].getCombinedType(session,
                            nodeDataTypes[0], OpTypes.SUBTRACT);
                }

                switch (compare) {

                    case 0 :
                        throw Error.error(ErrorCode.X_2201G);
                    case -1 : {
                        if (nodeDataTypes[0].compare(session, data[0], data[1])
                                < 0) {
                            return ValuePool.INTEGER_0;
                        }

                        if (nodeDataTypes[0].compare(session, data[0], data[2])
                                >= 0) {
                            return dataType.add(session, data[3],
                                                ValuePool.INTEGER_1,
                                                Type.SQL_INTEGER);
                        }

                        temp = subType.subtract(session, data[0], data[1],
                                                nodeDataTypes[1]);
                        temp2 = subType.subtract(session, data[2], data[1],
                                                 nodeDataTypes[1]);

                        break;
                    }
                    case 1 : {
                        if (nodeDataTypes[0].compare(session, data[0], data[1])
                                > 0) {
                            return ValuePool.INTEGER_0;
                        }

                        if (nodeDataTypes[0].compare(session, data[0], data[2])
                                <= 0) {
                            return dataType.add(session, data[3],
                                                ValuePool.INTEGER_1,
                                                Type.SQL_INTEGER);
                        }

                        temp = subType.subtract(session, data[1], data[0],
                                                nodeDataTypes[0]);
                        temp2 = subType.subtract(session, data[1], data[2],
                                                 nodeDataTypes[2]);

                        break;
                    }
                    default :
                        throw Error.runtimeError(ErrorCode.U_S0500, "");
                }

                Type opType;

                if (subType.typeCode == Types.SQL_DOUBLE) {
                    opType = subType;
                } else {
                    opType = IntervalType.factorType;
                    temp   = opType.convertToType(session, temp, subType);
                    temp2  = opType.convertToType(session, temp2, subType);
                }

                temp = opType.multiply(temp, data[3]);
                temp = opType.divide(session, temp, temp2);
                temp = dataType.convertToDefaultType(session, temp);

                return dataType.add(session, temp, ValuePool.INTEGER_1,
                                    Type.SQL_INTEGER);
            }
            case FUNC_SUBSTRING_CHAR : {
                if (data[0] == null || data[1] == null) {
                    return null;
                }

                Object value;

                value = Type.SQL_BIGINT.convertToType(session, data[1],
                                                      nodes[1].dataType);

                long offset = ((Number) value).longValue() - 1;
                long length = 0;

                if (nodes[2] != null) {
                    if (data[2] == null) {
                        return null;
                    }

                    value = Type.SQL_BIGINT.convertToType(session, data[2],
                                                          nodes[2].dataType);
                    length = ((Number) value).longValue();
                }

                if (nodes.length > 3 && nodes[3] != null
                        && ((Number) nodes[2].valueData).intValue()
                           == Tokens.OCTETS) {

                    // not clear what the rules on USING OCTECTS are with UTF
                }

                return ((CharacterType) dataType).substring(session, data[0],
                        offset, length, nodes[2] != null, false);
            }
            /*
            case FUNCTION_SUBSTRING_REG_EXPR :
                break;
            case FUNCTION_SUBSTRING_REGEX :
                break;
            */
            case FUNC_FOLD_LOWER :
                if (data[0] == null) {
                    return null;
                }

                return ((CharacterType) dataType).lower(session, data[0]);

            case FUNC_FOLD_UPPER :
                if (data[0] == null) {
                    return null;
                }

                return ((CharacterType) dataType).upper(session, data[0]);

            /*
            case FUNCTION_TRANSCODING :
                break;
            case FUNCTION_TRANSLITERATION :
                break;
            case FUNCTION_REGEX_TRANSLITERATION :
                break;
             */
            case FUNC_TRIM_CHAR : {
                if (data[1] == null || data[2] == null) {
                    return null;
                }

                boolean leading  = false;
                boolean trailing = false;

                switch (((Number) nodes[0].valueData).intValue()) {

                    case Tokens.BOTH :
                        leading = trailing = true;
                        break;

                    case Tokens.LEADING :
                        leading = true;
                        break;

                    case Tokens.TRAILING :
                        trailing = true;
                        break;

                    default :
                        throw Error.runtimeError(ErrorCode.U_S0500,
                                                 "FunctionSQL");
                }

                String string = (String) data[1];

                if (string.length() != 1) {
                    throw Error.error(ErrorCode.X_22027);
                }

                char character = string.charAt(0);

                return ((CharacterType) dataType).trim(session, data[2],
                                                       character, leading,
                                                       trailing);
            }
            case FUNC_OVERLAY_CHAR : {
                if (data[0] == null || data[1] == null || data[2] == null) {
                    return null;
                }

                Object value;

                value = Type.SQL_BIGINT.convertToType(session, data[2],
                                                      nodes[2].dataType);

                long offset = ((Number) value).longValue() - 1;
                long length = 0;

                if (nodes[3] != null) {
                    if (data[3] == null) {
                        return null;
                    }

                    value = Type.SQL_BIGINT.convertToType(session, data[3],
                                                          nodes[3].dataType);
                    length = ((Number) value).longValue();
                }

                return ((CharacterType) dataType).overlay(null, data[0],
                        data[1], offset, length, nodes[3] != null);
            }
            /*
            case FUNCTION_CHAR_NORMALIZE :
                break;
            */
            case FUNC_SUBSTRING_BINARY : {
                if (data[0] == null || data[1] == null) {
                    return null;
                }

                Object value;

                value = Type.SQL_BIGINT.convertToType(session, data[1],
                                                      nodes[1].dataType);

                long offset = ((Number) value).longValue() - 1;
                long length = 0;

                if (nodes[2] != null) {
                    if (data[2] == null) {
                        return null;
                    }

                    value = Type.SQL_BIGINT.convertToType(session, data[2],
                                                          nodes[2].dataType);
                    length = ((Number) value).intValue();
                }

                return ((BinaryType) dataType).substring(session,
                        (BlobData) data[0], offset, length, nodes[2] != null);
            }
            case FUNC_TRIM_BINARY : {
                if (data[1] == null || data[2] == null) {
                    return null;
                }

                boolean leading  = false;
                boolean trailing = false;
                int     spec     = ((Number) nodes[0].valueData).intValue();

                switch (spec) {

                    case Tokens.BOTH :
                        leading = trailing = true;
                        break;

                    case Tokens.LEADING :
                        leading = true;
                        break;

                    case Tokens.TRAILING :
                        trailing = true;
                        break;

                    default :
                        throw Error.runtimeError(ErrorCode.U_S0500,
                                                 "FunctionSQL");
                }

                BlobData string = (BlobData) data[1];

                if (string.length(session) != 1) {
                    throw Error.error(ErrorCode.X_22027);
                }

                byte[] bytes = string.getBytes();

                return ((BinaryType) dataType).trim(session,
                                                    (BlobData) data[2],
                                                    bytes[0], leading,
                                                    trailing);
            }
            case FUNC_OVERLAY_BINARY : {
                if (data[0] == null || data[1] == null || data[2] == null) {
                    return null;
                }

                Object value;

                value = Type.SQL_BIGINT.convertToType(session, data[2],
                                                      nodes[2].dataType);

                long offset = ((Number) value).longValue() - 1;
                long length = 0;

                if (nodes[3] != null) {
                    if (data[3] == null) {
                        return null;
                    }

                    value = Type.SQL_BIGINT.convertToType(session, data[3],
                                                          nodes[3].dataType);
                    length = ((Number) value).longValue();
                }

                return ((BinaryType) dataType).overlay(session,
                                                       (BlobData) data[0],
                                                       (BlobData) data[1],
                                                       offset, length,
                                                       nodes[3] != null);
            }
            case FUNC_CURRENT_CATALOG :
                return session.database.getCatalogName().name;

            /*
            case FUNC_CURRENT_DEFAULT_TRANSFORM_GROUP :
            case FUNC_CURRENT_PATH :
            */
            case FUNC_CURRENT_ROLE :
                return session.getRole() == null ? null
                                                 : session.getRole().getName()
                                                     .getNameString();

            case FUNC_CURRENT_SCHEMA :
                return session.getCurrentSchemaHsqlName().name;

            /*
            case FUNC_CURRENT_TRANSFORM_GROUP_FOR_TYPE :
            */
            case FUNC_CURRENT_USER :
                return session.getUser().getName().getNameString();

            case FUNC_SESSION_USER :
                return session.getUser().getName().getNameString();

            case FUNC_SYSTEM_USER :
                return session.getUser().getName().getNameString();

            case FUNC_USER :
                return session.getUser().getName().getNameString();

            case FUNC_VALUE :
                return session.sessionData.currentValue;

            case FUNC_CURRENT_DATE :
                if (session.database.sqlSyntaxOra) {
                    return dataType.convertToTypeLimits(
                        session, session.getCurrentTimestamp(false));
                }

                return session.getCurrentDate();

            case FUNC_CURRENT_TIME :
                return dataType.convertToTypeLimits(
                    session, session.getCurrentTime(true));

            case FUNC_CURRENT_TIMESTAMP :
                return dataType.convertToTypeLimits(
                    session, session.getCurrentTimestamp(true));

            case FUNC_LOCALTIME :
                return dataType.convertToTypeLimits(
                    session, session.getCurrentTime(false));

            case FUNC_LOCALTIMESTAMP :
                return dataType.convertToTypeLimits(
                    session, session.getCurrentTimestamp(false));

            default :
                throw Error.runtimeError(ErrorCode.U_S0500, "FunctionSQL");
        }
    }

    public void resolveTypes(Session session, Expression parent) {

        for (int i = 0; i < nodes.length; i++) {
            if (nodes[i] != null) {
                nodes[i].resolveTypes(session, this);
            }
        }

        switch (funcType) {

            case FUNC_POSITION_CHAR :
            case FUNC_POSITION_BINARY : {
                if (nodes[0].dataType == null) {
                    if (nodes[1].dataType == null) {
                        throw Error.error(ErrorCode.X_42567);
                    }

                    if (nodes[1].dataType.typeCode == Types.SQL_CLOB
                            || nodes[1].dataType.isBinaryType()) {
                        nodes[0].dataType = nodes[1].dataType;
                    } else {
                        nodes[0].dataType = Type.SQL_VARCHAR;
                    }
                }

                if (nodes[1].dataType == null) {
                    if (nodes[0].dataType.typeCode == Types.SQL_CLOB
                            || nodes[0].dataType.isBinaryType()) {
                        nodes[1].dataType = nodes[0].dataType;
                    } else {
                        nodes[1].dataType = Type.SQL_VARCHAR;
                    }
                }

                if (nodes[0].dataType.isCharacterType()
                        && nodes[1].dataType.isCharacterType()) {
                    funcType = FUNC_POSITION_CHAR;
                } else if (nodes[0].dataType.isBinaryType()
                           && nodes[1].dataType.isBinaryType()) {
                    if (nodes[0].dataType.isBitType()
                            || nodes[1].dataType.isBitType()) {
                        throw Error.error(ErrorCode.X_42563);
                    }

                    funcType = FUNC_POSITION_BINARY;
                } else {
                    throw Error.error(ErrorCode.X_42563);
                }

                if (nodes.length > 3 && nodes[3] != null) {
                    if (nodes[3].isDynamicParam()) {
                        nodes[3].dataType = Type.SQL_BIGINT;
                    }

                    if (!nodes[3].dataType.isNumberType()) {
                        throw Error.error(ErrorCode.X_42563);
                    }
                }

                dataType = Type.SQL_BIGINT;

                break;
            }
            /*
            case FUNC_OCCURENCES_REGEX :
            case FUNC_POSITION_REGEX :
            */
            case FUNC_EXTRACT : {
                if (nodes[1].dataType == null) {
                    throw Error.error(ErrorCode.X_42567);
                }

                if (!nodes[1].dataType.isDateTimeType()
                        && !nodes[1].dataType.isIntervalType()) {
                    throw Error.error(ErrorCode.X_42563);
                }

                int     part = ((Number) nodes[0].valueData).intValue();
                DTIType type = (DTIType) nodes[1].dataType;

                part     = DTIType.getFieldNameTypeForToken(part);
                dataType = type.getExtractType(part);

                break;
            }
            case FUNC_BIT_LENGTH : {
                if (nodes[0].dataType == null) {
                    nodes[0].dataType = Type.SQL_BIT_VARYING_MAX_LENGTH;
                }

                if (!nodes[0].dataType.isCharacterType()
                        && !nodes[0].dataType.isBinaryType()) {
                    throw Error.error(ErrorCode.X_42563);
                }

                dataType = Type.SQL_BIGINT;

                break;
            }
            case FUNC_CHAR_LENGTH :
                if (nodes[0].dataType == null) {
                    nodes[0].dataType = Type.SQL_VARCHAR;
                }

                if (!nodes[0].dataType.isCharacterType()) {
                    throw Error.error(ErrorCode.X_42563);
                }

            // fall through
            case FUNC_OCTET_LENGTH : {
                if (nodes[0].dataType == null) {
                    nodes[0].dataType = Type.SQL_VARCHAR;
                }

                if (!nodes[0].dataType.isCharacterType()
                        && !nodes[0].dataType.isBinaryType()) {
                    throw Error.error(ErrorCode.X_42563);
                }

                dataType = Type.SQL_BIGINT;

                break;
            }
            case FUNC_CARDINALITY : {
                if (nodes[0].dataType == null) {
                    throw Error.error(ErrorCode.X_42567);
                }

                if (!nodes[0].dataType.isArrayType()) {
                    throw Error.error(ErrorCode.X_42563);
                }

                dataType = Type.SQL_INTEGER;

                break;
            }
            case FUNC_MAX_CARDINALITY : {
                if (nodes[0].dataType == null) {
                    throw Error.error(ErrorCode.X_42567);
                }

                if (!nodes[0].dataType.isArrayType()) {
                    throw Error.error(ErrorCode.X_42563);
                }

                dataType = Type.SQL_INTEGER;

                break;
            }
            case FUNC_TRIM_ARRAY : {
                if (nodes[0].dataType == null) {
                    throw Error.error(ErrorCode.X_42567);
                }

                if (!nodes[0].dataType.isArrayType()) {
                    throw Error.error(ErrorCode.X_42563);
                }

                if (nodes[1].dataType == null) {
                    nodes[1].dataType = Type.SQL_INTEGER;
                }

                if (!nodes[1].dataType.isIntegralType()) {
                    throw Error.error(ErrorCode.X_42563);
                }

                dataType = nodes[0].dataType;

                break;
            }
            case FUNC_MOD : {
                if (nodes[0].dataType == null) {
                    nodes[0].dataType = nodes[1].dataType;
                }

                if (nodes[1].dataType == null) {
                    nodes[1].dataType = nodes[0].dataType;
                }

                if (nodes[0].dataType == null) {
                    throw Error.error(ErrorCode.X_42567);
                }

                if (!nodes[0].dataType.isNumberType()
                        || !nodes[1].dataType.isNumberType()) {
                    throw Error.error(ErrorCode.X_42563);
                }

                nodeDataTypes = new Type[2];

                if (session.database.sqlSyntaxOra) {
                    nodeDataTypes[0] =
                        nodes[0].dataType.getAggregateType(nodes[1].dataType);
                    nodeDataTypes[1] = nodes[1].dataType;
                } else {
                    nodeDataTypes[0] =
                        ((NumberType) nodes[0].dataType).getIntegralType();
                    nodeDataTypes[1] =
                        ((NumberType) nodes[1].dataType).getIntegralType();
                }

                dataType = nodeDataTypes[1];

                break;
            }
            case FUNC_POWER : {
                if (nodes[0].dataType == null) {
                    nodes[0].dataType = nodes[1].dataType;
                }

                if (nodes[1].dataType == null) {
                    nodes[1].dataType = nodes[0].dataType;
                }

                if (nodes[0].dataType == null) {
                    throw Error.error(ErrorCode.X_42567);
                }

                if (!nodes[0].dataType.isNumberType()
                        || !nodes[1].dataType.isNumberType()) {
                    throw Error.error(ErrorCode.X_42563);
                }

                dataType = Type.SQL_DOUBLE;

                break;
            }
            case FUNC_LN :
            case FUNC_EXP :
            case FUNC_SQRT : {
                if (nodes[0].dataType == null) {
                    nodes[0].dataType = Type.SQL_DOUBLE;
                }

                if (!nodes[0].dataType.isNumberType()) {
                    throw Error.error(ErrorCode.X_42563);
                }

                dataType = Type.SQL_DOUBLE;

                break;
            }
            case FUNC_ABS :
                if (nodes[0].dataType != null
                        && nodes[0].dataType.isIntervalType()) {
                    dataType = nodes[0].dataType;

                    break;
                }

            // fall through
            case FUNC_FLOOR :
            case FUNC_CEILING : {
                if (nodes[0].dataType == null) {
                    nodes[0].dataType = Type.SQL_DOUBLE;
                }

                if (!nodes[0].dataType.isNumberType()) {
                    throw Error.error(ErrorCode.X_42563);
                }

                dataType = nodes[0].dataType;

                if (dataType.typeCode == Types.SQL_DECIMAL
                        || dataType.typeCode == Types.SQL_NUMERIC) {
                    if (dataType.scale > 0) {
                        dataType = NumberType.getNumberType(dataType.typeCode,
                                                            dataType.precision
                                                            + 1, 0);
                    }
                }

                break;
            }
            case FUNC_WIDTH_BUCKET : {
                nodeDataTypes = new Type[4];
                nodeDataTypes[0] = Type.getAggregateType(nodes[0].dataType,
                        nodes[1].dataType);
                nodeDataTypes[0] = Type.getAggregateType(nodeDataTypes[0],
                        nodes[2].dataType);

                if (nodeDataTypes[0] == null) {
                    throw Error.error(ErrorCode.X_42567);
                }

                if (!nodeDataTypes[0].isNumberType()
                        && !nodeDataTypes[0].isDateTimeType()) {
                    throw Error.error(ErrorCode.X_42563);
                }

                nodeDataTypes[1] = nodeDataTypes[0];
                nodeDataTypes[2] = nodeDataTypes[0];

                if (nodes[1].dataType == null) {
                    nodes[1].dataType = nodeDataTypes[1];
                }

                if (nodes[2].dataType == null) {
                    nodes[2].dataType = nodeDataTypes[2];
                }

                if (nodes[3].dataType == null) {
                    nodes[3].dataType = Type.SQL_INTEGER;
                }

                if (!nodes[3].dataType.isIntegralType()) {
                    throw Error.error(ErrorCode.X_42563);
                }

                nodeDataTypes[3] = nodes[3].dataType;
                dataType         = nodes[3].dataType;

                break;
            }
            case FUNC_SUBSTRING_CHAR :
            case FUNC_SUBSTRING_BINARY : {
                if (nodes[0].dataType == null) {

                    // in 20.6 parameter not allowed as type cannot be determined as binary or char
                    // throw Error.error(ErrorCode.X_42567);
                    nodes[0].dataType = Type.SQL_VARCHAR_DEFAULT;
                }

                if (nodes[1].dataType == null) {
                    nodes[1].dataType = Type.SQL_NUMERIC;
                }

                if (!nodes[1].dataType.isNumberType()) {
                    throw Error.error(ErrorCode.X_42563);
                }

                if (nodes[2] != null) {
                    if (nodes[2].dataType == null) {
                        nodes[2].dataType = Type.SQL_NUMERIC;
                    }

                    if (!nodes[2].dataType.isNumberType()) {
                        throw Error.error(ErrorCode.X_42563);
                    }
                }

                dataType = nodes[0].dataType;

                if (dataType.isCharacterType()) {
                    funcType = FUNC_SUBSTRING_CHAR;

                    if (dataType.typeCode == Types.SQL_CHAR) {
                        dataType = CharacterType.getCharacterType(
                            Types.SQL_VARCHAR, dataType.precision,
                            dataType.getCollation());
                    }
                } else if (dataType.isBinaryType()) {
                    funcType = FUNC_SUBSTRING_BINARY;
                } else {
                    throw Error.error(ErrorCode.X_42563);
                }

                if (nodes.length > 3 && nodes[3] != null) {

                    // always boolean constant if defined
                }

                break;
            }
            /*
            case FUNCTION_SUBSTRING_REG_EXPR :
                break;
            case FUNCTION_SUBSTRING_REGEX :
                break;
            */
            case FUNC_FOLD_LOWER :
            case FUNC_FOLD_UPPER :
                if (nodes[0].dataType == null) {
                    nodes[0].dataType = Type.SQL_VARCHAR_DEFAULT;
                }

                dataType = nodes[0].dataType;

                if (!dataType.isCharacterType()) {
                    throw Error.error(ErrorCode.X_42563);
                }
                break;

            /*
            case FUNCTION_TRANSCODING :
                break;
            case FUNCTION_TRANSLITERATION :
                break;
            case FUNCTION_REGEX_TRANSLITERATION :
                break;
             */
            case FUNC_TRIM_CHAR :
            case FUNC_TRIM_BINARY :
                if (nodes[0] == null) {
                    nodes[0] =
                        new ExpressionValue(ValuePool.getInt(Tokens.BOTH),
                                            Type.SQL_INTEGER);
                }

                if (nodes[2].dataType == null) {
                    nodes[2].dataType = Type.SQL_VARCHAR_DEFAULT;
                }

                dataType = nodes[2].dataType;

                if (dataType.isCharacterType()) {
                    funcType = FUNC_TRIM_CHAR;

                    if (dataType.typeCode == Types.SQL_CHAR) {
                        dataType = CharacterType.getCharacterType(
                            Types.SQL_VARCHAR, dataType.precision,
                            dataType.getCollation());
                    }

                    if (nodes[1] == null) {
                        nodes[1] = new ExpressionValue(" ", Type.SQL_CHAR);
                    }
                } else if (dataType.isBinaryType()) {
                    funcType = FUNC_TRIM_BINARY;

                    if (nodes[1] == null) {
                        nodes[1] = new ExpressionValue(
                            new BinaryData(new byte[]{ 0 }, false),
                            Type.SQL_BINARY);
                    }
                } else {
                    throw Error.error(ErrorCode.X_42563);
                }
                break;

            case FUNC_OVERLAY_CHAR :
            case FUNC_OVERLAY_BINARY : {
                if (nodes[0].dataType == null) {
                    if (nodes[1].dataType == null) {
                        nodes[0].dataType = Type.SQL_VARCHAR_DEFAULT;
                        nodes[1].dataType = Type.SQL_VARCHAR_DEFAULT;

                        // throw Error.error(ErrorCode.X_42567);
                    }

                    if (nodes[1].dataType.typeCode == Types.SQL_CLOB
                            || nodes[1].dataType.isBinaryType()) {
                        nodes[0].dataType = nodes[1].dataType;
                    } else {
                        nodes[0].dataType = Type.SQL_VARCHAR_DEFAULT;
                    }
                }

                if (nodes[1].dataType == null) {
                    if (nodes[0].dataType.typeCode == Types.SQL_CLOB
                            || nodes[0].dataType.isBinaryType()) {
                        nodes[1].dataType = nodes[0].dataType;
                    } else {
                        nodes[1].dataType = Type.SQL_VARCHAR_DEFAULT;
                    }
                }

                if (nodes[0].dataType.isCharacterType()
                        && nodes[1].dataType.isCharacterType()) {
                    funcType = FUNC_OVERLAY_CHAR;

                    if (nodes[0].dataType.typeCode == Types.SQL_CLOB
                            || nodes[1].dataType.typeCode == Types.SQL_CLOB) {
                        dataType =
                            CharacterType
                                .getCharacterType(Types.SQL_CLOB,
                                                  nodes[0].dataType.precision
                                                  + nodes[1].dataType
                                                      .precision, nodes[0]
                                                      .dataType
                                                      .getCollation());
                    } else {
                        dataType =
                            CharacterType
                                .getCharacterType(Types.SQL_VARCHAR,
                                                  nodes[0].dataType.precision
                                                  + nodes[1].dataType
                                                      .precision, nodes[0]
                                                      .dataType
                                                      .getCollation());
                    }
                } else if (nodes[0].dataType.isBinaryType()
                           && nodes[1].dataType.isBinaryType()) {
                    funcType = FUNC_OVERLAY_BINARY;

                    if (nodes[0].dataType.typeCode == Types.SQL_BLOB
                            || nodes[1].dataType.typeCode == Types.SQL_BLOB) {
                        dataType = BinaryType.getBinaryType(
                            Types.SQL_BLOB,
                            nodes[0].dataType.precision
                            + nodes[1].dataType.precision);
                    } else {
                        dataType = BinaryType.getBinaryType(
                            Types.SQL_VARBINARY,
                            nodes[0].dataType.precision
                            + nodes[1].dataType.precision);
                    }
                } else {
                    throw Error.error(ErrorCode.X_42563);
                }

                if (nodes[2].dataType == null) {
                    nodes[2].dataType = Type.SQL_NUMERIC;
                }

                if (!nodes[2].dataType.isNumberType()) {
                    throw Error.error(ErrorCode.X_42563);
                }

                if (nodes[3] != null) {
                    if (nodes[3].dataType == null) {
                        nodes[3].dataType = Type.SQL_NUMERIC;
                    }

                    if (!nodes[3].dataType.isNumberType()) {
                        throw Error.error(ErrorCode.X_42563);
                    }
                }

                break;
            }
            /*
            case FUNCTION_CHAR_NORMALIZE :
                break;
            */
            case FUNC_CURRENT_CATALOG :
            case FUNC_CURRENT_DEFAULT_TRANSFORM_GROUP :
            case FUNC_CURRENT_PATH :
            case FUNC_CURRENT_ROLE :
            case FUNC_CURRENT_SCHEMA :
            case FUNC_CURRENT_TRANSFORM_GROUP_FOR_TYPE :
            case FUNC_CURRENT_USER :
            case FUNC_SESSION_USER :
            case FUNC_SYSTEM_USER :
            case FUNC_USER :
                dataType = TypeInvariants.SQL_IDENTIFIER;
                break;

            case FUNC_VALUE :
                break;

            case FUNC_CURRENT_DATE :
                if (session.database.sqlSyntaxOra) {
                    dataType = Type.SQL_TIMESTAMP_NO_FRACTION;

                    break;
                }

                dataType = Type.SQL_DATE;
                break;

            case FUNC_CURRENT_TIME : {
                int precision = DateTimeType.defaultTimeFractionPrecision;

                if (nodes.length > 0 && nodes[0] != null) {
                    precision = ((Integer) nodes[0].valueData).intValue();
                }

                dataType =
                    DateTimeType.getDateTimeType(Types.SQL_TIME_WITH_TIME_ZONE,
                                                 precision);

                break;
            }
            case FUNC_CURRENT_TIMESTAMP : {
                int precision = DateTimeType.defaultTimestampFractionPrecision;

                if (nodes.length > 0 && nodes[0] != null) {
                    precision = ((Integer) nodes[0].valueData).intValue();
                }

                dataType = DateTimeType.getDateTimeType(
                    Types.SQL_TIMESTAMP_WITH_TIME_ZONE, precision);

                break;
            }
            case FUNC_LOCALTIME : {
                int precision = DateTimeType.defaultTimeFractionPrecision;

                if (nodes.length > 0 && nodes[0] != null) {
                    precision = ((Integer) nodes[0].valueData).intValue();
                }

                dataType = DateTimeType.getDateTimeType(Types.SQL_TIME,
                        precision);

                break;
            }
            case FUNC_LOCALTIMESTAMP : {
                int precision = DateTimeType.defaultTimestampFractionPrecision;

                if (nodes.length > 0 && nodes[0] != null) {
                    precision = ((Integer) nodes[0].valueData).intValue();
                }

                dataType = DateTimeType.getDateTimeType(Types.SQL_TIMESTAMP,
                        precision);

                break;
            }
            default :
                throw Error.runtimeError(ErrorCode.U_S0500, "FunctionSQL");
        }
    }

    public String getSQL() {

        StringBuffer sb = new StringBuffer();

        switch (funcType) {

            case FUNC_POSITION_CHAR :
            case FUNC_POSITION_BINARY : {
                sb.append(Tokens.T_POSITION).append('(')                 //
                    .append(nodes[0].getSQL()).append(' ')               //
                    .append(Tokens.T_IN).append(' ')                     //
                    .append(nodes[1].getSQL());

                if (nodes[2] != null
                        && Boolean.TRUE.equals(nodes[2].valueData)) {
                    sb.append(' ').append(Tokens.T_USING).append(' ').append(
                        Tokens.T_OCTETS);
                }

                sb.append(')');

                break;
            }
            case FUNC_OCCURENCES_REGEX :
                break;

            case FUNC_POSITION_REGEX :
                break;

            case FUNC_EXTRACT : {
                int type = ((Integer) nodes[0].valueData).intValue();

                type = DTIType.getFieldNameTypeForToken(type);

                String token = DTIType.getFieldNameTokenForType(type);

                sb.append(Tokens.T_EXTRACT).append('(').append(token)    //
                    .append(' ').append(Tokens.T_FROM).append(' ')       //
                    .append(nodes[1].getSQL()).append(')');

                break;
            }
            case FUNC_CHAR_LENGTH : {
                sb.append(Tokens.T_CHAR_LENGTH).append('(')              //
                    .append(nodes[0].getSQL()).append(')');

                break;
            }
            case FUNC_BIT_LENGTH : {
                sb.append(Tokens.T_BIT_LENGTH).append('(')               //
                    .append(nodes[0].getSQL()).append(')');

                break;
            }
            case FUNC_OCTET_LENGTH : {
                sb.append(Tokens.T_OCTET_LENGTH).append('(')             //
                    .append(nodes[0].getSQL()).append(')');

                break;
            }
            case FUNC_CARDINALITY : {
                sb.append(Tokens.T_CARDINALITY).append('(')              //
                    .append(nodes[0].getSQL()).append(')');

                break;
            }
            case FUNC_MAX_CARDINALITY : {
                sb.append(Tokens.T_MAX_CARDINALITY).append('(')          //
                    .append(nodes[0].getSQL()).append(')');

                break;
            }
            case FUNC_TRIM_ARRAY : {
                sb.append(Tokens.T_TRIM_ARRAY).append('(')               //
                    .append(nodes[0].getSQL()).append(',')               //
                    .append(nodes[1].getSQL()).append(')');              //

                break;
            }
            case FUNC_ABS : {
                sb.append(Tokens.T_ABS).append('(')                      //
                    .append(nodes[0].getSQL()).append(')');

                break;
            }
            case FUNC_MOD : {
                sb.append(Tokens.T_MOD).append('(')                      //
                    .append(nodes[0].getSQL()).append(',')               //
                    .append(nodes[1].getSQL()).append(')');

                break;
            }
            case FUNC_LN : {
                sb.append(Tokens.T_LN).append('(')                       //
                    .append(nodes[0].getSQL()).append(')');

                break;
            }
            case FUNC_EXP : {
                sb.append(Tokens.T_EXP).append('(')                      //
                    .append(nodes[0].getSQL()).append(')');

                break;
            }
            case FUNC_POWER : {
                sb.append(Tokens.T_POWER).append('(')                    //
                    .append(nodes[0].getSQL()).append(',')               //
                    .append(nodes[1].getSQL()).append(')');

                break;
            }
            case FUNC_SQRT : {
                sb.append(Tokens.T_SQRT).append('(')                     //
                    .append(nodes[0].getSQL()).append(')');

                break;
            }
            case FUNC_FLOOR : {
                sb.append(Tokens.T_FLOOR).append('(')                    //
                    .append(nodes[0].getSQL()).append(')');

                break;
            }
            case FUNC_CEILING : {
                sb.append(Tokens.T_CEILING).append('(')                  //
                    .append(nodes[0].getSQL()).append(')');

                break;
            }
            case FUNC_WIDTH_BUCKET : {
                sb.append(Tokens.T_WIDTH_BUCKET).append('(')             //
                    .append(nodes[0].getSQL()).append(',')               //
                    .append(nodes[1].getSQL()).append(',')               //
                    .append(nodes[2].getSQL()).append(',')               //
                    .append(nodes[3].getSQL()).append(')');

                break;
            }
            case FUNC_SUBSTRING_CHAR :
            case FUNC_SUBSTRING_BINARY :
                sb.append(Tokens.T_SUBSTRING).append('(')                //
                    .append(nodes[0].getSQL()).append(' ')               //
                    .append(Tokens.T_FROM).append(' ')                   //
                    .append(nodes[1].getSQL());

                if (nodes[2] != null) {
                    sb.append(' ').append(Tokens.T_FOR).append(' ')      //
                        .append(nodes[2].getSQL());
                }

                if (nodes.length > 3 && nodes[3] != null) {
                    if (Boolean.TRUE.equals(nodes[3].valueData)) {
                        sb.append(' ').append(Tokens.T_USING).append(
                            ' ').append(Tokens.T_OCTETS);
                    }
                }

                sb.append(')');
                break;

            /*
            case FUNCTION_SUBSTRING_REGEX :
                break;
            */
            case FUNC_FOLD_LOWER :
                sb.append(Tokens.T_LOWER).append('(').append(
                    nodes[0].getSQL()).append(')');
                break;

            case FUNC_FOLD_UPPER :
                sb.append(Tokens.T_UPPER).append('(').append(
                    nodes[0].getSQL()).append(')');
                break;

            /*
            case FUNCTION_TRANSCODING :
                break;
            case FUNCTION_TRANSLITERATION :
                break;
            case FUNCTION_REGEX_TRANSLITERATION :
                break;
             */
            case FUNC_OVERLAY_CHAR :
            case FUNC_OVERLAY_BINARY :
                sb.append(Tokens.T_OVERLAY).append('(')                  //
                    .append(nodes[0].getSQL()).append(' ')               //
                    .append(Tokens.T_PLACING).append(' ')                //
                    .append(nodes[1].getSQL()).append(' ')               //
                    .append(Tokens.T_FROM).append(' ')                   //
                    .append(nodes[2].getSQL());

                if (nodes[3] != null) {
                    sb.append(' ').append(Tokens.T_FOR).append(' ').append(
                        nodes[3].getSQL());
                }

                if (nodes[4] != null) {
                    if (Boolean.TRUE.equals(nodes[4].valueData)) {
                        sb.append(' ').append(Tokens.T_USING).append(
                            ' ').append(Tokens.T_OCTETS);
                    }
                }

                sb.append(')');
                break;

            /*
            case FUNCTION_NORMALIZE :
                break;
            */
            case FUNC_TRIM_CHAR :
            case FUNC_TRIM_BINARY :
                String spec = null;

                switch (((Number) nodes[0].valueData).intValue()) {

                    case Tokens.BOTH :
                        spec = Tokens.T_BOTH;
                        break;

                    case Tokens.LEADING :
                        spec = Tokens.T_LEADING;
                        break;

                    case Tokens.TRAILING :
                        spec = Tokens.T_TRAILING;
                        break;

                    default :
                }

                sb.append(Tokens.T_TRIM).append('(')                     //
                    .append(spec).append(' ')                            //
                    .append(nodes[1].getSQL()).append(' ')               //
                    .append(Tokens.T_FROM).append(' ')                   //
                    .append(nodes[2].getSQL()).append(')');
                break;

            case FUNC_CURRENT_CATALOG :
            case FUNC_CURRENT_DEFAULT_TRANSFORM_GROUP :
            case FUNC_CURRENT_PATH :
            case FUNC_CURRENT_ROLE :
            case FUNC_CURRENT_SCHEMA :
            case FUNC_CURRENT_TRANSFORM_GROUP_FOR_TYPE :
            case FUNC_CURRENT_USER :
            case FUNC_SESSION_USER :
            case FUNC_SYSTEM_USER :
            case FUNC_USER :
            case FUNC_CURRENT_DATE :
            case FUNC_VALUE :
                return name;

            case FUNC_LOCALTIME :
            case FUNC_CURRENT_TIME : {
                int precision = DateTimeType.defaultTimeFractionPrecision;

                if (nodes.length > 0 && nodes[0] != null) {
                    precision = ((Number) nodes[0].valueData).intValue();
                }

                if (precision == DateTimeType.defaultTimeFractionPrecision) {
                    return name;
                }

                sb.append(name).append(Tokens.T_OPENBRACKET).append(precision);
                sb.append(Tokens.T_CLOSEBRACKET);

                return sb.toString();
            }
            case FUNC_LOCALTIMESTAMP :
            case FUNC_CURRENT_TIMESTAMP : {
                int precision = DateTimeType.defaultTimestampFractionPrecision;

                if (nodes.length > 0 && nodes[0] != null) {
                    precision = ((Number) nodes[0].valueData).intValue();
                }

                if (precision
                        == DateTimeType.defaultTimestampFractionPrecision) {
                    return name;
                }

                sb.append(name).append(Tokens.T_OPENBRACKET).append(precision);
                sb.append(Tokens.T_CLOSEBRACKET);

                return sb.toString();
            }
            default :
                throw Error.runtimeError(ErrorCode.U_S0500, "FunctionSQL");
        }

        return sb.toString();
    }

    public boolean equals(Expression other) {

        if (other instanceof FunctionSQL) {
            FunctionSQL o = (FunctionSQL) other;

            return super.equals(other) && funcType == o.funcType;
        }

        return false;
    }

    public int hashCode() {
        return opType + funcType;
    }

    /**
     * Returns a String representation of this object. <p>
     */
    public String describe(Session session, int blanks) {

        StringBuffer sb = new StringBuffer();

        sb.append('\n');

        for (int i = 0; i < blanks; i++) {
            sb.append(' ');
        }

        sb.append("FUNCTION ").append("=[\n");
        sb.append(name).append("(");

        for (int i = 0; i < nodes.length; i++) {
            if (nodes[i] == null) {
                continue;
            }

            sb.append("[").append(nodes[i].describe(session,
                    blanks)).append("]");
        }

        sb.append(") returns ").append(dataType.getNameString());
        sb.append("]\n");

        return sb.toString();
    }

    public boolean isDeterministic() {
        return isDeterministic;
    }

    public boolean isValueFunction() {
        return isSQLValueFunction;
    }
}
