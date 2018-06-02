--
-- PostgreSQL database dump
--

-- Dumped from database version 10.4 (Debian 10.4-2.pgdg90+1)
-- Dumped by pg_dump version 10.3

-- Started on 2018-06-02 15:54:02 UTC

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 5044 (class 1262 OID 23254)
-- Name: suitecrm; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE suitecrm WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';


ALTER DATABASE suitecrm OWNER TO postgres;

\connect suitecrm

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 1 (class 3079 OID 12980)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 5046 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 198 (class 1259 OID 23255)
-- Name: accounts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.accounts (
    id character(36) NOT NULL,
    name character varying(150),
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    modified_user_id character(36),
    created_by character(36),
    description text,
    deleted boolean DEFAULT false,
    assigned_user_id character(36),
    account_type character varying(50),
    industry character varying(50),
    annual_revenue character varying(100),
    phone_fax character varying(100),
    billing_address_street character varying(150),
    billing_address_city character varying(100),
    billing_address_state character varying(100),
    billing_address_postalcode character varying(20),
    billing_address_country character varying(255),
    rating character varying(100),
    phone_office character varying(100),
    phone_alternate character varying(100),
    website character varying(255),
    ownership character varying(100),
    employees character varying(10),
    ticker_symbol character varying(10),
    shipping_address_street character varying(150),
    shipping_address_city character varying(100),
    shipping_address_state character varying(100),
    shipping_address_postalcode character varying(20),
    shipping_address_country character varying(255),
    parent_id character(36),
    sic_code character varying(10),
    campaign_id character(36)
);


ALTER TABLE public.accounts OWNER TO postgres;

--
-- TOC entry 199 (class 1259 OID 23262)
-- Name: accounts_audit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.accounts_audit (
    id character(36) NOT NULL,
    parent_id character(36) NOT NULL,
    date_created timestamp with time zone,
    created_by character varying(36),
    field_name character varying(100),
    data_type character varying(100),
    before_value_string character varying(255),
    after_value_string character varying(255),
    before_value_text text,
    after_value_text text
);


ALTER TABLE public.accounts_audit OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 23268)
-- Name: accounts_bugs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.accounts_bugs (
    id character varying(36) NOT NULL,
    account_id character varying(36),
    bug_id character varying(36),
    date_modified timestamp with time zone,
    deleted boolean DEFAULT false
);


ALTER TABLE public.accounts_bugs OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 23272)
-- Name: accounts_cases; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.accounts_cases (
    id character varying(36) NOT NULL,
    account_id character varying(36),
    case_id character varying(36),
    date_modified timestamp with time zone,
    deleted boolean DEFAULT false
);


ALTER TABLE public.accounts_cases OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 23276)
-- Name: accounts_contacts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.accounts_contacts (
    id character varying(36) NOT NULL,
    contact_id character varying(36),
    account_id character varying(36),
    date_modified timestamp with time zone,
    deleted boolean DEFAULT false
);


ALTER TABLE public.accounts_contacts OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 23280)
-- Name: accounts_cstm; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.accounts_cstm (
    id_c character(36) NOT NULL,
    jjwg_maps_lng_c double precision DEFAULT '0'::double precision,
    jjwg_maps_lat_c double precision DEFAULT '0'::double precision,
    jjwg_maps_geocode_status_c character varying(255),
    jjwg_maps_address_c character varying(255)
);


ALTER TABLE public.accounts_cstm OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 23288)
-- Name: accounts_opportunities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.accounts_opportunities (
    id character varying(36) NOT NULL,
    opportunity_id character varying(36),
    account_id character varying(36),
    date_modified timestamp with time zone,
    deleted boolean DEFAULT false
);


ALTER TABLE public.accounts_opportunities OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 23292)
-- Name: acl_actions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.acl_actions (
    id character(36) NOT NULL,
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    modified_user_id character(36),
    created_by character(36),
    name character varying(150),
    category character varying(100),
    acltype character varying(100),
    aclaccess integer,
    deleted boolean
);


ALTER TABLE public.acl_actions OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 23295)
-- Name: acl_roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.acl_roles (
    id character(36) NOT NULL,
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    modified_user_id character(36),
    created_by character(36),
    name character varying(150),
    description text,
    deleted boolean
);


ALTER TABLE public.acl_roles OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 23301)
-- Name: acl_roles_actions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.acl_roles_actions (
    id character varying(36) NOT NULL,
    role_id character varying(36),
    action_id character varying(36),
    access_override integer,
    date_modified timestamp with time zone,
    deleted boolean DEFAULT false
);


ALTER TABLE public.acl_roles_actions OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 23305)
-- Name: acl_roles_users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.acl_roles_users (
    id character varying(36) NOT NULL,
    role_id character varying(36),
    user_id character varying(36),
    date_modified timestamp with time zone,
    deleted boolean DEFAULT false
);


ALTER TABLE public.acl_roles_users OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 23309)
-- Name: address_book; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.address_book (
    assigned_user_id character(36) NOT NULL,
    bean character varying(50),
    bean_id character(36) NOT NULL
);


ALTER TABLE public.address_book OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 23312)
-- Name: alerts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.alerts (
    id character(36) NOT NULL,
    name character varying(255),
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    modified_user_id character(36),
    created_by character(36),
    description text,
    deleted boolean DEFAULT false,
    assigned_user_id character(36),
    is_read boolean,
    target_module character varying(255),
    type character varying(255),
    url_redirect character varying(255)
);


ALTER TABLE public.alerts OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 23319)
-- Name: am_projecttemplates; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.am_projecttemplates (
    id character(36) NOT NULL,
    name character varying(255),
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    modified_user_id character(36),
    created_by character(36),
    description text,
    deleted boolean DEFAULT false,
    assigned_user_id character(36),
    status character varying(100) DEFAULT 'Draft'::character varying,
    priority character varying(100) DEFAULT 'High'::character varying,
    override_business_hours boolean DEFAULT false
);


ALTER TABLE public.am_projecttemplates OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 23329)
-- Name: am_projecttemplates_audit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.am_projecttemplates_audit (
    id character(36) NOT NULL,
    parent_id character(36) NOT NULL,
    date_created timestamp with time zone,
    created_by character varying(36),
    field_name character varying(100),
    data_type character varying(100),
    before_value_string character varying(255),
    after_value_string character varying(255),
    before_value_text text,
    after_value_text text
);


ALTER TABLE public.am_projecttemplates_audit OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 23335)
-- Name: am_projecttemplates_contacts_1_c; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.am_projecttemplates_contacts_1_c (
    id character varying(36) NOT NULL,
    date_modified timestamp with time zone,
    deleted boolean DEFAULT false,
    am_projecttemplates_ida character varying(36),
    contacts_idb character varying(36)
);


ALTER TABLE public.am_projecttemplates_contacts_1_c OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 23339)
-- Name: am_projecttemplates_project_1_c; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.am_projecttemplates_project_1_c (
    id character varying(36) NOT NULL,
    date_modified timestamp with time zone,
    deleted boolean DEFAULT false,
    am_projecttemplates_project_1am_projecttemplates_ida character varying(36),
    am_projecttemplates_project_1project_idb character varying(36)
);


ALTER TABLE public.am_projecttemplates_project_1_c OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 23343)
-- Name: am_projecttemplates_users_1_c; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.am_projecttemplates_users_1_c (
    id character varying(36) NOT NULL,
    date_modified timestamp with time zone,
    deleted boolean DEFAULT false,
    am_projecttemplates_ida character varying(36),
    users_idb character varying(36)
);


ALTER TABLE public.am_projecttemplates_users_1_c OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 23347)
-- Name: am_tasktemplates; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.am_tasktemplates (
    id character(36) NOT NULL,
    name character varying(255),
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    modified_user_id character(36),
    created_by character(36),
    description text,
    deleted boolean DEFAULT false,
    assigned_user_id character(36),
    status character varying(100) DEFAULT 'Not Started'::character varying,
    priority character varying(100) DEFAULT 'High'::character varying,
    percent_complete bigint DEFAULT '0'::bigint,
    predecessors bigint,
    milestone_flag boolean DEFAULT false,
    relationship_type character varying(100) DEFAULT 'FS'::character varying,
    task_number bigint,
    order_number bigint,
    estimated_effort bigint,
    utilization character varying(100) DEFAULT '0'::character varying,
    duration bigint
);


ALTER TABLE public.am_tasktemplates OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 23360)
-- Name: am_tasktemplates_am_projecttemplates_c; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.am_tasktemplates_am_projecttemplates_c (
    id character varying(36) NOT NULL,
    date_modified timestamp with time zone,
    deleted boolean DEFAULT false,
    am_tasktemplates_am_projecttemplatesam_projecttemplates_ida character varying(36),
    am_tasktemplates_am_projecttemplatesam_tasktemplates_idb character varying(36)
);


ALTER TABLE public.am_tasktemplates_am_projecttemplates_c OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 23364)
-- Name: am_tasktemplates_audit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.am_tasktemplates_audit (
    id character(36) NOT NULL,
    parent_id character(36) NOT NULL,
    date_created timestamp with time zone,
    created_by character varying(36),
    field_name character varying(100),
    data_type character varying(100),
    before_value_string character varying(255),
    after_value_string character varying(255),
    before_value_text text,
    after_value_text text
);


ALTER TABLE public.am_tasktemplates_audit OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 23370)
-- Name: aobh_businesshours; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.aobh_businesshours (
    id character(36) NOT NULL,
    name character varying(255),
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    modified_user_id character(36),
    created_by character(36),
    description text,
    deleted boolean DEFAULT false,
    opening_hours character varying(100) DEFAULT '1'::character varying,
    closing_hours character varying(100) DEFAULT '1'::character varying,
    open boolean,
    day character varying(100) DEFAULT 'monday'::character varying
);


ALTER TABLE public.aobh_businesshours OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 23380)
-- Name: aod_index; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.aod_index (
    id character(36) NOT NULL,
    name character varying(255),
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    modified_user_id character(36),
    created_by character(36),
    description text,
    deleted boolean DEFAULT false,
    assigned_user_id character(36),
    last_optimised timestamp with time zone,
    location character varying(255)
);


ALTER TABLE public.aod_index OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 23401)
-- Name: aod_index_audit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.aod_index_audit (
    id character(36) NOT NULL,
    parent_id character(36) NOT NULL,
    date_created timestamp with time zone,
    created_by character varying(36),
    field_name character varying(100),
    data_type character varying(100),
    before_value_string character varying(255),
    after_value_string character varying(255),
    before_value_text text,
    after_value_text text
);


ALTER TABLE public.aod_index_audit OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 23387)
-- Name: aod_indexevent; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.aod_indexevent (
    id character(36) NOT NULL,
    name character varying(255),
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    modified_user_id character(36),
    created_by character(36),
    description text,
    deleted boolean DEFAULT false,
    assigned_user_id character(36),
    error character varying(255),
    success boolean DEFAULT false,
    record_id character(36),
    record_module character varying(255)
);


ALTER TABLE public.aod_indexevent OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 23395)
-- Name: aod_indexevent_audit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.aod_indexevent_audit (
    id character(36) NOT NULL,
    parent_id character(36) NOT NULL,
    date_created timestamp with time zone,
    created_by character varying(36),
    field_name character varying(100),
    data_type character varying(100),
    before_value_string character varying(255),
    after_value_string character varying(255),
    before_value_text text,
    after_value_text text
);


ALTER TABLE public.aod_indexevent_audit OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 23425)
-- Name: aok_knowledge_base_categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.aok_knowledge_base_categories (
    id character(36) NOT NULL,
    name character varying(255),
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    modified_user_id character(36),
    created_by character(36),
    description text,
    deleted boolean DEFAULT false,
    assigned_user_id character(36)
);


ALTER TABLE public.aok_knowledge_base_categories OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 23432)
-- Name: aok_knowledge_base_categories_audit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.aok_knowledge_base_categories_audit (
    id character(36) NOT NULL,
    parent_id character(36) NOT NULL,
    date_created timestamp with time zone,
    created_by character varying(36),
    field_name character varying(100),
    data_type character varying(100),
    before_value_string character varying(255),
    after_value_string character varying(255),
    before_value_text text,
    after_value_text text
);


ALTER TABLE public.aok_knowledge_base_categories_audit OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 23407)
-- Name: aok_knowledgebase; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.aok_knowledgebase (
    id character(36) NOT NULL,
    name character varying(255),
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    modified_user_id character(36),
    created_by character(36),
    description text,
    deleted boolean DEFAULT false,
    assigned_user_id character(36),
    status character varying(100) DEFAULT 'Draft'::character varying,
    revision character varying(255),
    additional_info text,
    user_id_c character(36),
    user_id1_c character(36)
);


ALTER TABLE public.aok_knowledgebase OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 23415)
-- Name: aok_knowledgebase_audit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.aok_knowledgebase_audit (
    id character(36) NOT NULL,
    parent_id character(36) NOT NULL,
    date_created timestamp with time zone,
    created_by character varying(36),
    field_name character varying(100),
    data_type character varying(100),
    before_value_string character varying(255),
    after_value_string character varying(255),
    before_value_text text,
    after_value_text text
);


ALTER TABLE public.aok_knowledgebase_audit OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 23421)
-- Name: aok_knowledgebase_categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.aok_knowledgebase_categories (
    id character varying(36) NOT NULL,
    date_modified timestamp with time zone,
    deleted boolean DEFAULT false,
    aok_knowledgebase_id character varying(36),
    aok_knowledge_base_categories_id character varying(36)
);


ALTER TABLE public.aok_knowledgebase_categories OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 23438)
-- Name: aop_case_events; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.aop_case_events (
    id character(36) NOT NULL,
    name character varying(255),
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    modified_user_id character(36),
    created_by character(36),
    description text,
    deleted boolean DEFAULT false,
    assigned_user_id character(36),
    case_id character(36)
);


ALTER TABLE public.aop_case_events OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 23445)
-- Name: aop_case_events_audit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.aop_case_events_audit (
    id character(36) NOT NULL,
    parent_id character(36) NOT NULL,
    date_created timestamp with time zone,
    created_by character varying(36),
    field_name character varying(100),
    data_type character varying(100),
    before_value_string character varying(255),
    after_value_string character varying(255),
    before_value_text text,
    after_value_text text
);


ALTER TABLE public.aop_case_events_audit OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 23451)
-- Name: aop_case_updates; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.aop_case_updates (
    id character(36) NOT NULL,
    name character varying(255),
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    modified_user_id character(36),
    created_by character(36),
    description text,
    deleted boolean DEFAULT false,
    assigned_user_id character(36),
    case_id character(36),
    contact_id character(36),
    internal boolean
);


ALTER TABLE public.aop_case_updates OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 23458)
-- Name: aop_case_updates_audit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.aop_case_updates_audit (
    id character(36) NOT NULL,
    parent_id character(36) NOT NULL,
    date_created timestamp with time zone,
    created_by character varying(36),
    field_name character varying(100),
    data_type character varying(100),
    before_value_string character varying(255),
    after_value_string character varying(255),
    before_value_text text,
    after_value_text text
);


ALTER TABLE public.aop_case_updates_audit OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 23464)
-- Name: aor_charts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.aor_charts (
    id character(36) NOT NULL,
    name character varying(255),
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    modified_user_id character(36),
    created_by character(36),
    description text,
    deleted boolean DEFAULT false,
    aor_report_id character(36),
    type character varying(100),
    x_field bigint,
    y_field bigint
);


ALTER TABLE public.aor_charts OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 23471)
-- Name: aor_conditions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.aor_conditions (
    id character(36) NOT NULL,
    name character varying(255),
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    modified_user_id character(36),
    created_by character(36),
    description text,
    deleted boolean DEFAULT false,
    aor_report_id character(36),
    condition_order bigint,
    logic_op character varying(255),
    parenthesis character varying(255),
    module_path text,
    field character varying(100),
    operator character varying(100),
    value_type character varying(100),
    value character varying(255),
    parameter boolean
);


ALTER TABLE public.aor_conditions OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 23478)
-- Name: aor_fields; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.aor_fields (
    id character(36) NOT NULL,
    name character varying(255),
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    modified_user_id character(36),
    created_by character(36),
    description text,
    deleted boolean DEFAULT false,
    aor_report_id character(36),
    field_order bigint,
    module_path text,
    field character varying(100),
    display boolean,
    link boolean,
    label character varying(255),
    field_function character varying(100),
    sort_by character varying(100),
    format character varying(100),
    total character varying(100),
    sort_order character varying(100),
    group_by boolean,
    group_order character varying(100),
    group_display bigint
);


ALTER TABLE public.aor_fields OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 23485)
-- Name: aor_reports; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.aor_reports (
    id character(36) NOT NULL,
    name character varying(255),
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    modified_user_id character(36),
    created_by character(36),
    description text,
    deleted boolean DEFAULT false,
    assigned_user_id character(36),
    report_module character varying(100),
    graphs_per_row bigint DEFAULT '2'::bigint
);


ALTER TABLE public.aor_reports OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 23493)
-- Name: aor_reports_audit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.aor_reports_audit (
    id character(36) NOT NULL,
    parent_id character(36) NOT NULL,
    date_created timestamp with time zone,
    created_by character varying(36),
    field_name character varying(100),
    data_type character varying(100),
    before_value_string character varying(255),
    after_value_string character varying(255),
    before_value_text text,
    after_value_text text
);


ALTER TABLE public.aor_reports_audit OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 23499)
-- Name: aor_scheduled_reports; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.aor_scheduled_reports (
    id character(36) NOT NULL,
    name character varying(255),
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    modified_user_id character(36),
    created_by character(36),
    description text,
    deleted boolean DEFAULT false,
    schedule character varying(100),
    last_run timestamp with time zone,
    status character varying(100),
    email_recipients text,
    aor_report_id character(36)
);


ALTER TABLE public.aor_scheduled_reports OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 23506)
-- Name: aos_contracts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.aos_contracts (
    id character(36) NOT NULL,
    name character varying(255),
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    modified_user_id character(36),
    created_by character(36),
    description text,
    deleted boolean DEFAULT false,
    assigned_user_id character(36),
    reference_code character varying(255),
    start_date date,
    end_date date,
    total_contract_value numeric(26,6),
    total_contract_value_usdollar numeric(26,6),
    currency_id character(36),
    status character varying(100) DEFAULT 'Not Started'::character varying,
    customer_signed_date date,
    company_signed_date date,
    renewal_reminder_date timestamp with time zone,
    contract_type character varying(100) DEFAULT 'Type'::character varying,
    contract_account_id character(36),
    opportunity_id character(36),
    contact_id character(36),
    call_id character(36),
    total_amt numeric(26,6),
    total_amt_usdollar numeric(26,6),
    subtotal_amount numeric(26,6),
    subtotal_amount_usdollar numeric(26,6),
    discount_amount numeric(26,6),
    discount_amount_usdollar numeric(26,6),
    tax_amount numeric(26,6),
    tax_amount_usdollar numeric(26,6),
    shipping_amount numeric(26,6),
    shipping_amount_usdollar numeric(26,6),
    shipping_tax character varying(100),
    shipping_tax_amt numeric(26,6),
    shipping_tax_amt_usdollar numeric(26,6),
    total_amount numeric(26,6),
    total_amount_usdollar numeric(26,6)
);


ALTER TABLE public.aos_contracts OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 23515)
-- Name: aos_contracts_audit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.aos_contracts_audit (
    id character(36) NOT NULL,
    parent_id character(36) NOT NULL,
    date_created timestamp with time zone,
    created_by character varying(36),
    field_name character varying(100),
    data_type character varying(100),
    before_value_string character varying(255),
    after_value_string character varying(255),
    before_value_text text,
    after_value_text text
);


ALTER TABLE public.aos_contracts_audit OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 23521)
-- Name: aos_contracts_documents; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.aos_contracts_documents (
    id character varying(36) NOT NULL,
    date_modified timestamp with time zone,
    deleted boolean DEFAULT false,
    aos_contracts_id character varying(36),
    documents_id character varying(36),
    document_revision_id character varying(36)
);


ALTER TABLE public.aos_contracts_documents OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 23525)
-- Name: aos_invoices; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.aos_invoices (
    id character(36) NOT NULL,
    name character varying(255),
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    modified_user_id character(36),
    created_by character(36),
    description text,
    deleted boolean DEFAULT false,
    assigned_user_id character(36),
    billing_account_id character(36),
    billing_contact_id character(36),
    billing_address_street character varying(150),
    billing_address_city character varying(100),
    billing_address_state character varying(100),
    billing_address_postalcode character varying(20),
    billing_address_country character varying(255),
    shipping_address_street character varying(150),
    shipping_address_city character varying(100),
    shipping_address_state character varying(100),
    shipping_address_postalcode character varying(20),
    shipping_address_country character varying(255),
    number bigint NOT NULL,
    total_amt numeric(26,6),
    total_amt_usdollar numeric(26,6),
    subtotal_amount numeric(26,6),
    subtotal_amount_usdollar numeric(26,6),
    discount_amount numeric(26,6),
    discount_amount_usdollar numeric(26,6),
    tax_amount numeric(26,6),
    tax_amount_usdollar numeric(26,6),
    shipping_amount numeric(26,6),
    shipping_amount_usdollar numeric(26,6),
    shipping_tax character varying(100),
    shipping_tax_amt numeric(26,6),
    shipping_tax_amt_usdollar numeric(26,6),
    total_amount numeric(26,6),
    total_amount_usdollar numeric(26,6),
    currency_id character(36),
    quote_number bigint,
    quote_date date,
    invoice_date date,
    due_date date,
    status character varying(100),
    template_ddown_c text,
    subtotal_tax_amount numeric(26,6),
    subtotal_tax_amount_usdollar numeric(26,6)
);


ALTER TABLE public.aos_invoices OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 23532)
-- Name: aos_invoices_audit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.aos_invoices_audit (
    id character(36) NOT NULL,
    parent_id character(36) NOT NULL,
    date_created timestamp with time zone,
    created_by character varying(36),
    field_name character varying(100),
    data_type character varying(100),
    before_value_string character varying(255),
    after_value_string character varying(255),
    before_value_text text,
    after_value_text text
);


ALTER TABLE public.aos_invoices_audit OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 23538)
-- Name: aos_line_item_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.aos_line_item_groups (
    id character(36) NOT NULL,
    name character varying(255),
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    modified_user_id character(36),
    created_by character(36),
    description text,
    deleted boolean DEFAULT false,
    assigned_user_id character(36),
    total_amt numeric(26,6),
    total_amt_usdollar numeric(26,6),
    discount_amount numeric(26,6),
    discount_amount_usdollar numeric(26,6),
    subtotal_amount numeric(26,6),
    subtotal_amount_usdollar numeric(26,6),
    tax_amount numeric(26,6),
    tax_amount_usdollar numeric(26,6),
    subtotal_tax_amount numeric(26,6),
    subtotal_tax_amount_usdollar numeric(26,6),
    total_amount numeric(26,6),
    total_amount_usdollar numeric(26,6),
    parent_type character varying(100),
    parent_id character(36),
    number bigint,
    currency_id character(36)
);


ALTER TABLE public.aos_line_item_groups OWNER TO postgres;

--
-- TOC entry 245 (class 1259 OID 23545)
-- Name: aos_line_item_groups_audit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.aos_line_item_groups_audit (
    id character(36) NOT NULL,
    parent_id character(36) NOT NULL,
    date_created timestamp with time zone,
    created_by character varying(36),
    field_name character varying(100),
    data_type character varying(100),
    before_value_string character varying(255),
    after_value_string character varying(255),
    before_value_text text,
    after_value_text text
);


ALTER TABLE public.aos_line_item_groups_audit OWNER TO postgres;

--
-- TOC entry 246 (class 1259 OID 23551)
-- Name: aos_pdf_templates; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.aos_pdf_templates (
    id character(36) NOT NULL,
    name character varying(255),
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    modified_user_id character(36),
    created_by character(36),
    description text,
    deleted boolean DEFAULT false,
    assigned_user_id character(36),
    active boolean DEFAULT true,
    type character varying(100),
    pdfheader text,
    pdffooter text,
    margin_left bigint DEFAULT '15'::bigint,
    margin_right bigint DEFAULT '15'::bigint,
    margin_top bigint DEFAULT '16'::bigint,
    margin_bottom bigint DEFAULT '16'::bigint,
    margin_header bigint DEFAULT '9'::bigint,
    margin_footer bigint DEFAULT '9'::bigint
);


ALTER TABLE public.aos_pdf_templates OWNER TO postgres;

--
-- TOC entry 247 (class 1259 OID 23565)
-- Name: aos_pdf_templates_audit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.aos_pdf_templates_audit (
    id character(36) NOT NULL,
    parent_id character(36) NOT NULL,
    date_created timestamp with time zone,
    created_by character varying(36),
    field_name character varying(100),
    data_type character varying(100),
    before_value_string character varying(255),
    after_value_string character varying(255),
    before_value_text text,
    after_value_text text
);


ALTER TABLE public.aos_pdf_templates_audit OWNER TO postgres;

--
-- TOC entry 252 (class 1259 OID 23601)
-- Name: aos_product_categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.aos_product_categories (
    id character(36) NOT NULL,
    name character varying(255),
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    modified_user_id character(36),
    created_by character(36),
    description text,
    deleted boolean DEFAULT false,
    assigned_user_id character(36),
    is_parent boolean DEFAULT false,
    parent_category_id character(36)
);


ALTER TABLE public.aos_product_categories OWNER TO postgres;

--
-- TOC entry 253 (class 1259 OID 23609)
-- Name: aos_product_categories_audit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.aos_product_categories_audit (
    id character(36) NOT NULL,
    parent_id character(36) NOT NULL,
    date_created timestamp with time zone,
    created_by character varying(36),
    field_name character varying(100),
    data_type character varying(100),
    before_value_string character varying(255),
    after_value_string character varying(255),
    before_value_text text,
    after_value_text text
);


ALTER TABLE public.aos_product_categories_audit OWNER TO postgres;

--
-- TOC entry 248 (class 1259 OID 23571)
-- Name: aos_products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.aos_products (
    id character(36) NOT NULL,
    name character varying(255),
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    modified_user_id character(36),
    created_by character(36),
    description text,
    deleted boolean DEFAULT false,
    assigned_user_id character(36),
    maincode character varying(100) DEFAULT 'XXXX'::character varying,
    part_number character varying(25),
    category character varying(100),
    type character varying(100) DEFAULT 'Good'::character varying,
    cost numeric(26,6),
    cost_usdollar numeric(26,6),
    currency_id character(36),
    price numeric(26,6),
    price_usdollar numeric(26,6),
    url character varying(255),
    contact_id character(36),
    product_image character varying(255),
    aos_product_category_id character(36)
);


ALTER TABLE public.aos_products OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 23580)
-- Name: aos_products_audit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.aos_products_audit (
    id character(36) NOT NULL,
    parent_id character(36) NOT NULL,
    date_created timestamp with time zone,
    created_by character varying(36),
    field_name character varying(100),
    data_type character varying(100),
    before_value_string character varying(255),
    after_value_string character varying(255),
    before_value_text text,
    after_value_text text
);


ALTER TABLE public.aos_products_audit OWNER TO postgres;

--
-- TOC entry 250 (class 1259 OID 23586)
-- Name: aos_products_quotes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.aos_products_quotes (
    id character(36) NOT NULL,
    name text,
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    modified_user_id character(36),
    created_by character(36),
    description text,
    deleted boolean DEFAULT false,
    assigned_user_id character(36),
    currency_id character(36),
    part_number character varying(255),
    item_description text,
    number bigint,
    product_qty numeric(18,4),
    product_cost_price numeric(26,6),
    product_cost_price_usdollar numeric(26,6),
    product_list_price numeric(26,6),
    product_list_price_usdollar numeric(26,6),
    product_discount numeric(26,6),
    product_discount_usdollar numeric(26,6),
    product_discount_amount numeric(26,6),
    product_discount_amount_usdollar numeric(26,6),
    discount character varying(255) DEFAULT 'Percentage'::character varying,
    product_unit_price numeric(26,6),
    product_unit_price_usdollar numeric(26,6),
    vat_amt numeric(26,6),
    vat_amt_usdollar numeric(26,6),
    product_total_price numeric(26,6),
    product_total_price_usdollar numeric(26,6),
    vat character varying(100) DEFAULT '5.0'::character varying,
    parent_type character varying(100),
    parent_id character(36),
    product_id character(36),
    group_id character(36)
);


ALTER TABLE public.aos_products_quotes OWNER TO postgres;

--
-- TOC entry 251 (class 1259 OID 23595)
-- Name: aos_products_quotes_audit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.aos_products_quotes_audit (
    id character(36) NOT NULL,
    parent_id character(36) NOT NULL,
    date_created timestamp with time zone,
    created_by character varying(36),
    field_name character varying(100),
    data_type character varying(100),
    before_value_string character varying(255),
    after_value_string character varying(255),
    before_value_text text,
    after_value_text text
);


ALTER TABLE public.aos_products_quotes_audit OWNER TO postgres;

--
-- TOC entry 254 (class 1259 OID 23615)
-- Name: aos_quotes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.aos_quotes (
    id character(36) NOT NULL,
    name character varying(255),
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    modified_user_id character(36),
    created_by character(36),
    description text,
    deleted boolean DEFAULT false,
    assigned_user_id character(36),
    approval_issue text,
    billing_account_id character(36),
    billing_contact_id character(36),
    billing_address_street character varying(150),
    billing_address_city character varying(100),
    billing_address_state character varying(100),
    billing_address_postalcode character varying(20),
    billing_address_country character varying(255),
    shipping_address_street character varying(150),
    shipping_address_city character varying(100),
    shipping_address_state character varying(100),
    shipping_address_postalcode character varying(20),
    shipping_address_country character varying(255),
    expiration date,
    number bigint NOT NULL,
    opportunity_id character(36),
    template_ddown_c text,
    total_amt numeric(26,6),
    total_amt_usdollar numeric(26,6),
    subtotal_amount numeric(26,6),
    subtotal_amount_usdollar numeric(26,6),
    discount_amount numeric(26,6),
    discount_amount_usdollar numeric(26,6),
    tax_amount numeric(26,6),
    tax_amount_usdollar numeric(26,6),
    shipping_amount numeric(26,6),
    shipping_amount_usdollar numeric(26,6),
    shipping_tax character varying(100),
    shipping_tax_amt numeric(26,6),
    shipping_tax_amt_usdollar numeric(26,6),
    total_amount numeric(26,6),
    total_amount_usdollar numeric(26,6),
    currency_id character(36),
    stage character varying(100) DEFAULT 'Draft'::character varying,
    term character varying(100),
    terms_c text,
    approval_status character varying(100),
    invoice_status character varying(100) DEFAULT 'Not Invoiced'::character varying,
    subtotal_tax_amount numeric(26,6),
    subtotal_tax_amount_usdollar numeric(26,6)
);


ALTER TABLE public.aos_quotes OWNER TO postgres;

--
-- TOC entry 255 (class 1259 OID 23624)
-- Name: aos_quotes_aos_invoices_c; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.aos_quotes_aos_invoices_c (
    id character varying(36) NOT NULL,
    date_modified timestamp with time zone,
    deleted boolean DEFAULT false,
    aos_quotes77d9_quotes_ida character varying(36),
    aos_quotes6b83nvoices_idb character varying(36)
);


ALTER TABLE public.aos_quotes_aos_invoices_c OWNER TO postgres;

--
-- TOC entry 256 (class 1259 OID 23628)
-- Name: aos_quotes_audit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.aos_quotes_audit (
    id character(36) NOT NULL,
    parent_id character(36) NOT NULL,
    date_created timestamp with time zone,
    created_by character varying(36),
    field_name character varying(100),
    data_type character varying(100),
    before_value_string character varying(255),
    after_value_string character varying(255),
    before_value_text text,
    after_value_text text
);


ALTER TABLE public.aos_quotes_audit OWNER TO postgres;

--
-- TOC entry 257 (class 1259 OID 23634)
-- Name: aos_quotes_os_contracts_c; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.aos_quotes_os_contracts_c (
    id character varying(36) NOT NULL,
    date_modified timestamp with time zone,
    deleted boolean DEFAULT false,
    aos_quotese81e_quotes_ida character varying(36),
    aos_quotes4dc0ntracts_idb character varying(36)
);


ALTER TABLE public.aos_quotes_os_contracts_c OWNER TO postgres;

--
-- TOC entry 258 (class 1259 OID 23638)
-- Name: aos_quotes_project_c; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.aos_quotes_project_c (
    id character varying(36) NOT NULL,
    date_modified timestamp with time zone,
    deleted boolean DEFAULT false,
    aos_quotes1112_quotes_ida character varying(36),
    aos_quotes7207project_idb character varying(36)
);


ALTER TABLE public.aos_quotes_project_c OWNER TO postgres;

--
-- TOC entry 259 (class 1259 OID 23642)
-- Name: aow_actions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.aow_actions (
    id character(36) NOT NULL,
    name character varying(255),
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    modified_user_id character(36),
    created_by character(36),
    description text,
    deleted boolean DEFAULT false,
    aow_workflow_id character(36),
    action_order bigint,
    action character varying(100),
    parameters text
);


ALTER TABLE public.aow_actions OWNER TO postgres;

--
-- TOC entry 260 (class 1259 OID 23649)
-- Name: aow_conditions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.aow_conditions (
    id character(36) NOT NULL,
    name character varying(255),
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    modified_user_id character(36),
    created_by character(36),
    description text,
    deleted boolean DEFAULT false,
    aow_workflow_id character(36),
    condition_order bigint,
    module_path text,
    field character varying(100),
    operator character varying(100),
    value_type character varying(255),
    value character varying(255)
);


ALTER TABLE public.aow_conditions OWNER TO postgres;

--
-- TOC entry 261 (class 1259 OID 23656)
-- Name: aow_processed; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.aow_processed (
    id character(36) NOT NULL,
    name character varying(255),
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    modified_user_id character(36),
    created_by character(36),
    description text,
    deleted boolean DEFAULT false,
    aow_workflow_id character(36),
    parent_id character(36),
    parent_type character varying(100),
    status character varying(100) DEFAULT 'Pending'::character varying
);


ALTER TABLE public.aow_processed OWNER TO postgres;

--
-- TOC entry 262 (class 1259 OID 23664)
-- Name: aow_processed_aow_actions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.aow_processed_aow_actions (
    id character varying(36) NOT NULL,
    aow_processed_id character varying(36),
    aow_action_id character varying(36),
    status character varying(36) DEFAULT 'Pending'::character varying,
    date_modified timestamp with time zone,
    deleted boolean DEFAULT false
);


ALTER TABLE public.aow_processed_aow_actions OWNER TO postgres;

--
-- TOC entry 263 (class 1259 OID 23669)
-- Name: aow_workflow; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.aow_workflow (
    id character(36) NOT NULL,
    name character varying(255),
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    modified_user_id character(36),
    created_by character(36),
    description text,
    deleted boolean DEFAULT false,
    assigned_user_id character(36),
    flow_module character varying(100),
    flow_run_on character varying(100) DEFAULT '0'::character varying,
    status character varying(100) DEFAULT 'Active'::character varying,
    run_when character varying(100) DEFAULT 'Always'::character varying,
    multiple_runs boolean DEFAULT false
);


ALTER TABLE public.aow_workflow OWNER TO postgres;

--
-- TOC entry 264 (class 1259 OID 23680)
-- Name: aow_workflow_audit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.aow_workflow_audit (
    id character(36) NOT NULL,
    parent_id character(36) NOT NULL,
    date_created timestamp with time zone,
    created_by character varying(36),
    field_name character varying(100),
    data_type character varying(100),
    before_value_string character varying(255),
    after_value_string character varying(255),
    before_value_text text,
    after_value_text text
);


