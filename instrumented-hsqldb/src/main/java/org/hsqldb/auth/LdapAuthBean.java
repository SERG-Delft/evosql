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

import java.io.IOException;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.naming.AuthenticationException;
import javax.naming.Context;
import javax.naming.NamingEnumeration;
import javax.naming.NamingException;
import javax.naming.directory.Attribute;
import javax.naming.directory.Attributes;
import javax.naming.directory.BasicAttributes;
import javax.naming.directory.SearchResult;
import javax.naming.ldap.InitialLdapContext;
import javax.naming.ldap.LdapContext;
import javax.naming.ldap.StartTlsRequest;
import javax.naming.ldap.StartTlsResponse;

import org.hsqldb.lib.FrameworkLogger;

/**
 * Authenticates to a HyperSQL catalog according to entries in a LDAP
 * database.
 * If using LDAP StartTLS and your server has a certificate not trusted by
 * default by your JRE, then set system property 'javax.net.ssl.trustStore' to
 * the path to a trust store containing the cert (as well as any other certs
 * that your app needs for other purposes).
 * <P>
 * This class with authenticate login attempts against LDAP entries with RDN of
 * the HyperSQL account name (the precise attribute name defaults to 'uid', but
 * you may change that).
 * </P> <P>
 * This class purposefully does not support LDAPS, because LDAPS is deprecated
 * in favor of StartTLS, which we do support.
 * If you need to support LDAPS and are using SE 1.6, use our JaasAuthBean with
 * Sun's LdapLoginModule.
 * </P> <P>
 * This class does not support SASL/External authentication, because the work
 * involved with securely obtaining user-specific certs would be more complex
 * than everything else here combined.
 * Another AuthFunctionBean would have to be written if SASL/External is needed.
 * </P> <P>
 * To use instances of this class, you must use at least the methods
 * setLdapHost, setParentDn, initialize, plus
 * rolesSchemaAttribute and/or accessAttribute.
 * </P> <P>
 * For a user to be given HyperSQL catalog access, that user must either have
 * a value for accessAttribute if that property is set (optionally requiring
 * a match with accessValuePattern); or, if the accessAttribute is not set then
 * must have some (any) value for rolesSchemaAttribute (optionally requiring a
 * match with roleSchemaValuePattern).
 * Consequently, if you have set both accessAttribute and rolesSchemaAttribute,
 * the latter attribute will only be consulted if the check of the former
 * attribute succeeds.
 * </P> <P>
 * If you want roles assigned according to the local HyperSQL database instead
 * of according to LDAP, then set accessAttribute but not rolesSchemaAttribute.
 * </P> <P>
 * If what is wanted is to grant access but with no roles (overriding local
 * roles if there are any), then set both accessAttribute and
 * rolesSchemaAttribute, but do not set any rolesSchemaAttribute attribute
 * values for these no-role users.
 * (I hesitate to mention it, but you could accomplish the same thing with only
 * a rolesSchemaAttribute attribute, by setting only a dummy role/schema value
 * for non-role users, because HyperSQL will ignore unknown roles or schemas
 * but still give access since a list was still supplied).
 * </P>
 *
 * @see AuthFunctionBean
 * @see #setLdapHost(String)
 * @see #setParentDn(String)
 * @see #init()
 * @author Blaine Simpson (blaine dot simpson at admc dot com)
 * @since 2.0.1
 */
public class LdapAuthBean implements AuthFunctionBean {
    private static FrameworkLogger logger =
            FrameworkLogger.getLog(LdapAuthBean.class);

    private Integer ldapPort;
    private String ldapHost, principalTemplate, saslRealm, parentDn;
    private Pattern roleSchemaValuePattern, accessValuePattern;
    private String initialContextFactory = "com.sun.jndi.ldap.LdapCtxFactory";
    private boolean tls;  // This is for StartTLS, not tunneled TLS/LDAPS.
                  // Variable named just "tls" only for brevity.
    private String mechanism = "SIMPLE";
    private String rdnAttribute = "uid";
    private boolean initialized;
    private String rolesSchemaAttribute, accessAttribute;
    protected String[] attributeUnion;

