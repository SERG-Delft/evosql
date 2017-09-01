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

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;

import org.hsqldb.map.BitMap;

/**
 * A list of ACL permit and deny entries with a permitAccess method
 * which tells whether candidate addresses are permitted or denied
 * by this ACL list.
 * <P>
 * The ACL file is reloaded whenever a modification to it is detected.
 * If you copy in a file with an older file date, you will need to touch it.
 * </P>
 *
 * <P>
 * The public runtime method is permitAccess().
 * The public setup method is the constructor.
 * </P> <P>
 * Each non-comment line in the ACL file must be a rule of the format:
 * <PRE><CODE>
 *     {allow|deny} <ip_address>[/significant-bits]
 * </CODE></PRE>
 * For example
 * <PRE><CODE>
 *     allow ahostname
 *     deny ahost.domain.com
 *     allow 127.0.0.1
 *     allow 2001:db8::/32
 * </CODE></PRE>
 * </P> <P>
 * In order to detect bit specification mistakes, we require that
 * non-significant bits be zero in the values.
 * An undesirable consequence of this is, you can't use a specification like
 * the following to mean "all of the hosts on the same network as x.admc.com":
 * <PRE><CODE>
 *     allow x.admc.com/24
 * </CODE></PRE>
 * </P>
 *
 * @see #ServerAcl(File)
 * @see #permitAccess
 **/
public final class ServerAcl {

    public static final class AclFormatException extends Exception {

        public AclFormatException(String s) {
            super(s);
        }
    }

    protected static final byte[] ALL_SET_4BYTES  = new byte[] {
        -1, -1, -1, -1
    };
    protected static final byte[] ALL_SET_16BYTES = new byte[] {
        -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1
    };

    // -1 is all-bits-on in 2's-complement for signed values.
    // Must do it this way since Java has no support for unsigned integral
    // constants.
    private static final class AclEntry {

        private byte[] value;
        private byte[] mask;    // These are the bits in candidate which must match
        private int    bitBlockSize;
        public boolean allow;

        public AclEntry(byte[] value, int bitBlockSize,
                        boolean allow) throws AclFormatException {

            byte[] allOn = null;

            switch (value.length) {

                case 4 :
                    allOn = ALL_SET_4BYTES;
                    break;

                case 16 :
                    allOn = ALL_SET_16BYTES;
                    break;

                default :
                    throw new IllegalArgumentException(
                        "Only 4 and 16 bytes supported, not " + value.length);
            }

            if (bitBlockSize > value.length * 8) {
                throw new IllegalArgumentException(
                    "Specified " + bitBlockSize
                    + " significant bits, but value only has "
                    + (value.length * 8) + " bits");
            }

            this.bitBlockSize = bitBlockSize;
            this.value        = value;
            mask = BitMap.leftShift(allOn, value.length * 8 - bitBlockSize);

            if (mask.length != value.length) {
                throw new RuntimeException(
                    "Basic program assertion failed.  "
                    + "Generated mask length " + mask.length
                    + " (bytes) does not match given value length "
                    + value.length + " (bytes).");
            }

            this.allow = allow;

            validateMask();
        }

        public String toString() {

            StringBuffer sb = new StringBuffer("Addrs ");

            sb.append((value.length == 16)
                      ? ("[" + ServerAcl.colonNotation(value) + ']')
                      : ServerAcl.dottedNotation(value));
            sb.append("/" + bitBlockSize + ' ' + (allow ? "ALLOW"
                                                        : "DENY"));

            return sb.toString();
        }

        public boolean matches(byte[] candidate) {

            if (value.length != candidate.length) {
                return false;
            }

            return !BitMap.hasAnyBitSet(BitMap.xor(value,
                                                   BitMap.and(candidate,
                                                       mask)));
        }

        public void validateMask() throws AclFormatException {

            if (BitMap.hasAnyBitSet(BitMap.and(value, BitMap.not(mask)))) {
                throw new AclFormatException(
                    "The base address '" + ServerAcl.dottedNotation(value)
                    + "' is too specific for block-size-spec /"
                    + bitBlockSize);
            }
        }
    }

    /**
     * @param uba  Unsigned byte array
     */
    public static String dottedNotation(byte[] uba) {

        StringBuffer sb = new StringBuffer();

        for (int i = 0; i < uba.length; i++) {
            if (i > 0) {
                sb.append('.');
            }

            sb.append((int) uba[i] & 0xff);
        }

        return sb.toString();
    }

