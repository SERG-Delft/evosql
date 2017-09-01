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

/*
 * Codes based on SQL Standards for different types of statement.
 *
 * @author Fred Toussi (fredt@users dot sourceforge.net)
 * @version 2.3.4
 * @since 1.9.0
 */
public interface StatementTypes {

    int ALLOCATE_CURSOR                  = 1;
    int ALLOCATE_DESCRIPTOR              = 2;
    int ALTER_DOMAIN                     = 3;
    int ALTER_ROUTINE                    = 4;
    int ALTER_SEQUENCE                   = 5;
    int ALTER_TYPE                       = 6;
    int ALTER_TABLE                      = 7;
    int ALTER_TRANSFORM                  = 8;
    int CREATE_ASSERTION                 = 9;
    int CALL                             = 10;
    int CREATE_CHARACTER_SET             = 11;
    int CLOSE_CURSOR                     = 12;
    int CREATE_COLLATION                 = 13;
    int COMMIT_WORK                      = 14;
    int CONNECT                          = 15;
    int DEALLOCATE_DESCRIPTOR            = 16;
    int DEALLOCATE_PREPARE               = 17;
    int DELETE_CURSOR                    = 18;
    int DELETE_WHERE                     = 19;
    int DESCRIBE                         = 20;
    int SELECT_DIRECT_SINGLE             = 21;   // identifier is SELECT
    int DISCONNECT                       = 22;
    int CREATE_DOMAIN                    = 23;
    int DROP_ASSERTION                   = 24;
    int DROP_CHARACTER_SET               = 25;
    int DROP_COLLATION                   = 26;
    int DROP_TYPE                        = 27;
    int DROP_DOMAIN                      = 28;
    int DROP_ROLE                        = 29;
    int DROP_ROUTINE                     = 30;
    int DROP_SCHEMA                      = 31;
    int DROP_SEQUENCE                    = 32;
    int DROP_TABLE                       = 33;
    int DROP_TRANSFORM                   = 34;
    int DROP_TRANSLATION                 = 35;
    int DROP_TRIGGER                     = 36;
    int DROP_CAST                        = 37;
    int DROP_ORDERING                    = 38;
    int DROP_VIEW                        = 39;
    int DYNAMIC_CLOSE                    = 40;
    int DYNAMIC_DELETE_CURSOR            = 41;
    int DYNAMIC_FETCH                    = 42;
    int DYNAMIC_OPEN                     = 43;
    int SELECT_CURSOR                    = 44;
    int SELECT_SINGLE_DYNAMIC            = 45;   // identifier is SELECT
    int DYNAMIC_UPDATE_CURSOR            = 46;
    int EXECUTE_IMMEDIATE                = 47;
    int EXECUTE                          = 48;
    int FETCH                            = 49;
    int FREE_LOCATOR                     = 50;
    int GET_DESCRIPTOR                   = 51;
    int HOLD_LOCATOR                     = 52;
    int GRANT                            = 53;
    int GRANT_ROLE                       = 54;
    int INSERT                           = 55;
    int MERGE                            = 56;
    int OPEN                             = 57;
    int PREPARABLE_DYNAMIC_DELETE_CURSOR = 58;
    int PREPARABLE_DYNAMIC_UPDATE_CURSOR = 59;
    int PREPARE                          = 60;
    int RELEASE_SAVEPOINT                = 61;
    int RETURN                           = 62;
    int REVOKE                           = 63;
    int REVOKE_ROLE                      = 64;
    int CREATE_ROLE                      = 65;
    int ROLLBACK_WORK                    = 66;
    int SAVEPOINT                        = 67;
    int CREATE_SCHEMA                    = 68;
    int CREATE_ROUTINE                   = 69;
    int SELECT_SINGLE                    = 70;   // identifier is SELECT
    int CREATE_SEQUENCE                  = 71;
    int SET_CATALOG                      = 72;
    int SET_CONNECTION                   = 73;
    int SET_CONSTRAINT                   = 74;
    int SET_DESCRIPTOR                   = 75;
    int SET_TIME_ZONE                    = 76;
    int SET_NAMES                        = 77;
    int SET_PATH                         = 78;
    int SET_ROLE                         = 79;
    int SET_SCHEMA                       = 80;
    int SET_SESSION_AUTHORIZATION        = 81;
    int SET_SESSION_CHARACTERISTICS      = 82;
    int SET_COLLATION                    = 83;
    int SET_TRANSFORM_GROUP              = 84;
    int SET_TRANSACTION                  = 85;
    int START_TRANSACTION                = 86;
    int CREATE_TABLE                     = 87;
    int CREATE_TRANSFORM                 = 88;
    int CREATE_TRANSLATION               = 89;
    int CREATE_TRIGGER                   = 90;
    int UPDATE_CURSOR                    = 91;
    int UPDATE_WHERE                     = 92;
    int CREATE_CAST                      = 93;
    int CREATE_TYPE                      = 94;
    int CREATE_ORDERING                  = 95;
    int CREATE_VIEW                      = 96;
    int ASSIGNMENT                       = 97;   // PSM
    int CASE                             = 98;
    int BEGIN_END                        = 99;
    int DROP_MODULE                      = 100;
    int FOR                              = 101;
    int IF                               = 102;
    int ITERATE                          = 103;
    int LEAVE                            = 104;
    int LOOP                             = 105;
    int RESIGNAL                         = 106;
    int REPEAT                           = 107;
    int SIGNAL                           = 108;
    int CREATE_MODULE                    = 109;
    int WHILE                            = 110;
    int NULL                             = 111;