    public LdapAuthBean() {
        // Intentionally empty
    }

    /**
     * If this is set, then the entire (brief) transaction with the LDAP server
     * will be encrypted.
     */
    public void setStartTls(boolean isTls) {
        this.tls = isTls;
    }

    public void setLdapPort(int ldapPort) {
        this.ldapPort = Integer.valueOf(ldapPort);
    }

    /**
     * @throws IllegalStateException if any required setting has not been set.
     */
    public void init() {
        if (ldapHost == null) {
            throw new IllegalStateException(
                    "Required property 'ldapHost' not set");
        }
        if (parentDn == null) {
            throw new IllegalStateException(
                    "Required property 'parentDn' not set");
        }
        if (initialContextFactory == null) {
            throw new IllegalStateException(
                    "Required property 'initialContextFactory' not set");
        }
        if (mechanism == null) {
            throw new IllegalStateException(
                    "Required property 'mechanism' not set");
        }
        if (rdnAttribute == null) {
            throw new IllegalStateException(
                    "Required property 'rdnAttribute' not set");
        }
        if (rolesSchemaAttribute == null && accessAttribute == null) {
            throw new IllegalStateException(
                    "You must set property 'rolesSchemaAttribute' "
                    + "and/or property 'accessAttribute'");
        }
        if (roleSchemaValuePattern != null && rolesSchemaAttribute == null) {
            throw new IllegalStateException(
                    "If property 'roleSchemaValuePattern' is set, then you "
                    + "must also set property 'rolesSchemaAttribute' to "
                    + "indicate which attribute to evaluate");
        }
        if (accessValuePattern != null && accessAttribute == null) {
            throw new IllegalStateException(
                    "If property 'accessValuePattern' is set, then you "
                    + "must also set property 'accessAttribute' to "
                    + "indicate which attribute to evaluate");
        }
        if (rolesSchemaAttribute != null && accessAttribute != null) {
            attributeUnion = new String[]
                    { rolesSchemaAttribute, accessAttribute };
        } else if (rolesSchemaAttribute != null) {
            attributeUnion = new String[] { rolesSchemaAttribute };
        } else {
            attributeUnion = new String[] { accessAttribute };
        }
        initialized = true;
    }

    /**
     * Assign a pattern to detect honored accessAttribute values.
     * If you set accessAttribute but not accessValuePattern, then all that will
     * be checked for access is if the RDN + parentDN entry has the
     * accessAttribute attribute.  (I.e. the specific value will not matter
     * whatsoever).
     * </P><P>
     * You may only use this property if you have set property accessAttribute.
     * If you have set accessAttribute but not this property, then access will
     * be decided based solely upon existence of this attribute.
     * </P><P>
     * Capture groups in the pattern will be ignored and serve no purpose.
     * </P><P>
     * N.b. this Pattern will be used for the matches() operation, therefore it
     * must match the entire candidate value strings (this is different than
     * the find operation which does not need to satisfy the entire candidate
     * value).
     * </P><P>Example1 :<CODE><PRE>
     *     TRUE
     * </PRE></CODE>
     * This will match true values per OpenLDAP's boolean OID.
     * </P>
     *
     * @see Matcher#matches()
     */
    public void setAccessValuePattern(Pattern accessValuePattern) {
        this.accessValuePattern = accessValuePattern;
    }

    /**
     * String wrapper for method setAccessValuePattern(Pattern)
     *
     * Use the (x?) Pattern constructs to set options.
     *
     * @throws java.util.regex.PatternSyntaxException
     * @see #setAccessValuePattern(Pattern)
     */
    public void setAccessValuePatternString(String patternString) {
        setAccessValuePattern(Pattern.compile(patternString));
    }