    /**
     * @param uba  Unsigned byte array
     */
    public static String colonNotation(byte[] uba) {

        // TODO:  handle odd byte lengths.
        if ((uba.length / 2) * 2 != uba.length) {
            throw new RuntimeException(
                "At this time .colonNotation only handles even byte quantities");
        }

        StringBuffer sb = new StringBuffer();

        for (int i = 0; i < uba.length; i += 2) {
            if (i > 0) {
                sb.append(':');
            }

            sb.append(Integer.toHexString((uba[i] & 0xff) * 256
                                          + (uba[i + 1] & 0xff)));
        }

        return sb.toString();
    }

    private PrintWriter pw = null;

    public void setPrintWriter(PrintWriter pw) {
        this.pw = pw;
    }

    public String toString() {

        StringBuffer sb = new StringBuffer();

        for (int i = 0; i < aclEntries.size(); i++) {
            if (i > 0) {
                sb.append('\n');
            }

            sb.append("Entry " + (i + 1) + ": " + aclEntries.get(i));
        }

        return sb.toString();
    }

    private List            aclEntries;
    static private AclEntry PROHIBIT_ALL_IPV4;
    static private AclEntry PROHIBIT_ALL_IPV6;

    static {
        try {
            PROHIBIT_ALL_IPV4 =
                new AclEntry(InetAddress.getByName("0.0.0.0").getAddress(), 0,
                             false);
            PROHIBIT_ALL_IPV6 =
                new AclEntry(InetAddress.getByName("::").getAddress(), 0,
                             false);
        } catch (UnknownHostException uke) {

            // Should never reach here, since no name service is needed to
            // look up either address.
            throw new RuntimeException(
                "Unexpected problem in static initializer", uke);
        } catch (AclFormatException afe) {
            throw new RuntimeException(
                "Unexpected problem in static initializer", afe);
        }
    }

    /**
     * Uses system network libraries to resolve the given String to an IP addr,
     * then determine whether this address is permitted or denied.
     *
     * Specified name may be a numerical-based String like "1.2.3.4", a
     * constant known to the networking libraries, or a host name to be
     * resolved by the systems name resolution system.
     *
     * If the given String can't be resolved to an IP addr, false is returned.
     *
     * @see #permitAccess(byte[])
     */
    public boolean permitAccess(String s) {

        try {
            return permitAccess(InetAddress.getByName(s).getAddress());
        } catch (UnknownHostException uke) {
            println("'" + s + "' denied because failed to resolve to an addr");

            return false;    // Resolution of candidate failed
        }
    }

    /**
     * @return true if access for the candidate address should be permitted,
     *          false if access should be denied.
     * @throws RuntimeException if no rule covers the candidate address.
     *          This would be the case if this class is applied to some
     *          network protocol other than ipv4 or ipv6, without adding a
     *          default rule for it.
     */
    public boolean permitAccess(byte[] addr) {

        ensureAclsUptodate();

        for (int i = 0; i < aclEntries.size(); i++) {
            if (((AclEntry) aclEntries.get(i)).matches(addr)) {
                AclEntry hit = (AclEntry) aclEntries.get(i);

                println("Addr '" + ServerAcl.dottedNotation(addr)
                        + "' matched rule #" + (i + 1) + ":  " + hit);

                return hit.allow;
            }
        }

        throw new RuntimeException("No rule matches address '"
                                   + ServerAcl.dottedNotation(addr) + "'");
    }

    private void println(String s) {

        if (pw == null) {
            return;
        }

        pw.println(s);
        pw.flush();
    }

    private File aclFile;
    private long lastLoadTime = 0;

    private static final class InternalException extends Exception {}

    public ServerAcl(File aclFile) throws IOException, AclFormatException {
        this.aclFile = aclFile;
        aclEntries   = load();
    }

    synchronized protected void ensureAclsUptodate() {

        if (lastLoadTime > aclFile.lastModified()) {
            return;
        }

        try {
            aclEntries = load();

            println("ACLs reloaded from file");

            return;
        } catch (Exception e) {
            println("Failed to reload ACL file.  Retaining old ACLs.  " + e);
        }
    }

