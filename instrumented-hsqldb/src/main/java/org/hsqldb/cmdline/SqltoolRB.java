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


package org.hsqldb.cmdline;

import org.hsqldb.lib.ValidatingResourceBundle;
import org.hsqldb.lib.RefCapableRBInterface;

/* $Id: SqltoolRB.java 4809 2011-11-20 21:12:35Z unsaved $ */

/**
 * Resource Bundle for SqlTool and associated classes.
 *
 * Purpose of this class is to wrap a RefCapablePropertyResourceBundle to
 *  reliably detect any possible use of a missing property key as soon as
 *  this class is clinitted.
 * The reason for this is to allow us developers to detect all such errors
 *  before end-users ever use this class.
 * * IMPORTANT:  To add a new ResourceBundle element, add two new lines, one
 * like <PRE>
 *    public static final int NEWKEYID = keyCounter++;
 * </PRE> and one line <PRE>
 *      new Integer(KEY2), "key2",
 * </PRE>
 * Both should be inserted right after all of the other lines of the same type.
 * NEWKEYID is obviously a new constant which you will use in calling code
 * like SqltoolRB.NEWKEYID.
 */
public enum SqltoolRB implements RefCapableRBInterface {
    SqlTool_syntax,
    // SqlTool inline properties:
    passwordFor_prompt,
    SqlTool_varset_badformat,
    SqlTool_abort_continue_mutuallyexclusive,
    sqltempfile_fail,
    rcdata_inlineurl_missing,
    rcdata_inline_extravars,
    rcdata_inlineusername_missing,
    rcdata_password_visible,
    password_readfail,
    connection_fail,
    rcdata_genfromvalues_fail,
    conndata_retrieval_fail,
    jdbc_established,
    SqlTool_params_redundant,

    // SqlFile class, file references:
    SqlFile_banner,
    buffer_help,
    special_help,
    pl_help,
    pl_control,
    pl_assign,
    dsv_options,
    d_options,
    raw_leadin,
    errorat,
    rejectreport_top,
    rejectreport_row,
    rejectreport_bottom,
    macro_help,

    // SqlFile inline properties:
    rawmode_prompt,
    raw_movedtobuffer,
    input_movedtobuffer,
    sqlstatement_empty,
    causereport,
    break_unsatisfied,
    continue_unsatisfied,
    primaryinput_accessfail,
    input_unterminated,
    plvar_set_incomplete,
    aborting,
    rollingback,
    special_unspecified,
    bufhist_unspecified,
    buffer_executing,
    nobuffer_yet,
    commandnum_malformat,
    buffer_restored,
    substitution_malformat,
    substitution_nomatch,
    substitution_syntax,
    buffer_unknown,
    special_extrachars,
    buffer_extrachars,
    special_malformat,
    html_mode,
    dsv_targetfile_demand,
    file_wrotechars,
    file_writefail,
    special_d_like,
    outputfile_nonetoclose,
    outputfile_reopening,
    outputfile_header,
    destfile_demand,
    buffer_empty,
    file_appendfail,
    sqlfile_name_demand,
    sqlfile_execute_fail,
    a_setting,
    committed,
    special_b_malformat,
    binary_loadedbytesinto,
    binary_filefail,
    c_setting,
    bang_incomplete,
    bang_command_fail,
    special_unknown,
    dsv_m_syntax,
    dsv_x_syntax,
    raw_empty,
    dsv_nocolsleft,
    dsv_skipcols_missing,
    plalias_malformat,
    plvar_undefined,
    sysprop_empty,
    sysprop_unterminated,
    sysprop_undefined,
    var_infinite,
    plvar_nameempty,
    plvar_unterminated,
    pl_malformat,
    deprecated_noop,
    end_noblock,
    continue_syntax,
    break_syntax,
    pl_list_parens,
    pl_list_lengths,
    dumpload_malformat,
    plvar_nocolon,
    plvar_tildedash_nomoreargs,
    dumpload_fail,
    pl_malformat_specific,
    pl_block_fail,
    ifwhile_malformat,
    pl_unknown,
    pl_block_unterminated,
    vendor_oracle_dS,
    vendor_derby_dr,
    vendor_nosup_d,
    vendor_derby_du,
    special_d_unknown,
    metadata_fetch_fail,
    metadata_fetch_failfor,
    prepare_demandqm,
    binbuffer_empty,
    vendor_nosup_sysschemas,
    noresult,
    dsv_bincol,
    binbuf_write,
    rows_fetched,
    rows_fetched_dsv,
    row_update_singular,
    row_update_multiple,
    history_unavailable,
    history_none,
    editbuffer_contents,
    buffer_instructions,
    history_number_req,
    history_backto,
    history_upto,
    history_back,
    describe_table_name,
    describe_table_datatype,
    describe_table_width,
    describe_table_nonulls,
    describe_table_precision,
    describe_table_scale,
    logical_unrecognized,
    read_toobig,
    read_partial,
    read_convertfail,
    dsv_coldelim_present,
    dsv_rowdelim_present,
    dsv_nullrep_present,
    dsv_constcols_nullcol,
    file_readfail,
    inputfile_closefail,
    dsv_header_none,
    dsv_header_noswitchtarg,
    dsv_header_noswitchmatch,
    dsv_header_nonswitched,
    dsv_nocolheader,
    dsv_metadata_mismatch,
    query_metadatafail,
    dsv_rejectfile_setupfail,
    dsv_rejectreport_setupfail,
    none,
    insertion_preparefail,
    dsv_header_matchernonhead,
    dsv_colcount_mismatch,
    dsv_insertcol_mismatch,
    time_bad,
    boolean_bad,
    inputrec_modified,
    dsv_recin_fail,
    dsv_import_summary,
    insertions_notcommitted,
    autocommit_fetchfail,
    dsv_rejectfile_purgefail,
    dsv_rejectreport_purgefail,
    edit_malformat,
    input_malformat,
    append_empty,
    transiso_report,
    exectime_reporting,
    exectime_report,
    regex_malformat,
    encode_fail,
    macro_tip,
    macrodef_malformat,
    macrodef_empty,
    macrodef_semi,
    macro_malformat,
    macro_undefined,
    log_syntax,
    log_syntax_error,
    reject_rpc,
    rpc_autocommit_failure,
    rpc_commit_failure,
    disconnect_success,
    disconnect_failure,
    no_required_conn,
    disconnected_msg,
    connected_fallbackmsg,
    no_vendor_schemaspt,
    schemaname_retrieval_fail,
    remove_empty_vars_suggestset,
    auto_unset_warning,
    pl_unset_nomoreargs,
    dsv_q_nodblquote,
    connect_failure,
    streamread_failure,
    illegal_at,
    suggest_j,
    pipeclose_failure,
    arrayimp_jvmreq,
    arrayval_malformat,
    sqlarray_badjvm,
    csv_coldelim_present,
    csv_quote_unterminated,
    math_expr_fail,
    varname_warning,
    null_assignment,
    bad_time_format,
    no_timestamp_format,
    else_without_if,
    import_col_dup
    ;