    /**
     * Assign a pattern to both detect honored values, and to map from a single
     * value of "rolesSchemaAttribute"s to a HyperSQL role or schema string.
     * If your rolesSchemaAttribute holds only the String values precisely as
     * HyperSQL needs them, then don't use this method at all and all matching
     * attribute values will be passed directly.
     * </P><P>
     * You may only use this property if you have set property
     * rolesSchemaAttribute.
     * If rolesSchemaAttribute is set but this property is not set, then
     * the value will directly determine the user's roles and schema.
     * </P><P>
     * <B>Unlike the rolesSchemaAttribute, the property at-hand uses the
     * singular for "role", because whereas rolesSchemaAttribute is the
     * attribute for listing multiple roles, roleSchemaValuePattern is used
     * to evaluate single role values.</B>
     * </P><P>
     * These are two distinct and important purposes for the specified Pattern.
     * <OL>
     *   <LI>
     *      Values that do not successfully match the pattern will be ignored.
     *   <LI>
     *      Optionally uses parentheses to specify a single capture group
     *      (if you use parentheses to specify more than one matching group, we
     *      will only capture for the first).
     *      What is captured by this group is exactly the role or schema that
     *      HyperSQL will attempt to assign.
     *      If no capture parens are given then the Pattern is only used for the
     *      acceptance decision, and the LDAP-provided value will be returned
     *      verbatim.
     * </OL>
     * </P><P>
     * Together, these two features work great to extract just the needed role
     * and schema names from 'memberof' DNs, and will have no problem if you
     * also use 'memberof' for unrelated purposes.
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

    /**
     * Defaults to "SIMPLE".
     *
     * @param mechanism  Either 'SIMPLE' (the default) for LDAP Simple, or
     *                    one of the LDAP SASL mechanisms, such as 'DIGEST-MD5'.
     */
    public void setSecurityMechanism(String mechanism) {
        this.mechanism = mechanism;
    }

    /**
     * Do not specify URL scheme ("ldap:") because that is implied.
     * (Since we purposefully don't support LDAPS, there would be no reason to
     * change that).
     * <P>
     * If using StartTLS, then this host name must match the cn of the LDAP
     * server's certificate.
     * </P> <P>
     * If you need to support LDAPS and are using SE 1.6, use our JaasAuthBean
     * with Sun's LdapLoginModule instead of this class.
     * </P>
     *
     * @see JaasAuthBean
     */
    public void setLdapHost(String ldapHost) {
        this.ldapHost = ldapHost;
    }

    /**
     * A template String containing place-holder token '${username}'.
     * All occurrences of '${username}' (without the quotes) will be translated
     * to the username that authentication is being attempted with.
     * <P>
     * If you supply a principalTemplate that does not contain '${username}',
     * then authentication will be user-independent.
     * </P> <P>
     * It is common to authenticate to LDAP servers with the DN of the user's
     * LDAP entry.  In this situation, set principalTemplate to
     * <CODE>&lt;RDN_ATTR=&gt;${username},&lt;PARENT_DN&gt;</CODE>.
     * For example if you use parentDn of
     * <CODE>"ou=people,dc=admc,dc=com"</CODE> and rdnAttribute of
     * <CODE>uid</CODE>, then you would set <CODE><PRE>
     *     "uid=${username},ou=people,dc=admc,dc=com"
     * </PRE></CODE>
     * </P> <P>
     * By default the user name will be passed exactly as it is, so don't use
     * this setter if that is what you want.  (This works great for OpenLDAP
     * with DIGEST-MD5 SASL, for example).
     * </P>
     */
    public void setPrincipalTemplate(String principalTemplate) {
        this.principalTemplate = principalTemplate;
    }

    /**
     * Most users should not call this, and will get the default of
     * "com.sun.jndi.ldap.LdapCtxFactory".
     * Use this method if you prefer to use a context factory provided by your
     * framework or container, for example, or if you are using a non-Sun JRE.
     */
    public void setInitialContextFactory(String initialContextFactory) {
        this.initialContextFactory = initialContextFactory;
    }

