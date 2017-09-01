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

import java.io.BufferedOutputStream;
import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.Socket;
import java.nio.ByteBuffer;
import java.nio.charset.Charset;
import java.nio.charset.CharsetDecoder;

import org.hsqldb.DatabaseManager;
import org.hsqldb.HsqlException;
import org.hsqldb.Session;
import org.hsqldb.error.Error;
import org.hsqldb.error.ErrorCode;
import org.hsqldb.lib.ArrayUtil;
import org.hsqldb.lib.DataOutputStream;
import org.hsqldb.lib.HsqlByteArrayOutputStream;
import org.hsqldb.lib.InOutUtil;
import org.hsqldb.persist.HsqlDatabaseProperties;
import org.hsqldb.resources.ResourceBundleHandler;
import org.hsqldb.result.Result;
import org.hsqldb.result.ResultConstants;
import org.hsqldb.rowio.RowInputBinary;
import org.hsqldb.rowio.RowOutputBinary;

// fredt@users 20021002 - patch 1.7.1 - changed notification method
// unsaved@users 20021113 - patch 1.7.2 - SSL support
// boucherb@users 20030510 - patch 1.7.2 - SSL support moved to factory interface
// boucherb@users 20030510 - patch 1.7.2 - general lint removal
// boucherb@users 20030514 - patch 1.7.2 - localized error responses
// fredt@users 20030628 - patch 1.7.2 - new protocol, persistent sessions

/**
 *  A web server connection is a transient object that lasts for the duration
 *  of the SQL call and its result. This class uses the notification
 *  mechanism in WebServer to allow cleanup after a SHUTDOWN.<p>
 *
 *  The POST method is used for login  and subsequent remote calls. In 1.7.2
 *  The initial login establishes a persistent Session and returns its handle
 *  to the client. Subsequent calls are executed in the context of this
 *  session.<p>
 *  (fredt@users)
 *
 * @author Fred Toussi (fredt@users dot sourceforge.net)
 * @version 2.3.4
 * @since 1.6.2
 */
class WebServerConnection implements Runnable {

    static final String         ENCODING           = "ISO-8859-1";
    private Charset             iso                = Charset.forName(ENCODING);
    private CharsetDecoder      iso_8859_1_decoder = iso.newDecoder();
    private Socket              socket;
    private WebServer           server;
    private static final int    REQUEST_TYPE_BAD  = 0;
    private static final int    REQUEST_TYPE_GET  = 1;
    private static final int    REQUEST_TYPE_HEAD = 2;
    private static final int    REQUEST_TYPE_POST = 3;
    private static final String HEADER_OK         = "HTTP/1.0 200 OK";
    private static final String HEADER_BAD_REQUEST =
        "HTTP/1.0 400 Bad Request";
    private static final String HEADER_NOT_FOUND = "HTTP/1.0 404 Not Found";
    private static final String HEADER_FORBIDDEN = "HTTP/1.0 403 Forbidden";
    static final int            BUFFER_SIZE      = 256;
    final byte[]                mainBuffer       = new byte[BUFFER_SIZE];
    private RowOutputBinary     rowOut = new RowOutputBinary(mainBuffer);
    private RowInputBinary      rowIn            = new RowInputBinary(rowOut);

    //
    static byte[] BYTES_GET;
    static byte[] BYTES_HEAD;
    static byte[] BYTES_POST;
    static byte[] BYTES_CONTENT;

    static {
        try {
            BYTES_GET     = "GET".getBytes("ISO-8859-1");
            BYTES_HEAD    = "HEAD".getBytes("ISO-8859-1");
            BYTES_POST    = "POST".getBytes("ISO-8859-1");
            BYTES_CONTENT = "Content-Length: ".getBytes("ISO-8859-1");
        } catch (UnsupportedEncodingException e) {
            throw Error.runtimeError(ErrorCode.U_S0500, "RowOutputTextLog");
        }
    }

    static final byte[] BYTES_WHITESPACE = new byte[] {
        (byte) ' ', (byte) '\t'
    };

    // default mime type mappings
    private static final int hnd_content_types =
        ResourceBundleHandler.getBundleHandle("webserver-content-types", null);

    /**
     * Creates a new WebServerConnection to the specified WebServer on the
     * specified socket.
     *
     * @param socket the network socket on which WebServer communication
     *      takes place
     * @param server the WebServer instance to which the object
     *      represents a connection
     */
    WebServerConnection(Socket socket, WebServer server) {
        this.server = server;
        this.socket = socket;
    }

