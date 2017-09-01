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
import java.io.InputStream;
import java.net.Socket;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.Locale;
import java.util.TimeZone;

import org.hsqldb.error.Error;
import org.hsqldb.error.ErrorCode;
import org.hsqldb.jdbc.JDBCConnection;
import org.hsqldb.lib.DataOutputStream;
import org.hsqldb.map.ValuePool;
import org.hsqldb.navigator.RowSetNavigatorClient;
import org.hsqldb.persist.HsqlProperties;
import org.hsqldb.result.Result;
import org.hsqldb.result.ResultConstants;
import org.hsqldb.result.ResultLob;
import org.hsqldb.rowio.RowInputBinary;
import org.hsqldb.rowio.RowOutputBinary;
import org.hsqldb.rowio.RowOutputInterface;
import org.hsqldb.server.HsqlSocketFactory;
import org.hsqldb.types.BlobDataID;
import org.hsqldb.types.ClobDataID;
import org.hsqldb.types.TimestampData;

/**
 * Base remote session proxy implementation. Uses instances of Result to
 * transmit and receive data. This implementation utilises the updated HSQL
 * protocol.
 *
 * @author Fred Toussi (fredt@users dot sourceforge.net)
 * @version 2.3.4
 * @since 1.7.2
 */
public class ClientConnection implements SessionInterface, Cloneable {

    /**
     * Specifies the Compatibility version required for both Servers and
     * network JDBC Clients built with this baseline.  Must remain public
     * for Server to have visibility to it.
     *
     * Update this value only when the current version of HSQLDB does not
     * have inter-compatibility with Server and network JDBC Driver of
     * the previous HSQLDB version.
     *
     * Must specify all 4 version segments (any segment may be the value 0,
     * however). The string elements at (position p from right counted from 0)
     * are multiplied by 100 to power p and added up, then negated, to form the
     * integer representation of version string.
     */
    public static final String NETWORK_COMPATIBILITY_VERSION     = "2.3.4.0";
    public static final int    NETWORK_COMPATIBILITY_VERSION_INT = -2030400;

    //
    static final int             BUFFER_SIZE = 0x1000;
    final byte[]                 mainBuffer  = new byte[BUFFER_SIZE];
    private boolean              isClosed;
    private Socket               socket;
    protected DataOutputStream   dataOutput;
    protected DataInputStream    dataInput;
    protected RowOutputInterface rowOut;
    protected RowInputBinary     rowIn;
    private Result               resultOut;
    private long                 sessionID;
    private long                 lobIDSequence = -1;
    protected int                randomID;

    //
    private boolean  isReadOnlyDefault = false;
    private boolean  isAutoCommit      = true;
    private int      zoneSeconds;
    private Scanner  scanner;
    private String   zoneString;
    private Calendar calendar;
    private Calendar calendarGMT;
    SimpleDateFormat simpleDateFormatGMT;

    //
    JDBCConnection connection;
    String         host;
    int            port;
    String         path;
    String         database;
    boolean        isTLS;
    boolean        isTLSWrapper;
    int            databaseID;
    String         clientPropertiesString;
    HsqlProperties clientProperties;
    String         databaseUniqueName;

    /**
     * Establishes a connection to the server.
     */
    public ClientConnection(String host, int port, String path,
                            String database, boolean isTLS,
                            boolean isTLSWrapper, String user,
                            String password, int timeZoneSeconds) {

        this.host         = host;
        this.port         = port;
        this.path         = path;
        this.database     = database;
        this.isTLS        = isTLS;
        this.isTLSWrapper = isTLSWrapper;
        this.zoneSeconds  = timeZoneSeconds;
        this.zoneString   = TimeZone.getDefault().getID();

        initStructures();
        initConnection(host, port, isTLS);

        Result login = Result.newConnectionAttemptRequest(user, password,
            database, zoneString, timeZoneSeconds);
        Result resultIn = execute(login);

        if (resultIn.isError()) {
            throw Error.error(resultIn);
        }

        sessionID              = resultIn.getSessionId();
        databaseID             = resultIn.getDatabaseId();
        databaseUniqueName     = resultIn.getDatabaseName();
        clientPropertiesString = resultIn.getMainString();
        randomID               = resultIn.getSessionRandomID();
    }