    //
    int ALTER_FOREIGN_TABLE         = 121;
    int ALTER_USER_MAPPING          = 122;
    int DROP_FOREIGN_DATA_WRAPPER   = 123;
    int DROP_SERVER                 = 124;
    int DROP_FOREIGN_TABLE          = 125;
    int DROP_ROUTINE_MAPPING        = 126;
    int DROP_USER_MAPPING           = 127;
    int CREATE_FOREIGN_DATA_WRAPPER = 128;
    int CREATE_SERVER               = 129;
    int CREATE_FOREIGN_TABLE        = 130;
    int IMPORT_FOREIGN_SCHEMA       = 131;
    int CREATE_ROUTINE_MAPPING      = 132;
    int SET_PASSTHROUGH             = 133;
    int CREATE_USER_MAPPING         = 134;

    // hsqldb database
    int DATABASE_BACKUP     = 1001;
    int DATABASE_CHECKPOINT = 1002;
    int DATABASE_SHUTDOWN   = 1003;
    int DATABASE_SCRIPT     = 1004;
    int ALTER_SESSION       = 1005;
    int CHECK_INDEX         = 1006;

    // hsqldb database settings
    int SET_DATABASE_FILES_BACKUP_INCREMENT    = 1011;
    int SET_DATABASE_FILES_CACHE_ROWS          = 1012;
    int SET_DATABASE_FILES_CACHE_SIZE          = 1013;
    int SET_DATABASE_FILES_CHECK               = 1014;
    int SET_DATABASE_FILES_DEFRAG              = 1015;
    int SET_DATABASE_FILES_EVENT_LOG           = 1016;
    int SET_DATABASE_FILES_LOBS_SCALE          = 1017;
    int SET_DATABASE_FILES_LOBS_COMPRESSED     = 1018;
    int SET_DATABASE_FILES_UNUSED_TYPE_SETTING = 1019;
    int SET_DATABASE_FILES_LOG                 = 1020;
    int SET_DATABASE_FILES_LOG_SIZE            = 1021;
    int SET_DATABASE_FILES_NIO                 = 1022;
    int SET_DATABASE_FILES_READ_ONLY           = 1023;
    int SET_DATABASE_FILES_READ_ONLY_FILES     = 1024;
    int SET_DATABASE_FILES_SCALE               = 1025;
    int SET_DATABASE_FILES_SCRIPT_FORMAT       = 1026;
    int SET_DATABASE_FILES_SPACE               = 1031;
    int SET_DATABASE_FILES_TEMP_PATH           = 1032;
    int SET_DATABASE_FILES_WRITE_DELAY         = 1033;
    int SET_DATABASE_DEFAULT_INITIAL_SCHEMA    = 1034;
    int SET_DATABASE_DEFAULT_TABLE_TYPE        = 1035;
    int SET_DATABASE_AUTHENTICATION            = 1036;
    int SET_DATABASE_GC                        = 1037;
    int SET_DATABASE_PROPERTY                  = 1039;
    int SET_DATABASE_PASSWORD_CHECK            = 1040;
    int SET_DATABASE_READ_ONLY                 = 1041;
    int SET_DATABASE_READ_ONLY_FILES           = 1042;
    int SET_DATABASE_RESULT_MEMORY_ROWS        = 1046;
    int SET_DATABASE_SQL_COLLATION             = 1047;
    int SET_SESSION_SQL_IGNORECASE             = 1048;
    int SET_DATABASE_SQL_REFERENTIAL_INTEGRITY = 1049;
    int SET_DATABASE_SQL                       = 1050;
    int SET_DATABASE_TEXT_SOURCE               = 1051;
    int SET_DATABASE_TRANSACTION_CONTROL       = 1052;
    int SET_DATABASE_DEFAULT_ISOLATION_LEVEL   = 1053;
    int SET_DATABASE_TRANSACTION_CONFLICT      = 1054;
    int SET_DATABASE_UNIQUE_NAME               = 1055;
    int SET_DATABASE_PASSWORD_DIGEST           = 1056;