ALTER TABLE public.aow_workflow_audit OWNER TO postgres;

--
-- TOC entry 266 (class 1259 OID 23688)
-- Name: bugs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bugs (
    id character(36) NOT NULL,
    name character varying(255),
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    modified_user_id character(36),
    created_by character(36),
    description text,
    deleted boolean DEFAULT false,
    assigned_user_id character(36),
    bug_number bigint NOT NULL,
    type character varying(255),
    status character varying(100),
    priority character varying(100),
    resolution character varying(255),
    work_log text,
    found_in_release character varying(255),
    fixed_in_release character varying(255),
    source character varying(255),
    product_category character varying(255)
);


ALTER TABLE public.bugs OWNER TO postgres;

--
-- TOC entry 267 (class 1259 OID 23696)
-- Name: bugs_audit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bugs_audit (
    id character(36) NOT NULL,
    parent_id character(36) NOT NULL,
    date_created timestamp with time zone,
    created_by character varying(36),
    field_name character varying(100),
    data_type character varying(100),
    before_value_string character varying(255),
    after_value_string character varying(255),
    before_value_text text,
    after_value_text text
);


ALTER TABLE public.bugs_audit OWNER TO postgres;

--
-- TOC entry 265 (class 1259 OID 23686)
-- Name: bugs_bug_number_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bugs_bug_number_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bugs_bug_number_seq OWNER TO postgres;

--
-- TOC entry 5047 (class 0 OID 0)
-- Dependencies: 265
-- Name: bugs_bug_number_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bugs_bug_number_seq OWNED BY public.bugs.bug_number;


--
-- TOC entry 268 (class 1259 OID 23702)
-- Name: calls; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.calls (
    id character(36) NOT NULL,
    name character varying(50),
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    modified_user_id character(36),
    created_by character(36),
    description text,
    deleted boolean DEFAULT false,
    assigned_user_id character(36),
    duration_hours integer,
    duration_minutes integer,
    date_start timestamp with time zone,
    date_end timestamp with time zone,
    parent_type character varying(255),
    status character varying(100) DEFAULT 'Planned'::character varying,
    direction character varying(100),
    parent_id character(36),
    reminder_time bigint DEFAULT '-1'::bigint,
    email_reminder_time bigint DEFAULT '-1'::bigint,
    email_reminder_sent boolean DEFAULT false,
    outlook_id character varying(255),
    repeat_type character varying(36),
    repeat_interval integer DEFAULT 1,
    repeat_dow character varying(7),
    repeat_until date,
    repeat_count integer,
    repeat_parent_id character(36),
    recurring_source character varying(36)
);


ALTER TABLE public.calls OWNER TO postgres;

--
-- TOC entry 269 (class 1259 OID 23714)
-- Name: calls_contacts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.calls_contacts (
    id character varying(36) NOT NULL,
    call_id character varying(36),
    contact_id character varying(36),
    required character varying(1) DEFAULT '1'::character varying,
    accept_status character varying(25) DEFAULT 'none'::character varying,
    date_modified timestamp with time zone,
    deleted boolean DEFAULT false
);


ALTER TABLE public.calls_contacts OWNER TO postgres;

--
-- TOC entry 270 (class 1259 OID 23720)
-- Name: calls_leads; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.calls_leads (
    id character varying(36) NOT NULL,
    call_id character varying(36),
    lead_id character varying(36),
    required character varying(1) DEFAULT '1'::character varying,
    accept_status character varying(25) DEFAULT 'none'::character varying,
    date_modified timestamp with time zone,
    deleted boolean DEFAULT false
);


ALTER TABLE public.calls_leads OWNER TO postgres;

--
-- TOC entry 271 (class 1259 OID 23726)
-- Name: calls_reschedule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.calls_reschedule (
    id character(36) NOT NULL,
    name character varying(255),
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    modified_user_id character(36),
    created_by character(36),
    description text,
    deleted boolean DEFAULT false,
    assigned_user_id character(36),
    reason character varying(100),
    call_id character(36)
);


ALTER TABLE public.calls_reschedule OWNER TO postgres;

--
-- TOC entry 272 (class 1259 OID 23733)
-- Name: calls_reschedule_audit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.calls_reschedule_audit (
    id character(36) NOT NULL,
    parent_id character(36) NOT NULL,
    date_created timestamp with time zone,
    created_by character varying(36),
    field_name character varying(100),
    data_type character varying(100),
    before_value_string character varying(255),
    after_value_string character varying(255),
    before_value_text text,
    after_value_text text
);


ALTER TABLE public.calls_reschedule_audit OWNER TO postgres;

--
-- TOC entry 273 (class 1259 OID 23739)
-- Name: calls_users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.calls_users (
    id character varying(36) NOT NULL,
    call_id character varying(36),
    user_id character varying(36),
    required character varying(1) DEFAULT '1'::character varying,
    accept_status character varying(25) DEFAULT 'none'::character varying,
    date_modified timestamp with time zone,
    deleted boolean DEFAULT false
);


ALTER TABLE public.calls_users OWNER TO postgres;

--
-- TOC entry 277 (class 1259 OID 23764)
-- Name: campaign_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.campaign_log (
    id character(36) NOT NULL,
    campaign_id character(36),
    target_tracker_key character varying(36),
    target_id character varying(36),
    target_type character varying(100),
    activity_type character varying(100),
    activity_date timestamp with time zone,
    related_id character varying(36),
    related_type character varying(100),
    archived boolean DEFAULT false,
    hits bigint DEFAULT '0'::bigint,
    list_id character(36),
    deleted boolean,
    date_modified timestamp with time zone,
    more_information character varying(100),
    marketing_id character(36)
);


ALTER TABLE public.campaign_log OWNER TO postgres;

--
-- TOC entry 279 (class 1259 OID 23774)
-- Name: campaign_trkrs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.campaign_trkrs (
    id character(36) NOT NULL,
    tracker_name character varying(30),
    tracker_url character varying(255) DEFAULT 'http://'::character varying,
    tracker_key bigint NOT NULL,
    campaign_id character(36),
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    modified_user_id character(36),
    created_by character(36),
    is_optout boolean DEFAULT false,
    deleted boolean DEFAULT false
);


ALTER TABLE public.campaign_trkrs OWNER TO postgres;

--
-- TOC entry 278 (class 1259 OID 23772)
-- Name: campaign_trkrs_tracker_key_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.campaign_trkrs_tracker_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.campaign_trkrs_tracker_key_seq OWNER TO postgres;

--
-- TOC entry 5048 (class 0 OID 0)
-- Dependencies: 278
-- Name: campaign_trkrs_tracker_key_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.campaign_trkrs_tracker_key_seq OWNED BY public.campaign_trkrs.tracker_key;


--
-- TOC entry 275 (class 1259 OID 23747)
-- Name: campaigns; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.campaigns (
    id character(36) NOT NULL,
    name character varying(50),
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    modified_user_id character(36),
    created_by character(36),
    deleted boolean DEFAULT false,
    assigned_user_id character(36),
    tracker_key bigint NOT NULL,
    tracker_count bigint DEFAULT '0'::bigint,
    refer_url character varying(255) DEFAULT 'http://'::character varying,
    tracker_text character varying(255),
    start_date date,
    end_date date,
    status character varying(100),
    impressions bigint DEFAULT '0'::bigint,
    currency_id character(36),
    budget double precision,
    expected_cost double precision,
    actual_cost double precision,
    expected_revenue double precision,
    campaign_type character varying(100),
    objective text,
    content text,
    frequency character varying(100)
);


ALTER TABLE public.campaigns OWNER TO postgres;

--
-- TOC entry 276 (class 1259 OID 23758)
-- Name: campaigns_audit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.campaigns_audit (
    id character(36) NOT NULL,
    parent_id character(36) NOT NULL,
    date_created timestamp with time zone,
    created_by character varying(36),
    field_name character varying(100),
    data_type character varying(100),
    before_value_string character varying(255),
    after_value_string character varying(255),
    before_value_text text,
    after_value_text text
);


ALTER TABLE public.campaigns_audit OWNER TO postgres;

--
-- TOC entry 274 (class 1259 OID 23745)
-- Name: campaigns_tracker_key_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.campaigns_tracker_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.campaigns_tracker_key_seq OWNER TO postgres;

--
-- TOC entry 5049 (class 0 OID 0)
-- Dependencies: 274
-- Name: campaigns_tracker_key_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.campaigns_tracker_key_seq OWNED BY public.campaigns.tracker_key;


--
-- TOC entry 281 (class 1259 OID 23783)
-- Name: cases; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cases (
    id character(36) NOT NULL,
    name character varying(255),
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    modified_user_id character(36),
    created_by character(36),
    description text,
    deleted boolean DEFAULT false,
    assigned_user_id character(36),
    case_number bigint NOT NULL,
    type character varying(255),
    status character varying(100),
    priority character varying(100),
    resolution text,
    work_log text,
    account_id character(36),
    state character varying(100) DEFAULT 'Open'::character varying,
    contact_created_by_id character(36)
);


ALTER TABLE public.cases OWNER TO postgres;

--
-- TOC entry 282 (class 1259 OID 23792)
-- Name: cases_audit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cases_audit (
    id character(36) NOT NULL,
    parent_id character(36) NOT NULL,
    date_created timestamp with time zone,
    created_by character varying(36),
    field_name character varying(100),
    data_type character varying(100),
    before_value_string character varying(255),
    after_value_string character varying(255),
    before_value_text text,
    after_value_text text
);


ALTER TABLE public.cases_audit OWNER TO postgres;

--
-- TOC entry 283 (class 1259 OID 23798)
-- Name: cases_bugs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cases_bugs (
    id character varying(36) NOT NULL,
    case_id character varying(36),
    bug_id character varying(36),
    date_modified timestamp with time zone,
    deleted boolean DEFAULT false
);


ALTER TABLE public.cases_bugs OWNER TO postgres;

--
-- TOC entry 280 (class 1259 OID 23781)
-- Name: cases_case_number_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cases_case_number_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cases_case_number_seq OWNER TO postgres;

--
-- TOC entry 5050 (class 0 OID 0)
-- Dependencies: 280
-- Name: cases_case_number_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cases_case_number_seq OWNED BY public.cases.case_number;


--
-- TOC entry 284 (class 1259 OID 23802)
-- Name: cases_cstm; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cases_cstm (
    id_c character(36) NOT NULL,
    jjwg_maps_lng_c double precision DEFAULT '0'::double precision,
    jjwg_maps_lat_c double precision DEFAULT '0'::double precision,
    jjwg_maps_geocode_status_c character varying(255),
    jjwg_maps_address_c character varying(255)
);


ALTER TABLE public.cases_cstm OWNER TO postgres;

--
-- TOC entry 285 (class 1259 OID 23810)
-- Name: config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.config (
    category character varying(32),
    name character varying(32),
    value text
);


ALTER TABLE public.config OWNER TO postgres;

--
-- TOC entry 286 (class 1259 OID 23816)
-- Name: contacts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contacts (
    id character(36) NOT NULL,
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    modified_user_id character(36),
    created_by character(36),
    description text,
    deleted boolean DEFAULT false,
    assigned_user_id character(36),
    salutation character varying(255),
    first_name character varying(100),
    last_name character varying(100),
    title character varying(100),
    photo character varying(255),
    department character varying(255),
    do_not_call boolean DEFAULT false,
    phone_home character varying(100),
    phone_mobile character varying(100),
    phone_work character varying(100),
    phone_other character varying(100),
    phone_fax character varying(100),
    primary_address_street character varying(150),
    primary_address_city character varying(100),
    primary_address_state character varying(100),
    primary_address_postalcode character varying(20),
    primary_address_country character varying(255),
    alt_address_street character varying(150),
    alt_address_city character varying(100),
    alt_address_state character varying(100),
    alt_address_postalcode character varying(20),
    alt_address_country character varying(255),
    assistant character varying(75),
    assistant_phone character varying(100),
    lead_source character varying(255),
    reports_to_id character(36),
    birthdate date,
    campaign_id character(36),
    joomla_account_id character varying(255),
    portal_account_disabled boolean,
    portal_user_type character varying(100) DEFAULT 'Single'::character varying
);


ALTER TABLE public.contacts OWNER TO postgres;

--
-- TOC entry 287 (class 1259 OID 23825)
-- Name: contacts_audit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contacts_audit (
    id character(36) NOT NULL,
    parent_id character(36) NOT NULL,
    date_created timestamp with time zone,
    created_by character varying(36),
    field_name character varying(100),
    data_type character varying(100),
    before_value_string character varying(255),
    after_value_string character varying(255),
    before_value_text text,
    after_value_text text
);


ALTER TABLE public.contacts_audit OWNER TO postgres;

--
-- TOC entry 288 (class 1259 OID 23831)
-- Name: contacts_bugs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contacts_bugs (
    id character varying(36) NOT NULL,
    contact_id character varying(36),
    bug_id character varying(36),
    contact_role character varying(50),
    date_modified timestamp with time zone,
    deleted boolean DEFAULT false
);


ALTER TABLE public.contacts_bugs OWNER TO postgres;

--
-- TOC entry 289 (class 1259 OID 23835)
-- Name: contacts_cases; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contacts_cases (
    id character varying(36) NOT NULL,
    contact_id character varying(36),
    case_id character varying(36),
    contact_role character varying(50),
    date_modified timestamp with time zone,
    deleted boolean DEFAULT false
);


ALTER TABLE public.contacts_cases OWNER TO postgres;

--
-- TOC entry 290 (class 1259 OID 23839)
-- Name: contacts_cstm; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contacts_cstm (
    id_c character(36) NOT NULL,
    jjwg_maps_lng_c double precision DEFAULT '0'::double precision,
    jjwg_maps_lat_c double precision DEFAULT '0'::double precision,
    jjwg_maps_geocode_status_c character varying(255),
    jjwg_maps_address_c character varying(255)
);


ALTER TABLE public.contacts_cstm OWNER TO postgres;

--
-- TOC entry 291 (class 1259 OID 23847)
-- Name: contacts_users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contacts_users (
    id character varying(36) NOT NULL,
    contact_id character varying(36),
    user_id character varying(36),
    date_modified timestamp with time zone,
    deleted boolean DEFAULT false
);


ALTER TABLE public.contacts_users OWNER TO postgres;

--
-- TOC entry 292 (class 1259 OID 23851)
-- Name: cron_remove_documents; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cron_remove_documents (
    id character varying(36) NOT NULL,
    bean_id character varying(36),
    module character varying(25),
    date_modified timestamp with time zone
);


ALTER TABLE public.cron_remove_documents OWNER TO postgres;

--
-- TOC entry 293 (class 1259 OID 23854)
-- Name: currencies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.currencies (
    id character(36) NOT NULL,
    name character varying(36),
    symbol character varying(36),
    iso4217 character varying(3),
    conversion_rate double precision DEFAULT '0'::double precision,
    status character varying(100),
    deleted boolean,
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    created_by character(36) NOT NULL
);


ALTER TABLE public.currencies OWNER TO postgres;

--
-- TOC entry 294 (class 1259 OID 23858)
-- Name: custom_fields; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.custom_fields (
    bean_id character varying(36),
    set_num bigint DEFAULT '0'::bigint,
    field0 character varying(255),
    field1 character varying(255),
    field2 character varying(255),
    field3 character varying(255),
    field4 character varying(255),
    field5 character varying(255),
    field6 character varying(255),
    field7 character varying(255),
    field8 character varying(255),
    field9 character varying(255),
    deleted boolean DEFAULT false
);


ALTER TABLE public.custom_fields OWNER TO postgres;

--
-- TOC entry 301 (class 1259 OID 23895)
-- Name: document_revisions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.document_revisions (
    id character varying(36) NOT NULL,
    change_log character varying(255),
    document_id character varying(36),
    doc_id character varying(100),
    doc_type character varying(100),
    doc_url character varying(255),
    date_entered timestamp with time zone,
    created_by character(36),
    filename character varying(255),
    file_ext character varying(100),
    file_mime_type character varying(100),
    revision character varying(100),
    deleted boolean DEFAULT false,
    date_modified timestamp with time zone
);


ALTER TABLE public.document_revisions OWNER TO postgres;

--
-- TOC entry 295 (class 1259 OID 23866)
-- Name: documents; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.documents (
    id character(36) NOT NULL,
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    modified_user_id character(36),
    created_by character(36),
    description text,
    deleted boolean DEFAULT false,
    assigned_user_id character(36),
    document_name character varying(255),
    doc_id character varying(100),
    doc_type character varying(100) DEFAULT 'Sugar'::character varying,
    doc_url character varying(255),
    active_date date,
    exp_date date,
    category_id character varying(100),
    subcategory_id character varying(100),
    status_id character varying(100),
    document_revision_id character varying(36),
    related_doc_id character(36),
    related_doc_rev_id character(36),
    is_template boolean DEFAULT false,
    template_type character varying(100)
);


ALTER TABLE public.documents OWNER TO postgres;

--
-- TOC entry 296 (class 1259 OID 23875)
-- Name: documents_accounts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.documents_accounts (
    id character varying(36) NOT NULL,
    date_modified timestamp with time zone,
    deleted boolean DEFAULT false,
    document_id character varying(36),
    account_id character varying(36)
);


ALTER TABLE public.documents_accounts OWNER TO postgres;

--
-- TOC entry 297 (class 1259 OID 23879)
-- Name: documents_bugs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.documents_bugs (
    id character varying(36) NOT NULL,
    date_modified timestamp with time zone,
    deleted boolean DEFAULT false,
    document_id character varying(36),
    bug_id character varying(36)
);


ALTER TABLE public.documents_bugs OWNER TO postgres;

--
-- TOC entry 298 (class 1259 OID 23883)
-- Name: documents_cases; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.documents_cases (
    id character varying(36) NOT NULL,
    date_modified timestamp with time zone,
    deleted boolean DEFAULT false,
    document_id character varying(36),
    case_id character varying(36)
);


ALTER TABLE public.documents_cases OWNER TO postgres;

--
-- TOC entry 299 (class 1259 OID 23887)
-- Name: documents_contacts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.documents_contacts (
    id character varying(36) NOT NULL,
    date_modified timestamp with time zone,
    deleted boolean DEFAULT false,
    document_id character varying(36),
    contact_id character varying(36)
);


ALTER TABLE public.documents_contacts OWNER TO postgres;

--
-- TOC entry 300 (class 1259 OID 23891)
-- Name: documents_opportunities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.documents_opportunities (
    id character varying(36) NOT NULL,
    date_modified timestamp with time zone,
    deleted boolean DEFAULT false,
    document_id character varying(36),
    opportunity_id character varying(36)
);


ALTER TABLE public.documents_opportunities OWNER TO postgres;

--
-- TOC entry 302 (class 1259 OID 23902)
-- Name: eapm; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.eapm (
    id character(36) NOT NULL,
    name character varying(255),
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    modified_user_id character(36),
    created_by character(36),
    description text,
    deleted boolean DEFAULT false,
    assigned_user_id character(36),
    password character varying(255),
    url character varying(255),
    application character varying(100) DEFAULT 'webex'::character varying,
    api_data text,
    consumer_key character varying(255),
    consumer_secret character varying(255),
    oauth_token character varying(255),
    oauth_secret character varying(255),
    validated boolean
);


ALTER TABLE public.eapm OWNER TO postgres;

--
-- TOC entry 310 (class 1259 OID 23953)
-- Name: email_addr_bean_rel; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.email_addr_bean_rel (
    id character(36) NOT NULL,
    email_address_id character(36) NOT NULL,
    bean_id character(36) NOT NULL,
    bean_module character varying(100),
    primary_address boolean DEFAULT false,
    reply_to_address boolean DEFAULT false,
    date_created timestamp with time zone,
    date_modified timestamp with time zone,
    deleted boolean DEFAULT false
);


ALTER TABLE public.email_addr_bean_rel OWNER TO postgres;

--
-- TOC entry 309 (class 1259 OID 23944)
-- Name: email_addresses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.email_addresses (
    id character(36) NOT NULL,
    email_address character varying(255),
    email_address_caps character varying(255),
    invalid_email boolean DEFAULT false,
    opt_out boolean DEFAULT false,
    date_created timestamp with time zone,
    date_modified timestamp with time zone,
    deleted boolean DEFAULT false
);


ALTER TABLE public.email_addresses OWNER TO postgres;

--
-- TOC entry 311 (class 1259 OID 23959)
-- Name: email_cache; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.email_cache (
    ie_id character(36),
    mbox character varying(60),
    subject character varying(255),
    fromaddr character varying(100),
    toaddr character varying(255),
    senddate timestamp with time zone,
    message_id character varying(255),
    mailsize bigint,
    imap_uid bigint,
    msgno bigint,
    recent smallint,
    flagged smallint,
    answered smallint,
    deleted smallint,
    seen smallint,
    draft smallint
);


ALTER TABLE public.email_cache OWNER TO postgres;

--
-- TOC entry 312 (class 1259 OID 23965)
-- Name: email_marketing; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.email_marketing (
    id character(36) NOT NULL,
    deleted boolean,
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    modified_user_id character(36),
    created_by character(36),
    name character varying(255),
    from_name character varying(100),
    from_addr character varying(100),
    reply_to_name character varying(100),
    reply_to_addr character varying(100),
    inbound_email_id character varying(36),
    date_start timestamp with time zone,
    template_id character(36) NOT NULL,
    status character varying(100),
    campaign_id character(36),
    outbound_email_id character(36),
    all_prospect_lists boolean DEFAULT false
);


ALTER TABLE public.email_marketing OWNER TO postgres;

--
-- TOC entry 313 (class 1259 OID 23972)
-- Name: email_marketing_prospect_lists; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.email_marketing_prospect_lists (
    id character varying(36) NOT NULL,
    prospect_list_id character varying(36),
    email_marketing_id character varying(36),
    date_modified timestamp with time zone,
    deleted boolean DEFAULT false
);


ALTER TABLE public.email_marketing_prospect_lists OWNER TO postgres;

--
-- TOC entry 314 (class 1259 OID 23976)
-- Name: email_templates; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.email_templates (
    id character(36) NOT NULL,
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    modified_user_id character(36),
    created_by character varying(36),
    published character varying(3),
    name character varying(255),
    description text,
    subject character varying(255),
    body text,
    body_html text,
    deleted boolean,
    assigned_user_id character(36),
    text_only boolean,
    type character varying(255)
);


ALTER TABLE public.email_templates OWNER TO postgres;

--
-- TOC entry 304 (class 1259 OID 23912)
-- Name: emailman; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.emailman (
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    user_id character(36),
    id bigint NOT NULL,
    campaign_id character(36),
    marketing_id character(36),
    list_id character(36),
    send_date_time timestamp with time zone,
    modified_user_id character(36),
    in_queue boolean DEFAULT false,
    in_queue_date timestamp with time zone,
    send_attempts bigint DEFAULT '0'::bigint,
    deleted boolean DEFAULT false,
    related_id character(36),
    related_type character varying(100)
);


ALTER TABLE public.emailman OWNER TO postgres;

--
-- TOC entry 303 (class 1259 OID 23910)
-- Name: emailman_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.emailman_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.emailman_id_seq OWNER TO postgres;

--
-- TOC entry 5051 (class 0 OID 0)
-- Dependencies: 303
-- Name: emailman_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.emailman_id_seq OWNED BY public.emailman.id;


--
-- TOC entry 305 (class 1259 OID 23919)
-- Name: emails; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.emails (
    id character(36) NOT NULL,
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    assigned_user_id character(36),
    modified_user_id character(36),
    created_by character(36),
    deleted boolean,
    date_sent timestamp with time zone,
    message_id character varying(255),
    name character varying(255),
    type character varying(100),
    status character varying(100),
    flagged boolean,
    reply_to_status boolean,
    intent character varying(100) DEFAULT 'pick'::character varying,
    mailbox_id character(36),
    parent_type character varying(100),
    parent_id character(36)
);


ALTER TABLE public.emails OWNER TO postgres;

--
-- TOC entry 306 (class 1259 OID 23926)
-- Name: emails_beans; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.emails_beans (
    id character(36) NOT NULL,
    email_id character(36),
    bean_id character(36),
    bean_module character varying(100),
    campaign_data text,
    date_modified timestamp with time zone,
    deleted boolean DEFAULT false
);


ALTER TABLE public.emails_beans OWNER TO postgres;

--
-- TOC entry 307 (class 1259 OID 23933)
-- Name: emails_email_addr_rel; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.emails_email_addr_rel (
    id character(36) NOT NULL,
    email_id character(36) NOT NULL,
    address_type character varying(4),
    email_address_id character(36) NOT NULL,
    deleted boolean DEFAULT false
);


ALTER TABLE public.emails_email_addr_rel OWNER TO postgres;

--
-- TOC entry 308 (class 1259 OID 23937)
-- Name: emails_text; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.emails_text (
    email_id character(36) NOT NULL,
    from_addr character varying(255),
    reply_to_addr character varying(255),
    to_addrs text,
    cc_addrs text,
    bcc_addrs text,
    description text,
    description_html text,
    raw_source text,
    deleted boolean DEFAULT false
);


ALTER TABLE public.emails_text OWNER TO postgres;

--
-- TOC entry 315 (class 1259 OID 23982)
-- Name: favorites; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.favorites (
    id character(36) NOT NULL,
    name character varying(255),
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    modified_user_id character(36),
    created_by character(36),
    description text,
    deleted boolean DEFAULT false,
    assigned_user_id character(36),
    parent_id character(36),
    parent_type character varying(255)
);


ALTER TABLE public.favorites OWNER TO postgres;

--
-- TOC entry 316 (class 1259 OID 23989)
-- Name: fields_meta_data; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fields_meta_data (
    id character varying(255) NOT NULL,
    name character varying(255),
    vname character varying(255),
    comments character varying(255),
    help character varying(255),
    custom_module character varying(255),
    type character varying(255),
    len bigint,
    required boolean DEFAULT false,
    default_value character varying(255),
    date_modified timestamp with time zone,
    deleted boolean DEFAULT false,
    audited boolean DEFAULT false,
    massupdate boolean DEFAULT false,
    duplicate_merge smallint DEFAULT '0'::smallint,
    reportable boolean DEFAULT true,
    importable character varying(255),
    ext1 character varying(255),
    ext2 character varying(255),
    ext3 character varying(255),
    ext4 text
);


ALTER TABLE public.fields_meta_data OWNER TO postgres;

--
-- TOC entry 317 (class 1259 OID 24001)
-- Name: folders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.folders (
    id character(36) NOT NULL,
    name character varying(25),
    folder_type character varying(25),
    parent_folder character(36),
    has_child boolean DEFAULT false,
    is_group boolean DEFAULT false,
    is_dynamic boolean DEFAULT false,
    dynamic_query text,
    assign_to_id character(36),
    created_by character(36) NOT NULL,
    modified_by character(36) NOT NULL,
    deleted boolean DEFAULT false
);


ALTER TABLE public.folders OWNER TO postgres;

--
-- TOC entry 318 (class 1259 OID 24011)
-- Name: folders_rel; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.folders_rel (
    id character(36) NOT NULL,
    folder_id character(36) NOT NULL,
    polymorphic_module character varying(25),
    polymorphic_id character(36) NOT NULL,
    deleted boolean DEFAULT false
);


ALTER TABLE public.folders_rel OWNER TO postgres;

--
-- TOC entry 319 (class 1259 OID 24015)
-- Name: folders_subscriptions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.folders_subscriptions (
    id character(36) NOT NULL,
    folder_id character(36) NOT NULL,
    assigned_user_id character(36) NOT NULL
);


ALTER TABLE public.folders_subscriptions OWNER TO postgres;

--
-- TOC entry 327 (class 1259 OID 24060)
-- Name: fp_event_locations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fp_event_locations (
    id character(36) NOT NULL,
    name character varying(255),
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    modified_user_id character(36),
    created_by character(36),
    description text,
    deleted boolean DEFAULT false,
    assigned_user_id character(36),
    address character varying(255),
    address_city character varying(100),
    address_country character varying(100),
    address_postalcode character varying(20),
    address_state character varying(100),
    capacity character varying(255)
);


ALTER TABLE public.fp_event_locations OWNER TO postgres;

--
-- TOC entry 328 (class 1259 OID 24067)
-- Name: fp_event_locations_audit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fp_event_locations_audit (
    id character(36) NOT NULL,
    parent_id character(36) NOT NULL,
    date_created timestamp with time zone,
    created_by character varying(36),
    field_name character varying(100),
    data_type character varying(100),
    before_value_string character varying(255),
    after_value_string character varying(255),
    before_value_text text,
    after_value_text text
);


ALTER TABLE public.fp_event_locations_audit OWNER TO postgres;

--
-- TOC entry 329 (class 1259 OID 24073)
-- Name: fp_event_locations_fp_events_1_c; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fp_event_locations_fp_events_1_c (
    id character varying(36) NOT NULL,
    date_modified timestamp with time zone,
    deleted boolean DEFAULT false,
    fp_event_locations_fp_events_1fp_event_locations_ida character varying(36),
    fp_event_locations_fp_events_1fp_events_idb character varying(36)
);


ALTER TABLE public.fp_event_locations_fp_events_1_c OWNER TO postgres;

--
-- TOC entry 320 (class 1259 OID 24018)
-- Name: fp_events; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fp_events (
    id character(36) NOT NULL,
    name character varying(255),
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    modified_user_id character(36),
    created_by character(36),
    description text,
    deleted boolean DEFAULT false,
    assigned_user_id character(36),
    duration_hours integer,
    duration_minutes integer,
    date_start timestamp with time zone,
    date_end timestamp with time zone,
    budget numeric(26,6),
    currency_id character(36),
    invite_templates character varying(100),
    accept_redirect character varying(255),
    decline_redirect character varying(255),
    activity_status_type character varying(255)
);


ALTER TABLE public.fp_events OWNER TO postgres;

--
-- TOC entry 321 (class 1259 OID 24025)
-- Name: fp_events_audit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fp_events_audit (
    id character(36) NOT NULL,
    parent_id character(36) NOT NULL,
    date_created timestamp with time zone,
    created_by character varying(36),
    field_name character varying(100),
    data_type character varying(100),
    before_value_string character varying(255),
    after_value_string character varying(255),
    before_value_text text,
    after_value_text text
);


ALTER TABLE public.fp_events_audit OWNER TO postgres;

--
-- TOC entry 322 (class 1259 OID 24031)
-- Name: fp_events_contacts_c; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fp_events_contacts_c (
    id character varying(36) NOT NULL,
    date_modified timestamp with time zone,
    deleted boolean DEFAULT false,
    fp_events_contactsfp_events_ida character varying(36),
    fp_events_contactscontacts_idb character varying(36),
    invite_status character varying(25) DEFAULT 'Not Invited'::character varying,
    accept_status character varying(25) DEFAULT 'No Response'::character varying,
    email_responded integer DEFAULT 0
);


ALTER TABLE public.fp_events_contacts_c OWNER TO postgres;

--
-- TOC entry 323 (class 1259 OID 24038)
-- Name: fp_events_fp_event_delegates_1_c; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fp_events_fp_event_delegates_1_c (
    id character varying(36) NOT NULL,
    date_modified timestamp with time zone,
    deleted boolean DEFAULT false,
    fp_events_fp_event_delegates_1fp_events_ida character varying(36),
    fp_events_fp_event_delegates_1fp_event_delegates_idb character varying(36)
);


ALTER TABLE public.fp_events_fp_event_delegates_1_c OWNER TO postgres;

--
-- TOC entry 324 (class 1259 OID 24042)
-- Name: fp_events_fp_event_locations_1_c; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fp_events_fp_event_locations_1_c (
    id character varying(36) NOT NULL,
    date_modified timestamp with time zone,
    deleted boolean DEFAULT false,
    fp_events_fp_event_locations_1fp_events_ida character varying(36),
    fp_events_fp_event_locations_1fp_event_locations_idb character varying(36)
);


ALTER TABLE public.fp_events_fp_event_locations_1_c OWNER TO postgres;

--
-- TOC entry 325 (class 1259 OID 24046)
-- Name: fp_events_leads_1_c; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fp_events_leads_1_c (
    id character varying(36) NOT NULL,
    date_modified timestamp with time zone,
    deleted boolean DEFAULT false,
    fp_events_leads_1fp_events_ida character varying(36),
    fp_events_leads_1leads_idb character varying(36),
    invite_status character varying(25) DEFAULT 'Not Invited'::character varying,
    accept_status character varying(25) DEFAULT 'No Response'::character varying,
    email_responded integer DEFAULT 0
);


ALTER TABLE public.fp_events_leads_1_c OWNER TO postgres;

--
-- TOC entry 326 (class 1259 OID 24053)
-- Name: fp_events_prospects_1_c; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fp_events_prospects_1_c (
    id character varying(36) NOT NULL,
    date_modified timestamp with time zone,
    deleted boolean DEFAULT false,
    fp_events_prospects_1fp_events_ida character varying(36),
    fp_events_prospects_1prospects_idb character varying(36),
    invite_status character varying(25) DEFAULT 'Not Invited'::character varying,
    accept_status character varying(25) DEFAULT 'No Response'::character varying,
    email_responded integer DEFAULT 0
);


ALTER TABLE public.fp_events_prospects_1_c OWNER TO postgres;

--
-- TOC entry 330 (class 1259 OID 24077)
-- Name: import_maps; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.import_maps (
    id character(36) NOT NULL,
    name character varying(254),
    source character varying(36),
    enclosure character varying(1) DEFAULT ' '::character varying,
    delimiter character varying(1) DEFAULT ','::character varying,
    module character varying(36),
    content text,
    default_values text,
    has_header boolean DEFAULT true,
    deleted boolean,
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    assigned_user_id character(36),
    is_published character varying(3) DEFAULT 'no'::character varying
);


ALTER TABLE public.import_maps OWNER TO postgres;

--
-- TOC entry 331 (class 1259 OID 24087)
-- Name: inbound_email; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inbound_email (
    id character varying(36) NOT NULL,
    deleted boolean DEFAULT false,
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    modified_user_id character(36),
    created_by character(36),
    name character varying(255),
    status character varying(100) DEFAULT 'Active'::character varying,
    server_url character varying(100),
    email_user character varying(100),
    email_password character varying(100),
    port integer,
    service character varying(50),
    mailbox text,
    delete_seen boolean DEFAULT false,
    mailbox_type character varying(10),
    template_id character(36),
    stored_options text,
    group_id character(36),
    is_personal boolean DEFAULT false,
    groupfolder_id character(36)
);


ALTER TABLE public.inbound_email OWNER TO postgres;

--
-- TOC entry 332 (class 1259 OID 24097)
-- Name: inbound_email_autoreply; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inbound_email_autoreply (
    id character(36) NOT NULL,
    deleted boolean DEFAULT false,
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    autoreplied_to character varying(100),
    ie_id character(36) NOT NULL
);


ALTER TABLE public.inbound_email_autoreply OWNER TO postgres;

--
-- TOC entry 333 (class 1259 OID 24101)
-- Name: inbound_email_cache_ts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inbound_email_cache_ts (
    id character varying(255) NOT NULL,
    ie_timestamp bigint
);


ALTER TABLE public.inbound_email_cache_ts OWNER TO postgres;