    protected ClientConnection(ClientConnection other) {

        this.host         = other.host;
        this.port         = other.port;
        this.path         = other.path;
        this.database     = other.database;
        this.isTLS        = other.isTLS;
        this.isTLSWrapper = other.isTLSWrapper;
        this.zoneSeconds  = other.zoneSeconds;
        this.zoneString   = other.zoneString;

        //
        this.sessionID              = other.sessionID;
        this.databaseID             = other.databaseID;
        this.databaseUniqueName     = other.databaseUniqueName;
        this.clientPropertiesString = other.clientPropertiesString;
        this.randomID               = other.randomID;

        initStructures();
        initConnection(host, port, isTLS);
    }

    /**
     * resultOut is reused to transmit all remote calls for session management.
     * Here the structure is preset for sending attributes.
     */
    private void initStructures() {

        RowOutputBinary rowOutTemp = new RowOutputBinary(mainBuffer);

        rowOut    = rowOutTemp;
        rowIn     = new RowInputBinary(rowOutTemp);
        resultOut = Result.newSessionAttributesResult();
    }

    protected void initConnection(String host, int port, boolean isTLS) {
        openConnection(host, port, isTLS);
    }

    protected void openConnection(String host, int port, boolean isTLS) {

        try {
            if (isTLSWrapper) {
                socket =
                    HsqlSocketFactory.getInstance(false).createSocket(host,
                                                  port);
            }

            socket = HsqlSocketFactory.getInstance(isTLS).createSocket(socket,
                                                   host, port);

            socket.setTcpNoDelay(true);

            dataOutput = new DataOutputStream(socket.getOutputStream());
            dataInput = new DataInputStream(
                new BufferedInputStream(socket.getInputStream()));

            handshake();
        } catch (Exception e) {

            // The details from "e" should not be thrown away here.  This is
            // very useful info for end users to diagnose the runtime problem.
            throw new HsqlException(e, Error.getStateString(ErrorCode.X_08001),
                                    -ErrorCode.X_08001);
        }
    }

    protected void closeConnection() {

        try {
            if (socket != null) {
                socket.close();
            }
        } catch (Exception e) {}

        socket = null;
    }

    public synchronized Result execute(Result r) {

        if (isClosed) {
            return Result.newErrorResult(Error.error(ErrorCode.X_08503));
        }

        try {
            r.setSessionId(sessionID);
            r.setDatabaseId(databaseID);
            write(r);

            return read();
        } catch (Throwable e) {
            throw Error.error(ErrorCode.X_08006, e.toString());
        }
    }

    public synchronized RowSetNavigatorClient getRows(long navigatorId,
            int offset, int size) {

        try {
            resultOut.setResultType(ResultConstants.REQUESTDATA);
            resultOut.setResultId(navigatorId);
            resultOut.setUpdateCount(offset);
            resultOut.setFetchSize(size);

            Result result = execute(resultOut);

            return (RowSetNavigatorClient) result.getNavigator();
        } catch (Throwable e) {
            throw Error.error(ErrorCode.X_08006, e.toString());
        }
    }

    public synchronized void closeNavigator(long navigatorId) {

        try {
            resultOut.setResultType(ResultConstants.CLOSE_RESULT);
            resultOut.setResultId(navigatorId);
            execute(resultOut);
        } catch (Throwable e) {}
    }

    public synchronized void close() {

        if (isClosed) {
            return;
        }

        try {
            resultOut.setResultType(ResultConstants.DISCONNECT);
            execute(resultOut);
        } catch (Exception e) {}

        try {
            closeConnection();
        } catch (Exception e) {}

        isClosed = true;
    }

    public synchronized Object getAttribute(int id) {

        resultOut.setResultType(ResultConstants.GETSESSIONATTR);
        resultOut.setStatementType(id);

        Result in = execute(resultOut);

        if (in.isError()) {
            throw Error.error(in);
        }

        Object[] data = in.getSingleRowData();

        switch (id) {

            case SessionInterface.INFO_AUTOCOMMIT :
                return data[SessionInterface.INFO_BOOLEAN];

            case SessionInterface.INFO_CONNECTION_READONLY :
                return data[SessionInterface.INFO_BOOLEAN];

            case SessionInterface.INFO_ISOLATION :
                return data[SessionInterface.INFO_INTEGER];

            case SessionInterface.INFO_CATALOG :
                return data[SessionInterface.INFO_VARCHAR];
        }

        return null;
    }