    // hsqldb user settings
    int SET_USER_LOCAL          = 1091;
    int SET_USER_INITIAL_SCHEMA = 1092;
    int SET_USER_PASSWORD       = 1093;

    // hsqldb session
    int TRANSACTION_LOCK_CATALOG       = 1111;
    int TRANSACTION_UNLOCK_CATALOG     = 1112;
    int TRANSACTION_LOCK_TABLE         = 1113;
    int SET_SESSION_AUTOCOMMIT         = 1114;
    int SET_SESSION_FEATURE            = 1115;
    int SET_SESSION_RESULT_MAX_ROWS    = 1116;
    int SET_SESSION_RESULT_MEMORY_ROWS = 1117;
    int ROLLBACK_SAVEPOINT             = 1118;
    int DECLARE_SESSION_TABLE          = 1119;

    // hsqldb schema
    int ALTER_INDEX                  = 1121;
    int ALTER_VIEW                   = 1122;
    int COMMENT                      = 1123;
    int CREATE_ALIAS                 = 1124;
    int CREATE_INDEX                 = 1125;
    int CREATE_USER                  = 1126;
    int DECLARE_VARIABLE             = 1127;
    int DROP_COLUMN                  = 1128;
    int DROP_INDEX                   = 1129;
    int DROP_CONSTRAINT              = 1130;
    int DROP_USER                    = 1131;
    int DROP_DEFAULT                 = 1132;
    int ADD_COLUMN                   = 1133;
    int ADD_CONSTRAINT               = 1134;
    int ADD_DEFAULT                  = 1135;
    int ALTER_COLUMN_TYPE            = 1136;
    int ALTER_COLUMN_SEQUENCE        = 1137;
    int ALTER_COLUMN_NULL            = 1139;
    int ALTER_COLUMN_DEFAULT         = 1140;
    int ALTER_COLUMN_DROP_DEFAULT    = 1141;
    int ALTER_COLUMN_DROP_EXPRESSION = 1142;
    int ALTER_COLUMN_DROP_GENERATED  = 1143;
    int ALTER_COLUMN_TYPE_IDENTITY   = 1144;

    //
    int CREATE_REFERENCE = 1146;
    int DROP_REFERENCE   = 1147;

    //
    int EXPLAIN_PLAN             = 1151;
    int RENAME_OBJECT            = 1152;
    int SET_TABLE_INDEX          = 1153;
    int SET_TABLE_READONLY       = 1154;
    int SET_TABLE_SOURCE         = 1155;
    int SET_TABLE_SOURCE_HEADER  = 1156;
    int SET_TABLE_TYPE           = 1157;
    int SET_TABLE_CLUSTERED      = 1158;
    int SET_TABLE_NEW_TABLESPACE = 1159;
    int SET_TABLE_SET_TABLESPACE = 1160;
    int LOG_SCHEMA_STATEMENT     = 1161;

    // hsqldb sql implementation
    int CONDITION = 1211;                         // element of IF
    int HANDLER   = 1212;
    int DDL       = 1213;
    int CHECK     = 1214;
    int TRUNCATE  = 1215;

    //
    int CREATE_SEARCH = 1301;
    int DROP_SEARCH   = 1302;

    //
    // hsqldb groups
    int X_SQL_SCHEMA_DEFINITION      = 2001;
    int X_SQL_SCHEMA_MANIPULATION    = 2002;
    int X_SQL_DATA                   = 2003;
    int X_SQL_DATA_CHANGE            = 2004;
    int X_SQL_TRANSACTION            = 2005;
    int X_SQL_CONNECTION             = 2006;
    int X_SQL_CONTROL                = 2007;
    int X_SQL_SESSION                = 2008;
    int X_SQL_DIAGNOSTICS            = 2009;
    int X_SQL_DYNAMIC                = 2010;
    int X_HSQLDB_SESSION             = 2011;
    int X_HSQLDB_SCHEMA_MANIPULATION = 2012;
    int X_HSQLDB_SETTING             = 2013;
    int X_HSQLDB_DATABASE_OPERATION  = 2014;
    int X_HSQLDB_NONBLOCK_OPERATION  = 2015;
    int X_HSQLDB_TRANSACTION         = 2016;
    int X_DYNAMIC                    = 2017;

    // Expected types of Result returned for an SQL statement
    int RETURN_ANY    = 0;
    int RETURN_COUNT  = 1;
    int RETURN_RESULT = 2;
}