--
-- TOC entry 334 (class 1259 OID 24104)
-- Name: jjwg_address_cache; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.jjwg_address_cache (
    id character(36) NOT NULL,
    name character varying(255),
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    modified_user_id character(36),
    created_by character(36),
    description text,
    deleted boolean DEFAULT false,
    assigned_user_id character(36),
    lat double precision,
    lng double precision
);


ALTER TABLE public.jjwg_address_cache OWNER TO postgres;

--
-- TOC entry 335 (class 1259 OID 24111)
-- Name: jjwg_address_cache_audit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.jjwg_address_cache_audit (
    id character(36) NOT NULL,
    parent_id character(36) NOT NULL,
    date_created timestamp with time zone,
    created_by character varying(36),
    field_name character varying(100),
    data_type character varying(100),
    before_value_string character varying(255),
    after_value_string character varying(255),
    before_value_text text,
    after_value_text text
);


ALTER TABLE public.jjwg_address_cache_audit OWNER TO postgres;

--
-- TOC entry 336 (class 1259 OID 24117)
-- Name: jjwg_areas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.jjwg_areas (
    id character(36) NOT NULL,
    name character varying(255),
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    modified_user_id character(36),
    created_by character(36),
    description text,
    deleted boolean DEFAULT false,
    assigned_user_id character(36),
    city character varying(255),
    state character varying(255),
    country character varying(255),
    coordinates text
);


ALTER TABLE public.jjwg_areas OWNER TO postgres;

--
-- TOC entry 337 (class 1259 OID 24124)
-- Name: jjwg_areas_audit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.jjwg_areas_audit (
    id character(36) NOT NULL,
    parent_id character(36) NOT NULL,
    date_created timestamp with time zone,
    created_by character varying(36),
    field_name character varying(100),
    data_type character varying(100),
    before_value_string character varying(255),
    after_value_string character varying(255),
    before_value_text text,
    after_value_text text
);


ALTER TABLE public.jjwg_areas_audit OWNER TO postgres;

--
-- TOC entry 338 (class 1259 OID 24130)
-- Name: jjwg_maps; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.jjwg_maps (
    id character(36) NOT NULL,
    name character varying(255),
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    modified_user_id character(36),
    created_by character(36),
    description text,
    deleted boolean DEFAULT false,
    assigned_user_id character(36),
    distance double precision,
    unit_type character varying(100) DEFAULT 'mi'::character varying,
    module_type character varying(100) DEFAULT 'Accounts'::character varying,
    parent_type character varying(255),
    parent_id character(36)
);


ALTER TABLE public.jjwg_maps OWNER TO postgres;

--
-- TOC entry 339 (class 1259 OID 24139)
-- Name: jjwg_maps_audit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.jjwg_maps_audit (
    id character(36) NOT NULL,
    parent_id character(36) NOT NULL,
    date_created timestamp with time zone,
    created_by character varying(36),
    field_name character varying(100),
    data_type character varying(100),
    before_value_string character varying(255),
    after_value_string character varying(255),
    before_value_text text,
    after_value_text text
);


ALTER TABLE public.jjwg_maps_audit OWNER TO postgres;

--
-- TOC entry 340 (class 1259 OID 24145)
-- Name: jjwg_maps_jjwg_areas_c; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.jjwg_maps_jjwg_areas_c (
    id character varying(36) NOT NULL,
    date_modified timestamp with time zone,
    deleted boolean DEFAULT false,
    jjwg_maps_5304wg_maps_ida character varying(36),
    jjwg_maps_41f2g_areas_idb character varying(36)
);


ALTER TABLE public.jjwg_maps_jjwg_areas_c OWNER TO postgres;

--
-- TOC entry 341 (class 1259 OID 24149)
-- Name: jjwg_maps_jjwg_markers_c; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.jjwg_maps_jjwg_markers_c (
    id character varying(36) NOT NULL,
    date_modified timestamp with time zone,
    deleted boolean DEFAULT false,
    jjwg_maps_b229wg_maps_ida character varying(36),
    jjwg_maps_2e31markers_idb character varying(36)
);


ALTER TABLE public.jjwg_maps_jjwg_markers_c OWNER TO postgres;

--
-- TOC entry 342 (class 1259 OID 24153)
-- Name: jjwg_markers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.jjwg_markers (
    id character(36) NOT NULL,
    name character varying(255),
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    modified_user_id character(36),
    created_by character(36),
    description text,
    deleted boolean DEFAULT false,
    assigned_user_id character(36),
    city character varying(255),
    state character varying(255),
    country character varying(255),
    jjwg_maps_lat double precision DEFAULT '0'::double precision,
    jjwg_maps_lng double precision DEFAULT '0'::double precision,
    marker_image character varying(100) DEFAULT 'company'::character varying
);


ALTER TABLE public.jjwg_markers OWNER TO postgres;

--
-- TOC entry 343 (class 1259 OID 24163)
-- Name: jjwg_markers_audit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.jjwg_markers_audit (
    id character(36) NOT NULL,
    parent_id character(36) NOT NULL,
    date_created timestamp with time zone,
    created_by character varying(36),
    field_name character varying(100),
    data_type character varying(100),
    before_value_string character varying(255),
    after_value_string character varying(255),
    before_value_text text,
    after_value_text text
);


ALTER TABLE public.jjwg_markers_audit OWNER TO postgres;

--
-- TOC entry 344 (class 1259 OID 24169)
-- Name: job_queue; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.job_queue (
    assigned_user_id character(36),
    id character(36) NOT NULL,
    name character varying(255),
    deleted boolean DEFAULT false,
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    scheduler_id character(36),
    execute_time timestamp with time zone,
    status character varying(20),
    resolution character varying(20),
    message text,
    target character varying(255),
    data text,
    requeue boolean DEFAULT false,
    retry_count smallint,
    failure_count smallint,
    job_delay bigint,
    client character varying(255),
    percent_complete bigint
);


ALTER TABLE public.job_queue OWNER TO postgres;

--
-- TOC entry 345 (class 1259 OID 24177)
-- Name: leads; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.leads (
    id character(36) NOT NULL,
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    modified_user_id character(36),
    created_by character(36),
    description text,
    deleted boolean DEFAULT false,
    assigned_user_id character(36),
    salutation character varying(255),
    first_name character varying(100),
    last_name character varying(100),
    title character varying(100),
    photo character varying(255),
    department character varying(100),
    do_not_call boolean DEFAULT false,
    phone_home character varying(100),
    phone_mobile character varying(100),
    phone_work character varying(100),
    phone_other character varying(100),
    phone_fax character varying(100),
    primary_address_street character varying(150),
    primary_address_city character varying(100),
    primary_address_state character varying(100),
    primary_address_postalcode character varying(20),
    primary_address_country character varying(255),
    alt_address_street character varying(150),
    alt_address_city character varying(100),
    alt_address_state character varying(100),
    alt_address_postalcode character varying(20),
    alt_address_country character varying(255),
    assistant character varying(75),
    assistant_phone character varying(100),
    converted boolean DEFAULT false,
    refered_by character varying(100),
    lead_source character varying(100),
    lead_source_description text,
    status character varying(100),
    status_description text,
    reports_to_id character(36),
    account_name character varying(255),
    account_description text,
    contact_id character(36),
    account_id character(36),
    opportunity_id character(36),
    opportunity_name character varying(255),
    opportunity_amount character varying(50),
    campaign_id character(36),
    birthdate date,
    portal_name character varying(255),
    portal_app character varying(255),
    website character varying(255)
);


ALTER TABLE public.leads OWNER TO postgres;

--
-- TOC entry 346 (class 1259 OID 24186)
-- Name: leads_audit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.leads_audit (
    id character(36) NOT NULL,
    parent_id character(36) NOT NULL,
    date_created timestamp with time zone,
    created_by character varying(36),
    field_name character varying(100),
    data_type character varying(100),
    before_value_string character varying(255),
    after_value_string character varying(255),
    before_value_text text,
    after_value_text text
);


ALTER TABLE public.leads_audit OWNER TO postgres;

--
-- TOC entry 347 (class 1259 OID 24192)
-- Name: leads_cstm; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.leads_cstm (
    id_c character(36) NOT NULL,
    jjwg_maps_lng_c double precision DEFAULT '0'::double precision,
    jjwg_maps_lat_c double precision DEFAULT '0'::double precision,
    jjwg_maps_geocode_status_c character varying(255),
    jjwg_maps_address_c character varying(255)
);


ALTER TABLE public.leads_cstm OWNER TO postgres;

--
-- TOC entry 348 (class 1259 OID 24200)
-- Name: linked_documents; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.linked_documents (
    id character varying(36) NOT NULL,
    parent_id character varying(36),
    parent_type character varying(25),
    document_id character varying(36),
    document_revision_id character varying(36),
    date_modified timestamp with time zone,
    deleted boolean DEFAULT false
);


ALTER TABLE public.linked_documents OWNER TO postgres;

--
-- TOC entry 349 (class 1259 OID 24204)
-- Name: meetings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.meetings (
    id character(36) NOT NULL,
    name character varying(50),
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    modified_user_id character(36),
    created_by character(36),
    description text,
    deleted boolean DEFAULT false,
    assigned_user_id character(36),
    location character varying(50),
    password character varying(50),
    join_url character varying(200),
    host_url character varying(400),
    displayed_url character varying(400),
    creator character varying(50),
    external_id character varying(50),
    duration_hours integer,
    duration_minutes integer,
    date_start timestamp with time zone,
    date_end timestamp with time zone,
    parent_type character varying(100),
    status character varying(100) DEFAULT 'Planned'::character varying,
    type character varying(255) DEFAULT 'Sugar'::character varying,
    parent_id character(36),
    reminder_time bigint DEFAULT '-1'::bigint,
    email_reminder_time bigint DEFAULT '-1'::bigint,
    email_reminder_sent boolean DEFAULT false,
    outlook_id character varying(255),
    sequence bigint DEFAULT '0'::bigint,
    repeat_type character varying(36),
    repeat_interval integer DEFAULT 1,
    repeat_dow character varying(7),
    repeat_until date,
    repeat_count integer,
    repeat_parent_id character(36),
    recurring_source character varying(36)
);


ALTER TABLE public.meetings OWNER TO postgres;

--
-- TOC entry 350 (class 1259 OID 24218)
-- Name: meetings_contacts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.meetings_contacts (
    id character varying(36) NOT NULL,
    meeting_id character varying(36),
    contact_id character varying(36),
    required character varying(1) DEFAULT '1'::character varying,
    accept_status character varying(25) DEFAULT 'none'::character varying,
    date_modified timestamp with time zone,
    deleted boolean DEFAULT false
);


ALTER TABLE public.meetings_contacts OWNER TO postgres;

--
-- TOC entry 351 (class 1259 OID 24224)
-- Name: meetings_cstm; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.meetings_cstm (
    id_c character(36) NOT NULL,
    jjwg_maps_lng_c double precision DEFAULT '0'::double precision,
    jjwg_maps_lat_c double precision DEFAULT '0'::double precision,
    jjwg_maps_geocode_status_c character varying(255),
    jjwg_maps_address_c character varying(255)
);


ALTER TABLE public.meetings_cstm OWNER TO postgres;

--
-- TOC entry 352 (class 1259 OID 24232)
-- Name: meetings_leads; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.meetings_leads (
    id character varying(36) NOT NULL,
    meeting_id character varying(36),
    lead_id character varying(36),
    required character varying(1) DEFAULT '1'::character varying,
    accept_status character varying(25) DEFAULT 'none'::character varying,
    date_modified timestamp with time zone,
    deleted boolean DEFAULT false
);


ALTER TABLE public.meetings_leads OWNER TO postgres;

--
-- TOC entry 353 (class 1259 OID 24238)
-- Name: meetings_users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.meetings_users (
    id character varying(36) NOT NULL,
    meeting_id character varying(36),
    user_id character varying(36),
    required character varying(1) DEFAULT '1'::character varying,
    accept_status character varying(25) DEFAULT 'none'::character varying,
    date_modified timestamp with time zone,
    deleted boolean DEFAULT false
);


ALTER TABLE public.meetings_users OWNER TO postgres;

--
-- TOC entry 354 (class 1259 OID 24244)
-- Name: notes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notes (
    assigned_user_id character(36),
    id character(36) NOT NULL,
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    modified_user_id character(36),
    created_by character(36),
    name character varying(255),
    file_mime_type character varying(100),
    filename character varying(255),
    parent_type character varying(255),
    parent_id character(36),
    contact_id character(36),
    portal_flag boolean,
    embed_flag boolean DEFAULT false,
    description text,
    deleted boolean DEFAULT false
);


ALTER TABLE public.notes OWNER TO postgres;

--
-- TOC entry 355 (class 1259 OID 24252)
-- Name: oauth_consumer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oauth_consumer (
    id character(36) NOT NULL,
    name character varying(255),
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    modified_user_id character(36),
    created_by character(36),
    description text,
    deleted boolean DEFAULT false,
    assigned_user_id character(36),
    c_key character varying(255),
    c_secret character varying(255)
);


ALTER TABLE public.oauth_consumer OWNER TO postgres;

--
-- TOC entry 356 (class 1259 OID 24259)
-- Name: oauth_nonce; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oauth_nonce (
    conskey character varying(32) NOT NULL,
    nonce character varying(32) NOT NULL,
    nonce_ts numeric
);


ALTER TABLE public.oauth_nonce OWNER TO postgres;

--
-- TOC entry 357 (class 1259 OID 24265)
-- Name: oauth_tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oauth_tokens (
    id character(36) NOT NULL,
    secret character varying(32),
    tstate character varying(1),
    consumer character(36) NOT NULL,
    token_ts numeric,
    verify character varying(32),
    deleted boolean DEFAULT false NOT NULL,
    callback_url character varying(255),
    assigned_user_id character(36)
);


ALTER TABLE public.oauth_tokens OWNER TO postgres;

--
-- TOC entry 358 (class 1259 OID 24272)
-- Name: opportunities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.opportunities (
    id character(36) NOT NULL,
    name character varying(50),
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    modified_user_id character(36),
    created_by character(36),
    description text,
    deleted boolean DEFAULT false,
    assigned_user_id character(36),
    opportunity_type character varying(255),
    campaign_id character(36),
    lead_source character varying(50),
    amount double precision,
    amount_usdollar double precision,
    currency_id character(36),
    date_closed date,
    next_step character varying(100),
    sales_stage character varying(255),
    probability double precision
);


ALTER TABLE public.opportunities OWNER TO postgres;

--
-- TOC entry 359 (class 1259 OID 24279)
-- Name: opportunities_audit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.opportunities_audit (
    id character(36) NOT NULL,
    parent_id character(36) NOT NULL,
    date_created timestamp with time zone,
    created_by character varying(36),
    field_name character varying(100),
    data_type character varying(100),
    before_value_string character varying(255),
    after_value_string character varying(255),
    before_value_text text,
    after_value_text text
);


ALTER TABLE public.opportunities_audit OWNER TO postgres;

--
-- TOC entry 360 (class 1259 OID 24285)
-- Name: opportunities_contacts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.opportunities_contacts (
    id character varying(36) NOT NULL,
    contact_id character varying(36),
    opportunity_id character varying(36),
    contact_role character varying(50),
    date_modified timestamp with time zone,
    deleted boolean DEFAULT false
);


ALTER TABLE public.opportunities_contacts OWNER TO postgres;

--
-- TOC entry 361 (class 1259 OID 24289)
-- Name: opportunities_cstm; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.opportunities_cstm (
    id_c character(36) NOT NULL,
    jjwg_maps_lng_c double precision DEFAULT '0'::double precision,
    jjwg_maps_lat_c double precision DEFAULT '0'::double precision,
    jjwg_maps_geocode_status_c character varying(255),
    jjwg_maps_address_c character varying(255)
);


ALTER TABLE public.opportunities_cstm OWNER TO postgres;

--
-- TOC entry 362 (class 1259 OID 24297)
-- Name: outbound_email; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.outbound_email (
    id character(36) NOT NULL,
    name character varying(255),
    type character varying(15) DEFAULT 'user'::character varying,
    user_id character(36) NOT NULL,
    mail_sendtype character varying(8) DEFAULT 'smtp'::character varying,
    mail_smtptype character varying(20) DEFAULT 'other'::character varying,
    mail_smtpserver character varying(100),
    mail_smtpport integer DEFAULT 0,
    mail_smtpuser character varying(100),
    mail_smtppass character varying(100),
    mail_smtpauth_req boolean DEFAULT false,
    mail_smtpssl character varying(1) DEFAULT '0'::character varying,
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    modified_user_id character(36),
    created_by character(36),
    deleted boolean DEFAULT false,
    assigned_user_id character(36)
);


ALTER TABLE public.outbound_email OWNER TO postgres;

--
-- TOC entry 363 (class 1259 OID 24310)
-- Name: outbound_email_audit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.outbound_email_audit (
    id character(36) NOT NULL,
    parent_id character(36) NOT NULL,
    date_created timestamp with time zone,
    created_by character varying(36),
    field_name character varying(100),
    data_type character varying(100),
    before_value_string character varying(255),
    after_value_string character varying(255),
    before_value_text text,
    after_value_text text
);


ALTER TABLE public.outbound_email_audit OWNER TO postgres;

--
-- TOC entry 364 (class 1259 OID 24316)
-- Name: project; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.project (
    id character(36) NOT NULL,
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    assigned_user_id character(36),
    modified_user_id character(36),
    created_by character(36),
    name character varying(50),
    description text,
    deleted boolean DEFAULT false,
    estimated_start_date date,
    estimated_end_date date,
    status character varying(255),
    priority character varying(255),
    override_business_hours boolean DEFAULT false
);


ALTER TABLE public.project OWNER TO postgres;

--
-- TOC entry 371 (class 1259 OID 24348)
-- Name: project_contacts_1_c; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.project_contacts_1_c (
    id character varying(36) NOT NULL,
    date_modified timestamp with time zone,
    deleted boolean DEFAULT false,
    project_contacts_1project_ida character varying(36),
    project_contacts_1contacts_idb character varying(36)
);


ALTER TABLE public.project_contacts_1_c OWNER TO postgres;

--
-- TOC entry 372 (class 1259 OID 24352)
-- Name: project_cstm; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.project_cstm (
    id_c character(36) NOT NULL,
    jjwg_maps_lng_c double precision DEFAULT '0'::double precision,
    jjwg_maps_lat_c double precision DEFAULT '0'::double precision,
    jjwg_maps_geocode_status_c character varying(255),
    jjwg_maps_address_c character varying(255)
);


ALTER TABLE public.project_cstm OWNER TO postgres;

--
-- TOC entry 373 (class 1259 OID 24360)
-- Name: project_task; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.project_task (
    id character(36) NOT NULL,
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    project_id character(36) NOT NULL,
    project_task_id bigint,
    name character varying(50),
    status character varying(255),
    relationship_type character varying(255),
    description text,
    predecessors text,
    date_start date,
    time_start bigint,
    time_finish bigint,
    date_finish date,
    duration bigint,
    duration_unit text,
    actual_duration bigint,
    percent_complete bigint,
    date_due date,
    time_due time without time zone,
    parent_task_id bigint,
    assigned_user_id character(36),
    modified_user_id character(36),
    priority character varying(255),
    created_by character(36),
    milestone_flag boolean,
    order_number bigint DEFAULT '1'::bigint,
    task_number bigint,
    estimated_effort bigint,
    actual_effort bigint,
    deleted boolean DEFAULT false,
    utilization bigint DEFAULT '100'::bigint
);


ALTER TABLE public.project_task OWNER TO postgres;

--
-- TOC entry 374 (class 1259 OID 24369)
-- Name: project_task_audit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.project_task_audit (
    id character(36) NOT NULL,
    parent_id character(36) NOT NULL,
    date_created timestamp with time zone,
    created_by character varying(36),
    field_name character varying(100),
    data_type character varying(100),
    before_value_string character varying(255),
    after_value_string character varying(255),
    before_value_text text,
    after_value_text text
);


ALTER TABLE public.project_task_audit OWNER TO postgres;

--
-- TOC entry 375 (class 1259 OID 24375)
-- Name: project_users_1_c; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.project_users_1_c (
    id character varying(36) NOT NULL,
    date_modified timestamp with time zone,
    deleted boolean DEFAULT false,
    project_users_1project_ida character varying(36),
    project_users_1users_idb character varying(36)
);


ALTER TABLE public.project_users_1_c OWNER TO postgres;

--
-- TOC entry 365 (class 1259 OID 24324)
-- Name: projects_accounts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.projects_accounts (
    id character varying(36) NOT NULL,
    account_id character varying(36),
    project_id character varying(36),
    date_modified timestamp with time zone,
    deleted boolean DEFAULT false
);


ALTER TABLE public.projects_accounts OWNER TO postgres;

--
-- TOC entry 366 (class 1259 OID 24328)
-- Name: projects_bugs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.projects_bugs (
    id character varying(36) NOT NULL,
    bug_id character varying(36),
    project_id character varying(36),
    date_modified timestamp with time zone,
    deleted boolean DEFAULT false
);


ALTER TABLE public.projects_bugs OWNER TO postgres;

--
-- TOC entry 367 (class 1259 OID 24332)
-- Name: projects_cases; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.projects_cases (
    id character varying(36) NOT NULL,
    case_id character varying(36),
    project_id character varying(36),
    date_modified timestamp with time zone,
    deleted boolean DEFAULT false
);


ALTER TABLE public.projects_cases OWNER TO postgres;

--
-- TOC entry 368 (class 1259 OID 24336)
-- Name: projects_contacts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.projects_contacts (
    id character varying(36) NOT NULL,
    contact_id character varying(36),
    project_id character varying(36),
    date_modified timestamp with time zone,
    deleted boolean DEFAULT false
);


ALTER TABLE public.projects_contacts OWNER TO postgres;

--
-- TOC entry 369 (class 1259 OID 24340)
-- Name: projects_opportunities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.projects_opportunities (
    id character varying(36) NOT NULL,
    opportunity_id character varying(36),
    project_id character varying(36),
    date_modified timestamp with time zone,
    deleted boolean DEFAULT false
);


ALTER TABLE public.projects_opportunities OWNER TO postgres;

--
-- TOC entry 370 (class 1259 OID 24344)
-- Name: projects_products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.projects_products (
    id character varying(36) NOT NULL,
    product_id character varying(36),
    project_id character varying(36),
    date_modified timestamp with time zone,
    deleted boolean DEFAULT false
);


ALTER TABLE public.projects_products OWNER TO postgres;

--
-- TOC entry 381 (class 1259 OID 24408)
-- Name: prospect_list_campaigns; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.prospect_list_campaigns (
    id character varying(36) NOT NULL,
    prospect_list_id character varying(36),
    campaign_id character varying(36),
    date_modified timestamp with time zone,
    deleted boolean DEFAULT false
);


ALTER TABLE public.prospect_list_campaigns OWNER TO postgres;

--
-- TOC entry 379 (class 1259 OID 24398)
-- Name: prospect_lists; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.prospect_lists (
    assigned_user_id character(36),
    id character(36) NOT NULL,
    name character varying(50),
    list_type character varying(100),
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    modified_user_id character(36),
    created_by character(36),
    deleted boolean,
    description text,
    domain_name character varying(255)
);


ALTER TABLE public.prospect_lists OWNER TO postgres;

--
-- TOC entry 380 (class 1259 OID 24404)
-- Name: prospect_lists_prospects; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.prospect_lists_prospects (
    id character varying(36) NOT NULL,
    prospect_list_id character varying(36),
    related_id character varying(36),
    related_type character varying(25),
    date_modified timestamp with time zone,
    deleted boolean DEFAULT false
);


ALTER TABLE public.prospect_lists_prospects OWNER TO postgres;

--
-- TOC entry 377 (class 1259 OID 24381)
-- Name: prospects; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.prospects (
    id character(36) NOT NULL,
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    modified_user_id character(36),
    created_by character(36),
    description text,
    deleted boolean DEFAULT false,
    assigned_user_id character(36),
    salutation character varying(255),
    first_name character varying(100),
    last_name character varying(100),
    title character varying(100),
    photo character varying(255),
    department character varying(255),
    do_not_call boolean DEFAULT false,
    phone_home character varying(100),
    phone_mobile character varying(100),
    phone_work character varying(100),
    phone_other character varying(100),
    phone_fax character varying(100),
    primary_address_street character varying(150),
    primary_address_city character varying(100),
    primary_address_state character varying(100),
    primary_address_postalcode character varying(20),
    primary_address_country character varying(255),
    alt_address_street character varying(150),
    alt_address_city character varying(100),
    alt_address_state character varying(100),
    alt_address_postalcode character varying(20),
    alt_address_country character varying(255),
    assistant character varying(75),
    assistant_phone character varying(100),
    tracker_key bigint NOT NULL,
    birthdate date,
    lead_id character(36),
    account_name character varying(150),
    campaign_id character(36)
);


ALTER TABLE public.prospects OWNER TO postgres;

--
-- TOC entry 378 (class 1259 OID 24390)
-- Name: prospects_cstm; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.prospects_cstm (
    id_c character(36) NOT NULL,
    jjwg_maps_lng_c double precision DEFAULT '0'::double precision,
    jjwg_maps_lat_c double precision DEFAULT '0'::double precision,
    jjwg_maps_geocode_status_c character varying(255),
    jjwg_maps_address_c character varying(255)
);


ALTER TABLE public.prospects_cstm OWNER TO postgres;

--
-- TOC entry 376 (class 1259 OID 24379)
-- Name: prospects_tracker_key_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.prospects_tracker_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.prospects_tracker_key_seq OWNER TO postgres;

--
-- TOC entry 5052 (class 0 OID 0)
-- Dependencies: 376
-- Name: prospects_tracker_key_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.prospects_tracker_key_seq OWNED BY public.prospects.tracker_key;


--
-- TOC entry 382 (class 1259 OID 24412)
-- Name: relationships; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.relationships (
    id character(36) NOT NULL,
    relationship_name character varying(150),
    lhs_module character varying(100),
    lhs_table character varying(64),
    lhs_key character varying(64),
    rhs_module character varying(100),
    rhs_table character varying(64),
    rhs_key character varying(64),
    join_table character varying(64),
    join_key_lhs character varying(64),
    join_key_rhs character varying(64),
    relationship_type character varying(64),
    relationship_role_column character varying(64),
    relationship_role_column_value character varying(50),
    reverse boolean DEFAULT false,
    deleted boolean DEFAULT false
);


ALTER TABLE public.relationships OWNER TO postgres;

--
-- TOC entry 383 (class 1259 OID 24420)
-- Name: releases; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.releases (
    id character(36) NOT NULL,
    deleted boolean,
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    modified_user_id character(36),
    created_by character(36),
    name character varying(50),
    list_order integer,
    status character varying(100)
);


ALTER TABLE public.releases OWNER TO postgres;

--
-- TOC entry 384 (class 1259 OID 24423)
-- Name: reminders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reminders (
    id character(36) NOT NULL,
    name character varying(255),
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    modified_user_id character(36),
    created_by character(36),
    description text,
    deleted boolean DEFAULT false,
    assigned_user_id character(36),
    popup boolean,
    email boolean,
    email_sent boolean,
    timer_popup character varying(32),
    timer_email character varying(32),
    related_event_module character varying(32),
    related_event_module_id character(36) NOT NULL
);


ALTER TABLE public.reminders OWNER TO postgres;

--
-- TOC entry 385 (class 1259 OID 24430)
-- Name: reminders_invitees; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reminders_invitees (
    id character(36) NOT NULL,
    name character varying(255),
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    modified_user_id character(36),
    created_by character(36),
    description text,
    deleted boolean DEFAULT false,
    assigned_user_id character(36),
    reminder_id character(36) NOT NULL,
    related_invitee_module character varying(32),
    related_invitee_module_id character(36) NOT NULL
);


ALTER TABLE public.reminders_invitees OWNER TO postgres;

--
-- TOC entry 386 (class 1259 OID 24437)
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    id character(36) NOT NULL,
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    modified_user_id character(36),
    created_by character(36),
    name character varying(150),
    description text,
    modules text,
    deleted boolean
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- TOC entry 387 (class 1259 OID 24443)
-- Name: roles_modules; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles_modules (
    id character varying(36) NOT NULL,
    role_id character varying(36),
    module_id character varying(36),
    allow boolean DEFAULT false,
    date_modified timestamp with time zone,
    deleted boolean DEFAULT false
);


ALTER TABLE public.roles_modules OWNER TO postgres;

--
-- TOC entry 388 (class 1259 OID 24448)
-- Name: roles_users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles_users (
    id character varying(36) NOT NULL,
    role_id character varying(36),
    user_id character varying(36),
    date_modified timestamp with time zone,
    deleted boolean DEFAULT false
);


ALTER TABLE public.roles_users OWNER TO postgres;

--
-- TOC entry 389 (class 1259 OID 24452)
-- Name: saved_search; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.saved_search (
    id character(36) NOT NULL,
    name character varying(150),
    search_module character varying(150),
    deleted boolean,
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    assigned_user_id character(36),
    contents text,
    description text
);


ALTER TABLE public.saved_search OWNER TO postgres;

--
-- TOC entry 390 (class 1259 OID 24458)
-- Name: schedulers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schedulers (
    id character varying(36) NOT NULL,
    deleted boolean DEFAULT false,
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    created_by character(36),
    modified_user_id character(36),
    name character varying(255),
    job character varying(255),
    date_time_start timestamp with time zone,
    date_time_end timestamp with time zone,
    job_interval character varying(100),
    time_from time without time zone,
    time_to time without time zone,
    last_run timestamp with time zone,
    status character varying(100),
    catch_up boolean DEFAULT true
);


ALTER TABLE public.schedulers OWNER TO postgres;

--
-- TOC entry 391 (class 1259 OID 24466)
-- Name: securitygroups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.securitygroups (
    id character(36) NOT NULL,
    name character varying(255),
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    modified_user_id character(36),
    created_by character(36),
    description text,
    deleted boolean DEFAULT false,
    assigned_user_id character(36),
    noninheritable boolean
);


ALTER TABLE public.securitygroups OWNER TO postgres;

--
-- TOC entry 392 (class 1259 OID 24473)
-- Name: securitygroups_acl_roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.securitygroups_acl_roles (
    id character(36) NOT NULL,
    securitygroup_id character(36),
    role_id character(36),
    date_modified timestamp with time zone,
    deleted boolean DEFAULT false
);


ALTER TABLE public.securitygroups_acl_roles OWNER TO postgres;

--
-- TOC entry 393 (class 1259 OID 24477)
-- Name: securitygroups_audit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.securitygroups_audit (
    id character(36) NOT NULL,
    parent_id character(36) NOT NULL,
    date_created timestamp with time zone,
    created_by character varying(36),
    field_name character varying(100),
    data_type character varying(100),
    before_value_string character varying(255),
    after_value_string character varying(255),
    before_value_text text,
    after_value_text text
);


ALTER TABLE public.securitygroups_audit OWNER TO postgres;

--
-- TOC entry 394 (class 1259 OID 24483)
-- Name: securitygroups_default; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.securitygroups_default (
    id character(36) NOT NULL,
    securitygroup_id character(36),
    module character varying(50),
    date_modified timestamp with time zone,
    deleted boolean DEFAULT false
);


ALTER TABLE public.securitygroups_default OWNER TO postgres;

--
-- TOC entry 395 (class 1259 OID 24487)
-- Name: securitygroups_records; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.securitygroups_records (
    id character(36) NOT NULL,
    securitygroup_id character(36),
    record_id character(36),
    module character(36),
    date_modified timestamp with time zone,
    modified_user_id character(36),
    created_by character(36),
    deleted boolean DEFAULT false
);


ALTER TABLE public.securitygroups_records OWNER TO postgres;

--
-- TOC entry 396 (class 1259 OID 24491)
-- Name: securitygroups_users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.securitygroups_users (
    id character varying(36) NOT NULL,
    date_modified timestamp with time zone,
    deleted boolean DEFAULT false,
    securitygroup_id character varying(36),
    user_id character varying(36),
    primary_group boolean,
    noninheritable boolean DEFAULT false
);


ALTER TABLE public.securitygroups_users OWNER TO postgres;

--
-- TOC entry 397 (class 1259 OID 24496)
-- Name: spots; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.spots (
    id character(36) NOT NULL,
    name character varying(255),
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    modified_user_id character(36),
    created_by character(36),
    description text,
    deleted boolean DEFAULT false,
    assigned_user_id character(36),
    config text,
    type character varying(255)
);


ALTER TABLE public.spots OWNER TO postgres;

--
-- TOC entry 398 (class 1259 OID 24503)
-- Name: sugarfeed; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sugarfeed (
    id character(36) NOT NULL,
    name character varying(255),
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    modified_user_id character(36),
    created_by character(36),
    description text,
    deleted boolean DEFAULT false,
    assigned_user_id character(36),
    related_module character varying(100),
    related_id character(36),
    link_url character varying(255),
    link_type character varying(30)
);


ALTER TABLE public.sugarfeed OWNER TO postgres;

--
-- TOC entry 399 (class 1259 OID 24510)
-- Name: tasks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tasks (
    id character(36) NOT NULL,
    name character varying(50),
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    modified_user_id character(36),
    created_by character(36),
    description text,
    deleted boolean DEFAULT false,
    assigned_user_id character(36),
    status character varying(100) DEFAULT 'Not Started'::character varying,
    date_due_flag boolean DEFAULT false,
    date_due timestamp with time zone,
    date_start_flag boolean DEFAULT false,
    date_start timestamp with time zone,
    parent_type character varying(255),
    parent_id character(36),
    contact_id character(36),
    priority character varying(100)
);


ALTER TABLE public.tasks OWNER TO postgres;

--
-- TOC entry 400 (class 1259 OID 24520)
-- Name: templatesectionline; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.templatesectionline (
    id character(36) NOT NULL,
    name character varying(255),
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    modified_user_id character(36),
    created_by character(36),
    description text,
    deleted boolean DEFAULT false,
    thumbnail character varying(255),
    grp character varying(255),
    ord bigint
);


ALTER TABLE public.templatesectionline OWNER TO postgres;

--
-- TOC entry 402 (class 1259 OID 24529)
-- Name: tracker; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tracker (
    id bigint NOT NULL,
    monitor_id character(36) NOT NULL,
    user_id character varying(36),
    module_name character varying(255),
    item_id character varying(36),
    item_summary character varying(255),
    date_modified timestamp with time zone,
    action character varying(255),
    session_id character varying(36),
    visible boolean DEFAULT false,
    deleted boolean DEFAULT false
);


ALTER TABLE public.tracker OWNER TO postgres;

--
-- TOC entry 401 (class 1259 OID 24527)
-- Name: tracker_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tracker_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tracker_id_seq OWNER TO postgres;

--
-- TOC entry 5053 (class 0 OID 0)
-- Dependencies: 401
-- Name: tracker_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tracker_id_seq OWNED BY public.tracker.id;


--
-- TOC entry 403 (class 1259 OID 24538)
-- Name: upgrade_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.upgrade_history (
    id character(36) NOT NULL,
    filename character varying(255),
    md5sum character varying(32),
    type character varying(30),
    status character varying(50),
    version character varying(64),
    name character varying(255),
    description text,
    id_name character varying(255),
    manifest text,
    date_entered timestamp with time zone,
    enabled boolean DEFAULT true
);


ALTER TABLE public.upgrade_history OWNER TO postgres;

--
-- TOC entry 409 (class 1259 OID 24573)
-- Name: user_preferences; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_preferences (
    id character(36) NOT NULL,
    category character varying(50),
    deleted boolean DEFAULT false,
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    assigned_user_id character(36),
    contents text
);


ALTER TABLE public.user_preferences OWNER TO postgres;