    /**
     * Retrieves a best-guess mime-type string using the file extension
     * of the name argument.
     *
     * @return a best-guess mime-type string using the file extension
     *      of the name argument.
     */
    private String getMimeTypeString(String name) {

        int    pos;
        String key;
        String mimeType;

        if (name == null) {
            return ServerConstants.SC_DEFAULT_WEB_MIME;
        }

        pos      = name.lastIndexOf('.');
        key      = null;
        mimeType = null;

        // first search user-specified mapping
        if (pos >= 0) {
            key      = name.substring(pos).toLowerCase();
            mimeType = server.serverProperties.getProperty(key);
        }

        // if not found, search default mapping
        if (mimeType == null && key.length() > 1) {
            mimeType = ResourceBundleHandler.getString(hnd_content_types,
                    key.substring(1));
        }

        return mimeType == null ? ServerConstants.SC_DEFAULT_WEB_MIME
                                : mimeType;
    }

    /**
     * Causes this WebServerConnection to process its HTTP request
     * in a blocking fashion until the request is fully processed
     * or an exception occurs internally.
     *
     * This method reads the Request line then delegates action to subroutines.
     */
    public void run() {

        DataInputStream inStream = null;

        try {
            inStream = new DataInputStream(socket.getInputStream());

            int    count;
            String name   = null;
            int    method = REQUEST_TYPE_BAD;

            // read line, ignoring any leading blank lines (there shouldn't be any, but just to be safe)
            do {
                count = InOutUtil.readLine(inStream, rowOut);

                if (count == 0) {
                    throw new Exception();
                }
            } while (count < 2);

            byte[] byteArray = rowOut.toByteArray();
            int    offset    = rowOut.size() - count;

            if (ArrayUtil.containsAt(byteArray, offset, BYTES_POST)) {
                method = REQUEST_TYPE_POST;
                offset += BYTES_POST.length;
            } else if (ArrayUtil.containsAt(byteArray, offset, BYTES_GET)) {
                method = REQUEST_TYPE_GET;
                offset += BYTES_GET.length;
            } else if (ArrayUtil.containsAt(byteArray, offset, BYTES_HEAD)) {
                method = REQUEST_TYPE_HEAD;
                offset += BYTES_HEAD.length;
            } else {
                method = REQUEST_TYPE_BAD;
            }

            count = ArrayUtil.countStartElementsAt(byteArray, offset,
                                                   BYTES_WHITESPACE);

            if (count == 0) {
                method = REQUEST_TYPE_BAD;
            }

            offset += count;
            count = ArrayUtil.countNonStartElementsAt(byteArray, offset,
                    BYTES_WHITESPACE);
            name = new String(byteArray, offset, count, ENCODING);

            switch (method) {

                case REQUEST_TYPE_POST :
                    processPost(inStream, name);
                    break;

                case REQUEST_TYPE_BAD :
                    processError(REQUEST_TYPE_BAD);
                    break;

                case REQUEST_TYPE_GET :
                    processGet(name, true);
                    break;

                case REQUEST_TYPE_HEAD :
                    processGet(name, false);
                    break;
            }
        } catch (Exception e) {
            server.printStackTrace(e);
        } finally {
            try {
                if (inStream != null) {
                    inStream.close();
                }

                socket.close();
            } catch (IOException ioe) {
                server.printStackTrace(ioe);
            }
        }
    }

    /**
     * POST is used only for database access. So we can assume the strings
     * are those generated by ClientConnectionHTTP
     */
    private void processPost(InputStream inStream,
                             String name) throws IOException {

        try {

            // In run() the first line of the requestHeader was already read into rowOut (for a POST
            // this looks something like: 'POST /<some-path> HTTP/1.1')
            //
            // Now let's read the rest of the requestHeader until (including) the blank line that
            // denotes the end of the requestHeader block (We can not assume a fixed number of
            // lines since proxy's might add stuff, nor should we assume a certain order of the
            // requestHeader lines)
            int readLineLength;

            do {
                readLineLength = InOutUtil.readLine(inStream, rowOut);
            } while (readLineLength > 2);    // Blank line is usually 2 bytes ('\r\n')

            // rowOut now contains the entire requestHeader as bytes. It is converted here
            // into a java String, so that we can easily do some error checking on it and
            //  inspect it during debugging
            String requestHeader = iso_8859_1_decoder.decode(
                ByteBuffer.wrap(rowOut.toByteArray())).toString();

// System.out.println(requestHeader); //For debugging
            // Throw an error if the Content-Type is something other than an what
            // ClientConnectionHTTP is supposed to send
            if (requestHeader.indexOf("Content-Type: application/octet-stream")
                    < 0) {
                throw new Exception();
            }

            //TODO: Determine presence of Keep-Alive in requestHeader and act upon it accordingly.
            // if (requestHeader.indexOf("Connection: keep-alive") >= 0) { }
        } catch (Exception e) {
            processError(HttpURLConnection.HTTP_BAD_REQUEST);

            return;
        }

        // inStream's read-pointer will now be positioned at the beginning of the request's pay-load
        processQuery(inStream);
    }