    private static ValidatingResourceBundle vrb =
            new ValidatingResourceBundle(
                    SqltoolRB.class.getPackage().getName() + ".sqltool",
                    SqltoolRB.class);
    static {
        vrb.setMissingPosValueBehavior(ValidatingResourceBundle.NOOP_BEHAVIOR);
        vrb.setMissingPropertyBehavior(ValidatingResourceBundle.NOOP_BEHAVIOR);
    }

    public String getString() {
        return vrb.getString(this);
    }
    public String toString() {
        return ValidatingResourceBundle.resourceKeyFor(this);
    }
    public String getExpandedString() {
        return vrb.getExpandedString(this);
    }
    public String getExpandedString(String... strings) {
        return vrb.getExpandedString(this, strings);
    }
    public String getString(Throwable t) {
        return vrb.getString(this,
                (t.getMessage() == null)
                ? t.toString()
                : (t.getClass().getSimpleName() + ": " + t.getMessage()));
    }
    public String getString(String... strings) {
        return vrb.getString(this, strings);
    }
    public String getString(int i1) {
        return vrb.getString(this, i1);
    }
    public String getString(int i1, int i2) {
        return vrb.getString(this, i1, i2);
    }
    public String getString(int i1, int i2, int i3) {
        return vrb.getString(this, i1, i2, i3);
    }
    public String getString(int i1, String s2) {
        return vrb.getString(this, i1, s2);
    }
    public String getString(String s1, int i2) {
        return vrb.getString(this, s1, i2);
    }
    public String getString(int i1, int i2, String s3) {
        return vrb.getString(this, i1, i2, s3);
    }
    public String getString(int i1, String s2, int i3) {
        return vrb.getString(this, i1, s2, i3);
    }
    public String getString(String s1, int i2, int i3) {
        return vrb.getString(this, s1, i2, i3);
    }
    public String getString(int i1, String s2, String s3) {
        return vrb.getString(this, i1, s3, s3);
    }
    public String getString(String s1, String s2, int i3) {
        return vrb.getString(this, s1, s2, i3);
    }
    public String getString(String s1, int i2, String s3) {
        return vrb.getString(this, s1, i2, s3);
    }
}