--
-- TOC entry 404 (class 1259 OID 24545)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id character(36) NOT NULL,
    user_name character varying(60),
    user_hash character varying(255),
    system_generated_password boolean,
    pwd_last_changed timestamp with time zone,
    authenticate_id character varying(100),
    sugar_login boolean DEFAULT true,
    first_name character varying(30),
    last_name character varying(30),
    is_admin boolean DEFAULT false,
    external_auth_only boolean DEFAULT false,
    receive_notifications boolean DEFAULT true,
    description text,
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    modified_user_id character(36),
    created_by character(36),
    title character varying(50),
    photo character varying(255),
    department character varying(50),
    phone_home character varying(50),
    phone_mobile character varying(50),
    phone_work character varying(50),
    phone_other character varying(50),
    phone_fax character varying(50),
    status character varying(100),
    address_street character varying(150),
    address_city character varying(100),
    address_state character varying(100),
    address_country character varying(100),
    address_postalcode character varying(20),
    deleted boolean,
    portal_only boolean DEFAULT false,
    show_on_employees boolean DEFAULT true,
    employee_status character varying(100),
    messenger_id character varying(100),
    messenger_type character varying(100),
    reports_to_id character(36),
    is_group boolean
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 405 (class 1259 OID 24557)
-- Name: users_feeds; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users_feeds (
    user_id character varying(36),
    feed_id character varying(36),
    rank bigint,
    date_modified timestamp with time zone,
    deleted boolean DEFAULT false
);


ALTER TABLE public.users_feeds OWNER TO postgres;

--
-- TOC entry 406 (class 1259 OID 24561)
-- Name: users_last_import; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users_last_import (
    id character(36) NOT NULL,
    assigned_user_id character(36),
    import_module character varying(36),
    bean_type character varying(36),
    bean_id character(36),
    deleted boolean
);


ALTER TABLE public.users_last_import OWNER TO postgres;

--
-- TOC entry 407 (class 1259 OID 24564)
-- Name: users_password_link; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users_password_link (
    id character(36) NOT NULL,
    username character varying(36),
    date_generated timestamp with time zone,
    deleted boolean
);


ALTER TABLE public.users_password_link OWNER TO postgres;

--
-- TOC entry 408 (class 1259 OID 24567)
-- Name: users_signatures; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users_signatures (
    id character(36) NOT NULL,
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    deleted boolean,
    user_id character varying(36),
    name character varying(255),
    signature text,
    signature_html text
);


ALTER TABLE public.users_signatures OWNER TO postgres;

--
-- TOC entry 410 (class 1259 OID 24580)
-- Name: vcals; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vcals (
    id character(36) NOT NULL,
    deleted boolean,
    date_entered timestamp with time zone,
    date_modified timestamp with time zone,
    user_id character(36) NOT NULL,
    type character varying(100),
    source character varying(100),
    content text
);


ALTER TABLE public.vcals OWNER TO postgres;

--
-- TOC entry 3775 (class 2604 OID 23692)
-- Name: bugs bug_number; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bugs ALTER COLUMN bug_number SET DEFAULT nextval('public.bugs_bug_number_seq'::regclass);


--
-- TOC entry 3800 (class 2604 OID 23778)
-- Name: campaign_trkrs tracker_key; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.campaign_trkrs ALTER COLUMN tracker_key SET DEFAULT nextval('public.campaign_trkrs_tracker_key_seq'::regclass);


--
-- TOC entry 3793 (class 2604 OID 23751)
-- Name: campaigns tracker_key; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.campaigns ALTER COLUMN tracker_key SET DEFAULT nextval('public.campaigns_tracker_key_seq'::regclass);


--
-- TOC entry 3804 (class 2604 OID 23787)
-- Name: cases case_number; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cases ALTER COLUMN case_number SET DEFAULT nextval('public.cases_case_number_seq'::regclass);


--
-- TOC entry 3832 (class 2604 OID 23915)
-- Name: emailman id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.emailman ALTER COLUMN id SET DEFAULT nextval('public.emailman_id_seq'::regclass);


--
-- TOC entry 3955 (class 2604 OID 24386)
-- Name: prospects tracker_key; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prospects ALTER COLUMN tracker_key SET DEFAULT nextval('public.prospects_tracker_key_seq'::regclass);


--
-- TOC entry 3982 (class 2604 OID 24532)
-- Name: tracker id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tracker ALTER COLUMN id SET DEFAULT nextval('public.tracker_id_seq'::regclass);


--
-- TOC entry 4826 (class 0 OID 23255)
-- Dependencies: 198
-- Data for Name: accounts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.accounts (id, name, date_entered, date_modified, modified_user_id, created_by, description, deleted, assigned_user_id, account_type, industry, annual_revenue, phone_fax, billing_address_street, billing_address_city, billing_address_state, billing_address_postalcode, billing_address_country, rating, phone_office, phone_alternate, website, ownership, employees, ticker_symbol, shipping_address_street, shipping_address_city, shipping_address_state, shipping_address_postalcode, shipping_address_country, parent_id, sic_code, campaign_id) FROM stdin;
\.


--
-- TOC entry 4827 (class 0 OID 23262)
-- Dependencies: 199
-- Data for Name: accounts_audit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.accounts_audit (id, parent_id, date_created, created_by, field_name, data_type, before_value_string, after_value_string, before_value_text, after_value_text) FROM stdin;
\.


--
-- TOC entry 4828 (class 0 OID 23268)
-- Dependencies: 200
-- Data for Name: accounts_bugs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.accounts_bugs (id, account_id, bug_id, date_modified, deleted) FROM stdin;
\.


--
-- TOC entry 4829 (class 0 OID 23272)
-- Dependencies: 201
-- Data for Name: accounts_cases; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.accounts_cases (id, account_id, case_id, date_modified, deleted) FROM stdin;
\.


--
-- TOC entry 4830 (class 0 OID 23276)
-- Dependencies: 202
-- Data for Name: accounts_contacts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.accounts_contacts (id, contact_id, account_id, date_modified, deleted) FROM stdin;
\.


--
-- TOC entry 4831 (class 0 OID 23280)
-- Dependencies: 203
-- Data for Name: accounts_cstm; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.accounts_cstm (id_c, jjwg_maps_lng_c, jjwg_maps_lat_c, jjwg_maps_geocode_status_c, jjwg_maps_address_c) FROM stdin;
\.


--
-- TOC entry 4832 (class 0 OID 23288)
-- Dependencies: 204
-- Data for Name: accounts_opportunities; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.accounts_opportunities (id, opportunity_id, account_id, date_modified, deleted) FROM stdin;
\.


--
-- TOC entry 4833 (class 0 OID 23292)
-- Dependencies: 205
-- Data for Name: acl_actions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.acl_actions (id, date_entered, date_modified, modified_user_id, created_by, name, category, acltype, aclaccess, deleted) FROM stdin;
\.


--
-- TOC entry 4834 (class 0 OID 23295)
-- Dependencies: 206
-- Data for Name: acl_roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.acl_roles (id, date_entered, date_modified, modified_user_id, created_by, name, description, deleted) FROM stdin;
\.


--
-- TOC entry 4835 (class 0 OID 23301)
-- Dependencies: 207
-- Data for Name: acl_roles_actions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.acl_roles_actions (id, role_id, action_id, access_override, date_modified, deleted) FROM stdin;
\.


--
-- TOC entry 4836 (class 0 OID 23305)
-- Dependencies: 208
-- Data for Name: acl_roles_users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.acl_roles_users (id, role_id, user_id, date_modified, deleted) FROM stdin;
\.


--
-- TOC entry 4837 (class 0 OID 23309)
-- Dependencies: 209
-- Data for Name: address_book; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.address_book (assigned_user_id, bean, bean_id) FROM stdin;
\.


--
-- TOC entry 4838 (class 0 OID 23312)
-- Dependencies: 210
-- Data for Name: alerts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.alerts (id, name, date_entered, date_modified, modified_user_id, created_by, description, deleted, assigned_user_id, is_read, target_module, type, url_redirect) FROM stdin;
\.


--
-- TOC entry 4839 (class 0 OID 23319)
-- Dependencies: 211
-- Data for Name: am_projecttemplates; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.am_projecttemplates (id, name, date_entered, date_modified, modified_user_id, created_by, description, deleted, assigned_user_id, status, priority, override_business_hours) FROM stdin;
\.


--
-- TOC entry 4840 (class 0 OID 23329)
-- Dependencies: 212
-- Data for Name: am_projecttemplates_audit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.am_projecttemplates_audit (id, parent_id, date_created, created_by, field_name, data_type, before_value_string, after_value_string, before_value_text, after_value_text) FROM stdin;
\.


--
-- TOC entry 4841 (class 0 OID 23335)
-- Dependencies: 213
-- Data for Name: am_projecttemplates_contacts_1_c; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.am_projecttemplates_contacts_1_c (id, date_modified, deleted, am_projecttemplates_ida, contacts_idb) FROM stdin;
\.


--
-- TOC entry 4842 (class 0 OID 23339)
-- Dependencies: 214
-- Data for Name: am_projecttemplates_project_1_c; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.am_projecttemplates_project_1_c (id, date_modified, deleted, am_projecttemplates_project_1am_projecttemplates_ida, am_projecttemplates_project_1project_idb) FROM stdin;
\.


--
-- TOC entry 4843 (class 0 OID 23343)
-- Dependencies: 215
-- Data for Name: am_projecttemplates_users_1_c; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.am_projecttemplates_users_1_c (id, date_modified, deleted, am_projecttemplates_ida, users_idb) FROM stdin;
\.


--
-- TOC entry 4844 (class 0 OID 23347)
-- Dependencies: 216
-- Data for Name: am_tasktemplates; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.am_tasktemplates (id, name, date_entered, date_modified, modified_user_id, created_by, description, deleted, assigned_user_id, status, priority, percent_complete, predecessors, milestone_flag, relationship_type, task_number, order_number, estimated_effort, utilization, duration) FROM stdin;
\.


--
-- TOC entry 4845 (class 0 OID 23360)
-- Dependencies: 217
-- Data for Name: am_tasktemplates_am_projecttemplates_c; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.am_tasktemplates_am_projecttemplates_c (id, date_modified, deleted, am_tasktemplates_am_projecttemplatesam_projecttemplates_ida, am_tasktemplates_am_projecttemplatesam_tasktemplates_idb) FROM stdin;
\.


--
-- TOC entry 4846 (class 0 OID 23364)
-- Dependencies: 218
-- Data for Name: am_tasktemplates_audit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.am_tasktemplates_audit (id, parent_id, date_created, created_by, field_name, data_type, before_value_string, after_value_string, before_value_text, after_value_text) FROM stdin;
\.


--
-- TOC entry 4847 (class 0 OID 23370)
-- Dependencies: 219
-- Data for Name: aobh_businesshours; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.aobh_businesshours (id, name, date_entered, date_modified, modified_user_id, created_by, description, deleted, opening_hours, closing_hours, open, day) FROM stdin;
\.


--
-- TOC entry 4848 (class 0 OID 23380)
-- Dependencies: 220
-- Data for Name: aod_index; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.aod_index (id, name, date_entered, date_modified, modified_user_id, created_by, description, deleted, assigned_user_id, last_optimised, location) FROM stdin;
\.


--
-- TOC entry 4851 (class 0 OID 23401)
-- Dependencies: 223
-- Data for Name: aod_index_audit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.aod_index_audit (id, parent_id, date_created, created_by, field_name, data_type, before_value_string, after_value_string, before_value_text, after_value_text) FROM stdin;
\.


--
-- TOC entry 4849 (class 0 OID 23387)
-- Dependencies: 221
-- Data for Name: aod_indexevent; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.aod_indexevent (id, name, date_entered, date_modified, modified_user_id, created_by, description, deleted, assigned_user_id, error, success, record_id, record_module) FROM stdin;
\.


--
-- TOC entry 4850 (class 0 OID 23395)
-- Dependencies: 222
-- Data for Name: aod_indexevent_audit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.aod_indexevent_audit (id, parent_id, date_created, created_by, field_name, data_type, before_value_string, after_value_string, before_value_text, after_value_text) FROM stdin;
\.


--
-- TOC entry 4855 (class 0 OID 23425)
-- Dependencies: 227
-- Data for Name: aok_knowledge_base_categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.aok_knowledge_base_categories (id, name, date_entered, date_modified, modified_user_id, created_by, description, deleted, assigned_user_id) FROM stdin;
\.


--
-- TOC entry 4856 (class 0 OID 23432)
-- Dependencies: 228
-- Data for Name: aok_knowledge_base_categories_audit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.aok_knowledge_base_categories_audit (id, parent_id, date_created, created_by, field_name, data_type, before_value_string, after_value_string, before_value_text, after_value_text) FROM stdin;
\.


--
-- TOC entry 4852 (class 0 OID 23407)
-- Dependencies: 224
-- Data for Name: aok_knowledgebase; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.aok_knowledgebase (id, name, date_entered, date_modified, modified_user_id, created_by, description, deleted, assigned_user_id, status, revision, additional_info, user_id_c, user_id1_c) FROM stdin;
\.


--
-- TOC entry 4853 (class 0 OID 23415)
-- Dependencies: 225
-- Data for Name: aok_knowledgebase_audit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.aok_knowledgebase_audit (id, parent_id, date_created, created_by, field_name, data_type, before_value_string, after_value_string, before_value_text, after_value_text) FROM stdin;
\.


--
-- TOC entry 4854 (class 0 OID 23421)
-- Dependencies: 226
-- Data for Name: aok_knowledgebase_categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.aok_knowledgebase_categories (id, date_modified, deleted, aok_knowledgebase_id, aok_knowledge_base_categories_id) FROM stdin;
\.


--
-- TOC entry 4857 (class 0 OID 23438)
-- Dependencies: 229
-- Data for Name: aop_case_events; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.aop_case_events (id, name, date_entered, date_modified, modified_user_id, created_by, description, deleted, assigned_user_id, case_id) FROM stdin;
\.


--
-- TOC entry 4858 (class 0 OID 23445)
-- Dependencies: 230
-- Data for Name: aop_case_events_audit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.aop_case_events_audit (id, parent_id, date_created, created_by, field_name, data_type, before_value_string, after_value_string, before_value_text, after_value_text) FROM stdin;
\.


--
-- TOC entry 4859 (class 0 OID 23451)
-- Dependencies: 231
-- Data for Name: aop_case_updates; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.aop_case_updates (id, name, date_entered, date_modified, modified_user_id, created_by, description, deleted, assigned_user_id, case_id, contact_id, internal) FROM stdin;
\.


--
-- TOC entry 4860 (class 0 OID 23458)
-- Dependencies: 232
-- Data for Name: aop_case_updates_audit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.aop_case_updates_audit (id, parent_id, date_created, created_by, field_name, data_type, before_value_string, after_value_string, before_value_text, after_value_text) FROM stdin;
\.


--
-- TOC entry 4861 (class 0 OID 23464)
-- Dependencies: 233
-- Data for Name: aor_charts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.aor_charts (id, name, date_entered, date_modified, modified_user_id, created_by, description, deleted, aor_report_id, type, x_field, y_field) FROM stdin;
\.


--
-- TOC entry 4862 (class 0 OID 23471)
-- Dependencies: 234
-- Data for Name: aor_conditions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.aor_conditions (id, name, date_entered, date_modified, modified_user_id, created_by, description, deleted, aor_report_id, condition_order, logic_op, parenthesis, module_path, field, operator, value_type, value, parameter) FROM stdin;
\.


--
-- TOC entry 4863 (class 0 OID 23478)
-- Dependencies: 235
-- Data for Name: aor_fields; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.aor_fields (id, name, date_entered, date_modified, modified_user_id, created_by, description, deleted, aor_report_id, field_order, module_path, field, display, link, label, field_function, sort_by, format, total, sort_order, group_by, group_order, group_display) FROM stdin;
\.


--
-- TOC entry 4864 (class 0 OID 23485)
-- Dependencies: 236
-- Data for Name: aor_reports; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.aor_reports (id, name, date_entered, date_modified, modified_user_id, created_by, description, deleted, assigned_user_id, report_module, graphs_per_row) FROM stdin;
\.


--
-- TOC entry 4865 (class 0 OID 23493)
-- Dependencies: 237
-- Data for Name: aor_reports_audit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.aor_reports_audit (id, parent_id, date_created, created_by, field_name, data_type, before_value_string, after_value_string, before_value_text, after_value_text) FROM stdin;
\.


--
-- TOC entry 4866 (class 0 OID 23499)
-- Dependencies: 238
-- Data for Name: aor_scheduled_reports; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.aor_scheduled_reports (id, name, date_entered, date_modified, modified_user_id, created_by, description, deleted, schedule, last_run, status, email_recipients, aor_report_id) FROM stdin;
\.


--
-- TOC entry 4867 (class 0 OID 23506)
-- Dependencies: 239
-- Data for Name: aos_contracts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.aos_contracts (id, name, date_entered, date_modified, modified_user_id, created_by, description, deleted, assigned_user_id, reference_code, start_date, end_date, total_contract_value, total_contract_value_usdollar, currency_id, status, customer_signed_date, company_signed_date, renewal_reminder_date, contract_type, contract_account_id, opportunity_id, contact_id, call_id, total_amt, total_amt_usdollar, subtotal_amount, subtotal_amount_usdollar, discount_amount, discount_amount_usdollar, tax_amount, tax_amount_usdollar, shipping_amount, shipping_amount_usdollar, shipping_tax, shipping_tax_amt, shipping_tax_amt_usdollar, total_amount, total_amount_usdollar) FROM stdin;
\.


--
-- TOC entry 4868 (class 0 OID 23515)
-- Dependencies: 240
-- Data for Name: aos_contracts_audit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.aos_contracts_audit (id, parent_id, date_created, created_by, field_name, data_type, before_value_string, after_value_string, before_value_text, after_value_text) FROM stdin;
\.


--
-- TOC entry 4869 (class 0 OID 23521)
-- Dependencies: 241
-- Data for Name: aos_contracts_documents; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.aos_contracts_documents (id, date_modified, deleted, aos_contracts_id, documents_id, document_revision_id) FROM stdin;
\.


--
-- TOC entry 4870 (class 0 OID 23525)
-- Dependencies: 242
-- Data for Name: aos_invoices; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.aos_invoices (id, name, date_entered, date_modified, modified_user_id, created_by, description, deleted, assigned_user_id, billing_account_id, billing_contact_id, billing_address_street, billing_address_city, billing_address_state, billing_address_postalcode, billing_address_country, shipping_address_street, shipping_address_city, shipping_address_state, shipping_address_postalcode, shipping_address_country, number, total_amt, total_amt_usdollar, subtotal_amount, subtotal_amount_usdollar, discount_amount, discount_amount_usdollar, tax_amount, tax_amount_usdollar, shipping_amount, shipping_amount_usdollar, shipping_tax, shipping_tax_amt, shipping_tax_amt_usdollar, total_amount, total_amount_usdollar, currency_id, quote_number, quote_date, invoice_date, due_date, status, template_ddown_c, subtotal_tax_amount, subtotal_tax_amount_usdollar) FROM stdin;
\.


--
-- TOC entry 4871 (class 0 OID 23532)
-- Dependencies: 243
-- Data for Name: aos_invoices_audit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.aos_invoices_audit (id, parent_id, date_created, created_by, field_name, data_type, before_value_string, after_value_string, before_value_text, after_value_text) FROM stdin;
\.


--
-- TOC entry 4872 (class 0 OID 23538)
-- Dependencies: 244
-- Data for Name: aos_line_item_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.aos_line_item_groups (id, name, date_entered, date_modified, modified_user_id, created_by, description, deleted, assigned_user_id, total_amt, total_amt_usdollar, discount_amount, discount_amount_usdollar, subtotal_amount, subtotal_amount_usdollar, tax_amount, tax_amount_usdollar, subtotal_tax_amount, subtotal_tax_amount_usdollar, total_amount, total_amount_usdollar, parent_type, parent_id, number, currency_id) FROM stdin;
\.


--
-- TOC entry 4873 (class 0 OID 23545)
-- Dependencies: 245
-- Data for Name: aos_line_item_groups_audit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.aos_line_item_groups_audit (id, parent_id, date_created, created_by, field_name, data_type, before_value_string, after_value_string, before_value_text, after_value_text) FROM stdin;
\.


--
-- TOC entry 4874 (class 0 OID 23551)
-- Dependencies: 246
-- Data for Name: aos_pdf_templates; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.aos_pdf_templates (id, name, date_entered, date_modified, modified_user_id, created_by, description, deleted, assigned_user_id, active, type, pdfheader, pdffooter, margin_left, margin_right, margin_top, margin_bottom, margin_header, margin_footer) FROM stdin;
\.


--
-- TOC entry 4875 (class 0 OID 23565)
-- Dependencies: 247
-- Data for Name: aos_pdf_templates_audit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.aos_pdf_templates_audit (id, parent_id, date_created, created_by, field_name, data_type, before_value_string, after_value_string, before_value_text, after_value_text) FROM stdin;
\.


--
-- TOC entry 4880 (class 0 OID 23601)
-- Dependencies: 252
-- Data for Name: aos_product_categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.aos_product_categories (id, name, date_entered, date_modified, modified_user_id, created_by, description, deleted, assigned_user_id, is_parent, parent_category_id) FROM stdin;
\.


--
-- TOC entry 4881 (class 0 OID 23609)
-- Dependencies: 253
-- Data for Name: aos_product_categories_audit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.aos_product_categories_audit (id, parent_id, date_created, created_by, field_name, data_type, before_value_string, after_value_string, before_value_text, after_value_text) FROM stdin;
\.


--
-- TOC entry 4876 (class 0 OID 23571)
-- Dependencies: 248
-- Data for Name: aos_products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.aos_products (id, name, date_entered, date_modified, modified_user_id, created_by, description, deleted, assigned_user_id, maincode, part_number, category, type, cost, cost_usdollar, currency_id, price, price_usdollar, url, contact_id, product_image, aos_product_category_id) FROM stdin;
\.


--
-- TOC entry 4877 (class 0 OID 23580)
-- Dependencies: 249
-- Data for Name: aos_products_audit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.aos_products_audit (id, parent_id, date_created, created_by, field_name, data_type, before_value_string, after_value_string, before_value_text, after_value_text) FROM stdin;
\.


--
-- TOC entry 4878 (class 0 OID 23586)
-- Dependencies: 250
-- Data for Name: aos_products_quotes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.aos_products_quotes (id, name, date_entered, date_modified, modified_user_id, created_by, description, deleted, assigned_user_id, currency_id, part_number, item_description, number, product_qty, product_cost_price, product_cost_price_usdollar, product_list_price, product_list_price_usdollar, product_discount, product_discount_usdollar, product_discount_amount, product_discount_amount_usdollar, discount, product_unit_price, product_unit_price_usdollar, vat_amt, vat_amt_usdollar, product_total_price, product_total_price_usdollar, vat, parent_type, parent_id, product_id, group_id) FROM stdin;
\.


--
-- TOC entry 4879 (class 0 OID 23595)
-- Dependencies: 251
-- Data for Name: aos_products_quotes_audit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.aos_products_quotes_audit (id, parent_id, date_created, created_by, field_name, data_type, before_value_string, after_value_string, before_value_text, after_value_text) FROM stdin;
\.


--
-- TOC entry 4882 (class 0 OID 23615)
-- Dependencies: 254
-- Data for Name: aos_quotes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.aos_quotes (id, name, date_entered, date_modified, modified_user_id, created_by, description, deleted, assigned_user_id, approval_issue, billing_account_id, billing_contact_id, billing_address_street, billing_address_city, billing_address_state, billing_address_postalcode, billing_address_country, shipping_address_street, shipping_address_city, shipping_address_state, shipping_address_postalcode, shipping_address_country, expiration, number, opportunity_id, template_ddown_c, total_amt, total_amt_usdollar, subtotal_amount, subtotal_amount_usdollar, discount_amount, discount_amount_usdollar, tax_amount, tax_amount_usdollar, shipping_amount, shipping_amount_usdollar, shipping_tax, shipping_tax_amt, shipping_tax_amt_usdollar, total_amount, total_amount_usdollar, currency_id, stage, term, terms_c, approval_status, invoice_status, subtotal_tax_amount, subtotal_tax_amount_usdollar) FROM stdin;
\.


--
-- TOC entry 4883 (class 0 OID 23624)
-- Dependencies: 255
-- Data for Name: aos_quotes_aos_invoices_c; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.aos_quotes_aos_invoices_c (id, date_modified, deleted, aos_quotes77d9_quotes_ida, aos_quotes6b83nvoices_idb) FROM stdin;
\.


--
-- TOC entry 4884 (class 0 OID 23628)
-- Dependencies: 256
-- Data for Name: aos_quotes_audit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.aos_quotes_audit (id, parent_id, date_created, created_by, field_name, data_type, before_value_string, after_value_string, before_value_text, after_value_text) FROM stdin;
\.


--
-- TOC entry 4885 (class 0 OID 23634)
-- Dependencies: 257
-- Data for Name: aos_quotes_os_contracts_c; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.aos_quotes_os_contracts_c (id, date_modified, deleted, aos_quotese81e_quotes_ida, aos_quotes4dc0ntracts_idb) FROM stdin;
\.


--
-- TOC entry 4886 (class 0 OID 23638)
-- Dependencies: 258
-- Data for Name: aos_quotes_project_c; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.aos_quotes_project_c (id, date_modified, deleted, aos_quotes1112_quotes_ida, aos_quotes7207project_idb) FROM stdin;
\.


--
-- TOC entry 4887 (class 0 OID 23642)
-- Dependencies: 259
-- Data for Name: aow_actions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.aow_actions (id, name, date_entered, date_modified, modified_user_id, created_by, description, deleted, aow_workflow_id, action_order, action, parameters) FROM stdin;
\.


--
-- TOC entry 4888 (class 0 OID 23649)
-- Dependencies: 260
-- Data for Name: aow_conditions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.aow_conditions (id, name, date_entered, date_modified, modified_user_id, created_by, description, deleted, aow_workflow_id, condition_order, module_path, field, operator, value_type, value) FROM stdin;
\.


--
-- TOC entry 4889 (class 0 OID 23656)
-- Dependencies: 261
-- Data for Name: aow_processed; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.aow_processed (id, name, date_entered, date_modified, modified_user_id, created_by, description, deleted, aow_workflow_id, parent_id, parent_type, status) FROM stdin;
\.


--
-- TOC entry 4890 (class 0 OID 23664)
-- Dependencies: 262
-- Data for Name: aow_processed_aow_actions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.aow_processed_aow_actions (id, aow_processed_id, aow_action_id, status, date_modified, deleted) FROM stdin;
\.


--
-- TOC entry 4891 (class 0 OID 23669)
-- Dependencies: 263
-- Data for Name: aow_workflow; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.aow_workflow (id, name, date_entered, date_modified, modified_user_id, created_by, description, deleted, assigned_user_id, flow_module, flow_run_on, status, run_when, multiple_runs) FROM stdin;
\.


--
-- TOC entry 4892 (class 0 OID 23680)
-- Dependencies: 264
-- Data for Name: aow_workflow_audit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.aow_workflow_audit (id, parent_id, date_created, created_by, field_name, data_type, before_value_string, after_value_string, before_value_text, after_value_text) FROM stdin;
\.


--
-- TOC entry 4894 (class 0 OID 23688)
-- Dependencies: 266
-- Data for Name: bugs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.bugs (id, name, date_entered, date_modified, modified_user_id, created_by, description, deleted, assigned_user_id, bug_number, type, status, priority, resolution, work_log, found_in_release, fixed_in_release, source, product_category) FROM stdin;
\.


--
-- TOC entry 4895 (class 0 OID 23696)
-- Dependencies: 267
-- Data for Name: bugs_audit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.bugs_audit (id, parent_id, date_created, created_by, field_name, data_type, before_value_string, after_value_string, before_value_text, after_value_text) FROM stdin;
\.


--
-- TOC entry 4896 (class 0 OID 23702)
-- Dependencies: 268
-- Data for Name: calls; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.calls (id, name, date_entered, date_modified, modified_user_id, created_by, description, deleted, assigned_user_id, duration_hours, duration_minutes, date_start, date_end, parent_type, status, direction, parent_id, reminder_time, email_reminder_time, email_reminder_sent, outlook_id, repeat_type, repeat_interval, repeat_dow, repeat_until, repeat_count, repeat_parent_id, recurring_source) FROM stdin;
\.


--
-- TOC entry 4897 (class 0 OID 23714)
-- Dependencies: 269
-- Data for Name: calls_contacts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.calls_contacts (id, call_id, contact_id, required, accept_status, date_modified, deleted) FROM stdin;
\.


--
-- TOC entry 4898 (class 0 OID 23720)
-- Dependencies: 270
-- Data for Name: calls_leads; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.calls_leads (id, call_id, lead_id, required, accept_status, date_modified, deleted) FROM stdin;
\.


--
-- TOC entry 4899 (class 0 OID 23726)
-- Dependencies: 271
-- Data for Name: calls_reschedule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.calls_reschedule (id, name, date_entered, date_modified, modified_user_id, created_by, description, deleted, assigned_user_id, reason, call_id) FROM stdin;
\.


--
-- TOC entry 4900 (class 0 OID 23733)
-- Dependencies: 272
-- Data for Name: calls_reschedule_audit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.calls_reschedule_audit (id, parent_id, date_created, created_by, field_name, data_type, before_value_string, after_value_string, before_value_text, after_value_text) FROM stdin;
\.


--
-- TOC entry 4901 (class 0 OID 23739)
-- Dependencies: 273
-- Data for Name: calls_users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.calls_users (id, call_id, user_id, required, accept_status, date_modified, deleted) FROM stdin;
\.


--
-- TOC entry 4905 (class 0 OID 23764)
-- Dependencies: 277
-- Data for Name: campaign_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.campaign_log (id, campaign_id, target_tracker_key, target_id, target_type, activity_type, activity_date, related_id, related_type, archived, hits, list_id, deleted, date_modified, more_information, marketing_id) FROM stdin;
\.


--
-- TOC entry 4907 (class 0 OID 23774)
-- Dependencies: 279
-- Data for Name: campaign_trkrs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.campaign_trkrs (id, tracker_name, tracker_url, tracker_key, campaign_id, date_entered, date_modified, modified_user_id, created_by, is_optout, deleted) FROM stdin;
\.


--
-- TOC entry 4903 (class 0 OID 23747)
-- Dependencies: 275
-- Data for Name: campaigns; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.campaigns (id, name, date_entered, date_modified, modified_user_id, created_by, deleted, assigned_user_id, tracker_key, tracker_count, refer_url, tracker_text, start_date, end_date, status, impressions, currency_id, budget, expected_cost, actual_cost, expected_revenue, campaign_type, objective, content, frequency) FROM stdin;
\.


--
-- TOC entry 4904 (class 0 OID 23758)
-- Dependencies: 276
-- Data for Name: campaigns_audit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.campaigns_audit (id, parent_id, date_created, created_by, field_name, data_type, before_value_string, after_value_string, before_value_text, after_value_text) FROM stdin;
\.


--
-- TOC entry 4909 (class 0 OID 23783)
-- Dependencies: 281
-- Data for Name: cases; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cases (id, name, date_entered, date_modified, modified_user_id, created_by, description, deleted, assigned_user_id, case_number, type, status, priority, resolution, work_log, account_id, state, contact_created_by_id) FROM stdin;
\.


--
-- TOC entry 4910 (class 0 OID 23792)
-- Dependencies: 282
-- Data for Name: cases_audit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cases_audit (id, parent_id, date_created, created_by, field_name, data_type, before_value_string, after_value_string, before_value_text, after_value_text) FROM stdin;
\.


--
-- TOC entry 4911 (class 0 OID 23798)
-- Dependencies: 283
-- Data for Name: cases_bugs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cases_bugs (id, case_id, bug_id, date_modified, deleted) FROM stdin;
\.


--
-- TOC entry 4912 (class 0 OID 23802)
-- Dependencies: 284
-- Data for Name: cases_cstm; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cases_cstm (id_c, jjwg_maps_lng_c, jjwg_maps_lat_c, jjwg_maps_geocode_status_c, jjwg_maps_address_c) FROM stdin;
\.


--
-- TOC entry 4913 (class 0 OID 23810)
-- Dependencies: 285
-- Data for Name: config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.config (category, name, value) FROM stdin;
\.


--
-- TOC entry 4914 (class 0 OID 23816)
-- Dependencies: 286
-- Data for Name: contacts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contacts (id, date_entered, date_modified, modified_user_id, created_by, description, deleted, assigned_user_id, salutation, first_name, last_name, title, photo, department, do_not_call, phone_home, phone_mobile, phone_work, phone_other, phone_fax, primary_address_street, primary_address_city, primary_address_state, primary_address_postalcode, primary_address_country, alt_address_street, alt_address_city, alt_address_state, alt_address_postalcode, alt_address_country, assistant, assistant_phone, lead_source, reports_to_id, birthdate, campaign_id, joomla_account_id, portal_account_disabled, portal_user_type) FROM stdin;
\.


--
-- TOC entry 4915 (class 0 OID 23825)
-- Dependencies: 287
-- Data for Name: contacts_audit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contacts_audit (id, parent_id, date_created, created_by, field_name, data_type, before_value_string, after_value_string, before_value_text, after_value_text) FROM stdin;
\.


--
-- TOC entry 4916 (class 0 OID 23831)
-- Dependencies: 288
-- Data for Name: contacts_bugs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contacts_bugs (id, contact_id, bug_id, contact_role, date_modified, deleted) FROM stdin;
\.


--
-- TOC entry 4917 (class 0 OID 23835)
-- Dependencies: 289
-- Data for Name: contacts_cases; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contacts_cases (id, contact_id, case_id, contact_role, date_modified, deleted) FROM stdin;
\.


--
-- TOC entry 4918 (class 0 OID 23839)
-- Dependencies: 290
-- Data for Name: contacts_cstm; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contacts_cstm (id_c, jjwg_maps_lng_c, jjwg_maps_lat_c, jjwg_maps_geocode_status_c, jjwg_maps_address_c) FROM stdin;
\.


--
-- TOC entry 4919 (class 0 OID 23847)
-- Dependencies: 291
-- Data for Name: contacts_users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contacts_users (id, contact_id, user_id, date_modified, deleted) FROM stdin;
\.


--
-- TOC entry 4920 (class 0 OID 23851)
-- Dependencies: 292
-- Data for Name: cron_remove_documents; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cron_remove_documents (id, bean_id, module, date_modified) FROM stdin;
\.


--
-- TOC entry 4921 (class 0 OID 23854)
-- Dependencies: 293
-- Data for Name: currencies; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.currencies (id, name, symbol, iso4217, conversion_rate, status, deleted, date_entered, date_modified, created_by) FROM stdin;
\.


--
-- TOC entry 4922 (class 0 OID 23858)
-- Dependencies: 294
-- Data for Name: custom_fields; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.custom_fields (bean_id, set_num, field0, field1, field2, field3, field4, field5, field6, field7, field8, field9, deleted) FROM stdin;
\.


--
-- TOC entry 4929 (class 0 OID 23895)
-- Dependencies: 301
-- Data for Name: document_revisions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.document_revisions (id, change_log, document_id, doc_id, doc_type, doc_url, date_entered, created_by, filename, file_ext, file_mime_type, revision, deleted, date_modified) FROM stdin;
\.