    /**
     * Processes a database query in HSQL protocol that has been
     * tunneled over HTTP protocol.
     *
     * @param inStream the incoming byte stream representing the HSQL protocol
     *      database query
     */
    void processQuery(InputStream inStream) {

        try {
            DataInputStream dataIn     = new DataInputStream(inStream);
            int             databaseID = dataIn.readInt();
            long            sessionID  = dataIn.readLong();
            int             mode       = dataIn.readByte();
            Session session = DatabaseManager.getSession(databaseID,
                sessionID);
            Result resultIn = Result.newResult(session, mode, dataIn, rowIn);

            resultIn.setDatabaseId(databaseID);
            resultIn.setSessionId(sessionID);

            //
            Result resultOut;
            int    type = resultIn.getType();

            if (type == ResultConstants.CONNECT) {
                try {
                    String databaseName = resultIn.getDatabaseName();
                    int    dbIndex      = server.getDBIndex(databaseName);
                    int    dbID         = server.dbID[dbIndex];

                    session =
                        DatabaseManager.newSession(dbID,
                                                   resultIn.getMainString(),
                                                   resultIn.getSubString(),
                                                   resultIn.getZoneString(),
                                                   resultIn.getUpdateCount());
                    resultOut =
                        Result.newConnectionAcknowledgeResponse(session);
                } catch (HsqlException e) {
                    resultOut = Result.newErrorResult(e);
                } catch (RuntimeException e) {
                    resultOut = Result.newErrorResult(e);
                }
            } else {
                if (session == null) {
                    resultOut = Result.newErrorResult(
                        Error.error(ErrorCode.SERVER_DATABASE_DISCONNECTED));
                } else {
                    resultIn.setSession(session);
                    resultIn.readLobResults(session, dataIn, rowIn);

                    if (type == ResultConstants.SQLCANCEL) {
                        resultOut = session.cancel(resultIn);
                    } else {
                        resultOut = session.execute(resultIn);
                    }
                }
            }

// patched 2.2.9 by Aart 2012-05-15: Make sure 'Content-length' is correctly set
            if (type == ResultConstants.DISCONNECT
                    || type == ResultConstants.RESETSESSION) {
                DataOutputStream dataOut =
                    new DataOutputStream(socket.getOutputStream());

                // Upon DISCONNECT 6 bytes are read by the ClientConnectionHTTP": mode (1 byte), a length (int), and an 'additional results (1 byte)
                String header = getHead(HEADER_OK, false,
                                        "application/octet-stream", 6);

                dataOut.write(header.getBytes(ENCODING));
                dataOut.writeByte(ResultConstants.DISCONNECT);    // Mode
                dataOut.writeInt(4);                              //Length Int of first result is always read! Minvalue is 4: It is the number of bytes of the current result (it includes the length of this Int itself)
                dataOut.writeByte(ResultConstants.NONE);          // No Additional results
                dataOut.close();

                return;
            }

            // TODO: when doing Keep-Alive connections, try to retain buffer
            HsqlByteArrayOutputStream memStream =
                new HsqlByteArrayOutputStream();
            DataOutputStream tempOutput = new DataOutputStream(memStream);

            resultOut.write(session, tempOutput, rowOut);

            DataOutputStream dataOut =
                new DataOutputStream(socket.getOutputStream());

            // Write HTTP response header
            String header = getHead(HEADER_OK, false,
                                    "application/octet-stream",
                                    memStream.size());

            dataOut.write(header.getBytes(ENCODING));

            // Write actual pay-load to response
            memStream.writeTo(dataOut);
            dataOut.close();

// patch-end 2.2.9 by Aart 2012-05-15
        } catch (IOException e) {
            server.printStackTrace(e);
        }
    }

