/* Copyright (c) 2001-2014, The HSQL Development Group
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

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.security.auth.Subject;
import javax.security.auth.callback.Callback;
import javax.security.auth.callback.CallbackHandler;
import javax.security.auth.callback.NameCallback;
import javax.security.auth.callback.PasswordCallback;
import javax.security.auth.callback.UnsupportedCallbackException;
import javax.security.auth.login.LoginContext;
import javax.security.auth.login.LoginException;

import org.hsqldb.lib.FrameworkLogger;

/**
 * Provides authentication and authorization (roles and initial schema)
 * according to JAAS modules configured by the runtime JAAS implementation.
 * <P>
 * <b>JAAS modules used must have both a NameCallback and a PasswordCallback.</b>
 * This is how we pass the JDBC-provided user name and password to the module.
 * </P> <P>
 * JAAS setup is Java-implementation-specific.
 * For Sun Java, you set up a JAAS configuration file which resides at
 * <code>$HOME/.java.login.config</code> or at the location that you set with
 * Java system property <code>java.security.auth.login.config</code>.
 * </P> <P>
 * You can use this bean to manage just access, or also to manage roles or
 * initial schemas.
 * To use for roles or initial schemas, you must set the roleSchemaValuePattern
 * property to distinguish which of the JAAS-module-provided values to use.
 * By default, all JAAS-module-provided Principles will be candidates.
 * If you set property roleSchemaViaCredential to true, then all
 * JAAS-module-provided public Credentials will be candidates instead.
 * </P>
 *
 * @see AuthFunctionBean
 * @see NameCallback
 * @see PasswordCallback
 * @author Blaine Simpson (blaine dot simpson at admc dot com)
 * @since 2.0.1
 */
public class JaasAuthBean implements AuthFunctionBean {
    private static FrameworkLogger logger =
            FrameworkLogger.getLog(JaasAuthBean.class);

    private boolean initialized;
    private String applicationKey;
    private Pattern roleSchemaValuePattern;
    private boolean roleSchemaViaCredential;

    public JaasAuthBean() {
        // Intentionally empty
    }

    /**
     * By default, If roleSchemaValuePattern is set, then role and schema
     * values are obtained from principle values; otherwise existing account
     * privileges are used (if any).
     * If roleSchemaViaCredential is set to true and roleSchemaValuePattern is
     * set, then credential values will be used instead.
     * <P>
     * Do not set roleSchemaViaCredential to true unless roleSchemaValuePattern
     * is set.
     * </P>
     */
    public void setRoleSchemaViaCredential(boolean roleSchemaViaCredential) {
        this.roleSchemaViaCredential = roleSchemaViaCredential;
    }

    /**
     * @throws IllegalStateException if any required setting has not been set.
     */
    public void init() {
        if (applicationKey == null) {
            throw new IllegalStateException(
                    "Required property 'applicationKey' not set");
        }
        if (roleSchemaViaCredential && roleSchemaValuePattern == null) {
            throw new IllegalStateException(
                    "Properties 'roleSchemaViaCredential' and "
                    + "'roleSchemaValuePattern' are mutually exclusive.  "
                    + "If you want JaasAuthBean to manage roles or schemas, "
                    + "you must set property 'roleSchemaValuePattern'.");
        }
        initialized = true;
    }

    /**
     * Set the key into the JAAS runtime configuration.
     *
     * For Sun's JAAS implementation, this is the "application" identifier for
     * a stanza in the JAAS configuration file.
     */
    public void setApplicationKey(String applicationKey) {
        this.applicationKey = applicationKey;
    }

    /**
     * Assign a pattern to both detect honored values, and optionally
     * to map from a single principal name or public credential string
     * to a single HyperSQL role or schema string.
     * Do not use this method if you are using this JaasAuthBean only to
     * permit or reject access (with roles and schema being determined by
     * pre-existing local HyperSQL accounts).
     * On that case, simple success of the login() method method will allow
     * access as the specified user.
     * <P>
     * If every principal name or public credentials holds only the String
     * values precisely as HyperSQL needs them, then set the pattern to ".+".
     * For example, if the JAAS module returns principals (or credentials) with
     * values "one", "two", "three", then if you set this pattern to ".+",
     * HyperSQL will attempt to assign initial schema and roles for the values
     * "one", "two", and "three".
     * </P><P>
     * These are two distinct and important purposes for the specified Pattern.
     * <OL>
     *   <LI>
     *      Values that do not successfully match the pattern will be ignored.
     *      If the pattern does match, then the entire principal or credential
     *      value will be used to assign initial schema or role (as long as it
     *      is a valid schema name or role name in the local database).
     *   <LI>
     *      Optionally uses parentheses to specify a single capture group
     *      (if you use parentheses to specify more than one matching group, we
     *      will only capture for the first).
     *      What is captured by this group is exactly the role or schema that
     *      HyperSQL will attempt to assign.
     *      If no capture parens are given then the Pattern is only used for the
     *      acceptance decision, and the JAAS-provided value will be returned
     *      verbatim.
     * </OL>
     * </P><P>
     * N.b. this Pattern will be used for the matches() operation, therefore it
     * must match the entire candidate value strings (this is different than
     * the find operation which does not need to satisfy the entire candidate
     * value).
     * </P><P>Example1 :<CODE><PRE>
     *     cn=([^,]+),ou=dbRole,dc=admc,dc=com
     * </PRE></CODE>
     *     will extract the CN value from matching attribute values.
     * </P><P>Example1 :<CODE><PRE>
     *     cn=[^,]+,ou=dbRole,dc=admc,dc=com
     * </PRE></CODE>
     *     will return the entire <CODE>cn...com</CODE> string for matching
     *     attribute values.
     * </P>
     *
     * @see Matcher#matches()
     */
    public void setRoleSchemaValuePattern(Pattern roleSchemaValuePattern) {
        this.roleSchemaValuePattern = roleSchemaValuePattern;
    }

