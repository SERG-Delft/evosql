/* Copyright (c) 2001-2007, The HSQL Development Group
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


package org.hsqldb.util.preprocessor;

/* $Id: Option.java 610 2008-12-22 15:54:18Z unsaved $ */

/**
 * Static methods and constants to decode preprocessor options.
 *
 * @author boucherb@users
 * @version 1.8.1
 * @since 1.8.1
 */
public class Option {

    public static final int DEFAULT   = 0;    // No options set
    public static final int BACKUP    = 1<<0; // Backup source files?
    public static final int FILTER    = 1<<1; // Remove directive lines?
    public static final int INDENT    = 1<<2; // indent directive lines?
    public static final int TEST_ONLY = 1<<3; // process only; don't save
    public static final int VERBOSE   = 1<<4; // log detailed info

    private Option(){/*Construction Disabled*/}

    public static boolean isDefault(int options) {
        return options == DEFAULT;
    }

    public static int setDefault(int options, boolean _default) {
        return (_default) ? DEFAULT : options;
    }

    public static boolean isBackup(int options) {
        return ((options & BACKUP) != 0);
    }

    public static int setBackup(int options, boolean backup) {
        return (backup) ? (options | BACKUP) : (options & ~BACKUP);
    }

    public static boolean isFilter(int options) {
        return ((options & FILTER) != 0);
    }

    public static int setFilter(int options, boolean filter) {
        return (filter) ? (options | FILTER) : (options & ~FILTER);
    }

    public static boolean isIndent(int options) {
        return ((options & INDENT) != 0);
    }

    public static int setIndent(int options, boolean indent) {
        return (indent) ? (options | INDENT) : (options & ~INDENT);
    }

    public static boolean isTestOnly(int options) {
        return ((options & TEST_ONLY) != 0);
    }

    public static int setTestOnly(int options, boolean testOnly) {
        return (testOnly) ? (options | TEST_ONLY) : (options & ~TEST_ONLY);
    }

    public static boolean isVerbose(int options) {
        return ((options & VERBOSE) != 0);
    }

    public static int setVerbose(int options, boolean verbose) {
        return (verbose) ? (options | VERBOSE) : (options & ~VERBOSE);
    }
}