--
-- TOC entry 4923 (class 0 OID 23866)
-- Dependencies: 295
-- Data for Name: documents; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.documents (id, date_entered, date_modified, modified_user_id, created_by, description, deleted, assigned_user_id, document_name, doc_id, doc_type, doc_url, active_date, exp_date, category_id, subcategory_id, status_id, document_revision_id, related_doc_id, related_doc_rev_id, is_template, template_type) FROM stdin;
\.


--
-- TOC entry 4924 (class 0 OID 23875)
-- Dependencies: 296
-- Data for Name: documents_accounts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.documents_accounts (id, date_modified, deleted, document_id, account_id) FROM stdin;
\.


--
-- TOC entry 4925 (class 0 OID 23879)
-- Dependencies: 297
-- Data for Name: documents_bugs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.documents_bugs (id, date_modified, deleted, document_id, bug_id) FROM stdin;
\.


--
-- TOC entry 4926 (class 0 OID 23883)
-- Dependencies: 298
-- Data for Name: documents_cases; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.documents_cases (id, date_modified, deleted, document_id, case_id) FROM stdin;
\.


--
-- TOC entry 4927 (class 0 OID 23887)
-- Dependencies: 299
-- Data for Name: documents_contacts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.documents_contacts (id, date_modified, deleted, document_id, contact_id) FROM stdin;
\.


--
-- TOC entry 4928 (class 0 OID 23891)
-- Dependencies: 300
-- Data for Name: documents_opportunities; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.documents_opportunities (id, date_modified, deleted, document_id, opportunity_id) FROM stdin;
\.


--
-- TOC entry 4930 (class 0 OID 23902)
-- Dependencies: 302
-- Data for Name: eapm; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.eapm (id, name, date_entered, date_modified, modified_user_id, created_by, description, deleted, assigned_user_id, password, url, application, api_data, consumer_key, consumer_secret, oauth_token, oauth_secret, validated) FROM stdin;
\.


--
-- TOC entry 4938 (class 0 OID 23953)
-- Dependencies: 310
-- Data for Name: email_addr_bean_rel; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.email_addr_bean_rel (id, email_address_id, bean_id, bean_module, primary_address, reply_to_address, date_created, date_modified, deleted) FROM stdin;
\.


--
-- TOC entry 4937 (class 0 OID 23944)
-- Dependencies: 309
-- Data for Name: email_addresses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.email_addresses (id, email_address, email_address_caps, invalid_email, opt_out, date_created, date_modified, deleted) FROM stdin;
\.


--
-- TOC entry 4939 (class 0 OID 23959)
-- Dependencies: 311
-- Data for Name: email_cache; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.email_cache (ie_id, mbox, subject, fromaddr, toaddr, senddate, message_id, mailsize, imap_uid, msgno, recent, flagged, answered, deleted, seen, draft) FROM stdin;
\.


--
-- TOC entry 4940 (class 0 OID 23965)
-- Dependencies: 312
-- Data for Name: email_marketing; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.email_marketing (id, deleted, date_entered, date_modified, modified_user_id, created_by, name, from_name, from_addr, reply_to_name, reply_to_addr, inbound_email_id, date_start, template_id, status, campaign_id, outbound_email_id, all_prospect_lists) FROM stdin;
\.


--
-- TOC entry 4941 (class 0 OID 23972)
-- Dependencies: 313
-- Data for Name: email_marketing_prospect_lists; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.email_marketing_prospect_lists (id, prospect_list_id, email_marketing_id, date_modified, deleted) FROM stdin;
\.


--
-- TOC entry 4942 (class 0 OID 23976)
-- Dependencies: 314
-- Data for Name: email_templates; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.email_templates (id, date_entered, date_modified, modified_user_id, created_by, published, name, description, subject, body, body_html, deleted, assigned_user_id, text_only, type) FROM stdin;
\.


--
-- TOC entry 4932 (class 0 OID 23912)
-- Dependencies: 304
-- Data for Name: emailman; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.emailman (date_entered, date_modified, user_id, id, campaign_id, marketing_id, list_id, send_date_time, modified_user_id, in_queue, in_queue_date, send_attempts, deleted, related_id, related_type) FROM stdin;
\.


--
-- TOC entry 4933 (class 0 OID 23919)
-- Dependencies: 305
-- Data for Name: emails; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.emails (id, date_entered, date_modified, assigned_user_id, modified_user_id, created_by, deleted, date_sent, message_id, name, type, status, flagged, reply_to_status, intent, mailbox_id, parent_type, parent_id) FROM stdin;
\.


--
-- TOC entry 4934 (class 0 OID 23926)
-- Dependencies: 306
-- Data for Name: emails_beans; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.emails_beans (id, email_id, bean_id, bean_module, campaign_data, date_modified, deleted) FROM stdin;
\.


--
-- TOC entry 4935 (class 0 OID 23933)
-- Dependencies: 307
-- Data for Name: emails_email_addr_rel; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.emails_email_addr_rel (id, email_id, address_type, email_address_id, deleted) FROM stdin;
\.


--
-- TOC entry 4936 (class 0 OID 23937)
-- Dependencies: 308
-- Data for Name: emails_text; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.emails_text (email_id, from_addr, reply_to_addr, to_addrs, cc_addrs, bcc_addrs, description, description_html, raw_source, deleted) FROM stdin;
\.


--
-- TOC entry 4943 (class 0 OID 23982)
-- Dependencies: 315
-- Data for Name: favorites; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.favorites (id, name, date_entered, date_modified, modified_user_id, created_by, description, deleted, assigned_user_id, parent_id, parent_type) FROM stdin;
\.


--
-- TOC entry 4944 (class 0 OID 23989)
-- Dependencies: 316
-- Data for Name: fields_meta_data; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fields_meta_data (id, name, vname, comments, help, custom_module, type, len, required, default_value, date_modified, deleted, audited, massupdate, duplicate_merge, reportable, importable, ext1, ext2, ext3, ext4) FROM stdin;
\.


--
-- TOC entry 4945 (class 0 OID 24001)
-- Dependencies: 317
-- Data for Name: folders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.folders (id, name, folder_type, parent_folder, has_child, is_group, is_dynamic, dynamic_query, assign_to_id, created_by, modified_by, deleted) FROM stdin;
\.


--
-- TOC entry 4946 (class 0 OID 24011)
-- Dependencies: 318
-- Data for Name: folders_rel; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.folders_rel (id, folder_id, polymorphic_module, polymorphic_id, deleted) FROM stdin;
\.


--
-- TOC entry 4947 (class 0 OID 24015)
-- Dependencies: 319
-- Data for Name: folders_subscriptions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.folders_subscriptions (id, folder_id, assigned_user_id) FROM stdin;
\.


--
-- TOC entry 4955 (class 0 OID 24060)
-- Dependencies: 327
-- Data for Name: fp_event_locations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fp_event_locations (id, name, date_entered, date_modified, modified_user_id, created_by, description, deleted, assigned_user_id, address, address_city, address_country, address_postalcode, address_state, capacity) FROM stdin;
\.


--
-- TOC entry 4956 (class 0 OID 24067)
-- Dependencies: 328
-- Data for Name: fp_event_locations_audit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fp_event_locations_audit (id, parent_id, date_created, created_by, field_name, data_type, before_value_string, after_value_string, before_value_text, after_value_text) FROM stdin;
\.


--
-- TOC entry 4957 (class 0 OID 24073)
-- Dependencies: 329
-- Data for Name: fp_event_locations_fp_events_1_c; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fp_event_locations_fp_events_1_c (id, date_modified, deleted, fp_event_locations_fp_events_1fp_event_locations_ida, fp_event_locations_fp_events_1fp_events_idb) FROM stdin;
\.


--
-- TOC entry 4948 (class 0 OID 24018)
-- Dependencies: 320
-- Data for Name: fp_events; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fp_events (id, name, date_entered, date_modified, modified_user_id, created_by, description, deleted, assigned_user_id, duration_hours, duration_minutes, date_start, date_end, budget, currency_id, invite_templates, accept_redirect, decline_redirect, activity_status_type) FROM stdin;
\.


--
-- TOC entry 4949 (class 0 OID 24025)
-- Dependencies: 321
-- Data for Name: fp_events_audit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fp_events_audit (id, parent_id, date_created, created_by, field_name, data_type, before_value_string, after_value_string, before_value_text, after_value_text) FROM stdin;
\.


--
-- TOC entry 4950 (class 0 OID 24031)
-- Dependencies: 322
-- Data for Name: fp_events_contacts_c; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fp_events_contacts_c (id, date_modified, deleted, fp_events_contactsfp_events_ida, fp_events_contactscontacts_idb, invite_status, accept_status, email_responded) FROM stdin;
\.


--
-- TOC entry 4951 (class 0 OID 24038)
-- Dependencies: 323
-- Data for Name: fp_events_fp_event_delegates_1_c; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fp_events_fp_event_delegates_1_c (id, date_modified, deleted, fp_events_fp_event_delegates_1fp_events_ida, fp_events_fp_event_delegates_1fp_event_delegates_idb) FROM stdin;
\.


--
-- TOC entry 4952 (class 0 OID 24042)
-- Dependencies: 324
-- Data for Name: fp_events_fp_event_locations_1_c; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fp_events_fp_event_locations_1_c (id, date_modified, deleted, fp_events_fp_event_locations_1fp_events_ida, fp_events_fp_event_locations_1fp_event_locations_idb) FROM stdin;
\.


--
-- TOC entry 4953 (class 0 OID 24046)
-- Dependencies: 325
-- Data for Name: fp_events_leads_1_c; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fp_events_leads_1_c (id, date_modified, deleted, fp_events_leads_1fp_events_ida, fp_events_leads_1leads_idb, invite_status, accept_status, email_responded) FROM stdin;
\.


--
-- TOC entry 4954 (class 0 OID 24053)
-- Dependencies: 326
-- Data for Name: fp_events_prospects_1_c; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fp_events_prospects_1_c (id, date_modified, deleted, fp_events_prospects_1fp_events_ida, fp_events_prospects_1prospects_idb, invite_status, accept_status, email_responded) FROM stdin;
\.


--
-- TOC entry 4958 (class 0 OID 24077)
-- Dependencies: 330
-- Data for Name: import_maps; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.import_maps (id, name, source, enclosure, delimiter, module, content, default_values, has_header, deleted, date_entered, date_modified, assigned_user_id, is_published) FROM stdin;
\.


--
-- TOC entry 4959 (class 0 OID 24087)
-- Dependencies: 331
-- Data for Name: inbound_email; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inbound_email (id, deleted, date_entered, date_modified, modified_user_id, created_by, name, status, server_url, email_user, email_password, port, service, mailbox, delete_seen, mailbox_type, template_id, stored_options, group_id, is_personal, groupfolder_id) FROM stdin;
\.


--
-- TOC entry 4960 (class 0 OID 24097)
-- Dependencies: 332
-- Data for Name: inbound_email_autoreply; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inbound_email_autoreply (id, deleted, date_entered, date_modified, autoreplied_to, ie_id) FROM stdin;
\.


--
-- TOC entry 4961 (class 0 OID 24101)
-- Dependencies: 333
-- Data for Name: inbound_email_cache_ts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inbound_email_cache_ts (id, ie_timestamp) FROM stdin;
\.


--
-- TOC entry 4962 (class 0 OID 24104)
-- Dependencies: 334
-- Data for Name: jjwg_address_cache; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.jjwg_address_cache (id, name, date_entered, date_modified, modified_user_id, created_by, description, deleted, assigned_user_id, lat, lng) FROM stdin;
\.


--
-- TOC entry 4963 (class 0 OID 24111)
-- Dependencies: 335
-- Data for Name: jjwg_address_cache_audit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.jjwg_address_cache_audit (id, parent_id, date_created, created_by, field_name, data_type, before_value_string, after_value_string, before_value_text, after_value_text) FROM stdin;
\.


--
-- TOC entry 4964 (class 0 OID 24117)
-- Dependencies: 336
-- Data for Name: jjwg_areas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.jjwg_areas (id, name, date_entered, date_modified, modified_user_id, created_by, description, deleted, assigned_user_id, city, state, country, coordinates) FROM stdin;
\.


--
-- TOC entry 4965 (class 0 OID 24124)
-- Dependencies: 337
-- Data for Name: jjwg_areas_audit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.jjwg_areas_audit (id, parent_id, date_created, created_by, field_name, data_type, before_value_string, after_value_string, before_value_text, after_value_text) FROM stdin;
\.


--
-- TOC entry 4966 (class 0 OID 24130)
-- Dependencies: 338
-- Data for Name: jjwg_maps; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.jjwg_maps (id, name, date_entered, date_modified, modified_user_id, created_by, description, deleted, assigned_user_id, distance, unit_type, module_type, parent_type, parent_id) FROM stdin;
\.


--
-- TOC entry 4967 (class 0 OID 24139)
-- Dependencies: 339
-- Data for Name: jjwg_maps_audit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.jjwg_maps_audit (id, parent_id, date_created, created_by, field_name, data_type, before_value_string, after_value_string, before_value_text, after_value_text) FROM stdin;
\.


--
-- TOC entry 4968 (class 0 OID 24145)
-- Dependencies: 340
-- Data for Name: jjwg_maps_jjwg_areas_c; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.jjwg_maps_jjwg_areas_c (id, date_modified, deleted, jjwg_maps_5304wg_maps_ida, jjwg_maps_41f2g_areas_idb) FROM stdin;
\.


--
-- TOC entry 4969 (class 0 OID 24149)
-- Dependencies: 341
-- Data for Name: jjwg_maps_jjwg_markers_c; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.jjwg_maps_jjwg_markers_c (id, date_modified, deleted, jjwg_maps_b229wg_maps_ida, jjwg_maps_2e31markers_idb) FROM stdin;
\.


--
-- TOC entry 4970 (class 0 OID 24153)
-- Dependencies: 342
-- Data for Name: jjwg_markers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.jjwg_markers (id, name, date_entered, date_modified, modified_user_id, created_by, description, deleted, assigned_user_id, city, state, country, jjwg_maps_lat, jjwg_maps_lng, marker_image) FROM stdin;
\.


--
-- TOC entry 4971 (class 0 OID 24163)
-- Dependencies: 343
-- Data for Name: jjwg_markers_audit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.jjwg_markers_audit (id, parent_id, date_created, created_by, field_name, data_type, before_value_string, after_value_string, before_value_text, after_value_text) FROM stdin;
\.


--
-- TOC entry 4972 (class 0 OID 24169)
-- Dependencies: 344
-- Data for Name: job_queue; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.job_queue (assigned_user_id, id, name, deleted, date_entered, date_modified, scheduler_id, execute_time, status, resolution, message, target, data, requeue, retry_count, failure_count, job_delay, client, percent_complete) FROM stdin;
\.


--
-- TOC entry 4973 (class 0 OID 24177)
-- Dependencies: 345
-- Data for Name: leads; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.leads (id, date_entered, date_modified, modified_user_id, created_by, description, deleted, assigned_user_id, salutation, first_name, last_name, title, photo, department, do_not_call, phone_home, phone_mobile, phone_work, phone_other, phone_fax, primary_address_street, primary_address_city, primary_address_state, primary_address_postalcode, primary_address_country, alt_address_street, alt_address_city, alt_address_state, alt_address_postalcode, alt_address_country, assistant, assistant_phone, converted, refered_by, lead_source, lead_source_description, status, status_description, reports_to_id, account_name, account_description, contact_id, account_id, opportunity_id, opportunity_name, opportunity_amount, campaign_id, birthdate, portal_name, portal_app, website) FROM stdin;
\.


--
-- TOC entry 4974 (class 0 OID 24186)
-- Dependencies: 346
-- Data for Name: leads_audit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.leads_audit (id, parent_id, date_created, created_by, field_name, data_type, before_value_string, after_value_string, before_value_text, after_value_text) FROM stdin;
\.


--
-- TOC entry 4975 (class 0 OID 24192)
-- Dependencies: 347
-- Data for Name: leads_cstm; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.leads_cstm (id_c, jjwg_maps_lng_c, jjwg_maps_lat_c, jjwg_maps_geocode_status_c, jjwg_maps_address_c) FROM stdin;
\.


--
-- TOC entry 4976 (class 0 OID 24200)
-- Dependencies: 348
-- Data for Name: linked_documents; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.linked_documents (id, parent_id, parent_type, document_id, document_revision_id, date_modified, deleted) FROM stdin;
\.


--
-- TOC entry 4977 (class 0 OID 24204)
-- Dependencies: 349
-- Data for Name: meetings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.meetings (id, name, date_entered, date_modified, modified_user_id, created_by, description, deleted, assigned_user_id, location, password, join_url, host_url, displayed_url, creator, external_id, duration_hours, duration_minutes, date_start, date_end, parent_type, status, type, parent_id, reminder_time, email_reminder_time, email_reminder_sent, outlook_id, sequence, repeat_type, repeat_interval, repeat_dow, repeat_until, repeat_count, repeat_parent_id, recurring_source) FROM stdin;
\.


--
-- TOC entry 4978 (class 0 OID 24218)
-- Dependencies: 350
-- Data for Name: meetings_contacts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.meetings_contacts (id, meeting_id, contact_id, required, accept_status, date_modified, deleted) FROM stdin;
\.


--
-- TOC entry 4979 (class 0 OID 24224)
-- Dependencies: 351
-- Data for Name: meetings_cstm; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.meetings_cstm (id_c, jjwg_maps_lng_c, jjwg_maps_lat_c, jjwg_maps_geocode_status_c, jjwg_maps_address_c) FROM stdin;
\.


--
-- TOC entry 4980 (class 0 OID 24232)
-- Dependencies: 352
-- Data for Name: meetings_leads; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.meetings_leads (id, meeting_id, lead_id, required, accept_status, date_modified, deleted) FROM stdin;
\.


--
-- TOC entry 4981 (class 0 OID 24238)
-- Dependencies: 353
-- Data for Name: meetings_users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.meetings_users (id, meeting_id, user_id, required, accept_status, date_modified, deleted) FROM stdin;
\.


--
-- TOC entry 4982 (class 0 OID 24244)
-- Dependencies: 354
-- Data for Name: notes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notes (assigned_user_id, id, date_entered, date_modified, modified_user_id, created_by, name, file_mime_type, filename, parent_type, parent_id, contact_id, portal_flag, embed_flag, description, deleted) FROM stdin;
\.


--
-- TOC entry 4983 (class 0 OID 24252)
-- Dependencies: 355
-- Data for Name: oauth_consumer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oauth_consumer (id, name, date_entered, date_modified, modified_user_id, created_by, description, deleted, assigned_user_id, c_key, c_secret) FROM stdin;
\.


--
-- TOC entry 4984 (class 0 OID 24259)
-- Dependencies: 356
-- Data for Name: oauth_nonce; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oauth_nonce (conskey, nonce, nonce_ts) FROM stdin;
\.


--
-- TOC entry 4985 (class 0 OID 24265)
-- Dependencies: 357
-- Data for Name: oauth_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oauth_tokens (id, secret, tstate, consumer, token_ts, verify, deleted, callback_url, assigned_user_id) FROM stdin;
\.


--
-- TOC entry 4986 (class 0 OID 24272)
-- Dependencies: 358
-- Data for Name: opportunities; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.opportunities (id, name, date_entered, date_modified, modified_user_id, created_by, description, deleted, assigned_user_id, opportunity_type, campaign_id, lead_source, amount, amount_usdollar, currency_id, date_closed, next_step, sales_stage, probability) FROM stdin;
\.


--
-- TOC entry 4987 (class 0 OID 24279)
-- Dependencies: 359
-- Data for Name: opportunities_audit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.opportunities_audit (id, parent_id, date_created, created_by, field_name, data_type, before_value_string, after_value_string, before_value_text, after_value_text) FROM stdin;
\.


--
-- TOC entry 4988 (class 0 OID 24285)
-- Dependencies: 360
-- Data for Name: opportunities_contacts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.opportunities_contacts (id, contact_id, opportunity_id, contact_role, date_modified, deleted) FROM stdin;
\.


--
-- TOC entry 4989 (class 0 OID 24289)
-- Dependencies: 361
-- Data for Name: opportunities_cstm; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.opportunities_cstm (id_c, jjwg_maps_lng_c, jjwg_maps_lat_c, jjwg_maps_geocode_status_c, jjwg_maps_address_c) FROM stdin;
\.


--
-- TOC entry 4990 (class 0 OID 24297)
-- Dependencies: 362
-- Data for Name: outbound_email; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.outbound_email (id, name, type, user_id, mail_sendtype, mail_smtptype, mail_smtpserver, mail_smtpport, mail_smtpuser, mail_smtppass, mail_smtpauth_req, mail_smtpssl, date_entered, date_modified, modified_user_id, created_by, deleted, assigned_user_id) FROM stdin;
\.


--
-- TOC entry 4991 (class 0 OID 24310)
-- Dependencies: 363
-- Data for Name: outbound_email_audit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.outbound_email_audit (id, parent_id, date_created, created_by, field_name, data_type, before_value_string, after_value_string, before_value_text, after_value_text) FROM stdin;
\.


--
-- TOC entry 4992 (class 0 OID 24316)
-- Dependencies: 364
-- Data for Name: project; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.project (id, date_entered, date_modified, assigned_user_id, modified_user_id, created_by, name, description, deleted, estimated_start_date, estimated_end_date, status, priority, override_business_hours) FROM stdin;
\.


--
-- TOC entry 4999 (class 0 OID 24348)
-- Dependencies: 371
-- Data for Name: project_contacts_1_c; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.project_contacts_1_c (id, date_modified, deleted, project_contacts_1project_ida, project_contacts_1contacts_idb) FROM stdin;
\.


--
-- TOC entry 5000 (class 0 OID 24352)
-- Dependencies: 372
-- Data for Name: project_cstm; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.project_cstm (id_c, jjwg_maps_lng_c, jjwg_maps_lat_c, jjwg_maps_geocode_status_c, jjwg_maps_address_c) FROM stdin;
\.


--
-- TOC entry 5001 (class 0 OID 24360)
-- Dependencies: 373
-- Data for Name: project_task; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.project_task (id, date_entered, date_modified, project_id, project_task_id, name, status, relationship_type, description, predecessors, date_start, time_start, time_finish, date_finish, duration, duration_unit, actual_duration, percent_complete, date_due, time_due, parent_task_id, assigned_user_id, modified_user_id, priority, created_by, milestone_flag, order_number, task_number, estimated_effort, actual_effort, deleted, utilization) FROM stdin;
\.


--
-- TOC entry 5002 (class 0 OID 24369)
-- Dependencies: 374
-- Data for Name: project_task_audit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.project_task_audit (id, parent_id, date_created, created_by, field_name, data_type, before_value_string, after_value_string, before_value_text, after_value_text) FROM stdin;
\.


--
-- TOC entry 5003 (class 0 OID 24375)
-- Dependencies: 375
-- Data for Name: project_users_1_c; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.project_users_1_c (id, date_modified, deleted, project_users_1project_ida, project_users_1users_idb) FROM stdin;
\.


--
-- TOC entry 4993 (class 0 OID 24324)
-- Dependencies: 365
-- Data for Name: projects_accounts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.projects_accounts (id, account_id, project_id, date_modified, deleted) FROM stdin;
\.


--
-- TOC entry 4994 (class 0 OID 24328)
-- Dependencies: 366
-- Data for Name: projects_bugs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.projects_bugs (id, bug_id, project_id, date_modified, deleted) FROM stdin;
\.


--
-- TOC entry 4995 (class 0 OID 24332)
-- Dependencies: 367
-- Data for Name: projects_cases; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.projects_cases (id, case_id, project_id, date_modified, deleted) FROM stdin;
\.


--
-- TOC entry 4996 (class 0 OID 24336)
-- Dependencies: 368
-- Data for Name: projects_contacts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.projects_contacts (id, contact_id, project_id, date_modified, deleted) FROM stdin;
\.


--
-- TOC entry 4997 (class 0 OID 24340)
-- Dependencies: 369
-- Data for Name: projects_opportunities; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.projects_opportunities (id, opportunity_id, project_id, date_modified, deleted) FROM stdin;
\.


--
-- TOC entry 4998 (class 0 OID 24344)
-- Dependencies: 370
-- Data for Name: projects_products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.projects_products (id, product_id, project_id, date_modified, deleted) FROM stdin;
\.


--
-- TOC entry 5009 (class 0 OID 24408)
-- Dependencies: 381
-- Data for Name: prospect_list_campaigns; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.prospect_list_campaigns (id, prospect_list_id, campaign_id, date_modified, deleted) FROM stdin;
\.


--
-- TOC entry 5007 (class 0 OID 24398)
-- Dependencies: 379
-- Data for Name: prospect_lists; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.prospect_lists (assigned_user_id, id, name, list_type, date_entered, date_modified, modified_user_id, created_by, deleted, description, domain_name) FROM stdin;
\.


--
-- TOC entry 5008 (class 0 OID 24404)
-- Dependencies: 380
-- Data for Name: prospect_lists_prospects; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.prospect_lists_prospects (id, prospect_list_id, related_id, related_type, date_modified, deleted) FROM stdin;
\.


--
-- TOC entry 5005 (class 0 OID 24381)
-- Dependencies: 377
-- Data for Name: prospects; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.prospects (id, date_entered, date_modified, modified_user_id, created_by, description, deleted, assigned_user_id, salutation, first_name, last_name, title, photo, department, do_not_call, phone_home, phone_mobile, phone_work, phone_other, phone_fax, primary_address_street, primary_address_city, primary_address_state, primary_address_postalcode, primary_address_country, alt_address_street, alt_address_city, alt_address_state, alt_address_postalcode, alt_address_country, assistant, assistant_phone, tracker_key, birthdate, lead_id, account_name, campaign_id) FROM stdin;
\.


--
-- TOC entry 5006 (class 0 OID 24390)
-- Dependencies: 378
-- Data for Name: prospects_cstm; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.prospects_cstm (id_c, jjwg_maps_lng_c, jjwg_maps_lat_c, jjwg_maps_geocode_status_c, jjwg_maps_address_c) FROM stdin;
\.


--
-- TOC entry 5010 (class 0 OID 24412)
-- Dependencies: 382
-- Data for Name: relationships; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.relationships (id, relationship_name, lhs_module, lhs_table, lhs_key, rhs_module, rhs_table, rhs_key, join_table, join_key_lhs, join_key_rhs, relationship_type, relationship_role_column, relationship_role_column_value, reverse, deleted) FROM stdin;
\.


--
-- TOC entry 5011 (class 0 OID 24420)
-- Dependencies: 383
-- Data for Name: releases; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.releases (id, deleted, date_entered, date_modified, modified_user_id, created_by, name, list_order, status) FROM stdin;
\.


--
-- TOC entry 5012 (class 0 OID 24423)
-- Dependencies: 384
-- Data for Name: reminders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reminders (id, name, date_entered, date_modified, modified_user_id, created_by, description, deleted, assigned_user_id, popup, email, email_sent, timer_popup, timer_email, related_event_module, related_event_module_id) FROM stdin;
\.


--
-- TOC entry 5013 (class 0 OID 24430)
-- Dependencies: 385
-- Data for Name: reminders_invitees; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reminders_invitees (id, name, date_entered, date_modified, modified_user_id, created_by, description, deleted, assigned_user_id, reminder_id, related_invitee_module, related_invitee_module_id) FROM stdin;
\.


--
-- TOC entry 5014 (class 0 OID 24437)
-- Dependencies: 386
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles (id, date_entered, date_modified, modified_user_id, created_by, name, description, modules, deleted) FROM stdin;
\.


--
-- TOC entry 5015 (class 0 OID 24443)
-- Dependencies: 387
-- Data for Name: roles_modules; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles_modules (id, role_id, module_id, allow, date_modified, deleted) FROM stdin;
\.


--
-- TOC entry 5016 (class 0 OID 24448)
-- Dependencies: 388
-- Data for Name: roles_users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles_users (id, role_id, user_id, date_modified, deleted) FROM stdin;
\.


--
-- TOC entry 5017 (class 0 OID 24452)
-- Dependencies: 389
-- Data for Name: saved_search; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.saved_search (id, name, search_module, deleted, date_entered, date_modified, assigned_user_id, contents, description) FROM stdin;
\.


--
-- TOC entry 5018 (class 0 OID 24458)
-- Dependencies: 390
-- Data for Name: schedulers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.schedulers (id, deleted, date_entered, date_modified, created_by, modified_user_id, name, job, date_time_start, date_time_end, job_interval, time_from, time_to, last_run, status, catch_up) FROM stdin;
\.


--
-- TOC entry 5019 (class 0 OID 24466)
-- Dependencies: 391
-- Data for Name: securitygroups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.securitygroups (id, name, date_entered, date_modified, modified_user_id, created_by, description, deleted, assigned_user_id, noninheritable) FROM stdin;
\.


--
-- TOC entry 5020 (class 0 OID 24473)
-- Dependencies: 392
-- Data for Name: securitygroups_acl_roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.securitygroups_acl_roles (id, securitygroup_id, role_id, date_modified, deleted) FROM stdin;
\.


--
-- TOC entry 5021 (class 0 OID 24477)
-- Dependencies: 393
-- Data for Name: securitygroups_audit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.securitygroups_audit (id, parent_id, date_created, created_by, field_name, data_type, before_value_string, after_value_string, before_value_text, after_value_text) FROM stdin;
\.


--
-- TOC entry 5022 (class 0 OID 24483)
-- Dependencies: 394
-- Data for Name: securitygroups_default; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.securitygroups_default (id, securitygroup_id, module, date_modified, deleted) FROM stdin;
\.


--
-- TOC entry 5023 (class 0 OID 24487)
-- Dependencies: 395
-- Data for Name: securitygroups_records; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.securitygroups_records (id, securitygroup_id, record_id, module, date_modified, modified_user_id, created_by, deleted) FROM stdin;
\.


--
-- TOC entry 5024 (class 0 OID 24491)
-- Dependencies: 396
-- Data for Name: securitygroups_users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.securitygroups_users (id, date_modified, deleted, securitygroup_id, user_id, primary_group, noninheritable) FROM stdin;
\.


--
-- TOC entry 5025 (class 0 OID 24496)
-- Dependencies: 397
-- Data for Name: spots; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.spots (id, name, date_entered, date_modified, modified_user_id, created_by, description, deleted, assigned_user_id, config, type) FROM stdin;
\.


--
-- TOC entry 5026 (class 0 OID 24503)
-- Dependencies: 398
-- Data for Name: sugarfeed; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sugarfeed (id, name, date_entered, date_modified, modified_user_id, created_by, description, deleted, assigned_user_id, related_module, related_id, link_url, link_type) FROM stdin;
\.


--
-- TOC entry 5027 (class 0 OID 24510)
-- Dependencies: 399
-- Data for Name: tasks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tasks (id, name, date_entered, date_modified, modified_user_id, created_by, description, deleted, assigned_user_id, status, date_due_flag, date_due, date_start_flag, date_start, parent_type, parent_id, contact_id, priority) FROM stdin;
\.


--
-- TOC entry 5028 (class 0 OID 24520)
-- Dependencies: 400
-- Data for Name: templatesectionline; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.templatesectionline (id, name, date_entered, date_modified, modified_user_id, created_by, description, deleted, thumbnail, grp, ord) FROM stdin;
\.


--
-- TOC entry 5030 (class 0 OID 24529)
-- Dependencies: 402
-- Data for Name: tracker; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tracker (id, monitor_id, user_id, module_name, item_id, item_summary, date_modified, action, session_id, visible, deleted) FROM stdin;
\.


--
-- TOC entry 5031 (class 0 OID 24538)
-- Dependencies: 403
-- Data for Name: upgrade_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.upgrade_history (id, filename, md5sum, type, status, version, name, description, id_name, manifest, date_entered, enabled) FROM stdin;
\.


--
-- TOC entry 5037 (class 0 OID 24573)
-- Dependencies: 409
-- Data for Name: user_preferences; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_preferences (id, category, deleted, date_entered, date_modified, assigned_user_id, contents) FROM stdin;
\.


--
-- TOC entry 5032 (class 0 OID 24545)
-- Dependencies: 404
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, user_name, user_hash, system_generated_password, pwd_last_changed, authenticate_id, sugar_login, first_name, last_name, is_admin, external_auth_only, receive_notifications, description, date_entered, date_modified, modified_user_id, created_by, title, photo, department, phone_home, phone_mobile, phone_work, phone_other, phone_fax, status, address_street, address_city, address_state, address_country, address_postalcode, deleted, portal_only, show_on_employees, employee_status, messenger_id, messenger_type, reports_to_id, is_group) FROM stdin;
\.


--
-- TOC entry 5033 (class 0 OID 24557)
-- Dependencies: 405
-- Data for Name: users_feeds; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users_feeds (user_id, feed_id, rank, date_modified, deleted) FROM stdin;
\.


--
-- TOC entry 5034 (class 0 OID 24561)
-- Dependencies: 406
-- Data for Name: users_last_import; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users_last_import (id, assigned_user_id, import_module, bean_type, bean_id, deleted) FROM stdin;
\.


--
-- TOC entry 5035 (class 0 OID 24564)
-- Dependencies: 407
-- Data for Name: users_password_link; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users_password_link (id, username, date_generated, deleted) FROM stdin;
\.


--
-- TOC entry 5036 (class 0 OID 24567)
-- Dependencies: 408
-- Data for Name: users_signatures; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users_signatures (id, date_entered, date_modified, deleted, user_id, name, signature, signature_html) FROM stdin;
\.


--
-- TOC entry 5038 (class 0 OID 24580)
-- Dependencies: 410
-- Data for Name: vcals; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vcals (id, deleted, date_entered, date_modified, user_id, type, source, content) FROM stdin;
\.


--
-- TOC entry 5054 (class 0 OID 0)
-- Dependencies: 265
-- Name: bugs_bug_number_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.bugs_bug_number_seq', 1, true);


--
-- TOC entry 5055 (class 0 OID 0)
-- Dependencies: 278
-- Name: campaign_trkrs_tracker_key_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.campaign_trkrs_tracker_key_seq', 1, true);


--
-- TOC entry 5056 (class 0 OID 0)
-- Dependencies: 274
-- Name: campaigns_tracker_key_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.campaigns_tracker_key_seq', 1, true);


--
-- TOC entry 5057 (class 0 OID 0)
-- Dependencies: 280
-- Name: cases_case_number_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cases_case_number_seq', 1, true);


--
-- TOC entry 5058 (class 0 OID 0)
-- Dependencies: 303
-- Name: emailman_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.emailman_id_seq', 1, true);


--
-- TOC entry 5059 (class 0 OID 0)
-- Dependencies: 376
-- Name: prospects_tracker_key_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.prospects_tracker_key_seq', 1, true);


--
-- TOC entry 5060 (class 0 OID 0)
-- Dependencies: 401
-- Name: tracker_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tracker_id_seq', 1, true);


--
-- TOC entry 3999 (class 2606 OID 25101)
-- Name: accounts idx_23255_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT idx_23255_primary PRIMARY KEY (id);


--
-- TOC entry 4002 (class 2606 OID 25102)
-- Name: accounts_audit idx_23262_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_audit
    ADD CONSTRAINT idx_23262_primary PRIMARY KEY (id);


--
-- TOC entry 4007 (class 2606 OID 25103)
-- Name: accounts_bugs idx_23268_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_bugs
    ADD CONSTRAINT idx_23268_primary PRIMARY KEY (id);


--
-- TOC entry 4011 (class 2606 OID 25104)
-- Name: accounts_cases idx_23272_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_cases
    ADD CONSTRAINT idx_23272_primary PRIMARY KEY (id);


