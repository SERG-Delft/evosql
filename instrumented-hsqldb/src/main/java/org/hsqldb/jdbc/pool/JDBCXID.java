/* Copyright (c) 2001-2015, The HSQL Development Group
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


package org.hsqldb.jdbc.pool;

import java.net.Inet4Address;
import java.util.Arrays;
import java.util.Random;

import javax.transaction.xa.Xid;

/**
 * Implementation of Xid for tests.
 *
 * <pre>
 * // Example usage:
 *
 * JDBCXADataSource ds = new JDBCXADataSource();
 *
 * ds.setUser(user);
 * ds.setPassword(password);
 * ds.setUrl(jdbcUrl);
 *
 * XAConnection xaCon = ds.getConnection();
 * Connection con = xaCon.getConnection();
 * Xid xid = JDBCXID.getUniqueXid((int)Thread.currentThread().getId());
 * XAResource xaRes = xaCon.getXAResource();
 *
 *  // Start the transaction.
 * System.out.println("Starting XA transaction with xid = " + xid.toString());
 *
 * xaRes.setTransactionTimeout(0);
 * xaRes.start(xid,XAResource.TMNOFLAGS);
 *
 * // Do work here ....
 *
 * // Commit the transaction.
 * xaRes.end(xid,XAResource.TMSUCCESS);
 * xaRes.commit(xid,true);
 *
 * // Cleanup.
 * con.close();
 * xaCon.close();
 * </pre>
 *
 * @author Fred Toussi (fredt@users dot sourceforge.net)
 * @author Campbell Burnet (boucherb@users dot sourceforge.net)
 * @version 2.1
 */
public class JDBCXID implements Xid {

    int formatID;
    byte[] txID;
    byte[] txBranch;
    //
    int hash;
    boolean hashComputed;

    public int getFormatId() {
        return formatID;
    }

    public byte[] getGlobalTransactionId() {
        return txID;
    }

    public byte[] getBranchQualifier() {
        return txBranch;
    }

    public JDBCXID(int formatID, byte[] txID, byte[] txBranch) {

        this.formatID = formatID;
        this.txID = txID;
        this.txBranch = txBranch;
    }

    public int hashCode() {
        if (!hashComputed) {
            hash = 7;
            hash = 83 * hash + this.formatID;
            hash = 83 * hash + Arrays.hashCode(this.txID);
            hash = 83 * hash + Arrays.hashCode(this.txBranch);
            hashComputed = true;
        }
        return hash;
    }

    public boolean equals(Object other) {

        if (other instanceof Xid) {
            Xid o = (Xid) other;

            return formatID == o.getFormatId()
                    && Arrays.equals(txID, o.getGlobalTransactionId())
                    && Arrays.equals(txBranch, o.getBranchQualifier());
        }

        return false;
    }

    // inherit doc
    public String toString() {

        StringBuffer sb = new StringBuffer(512);
        //
        sb.append("formatId=").append(getFormatId());
        //
        sb.append(" globalTransactionId(").append(txID.length).append(")={0x");
        for (int i = 0; i < txID.length; i++) {
            final int hexVal = txID[i] & 0xFF;
            if (hexVal < 0x10) {
                sb.append("0").append(Integer.toHexString(txID[i] & 0xFF));
            }
            sb.append(Integer.toHexString(txID[i] & 0xFF));
        }
        //
        sb.append("} branchQualifier(").append(txBranch.length).append("))={0x");
        for (int i = 0; i < txBranch.length; i++) {
            final int hexVal = txBranch[i] & 0xFF;
            if (hexVal < 0x10) {
                sb.append("0");
            }
            sb.append(Integer.toHexString(txBranch[i] & 0xFF));
        }
        sb.append("}");
        //
        return sb.toString();
    }

    private static byte[] s_localIp = null;
    private static int s_txnSequenceNumber = 0;
    //
    private static final int UXID_FORMAT_ID = 0xFEED;

    private static int nextTxnSequenceNumber() {
         s_txnSequenceNumber++;
        return  s_txnSequenceNumber;
    }

    private static byte[] getLocalIp() {
        if (null == s_localIp) {
            try {
                s_localIp = Inet4Address.getLocalHost().getAddress();
            } catch (Exception ex) {
                s_localIp = new byte[]{0x7F, 0x00, 0x00, 0x01};
            }
        }
        return s_localIp;
    }

    /**
     * Retrieves a randomly generated JDBCXID.
     *
     * The newly generated object is based on the local IP address, the given
     * <tt>threadId</tt> and a randomly generated number using the current time
     * in milliseconds as the random seed.
     *
     * Note that java.util.Random is used, not java.security.SecureRandom.
     *
     * @param threadId can be a real thread id or just some convenient
     *        tracking value.
     *
     * @return a randomly generated JDBCXID
     */
    public static Xid getUniqueXid(final int threadId) {
        final Random random = new Random(System.currentTimeMillis());
        //
        int txnSequenceNumberValue = nextTxnSequenceNumber();
        int threadIdValue = threadId;
        int randomValue = random.nextInt();
        //
        byte[] globalTransactionId = new byte[MAXGTRIDSIZE];
        byte[] branchQualifier = new byte[MAXBQUALSIZE];
        byte[] localIp = getLocalIp();

        System.arraycopy(localIp, 0, globalTransactionId, 0, 4);
        System.arraycopy(localIp, 0, branchQualifier, 0, 4);

        // Bytes 4 -> 7 - unique transaction id.
        // Bytes 8 ->11 - thread id.
        // Bytes 12->15 - random.
        for (int i = 0; i <= 3; i++) {
            globalTransactionId[i + 4] = (byte) (txnSequenceNumberValue % 0x100);
            branchQualifier[i + 4] = (byte) (txnSequenceNumberValue % 0x100);
            txnSequenceNumberValue >>= 8;
            globalTransactionId[i + 8] = (byte) (threadIdValue % 0x100);
            branchQualifier[i + 8] = (byte) (threadIdValue % 0x100);
            threadIdValue >>= 8;
            globalTransactionId[i + 12] = (byte) (randomValue % 0x100);
            branchQualifier[i + 12] = (byte) (randomValue % 0x100);
            randomValue >>= 8;
        }

        return new JDBCXID(UXID_FORMAT_ID, globalTransactionId, branchQualifier);
    }
}
