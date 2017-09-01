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


package org.hsqldb.server;

import java.util.Map;

import org.hsqldb.Session;
import org.hsqldb.result.Result;
import org.hsqldb.result.ResultConstants;
import org.hsqldb.result.ResultMetaData;
import org.hsqldb.types.Type;

class StatementPortal {

    public Object[] parameters;
    public Result   bindResult, ackResult;
    public String   lcQuery;
    public String   handle;
    private Map     containingMap;
    private Session session;

    /**
     * Convenience wrapper for the 3-param constructor.
     *
     * @see #StatementPortal(String, OdbcPreparedStatement, Object[], Map)
     */
    public StatementPortal(String handle, OdbcPreparedStatement odbcPs,
                           Map containingMap) throws RecoverableOdbcFailure {
        this(handle, odbcPs, new Object[0], containingMap);
    }

    /**
     * Instantiates a proxy ODBC StatementPortal object for the
     * Connection Session, and adds the new instance to the specified map.
     *
     * @param paramObjs Param values are either String or BinaryData instances
     */
    public StatementPortal(String handle, OdbcPreparedStatement odbcPs,
                           Object[] paramObjs,
                           Map containingMap) throws RecoverableOdbcFailure {

        this.handle        = handle;
        lcQuery            = odbcPs.query.toLowerCase();
        ackResult          = odbcPs.ackResult;
        session            = odbcPs.session;
        this.containingMap = containingMap;

        Type[] paramTypes = Type.emptyArray;

        switch (ackResult.getType()) {

            case ResultConstants.PREPARE_ACK :
                break;

            case ResultConstants.ERROR :
                throw new RecoverableOdbcFailure(ackResult);
            default :
                throw new RecoverableOdbcFailure(
                    "Output Result from secondary Statement prep is of "
                    + "unexpected type: " + ackResult.getType());
        }

        if (paramObjs.length < 1) {
            parameters = new Object[0];
        } else {
            ResultMetaData pmd = odbcPs.ackResult.parameterMetaData;

            if (pmd == null) {
                throw new RecoverableOdbcFailure("No metadata for Result ack");
            }

            paramTypes = pmd.getParameterTypes();

            if (paramTypes.length != paramObjs.length) {
                throw new RecoverableOdbcFailure(
                    null,
                    "Client didn't specify all " + paramTypes.length
                    + " parameters (" + paramObjs.length + ')', "08P01");
            }

            parameters = new Object[paramObjs.length];

            try {
                for (int i = 0; i < parameters.length; i++) {
                    parameters[i] = (paramObjs[i] instanceof String)
                                    ? PgType.getPgType(
                                        paramTypes[i], true).getParameter(
                                        (String) paramObjs[i], session)
                                    : paramObjs[i];
                }
            } catch (java.sql.SQLException se) {
                throw new RecoverableOdbcFailure("Typing failure: " + se);
            }
        }

        bindResult = Result.newPreparedExecuteRequest(paramTypes,
                odbcPs.ackResult.getStatementID());

        containingMap.put(handle, this);
    }

    /**
     * Releases resources for this instance
     * and removes this instance from the containing map.
     */
    public void close() {

        // TODO:  Free up resources!
        containingMap.remove(handle);
    }
}