    /**
     * Some LDAP servers using a SASL mechanism require a realm to be specified,
     * and some mechanisms allow a realm to be specified if you wish to use that
     * feature.
     * By default no realm will be sent to the LDAP server.
     * <P>
     * Don't use this setter if you are not setting a SASL mechanism.
     * </P>
     */
    public void setSaslRealm(String saslRealm) {
        this.saslRealm = saslRealm;
    }

    /**
     * Set DN which is parent of the user DNs.
     * E.g.  "ou=people,dc=admc,dc=com"
     */
    public void setParentDn(String parentDn) {
        this.parentDn = parentDn;
    }

    /**
     * rdnAttribute must hold the user name exactly as the HyperSQL login will
     * be made with.
     * <P>
     * This is the RDN relative to the Parent DN specified with setParentDN.
     * Defaults to 'uid'.
     * </P>
     *
     * @see #setParentDn(String)
     */
    public void setRdnAttribute(String rdnAttribute) {
        this.rdnAttribute = rdnAttribute;
    }

    /**
     * Set the attribute name of the RDN + parentDn entries in which is stored
     * the list of roles and optional schema for the authenticating user.
     * <P>
     * There is no default.  <b>You must set this attribute if you want LDAP
     * instead of the local HyperSQL database to determine the user's roles!</b>
     * You must set the rolesSchemaAttribute property and/or the
     * accessAttribute property.
     * Consequently, if you do no tset this property, then you must set the
     * accessAttribute property, and this LdapAuthBean will only determine
     * access not roles.
     * </P> <P>
     * To use the nice <i>reverse group membership</i> feature of LDAP, set
     * this value to "memberof".
     * </P> <P>
     * If you have set both rolesSchemaAttribute and this value, then the
     * attribute set here will only be consulted if the accessAttribute check
     * succeeds.
     * </P>
     */
    public void setRolesSchemaAttribute(String attribute) {
        rolesSchemaAttribute = attribute;
    }

    /**
     * Set the attribute name of the RDN + parentDn entries which will be
     * consulted to decide whether the user can access the HyperSQL database.
     * <P>
     * There is no default.  If you set this attribute, then the attribute will
     * determine whether the user can access the HyperSQL database, regardless
     * of whether the rolesSchemaAttribute attribute is set.
     * </P> <P>
     * If you set just this property, then the local HyperSQL database will
     * decide all roles for the user.  If you set this property and property
     * rolesSchemaAttribute then this attribute will determine access, and if
     * this attribute grants access then the rolesSchemaAttribute value will
     * determine the user's roles.
     * </P>
     */
    public void setAccessAttribute(String attribute) {
        accessAttribute = attribute;
    }