    protected List load() throws IOException, AclFormatException {

        if (!aclFile.exists()) {
            throw new IOException("File '" + aclFile.getAbsolutePath()
                                  + "' is not present");
        }

        if (!aclFile.isFile()) {
            throw new IOException("'" + aclFile.getAbsolutePath()
                                  + "' is not a regular file");
        }

        if (!aclFile.canRead()) {
            throw new IOException("'" + aclFile.getAbsolutePath()
                                  + "' is not accessible");
        }

        String          line;
        String          ruleTypeString;
        StringTokenizer toker;
        String          addrString,
                        bitString = null;
        int             slashIndex;
        int             linenum = 0;
        byte[]          addr;
        boolean         allow;
        int             bits;
        BufferedReader  br      = new BufferedReader(new FileReader(aclFile));
        List            newAcls = new ArrayList();

        try {
            while ((line = br.readLine()) != null) {
                linenum++;

                line = line.trim();

                if (line.length() < 1) {
                    continue;
                }

                if (line.charAt(0) == '#') {
                    continue;
                }

                toker = new StringTokenizer(line);

                try {
                    if (toker.countTokens() != 2) {
                        throw new InternalException();
                    }

                    ruleTypeString = toker.nextToken();
                    addrString     = toker.nextToken();
                    slashIndex     = addrString.indexOf('/');

                    if (slashIndex > -1) {
                        bitString  = addrString.substring(slashIndex + 1);
                        addrString = addrString.substring(0, slashIndex);
                    }

                    addr = InetAddress.getByName(addrString).getAddress();
                    bits = (bitString == null) ? (addr.length * 8)
                                               : Integer.parseInt(bitString);

                    if (ruleTypeString.equalsIgnoreCase("allow")) {
                        allow = true;
                    } else if (ruleTypeString.equalsIgnoreCase("permit")) {
                        allow = true;
                    } else if (ruleTypeString.equalsIgnoreCase("accept")) {
                        allow = true;
                    } else if (ruleTypeString.equalsIgnoreCase("prohibit")) {
                        allow = false;
                    } else if (ruleTypeString.equalsIgnoreCase("deny")) {
                        allow = false;
                    } else if (ruleTypeString.equalsIgnoreCase("reject")) {
                        allow = false;
                    } else {
                        throw new InternalException();
                    }
                } catch (NumberFormatException nfe) {
                    throw new AclFormatException("Syntax error at ACL file '"
                                                 + aclFile.getAbsolutePath()
                                                 + "', line " + linenum);
                } catch (InternalException ie) {
                    throw new AclFormatException("Syntax error at ACL file '"
                                                 + aclFile.getAbsolutePath()
                                                 + "', line " + linenum);
                }

                try {
                    newAcls.add(new AclEntry(addr, bits, allow));
                } catch (AclFormatException afe) {
                    throw new AclFormatException("Syntax error at ACL file '"
                                                 + aclFile.getAbsolutePath()
                                                 + "', line " + linenum + ": "
                                                 + afe.toString());
                }
            }
        } finally {
            br.close();
        }

        newAcls.add(PROHIBIT_ALL_IPV4);
        newAcls.add(PROHIBIT_ALL_IPV6);

        lastLoadTime = new java.util.Date().getTime();

        return newAcls;
    }

    /**
     * Utility method that allows interactive testing of individual
     * ACL records, as well as the net effect of the ACL record list.
     *
     * Run  "java -cp path/to/hsqldb.jar org.hsqldb.server.ServerAcl --help"
     * for Syntax help.
     */
    public static void main(String[] sa)
    throws AclFormatException, IOException {

        if (sa.length > 1) {
            throw new RuntimeException("Try: java -cp path/to/hsqldb.jar "
                                       + ServerAcl.class.getName()
                                       + " --help");
        }

        if (sa.length > 0 && sa[0].equals("--help")) {
            System.err.println("SYNTAX: java -cp path/to/hsqldb.jar "
                               + ServerAcl.class.getName()
                               + " [filepath.txt]");
            System.err.println("ACL file path defaults to 'acl.txt' in the "
                               + "current directory.");
            System.exit(0);
        }

        ServerAcl serverAcl = new ServerAcl(new File((sa.length == 0)
            ? "acl.txt"
            : sa[0]));

        serverAcl.setPrintWriter(new PrintWriter(System.out));
        System.out.println(serverAcl.toString());

        BufferedReader br =
            new BufferedReader(new InputStreamReader(System.in));

        System.out.println("Enter hostnames or IP addresses to be tested "
                           + "(one per line).");

        String s;

        while ((s = br.readLine()) != null) {
            s = s.trim();

            if (s.length() < 1) {
                continue;
            }

            System.out.println(Boolean.toString(serverAcl.permitAccess(s)));
        }
    }
}