--
-- TOC entry 4015 (class 2606 OID 25105)
-- Name: accounts_contacts idx_23276_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_contacts
    ADD CONSTRAINT idx_23276_primary PRIMARY KEY (id);


--
-- TOC entry 4017 (class 2606 OID 25106)
-- Name: accounts_cstm idx_23280_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_cstm
    ADD CONSTRAINT idx_23280_primary PRIMARY KEY (id_c);


--
-- TOC entry 4021 (class 2606 OID 25107)
-- Name: accounts_opportunities idx_23288_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_opportunities
    ADD CONSTRAINT idx_23288_primary PRIMARY KEY (id);


--
-- TOC entry 4025 (class 2606 OID 25108)
-- Name: acl_actions idx_23292_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.acl_actions
    ADD CONSTRAINT idx_23292_primary PRIMARY KEY (id);


--
-- TOC entry 4028 (class 2606 OID 25109)
-- Name: acl_roles idx_23295_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.acl_roles
    ADD CONSTRAINT idx_23295_primary PRIMARY KEY (id);


--
-- TOC entry 4033 (class 2606 OID 25110)
-- Name: acl_roles_actions idx_23301_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.acl_roles_actions
    ADD CONSTRAINT idx_23301_primary PRIMARY KEY (id);


--
-- TOC entry 4038 (class 2606 OID 25111)
-- Name: acl_roles_users idx_23305_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.acl_roles_users
    ADD CONSTRAINT idx_23305_primary PRIMARY KEY (id);


--
-- TOC entry 4041 (class 2606 OID 25112)
-- Name: alerts idx_23312_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alerts
    ADD CONSTRAINT idx_23312_primary PRIMARY KEY (id);


--
-- TOC entry 4043 (class 2606 OID 25113)
-- Name: am_projecttemplates idx_23319_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.am_projecttemplates
    ADD CONSTRAINT idx_23319_primary PRIMARY KEY (id);


--
-- TOC entry 4046 (class 2606 OID 25114)
-- Name: am_projecttemplates_audit idx_23329_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.am_projecttemplates_audit
    ADD CONSTRAINT idx_23329_primary PRIMARY KEY (id);


--
-- TOC entry 4049 (class 2606 OID 25115)
-- Name: am_projecttemplates_contacts_1_c idx_23335_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.am_projecttemplates_contacts_1_c
    ADD CONSTRAINT idx_23335_primary PRIMARY KEY (id);


--
-- TOC entry 4053 (class 2606 OID 25116)
-- Name: am_projecttemplates_project_1_c idx_23339_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.am_projecttemplates_project_1_c
    ADD CONSTRAINT idx_23339_primary PRIMARY KEY (id);


--
-- TOC entry 4056 (class 2606 OID 25117)
-- Name: am_projecttemplates_users_1_c idx_23343_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.am_projecttemplates_users_1_c
    ADD CONSTRAINT idx_23343_primary PRIMARY KEY (id);


--
-- TOC entry 4058 (class 2606 OID 25118)
-- Name: am_tasktemplates idx_23347_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.am_tasktemplates
    ADD CONSTRAINT idx_23347_primary PRIMARY KEY (id);


--
-- TOC entry 4062 (class 2606 OID 25119)
-- Name: am_tasktemplates_am_projecttemplates_c idx_23360_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.am_tasktemplates_am_projecttemplates_c
    ADD CONSTRAINT idx_23360_primary PRIMARY KEY (id);


--
-- TOC entry 4065 (class 2606 OID 25120)
-- Name: am_tasktemplates_audit idx_23364_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.am_tasktemplates_audit
    ADD CONSTRAINT idx_23364_primary PRIMARY KEY (id);


--
-- TOC entry 4067 (class 2606 OID 25121)
-- Name: aobh_businesshours idx_23370_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aobh_businesshours
    ADD CONSTRAINT idx_23370_primary PRIMARY KEY (id);


--
-- TOC entry 4069 (class 2606 OID 25122)
-- Name: aod_index idx_23380_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aod_index
    ADD CONSTRAINT idx_23380_primary PRIMARY KEY (id);


--
-- TOC entry 4073 (class 2606 OID 25123)
-- Name: aod_indexevent idx_23387_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aod_indexevent
    ADD CONSTRAINT idx_23387_primary PRIMARY KEY (id);


--
-- TOC entry 4076 (class 2606 OID 25124)
-- Name: aod_indexevent_audit idx_23395_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aod_indexevent_audit
    ADD CONSTRAINT idx_23395_primary PRIMARY KEY (id);


--
-- TOC entry 4079 (class 2606 OID 25125)
-- Name: aod_index_audit idx_23401_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aod_index_audit
    ADD CONSTRAINT idx_23401_primary PRIMARY KEY (id);


--
-- TOC entry 4081 (class 2606 OID 25126)
-- Name: aok_knowledgebase idx_23407_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aok_knowledgebase
    ADD CONSTRAINT idx_23407_primary PRIMARY KEY (id);


--
-- TOC entry 4084 (class 2606 OID 25127)
-- Name: aok_knowledgebase_audit idx_23415_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aok_knowledgebase_audit
    ADD CONSTRAINT idx_23415_primary PRIMARY KEY (id);


--
-- TOC entry 4087 (class 2606 OID 25128)
-- Name: aok_knowledgebase_categories idx_23421_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aok_knowledgebase_categories
    ADD CONSTRAINT idx_23421_primary PRIMARY KEY (id);


--
-- TOC entry 4089 (class 2606 OID 25129)
-- Name: aok_knowledge_base_categories idx_23425_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aok_knowledge_base_categories
    ADD CONSTRAINT idx_23425_primary PRIMARY KEY (id);


--
-- TOC entry 4092 (class 2606 OID 25130)
-- Name: aok_knowledge_base_categories_audit idx_23432_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aok_knowledge_base_categories_audit
    ADD CONSTRAINT idx_23432_primary PRIMARY KEY (id);


--
-- TOC entry 4094 (class 2606 OID 25131)
-- Name: aop_case_events idx_23438_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aop_case_events
    ADD CONSTRAINT idx_23438_primary PRIMARY KEY (id);


--
-- TOC entry 4097 (class 2606 OID 25132)
-- Name: aop_case_events_audit idx_23445_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aop_case_events_audit
    ADD CONSTRAINT idx_23445_primary PRIMARY KEY (id);


--
-- TOC entry 4099 (class 2606 OID 25133)
-- Name: aop_case_updates idx_23451_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aop_case_updates
    ADD CONSTRAINT idx_23451_primary PRIMARY KEY (id);


--
-- TOC entry 4102 (class 2606 OID 25134)
-- Name: aop_case_updates_audit idx_23458_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aop_case_updates_audit
    ADD CONSTRAINT idx_23458_primary PRIMARY KEY (id);


--
-- TOC entry 4104 (class 2606 OID 25135)
-- Name: aor_charts idx_23464_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aor_charts
    ADD CONSTRAINT idx_23464_primary PRIMARY KEY (id);


--
-- TOC entry 4107 (class 2606 OID 25136)
-- Name: aor_conditions idx_23471_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aor_conditions
    ADD CONSTRAINT idx_23471_primary PRIMARY KEY (id);


--
-- TOC entry 4110 (class 2606 OID 25137)
-- Name: aor_fields idx_23478_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aor_fields
    ADD CONSTRAINT idx_23478_primary PRIMARY KEY (id);


--
-- TOC entry 4112 (class 2606 OID 25138)
-- Name: aor_reports idx_23485_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aor_reports
    ADD CONSTRAINT idx_23485_primary PRIMARY KEY (id);


--
-- TOC entry 4115 (class 2606 OID 25139)
-- Name: aor_reports_audit idx_23493_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aor_reports_audit
    ADD CONSTRAINT idx_23493_primary PRIMARY KEY (id);


--
-- TOC entry 4117 (class 2606 OID 25140)
-- Name: aor_scheduled_reports idx_23499_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aor_scheduled_reports
    ADD CONSTRAINT idx_23499_primary PRIMARY KEY (id);


--
-- TOC entry 4119 (class 2606 OID 25141)
-- Name: aos_contracts idx_23506_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aos_contracts
    ADD CONSTRAINT idx_23506_primary PRIMARY KEY (id);


--
-- TOC entry 4122 (class 2606 OID 25142)
-- Name: aos_contracts_audit idx_23515_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aos_contracts_audit
    ADD CONSTRAINT idx_23515_primary PRIMARY KEY (id);


--
-- TOC entry 4125 (class 2606 OID 25143)
-- Name: aos_contracts_documents idx_23521_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aos_contracts_documents
    ADD CONSTRAINT idx_23521_primary PRIMARY KEY (id);


--
-- TOC entry 4127 (class 2606 OID 25144)
-- Name: aos_invoices idx_23525_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aos_invoices
    ADD CONSTRAINT idx_23525_primary PRIMARY KEY (id);


--
-- TOC entry 4130 (class 2606 OID 25145)
-- Name: aos_invoices_audit idx_23532_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aos_invoices_audit
    ADD CONSTRAINT idx_23532_primary PRIMARY KEY (id);


--
-- TOC entry 4132 (class 2606 OID 25146)
-- Name: aos_line_item_groups idx_23538_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aos_line_item_groups
    ADD CONSTRAINT idx_23538_primary PRIMARY KEY (id);


--
-- TOC entry 4135 (class 2606 OID 25147)
-- Name: aos_line_item_groups_audit idx_23545_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aos_line_item_groups_audit
    ADD CONSTRAINT idx_23545_primary PRIMARY KEY (id);


--
-- TOC entry 4137 (class 2606 OID 25148)
-- Name: aos_pdf_templates idx_23551_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aos_pdf_templates
    ADD CONSTRAINT idx_23551_primary PRIMARY KEY (id);


--
-- TOC entry 4140 (class 2606 OID 25149)
-- Name: aos_pdf_templates_audit idx_23565_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aos_pdf_templates_audit
    ADD CONSTRAINT idx_23565_primary PRIMARY KEY (id);


--
-- TOC entry 4142 (class 2606 OID 25150)
-- Name: aos_products idx_23571_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aos_products
    ADD CONSTRAINT idx_23571_primary PRIMARY KEY (id);


--
-- TOC entry 4145 (class 2606 OID 25151)
-- Name: aos_products_audit idx_23580_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aos_products_audit
    ADD CONSTRAINT idx_23580_primary PRIMARY KEY (id);


--
-- TOC entry 4148 (class 2606 OID 25152)
-- Name: aos_products_quotes idx_23586_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aos_products_quotes
    ADD CONSTRAINT idx_23586_primary PRIMARY KEY (id);


--
-- TOC entry 4151 (class 2606 OID 25153)
-- Name: aos_products_quotes_audit idx_23595_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aos_products_quotes_audit
    ADD CONSTRAINT idx_23595_primary PRIMARY KEY (id);


--
-- TOC entry 4153 (class 2606 OID 25154)
-- Name: aos_product_categories idx_23601_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aos_product_categories
    ADD CONSTRAINT idx_23601_primary PRIMARY KEY (id);


--
-- TOC entry 4156 (class 2606 OID 25155)
-- Name: aos_product_categories_audit idx_23609_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aos_product_categories_audit
    ADD CONSTRAINT idx_23609_primary PRIMARY KEY (id);


--
-- TOC entry 4158 (class 2606 OID 25156)
-- Name: aos_quotes idx_23615_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aos_quotes
    ADD CONSTRAINT idx_23615_primary PRIMARY KEY (id);


--
-- TOC entry 4161 (class 2606 OID 25157)
-- Name: aos_quotes_aos_invoices_c idx_23624_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aos_quotes_aos_invoices_c
    ADD CONSTRAINT idx_23624_primary PRIMARY KEY (id);


--
-- TOC entry 4164 (class 2606 OID 25158)
-- Name: aos_quotes_audit idx_23628_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aos_quotes_audit
    ADD CONSTRAINT idx_23628_primary PRIMARY KEY (id);


--
-- TOC entry 4167 (class 2606 OID 25159)
-- Name: aos_quotes_os_contracts_c idx_23634_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aos_quotes_os_contracts_c
    ADD CONSTRAINT idx_23634_primary PRIMARY KEY (id);


--
-- TOC entry 4170 (class 2606 OID 25160)
-- Name: aos_quotes_project_c idx_23638_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aos_quotes_project_c
    ADD CONSTRAINT idx_23638_primary PRIMARY KEY (id);


--
-- TOC entry 4173 (class 2606 OID 25161)
-- Name: aow_actions idx_23642_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aow_actions
    ADD CONSTRAINT idx_23642_primary PRIMARY KEY (id);


--
-- TOC entry 4176 (class 2606 OID 25162)
-- Name: aow_conditions idx_23649_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aow_conditions
    ADD CONSTRAINT idx_23649_primary PRIMARY KEY (id);


--
-- TOC entry 4181 (class 2606 OID 25163)
-- Name: aow_processed idx_23656_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aow_processed
    ADD CONSTRAINT idx_23656_primary PRIMARY KEY (id);


--
-- TOC entry 4185 (class 2606 OID 25164)
-- Name: aow_processed_aow_actions idx_23664_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aow_processed_aow_actions
    ADD CONSTRAINT idx_23664_primary PRIMARY KEY (id);


--
-- TOC entry 4188 (class 2606 OID 25165)
-- Name: aow_workflow idx_23669_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aow_workflow
    ADD CONSTRAINT idx_23669_primary PRIMARY KEY (id);


--
-- TOC entry 4191 (class 2606 OID 25166)
-- Name: aow_workflow_audit idx_23680_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aow_workflow_audit
    ADD CONSTRAINT idx_23680_primary PRIMARY KEY (id);


--
-- TOC entry 4197 (class 2606 OID 25167)
-- Name: bugs idx_23688_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bugs
    ADD CONSTRAINT idx_23688_primary PRIMARY KEY (id);


--
-- TOC entry 4200 (class 2606 OID 25168)
-- Name: bugs_audit idx_23696_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bugs_audit
    ADD CONSTRAINT idx_23696_primary PRIMARY KEY (id);


--
-- TOC entry 4207 (class 2606 OID 25169)
-- Name: calls idx_23702_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.calls
    ADD CONSTRAINT idx_23702_primary PRIMARY KEY (id);


--
-- TOC entry 4212 (class 2606 OID 25170)
-- Name: calls_contacts idx_23714_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.calls_contacts
    ADD CONSTRAINT idx_23714_primary PRIMARY KEY (id);


--
-- TOC entry 4217 (class 2606 OID 25171)
-- Name: calls_leads idx_23720_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.calls_leads
    ADD CONSTRAINT idx_23720_primary PRIMARY KEY (id);


--
-- TOC entry 4219 (class 2606 OID 25172)
-- Name: calls_reschedule idx_23726_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.calls_reschedule
    ADD CONSTRAINT idx_23726_primary PRIMARY KEY (id);


--
-- TOC entry 4222 (class 2606 OID 25173)
-- Name: calls_reschedule_audit idx_23733_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.calls_reschedule_audit
    ADD CONSTRAINT idx_23733_primary PRIMARY KEY (id);


--
-- TOC entry 4227 (class 2606 OID 25174)
-- Name: calls_users idx_23739_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.calls_users
    ADD CONSTRAINT idx_23739_primary PRIMARY KEY (id);


--
-- TOC entry 4231 (class 2606 OID 25175)
-- Name: campaigns idx_23747_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.campaigns
    ADD CONSTRAINT idx_23747_primary PRIMARY KEY (id);


--
-- TOC entry 4234 (class 2606 OID 25176)
-- Name: campaigns_audit idx_23758_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.campaigns_audit
    ADD CONSTRAINT idx_23758_primary PRIMARY KEY (id);


--
-- TOC entry 4241 (class 2606 OID 25177)
-- Name: campaign_log idx_23764_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.campaign_log
    ADD CONSTRAINT idx_23764_primary PRIMARY KEY (id);


--
-- TOC entry 4244 (class 2606 OID 25178)
-- Name: campaign_trkrs idx_23774_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.campaign_trkrs
    ADD CONSTRAINT idx_23774_primary PRIMARY KEY (id);


--
-- TOC entry 4251 (class 2606 OID 25179)
-- Name: cases idx_23783_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cases
    ADD CONSTRAINT idx_23783_primary PRIMARY KEY (id);


--
-- TOC entry 4254 (class 2606 OID 25180)
-- Name: cases_audit idx_23792_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cases_audit
    ADD CONSTRAINT idx_23792_primary PRIMARY KEY (id);


--
-- TOC entry 4259 (class 2606 OID 25181)
-- Name: cases_bugs idx_23798_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cases_bugs
    ADD CONSTRAINT idx_23798_primary PRIMARY KEY (id);


--
-- TOC entry 4261 (class 2606 OID 25182)
-- Name: cases_cstm idx_23802_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cases_cstm
    ADD CONSTRAINT idx_23802_primary PRIMARY KEY (id_c);


--
-- TOC entry 4270 (class 2606 OID 25183)
-- Name: contacts idx_23816_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contacts
    ADD CONSTRAINT idx_23816_primary PRIMARY KEY (id);


--
-- TOC entry 4273 (class 2606 OID 25184)
-- Name: contacts_audit idx_23825_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contacts_audit
    ADD CONSTRAINT idx_23825_primary PRIMARY KEY (id);


--
-- TOC entry 4278 (class 2606 OID 25185)
-- Name: contacts_bugs idx_23831_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contacts_bugs
    ADD CONSTRAINT idx_23831_primary PRIMARY KEY (id);


--
-- TOC entry 4283 (class 2606 OID 25186)
-- Name: contacts_cases idx_23835_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contacts_cases
    ADD CONSTRAINT idx_23835_primary PRIMARY KEY (id);


--
-- TOC entry 4285 (class 2606 OID 25187)
-- Name: contacts_cstm idx_23839_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contacts_cstm
    ADD CONSTRAINT idx_23839_primary PRIMARY KEY (id_c);


--
-- TOC entry 4290 (class 2606 OID 25188)
-- Name: contacts_users idx_23847_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contacts_users
    ADD CONSTRAINT idx_23847_primary PRIMARY KEY (id);


--
-- TOC entry 4294 (class 2606 OID 25189)
-- Name: cron_remove_documents idx_23851_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cron_remove_documents
    ADD CONSTRAINT idx_23851_primary PRIMARY KEY (id);


--
-- TOC entry 4297 (class 2606 OID 25190)
-- Name: currencies idx_23854_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.currencies
    ADD CONSTRAINT idx_23854_primary PRIMARY KEY (id);


--
-- TOC entry 4301 (class 2606 OID 25191)
-- Name: documents idx_23866_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documents
    ADD CONSTRAINT idx_23866_primary PRIMARY KEY (id);


--
-- TOC entry 4305 (class 2606 OID 25192)
-- Name: documents_accounts idx_23875_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documents_accounts
    ADD CONSTRAINT idx_23875_primary PRIMARY KEY (id);


--
-- TOC entry 4309 (class 2606 OID 25193)
-- Name: documents_bugs idx_23879_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documents_bugs
    ADD CONSTRAINT idx_23879_primary PRIMARY KEY (id);


--
-- TOC entry 4313 (class 2606 OID 25194)
-- Name: documents_cases idx_23883_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documents_cases
    ADD CONSTRAINT idx_23883_primary PRIMARY KEY (id);


--
-- TOC entry 4317 (class 2606 OID 25195)
-- Name: documents_contacts idx_23887_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documents_contacts
    ADD CONSTRAINT idx_23887_primary PRIMARY KEY (id);


--
-- TOC entry 4321 (class 2606 OID 25196)
-- Name: documents_opportunities idx_23891_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documents_opportunities
    ADD CONSTRAINT idx_23891_primary PRIMARY KEY (id);


--
-- TOC entry 4324 (class 2606 OID 25197)
-- Name: document_revisions idx_23895_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.document_revisions
    ADD CONSTRAINT idx_23895_primary PRIMARY KEY (id);


--
-- TOC entry 4327 (class 2606 OID 25198)
-- Name: eapm idx_23902_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eapm
    ADD CONSTRAINT idx_23902_primary PRIMARY KEY (id);


--
-- TOC entry 4332 (class 2606 OID 25199)
-- Name: emailman idx_23912_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.emailman
    ADD CONSTRAINT idx_23912_primary PRIMARY KEY (id);


--
-- TOC entry 4338 (class 2606 OID 25200)
-- Name: emails idx_23919_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.emails
    ADD CONSTRAINT idx_23919_primary PRIMARY KEY (id);


--
-- TOC entry 4342 (class 2606 OID 25201)
-- Name: emails_beans idx_23926_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.emails_beans
    ADD CONSTRAINT idx_23926_primary PRIMARY KEY (id);


--
-- TOC entry 4346 (class 2606 OID 25202)
-- Name: emails_email_addr_rel idx_23933_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.emails_email_addr_rel
    ADD CONSTRAINT idx_23933_primary PRIMARY KEY (id);


--
-- TOC entry 4349 (class 2606 OID 25203)
-- Name: emails_text idx_23937_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.emails_text
    ADD CONSTRAINT idx_23937_primary PRIMARY KEY (email_id);


--
-- TOC entry 4353 (class 2606 OID 25204)
-- Name: email_addresses idx_23944_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.email_addresses
    ADD CONSTRAINT idx_23944_primary PRIMARY KEY (id);


--
-- TOC entry 4357 (class 2606 OID 25205)
-- Name: email_addr_bean_rel idx_23953_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.email_addr_bean_rel
    ADD CONSTRAINT idx_23953_primary PRIMARY KEY (id);


--
-- TOC entry 4366 (class 2606 OID 25206)
-- Name: email_marketing idx_23965_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.email_marketing
    ADD CONSTRAINT idx_23965_primary PRIMARY KEY (id);


--
-- TOC entry 4369 (class 2606 OID 25207)
-- Name: email_marketing_prospect_lists idx_23972_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.email_marketing_prospect_lists
    ADD CONSTRAINT idx_23972_primary PRIMARY KEY (id);


--
-- TOC entry 4372 (class 2606 OID 25208)
-- Name: email_templates idx_23976_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.email_templates
    ADD CONSTRAINT idx_23976_primary PRIMARY KEY (id);


--
-- TOC entry 4374 (class 2606 OID 25209)
-- Name: favorites idx_23982_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favorites
    ADD CONSTRAINT idx_23982_primary PRIMARY KEY (id);


--
-- TOC entry 4378 (class 2606 OID 25210)
-- Name: fields_meta_data idx_23989_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fields_meta_data
    ADD CONSTRAINT idx_23989_primary PRIMARY KEY (id);


--
-- TOC entry 4381 (class 2606 OID 25211)
-- Name: folders idx_24001_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.folders
    ADD CONSTRAINT idx_24001_primary PRIMARY KEY (id);


--
-- TOC entry 4385 (class 2606 OID 25212)
-- Name: folders_rel idx_24011_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.folders_rel
    ADD CONSTRAINT idx_24011_primary PRIMARY KEY (id);


--
-- TOC entry 4388 (class 2606 OID 25213)
-- Name: folders_subscriptions idx_24015_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.folders_subscriptions
    ADD CONSTRAINT idx_24015_primary PRIMARY KEY (id);


--
-- TOC entry 4390 (class 2606 OID 25214)
-- Name: fp_events idx_24018_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fp_events
    ADD CONSTRAINT idx_24018_primary PRIMARY KEY (id);


--
-- TOC entry 4393 (class 2606 OID 25215)
-- Name: fp_events_audit idx_24025_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fp_events_audit
    ADD CONSTRAINT idx_24025_primary PRIMARY KEY (id);


--
-- TOC entry 4396 (class 2606 OID 25216)
-- Name: fp_events_contacts_c idx_24031_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fp_events_contacts_c
    ADD CONSTRAINT idx_24031_primary PRIMARY KEY (id);


--
-- TOC entry 4400 (class 2606 OID 25217)
-- Name: fp_events_fp_event_delegates_1_c idx_24038_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fp_events_fp_event_delegates_1_c
    ADD CONSTRAINT idx_24038_primary PRIMARY KEY (id);


--
-- TOC entry 4403 (class 2606 OID 25218)
-- Name: fp_events_fp_event_locations_1_c idx_24042_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fp_events_fp_event_locations_1_c
    ADD CONSTRAINT idx_24042_primary PRIMARY KEY (id);


--
-- TOC entry 4406 (class 2606 OID 25219)
-- Name: fp_events_leads_1_c idx_24046_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fp_events_leads_1_c
    ADD CONSTRAINT idx_24046_primary PRIMARY KEY (id);


--
-- TOC entry 4409 (class 2606 OID 25220)
-- Name: fp_events_prospects_1_c idx_24053_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fp_events_prospects_1_c
    ADD CONSTRAINT idx_24053_primary PRIMARY KEY (id);


--
-- TOC entry 4411 (class 2606 OID 25221)
-- Name: fp_event_locations idx_24060_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fp_event_locations
    ADD CONSTRAINT idx_24060_primary PRIMARY KEY (id);


--
-- TOC entry 4414 (class 2606 OID 25222)
-- Name: fp_event_locations_audit idx_24067_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fp_event_locations_audit
    ADD CONSTRAINT idx_24067_primary PRIMARY KEY (id);


--
-- TOC entry 4418 (class 2606 OID 25223)
-- Name: fp_event_locations_fp_events_1_c idx_24073_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fp_event_locations_fp_events_1_c
    ADD CONSTRAINT idx_24073_primary PRIMARY KEY (id);


--
-- TOC entry 4421 (class 2606 OID 25224)
-- Name: import_maps idx_24077_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.import_maps
    ADD CONSTRAINT idx_24077_primary PRIMARY KEY (id);


--
-- TOC entry 4423 (class 2606 OID 25225)
-- Name: inbound_email idx_24087_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inbound_email
    ADD CONSTRAINT idx_24087_primary PRIMARY KEY (id);


--
-- TOC entry 4426 (class 2606 OID 25226)
-- Name: inbound_email_autoreply idx_24097_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inbound_email_autoreply
    ADD CONSTRAINT idx_24097_primary PRIMARY KEY (id);


--
-- TOC entry 4428 (class 2606 OID 25227)
-- Name: inbound_email_cache_ts idx_24101_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inbound_email_cache_ts
    ADD CONSTRAINT idx_24101_primary PRIMARY KEY (id);


--
-- TOC entry 4430 (class 2606 OID 25228)
-- Name: jjwg_address_cache idx_24104_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jjwg_address_cache
    ADD CONSTRAINT idx_24104_primary PRIMARY KEY (id);


--
-- TOC entry 4433 (class 2606 OID 25229)
-- Name: jjwg_address_cache_audit idx_24111_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jjwg_address_cache_audit
    ADD CONSTRAINT idx_24111_primary PRIMARY KEY (id);


--
-- TOC entry 4435 (class 2606 OID 25230)
-- Name: jjwg_areas idx_24117_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jjwg_areas
    ADD CONSTRAINT idx_24117_primary PRIMARY KEY (id);


--
-- TOC entry 4438 (class 2606 OID 25231)
-- Name: jjwg_areas_audit idx_24124_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jjwg_areas_audit
    ADD CONSTRAINT idx_24124_primary PRIMARY KEY (id);


--
-- TOC entry 4440 (class 2606 OID 25232)
-- Name: jjwg_maps idx_24130_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jjwg_maps
    ADD CONSTRAINT idx_24130_primary PRIMARY KEY (id);


--
-- TOC entry 4443 (class 2606 OID 25233)
-- Name: jjwg_maps_audit idx_24139_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jjwg_maps_audit
    ADD CONSTRAINT idx_24139_primary PRIMARY KEY (id);


--
-- TOC entry 4446 (class 2606 OID 25234)
-- Name: jjwg_maps_jjwg_areas_c idx_24145_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jjwg_maps_jjwg_areas_c
    ADD CONSTRAINT idx_24145_primary PRIMARY KEY (id);


--
-- TOC entry 4449 (class 2606 OID 25235)
-- Name: jjwg_maps_jjwg_markers_c idx_24149_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jjwg_maps_jjwg_markers_c
    ADD CONSTRAINT idx_24149_primary PRIMARY KEY (id);


--
-- TOC entry 4451 (class 2606 OID 25236)
-- Name: jjwg_markers idx_24153_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jjwg_markers
    ADD CONSTRAINT idx_24153_primary PRIMARY KEY (id);


--
-- TOC entry 4454 (class 2606 OID 25237)
-- Name: jjwg_markers_audit idx_24163_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jjwg_markers_audit
    ADD CONSTRAINT idx_24163_primary PRIMARY KEY (id);


--
-- TOC entry 4460 (class 2606 OID 25238)
-- Name: job_queue idx_24169_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_queue
    ADD CONSTRAINT idx_24169_primary PRIMARY KEY (id);


--
-- TOC entry 4473 (class 2606 OID 25239)
-- Name: leads idx_24177_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.leads
    ADD CONSTRAINT idx_24177_primary PRIMARY KEY (id);


--
-- TOC entry 4476 (class 2606 OID 25240)
-- Name: leads_audit idx_24186_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.leads_audit
    ADD CONSTRAINT idx_24186_primary PRIMARY KEY (id);


--
-- TOC entry 4478 (class 2606 OID 25241)
-- Name: leads_cstm idx_24192_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.leads_cstm
    ADD CONSTRAINT idx_24192_primary PRIMARY KEY (id_c);


--
-- TOC entry 4481 (class 2606 OID 25242)
-- Name: linked_documents idx_24200_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.linked_documents
    ADD CONSTRAINT idx_24200_primary PRIMARY KEY (id);


--
-- TOC entry 4487 (class 2606 OID 25243)
-- Name: meetings idx_24204_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.meetings
    ADD CONSTRAINT idx_24204_primary PRIMARY KEY (id);


--
-- TOC entry 4492 (class 2606 OID 25244)
-- Name: meetings_contacts idx_24218_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.meetings_contacts
    ADD CONSTRAINT idx_24218_primary PRIMARY KEY (id);


--
-- TOC entry 4494 (class 2606 OID 25245)
-- Name: meetings_cstm idx_24224_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.meetings_cstm
    ADD CONSTRAINT idx_24224_primary PRIMARY KEY (id_c);


--
-- TOC entry 4499 (class 2606 OID 25246)
-- Name: meetings_leads idx_24232_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.meetings_leads
    ADD CONSTRAINT idx_24232_primary PRIMARY KEY (id);


--
-- TOC entry 4504 (class 2606 OID 25247)
-- Name: meetings_users idx_24238_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.meetings_users
    ADD CONSTRAINT idx_24238_primary PRIMARY KEY (id);


--
-- TOC entry 4510 (class 2606 OID 25248)
-- Name: notes idx_24244_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notes
    ADD CONSTRAINT idx_24244_primary PRIMARY KEY (id);


--
-- TOC entry 4513 (class 2606 OID 25249)
-- Name: oauth_consumer idx_24252_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth_consumer
    ADD CONSTRAINT idx_24252_primary PRIMARY KEY (id);


--
-- TOC entry 4516 (class 2606 OID 25250)
-- Name: oauth_nonce idx_24259_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth_nonce
    ADD CONSTRAINT idx_24259_primary PRIMARY KEY (conskey, nonce);


--
-- TOC entry 4520 (class 2606 OID 25251)
-- Name: oauth_tokens idx_24265_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth_tokens
    ADD CONSTRAINT idx_24265_primary PRIMARY KEY (id, deleted);


--
-- TOC entry 4525 (class 2606 OID 25252)
-- Name: opportunities idx_24272_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.opportunities
    ADD CONSTRAINT idx_24272_primary PRIMARY KEY (id);


--
-- TOC entry 4528 (class 2606 OID 25253)
-- Name: opportunities_audit idx_24279_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.opportunities_audit
    ADD CONSTRAINT idx_24279_primary PRIMARY KEY (id);


--
-- TOC entry 4533 (class 2606 OID 25254)
-- Name: opportunities_contacts idx_24285_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.opportunities_contacts
    ADD CONSTRAINT idx_24285_primary PRIMARY KEY (id);


--
-- TOC entry 4535 (class 2606 OID 25255)
-- Name: opportunities_cstm idx_24289_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.opportunities_cstm
    ADD CONSTRAINT idx_24289_primary PRIMARY KEY (id_c);


--
-- TOC entry 4537 (class 2606 OID 25256)
-- Name: outbound_email idx_24297_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.outbound_email
    ADD CONSTRAINT idx_24297_primary PRIMARY KEY (id);


--
-- TOC entry 4540 (class 2606 OID 25257)
-- Name: outbound_email_audit idx_24310_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.outbound_email_audit
    ADD CONSTRAINT idx_24310_primary PRIMARY KEY (id);


--
-- TOC entry 4542 (class 2606 OID 25258)
-- Name: project idx_24316_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project
    ADD CONSTRAINT idx_24316_primary PRIMARY KEY (id);


--
-- TOC entry 4546 (class 2606 OID 25259)
-- Name: projects_accounts idx_24324_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projects_accounts
    ADD CONSTRAINT idx_24324_primary PRIMARY KEY (id);


--
-- TOC entry 4551 (class 2606 OID 25260)
-- Name: projects_bugs idx_24328_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projects_bugs
    ADD CONSTRAINT idx_24328_primary PRIMARY KEY (id);


--
-- TOC entry 4556 (class 2606 OID 25261)
-- Name: projects_cases idx_24332_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projects_cases
    ADD CONSTRAINT idx_24332_primary PRIMARY KEY (id);


--
-- TOC entry 4561 (class 2606 OID 25262)
-- Name: projects_contacts idx_24336_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projects_contacts
    ADD CONSTRAINT idx_24336_primary PRIMARY KEY (id);


--
-- TOC entry 4566 (class 2606 OID 25263)
-- Name: projects_opportunities idx_24340_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projects_opportunities
    ADD CONSTRAINT idx_24340_primary PRIMARY KEY (id);


--
-- TOC entry 4571 (class 2606 OID 25264)
-- Name: projects_products idx_24344_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projects_products
    ADD CONSTRAINT idx_24344_primary PRIMARY KEY (id);


--
-- TOC entry 4574 (class 2606 OID 25265)
-- Name: project_contacts_1_c idx_24348_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project_contacts_1_c
    ADD CONSTRAINT idx_24348_primary PRIMARY KEY (id);


--
-- TOC entry 4577 (class 2606 OID 25266)
-- Name: project_cstm idx_24352_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project_cstm
    ADD CONSTRAINT idx_24352_primary PRIMARY KEY (id_c);


--
-- TOC entry 4579 (class 2606 OID 25267)
-- Name: project_task idx_24360_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project_task
    ADD CONSTRAINT idx_24360_primary PRIMARY KEY (id);


--
-- TOC entry 4582 (class 2606 OID 25268)
-- Name: project_task_audit idx_24369_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project_task_audit
    ADD CONSTRAINT idx_24369_primary PRIMARY KEY (id);


--
-- TOC entry 4584 (class 2606 OID 25269)
-- Name: project_users_1_c idx_24375_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project_users_1_c
    ADD CONSTRAINT idx_24375_primary PRIMARY KEY (id);


--
-- TOC entry 4591 (class 2606 OID 25270)
-- Name: prospects idx_24381_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prospects
    ADD CONSTRAINT idx_24381_primary PRIMARY KEY (id);


--
-- TOC entry 4594 (class 2606 OID 25271)
-- Name: prospects_cstm idx_24390_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prospects_cstm
    ADD CONSTRAINT idx_24390_primary PRIMARY KEY (id_c);


--
-- TOC entry 4597 (class 2606 OID 25272)
-- Name: prospect_lists idx_24398_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prospect_lists
    ADD CONSTRAINT idx_24398_primary PRIMARY KEY (id);