    /**
     * @see AuthFunctionBean#authenticate(String, String)
     */
    public String[] authenticate(String userName, String password)
            throws DenyException {
        if (!initialized) {
            throw new IllegalStateException(
                "You must invoke the 'init' method to initialize the "
                + LdapAuthBean.class.getName() + " instance.");
        }
        Hashtable env = new Hashtable(5, 0.75f);
        env.put(Context.INITIAL_CONTEXT_FACTORY, initialContextFactory);
        env.put(Context.PROVIDER_URL, "ldap://" + ldapHost
                + ((ldapPort == null) ? "" : (":" + ldapPort)));
        StartTlsResponse tlsResponse = null;
        LdapContext ctx = null;

        try {
            ctx = new InitialLdapContext(env, null);

            if (tls) {
                // Requesting to start TLS on an LDAP association
                tlsResponse = (StartTlsResponse) ctx.extendedOperation(
                        new StartTlsRequest());

                // Starting TLS
                tlsResponse.negotiate();
            }

            // A TLS/SSL secure channel has been established if you reach here.

            // Assertion of client's authorization Identity -- Explicit way
            ctx.addToEnvironment(Context.SECURITY_AUTHENTICATION, mechanism);
            ctx.addToEnvironment(Context.SECURITY_PRINCIPAL,
                  ((principalTemplate == null)
                  ? userName
                  : principalTemplate.replace("${username}", userName)));
            ctx.addToEnvironment(Context.SECURITY_CREDENTIALS, password);
            if (saslRealm != null) {
                env.put("java.naming.security.sasl.realm", saslRealm);
            }

            // The Context.SECURITY_* authorizations are only applied when the
            // following statement executes.  (Or any other remote operations done
            // while the TLS connection is still open).
            NamingEnumeration<SearchResult> sRess = null;
            try {
                sRess = ctx.search(parentDn,
                        new BasicAttributes(rdnAttribute, userName),
                        attributeUnion);
            } catch (AuthenticationException ae) {
                throw new DenyException();
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
            if (!sRess.hasMore()) {
                throw new DenyException();
            }
            SearchResult sRes = sRess.next();
            if (sRess.hasMore()) {
                throw new RuntimeException("> 1 result");
            }
            Attributes attrs = sRes.getAttributes();
            if (accessAttribute != null) {
                Attribute attribute =  attrs.get(accessAttribute);
                if (attribute == null) {
                    throw new DenyException();
                }
                if (attribute.size() != 1) {
                    throw new RuntimeException("Access attribute '"
                            + accessAttribute + "' has unexpected value count: "
                            + attribute.size());
                }
                if (accessValuePattern != null) {
                    Object accessValue = attribute.get(0);
                    if (accessValue == null) {
                        throw new RuntimeException(
                                "Access Attr. value is null");
                    }
                    if (!(accessValue instanceof String)) {
                        throw new RuntimeException("Access Attr. value "
                                + "not a String: "
                                + accessValue.getClass().getName());
                    }
                    if (!accessValuePattern.matcher(
                            (String) accessValue).matches()) {
                        throw new DenyException();
                    }
                }
            }
            if (rolesSchemaAttribute == null) {
                return null;
            }

            // If we reach here, then we definitely need to try to return a
            // list of roles + schema.
            List<String> returns = new ArrayList<String>();
            Attribute attribute =  attrs.get(rolesSchemaAttribute);
            if (attribute != null) {
                int valCount = attribute.size();
                Matcher matcher;
                Object oneVal;
                for (int i = 0; i < valCount; i++) {
                    oneVal = attribute.get(i);
                    if (oneVal == null) {
                        throw new RuntimeException(
                                "R/S Attr value #" + i + " is null");
                    }
                    if (!(oneVal instanceof String)) {
                        throw new RuntimeException(
                                "R/S Attr value #" + i + " not a String: "
                                + oneVal.getClass().getName());
                    }
                    if (roleSchemaValuePattern == null) {
                        returns.add((String) oneVal);
                    } else {
                        matcher = roleSchemaValuePattern.matcher(
                                (String) oneVal);
                        if (matcher.matches()) {
                            returns.add((matcher.groupCount() > 0)
                                    ? matcher.group(1)
                                    : (String) oneVal);
                        }
                    }
                }
            }
            if (returns.size() < 1) {
                if (accessAttribute == null) {
                    throw new DenyException();
                }
                return new String[0];
            }
            return returns.toArray(new String[0]);
        } catch (DenyException de) {
            // This throws a non-runtime Exception, which is handled as an
            // access denial instead of a system problem.
            throw de;
        } catch (RuntimeException re) {
            throw re;
        } catch (IOException ioe) {
            throw new RuntimeException(ioe);
        } catch (NamingException ne) {
            throw new RuntimeException(ne);
        } finally {
            if (tlsResponse != null) try {
                tlsResponse.close();
            } catch (IOException ioe) {
                logger.error("Failed to close TLS Response", ioe);
            }
            if (ctx != null) try {
                ctx.close();
            } catch (NamingException ne) {
                logger.error("Failed to close LDAP Context", ne);
            }
        }
    }
}
