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

import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.hsqldb.Session;
import org.hsqldb.result.Result;
import org.hsqldb.result.ResultConstants;
import org.hsqldb.result.ResultProperties;

class OdbcPreparedStatement {

    public String  handle, query;
    public Result  ackResult;
    public Session session;
    private Map    containingMap;
    private List   portals = new ArrayList();

    protected OdbcPreparedStatement(OdbcPreparedStatement other) {
        this.handle    = other.handle;
        this.ackResult = other.ackResult;
    }

    /**
     * Instantiates an proxy OdbcPreparedStatement object for the
     * Connection Session, and adds the new instance to the specified map.
     */
    public OdbcPreparedStatement(String handle, String query,
                                 Map containingMap,
                                 Session session)
                                 throws RecoverableOdbcFailure {

        this.handle        = handle;
        this.query         = query;
        this.containingMap = containingMap;
        this.session       = session;

        Result psResult = Result.newPrepareStatementRequest();

        psResult.setPrepareOrExecuteProperties(
            query, 0, 0, 0, 0,ResultProperties.defaultPropsValue,
            Statement.NO_GENERATED_KEYS, null, null);

        ackResult = session.execute(psResult);

        switch (ackResult.getType()) {

            case ResultConstants.PREPARE_ACK :
                break;

            case ResultConstants.ERROR :
                throw new RecoverableOdbcFailure(ackResult);
            default :
                throw new RecoverableOdbcFailure(
                    "Output Result from Statement prep is of "
                    + "unexpected type: " + ackResult.getType());
        }

        containingMap.put(handle, this);
    }

    /**
     * Releases resources for this instance and all associated StatementPortals,
     * and removes this instance from the containing map.
     */
    public void close() {

        // TODO:  Free up resources!
        containingMap.remove(handle);

        while (portals.size() > 0) {
            ((StatementPortal) portals.remove(1)).close();
        }
    }

    /**
     * Associates an StatementPortal with OdbcPreparedStatement.
     */
    public void addPortal(StatementPortal portal) {
        portals.add(portal);
    }
}