    /**
     * String wrapper for method setRoleSchemaValuePattern(Pattern)
     *
     * Use the (x?) Pattern constructs to set options.
     *
     * @throws java.util.regex.PatternSyntaxException
     * @see #setRoleSchemaValuePattern(Pattern)
     */
    public void setRoleSchemaValuePatternString(String patternString) {
        setRoleSchemaValuePattern(Pattern.compile(patternString));
    }

    public static class UPCallbackHandler implements CallbackHandler {
        private String u;
        private char[] p;

        public UPCallbackHandler(String u, String pString) {
            this.u = u;
            p = pString.toCharArray();
        }

        public void handle(Callback[] callbacks)
                throws UnsupportedCallbackException {
            boolean didSetName = false;
            boolean didSetPassword = false;
            for (Callback cb : callbacks)
                if (cb instanceof NameCallback) {
                    ((NameCallback) cb).setName(u);
                    didSetName = true;
                } else if (cb instanceof PasswordCallback) {
                    ((PasswordCallback) cb).setPassword(p);
                    didSetPassword = true;
                } else {
                    throw new UnsupportedCallbackException(cb,
                            "Unsupported Callback type: "
                            + cb.getClass().getName());
                }
            if (!didSetName)
                throw new IllegalStateException(
                        "Supplied Callbacks does not include a NameCallback");
            if (!didSetPassword)
                throw new IllegalStateException("Supplied Callbacks "
                        + "does not include a PasswordCallback");
        }
    }

    /**
     * @see AuthFunctionBean#authenticate(String, String)
     */
    public String[] authenticate(String userName, String password)
            throws DenyException {
        if (!initialized) {
            throw new IllegalStateException(
                "You must invoke the 'init' method to initialize the "
                + JaasAuthBean.class.getName() + " instance.");
        }
        try {
            LoginContext lc =
                new LoginContext(applicationKey,
                        new UPCallbackHandler(userName, password));
            try {
                lc.login();
            } catch (LoginException le) {
                // I wish there were a way to distinguish system problems from
                // purposeful rejections here.  :-(
                logger.finer("JSSE backend denying access:  " + le);
                throw new DenyException();
            }
            try {
                if (roleSchemaValuePattern == null) {
                    return null;
                }
                int i = 0;
                Matcher m = null;
                List<String> rsCandidates = new ArrayList<String>();
                List<String> rsList = new ArrayList<String>();
                Subject s = lc.getSubject();
                if (roleSchemaViaCredential) {
                    for (Object cred :
                                new ArrayList(s.getPublicCredentials())) {
                        rsCandidates.add(cred.toString());
                    }
                } else {
                    for (Principal p :
                            new ArrayList<Principal>(s.getPrincipals())) {
                        rsCandidates.add(p.getName());
                    }
                }
                logger.finer(Integer.toString(rsCandidates.size())
                            + " candidate " + (roleSchemaViaCredential
                            ? "Credentials" : "Principals"));
                for (String candid : rsCandidates) {
                    m = roleSchemaValuePattern.matcher(candid);
                    if (m.matches()) {
                        logger.finer("    +" + ++i + ": "
                                + ((m.groupCount() > 0) ? m.group(1) : candid));
                        rsList.add((m.groupCount() > 0) ? m.group(1) : candid);
                    } else {
                        logger.finer("    -" + ++i + ": " + candid);
                    }
                }
                return rsList.toArray(new String[0]);
            } finally {
                lc.logout();
            }
        } catch (LoginException le) {
            logger.severe("System JaasAuthBean failure", le);
            throw new RuntimeException(le);  // JAAS System failure
        } catch (RuntimeException re) {
            logger.severe("System JaasAuthBean failure", re);
            throw re;
        }
    }
}
