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

import org.hsqldb.HsqlNameManager.HsqlName;
import org.hsqldb.error.Error;
import org.hsqldb.error.ErrorCode;
import org.hsqldb.lib.OrderedHashSet;
import org.hsqldb.result.Result;

/**
 * Implementation of Statement for simple PSM control statements.
 *
 * @author Fred Toussi (fredt@users dot sourceforge.net)
 * @version 2.3.3
 * @since 1.9.0
 */
public class StatementSimple extends Statement {

    HsqlName label;

    StatementSimple(int type, HsqlName label) {

        super(type, StatementTypes.X_SQL_CONTROL);

        references             = new OrderedHashSet();
        isTransactionStatement = false;
        this.label             = label;
    }

    public String getSQL() {

        StringBuffer sb = new StringBuffer();

        switch (type) {

            case StatementTypes.ITERATE :
                sb.append(Tokens.T_ITERATE).append(' ').append(label);
                break;

            case StatementTypes.LEAVE :
                sb.append(Tokens.T_LEAVE).append(' ').append(label);
                break;
        }

        return sb.toString();
    }

    protected String describe(Session session, int blanks) {

        StringBuffer sb = new StringBuffer();

        sb.append('\n');

        for (int i = 0; i < blanks; i++) {
            sb.append(' ');
        }

        sb.append(Tokens.T_STATEMENT);

        return sb.toString();
    }

    public Result execute(Session session) {

        Result result;

        try {
            result = getResult(session);
        } catch (Throwable t) {
            result = Result.newErrorResult(t);
        }

        if (result.isError()) {
            result.getException().setStatementType(group, type);
        }

        return result;
    }

    Result getResult(Session session) {

        switch (type) {

            case StatementTypes.ITERATE :
            case StatementTypes.LEAVE :
                return Result.newPSMResult(type, label.name, null);

            default :
                throw Error.runtimeError(ErrorCode.U_S0500, "StatementSimple");
        }
    }

    public void resolve(Session session) {

        boolean resolved = false;

        switch (type) {

            case StatementTypes.ITERATE : {
                StatementCompound statement = parent;

                while (statement != null) {
                    if (statement.isLoop) {
                        if (label == null) {
                            resolved = true;

                            break;
                        }

                        if (statement.label != null
                                && label.name.equals(statement.label.name)) {
                            resolved = true;

                            break;
                        }
                    }

                    statement = statement.parent;
                }

                break;
            }
            case StatementTypes.LEAVE :
                resolved = true;
                break;

            default :
                throw Error.runtimeError(ErrorCode.U_S0500, "StatementSimple");
        }

        if (!resolved) {
            throw Error.error(ErrorCode.X_42602);
        }
    }

    public String describe(Session session) {
        return "";
    }

    public boolean isCatalogLock() {
        return false;
    }

    public boolean isCatalogChange() {
        return false;
    }
}