--
-- TOC entry 4601 (class 2606 OID 25273)
-- Name: prospect_lists_prospects idx_24404_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prospect_lists_prospects
    ADD CONSTRAINT idx_24404_primary PRIMARY KEY (id);


--
-- TOC entry 4606 (class 2606 OID 25274)
-- Name: prospect_list_campaigns idx_24408_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prospect_list_campaigns
    ADD CONSTRAINT idx_24408_primary PRIMARY KEY (id);


--
-- TOC entry 4609 (class 2606 OID 25275)
-- Name: relationships idx_24412_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.relationships
    ADD CONSTRAINT idx_24412_primary PRIMARY KEY (id);


--
-- TOC entry 4612 (class 2606 OID 25276)
-- Name: releases idx_24420_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.releases
    ADD CONSTRAINT idx_24420_primary PRIMARY KEY (id);


--
-- TOC entry 4618 (class 2606 OID 25277)
-- Name: reminders idx_24423_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reminders
    ADD CONSTRAINT idx_24423_primary PRIMARY KEY (id);


--
-- TOC entry 4625 (class 2606 OID 25278)
-- Name: reminders_invitees idx_24430_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reminders_invitees
    ADD CONSTRAINT idx_24430_primary PRIMARY KEY (id);


--
-- TOC entry 4628 (class 2606 OID 25279)
-- Name: roles idx_24437_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT idx_24437_primary PRIMARY KEY (id);


--
-- TOC entry 4632 (class 2606 OID 25280)
-- Name: roles_modules idx_24443_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles_modules
    ADD CONSTRAINT idx_24443_primary PRIMARY KEY (id);


--
-- TOC entry 4636 (class 2606 OID 25281)
-- Name: roles_users idx_24448_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles_users
    ADD CONSTRAINT idx_24448_primary PRIMARY KEY (id);


--
-- TOC entry 4639 (class 2606 OID 25282)
-- Name: saved_search idx_24452_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.saved_search
    ADD CONSTRAINT idx_24452_primary PRIMARY KEY (id);


--
-- TOC entry 4642 (class 2606 OID 25283)
-- Name: schedulers idx_24458_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedulers
    ADD CONSTRAINT idx_24458_primary PRIMARY KEY (id);


--
-- TOC entry 4644 (class 2606 OID 25284)
-- Name: securitygroups idx_24466_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.securitygroups
    ADD CONSTRAINT idx_24466_primary PRIMARY KEY (id);


--
-- TOC entry 4646 (class 2606 OID 25285)
-- Name: securitygroups_acl_roles idx_24473_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.securitygroups_acl_roles
    ADD CONSTRAINT idx_24473_primary PRIMARY KEY (id);


--
-- TOC entry 4649 (class 2606 OID 25286)
-- Name: securitygroups_audit idx_24477_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.securitygroups_audit
    ADD CONSTRAINT idx_24477_primary PRIMARY KEY (id);


--
-- TOC entry 4651 (class 2606 OID 25287)
-- Name: securitygroups_default idx_24483_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.securitygroups_default
    ADD CONSTRAINT idx_24483_primary PRIMARY KEY (id);


--
-- TOC entry 4655 (class 2606 OID 25288)
-- Name: securitygroups_records idx_24487_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.securitygroups_records
    ADD CONSTRAINT idx_24487_primary PRIMARY KEY (id);


--
-- TOC entry 4657 (class 2606 OID 25289)
-- Name: securitygroups_users idx_24491_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.securitygroups_users
    ADD CONSTRAINT idx_24491_primary PRIMARY KEY (id);


--
-- TOC entry 4663 (class 2606 OID 25290)
-- Name: spots idx_24496_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.spots
    ADD CONSTRAINT idx_24496_primary PRIMARY KEY (id);


--
-- TOC entry 4665 (class 2606 OID 25291)
-- Name: sugarfeed idx_24503_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sugarfeed
    ADD CONSTRAINT idx_24503_primary PRIMARY KEY (id);


--
-- TOC entry 4673 (class 2606 OID 25292)
-- Name: tasks idx_24510_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT idx_24510_primary PRIMARY KEY (id);


--
-- TOC entry 4675 (class 2606 OID 25293)
-- Name: templatesectionline idx_24520_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.templatesectionline
    ADD CONSTRAINT idx_24520_primary PRIMARY KEY (id);


--
-- TOC entry 4682 (class 2606 OID 25294)
-- Name: tracker idx_24529_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tracker
    ADD CONSTRAINT idx_24529_primary PRIMARY KEY (id);


--
-- TOC entry 4684 (class 2606 OID 25295)
-- Name: upgrade_history idx_24538_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.upgrade_history
    ADD CONSTRAINT idx_24538_primary PRIMARY KEY (id);


--
-- TOC entry 4688 (class 2606 OID 25296)
-- Name: users idx_24545_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT idx_24545_primary PRIMARY KEY (id);


--
-- TOC entry 4692 (class 2606 OID 25297)
-- Name: users_last_import idx_24561_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_last_import
    ADD CONSTRAINT idx_24561_primary PRIMARY KEY (id);


--
-- TOC entry 4695 (class 2606 OID 25298)
-- Name: users_password_link idx_24564_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_password_link
    ADD CONSTRAINT idx_24564_primary PRIMARY KEY (id);


--
-- TOC entry 4698 (class 2606 OID 25299)
-- Name: users_signatures idx_24567_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_signatures
    ADD CONSTRAINT idx_24567_primary PRIMARY KEY (id);


--
-- TOC entry 4701 (class 2606 OID 25300)
-- Name: user_preferences idx_24573_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_preferences
    ADD CONSTRAINT idx_24573_primary PRIMARY KEY (id);


--
-- TOC entry 4704 (class 2606 OID 25301)
-- Name: vcals idx_24580_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vcals
    ADD CONSTRAINT idx_24580_primary PRIMARY KEY (id);


--
-- TOC entry 3994 (class 1259 OID 24589)
-- Name: idx_23255_idx_accnt_assigned_del; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23255_idx_accnt_assigned_del ON public.accounts USING btree (deleted, assigned_user_id);


--
-- TOC entry 3995 (class 1259 OID 24588)
-- Name: idx_23255_idx_accnt_id_del; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23255_idx_accnt_id_del ON public.accounts USING btree (id, deleted);


--
-- TOC entry 3996 (class 1259 OID 24590)
-- Name: idx_23255_idx_accnt_name_del; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23255_idx_accnt_name_del ON public.accounts USING btree (name, deleted);


--
-- TOC entry 3997 (class 1259 OID 24586)
-- Name: idx_23255_idx_accnt_parent_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23255_idx_accnt_parent_id ON public.accounts USING btree (parent_id);


--
-- TOC entry 4000 (class 1259 OID 24591)
-- Name: idx_23262_idx_accounts_parent_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23262_idx_accounts_parent_id ON public.accounts_audit USING btree (parent_id);


--
-- TOC entry 4003 (class 1259 OID 24594)
-- Name: idx_23268_idx_acc_bug_acc; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23268_idx_acc_bug_acc ON public.accounts_bugs USING btree (account_id);


--
-- TOC entry 4004 (class 1259 OID 24595)
-- Name: idx_23268_idx_acc_bug_bug; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23268_idx_acc_bug_bug ON public.accounts_bugs USING btree (bug_id);


--
-- TOC entry 4005 (class 1259 OID 24596)
-- Name: idx_23268_idx_account_bug; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23268_idx_account_bug ON public.accounts_bugs USING btree (account_id, bug_id);


--
-- TOC entry 4008 (class 1259 OID 24597)
-- Name: idx_23272_idx_acc_acc_case; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23272_idx_acc_acc_case ON public.accounts_cases USING btree (case_id);


--
-- TOC entry 4009 (class 1259 OID 24608)
-- Name: idx_23272_idx_acc_case_acc; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23272_idx_acc_case_acc ON public.accounts_cases USING btree (account_id);


--
-- TOC entry 4012 (class 1259 OID 24602)
-- Name: idx_23276_idx_account_contact; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23276_idx_account_contact ON public.accounts_contacts USING btree (account_id, contact_id);


--
-- TOC entry 4013 (class 1259 OID 24598)
-- Name: idx_23276_idx_contid_del_accid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23276_idx_contid_del_accid ON public.accounts_contacts USING btree (contact_id, deleted, account_id);


--
-- TOC entry 4018 (class 1259 OID 24605)
-- Name: idx_23288_idx_account_opportunity; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23288_idx_account_opportunity ON public.accounts_opportunities USING btree (account_id, opportunity_id);


--
-- TOC entry 4019 (class 1259 OID 24609)
-- Name: idx_23288_idx_oppid_del_accid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23288_idx_oppid_del_accid ON public.accounts_opportunities USING btree (opportunity_id, deleted, account_id);


--
-- TOC entry 4022 (class 1259 OID 24600)
-- Name: idx_23292_idx_aclaction_id_del; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23292_idx_aclaction_id_del ON public.acl_actions USING btree (id, deleted);


--
-- TOC entry 4023 (class 1259 OID 24603)
-- Name: idx_23292_idx_category_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23292_idx_category_name ON public.acl_actions USING btree (category, name);


--
-- TOC entry 4026 (class 1259 OID 24615)
-- Name: idx_23295_idx_aclrole_id_del; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23295_idx_aclrole_id_del ON public.acl_roles USING btree (id, deleted);


--
-- TOC entry 4029 (class 1259 OID 24610)
-- Name: idx_23301_idx_acl_action_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23301_idx_acl_action_id ON public.acl_roles_actions USING btree (action_id);


--
-- TOC entry 4030 (class 1259 OID 24612)
-- Name: idx_23301_idx_acl_role_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23301_idx_acl_role_id ON public.acl_roles_actions USING btree (role_id);


--
-- TOC entry 4031 (class 1259 OID 24619)
-- Name: idx_23301_idx_aclrole_action; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23301_idx_aclrole_action ON public.acl_roles_actions USING btree (role_id, action_id);


--
-- TOC entry 4034 (class 1259 OID 24617)
-- Name: idx_23305_idx_aclrole_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23305_idx_aclrole_id ON public.acl_roles_users USING btree (role_id);


--
-- TOC entry 4035 (class 1259 OID 24613)
-- Name: idx_23305_idx_aclrole_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23305_idx_aclrole_user ON public.acl_roles_users USING btree (role_id, user_id);


--
-- TOC entry 4036 (class 1259 OID 24616)
-- Name: idx_23305_idx_acluser_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23305_idx_acluser_id ON public.acl_roles_users USING btree (user_id);


--
-- TOC entry 4039 (class 1259 OID 24622)
-- Name: idx_23309_ab_user_bean_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23309_ab_user_bean_idx ON public.address_book USING btree (assigned_user_id, bean);


--
-- TOC entry 4044 (class 1259 OID 24626)
-- Name: idx_23329_idx_am_projecttemplates_parent_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23329_idx_am_projecttemplates_parent_id ON public.am_projecttemplates_audit USING btree (parent_id);


--
-- TOC entry 4047 (class 1259 OID 24621)
-- Name: idx_23335_am_projecttemplates_contacts_1_alt; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23335_am_projecttemplates_contacts_1_alt ON public.am_projecttemplates_contacts_1_c USING btree (am_projecttemplates_ida, contacts_idb);


--
-- TOC entry 4050 (class 1259 OID 24633)
-- Name: idx_23339_am_projecttemplates_project_1_alt; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23339_am_projecttemplates_project_1_alt ON public.am_projecttemplates_project_1_c USING btree (am_projecttemplates_project_1project_idb);


--
-- TOC entry 4051 (class 1259 OID 24627)
-- Name: idx_23339_am_projecttemplates_project_1_ida1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23339_am_projecttemplates_project_1_ida1 ON public.am_projecttemplates_project_1_c USING btree (am_projecttemplates_project_1am_projecttemplates_ida);


--
-- TOC entry 4054 (class 1259 OID 24625)
-- Name: idx_23343_am_projecttemplates_users_1_alt; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23343_am_projecttemplates_users_1_alt ON public.am_projecttemplates_users_1_c USING btree (am_projecttemplates_ida, users_idb);


--
-- TOC entry 4059 (class 1259 OID 24631)
-- Name: idx_23360_am_tasktemplates_am_projecttemplates_alt; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23360_am_tasktemplates_am_projecttemplates_alt ON public.am_tasktemplates_am_projecttemplates_c USING btree (am_tasktemplates_am_projecttemplatesam_tasktemplates_idb);


--
-- TOC entry 4060 (class 1259 OID 24639)
-- Name: idx_23360_am_tasktemplates_am_projecttemplates_ida1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23360_am_tasktemplates_am_projecttemplates_ida1 ON public.am_tasktemplates_am_projecttemplates_c USING btree (am_tasktemplates_am_projecttemplatesam_projecttemplates_ida);


--
-- TOC entry 4063 (class 1259 OID 24638)
-- Name: idx_23364_idx_am_tasktemplates_parent_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23364_idx_am_tasktemplates_parent_id ON public.am_tasktemplates_audit USING btree (parent_id);


--
-- TOC entry 4070 (class 1259 OID 24641)
-- Name: idx_23387_idx_record_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23387_idx_record_id ON public.aod_indexevent USING btree (record_id);


--
-- TOC entry 4071 (class 1259 OID 24637)
-- Name: idx_23387_idx_record_module; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23387_idx_record_module ON public.aod_indexevent USING btree (record_module);


--
-- TOC entry 4074 (class 1259 OID 24636)
-- Name: idx_23395_idx_aod_indexevent_parent_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23395_idx_aod_indexevent_parent_id ON public.aod_indexevent_audit USING btree (parent_id);


--
-- TOC entry 4077 (class 1259 OID 24643)
-- Name: idx_23401_idx_aod_index_parent_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23401_idx_aod_index_parent_id ON public.aod_index_audit USING btree (parent_id);


--
-- TOC entry 4082 (class 1259 OID 24651)
-- Name: idx_23415_idx_aok_knowledgebase_parent_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23415_idx_aok_knowledgebase_parent_id ON public.aok_knowledgebase_audit USING btree (parent_id);


--
-- TOC entry 4085 (class 1259 OID 24644)
-- Name: idx_23421_aok_knowledgebase_categories_alt; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23421_aok_knowledgebase_categories_alt ON public.aok_knowledgebase_categories USING btree (aok_knowledgebase_id, aok_knowledge_base_categories_id);


--
-- TOC entry 4090 (class 1259 OID 24649)
-- Name: idx_23432_idx_aok_knowledge_base_categories_parent_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23432_idx_aok_knowledge_base_categories_parent_id ON public.aok_knowledge_base_categories_audit USING btree (parent_id);


--
-- TOC entry 4095 (class 1259 OID 24657)
-- Name: idx_23445_idx_aop_case_events_parent_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23445_idx_aop_case_events_parent_id ON public.aop_case_events_audit USING btree (parent_id);


--
-- TOC entry 4100 (class 1259 OID 24665)
-- Name: idx_23458_idx_aop_case_updates_parent_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23458_idx_aop_case_updates_parent_id ON public.aop_case_updates_audit USING btree (parent_id);


--
-- TOC entry 4105 (class 1259 OID 24659)
-- Name: idx_23471_aor_conditions_index_report_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23471_aor_conditions_index_report_id ON public.aor_conditions USING btree (aor_report_id);


--
-- TOC entry 4108 (class 1259 OID 24664)
-- Name: idx_23478_aor_fields_index_report_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23478_aor_fields_index_report_id ON public.aor_fields USING btree (aor_report_id);


--
-- TOC entry 4113 (class 1259 OID 24658)
-- Name: idx_23493_idx_aor_reports_parent_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23493_idx_aor_reports_parent_id ON public.aor_reports_audit USING btree (parent_id);


--
-- TOC entry 4120 (class 1259 OID 24678)
-- Name: idx_23515_idx_aos_contracts_parent_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23515_idx_aos_contracts_parent_id ON public.aos_contracts_audit USING btree (parent_id);


--
-- TOC entry 4123 (class 1259 OID 24670)
-- Name: idx_23521_aos_contracts_documents_alt; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23521_aos_contracts_documents_alt ON public.aos_contracts_documents USING btree (aos_contracts_id, documents_id);


--
-- TOC entry 4128 (class 1259 OID 24679)
-- Name: idx_23532_idx_aos_invoices_parent_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23532_idx_aos_invoices_parent_id ON public.aos_invoices_audit USING btree (parent_id);


--
-- TOC entry 4133 (class 1259 OID 24668)
-- Name: idx_23545_idx_aos_line_item_groups_parent_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23545_idx_aos_line_item_groups_parent_id ON public.aos_line_item_groups_audit USING btree (parent_id);


--
-- TOC entry 4138 (class 1259 OID 24686)
-- Name: idx_23565_idx_aos_pdf_templates_parent_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23565_idx_aos_pdf_templates_parent_id ON public.aos_pdf_templates_audit USING btree (parent_id);


--
-- TOC entry 4143 (class 1259 OID 24681)
-- Name: idx_23580_idx_aos_products_parent_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23580_idx_aos_products_parent_id ON public.aos_products_audit USING btree (parent_id);


--
-- TOC entry 4146 (class 1259 OID 24693)
-- Name: idx_23586_idx_aospq_par_del; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23586_idx_aospq_par_del ON public.aos_products_quotes USING btree (parent_id, parent_type, deleted);


--
-- TOC entry 4149 (class 1259 OID 24685)
-- Name: idx_23595_idx_aos_products_quotes_parent_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23595_idx_aos_products_quotes_parent_id ON public.aos_products_quotes_audit USING btree (parent_id);


--
-- TOC entry 4154 (class 1259 OID 24694)
-- Name: idx_23609_idx_aos_product_categories_parent_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23609_idx_aos_product_categories_parent_id ON public.aos_product_categories_audit USING btree (parent_id);


--
-- TOC entry 4159 (class 1259 OID 24703)
-- Name: idx_23624_aos_quotes_aos_invoices_alt; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23624_aos_quotes_aos_invoices_alt ON public.aos_quotes_aos_invoices_c USING btree (aos_quotes77d9_quotes_ida, aos_quotes6b83nvoices_idb);


--
-- TOC entry 4162 (class 1259 OID 24692)
-- Name: idx_23628_idx_aos_quotes_parent_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23628_idx_aos_quotes_parent_id ON public.aos_quotes_audit USING btree (parent_id);


--
-- TOC entry 4165 (class 1259 OID 24707)
-- Name: idx_23634_aos_quotes_aos_contracts_alt; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23634_aos_quotes_aos_contracts_alt ON public.aos_quotes_os_contracts_c USING btree (aos_quotese81e_quotes_ida, aos_quotes4dc0ntracts_idb);


--
-- TOC entry 4168 (class 1259 OID 24699)
-- Name: idx_23638_aos_quotes_project_alt; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23638_aos_quotes_project_alt ON public.aos_quotes_project_c USING btree (aos_quotes1112_quotes_ida, aos_quotes7207project_idb);


--
-- TOC entry 4171 (class 1259 OID 24696)
-- Name: idx_23642_aow_action_index_workflow_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23642_aow_action_index_workflow_id ON public.aow_actions USING btree (aow_workflow_id);


--
-- TOC entry 4174 (class 1259 OID 24700)
-- Name: idx_23649_aow_conditions_index_workflow_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23649_aow_conditions_index_workflow_id ON public.aow_conditions USING btree (aow_workflow_id);


--
-- TOC entry 4177 (class 1259 OID 24712)
-- Name: idx_23656_aow_processed_index_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23656_aow_processed_index_status ON public.aow_processed USING btree (status);


--
-- TOC entry 4178 (class 1259 OID 24714)
-- Name: idx_23656_aow_processed_index_workflow; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23656_aow_processed_index_workflow ON public.aow_processed USING btree (aow_workflow_id, status, parent_id, deleted);


--
-- TOC entry 4179 (class 1259 OID 24704)
-- Name: idx_23656_aow_processed_index_workflow_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23656_aow_processed_index_workflow_id ON public.aow_processed USING btree (aow_workflow_id);


--
-- TOC entry 4182 (class 1259 OID 24717)
-- Name: idx_23664_idx_actid_del_freid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23664_idx_actid_del_freid ON public.aow_processed_aow_actions USING btree (aow_action_id, deleted, aow_processed_id);


--
-- TOC entry 4183 (class 1259 OID 24715)
-- Name: idx_23664_idx_aow_processed_aow_actions; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23664_idx_aow_processed_aow_actions ON public.aow_processed_aow_actions USING btree (aow_processed_id, aow_action_id);


--
-- TOC entry 4186 (class 1259 OID 24711)
-- Name: idx_23669_aow_workflow_index_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23669_aow_workflow_index_status ON public.aow_workflow USING btree (status);


--
-- TOC entry 4189 (class 1259 OID 24718)
-- Name: idx_23680_idx_aow_workflow_parent_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23680_idx_aow_workflow_parent_id ON public.aow_workflow_audit USING btree (parent_id);


--
-- TOC entry 4192 (class 1259 OID 24724)
-- Name: idx_23688_bug_number; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23688_bug_number ON public.bugs USING btree (bug_number);


--
-- TOC entry 4193 (class 1259 OID 24723)
-- Name: idx_23688_bugsnumk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_23688_bugsnumk ON public.bugs USING btree (bug_number);


--
-- TOC entry 4194 (class 1259 OID 24719)
-- Name: idx_23688_idx_bug_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23688_idx_bug_name ON public.bugs USING btree (name);


--
-- TOC entry 4195 (class 1259 OID 24727)
-- Name: idx_23688_idx_bugs_assigned_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23688_idx_bugs_assigned_user ON public.bugs USING btree (assigned_user_id);


--
-- TOC entry 4198 (class 1259 OID 24731)
-- Name: idx_23696_idx_bugs_parent_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23696_idx_bugs_parent_id ON public.bugs_audit USING btree (parent_id);


--
-- TOC entry 4201 (class 1259 OID 24729)
-- Name: idx_23702_idx_call_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23702_idx_call_name ON public.calls USING btree (name);


--
-- TOC entry 4202 (class 1259 OID 24721)
-- Name: idx_23702_idx_calls_assigned_del; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23702_idx_calls_assigned_del ON public.calls USING btree (deleted, assigned_user_id);


--
-- TOC entry 4203 (class 1259 OID 24722)
-- Name: idx_23702_idx_calls_date_start; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23702_idx_calls_date_start ON public.calls USING btree (date_start);


--
-- TOC entry 4204 (class 1259 OID 24720)
-- Name: idx_23702_idx_calls_par_del; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23702_idx_calls_par_del ON public.calls USING btree (parent_id, parent_type, deleted);


--
-- TOC entry 4205 (class 1259 OID 24725)
-- Name: idx_23702_idx_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23702_idx_status ON public.calls USING btree (status);


--
-- TOC entry 4208 (class 1259 OID 24734)
-- Name: idx_23714_idx_call_contact; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23714_idx_call_contact ON public.calls_contacts USING btree (call_id, contact_id);


--
-- TOC entry 4209 (class 1259 OID 24739)
-- Name: idx_23714_idx_con_call_call; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23714_idx_con_call_call ON public.calls_contacts USING btree (call_id);


--
-- TOC entry 4210 (class 1259 OID 24732)
-- Name: idx_23714_idx_con_call_con; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23714_idx_con_call_con ON public.calls_contacts USING btree (contact_id);


--
-- TOC entry 4213 (class 1259 OID 24741)
-- Name: idx_23720_idx_call_lead; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23720_idx_call_lead ON public.calls_leads USING btree (call_id, lead_id);


--
-- TOC entry 4214 (class 1259 OID 24738)
-- Name: idx_23720_idx_lead_call_call; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23720_idx_lead_call_call ON public.calls_leads USING btree (call_id);


--
-- TOC entry 4215 (class 1259 OID 24735)
-- Name: idx_23720_idx_lead_call_lead; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23720_idx_lead_call_lead ON public.calls_leads USING btree (lead_id);


--
-- TOC entry 4220 (class 1259 OID 24742)
-- Name: idx_23733_idx_calls_reschedule_parent_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23733_idx_calls_reschedule_parent_id ON public.calls_reschedule_audit USING btree (parent_id);


--
-- TOC entry 4223 (class 1259 OID 24750)
-- Name: idx_23739_idx_call_users; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23739_idx_call_users ON public.calls_users USING btree (call_id, user_id);


--
-- TOC entry 4224 (class 1259 OID 24747)
-- Name: idx_23739_idx_usr_call_call; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23739_idx_usr_call_call ON public.calls_users USING btree (call_id);


--
-- TOC entry 4225 (class 1259 OID 24748)
-- Name: idx_23739_idx_usr_call_usr; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23739_idx_usr_call_usr ON public.calls_users USING btree (user_id);


--
-- TOC entry 4228 (class 1259 OID 24737)
-- Name: idx_23747_camp_auto_tracker_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23747_camp_auto_tracker_key ON public.campaigns USING btree (tracker_key);


--
-- TOC entry 4229 (class 1259 OID 24754)
-- Name: idx_23747_idx_campaign_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23747_idx_campaign_name ON public.campaigns USING btree (name);


--
-- TOC entry 4232 (class 1259 OID 24749)
-- Name: idx_23758_idx_campaigns_parent_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23758_idx_campaigns_parent_id ON public.campaigns_audit USING btree (parent_id);


--
-- TOC entry 4235 (class 1259 OID 24744)
-- Name: idx_23764_idx_camp_campaign_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23764_idx_camp_campaign_id ON public.campaign_log USING btree (campaign_id);


--
-- TOC entry 4236 (class 1259 OID 24753)
-- Name: idx_23764_idx_camp_more_info; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23764_idx_camp_more_info ON public.campaign_log USING btree (more_information);


--
-- TOC entry 4237 (class 1259 OID 24751)
-- Name: idx_23764_idx_camp_tracker; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23764_idx_camp_tracker ON public.campaign_log USING btree (target_tracker_key);


--
-- TOC entry 4238 (class 1259 OID 24760)
-- Name: idx_23764_idx_target_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23764_idx_target_id ON public.campaign_log USING btree (target_id);


--
-- TOC entry 4239 (class 1259 OID 24759)
-- Name: idx_23764_idx_target_id_deleted; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23764_idx_target_id_deleted ON public.campaign_log USING btree (target_id, deleted);


--
-- TOC entry 4242 (class 1259 OID 24756)
-- Name: idx_23774_campaign_tracker_key_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23774_campaign_tracker_key_idx ON public.campaign_trkrs USING btree (tracker_key);


--
-- TOC entry 4245 (class 1259 OID 24764)
-- Name: idx_23783_case_number; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23783_case_number ON public.cases USING btree (case_number);


--
-- TOC entry 4246 (class 1259 OID 24766)
-- Name: idx_23783_casesnumk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_23783_casesnumk ON public.cases USING btree (case_number);


--
-- TOC entry 4247 (class 1259 OID 24763)
-- Name: idx_23783_idx_account_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23783_idx_account_id ON public.cases USING btree (account_id);


--
-- TOC entry 4248 (class 1259 OID 24755)
-- Name: idx_23783_idx_case_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23783_idx_case_name ON public.cases USING btree (name);


--
-- TOC entry 4249 (class 1259 OID 24757)
-- Name: idx_23783_idx_cases_stat_del; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23783_idx_cases_stat_del ON public.cases USING btree (assigned_user_id, status, deleted);


--
-- TOC entry 4252 (class 1259 OID 24761)
-- Name: idx_23792_idx_cases_parent_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23792_idx_cases_parent_id ON public.cases_audit USING btree (parent_id);


--
-- TOC entry 4255 (class 1259 OID 24771)
-- Name: idx_23798_idx_cas_bug_bug; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23798_idx_cas_bug_bug ON public.cases_bugs USING btree (bug_id);


--
-- TOC entry 4256 (class 1259 OID 24767)
-- Name: idx_23798_idx_cas_bug_cas; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23798_idx_cas_bug_cas ON public.cases_bugs USING btree (case_id);


--
-- TOC entry 4257 (class 1259 OID 24775)
-- Name: idx_23798_idx_case_bug; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23798_idx_case_bug ON public.cases_bugs USING btree (case_id, bug_id);


--
-- TOC entry 4262 (class 1259 OID 24774)
-- Name: idx_23810_idx_config_cat; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23810_idx_config_cat ON public.config USING btree (category);


--
-- TOC entry 4263 (class 1259 OID 24769)
-- Name: idx_23816_idx_cont_assigned; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23816_idx_cont_assigned ON public.contacts USING btree (assigned_user_id);


--
-- TOC entry 4264 (class 1259 OID 24768)
-- Name: idx_23816_idx_cont_del_reports; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23816_idx_cont_del_reports ON public.contacts USING btree (deleted, reports_to_id, last_name);


--
-- TOC entry 4265 (class 1259 OID 24779)
-- Name: idx_23816_idx_cont_last_first; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23816_idx_cont_last_first ON public.contacts USING btree (last_name, first_name, deleted);


--
-- TOC entry 4266 (class 1259 OID 24776)
-- Name: idx_23816_idx_contacts_del_last; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23816_idx_contacts_del_last ON public.contacts USING btree (deleted, last_name);


--
-- TOC entry 4267 (class 1259 OID 24770)
-- Name: idx_23816_idx_del_id_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23816_idx_del_id_user ON public.contacts USING btree (deleted, id, assigned_user_id);


--
-- TOC entry 4268 (class 1259 OID 24785)
-- Name: idx_23816_idx_reports_to_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23816_idx_reports_to_id ON public.contacts USING btree (reports_to_id);


--
-- TOC entry 4271 (class 1259 OID 24784)
-- Name: idx_23825_idx_contacts_parent_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23825_idx_contacts_parent_id ON public.contacts_audit USING btree (parent_id);


--
-- TOC entry 4274 (class 1259 OID 24786)
-- Name: idx_23831_idx_con_bug_bug; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23831_idx_con_bug_bug ON public.contacts_bugs USING btree (bug_id);


--
-- TOC entry 4275 (class 1259 OID 24791)
-- Name: idx_23831_idx_con_bug_con; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23831_idx_con_bug_con ON public.contacts_bugs USING btree (contact_id);


--
-- TOC entry 4276 (class 1259 OID 24772)
-- Name: idx_23831_idx_contact_bug; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23831_idx_contact_bug ON public.contacts_bugs USING btree (contact_id, bug_id);


--
-- TOC entry 4279 (class 1259 OID 24781)
-- Name: idx_23835_idx_con_case_case; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23835_idx_con_case_case ON public.contacts_cases USING btree (case_id);


--
-- TOC entry 4280 (class 1259 OID 24790)
-- Name: idx_23835_idx_con_case_con; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23835_idx_con_case_con ON public.contacts_cases USING btree (contact_id);


--
-- TOC entry 4281 (class 1259 OID 24780)
-- Name: idx_23835_idx_contacts_cases; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23835_idx_contacts_cases ON public.contacts_cases USING btree (contact_id, case_id);


--
-- TOC entry 4286 (class 1259 OID 24797)
-- Name: idx_23847_idx_con_users_con; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23847_idx_con_users_con ON public.contacts_users USING btree (contact_id);


--
-- TOC entry 4287 (class 1259 OID 24789)
-- Name: idx_23847_idx_con_users_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23847_idx_con_users_user ON public.contacts_users USING btree (user_id);


--
-- TOC entry 4288 (class 1259 OID 24804)
-- Name: idx_23847_idx_contacts_users; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23847_idx_contacts_users ON public.contacts_users USING btree (contact_id, user_id);


--
-- TOC entry 4291 (class 1259 OID 24801)
-- Name: idx_23851_idx_cron_remove_document_bean_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23851_idx_cron_remove_document_bean_id ON public.cron_remove_documents USING btree (bean_id);


--
-- TOC entry 4292 (class 1259 OID 24803)
-- Name: idx_23851_idx_cron_remove_document_stamp; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23851_idx_cron_remove_document_stamp ON public.cron_remove_documents USING btree (date_modified);


--
-- TOC entry 4295 (class 1259 OID 24792)
-- Name: idx_23854_idx_currency_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23854_idx_currency_name ON public.currencies USING btree (name, deleted);


--
-- TOC entry 4298 (class 1259 OID 24805)
-- Name: idx_23858_idx_beanid_set_num; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23858_idx_beanid_set_num ON public.custom_fields USING btree (bean_id, set_num);


--
-- TOC entry 4299 (class 1259 OID 24794)
-- Name: idx_23866_idx_doc_cat; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23866_idx_doc_cat ON public.documents USING btree (category_id, subcategory_id);


--
-- TOC entry 4302 (class 1259 OID 24811)
-- Name: idx_23875_documents_accounts_account_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23875_documents_accounts_account_id ON public.documents_accounts USING btree (account_id, document_id);


--
-- TOC entry 4303 (class 1259 OID 24812)
-- Name: idx_23875_documents_accounts_document_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23875_documents_accounts_document_id ON public.documents_accounts USING btree (document_id, account_id);


--
-- TOC entry 4306 (class 1259 OID 24795)
-- Name: idx_23879_documents_bugs_bug_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23879_documents_bugs_bug_id ON public.documents_bugs USING btree (bug_id, document_id);


--
-- TOC entry 4307 (class 1259 OID 24814)
-- Name: idx_23879_documents_bugs_document_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23879_documents_bugs_document_id ON public.documents_bugs USING btree (document_id, bug_id);


--
-- TOC entry 4310 (class 1259 OID 24816)
-- Name: idx_23883_documents_cases_case_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23883_documents_cases_case_id ON public.documents_cases USING btree (case_id, document_id);


--
-- TOC entry 4311 (class 1259 OID 24800)
-- Name: idx_23883_documents_cases_document_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23883_documents_cases_document_id ON public.documents_cases USING btree (document_id, case_id);


--
-- TOC entry 4314 (class 1259 OID 24808)
-- Name: idx_23887_documents_contacts_contact_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23887_documents_contacts_contact_id ON public.documents_contacts USING btree (contact_id, document_id);


--
-- TOC entry 4315 (class 1259 OID 24807)
-- Name: idx_23887_documents_contacts_document_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23887_documents_contacts_document_id ON public.documents_contacts USING btree (document_id, contact_id);


--
-- TOC entry 4318 (class 1259 OID 24825)
-- Name: idx_23891_idx_docu_oppo_docu_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23891_idx_docu_oppo_docu_id ON public.documents_opportunities USING btree (document_id, opportunity_id);


--
-- TOC entry 4319 (class 1259 OID 24824)
-- Name: idx_23891_idx_docu_opps_oppo_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23891_idx_docu_opps_oppo_id ON public.documents_opportunities USING btree (opportunity_id, document_id);


--
-- TOC entry 4322 (class 1259 OID 24806)
-- Name: idx_23895_documentrevision_mimetype; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23895_documentrevision_mimetype ON public.document_revisions USING btree (file_mime_type);


--
-- TOC entry 4325 (class 1259 OID 24819)
-- Name: idx_23902_idx_app_active; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23902_idx_app_active ON public.eapm USING btree (assigned_user_id, application, validated);


--
-- TOC entry 4328 (class 1259 OID 24813)
-- Name: idx_23912_idx_eman_campaign_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23912_idx_eman_campaign_id ON public.emailman USING btree (campaign_id);


--
-- TOC entry 4329 (class 1259 OID 24817)
-- Name: idx_23912_idx_eman_list; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23912_idx_eman_list ON public.emailman USING btree (list_id, user_id, deleted);


--
-- TOC entry 4330 (class 1259 OID 24829)
-- Name: idx_23912_idx_eman_relid_reltype_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23912_idx_eman_relid_reltype_id ON public.emailman USING btree (related_id, related_type, campaign_id);


