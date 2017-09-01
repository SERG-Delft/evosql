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

import java.io.BufferedInputStream;
import java.io.DataInputStream;
import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;

import org.hsqldb.lib.DataOutputStream;
import org.hsqldb.lib.HsqlByteArrayOutputStream;
import org.hsqldb.result.Result;

/**
 * HTTP protocol session proxy implementation. Uses the updated HSQLDB HTTP sub
 * protocol.
 *
 * @author Fred Toussi (fredt@users dot sourceforge.net)
 * @version 2.3.4
 * @since 1.7.2
 */
public class ClientConnectionHTTP extends ClientConnection {

    static final String ENCODING = "ISO-8859-1";
    static final int    IDLENGTH = 12;    // length of int + long for db and session

    // IDs
    private HttpURLConnection httpConnection = null;

    public ClientConnectionHTTP(String host, int port, String path,
                                String database, boolean isTLS,
                                boolean isTLSWrapper, String user,
                                String password, int timeZoneSeconds) {
        super(host, port, path, database, isTLS, isTLSWrapper, user, password,
              timeZoneSeconds);
    }

    public ClientConnectionHTTP(ClientConnectionHTTP other) {
        super(other);
    }

    // Empty since HTTP has an empty handshake() method. execute() will open connection
    // when it needs to
    protected void initConnection(String host, int port, boolean isTLS) {}

    /**
     * This just opens (a new or re-uses a connection) Keep-Alive.
     *
     * Contrary to before, the dataOutput and dataInput are not connected to the
     * connection's Output- and Input-Streams here, because when connecting to
     * the input stream here, somehow rules out writing to the output stream.
     */
    protected void openConnection(String host, int port, boolean isTLS) {

        try {
            URL    url = null;
            String s   = "";

            if (!path.endsWith("/")) {
                s = "/";
            }

            s = "http://" + host + ":" + port + path + s + database;

            if (isTLS) {
                url = new URL("https://" + host + ":" + port + path + s
                              + database);    // PROTECT/servlet/hsqldb
            } else {
                url = new URL(s);             // PROTECT/servlet/hsqldb
            }

            httpConnection = (HttpURLConnection) url.openConnection();

            httpConnection.setDefaultUseCaches(false);
        } catch (IOException e) {
            e.printStackTrace(System.out);
        }
    }

    protected void closeConnection() {

        //httpConnection.disconnect();
    }                                         // In Keep-Alive scenario, this is empty

    public synchronized Result execute(Result r) {

        openConnection(host, port, isTLS);

        Result result = super.execute(r);

        closeConnection();

        return result;
    }

    public Result cancel(Result result) {

        ClientConnectionHTTP connection = new ClientConnectionHTTP(this);

        result.setSessionRandomID(randomID);

        return connection.execute(result);
    }

    protected void write(Result r) throws IOException, HsqlException {

        HsqlByteArrayOutputStream memStream  = new HsqlByteArrayOutputStream();
        DataOutputStream          tempOutput = new DataOutputStream(memStream);

        r.write(this, tempOutput, rowOut);
        httpConnection.setRequestMethod("POST");
        httpConnection.setDoOutput(true);
        httpConnection.setUseCaches(false);

        //httpConnection.setRequestProperty("Accept-Encoding", "gzip");
        httpConnection.setRequestProperty("Content-Type",
                                          "application/octet-stream");
        httpConnection.setRequestProperty("Content-Length",
                                          String.valueOf(IDLENGTH
                                              + memStream.size()));

        dataOutput = new DataOutputStream(httpConnection.getOutputStream());

        dataOutput.writeInt(r.getDatabaseId());
        dataOutput.writeLong(r.getSessionId());
        memStream.writeTo(dataOutput);
        dataOutput.flush();
    }

    protected Result read() throws IOException, HsqlException {

        dataInput = new DataInputStream(
            new BufferedInputStream(httpConnection.getInputStream()));

        rowOut.reset();

        Result result = Result.newResult(dataInput, rowIn);

        result.readAdditionalResults(this, dataInput, rowIn);
        dataInput.close();    // Added to ensure connection is returned to Java

        // engine for transparent re-use of Keep-alive
        // connections (Aart)
        return result;
    }

    protected void handshake() throws IOException {

        // We depend on the HTTP wrappings to assure end-to-end handshaking
    }
}
