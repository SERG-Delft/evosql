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


package org.hsqldb.auth;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Arrays;
import java.util.Properties;

public class LdapAuthBeanTester {

    /**
     * Run this method to try and test configuration settings for LdapAuthBeans,
     * or to troubleshoot.
     * It purposefully does not test the Java Function or the JDBC layer at all.
     * This program will attempt to retrieve and display the schema/roles list
     * for the specified user and with the specified password from the LDAP
     * server according to the specified properties.
     * <P>
     * Passwords typed on the command line are inherently not secure, so only
     * use this program when the computer it is run on is secured and where
     * your command line may not be observed, directly or indirectly, by others.
     * </P> <P>
     * Set the properties in a properties file to match your LDAP security and
     * Directory Information Tree structure and use this program to check
     * everything between the LdapAuthBean and your LDAP server.
     * You then know the exact settings to use for an LdapAuthBean that you can
     * plug into AuthBeanMultiplexer.
     * </P> <P>
     * Run with no arguments to see required syntax.
     * </P> <P>
     *   The property file may contain any of the following properties, which
     *   exactly match the corresponding setter methods in this class.
     *   <UL>
     *     <LI>trustStore.  This is the only property without a corresponding
     *         setter method.  Setting this property has the same effect as
     *         setting Java system property
     *         <CODE>'javax.net.ssl.trustStore'<CODE>.
     *     <LI>startTls.  Takes a boolean value according to
     *         method java.util.Boolean.parseBoolean.
     *     <LI>roleSchemaValuePattern.  Corresponds to method
     *         setRoleSchemaValuePatternString
     *     <LI>accessValuePattern.  Corresponds to method
     *         setAccessValuePatternString
     *     <LI>ldapPort
     *     <LI>securityMechanism
     *     <LI>ldapHost
     *     <LI>principalTemplate
     *     <LI>initialContextFactory
     *     <LI>saslRealm
     *     <LI>parentDn
     *     <LI>rdnAttribute
     *     <LI>rolesSchemaAttribute
     *     <LI>accessAttribute
     *   </UL>
     *   Tokens like ${this} will not be expanded to system property values,
     *   and your bean will get the values exactly as you type them in.
     * </P> <P>
     * The file sample/ldap-exerciser.properties in the HyperSQL distribution
     * may be used as a template or example.
     * </P>
     */
    public static void main(String[] sa) throws IOException {

        if (sa.length != 3) {
            throw new IllegalArgumentException(
                "SYNTAX:  java " + AuthBeanMultiplexer.class.getName()
                + " path/to/file.properties <USERNAME> <PASSWORD>");
        }

        File file = new File(sa[0]);

        if (!file.isFile()) {
            throw new IllegalArgumentException("Not a file: "
                                               + file.getAbsolutePath());
        }

        Properties p = new Properties();

        p.load(new FileInputStream(file));

        String trustStore     = p.getProperty("trustStore");
        String startTlsString = p.getProperty("startTls");
        String ldapPortString = p.getProperty("ldapPort");
        String roleSchemaValuePatternString =
            p.getProperty("roleSchemaValuePattern");
        String accessValuePatternString = p.getProperty("accessValuePattern");
        String securityMechanism        = p.getProperty("securityMechanism");
        String ldapHost                 = p.getProperty("ldapHost");
        String principalTemplate        = p.getProperty("principalTemplate");
        String initialContextFactory = p.getProperty("initialContextFactory");
        String saslRealm                = p.getProperty("saslRealm");
        String parentDn                 = p.getProperty("parentDn");
        String rdnAttribute             = p.getProperty("rdnAttribute");
        String rolesSchemaAttribute = p.getProperty("rolesSchemaAttribute");
        String accessAttribute          = p.getProperty("accessAttribute");

        if (trustStore != null) {
            if (!(new File(trustStore)).isFile()) {
                throw new IllegalArgumentException(
                    "Specified trust store is not a file: " + trustStore);
            }

            System.setProperty("javax.net.ssl.trustStore", trustStore);
        }

        LdapAuthBean bean = new LdapAuthBean();

        if (startTlsString != null) {
            bean.setStartTls(Boolean.parseBoolean(startTlsString));
        }

        if (ldapPortString != null) {
            bean.setLdapPort(Integer.parseInt(ldapPortString));
        }

        if (roleSchemaValuePatternString != null) {
            bean.setRoleSchemaValuePatternString(roleSchemaValuePatternString);
        }

        if (accessValuePatternString != null) {
            bean.setAccessValuePatternString(accessValuePatternString);
        }

        if (securityMechanism != null) {
            bean.setSecurityMechanism(securityMechanism);
        }

        if (ldapHost != null) {
            bean.setLdapHost(ldapHost);
        }

        if (principalTemplate != null) {
            bean.setPrincipalTemplate(principalTemplate);
        }

        if (initialContextFactory != null) {
            bean.setInitialContextFactory(initialContextFactory);
        }

        if (saslRealm != null) {
            bean.setSaslRealm(saslRealm);
        }

        if (parentDn != null) {
            bean.setParentDn(parentDn);
        }

        if (rdnAttribute != null) {
            bean.setRdnAttribute(rdnAttribute);
        }

        if (rolesSchemaAttribute != null) {
            bean.setRolesSchemaAttribute(rolesSchemaAttribute);
        }

        if (accessAttribute != null) {
            bean.setAccessAttribute(accessAttribute);
        }

        bean.init();

        String[] res = null;

        try {
            res = bean.authenticate(sa[1], sa[2]);
        } catch (DenyException de) {
            System.out.println("<DENY ACCESS>");

            return;
        }

        if (res == null) {
            System.out.println("<ALLOW ACCESS w/ local Roles+Schema>");
        } else {
            System.out.println(Integer.toString(res.length)
                               + " Roles/Schema: " + Arrays.toString(res));
        }
    }
}