    public synchronized void setAttribute(int id, Object value) {

        resultOut.setResultType(ResultConstants.SETSESSIONATTR);

        Object[] data = resultOut.getSingleRowData();

        data[SessionInterface.INFO_ID] = ValuePool.getInt(id);

        switch (id) {

            case SessionInterface.INFO_AUTOCOMMIT :
            case SessionInterface.INFO_CONNECTION_READONLY :
                data[SessionInterface.INFO_BOOLEAN] = value;
                break;

            case SessionInterface.INFO_ISOLATION :
                data[SessionInterface.INFO_INTEGER] = value;
                break;

            case SessionInterface.INFO_CATALOG :
                data[SessionInterface.INFO_VARCHAR] = value;
                break;

            default :
        }

        Result resultIn = execute(resultOut);

        if (resultIn.isError()) {
            throw Error.error(resultIn);
        }
    }

    public synchronized boolean isReadOnlyDefault() {

        Object info = getAttribute(SessionInterface.INFO_CONNECTION_READONLY);

        isReadOnlyDefault = ((Boolean) info).booleanValue();

        return isReadOnlyDefault;
    }

    public synchronized void setReadOnlyDefault(boolean mode) {

        if (mode != isReadOnlyDefault) {
            setAttribute(SessionInterface.INFO_CONNECTION_READONLY,
                         mode ? Boolean.TRUE
                              : Boolean.FALSE);

            isReadOnlyDefault = mode;
        }
    }

    public synchronized boolean isAutoCommit() {

        Object info = getAttribute(SessionInterface.INFO_AUTOCOMMIT);

        isAutoCommit = ((Boolean) info).booleanValue();

        return isAutoCommit;
    }

    public synchronized void setAutoCommit(boolean mode) {

        if (mode != isAutoCommit) {
            setAttribute(SessionInterface.INFO_AUTOCOMMIT, mode ? Boolean.TRUE
                                                                : Boolean
                                                                .FALSE);

            isAutoCommit = mode;
        }
    }

    public synchronized void setIsolationDefault(int level) {
        setAttribute(SessionInterface.INFO_ISOLATION, ValuePool.getInt(level));
    }

    public synchronized int getIsolation() {

        Object info = getAttribute(SessionInterface.INFO_ISOLATION);

        return ((Integer) info).intValue();
    }

    public synchronized boolean isClosed() {
        return isClosed;
    }

    public Session getSession() {
        return null;
    }

    public synchronized void startPhasedTransaction() {}

    public synchronized void prepareCommit() {

        resultOut.setAsTransactionEndRequest(ResultConstants.PREPARECOMMIT,
                                             null);

        Result in = execute(resultOut);

        if (in.isError()) {
            throw Error.error(in);
        }
    }

    public synchronized void commit(boolean chain) {

        resultOut.setAsTransactionEndRequest(ResultConstants.TX_COMMIT, null);

        Result in = execute(resultOut);

        if (in.isError()) {
            throw Error.error(in);
        }
    }

    public synchronized void rollback(boolean chain) {

        resultOut.setAsTransactionEndRequest(ResultConstants.TX_ROLLBACK,
                                             null);

        Result in = execute(resultOut);

        if (in.isError()) {
            throw Error.error(in);
        }
    }

    public synchronized void rollbackToSavepoint(String name) {

        resultOut.setAsTransactionEndRequest(
            ResultConstants.TX_SAVEPOINT_NAME_ROLLBACK, name);

        Result in = execute(resultOut);

        if (in.isError()) {
            throw Error.error(in);
        }
    }

    public synchronized void savepoint(String name) {

        Result result = Result.newSetSavepointRequest(name);
        Result in     = execute(result);

        if (in.isError()) {
            throw Error.error(in);
        }
    }

    public synchronized void releaseSavepoint(String name) {

        resultOut.setAsTransactionEndRequest(
            ResultConstants.TX_SAVEPOINT_NAME_RELEASE, name);

        Result in = execute(resultOut);

        if (in.isError()) {
            throw Error.error(in);
        }
    }

    public void addWarning(HsqlException warning) {}

    public synchronized long getId() {
        return sessionID;
    }

    /**
     * Used by pooled connections to reset the server-side session to a new
     * one. In case of failure, the connection is closed.
     *
     * When the Connection.close() method is called, a pooled connection calls
     * this method instead of HSQLClientConnection.close(). It can then
     * reuse the HSQLClientConnection object with no further initialisation.
     *
     */
    public synchronized void resetSession() {

        Result login    = Result.newResetSessionRequest();
        Result resultIn = execute(login);

        if (resultIn.isError()) {
            isClosed = true;

            closeConnection();

            throw Error.error(resultIn);
        }

        sessionID  = resultIn.getSessionId();
        databaseID = resultIn.getDatabaseId();
    }