--
-- TOC entry 4333 (class 1259 OID 24835)
-- Name: idx_23919_idx_email_assigned; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23919_idx_email_assigned ON public.emails USING btree (assigned_user_id, type, status);


--
-- TOC entry 4334 (class 1259 OID 24836)
-- Name: idx_23919_idx_email_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23919_idx_email_name ON public.emails USING btree (name);


--
-- TOC entry 4335 (class 1259 OID 24840)
-- Name: idx_23919_idx_email_parent_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23919_idx_email_parent_id ON public.emails USING btree (parent_id);


--
-- TOC entry 4336 (class 1259 OID 24820)
-- Name: idx_23919_idx_message_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23919_idx_message_id ON public.emails USING btree (message_id);


--
-- TOC entry 4339 (class 1259 OID 24838)
-- Name: idx_23926_idx_emails_beans_bean_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23926_idx_emails_beans_bean_id ON public.emails_beans USING btree (bean_id);


--
-- TOC entry 4340 (class 1259 OID 24831)
-- Name: idx_23926_idx_emails_beans_email_bean; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23926_idx_emails_beans_email_bean ON public.emails_beans USING btree (email_id, bean_id, deleted);


--
-- TOC entry 4343 (class 1259 OID 24826)
-- Name: idx_23933_idx_eearl_address_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23933_idx_eearl_address_id ON public.emails_email_addr_rel USING btree (email_address_id);


--
-- TOC entry 4344 (class 1259 OID 24828)
-- Name: idx_23933_idx_eearl_email_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23933_idx_eearl_email_id ON public.emails_email_addr_rel USING btree (email_id, address_type);


--
-- TOC entry 4347 (class 1259 OID 24833)
-- Name: idx_23937_emails_textfromaddr; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23937_emails_textfromaddr ON public.emails_text USING btree (from_addr);


--
-- TOC entry 4350 (class 1259 OID 24844)
-- Name: idx_23944_idx_ea_caps_opt_out_invalid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23944_idx_ea_caps_opt_out_invalid ON public.email_addresses USING btree (email_address_caps, opt_out, invalid_email);


--
-- TOC entry 4351 (class 1259 OID 24849)
-- Name: idx_23944_idx_ea_opt_out_invalid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23944_idx_ea_opt_out_invalid ON public.email_addresses USING btree (email_address, opt_out, invalid_email);


--
-- TOC entry 4354 (class 1259 OID 24830)
-- Name: idx_23953_idx_bean_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23953_idx_bean_id ON public.email_addr_bean_rel USING btree (bean_id, bean_module);


--
-- TOC entry 4355 (class 1259 OID 24853)
-- Name: idx_23953_idx_email_address_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23953_idx_email_address_id ON public.email_addr_bean_rel USING btree (email_address_id);


--
-- TOC entry 4358 (class 1259 OID 24847)
-- Name: idx_23959_idx_ie_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23959_idx_ie_id ON public.email_cache USING btree (ie_id);


--
-- TOC entry 4359 (class 1259 OID 24841)
-- Name: idx_23959_idx_mail_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23959_idx_mail_date ON public.email_cache USING btree (ie_id, mbox, senddate);


--
-- TOC entry 4360 (class 1259 OID 24832)
-- Name: idx_23959_idx_mail_from; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23959_idx_mail_from ON public.email_cache USING btree (ie_id, mbox, fromaddr);


--
-- TOC entry 4361 (class 1259 OID 24850)
-- Name: idx_23959_idx_mail_subj; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23959_idx_mail_subj ON public.email_cache USING btree (subject);


--
-- TOC entry 4362 (class 1259 OID 24846)
-- Name: idx_23959_idx_mail_to; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23959_idx_mail_to ON public.email_cache USING btree (toaddr);


--
-- TOC entry 4363 (class 1259 OID 24864)
-- Name: idx_23965_idx_emmkit_del; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23965_idx_emmkit_del ON public.email_marketing USING btree (deleted);


--
-- TOC entry 4364 (class 1259 OID 24859)
-- Name: idx_23965_idx_emmkt_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23965_idx_emmkt_name ON public.email_marketing USING btree (name);


--
-- TOC entry 4367 (class 1259 OID 24854)
-- Name: idx_23972_email_mp_prospects; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23972_email_mp_prospects ON public.email_marketing_prospect_lists USING btree (email_marketing_id, prospect_list_id);


--
-- TOC entry 4370 (class 1259 OID 24865)
-- Name: idx_23976_idx_email_template_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23976_idx_email_template_name ON public.email_templates USING btree (name);


--
-- TOC entry 4375 (class 1259 OID 24851)
-- Name: idx_23989_idx_meta_cm_del; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23989_idx_meta_cm_del ON public.fields_meta_data USING btree (custom_module, deleted);


--
-- TOC entry 4376 (class 1259 OID 24845)
-- Name: idx_23989_idx_meta_id_del; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_23989_idx_meta_id_del ON public.fields_meta_data USING btree (id, deleted);


--
-- TOC entry 4379 (class 1259 OID 24857)
-- Name: idx_24001_idx_parent_folder; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24001_idx_parent_folder ON public.folders USING btree (parent_folder);


--
-- TOC entry 4382 (class 1259 OID 24870)
-- Name: idx_24011_idx_fr_id_deleted_poly; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24011_idx_fr_id_deleted_poly ON public.folders_rel USING btree (folder_id, deleted, polymorphic_id);


--
-- TOC entry 4383 (class 1259 OID 24876)
-- Name: idx_24011_idx_poly_module_poly_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24011_idx_poly_module_poly_id ON public.folders_rel USING btree (polymorphic_module, polymorphic_id);


--
-- TOC entry 4386 (class 1259 OID 24848)
-- Name: idx_24015_idx_folder_id_assigned_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24015_idx_folder_id_assigned_user_id ON public.folders_subscriptions USING btree (folder_id, assigned_user_id);


--
-- TOC entry 4391 (class 1259 OID 24872)
-- Name: idx_24025_idx_fp_events_parent_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24025_idx_fp_events_parent_id ON public.fp_events_audit USING btree (parent_id);


--
-- TOC entry 4394 (class 1259 OID 24858)
-- Name: idx_24031_fp_events_contacts_alt; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24031_fp_events_contacts_alt ON public.fp_events_contacts_c USING btree (fp_events_contactsfp_events_ida, fp_events_contactscontacts_idb);


--
-- TOC entry 4397 (class 1259 OID 24871)
-- Name: idx_24038_fp_events_fp_event_delegates_1_alt; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24038_fp_events_fp_event_delegates_1_alt ON public.fp_events_fp_event_delegates_1_c USING btree (fp_events_fp_event_delegates_1fp_event_delegates_idb);


--
-- TOC entry 4398 (class 1259 OID 24888)
-- Name: idx_24038_fp_events_fp_event_delegates_1_ida1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24038_fp_events_fp_event_delegates_1_ida1 ON public.fp_events_fp_event_delegates_1_c USING btree (fp_events_fp_event_delegates_1fp_events_ida);


--
-- TOC entry 4401 (class 1259 OID 24885)
-- Name: idx_24042_fp_events_fp_event_locations_1_alt; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24042_fp_events_fp_event_locations_1_alt ON public.fp_events_fp_event_locations_1_c USING btree (fp_events_fp_event_locations_1fp_events_ida, fp_events_fp_event_locations_1fp_event_locations_idb);


--
-- TOC entry 4404 (class 1259 OID 24856)
-- Name: idx_24046_fp_events_leads_1_alt; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24046_fp_events_leads_1_alt ON public.fp_events_leads_1_c USING btree (fp_events_leads_1fp_events_ida, fp_events_leads_1leads_idb);


--
-- TOC entry 4407 (class 1259 OID 24879)
-- Name: idx_24053_fp_events_prospects_1_alt; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24053_fp_events_prospects_1_alt ON public.fp_events_prospects_1_c USING btree (fp_events_prospects_1fp_events_ida, fp_events_prospects_1prospects_idb);


--
-- TOC entry 4412 (class 1259 OID 24869)
-- Name: idx_24067_idx_fp_event_locations_parent_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24067_idx_fp_event_locations_parent_id ON public.fp_event_locations_audit USING btree (parent_id);


--
-- TOC entry 4415 (class 1259 OID 24884)
-- Name: idx_24073_fp_event_locations_fp_events_1_alt; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24073_fp_event_locations_fp_events_1_alt ON public.fp_event_locations_fp_events_1_c USING btree (fp_event_locations_fp_events_1fp_events_idb);


--
-- TOC entry 4416 (class 1259 OID 24902)
-- Name: idx_24073_fp_event_locations_fp_events_1_ida1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24073_fp_event_locations_fp_events_1_ida1 ON public.fp_event_locations_fp_events_1_c USING btree (fp_event_locations_fp_events_1fp_event_locations_ida);


--
-- TOC entry 4419 (class 1259 OID 24897)
-- Name: idx_24077_idx_owner_module_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24077_idx_owner_module_name ON public.import_maps USING btree (assigned_user_id, module, name, deleted);


--
-- TOC entry 4424 (class 1259 OID 24898)
-- Name: idx_24097_idx_ie_autoreplied_to; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24097_idx_ie_autoreplied_to ON public.inbound_email_autoreply USING btree (autoreplied_to);


--
-- TOC entry 4431 (class 1259 OID 24880)
-- Name: idx_24111_idx_jjwg_address_cache_parent_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24111_idx_jjwg_address_cache_parent_id ON public.jjwg_address_cache_audit USING btree (parent_id);


--
-- TOC entry 4436 (class 1259 OID 24916)
-- Name: idx_24124_idx_jjwg_areas_parent_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24124_idx_jjwg_areas_parent_id ON public.jjwg_areas_audit USING btree (parent_id);


--
-- TOC entry 4441 (class 1259 OID 24901)
-- Name: idx_24139_idx_jjwg_maps_parent_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24139_idx_jjwg_maps_parent_id ON public.jjwg_maps_audit USING btree (parent_id);


--
-- TOC entry 4444 (class 1259 OID 24914)
-- Name: idx_24145_jjwg_maps_jjwg_areas_alt; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24145_jjwg_maps_jjwg_areas_alt ON public.jjwg_maps_jjwg_areas_c USING btree (jjwg_maps_5304wg_maps_ida, jjwg_maps_41f2g_areas_idb);


--
-- TOC entry 4447 (class 1259 OID 24908)
-- Name: idx_24149_jjwg_maps_jjwg_markers_alt; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24149_jjwg_maps_jjwg_markers_alt ON public.jjwg_maps_jjwg_markers_c USING btree (jjwg_maps_b229wg_maps_ida, jjwg_maps_2e31markers_idb);


--
-- TOC entry 4452 (class 1259 OID 24912)
-- Name: idx_24163_idx_jjwg_markers_parent_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24163_idx_jjwg_markers_parent_id ON public.jjwg_markers_audit USING btree (parent_id);


--
-- TOC entry 4455 (class 1259 OID 24925)
-- Name: idx_24169_idx_status_entered; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24169_idx_status_entered ON public.job_queue USING btree (status, date_entered);


--
-- TOC entry 4456 (class 1259 OID 24918)
-- Name: idx_24169_idx_status_modified; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24169_idx_status_modified ON public.job_queue USING btree (status, date_modified);


--
-- TOC entry 4457 (class 1259 OID 24921)
-- Name: idx_24169_idx_status_scheduler; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24169_idx_status_scheduler ON public.job_queue USING btree (status, scheduler_id);


--
-- TOC entry 4458 (class 1259 OID 24911)
-- Name: idx_24169_idx_status_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24169_idx_status_time ON public.job_queue USING btree (status, execute_time, date_entered);


--
-- TOC entry 4461 (class 1259 OID 24927)
-- Name: idx_24177_idx_del_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24177_idx_del_user ON public.leads USING btree (deleted, assigned_user_id);


--
-- TOC entry 4462 (class 1259 OID 24913)
-- Name: idx_24177_idx_lead_acct_name_first; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24177_idx_lead_acct_name_first ON public.leads USING btree (account_name, deleted);


--
-- TOC entry 4463 (class 1259 OID 24906)
-- Name: idx_24177_idx_lead_assigned; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24177_idx_lead_assigned ON public.leads USING btree (assigned_user_id);


--
-- TOC entry 4464 (class 1259 OID 24924)
-- Name: idx_24177_idx_lead_contact; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24177_idx_lead_contact ON public.leads USING btree (contact_id);


--
-- TOC entry 4465 (class 1259 OID 24919)
-- Name: idx_24177_idx_lead_del_stat; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24177_idx_lead_del_stat ON public.leads USING btree (last_name, status, deleted, first_name);


--
-- TOC entry 4466 (class 1259 OID 24939)
-- Name: idx_24177_idx_lead_last_first; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24177_idx_lead_last_first ON public.leads USING btree (last_name, first_name, deleted);


--
-- TOC entry 4467 (class 1259 OID 24930)
-- Name: idx_24177_idx_lead_opp_del; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24177_idx_lead_opp_del ON public.leads USING btree (opportunity_id, deleted);


--
-- TOC entry 4468 (class 1259 OID 24933)
-- Name: idx_24177_idx_lead_phone_work; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24177_idx_lead_phone_work ON public.leads USING btree (phone_work);


--
-- TOC entry 4469 (class 1259 OID 24915)
-- Name: idx_24177_idx_leads_acct_del; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24177_idx_leads_acct_del ON public.leads USING btree (account_id, deleted);


--
-- TOC entry 4470 (class 1259 OID 24920)
-- Name: idx_24177_idx_leads_id_del; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24177_idx_leads_id_del ON public.leads USING btree (id, deleted);


--
-- TOC entry 4471 (class 1259 OID 24928)
-- Name: idx_24177_idx_reports_to; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24177_idx_reports_to ON public.leads USING btree (reports_to_id);


--
-- TOC entry 4474 (class 1259 OID 24936)
-- Name: idx_24186_idx_leads_parent_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24186_idx_leads_parent_id ON public.leads_audit USING btree (parent_id);


--
-- TOC entry 4479 (class 1259 OID 24923)
-- Name: idx_24200_idx_parent_document; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24200_idx_parent_document ON public.linked_documents USING btree (parent_type, parent_id, document_id);


--
-- TOC entry 4482 (class 1259 OID 24935)
-- Name: idx_24204_idx_meet_date_start; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24204_idx_meet_date_start ON public.meetings USING btree (date_start);


--
-- TOC entry 4483 (class 1259 OID 24929)
-- Name: idx_24204_idx_meet_par_del; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24204_idx_meet_par_del ON public.meetings USING btree (parent_id, parent_type, deleted);


--
-- TOC entry 4484 (class 1259 OID 24952)
-- Name: idx_24204_idx_meet_stat_del; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24204_idx_meet_stat_del ON public.meetings USING btree (assigned_user_id, status, deleted);


--
-- TOC entry 4485 (class 1259 OID 24942)
-- Name: idx_24204_idx_mtg_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24204_idx_mtg_name ON public.meetings USING btree (name);


--
-- TOC entry 4488 (class 1259 OID 24940)
-- Name: idx_24218_idx_con_mtg_con; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24218_idx_con_mtg_con ON public.meetings_contacts USING btree (contact_id);


--
-- TOC entry 4489 (class 1259 OID 24910)
-- Name: idx_24218_idx_con_mtg_mtg; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24218_idx_con_mtg_mtg ON public.meetings_contacts USING btree (meeting_id);


--
-- TOC entry 4490 (class 1259 OID 24951)
-- Name: idx_24218_idx_meeting_contact; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24218_idx_meeting_contact ON public.meetings_contacts USING btree (meeting_id, contact_id);


--
-- TOC entry 4495 (class 1259 OID 24937)
-- Name: idx_24232_idx_lead_meeting_lead; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24232_idx_lead_meeting_lead ON public.meetings_leads USING btree (lead_id);


--
-- TOC entry 4496 (class 1259 OID 24931)
-- Name: idx_24232_idx_lead_meeting_meeting; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24232_idx_lead_meeting_meeting ON public.meetings_leads USING btree (meeting_id);


--
-- TOC entry 4497 (class 1259 OID 24947)
-- Name: idx_24232_idx_meeting_lead; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24232_idx_meeting_lead ON public.meetings_leads USING btree (meeting_id, lead_id);


--
-- TOC entry 4500 (class 1259 OID 24962)
-- Name: idx_24238_idx_meeting_users; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24238_idx_meeting_users ON public.meetings_users USING btree (meeting_id, user_id);


--
-- TOC entry 4501 (class 1259 OID 24953)
-- Name: idx_24238_idx_usr_mtg_mtg; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24238_idx_usr_mtg_mtg ON public.meetings_users USING btree (meeting_id);


--
-- TOC entry 4502 (class 1259 OID 24960)
-- Name: idx_24238_idx_usr_mtg_usr; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24238_idx_usr_mtg_usr ON public.meetings_users USING btree (user_id);


--
-- TOC entry 4505 (class 1259 OID 24948)
-- Name: idx_24244_idx_note_contact; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24244_idx_note_contact ON public.notes USING btree (contact_id);


--
-- TOC entry 4506 (class 1259 OID 24956)
-- Name: idx_24244_idx_note_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24244_idx_note_name ON public.notes USING btree (name);


--
-- TOC entry 4507 (class 1259 OID 24922)
-- Name: idx_24244_idx_notes_assigned_del; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24244_idx_notes_assigned_del ON public.notes USING btree (deleted, assigned_user_id);


--
-- TOC entry 4508 (class 1259 OID 24964)
-- Name: idx_24244_idx_notes_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24244_idx_notes_parent ON public.notes USING btree (parent_id, parent_type);


--
-- TOC entry 4511 (class 1259 OID 24943)
-- Name: idx_24252_ckey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_24252_ckey ON public.oauth_consumer USING btree (c_key);


--
-- TOC entry 4514 (class 1259 OID 24954)
-- Name: idx_24259_oauth_nonce_keyts; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24259_oauth_nonce_keyts ON public.oauth_nonce USING btree (conskey, nonce_ts);


--
-- TOC entry 4517 (class 1259 OID 24963)
-- Name: idx_24265_constoken_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24265_constoken_key ON public.oauth_tokens USING btree (consumer);


--
-- TOC entry 4518 (class 1259 OID 24972)
-- Name: idx_24265_oauth_state_ts; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24265_oauth_state_ts ON public.oauth_tokens USING btree (tstate, token_ts);


--
-- TOC entry 4521 (class 1259 OID 24932)
-- Name: idx_24272_idx_opp_assigned; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24272_idx_opp_assigned ON public.opportunities USING btree (assigned_user_id);


--
-- TOC entry 4522 (class 1259 OID 24975)
-- Name: idx_24272_idx_opp_id_deleted; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24272_idx_opp_id_deleted ON public.opportunities USING btree (id, deleted);


--
-- TOC entry 4523 (class 1259 OID 24961)
-- Name: idx_24272_idx_opp_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24272_idx_opp_name ON public.opportunities USING btree (name);


--
-- TOC entry 4526 (class 1259 OID 24959)
-- Name: idx_24279_idx_opportunities_parent_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24279_idx_opportunities_parent_id ON public.opportunities_audit USING btree (parent_id);


--
-- TOC entry 4529 (class 1259 OID 24969)
-- Name: idx_24285_idx_con_opp_con; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24285_idx_con_opp_con ON public.opportunities_contacts USING btree (contact_id);


--
-- TOC entry 4530 (class 1259 OID 24966)
-- Name: idx_24285_idx_con_opp_opp; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24285_idx_con_opp_opp ON public.opportunities_contacts USING btree (opportunity_id);


--
-- TOC entry 4531 (class 1259 OID 24990)
-- Name: idx_24285_idx_opportunities_contacts; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24285_idx_opportunities_contacts ON public.opportunities_contacts USING btree (opportunity_id, contact_id);


--
-- TOC entry 4538 (class 1259 OID 24945)
-- Name: idx_24310_idx_outbound_email_parent_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24310_idx_outbound_email_parent_id ON public.outbound_email_audit USING btree (parent_id);


--
-- TOC entry 4543 (class 1259 OID 24979)
-- Name: idx_24324_idx_proj_acct_acct; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24324_idx_proj_acct_acct ON public.projects_accounts USING btree (account_id);


--
-- TOC entry 4544 (class 1259 OID 24971)
-- Name: idx_24324_idx_proj_acct_proj; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24324_idx_proj_acct_proj ON public.projects_accounts USING btree (project_id);


--
-- TOC entry 4547 (class 1259 OID 24982)
-- Name: idx_24324_projects_accounts_alt; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24324_projects_accounts_alt ON public.projects_accounts USING btree (project_id, account_id);


--
-- TOC entry 4548 (class 1259 OID 24978)
-- Name: idx_24328_idx_proj_bug_bug; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24328_idx_proj_bug_bug ON public.projects_bugs USING btree (bug_id);


--
-- TOC entry 4549 (class 1259 OID 24998)
-- Name: idx_24328_idx_proj_bug_proj; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24328_idx_proj_bug_proj ON public.projects_bugs USING btree (project_id);


--
-- TOC entry 4552 (class 1259 OID 24995)
-- Name: idx_24328_projects_bugs_alt; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24328_projects_bugs_alt ON public.projects_bugs USING btree (project_id, bug_id);


--
-- TOC entry 4553 (class 1259 OID 24989)
-- Name: idx_24332_idx_proj_case_case; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24332_idx_proj_case_case ON public.projects_cases USING btree (case_id);


--
-- TOC entry 4554 (class 1259 OID 24957)
-- Name: idx_24332_idx_proj_case_proj; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24332_idx_proj_case_proj ON public.projects_cases USING btree (project_id);


--
-- TOC entry 4557 (class 1259 OID 24984)
-- Name: idx_24332_projects_cases_alt; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24332_projects_cases_alt ON public.projects_cases USING btree (project_id, case_id);


--
-- TOC entry 4558 (class 1259 OID 24992)
-- Name: idx_24336_idx_proj_con_con; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24336_idx_proj_con_con ON public.projects_contacts USING btree (contact_id);


--
-- TOC entry 4559 (class 1259 OID 24985)
-- Name: idx_24336_idx_proj_con_proj; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24336_idx_proj_con_proj ON public.projects_contacts USING btree (project_id);


--
-- TOC entry 4562 (class 1259 OID 24994)
-- Name: idx_24336_projects_contacts_alt; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24336_projects_contacts_alt ON public.projects_contacts USING btree (project_id, contact_id);


--
-- TOC entry 4563 (class 1259 OID 24988)
-- Name: idx_24340_idx_proj_opp_opp; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24340_idx_proj_opp_opp ON public.projects_opportunities USING btree (opportunity_id);


--
-- TOC entry 4564 (class 1259 OID 25013)
-- Name: idx_24340_idx_proj_opp_proj; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24340_idx_proj_opp_proj ON public.projects_opportunities USING btree (project_id);


--
-- TOC entry 4567 (class 1259 OID 25006)
-- Name: idx_24340_projects_opportunities_alt; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24340_projects_opportunities_alt ON public.projects_opportunities USING btree (project_id, opportunity_id);


--
-- TOC entry 4568 (class 1259 OID 25002)
-- Name: idx_24344_idx_proj_prod_product; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24344_idx_proj_prod_product ON public.projects_products USING btree (product_id);


--
-- TOC entry 4569 (class 1259 OID 24970)
-- Name: idx_24344_idx_proj_prod_project; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24344_idx_proj_prod_project ON public.projects_products USING btree (project_id);


--
-- TOC entry 4572 (class 1259 OID 24996)
-- Name: idx_24344_projects_products_alt; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24344_projects_products_alt ON public.projects_products USING btree (project_id, product_id);


--
-- TOC entry 4575 (class 1259 OID 24997)
-- Name: idx_24348_project_contacts_1_alt; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24348_project_contacts_1_alt ON public.project_contacts_1_c USING btree (project_contacts_1project_ida, project_contacts_1contacts_idb);


--
-- TOC entry 4580 (class 1259 OID 25000)
-- Name: idx_24369_idx_project_task_parent_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24369_idx_project_task_parent_id ON public.project_task_audit USING btree (parent_id);


--
-- TOC entry 4585 (class 1259 OID 25019)
-- Name: idx_24375_project_users_1_alt; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24375_project_users_1_alt ON public.project_users_1_c USING btree (project_users_1project_ida, project_users_1users_idb);


--
-- TOC entry 4586 (class 1259 OID 25008)
-- Name: idx_24381_idx_prospecs_del_last; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24381_idx_prospecs_del_last ON public.prospects USING btree (last_name, deleted);


--
-- TOC entry 4587 (class 1259 OID 24981)
-- Name: idx_24381_idx_prospects_assigned; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24381_idx_prospects_assigned ON public.prospects USING btree (assigned_user_id);


--
-- TOC entry 4588 (class 1259 OID 25027)
-- Name: idx_24381_idx_prospects_id_del; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24381_idx_prospects_id_del ON public.prospects USING btree (id, deleted);


--
-- TOC entry 4589 (class 1259 OID 25009)
-- Name: idx_24381_idx_prospects_last_first; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24381_idx_prospects_last_first ON public.prospects USING btree (last_name, first_name, deleted);


--
-- TOC entry 4592 (class 1259 OID 25010)
-- Name: idx_24381_prospect_auto_tracker_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24381_prospect_auto_tracker_key ON public.prospects USING btree (tracker_key);


--
-- TOC entry 4595 (class 1259 OID 25018)
-- Name: idx_24398_idx_prospect_list_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24398_idx_prospect_list_name ON public.prospect_lists USING btree (name);


--
-- TOC entry 4598 (class 1259 OID 25035)
-- Name: idx_24404_idx_plp_pro_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24404_idx_plp_pro_id ON public.prospect_lists_prospects USING btree (prospect_list_id);


--
-- TOC entry 4599 (class 1259 OID 25025)
-- Name: idx_24404_idx_plp_rel_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24404_idx_plp_rel_id ON public.prospect_lists_prospects USING btree (related_id, related_type, prospect_list_id);


--
-- TOC entry 4602 (class 1259 OID 25022)
-- Name: idx_24408_idx_cam_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24408_idx_cam_id ON public.prospect_list_campaigns USING btree (campaign_id);


--
-- TOC entry 4603 (class 1259 OID 25038)
-- Name: idx_24408_idx_pro_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24408_idx_pro_id ON public.prospect_list_campaigns USING btree (prospect_list_id);


--
-- TOC entry 4604 (class 1259 OID 24993)
-- Name: idx_24408_idx_prospect_list_campaigns; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24408_idx_prospect_list_campaigns ON public.prospect_list_campaigns USING btree (prospect_list_id, campaign_id);


--
-- TOC entry 4607 (class 1259 OID 25028)
-- Name: idx_24412_idx_rel_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24412_idx_rel_name ON public.relationships USING btree (relationship_name);


--
-- TOC entry 4610 (class 1259 OID 25012)
-- Name: idx_24420_idx_releases; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24420_idx_releases ON public.releases USING btree (name, deleted);


--
-- TOC entry 4613 (class 1259 OID 25024)
-- Name: idx_24423_idx_reminder_deleted; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24423_idx_reminder_deleted ON public.reminders USING btree (deleted);


--
-- TOC entry 4614 (class 1259 OID 25047)
-- Name: idx_24423_idx_reminder_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24423_idx_reminder_name ON public.reminders USING btree (name);


--
-- TOC entry 4615 (class 1259 OID 25039)
-- Name: idx_24423_idx_reminder_related_event_module; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24423_idx_reminder_related_event_module ON public.reminders USING btree (related_event_module);


--
-- TOC entry 4616 (class 1259 OID 25045)
-- Name: idx_24423_idx_reminder_related_event_module_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24423_idx_reminder_related_event_module_id ON public.reminders USING btree (related_event_module_id);


--
-- TOC entry 4619 (class 1259 OID 25003)
-- Name: idx_24430_idx_reminder_invitee_assigned_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24430_idx_reminder_invitee_assigned_user_id ON public.reminders_invitees USING btree (assigned_user_id);


--
-- TOC entry 4620 (class 1259 OID 25050)
-- Name: idx_24430_idx_reminder_invitee_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24430_idx_reminder_invitee_name ON public.reminders_invitees USING btree (name);


--
-- TOC entry 4621 (class 1259 OID 25031)
-- Name: idx_24430_idx_reminder_invitee_related_invitee_module; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24430_idx_reminder_invitee_related_invitee_module ON public.reminders_invitees USING btree (related_invitee_module);


--
-- TOC entry 4622 (class 1259 OID 25040)
-- Name: idx_24430_idx_reminder_invitee_related_invitee_module_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24430_idx_reminder_invitee_related_invitee_module_id ON public.reminders_invitees USING btree (related_invitee_module_id);


--
-- TOC entry 4623 (class 1259 OID 25034)
-- Name: idx_24430_idx_reminder_invitee_reminder_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24430_idx_reminder_invitee_reminder_id ON public.reminders_invitees USING btree (reminder_id);


--
-- TOC entry 4626 (class 1259 OID 25043)
-- Name: idx_24437_idx_role_id_del; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24437_idx_role_id_del ON public.roles USING btree (id, deleted);


--
-- TOC entry 4629 (class 1259 OID 25063)
-- Name: idx_24443_idx_module_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24443_idx_module_id ON public.roles_modules USING btree (module_id);


--
-- TOC entry 4630 (class 1259 OID 25049)
-- Name: idx_24443_idx_role_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24443_idx_role_id ON public.roles_modules USING btree (role_id);


--
-- TOC entry 4633 (class 1259 OID 25046)
-- Name: idx_24448_idx_ru_role_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24448_idx_ru_role_id ON public.roles_users USING btree (role_id);


--
-- TOC entry 4634 (class 1259 OID 25017)
-- Name: idx_24448_idx_ru_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24448_idx_ru_user_id ON public.roles_users USING btree (user_id);


--
-- TOC entry 4637 (class 1259 OID 25044)
-- Name: idx_24452_idx_desc; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24452_idx_desc ON public.saved_search USING btree (name, deleted);


--
-- TOC entry 4640 (class 1259 OID 25042)
-- Name: idx_24458_idx_schedule; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24458_idx_schedule ON public.schedulers USING btree (date_time_start, deleted);


--
-- TOC entry 4647 (class 1259 OID 25075)
-- Name: idx_24477_idx_securitygroups_parent_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24477_idx_securitygroups_parent_id ON public.securitygroups_audit USING btree (parent_id);


--
-- TOC entry 4652 (class 1259 OID 25058)
-- Name: idx_24487_idx_securitygroups_records_del; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24487_idx_securitygroups_records_del ON public.securitygroups_records USING btree (deleted, record_id, module, securitygroup_id);


--
-- TOC entry 4653 (class 1259 OID 25029)
-- Name: idx_24487_idx_securitygroups_records_mod; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24487_idx_securitygroups_records_mod ON public.securitygroups_records USING btree (module, deleted, record_id, securitygroup_id);


--
-- TOC entry 4658 (class 1259 OID 25067)
-- Name: idx_24491_securitygroups_users_idxa; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24491_securitygroups_users_idxa ON public.securitygroups_users USING btree (securitygroup_id);


--
-- TOC entry 4659 (class 1259 OID 25057)
-- Name: idx_24491_securitygroups_users_idxb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24491_securitygroups_users_idxb ON public.securitygroups_users USING btree (user_id);


--
-- TOC entry 4660 (class 1259 OID 25051)
-- Name: idx_24491_securitygroups_users_idxc; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24491_securitygroups_users_idxc ON public.securitygroups_users USING btree (user_id, deleted, securitygroup_id, id);


--
-- TOC entry 4661 (class 1259 OID 25064)
-- Name: idx_24491_securitygroups_users_idxd; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24491_securitygroups_users_idxd ON public.securitygroups_users USING btree (user_id, deleted, securitygroup_id);


--
-- TOC entry 4666 (class 1259 OID 25074)
-- Name: idx_24503_sgrfeed_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24503_sgrfeed_date ON public.sugarfeed USING btree (date_entered, deleted);


--
-- TOC entry 4667 (class 1259 OID 25079)
-- Name: idx_24510_idx_task_assigned; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24510_idx_task_assigned ON public.tasks USING btree (assigned_user_id);


--
-- TOC entry 4668 (class 1259 OID 25070)
-- Name: idx_24510_idx_task_con_del; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24510_idx_task_con_del ON public.tasks USING btree (contact_id, deleted);


--
-- TOC entry 4669 (class 1259 OID 25041)
-- Name: idx_24510_idx_task_par_del; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24510_idx_task_par_del ON public.tasks USING btree (parent_id, parent_type, deleted);


--
-- TOC entry 4670 (class 1259 OID 25080)
-- Name: idx_24510_idx_task_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24510_idx_task_status ON public.tasks USING btree (status);


--
-- TOC entry 4671 (class 1259 OID 25068)
-- Name: idx_24510_idx_tsk_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24510_idx_tsk_name ON public.tasks USING btree (name);


--
-- TOC entry 4676 (class 1259 OID 25061)
-- Name: idx_24529_idx_tracker_date_modified; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24529_idx_tracker_date_modified ON public.tracker USING btree (date_modified);


--
-- TOC entry 4677 (class 1259 OID 25078)
-- Name: idx_24529_idx_tracker_iid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24529_idx_tracker_iid ON public.tracker USING btree (item_id);


--
-- TOC entry 4678 (class 1259 OID 25072)
-- Name: idx_24529_idx_tracker_monitor_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24529_idx_tracker_monitor_id ON public.tracker USING btree (monitor_id);


--
-- TOC entry 4679 (class 1259 OID 25095)
-- Name: idx_24529_idx_tracker_userid_itemid_vis; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24529_idx_tracker_userid_itemid_vis ON public.tracker USING btree (user_id, item_id, visible);


--
-- TOC entry 4680 (class 1259 OID 25087)
-- Name: idx_24529_idx_tracker_userid_vis_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24529_idx_tracker_userid_vis_id ON public.tracker USING btree (user_id, visible, id);


--
-- TOC entry 4685 (class 1259 OID 25053)
-- Name: idx_24538_upgrade_history_md5_uk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_24538_upgrade_history_md5_uk ON public.upgrade_history USING btree (md5sum);


--
-- TOC entry 4686 (class 1259 OID 25089)
-- Name: idx_24545_idx_user_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24545_idx_user_name ON public.users USING btree (user_name, is_group, status, last_name, first_name, id);


--
-- TOC entry 4689 (class 1259 OID 25085)
-- Name: idx_24557_idx_ud_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24557_idx_ud_user_id ON public.users_feeds USING btree (user_id, feed_id);


--
-- TOC entry 4690 (class 1259 OID 25083)
-- Name: idx_24561_idx_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24561_idx_user_id ON public.users_last_import USING btree (assigned_user_id);


--
-- TOC entry 4693 (class 1259 OID 25091)
-- Name: idx_24564_idx_username; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24564_idx_username ON public.users_password_link USING btree (username);


--
-- TOC entry 4696 (class 1259 OID 25094)
-- Name: idx_24567_idx_usersig_uid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24567_idx_usersig_uid ON public.users_signatures USING btree (user_id);


--
-- TOC entry 4699 (class 1259 OID 25090)
-- Name: idx_24573_idx_userprefnamecat; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24573_idx_userprefnamecat ON public.user_preferences USING btree (assigned_user_id, category);


--
-- TOC entry 4702 (class 1259 OID 25066)
-- Name: idx_24580_idx_vcal; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_24580_idx_vcal ON public.vcals USING btree (type, user_id);


-- Completed on 2018-06-02 15:54:03 UTC

--
-- PostgreSQL database dump complete
--