    /**
     *  Processes an HTTP GET request
     *
     * @param  name the name of the content to get
     * @param  send whether to send the content as well, or just the header
     */
    private void processGet(String name, boolean send) {

        try {
            String       hdr;
            OutputStream os;
            InputStream  is;
            int          b;

            if (name.endsWith("/")) {
                name += server.getDefaultWebPage();
            }

            // traversing up the directory structure is forbidden.
            if (name.indexOf("..") != -1) {
                processError(HttpURLConnection.HTTP_FORBIDDEN);

                return;
            }

            name = server.getWebRoot() + name;

            if (File.separatorChar != '/') {
                name = name.replace('/', File.separatorChar);
            }

            is = null;

            server.printWithThread("GET " + name);

            try {
                File file = new File(name);

                is = new DataInputStream(new FileInputStream(file));
                hdr = getHead(HEADER_OK, true, getMimeTypeString(name),
                              (int) file.length());
            } catch (IOException e) {
                processError(HttpURLConnection.HTTP_NOT_FOUND);

                if (is != null) {
                    is.close();
                }

                return;
            }

            os = new BufferedOutputStream(socket.getOutputStream());

            os.write(hdr.getBytes(ENCODING));

            if (send) {
                while ((b = is.read()) != -1) {
                    os.write(b);
                }
            }

            os.flush();
            os.close();
            is.close();
        } catch (Exception e) {
            server.printError("processGet: " + e.toString());
            server.printStackTrace(e);
        }
    }

    /**
     * Retrieves an HTTP protocol header given the supplied arguments.
     *
     * @param responseCodeString the HTTP response code
     * @param addInfo true if additional header info is to be added
     * @param mimeType the Content-Type field value
     * @param length the Content-Length field value
     * @return an HTTP protocol header
     */
    String getHead(String responseCodeString, boolean addInfo,
                   String mimeType, int length) {

        StringBuffer sb = new StringBuffer(128);

        sb.append(responseCodeString).append("\r\n");

        if (addInfo) {
            sb.append("Allow: GET, HEAD, POST\nMIME-Version: 1.0\r\n");
            sb.append("Server: ").append(
                HsqlDatabaseProperties.PRODUCT_NAME).append("\r\n");
        }

        if (mimeType != null) {
            sb.append("Cache-Control: no-cache\r\n");    // DB-traffic should not be cached by proxy's
            sb.append("Content-Type: ").append(mimeType).append("\r\n");

            //sb.append("Content-Length: ").append(length).append("\r\n");
        }

        sb.append("\r\n");

        return sb.toString();
    }

    /**
     *  Processes an HTTP error condition, sending an error response to
     *  the client.
     *
     * @param code the error condition code
     */
    private void processError(int code) {

        String msg;

        server.printWithThread("processError " + code);

        switch (code) {

            case HttpURLConnection.HTTP_BAD_REQUEST :
                msg = getHead(HEADER_BAD_REQUEST, false, null, 0);
                msg += ResourceBundleHandler.getString(
                    WebServer.webBundleHandle, "BAD_REQUEST");
                break;

            case HttpURLConnection.HTTP_FORBIDDEN :
                msg = getHead(HEADER_FORBIDDEN, false, null, 0);
                msg += ResourceBundleHandler.getString(
                    WebServer.webBundleHandle, "FORBIDDEN");
                break;

            case HttpURLConnection.HTTP_NOT_FOUND :
            default :
                msg = getHead(HEADER_NOT_FOUND, false, null, 0);
                msg += ResourceBundleHandler.getString(
                    WebServer.webBundleHandle, "NOT_FOUND");
                break;
        }

        try {
            OutputStream os =
                new BufferedOutputStream(socket.getOutputStream());

            os.write(msg.getBytes(ENCODING));
            os.flush();
            os.close();
        } catch (Exception e) {
            server.printError("processError: " + e.toString());
            server.printStackTrace(e);
        }
    }

    /**
     * Retrieves the thread name to be used  when
     * this object is the Runnable object of a Thread.
     *
     * @return the thread name to be used  when
     *      this object is the Runnable object of a Thread.
     */
    String getConnectionThreadName() {
        return "HSQLDB HTTP Connection @" + Integer.toString(hashCode(), 16);
    }
}
