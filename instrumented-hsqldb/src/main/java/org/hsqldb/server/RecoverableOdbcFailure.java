/* Copyright (c) 2001-2011, The HSQL Development Group
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

import org.hsqldb.result.Result;

class RecoverableOdbcFailure extends Exception {
    private String clientMessage = null;
    private String sqlStateCode = null;
    private Result errorResult = null;
    public String getSqlStateCode() {
        return sqlStateCode;
    }
    public Result getErrorResult() {
        return errorResult;
    }
    public RecoverableOdbcFailure(Result errorResult) {
        this.errorResult = errorResult;
    }
    /**
     * This constructor purposefully means that both server-side and
     * client-side message will be set to the specified message.
     */
    public RecoverableOdbcFailure(String m) {
        super(m);
        clientMessage = m;
    }
    /**
     * This constructor purposefully means that both server-side and
     * client-side message will be set to the specified message.
     * <P><B>
     * Note:  The parameters DO NOT SPECIFY server-side and client-side
     * messages.  Use the 3-parameter constructor for that.
     * </B></P>
     *
     * @see #RecoverableOdbcFailure(String, String, String)
     */
    public RecoverableOdbcFailure(String m, String sqlStateCode) {
        this(m);
        this.sqlStateCode = sqlStateCode;
    }
    /**
     * Set any parameter to null to skip the specified reporting.
     */
    public RecoverableOdbcFailure(
    String ourMessage, String clientMessage, String sqlStateCode) {
        super(ourMessage);
        this.clientMessage = clientMessage;
        this.sqlStateCode = sqlStateCode;
    }
    public String getClientMessage() {
        return clientMessage;
    }
}