    protected void write(Result r) throws IOException, HsqlException {
        r.write(this, dataOutput, rowOut);
    }

    protected Result read() throws IOException, HsqlException {

        Result result = Result.newResult(dataInput, rowIn);

        result.readAdditionalResults(this, dataInput, rowIn);
        rowOut.reset(mainBuffer);
        rowIn.resetRow(mainBuffer.length);

        return result;
    }

    /**
     * Never called on this class
     */
    public synchronized String getInternalConnectionURL() {
        return null;
    }

    public Result cancel(Result result) {

        ClientConnection connection = new ClientConnection(this);

        try {
            result.setSessionRandomID(randomID);

            return connection.execute(result);
        } finally {
            connection.closeConnection();
        }
    }

    public synchronized long getLobId() {
        return lobIDSequence--;
    }

    public BlobDataID createBlob(long length) {

        BlobDataID blob = new BlobDataID(getLobId());

        return blob;
    }

    public ClobDataID createClob(long length) {

        ClobDataID clob = new ClobDataID(getLobId());

        return clob;
    }

    /**
     * Does nothing here
     */
    public void allocateResultLob(ResultLob resultLob,
                                  InputStream dataInput) {}

    public Scanner getScanner() {

        if (scanner == null) {
            scanner = new Scanner();
        }

        return scanner;
    }

    public Calendar getCalendar() {

        if (calendar == null) {
            TimeZone zone = TimeZone.getTimeZone(zoneString);

            calendar = new GregorianCalendar(zone);
        }

        return calendar;
    }

    public Calendar getCalendarGMT() {

        if (calendarGMT == null) {
            calendarGMT = new GregorianCalendar(TimeZone.getTimeZone("GMT"),
                                                HsqlDateTime.defaultLocale);

            calendarGMT.setLenient(false);
        }

        return calendarGMT;
    }

    public SimpleDateFormat getSimpleDateFormatGMT() {

        if (simpleDateFormatGMT == null) {
            simpleDateFormatGMT = new SimpleDateFormat("MMMM", Locale.ENGLISH);

            Calendar cal = new GregorianCalendar(TimeZone.getTimeZone("GMT"),
                                                 HsqlDateTime.defaultLocale);

            cal.setLenient(false);
            simpleDateFormatGMT.setCalendar(cal);
        }

        return simpleDateFormatGMT;
    }

    public TimestampData getCurrentDate() {

        long currentMillis = System.currentTimeMillis();
        long seconds = HsqlDateTime.getCurrentDateMillis(currentMillis) / 1000;

        return new TimestampData(seconds);
    }

    public int getZoneSeconds() {
        return zoneSeconds;
    }

    public int getStreamBlockSize() {
        return lobStreamBlockSize;
    }

    public HsqlProperties getClientProperties() {

        if (clientProperties == null) {
            if (clientPropertiesString.length() > 0) {
                clientProperties = HsqlProperties.delimitedArgPairsToProps(
                    clientPropertiesString, "=", ";", null);
            } else {
                clientProperties = new HsqlProperties();
            }
        }

        return clientProperties;
    }

    public JDBCConnection getJDBCConnection() {
        return connection;
    }

    public void setJDBCConnection(JDBCConnection connection) {
        this.connection = connection;
    }

    public String getDatabaseUniqueName() {
        return databaseUniqueName;
    }

    /**
     * Converts specified encoded integer to a Network Compatibility Version
     * String. The transmitted integer is negative to distinguish it from
     * 7 bit ASCII characters.
     */
    public static String toNetCompVersionString(int i) {

        StringBuffer sb = new StringBuffer();

        i *= -1;

        sb.append(i / 1000000);

        i %= 1000000;

        sb.append('.');
        sb.append(i / 10000);

        i %= 10000;

        sb.append('.');
        sb.append(i / 100);

        i %= 100;

        sb.append('.');
        sb.append(i);

        return sb.toString();
    }

    protected void handshake() throws IOException {
        dataOutput.writeInt(NETWORK_COMPATIBILITY_VERSION_INT);
        dataOutput.flush();
    }
}
