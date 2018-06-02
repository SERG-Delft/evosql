--
-- PostgreSQL database dump
--

-- Dumped from database version 10.4 (Debian 10.4-2.pgdg90+1)
-- Dumped by pg_dump version 10.3

-- Started on 2018-06-02 15:52:49 UTC

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
-- TOC entry 8357 (class 1262 OID 16384)
-- Name: erpnext; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE erpnext WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';


ALTER DATABASE erpnext OWNER TO postgres;

\connect erpnext

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
-- TOC entry 8359 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 559 (class 1259 OID 20527)
-- Name: __auth; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.__auth (
    doctype character varying(140) NOT NULL,
    name character varying(255) NOT NULL,
    fieldname character varying(140) NOT NULL,
    password character varying(255) NOT NULL,
    salt character varying(140),
    encrypted integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.__auth OWNER TO postgres;

--
-- TOC entry 560 (class 1259 OID 20534)
-- Name: __listsettings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.__listsettings (
    "user" character varying(180) NOT NULL,
    doctype character varying(180) NOT NULL,
    data text
);


ALTER TABLE public.__listsettings OWNER TO postgres;

--
-- TOC entry 198 (class 1259 OID 16385)
-- Name: tabAbout Us Team Member; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabAbout Us Team Member" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    image_link text,
    bio text,
    full_name character varying(140)
);


ALTER TABLE public."tabAbout Us Team Member" OWNER TO postgres;

--
-- TOC entry 199 (class 1259 OID 16393)
-- Name: tabAcademic Term; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabAcademic Term" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    academic_year character varying(140),
    _liked_by text,
    term_name character varying(140),
    title character varying(140),
    term_start_date date,
    _assign text,
    term_end_date date,
    _comments text,
    _user_tags text
);


ALTER TABLE public."tabAcademic Term" OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 16401)
-- Name: tabAcademic Year; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabAcademic Year" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    year_end_date date,
    _liked_by text,
    year_start_date date,
    _user_tags text,
    _assign text,
    academic_year_name character varying(140),
    _comments text
);


ALTER TABLE public."tabAcademic Year" OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 16421)
-- Name: tabActivity Cost; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabActivity Cost" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    _assign text,
    title character varying(140),
    _comments text,
    billing_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    costing_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    employee_name character varying(140),
    employee character varying(140),
    _user_tags text,
    _liked_by text,
    activity_type character varying(140)
);


ALTER TABLE public."tabActivity Cost" OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 16431)
-- Name: tabActivity Type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabActivity Type" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    _liked_by text,
    _user_tags text,
    _assign text,
    billing_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    costing_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    _comments text,
    activity_type character varying(140)
);


ALTER TABLE public."tabActivity Type" OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 16452)
-- Name: tabAddress Template; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabAddress Template" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    _liked_by text,
    country character varying(140),
    _assign text,
    is_default integer DEFAULT 0 NOT NULL,
    _comments text,
    template text,
    _user_tags text
);


ALTER TABLE public."tabAddress Template" OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 16479)
-- Name: tabAppraisal Goal; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabAppraisal Goal" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    score_earned numeric(18,6) DEFAULT 0.000000 NOT NULL,
    score numeric(18,6) DEFAULT 0.000000 NOT NULL,
    kra text,
    per_weightage numeric(18,6) DEFAULT 0.000000 NOT NULL
);


ALTER TABLE public."tabAppraisal Goal" OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 16490)
-- Name: tabAppraisal Template; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabAppraisal Template" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    _liked_by text,
    description text,
    _user_tags text,
    kra_title character varying(140),
    _assign text,
    _comments text
);


ALTER TABLE public."tabAppraisal Template" OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 16498)
-- Name: tabAppraisal Template Goal; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabAppraisal Template Goal" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    kra text,
    per_weightage numeric(18,6) DEFAULT 0.000000 NOT NULL
);


ALTER TABLE public."tabAppraisal Template Goal" OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 16507)
-- Name: tabAssessment Evaluation Criteria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabAssessment Evaluation Criteria" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    maximum_score numeric(18,6) DEFAULT 0.000000 NOT NULL,
    evaluation_criteria character varying(140)
);


ALTER TABLE public."tabAssessment Evaluation Criteria" OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 16516)
-- Name: tabAssessment Group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabAssessment Group" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    _liked_by text,
    _user_tags text,
    _assign text,
    assessment_group_code character varying(140),
    _comments text,
    assessment_group_name character varying(140)
);


ALTER TABLE public."tabAssessment Group" OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 16524)
-- Name: tabAssessment Plan; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabAssessment Plan" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    supervisor character varying(140),
    examiner character varying(140),
    course character varying(140),
    assessment_name character varying(140),
    supervisor_name character varying(140),
    maximum_assessment_score numeric(18,6) DEFAULT 0.000000 NOT NULL,
    _comments text,
    amended_from character varying(140),
    _liked_by text,
    assessment_group character varying(140),
    _assign text,
    student_group character varying(140),
    to_time time(6) without time zone,
    schedule_date date,
    _user_tags text,
    from_time time(6) without time zone,
    room character varying(140),
    student_batch character varying(140),
    grading_scale character varying(140),
    examiner_name character varying(140),
    assessment_code character varying(140)
);


ALTER TABLE public."tabAssessment Plan" OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 16533)
-- Name: tabAssessment Result; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabAssessment Result" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    _liked_by text,
    grade character varying(140),
    _comments text,
    _assign text,
    grading_scale character varying(140),
    amended_from character varying(140),
    student character varying(140),
    maximum_score numeric(18,6) DEFAULT 0.000000 NOT NULL,
    student_name character varying(140),
    assessment_plan character varying(140),
    _user_tags text,
    total_score numeric(18,6) DEFAULT 0.000000 NOT NULL
);


ALTER TABLE public."tabAssessment Result" OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16543)
-- Name: tabAssessment Result Detail; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabAssessment Result Detail" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    maximum_score numeric(18,6) DEFAULT 0.000000 NOT NULL,
    grade character varying(140),
    evaluation_criteria character varying(140),
    score numeric(18,6) DEFAULT 0.000000 NOT NULL
);


ALTER TABLE public."tabAssessment Result Detail" OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16570)
-- Name: tabAsset Category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabAsset Category" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    asset_category_name character varying(140),
    _liked_by text,
    _comments text,
    _assign text,
    total_number_of_depreciations bigint DEFAULT '0'::bigint NOT NULL,
    frequency_of_depreciation bigint DEFAULT '0'::bigint NOT NULL,
    _user_tags text,
    depreciation_method character varying(140) DEFAULT 'Straight Line'::character varying
);


ALTER TABLE public."tabAsset Category" OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16581)
-- Name: tabAsset Category Account; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabAsset Category Account" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    depreciation_expense_account character varying(140),
    accumulated_depreciation_account character varying(140),
    fixed_asset_account character varying(140),
    company_name character varying(140)
);


ALTER TABLE public."tabAsset Category Account" OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16589)
-- Name: tabAsset Movement; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabAsset Movement" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    _liked_by text,
    _comments text,
    company character varying(140),
    _assign text,
    amended_from character varying(140),
    transaction_date timestamp with time zone,
    asset character varying(140),
    target_warehouse character varying(140),
    _user_tags text,
    source_warehouse character varying(140)
);


ALTER TABLE public."tabAsset Movement" OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16606)
-- Name: tabAttendance Tool Student; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabAttendance Tool Student" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    status character varying(140),
    student_name character varying(140),
    student character varying(140)
);


ALTER TABLE public."tabAttendance Tool Student" OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16614)
-- Name: tabAuthorization Rule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabAuthorization Rule" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    to_designation character varying(140),
    system_role character varying(140),
    system_user character varying(140),
    _user_tags text,
    to_emp character varying(140),
    customer_or_item character varying(140),
    approving_user character varying(140),
    _liked_by text,
    company character varying(140),
    _assign text,
    _comments text,
    transaction character varying(140),
    master_name character varying(140),
    value numeric(18,6) DEFAULT 0.000000 NOT NULL,
    based_on character varying(140),
    approving_role character varying(140)
);


ALTER TABLE public."tabAuthorization Rule" OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16623)
-- Name: tabAuto Email Report; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabAuto Email Report" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    filters text,
    frequency character varying(140),
    day_of_week character varying(140) DEFAULT 'Monday'::character varying,
    report_type character varying(140),
    send_if_data integer DEFAULT 1 NOT NULL,
    _comments text,
    filter_meta text,
    data_modified_till bigint DEFAULT '24'::bigint NOT NULL,
    no_of_rows bigint DEFAULT '100'::bigint NOT NULL,
    _liked_by text,
    description text,
    format character varying(140),
    _assign text,
    email_to text,
    "user" character varying(140) DEFAULT 'User'::character varying,
    report character varying(140),
    _user_tags text,
    enabled integer DEFAULT 1 NOT NULL
);


ALTER TABLE public."tabAuto Email Report" OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 16729)
-- Name: tabBOM Explosion Item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabBOM Explosion Item" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    qty_consumed_per_unit numeric(18,6) DEFAULT 0.000000 NOT NULL,
    description text,
    item_name character varying(140),
    image text,
    rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    item_code character varying(140),
    qty numeric(18,6) DEFAULT 0.000000 NOT NULL,
    amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    stock_uom character varying(140)
);


ALTER TABLE public."tabBOM Explosion Item" OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 16741)
-- Name: tabBOM Item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabBOM Item" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    bom_no character varying(140),
    description text,
    rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    item_name character varying(140),
    qty_consumed_per_unit numeric(18,6) DEFAULT 0.000000 NOT NULL,
    base_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    item_code character varying(140),
    qty numeric(18,6) DEFAULT 0.000000 NOT NULL,
    amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    stock_uom character varying(140),
    scrap numeric(18,6) DEFAULT 0.000000 NOT NULL,
    base_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    image text
);


ALTER TABLE public."tabBOM Item" OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 16756)
-- Name: tabBOM Operation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabBOM Operation" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    operating_cost numeric(18,6) DEFAULT 0.000000 NOT NULL,
    workstation character varying(140),
    description text,
    operation character varying(140),
    base_hour_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    hour_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    base_operating_cost numeric(18,6) DEFAULT 5.000000 NOT NULL,
    time_in_mins numeric(18,6) DEFAULT 0.000000 NOT NULL
);


ALTER TABLE public."tabBOM Operation" OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 16769)
-- Name: tabBOM Scrap Item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabBOM Scrap Item" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    item_name character varying(140),
    qty numeric(18,6) DEFAULT 0.000000 NOT NULL,
    base_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    item_code character varying(140),
    base_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    stock_uom character varying(140)
);


ALTER TABLE public."tabBOM Scrap Item" OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16637)
-- Name: tabBank Reconciliation Detail; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabBank Reconciliation Detail" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    payment_document character varying(140),
    clearance_date date,
    cheque_date date,
    payment_entry character varying(140),
    amount character varying(140),
    posting_date date,
    cheque_number character varying(140),
    against_account character varying(140)
);


ALTER TABLE public."tabBank Reconciliation Detail" OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16672)
-- Name: tabBlock Module; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabBlock Module" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    module character varying(140)
);


ALTER TABLE public."tabBlock Module" OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 16680)
-- Name: tabBlog Category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabBlog Category" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    _liked_by text,
    title character varying(140),
    _user_tags text,
    route character varying(140),
    _assign text,
    published integer DEFAULT 0 NOT NULL,
    _comments text,
    category_name character varying(140)
);


ALTER TABLE public."tabBlog Category" OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16689)
-- Name: tabBlog Post; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabBlog Post" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    published_on date,
    _liked_by text,
    _user_tags text,
    title character varying(140),
    blogger character varying(140),
    _assign text,
    email_sent integer DEFAULT 0 NOT NULL,
    content text,
    _comments text,
    published integer DEFAULT 0 NOT NULL,
    blog_category character varying(140),
    route character varying(140),
    blog_intro text
);


ALTER TABLE public."tabBlog Post" OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 16809)
-- Name: tabBudget Account; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabBudget Account" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    account character varying(140),
    budget_amount numeric(18,6) DEFAULT 0.000000 NOT NULL
);


ALTER TABLE public."tabBudget Account" OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 16818)
-- Name: tabC-Form; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabC-Form" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    customer character varying(140),
    _assign text,
    total_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    naming_series character varying(140),
    company character varying(140),
    c_form_no character varying(140),
    amended_from character varying(140),
    state character varying(140),
    _liked_by text,
    _comments text,
    received_date date,
    total_invoiced_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    quarter character varying(140),
    _user_tags text
);


ALTER TABLE public."tabC-Form" OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 16828)
-- Name: tabC-Form Invoice Detail; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabC-Form Invoice Detail" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    territory character varying(140),
    grand_total numeric(18,6) DEFAULT 0.000000 NOT NULL,
    net_total numeric(18,6) DEFAULT 0.000000 NOT NULL,
    invoice_date date,
    invoice_no character varying(140)
);


ALTER TABLE public."tabC-Form Invoice Detail" OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 16846)
-- Name: tabCheque Print Template; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabCheque Print Template" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    date_dist_from_left_edge numeric(18,6) DEFAULT 15.000000 NOT NULL,
    _liked_by text,
    is_account_payable integer DEFAULT 1 NOT NULL,
    amt_in_word_width numeric(18,6) DEFAULT 15.000000 NOT NULL,
    amt_in_figures_from_left_edge numeric(18,6) DEFAULT 16.000000 NOT NULL,
    cheque_width numeric(18,6) DEFAULT 20.000000 NOT NULL,
    amt_in_words_from_top_edge numeric(18,6) DEFAULT 3.000000 NOT NULL,
    acc_pay_dist_from_left_edge numeric(18,6) DEFAULT 9.000000 NOT NULL,
    payer_name_from_top_edge numeric(18,6) DEFAULT 2.000000 NOT NULL,
    starting_position_from_top_edge numeric(18,6) DEFAULT 0.000000 NOT NULL,
    _comments text,
    message_to_show character varying(140) DEFAULT 'Acc. Payee'::character varying,
    date_dist_from_top_edge numeric(18,6) DEFAULT 1.000000 NOT NULL,
    signatory_from_top_edge numeric(18,6) DEFAULT 6.000000 NOT NULL,
    payer_name_from_left_edge numeric(18,6) DEFAULT 3.000000 NOT NULL,
    bank_name character varying(140),
    acc_no_dist_from_top_edge numeric(18,6) DEFAULT 5.000000 NOT NULL,
    signatory_from_left_edge numeric(18,6) DEFAULT 15.000000 NOT NULL,
    amt_in_figures_from_top_edge numeric(18,6) DEFAULT 3.500000 NOT NULL,
    acc_pay_dist_from_top_edge numeric(18,6) DEFAULT 1.000000 NOT NULL,
    amt_in_words_from_left_edge numeric(18,6) DEFAULT 4.000000 NOT NULL,
    amt_in_words_line_spacing numeric(18,6) DEFAULT 0.500000 NOT NULL,
    has_print_format integer DEFAULT 0 NOT NULL,
    _user_tags text,
    scanned_cheque text,
    cheque_height numeric(18,6) DEFAULT 9.000000 NOT NULL,
    _assign text,
    cheque_size character varying(140) DEFAULT 'Regular'::character varying,
    acc_no_dist_from_left_edge numeric(18,6) DEFAULT 4.000000 NOT NULL
);


ALTER TABLE public."tabCheque Print Template" OWNER TO postgres;

--
-- TOC entry 246 (class 1259 OID 16899)
-- Name: tabCompany History; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabCompany History" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    highlight text,
    year character varying(140)
);


ALTER TABLE public."tabCompany History" OWNER TO postgres;

--
-- TOC entry 248 (class 1259 OID 16918)
-- Name: tabCost Center; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabCost Center" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    _liked_by text,
    rgt bigint DEFAULT '0'::bigint NOT NULL,
    cost_center_name character varying(140),
    _comments text,
    company character varying(140),
    _assign text,
    is_group integer DEFAULT 0 NOT NULL,
    old_parent character varying(140),
    lft bigint DEFAULT '0'::bigint NOT NULL,
    parent_cost_center character varying(140),
    _user_tags text
);


ALTER TABLE public."tabCost Center" OWNER TO postgres;

--
-- TOC entry 251 (class 1259 OID 16945)
-- Name: tabCourse Evaluation Criteria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabCourse Evaluation Criteria" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    weightage numeric(18,6) DEFAULT 0.000000 NOT NULL,
    evaluation_criteria character varying(140)
);


ALTER TABLE public."tabCourse Evaluation Criteria" OWNER TO postgres;

--
-- TOC entry 252 (class 1259 OID 16954)
-- Name: tabCourse Schedule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabCourse Schedule" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    instructor character varying(140),
    room character varying(140),
    title character varying(140),
    naming_series character varying(140) DEFAULT 'SH'::character varying,
    student_group character varying(140),
    course character varying(140),
    _assign text,
    _liked_by text,
    _comments text,
    to_time time(6) without time zone,
    student_batch character varying(140),
    instructor_name character varying(140),
    schedule_date date,
    _user_tags text,
    from_time time(6) without time zone
);


ALTER TABLE public."tabCourse Schedule" OWNER TO postgres;

--
-- TOC entry 254 (class 1259 OID 16974)
-- Name: tabCurrency Exchange; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabCurrency Exchange" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    to_currency character varying(140),
    _liked_by text,
    _comments text,
    _assign text,
    exchange_rate numeric(21,9) DEFAULT 0.000000000 NOT NULL,
    from_currency character varying(140),
    date date,
    _user_tags text
);


ALTER TABLE public."tabCurrency Exchange" OWNER TO postgres;

--
-- TOC entry 255 (class 1259 OID 16983)
-- Name: tabCustom DocPerm; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabCustom DocPerm" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    share integer DEFAULT 1 NOT NULL,
    export integer DEFAULT 1 NOT NULL,
    cancel integer DEFAULT 0 NOT NULL,
    user_permission_doctypes text,
    "create" integer DEFAULT 1 NOT NULL,
    submit integer DEFAULT 0 NOT NULL,
    write integer DEFAULT 1 NOT NULL,
    role character varying(140),
    print integer DEFAULT 1 NOT NULL,
    import integer DEFAULT 0 NOT NULL,
    email integer DEFAULT 1 NOT NULL,
    _liked_by text,
    _user_tags text,
    apply_user_permissions integer DEFAULT 0 NOT NULL,
    read integer DEFAULT 1 NOT NULL,
    _assign text,
    _comments text,
    set_user_permissions integer DEFAULT 0 NOT NULL,
    report integer DEFAULT 1 NOT NULL,
    amend integer DEFAULT 0 NOT NULL,
    permlevel bigint DEFAULT '0'::bigint NOT NULL,
    if_owner integer DEFAULT 0 NOT NULL,
    delete integer DEFAULT 1 NOT NULL
);


ALTER TABLE public."tabCustom DocPerm" OWNER TO postgres;

--
-- TOC entry 256 (class 1259 OID 17008)
-- Name: tabCustom Field; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabCustom Field" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    collapsible integer DEFAULT 0 NOT NULL,
    print_width character varying(140),
    no_copy integer DEFAULT 0 NOT NULL,
    depends_on text,
    _liked_by text,
    in_list_view integer DEFAULT 0 NOT NULL,
    reqd integer DEFAULT 0 NOT NULL,
    ignore_xss_filter integer DEFAULT 0 NOT NULL,
    collapsible_depends_on text,
    in_filter integer DEFAULT 0 NOT NULL,
    read_only integer DEFAULT 0 NOT NULL,
    print_hide integer DEFAULT 0 NOT NULL,
    _comments text,
    ignore_user_permissions integer DEFAULT 0 NOT NULL,
    label character varying(140),
    print_hide_if_no_value integer DEFAULT 0 NOT NULL,
    width character varying(140),
    options text,
    hidden integer DEFAULT 0 NOT NULL,
    permlevel bigint DEFAULT '0'::bigint NOT NULL,
    insert_after character varying(140),
    _assign text,
    description text,
    search_index integer DEFAULT 0 NOT NULL,
    allow_on_submit integer DEFAULT 0 NOT NULL,
    "precision" character varying(140),
    dt character varying(140),
    "unique" integer DEFAULT 0 NOT NULL,
    _user_tags text,
    "default" text,
    in_standard_filter integer DEFAULT 0 NOT NULL,
    fieldname character varying(140),
    fieldtype character varying(140) DEFAULT 'Data'::character varying,
    report_hide integer DEFAULT 0 NOT NULL
);


ALTER TABLE public."tabCustom Field" OWNER TO postgres;

--
-- TOC entry 257 (class 1259 OID 17034)
-- Name: tabCustom Script; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabCustom Script" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    _liked_by text,
    script text,
    _user_tags text,
    _assign text,
    dt character varying(140),
    _comments text,
    script_type character varying(140) DEFAULT 'Client'::character varying
);


ALTER TABLE public."tabCustom Script" OWNER TO postgres;

--
-- TOC entry 259 (class 1259 OID 17057)
-- Name: tabCustomer Group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabCustomer Group" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    credit_limit numeric(18,6) DEFAULT 0.000000 NOT NULL,
    rgt bigint DEFAULT '0'::bigint NOT NULL,
    lft bigint DEFAULT '0'::bigint NOT NULL,
    _comments text,
    parent_customer_group character varying(140),
    _assign text,
    is_group integer DEFAULT 0 NOT NULL,
    old_parent character varying(140),
    credit_days_based_on character varying(140),
    default_price_list character varying(140),
    _liked_by text,
    credit_days bigint DEFAULT '0'::bigint NOT NULL,
    customer_group_name character varying(140),
    _user_tags text
);


ALTER TABLE public."tabCustomer Group" OWNER TO postgres;

--
-- TOC entry 260 (class 1259 OID 17070)
-- Name: tabCustomize Form Field; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabCustomize Form Field" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    collapsible integer DEFAULT 0 NOT NULL,
    print_width character varying(140),
    in_list_view integer DEFAULT 0 NOT NULL,
    reqd integer DEFAULT 0 NOT NULL,
    collapsible_depends_on text,
    in_filter integer DEFAULT 0 NOT NULL,
    read_only integer DEFAULT 0 NOT NULL,
    print_hide integer DEFAULT 0 NOT NULL,
    ignore_user_permissions integer DEFAULT 0 NOT NULL,
    label character varying(140),
    print_hide_if_no_value integer DEFAULT 0 NOT NULL,
    width character varying(140),
    depends_on text,
    hidden integer DEFAULT 0 NOT NULL,
    permlevel bigint DEFAULT '0'::bigint NOT NULL,
    columns bigint DEFAULT '0'::bigint NOT NULL,
    description text,
    allow_on_submit integer DEFAULT 0 NOT NULL,
    "precision" character varying(140),
    is_custom_field integer DEFAULT 0 NOT NULL,
    remember_last_selected_value integer DEFAULT 0 NOT NULL,
    "unique" integer DEFAULT 0 NOT NULL,
    "default" text,
    in_standard_filter integer DEFAULT 0 NOT NULL,
    options text,
    length bigint DEFAULT '0'::bigint NOT NULL,
    fieldname character varying(140),
    fieldtype character varying(140) DEFAULT 'Data'::character varying,
    report_hide integer DEFAULT 0 NOT NULL
);


ALTER TABLE public."tabCustomize Form Field" OWNER TO postgres;

--
-- TOC entry 261 (class 1259 OID 17097)
-- Name: tabDaily Work Summary; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabDaily Work Summary" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    status character varying(140) DEFAULT 'Open'::character varying,
    _liked_by text,
    _user_tags text,
    company character varying(140),
    _assign text,
    email_sent_to text,
    _comments text
);


ALTER TABLE public."tabDaily Work Summary" OWNER TO postgres;

--
-- TOC entry 262 (class 1259 OID 17106)
-- Name: tabDaily Work Summary Settings Company; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabDaily Work Summary Settings Company" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    company character varying(140),
    send_emails_at character varying(140) DEFAULT '17:00'::character varying
);


ALTER TABLE public."tabDaily Work Summary Settings Company" OWNER TO postgres;

--
-- TOC entry 264 (class 1259 OID 17123)
-- Name: tabDeleted Document; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabDeleted Document" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    new_name character varying(140),
    _assign text,
    _user_tags text,
    deleted_name character varying(140),
    _liked_by text,
    _comments text,
    data text,
    restored integer DEFAULT 0 NOT NULL,
    deleted_doctype character varying(140)
);


ALTER TABLE public."tabDeleted Document" OWNER TO postgres;

--
-- TOC entry 265 (class 1259 OID 17132)
-- Name: tabDelivery Note; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabDelivery Note" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    lr_date date,
    title character varying(140) DEFAULT '{customer_name}'::character varying,
    excise_page character varying(140),
    selling_price_list character varying(140),
    return_against character varying(140),
    tc_name character varying(140),
    source character varying(140),
    instructions text,
    base_in_words character varying(140),
    ignore_pricing_rule integer DEFAULT 0 NOT NULL,
    _assign text,
    base_discount_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    base_total_taxes_and_charges numeric(18,6) DEFAULT 0.000000 NOT NULL,
    discount_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    is_return integer DEFAULT 0 NOT NULL,
    select_print_heading character varying(140),
    total_taxes_and_charges numeric(18,6) DEFAULT 0.000000 NOT NULL,
    per_installed numeric(18,6) DEFAULT 0.000000 NOT NULL,
    po_date date,
    price_list_currency character varying(140),
    contact_display text,
    terms text,
    shipping_address text,
    customer_address character varying(140),
    total_commission numeric(18,6) DEFAULT 0.000000 NOT NULL,
    contact_mobile text,
    _user_tags text,
    base_net_total numeric(18,6) DEFAULT 0.000000 NOT NULL,
    language character varying(140),
    rounded_total numeric(18,6) DEFAULT 0.000000 NOT NULL,
    customer_group character varying(140),
    apply_discount_on character varying(140) DEFAULT 'Grand Total'::character varying,
    po_no character varying(140),
    contact_person character varying(140),
    print_without_amount integer DEFAULT 0 NOT NULL,
    additional_discount_percentage numeric(18,6) DEFAULT 0.000000 NOT NULL,
    campaign character varying(140),
    conversion_rate numeric(21,9) DEFAULT 0.000000000 NOT NULL,
    posting_time time(6) without time zone,
    total numeric(18,6) DEFAULT 0.000000 NOT NULL,
    customer_name character varying(140),
    commission_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    _comments text,
    base_total numeric(18,6) DEFAULT 0.000000 NOT NULL,
    territory character varying(140),
    sales_partner character varying(140),
    company character varying(140),
    contact_email character varying(140),
    customer character varying(140),
    grand_total numeric(18,6) DEFAULT 0.000000 NOT NULL,
    project character varying(140),
    posting_date date,
    shipping_address_name character varying(140),
    address_display text,
    naming_series character varying(140),
    currency character varying(140),
    letter_head character varying(140),
    installation_status character varying(140),
    shipping_rule character varying(140),
    amended_from character varying(140),
    base_grand_total numeric(18,6) DEFAULT 0.000000 NOT NULL,
    to_warehouse character varying(140),
    status character varying(140) DEFAULT 'Draft'::character varying,
    _liked_by text,
    lr_no character varying(140),
    taxes_and_charges character varying(140),
    per_billed numeric(18,6) DEFAULT 0.000000 NOT NULL,
    transporter_name character varying(140),
    in_words character varying(140),
    plc_conversion_rate numeric(21,9) DEFAULT 0.000000000 NOT NULL,
    net_total numeric(18,6) DEFAULT 0.000000 NOT NULL,
    base_rounded_total numeric(18,6) DEFAULT 0.000000 NOT NULL
);


ALTER TABLE public."tabDelivery Note" OWNER TO postgres;

--
-- TOC entry 266 (class 1259 OID 17165)
-- Name: tabDelivery Note Item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabDelivery Note Item" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    image text,
    serial_no text,
    base_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    expense_account character varying(140),
    item_tax_rate text,
    rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    installed_qty numeric(18,6) DEFAULT 0.000000 NOT NULL,
    cost_center character varying(140),
    target_warehouse character varying(140),
    actual_qty numeric(18,6) DEFAULT 0.000000 NOT NULL,
    quality_inspection character varying(140),
    page_break integer DEFAULT 0 NOT NULL,
    base_net_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    discount_percentage numeric(18,6) DEFAULT 0.000000 NOT NULL,
    item_name character varying(140),
    qty numeric(18,6) DEFAULT 0.000000 NOT NULL,
    base_net_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    against_sales_invoice character varying(140),
    net_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    stock_uom character varying(140),
    base_price_list_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    warehouse character varying(140),
    billed_amt numeric(18,6) DEFAULT 0.000000 NOT NULL,
    against_sales_order character varying(140),
    description text,
    brand character varying(140),
    barcode character varying(140),
    base_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    item_code character varying(140),
    margin_type character varying(140),
    pricing_rule character varying(140),
    price_list_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    margin_rate_or_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    actual_batch_qty numeric(18,6) DEFAULT 0.000000 NOT NULL,
    item_group character varying(140),
    so_detail character varying(140),
    amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    customer_item_code character varying(140),
    batch_no character varying(140),
    net_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    si_detail character varying(140),
    total_margin numeric(18,6) DEFAULT 0.000000 NOT NULL
);


ALTER TABLE public."tabDelivery Note Item" OWNER TO postgres;

--
-- TOC entry 268 (class 1259 OID 17200)
-- Name: tabDependent Task; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabDependent Task" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    task character varying(140)
);


ALTER TABLE public."tabDependent Task" OWNER TO postgres;

--
-- TOC entry 269 (class 1259 OID 17208)
-- Name: tabDepreciation Schedule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabDepreciation Schedule" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    journal_entry character varying(140),
    depreciation_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    schedule_date date,
    accumulated_depreciation_amount numeric(18,6) DEFAULT 0.000000 NOT NULL
);


ALTER TABLE public."tabDepreciation Schedule" OWNER TO postgres;

--
-- TOC entry 271 (class 1259 OID 17226)
-- Name: tabDesktop Icon; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabDesktop Icon" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    color character varying(140),
    app character varying(140),
    label character varying(140),
    blocked integer DEFAULT 0 NOT NULL,
    _comments text,
    custom integer DEFAULT 0 NOT NULL,
    hidden integer DEFAULT 0 NOT NULL,
    type character varying(140),
    _liked_by text,
    _assign text,
    standard integer DEFAULT 0 NOT NULL,
    link text,
    force_show integer DEFAULT 0 NOT NULL,
    _user_tags text,
    icon character varying(140),
    reverse integer DEFAULT 0 NOT NULL,
    module_name character varying(140),
    _doctype character varying(140)
);


ALTER TABLE public."tabDesktop Icon" OWNER TO postgres;

--
-- TOC entry 277 (class 1259 OID 17348)
-- Name: tabDynamic Link; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabDynamic Link" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    link_name character varying(140),
    link_doctype character varying(140)
);


ALTER TABLE public."tabDynamic Link" OWNER TO postgres;

--
-- TOC entry 278 (class 1259 OID 17356)
-- Name: tabEmail Account; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabEmail Account" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    default_outgoing integer DEFAULT 0 NOT NULL,
    domain character varying(140),
    email_id character varying(140),
    uidnext character varying(140),
    use_imap integer DEFAULT 0 NOT NULL,
    auto_reply_message text,
    use_ssl integer DEFAULT 0 NOT NULL,
    email_server character varying(140),
    uid_validity character varying(140),
    send_notification_to text,
    always_use_account_email_id_as_sender integer DEFAULT 0 NOT NULL,
    default_incoming integer DEFAULT 0 NOT NULL,
    service character varying(140),
    _comments text,
    smtp_port character varying(140),
    smtp_server character varying(140),
    no_failed bigint DEFAULT '0'::bigint NOT NULL,
    use_tls integer DEFAULT 0 NOT NULL,
    enable_incoming integer DEFAULT 0 NOT NULL,
    attachment_limit bigint DEFAULT '1'::bigint NOT NULL,
    awaiting_password integer DEFAULT 0 NOT NULL,
    login_id character varying(140),
    _liked_by text,
    enable_auto_reply integer DEFAULT 0 NOT NULL,
    _assign text,
    send_unsubscribe_message integer DEFAULT 1 NOT NULL,
    enable_outgoing integer DEFAULT 0 NOT NULL,
    add_signature integer DEFAULT 0 NOT NULL,
    password character varying(140),
    _user_tags text,
    email_account_name character varying(140),
    footer text,
    unreplied_for_mins bigint DEFAULT '30'::bigint NOT NULL,
    login_id_is_different integer DEFAULT 0 NOT NULL,
    no_remaining character varying(140),
    append_to character varying(140),
    signature text,
    notify_if_unreplied integer DEFAULT 0 NOT NULL
);


ALTER TABLE public."tabEmail Account" OWNER TO postgres;

--
-- TOC entry 279 (class 1259 OID 17381)
-- Name: tabEmail Alert; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabEmail Alert" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    enabled integer DEFAULT 1 NOT NULL,
    module character varying(140),
    days_in_advance bigint DEFAULT '0'::bigint NOT NULL,
    message text,
    event character varying(140),
    subject character varying(140),
    attach_print integer DEFAULT 0 NOT NULL,
    condition text,
    date_changed character varying(140),
    _liked_by text,
    _assign text,
    is_standard integer DEFAULT 0 NOT NULL,
    _comments text,
    document_type character varying(140),
    _user_tags text,
    method character varying(140),
    value_changed character varying(140)
);


ALTER TABLE public."tabEmail Alert" OWNER TO postgres;

--
-- TOC entry 280 (class 1259 OID 17393)
-- Name: tabEmail Alert Recipient; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabEmail Alert Recipient" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    cc text,
    email_by_document_field character varying(140),
    email_by_role character varying(140),
    condition character varying(140)
);


ALTER TABLE public."tabEmail Alert Recipient" OWNER TO postgres;

--
-- TOC entry 281 (class 1259 OID 17401)
-- Name: tabEmail Digest; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabEmail Digest" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    calendar_events integer DEFAULT 0 NOT NULL,
    _liked_by text,
    frequency character varying(140),
    pending_quotations integer DEFAULT 0 NOT NULL,
    expense_year_to_date integer DEFAULT 0 NOT NULL,
    expenses_booked integer DEFAULT 0 NOT NULL,
    new_quotations integer DEFAULT 0 NOT NULL,
    next_send character varying(140),
    purchase_order integer DEFAULT 0 NOT NULL,
    income integer DEFAULT 0 NOT NULL,
    issue integer DEFAULT 0 NOT NULL,
    income_year_to_date integer DEFAULT 0 NOT NULL,
    recipient_list text,
    invoiced_amount integer DEFAULT 0 NOT NULL,
    company character varying(140),
    bank_balance integer DEFAULT 0 NOT NULL,
    pending_sales_orders integer DEFAULT 0 NOT NULL,
    notifications integer DEFAULT 0 NOT NULL,
    _assign text,
    _comments text,
    add_quote integer DEFAULT 0 NOT NULL,
    _user_tags text,
    sales_order integer DEFAULT 0 NOT NULL,
    enabled integer DEFAULT 0 NOT NULL,
    project integer DEFAULT 0 NOT NULL,
    credit_balance integer DEFAULT 0 NOT NULL,
    todo_list integer DEFAULT 0 NOT NULL,
    pending_purchase_orders integer DEFAULT 0 NOT NULL,
    payables integer DEFAULT 0 NOT NULL
);


ALTER TABLE public."tabEmail Digest" OWNER TO postgres;

--
-- TOC entry 282 (class 1259 OID 17430)
-- Name: tabEmail Domain; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabEmail Domain" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    _assign text,
    email_id character varying(140),
    _comments text,
    smtp_port character varying(140),
    smtp_server character varying(140),
    domain_name character varying(140),
    use_tls integer DEFAULT 0 NOT NULL,
    _liked_by text,
    use_imap integer DEFAULT 0 NOT NULL,
    attachment_limit bigint DEFAULT '1'::bigint NOT NULL,
    use_ssl integer DEFAULT 0 NOT NULL,
    email_server character varying(140),
    _user_tags text,
    append_to character varying(140)
);


ALTER TABLE public."tabEmail Domain" OWNER TO postgres;

--
-- TOC entry 283 (class 1259 OID 17442)
-- Name: tabEmail Flag Queue; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabEmail Flag Queue" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    _liked_by text,
    _user_tags text,
    _assign text,
    flag character varying(140),
    comm_name character varying(140),
    action character varying(140),
    _comments text
);


ALTER TABLE public."tabEmail Flag Queue" OWNER TO postgres;

--
-- TOC entry 284 (class 1259 OID 17450)
-- Name: tabEmail Group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabEmail Group" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    _liked_by text,
    title character varying(140),
    _user_tags text,
    _assign text,
    total_subscribers bigint DEFAULT '0'::bigint NOT NULL,
    _comments text
);


ALTER TABLE public."tabEmail Group" OWNER TO postgres;

--
-- TOC entry 285 (class 1259 OID 17459)
-- Name: tabEmail Group Member; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabEmail Group Member" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    _liked_by text,
    _comments text,
    _assign text,
    unsubscribed integer DEFAULT 0 NOT NULL,
    _user_tags text,
    email character varying(140),
    email_group character varying(140)
);


ALTER TABLE public."tabEmail Group Member" OWNER TO postgres;

--
-- TOC entry 286 (class 1259 OID 17468)
-- Name: tabEmail Queue; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabEmail Queue" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    status character varying(140) DEFAULT 'Not Sent'::character varying,
    reference_doctype character varying(140),
    _liked_by text,
    sender character varying(140),
    reference_name character varying(140),
    _assign text,
    unsubscribe_param character varying(140),
    expose_recipients character varying(140),
    priority bigint DEFAULT '1'::bigint NOT NULL,
    send_after timestamp with time zone,
    _comments text,
    error text,
    communication character varying(140),
    show_as_cc character varying(140),
    message text,
    unsubscribe_method character varying(140),
    _user_tags text,
    message_id character varying(140)
);


ALTER TABLE public."tabEmail Queue" OWNER TO postgres;

--
-- TOC entry 287 (class 1259 OID 17478)
-- Name: tabEmail Queue Recipient; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabEmail Queue Recipient" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    status character varying(140) DEFAULT 'Not Sent'::character varying,
    recipient character varying(140),
    error text
);


ALTER TABLE public."tabEmail Queue Recipient" OWNER TO postgres;

--
-- TOC entry 288 (class 1259 OID 17487)
-- Name: tabEmail Unsubscribe; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabEmail Unsubscribe" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    reference_doctype character varying(140),
    _liked_by text,
    _comments text,
    _assign text,
    global_unsubscribe integer DEFAULT 0 NOT NULL,
    reference_name character varying(140),
    _user_tags text,
    email character varying(140)
);


ALTER TABLE public."tabEmail Unsubscribe" OWNER TO postgres;

--
-- TOC entry 290 (class 1259 OID 17507)
-- Name: tabEmployee Education; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabEmployee Education" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    maj_opt_subj text,
    level character varying(140),
    class_per character varying(140),
    qualification character varying(140),
    school_univ text,
    year_of_passing bigint DEFAULT '0'::bigint NOT NULL
);


ALTER TABLE public."tabEmployee Education" OWNER TO postgres;

--
-- TOC entry 291 (class 1259 OID 17516)
-- Name: tabEmployee External Work History; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabEmployee External Work History" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    salary numeric(18,6) DEFAULT 0.000000 NOT NULL,
    designation character varying(140),
    contact character varying(140),
    company_name character varying(140),
    address text,
    total_experience character varying(140)
);


ALTER TABLE public."tabEmployee External Work History" OWNER TO postgres;

--
-- TOC entry 292 (class 1259 OID 17525)
-- Name: tabEmployee Internal Work History; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabEmployee Internal Work History" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    department character varying(140),
    from_date date,
    designation character varying(140),
    branch character varying(140),
    to_date date
);


ALTER TABLE public."tabEmployee Internal Work History" OWNER TO postgres;

--
-- TOC entry 293 (class 1259 OID 17533)
-- Name: tabEmployee Leave Approver; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabEmployee Leave Approver" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    leave_approver character varying(140)
);


ALTER TABLE public."tabEmployee Leave Approver" OWNER TO postgres;

--
-- TOC entry 294 (class 1259 OID 17541)
-- Name: tabEmployment Type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabEmployment Type" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    _comments text,
    _assign text,
    _user_tags text,
    employee_type_name character varying(140),
    _liked_by text
);


ALTER TABLE public."tabEmployment Type" OWNER TO postgres;

--
-- TOC entry 295 (class 1259 OID 17549)
-- Name: tabError Log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabError Log" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    _liked_by text,
    _comments text,
    _assign text,
    error text,
    seen integer DEFAULT 0 NOT NULL,
    _user_tags text,
    method character varying(140)
);


ALTER TABLE public."tabError Log" OWNER TO postgres;

--
-- TOC entry 296 (class 1259 OID 17558)
-- Name: tabError Snapshot; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabError Snapshot" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    exception text,
    _assign text,
    pyver text,
    "timestamp" timestamp with time zone,
    evalue text,
    traceback text,
    parent_error_snapshot character varying(140),
    etype character varying(140),
    _liked_by text,
    _comments text,
    frames text,
    seen integer DEFAULT 0 NOT NULL,
    _user_tags text,
    relapses bigint DEFAULT '1'::bigint NOT NULL,
    locals text
);


ALTER TABLE public."tabError Snapshot" OWNER TO postgres;

--
-- TOC entry 297 (class 1259 OID 17568)
-- Name: tabEvaluation Criteria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabEvaluation Criteria" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    _comments text,
    _assign text,
    _user_tags text,
    evaluation_criteria character varying(140),
    _liked_by text
);


ALTER TABLE public."tabEvaluation Criteria" OWNER TO postgres;

--
-- TOC entry 299 (class 1259 OID 17594)
-- Name: tabEvent Role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabEvent Role" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    role character varying(140)
);


ALTER TABLE public."tabEvent Role" OWNER TO postgres;

--
-- TOC entry 300 (class 1259 OID 17602)
-- Name: tabExpense Claim; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabExpense Claim" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    total_claimed_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    email_id character varying(140),
    naming_series character varying(140) DEFAULT 'EXP'::character varying,
    approval_status character varying(140) DEFAULT 'Draft'::character varying,
    total_amount_reimbursed numeric(18,6) DEFAULT 0.000000 NOT NULL,
    vehicle_log character varying(140),
    _comments text,
    amended_from character varying(140),
    total_sanctioned_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    employee character varying(140),
    _liked_by text,
    company character varying(140),
    _assign text,
    employee_name character varying(140),
    exp_approver character varying(140),
    _user_tags text,
    remark text,
    task character varying(140),
    title character varying(140) DEFAULT '{employee_name}'::character varying,
    project character varying(140),
    posting_date date
);


ALTER TABLE public."tabExpense Claim" OWNER TO postgres;

--
-- TOC entry 301 (class 1259 OID 17616)
-- Name: tabExpense Claim Account; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabExpense Claim Account" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    company character varying(140),
    default_account character varying(140)
);


ALTER TABLE public."tabExpense Claim Account" OWNER TO postgres;

--
-- TOC entry 302 (class 1259 OID 17624)
-- Name: tabExpense Claim Detail; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabExpense Claim Detail" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    description text,
    claim_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    sanctioned_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    expense_type character varying(140),
    default_account character varying(140),
    expense_date date
);


ALTER TABLE public."tabExpense Claim Detail" OWNER TO postgres;

--
-- TOC entry 303 (class 1259 OID 17634)
-- Name: tabExpense Claim Type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabExpense Claim Type" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    _liked_by text,
    description text,
    _comments text,
    _assign text,
    expense_type character varying(140),
    _user_tags text
);


ALTER TABLE public."tabExpense Claim Type" OWNER TO postgres;

--
-- TOC entry 304 (class 1259 OID 17642)
-- Name: tabFee Category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabFee Category" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    _liked_by text,
    description text,
    _user_tags text,
    _assign text,
    _comments text,
    category_name character varying(140)
);


ALTER TABLE public."tabFee Category" OWNER TO postgres;

--
-- TOC entry 305 (class 1259 OID 17650)
-- Name: tabFee Component; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabFee Component" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    fees_category character varying(140)
);


ALTER TABLE public."tabFee Component" OWNER TO postgres;

--
-- TOC entry 306 (class 1259 OID 17659)
-- Name: tabFee Structure; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabFee Structure" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    _assign text,
    student_category character varying(140),
    total_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    naming_series character varying(140),
    academic_term character varying(140),
    program character varying(140),
    _comments text,
    _user_tags text,
    _liked_by text
);


ALTER TABLE public."tabFee Structure" OWNER TO postgres;

--
-- TOC entry 309 (class 1259 OID 17694)
-- Name: tabFiscal Year; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabFiscal Year" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    year_end_date date,
    _liked_by text,
    year_start_date date,
    _comments text,
    _assign text,
    disabled integer DEFAULT 0 NOT NULL,
    year character varying(140),
    _user_tags text
);


ALTER TABLE public."tabFiscal Year" OWNER TO postgres;

--
-- TOC entry 310 (class 1259 OID 17703)
-- Name: tabFiscal Year Company; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabFiscal Year Company" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    company character varying(140)
);


ALTER TABLE public."tabFiscal Year Company" OWNER TO postgres;

--
-- TOC entry 311 (class 1259 OID 17711)
-- Name: tabFooter Item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabFooter Item" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    url character varying(140),
    group_label character varying(140),
    target character varying(140),
    label character varying(140)
);


ALTER TABLE public."tabFooter Item" OWNER TO postgres;

--
-- TOC entry 312 (class 1259 OID 17719)
-- Name: tabGL Entry; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabGL Entry" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    fiscal_year character varying(140),
    voucher_no character varying(140),
    cost_center character varying(140),
    against_voucher character varying(140),
    party_type character varying(140),
    transaction_date date,
    debit numeric(18,6) DEFAULT 0.000000 NOT NULL,
    party character varying(140),
    _liked_by text,
    company character varying(140),
    _assign text,
    voucher_type character varying(140),
    _comments text,
    is_advance character varying(140),
    remarks text,
    account_currency character varying(140),
    debit_in_account_currency numeric(18,6) DEFAULT 0.000000 NOT NULL,
    _user_tags text,
    account character varying(140),
    against_voucher_type character varying(140),
    against text,
    project character varying(140),
    credit numeric(18,6) DEFAULT 0.000000 NOT NULL,
    is_opening character varying(140),
    posting_date date,
    credit_in_account_currency numeric(18,6) DEFAULT 0.000000 NOT NULL
);


ALTER TABLE public."tabGL Entry" OWNER TO postgres;

--
-- TOC entry 313 (class 1259 OID 17731)
-- Name: tabGrade Interval; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabGrade Interval" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    min_score numeric(18,6) DEFAULT 0.000000 NOT NULL,
    grade_code character varying(140),
    grade_description text
);


ALTER TABLE public."tabGrade Interval" OWNER TO postgres;

--
-- TOC entry 314 (class 1259 OID 17740)
-- Name: tabGrading Scale; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabGrading Scale" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    _liked_by text,
    description text,
    grading_scale_name character varying(140),
    _comments text,
    _assign text,
    amended_from character varying(140),
    _user_tags text
);


ALTER TABLE public."tabGrading Scale" OWNER TO postgres;

--
-- TOC entry 315 (class 1259 OID 17748)
-- Name: tabGrading Scale Interval; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabGrading Scale Interval" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    threshold numeric(18,6) DEFAULT 0.000000 NOT NULL,
    grade_code character varying(140),
    grade_description text
);


ALTER TABLE public."tabGrading Scale Interval" OWNER TO postgres;

--
-- TOC entry 316 (class 1259 OID 17757)
-- Name: tabGrading Structure; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabGrading Structure" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    _assign text,
    description text,
    _comments text,
    grading_system_name character varying(140),
    _liked_by text,
    _user_tags text
);


ALTER TABLE public."tabGrading Structure" OWNER TO postgres;

--
-- TOC entry 318 (class 1259 OID 17773)
-- Name: tabGuardian Interest; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabGuardian Interest" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    interest character varying(140)
);


ALTER TABLE public."tabGuardian Interest" OWNER TO postgres;

--
-- TOC entry 319 (class 1259 OID 17781)
-- Name: tabHelp Article; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabHelp Article" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    category character varying(140),
    _assign text,
    author character varying(140) DEFAULT 'user_fullname'::character varying,
    _comments text,
    route character varying(140),
    level character varying(140),
    content text,
    _liked_by text,
    likes bigint DEFAULT '0'::bigint NOT NULL,
    published integer DEFAULT 0 NOT NULL,
    title character varying(140),
    _user_tags text
);


ALTER TABLE public."tabHelp Article" OWNER TO postgres;

--
-- TOC entry 320 (class 1259 OID 17792)
-- Name: tabHelp Category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabHelp Category" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    _assign text,
    _comments text,
    route character varying(140),
    published integer DEFAULT 0 NOT NULL,
    help_articles bigint DEFAULT '0'::bigint NOT NULL,
    _liked_by text,
    category_description text,
    _user_tags text,
    category_name character varying(140)
);


ALTER TABLE public."tabHelp Category" OWNER TO postgres;

--
-- TOC entry 322 (class 1259 OID 17810)
-- Name: tabHoliday List; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabHoliday List" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    _liked_by text,
    holiday_list_name character varying(140),
    _comments text,
    _assign text,
    weekly_off character varying(140),
    from_date date,
    _user_tags text,
    to_date date
);


ALTER TABLE public."tabHoliday List" OWNER TO postgres;

--
-- TOC entry 323 (class 1259 OID 17818)
-- Name: tabHomepage Featured Product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabHomepage Featured Product" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    description text,
    item_name character varying(140),
    route text,
    item_code character varying(140),
    image text,
    thumbnail text
);


ALTER TABLE public."tabHomepage Featured Product" OWNER TO postgres;

--
-- TOC entry 324 (class 1259 OID 17826)
-- Name: tabIndustry Type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabIndustry Type" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    _comments text,
    industry character varying(140),
    _assign text,
    _user_tags text,
    _liked_by text
);


ALTER TABLE public."tabIndustry Type" OWNER TO postgres;

--
-- TOC entry 325 (class 1259 OID 17834)
-- Name: tabInstallation Note; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabInstallation Note" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    address_display text,
    inst_date date,
    naming_series character varying(140),
    customer_name character varying(140),
    _comments text,
    amended_from character varying(140),
    contact_display text,
    territory character varying(140),
    status character varying(140) DEFAULT 'Draft'::character varying,
    _liked_by text,
    company character varying(140),
    _assign text,
    customer_address character varying(140),
    contact_email character varying(140),
    contact_mobile text,
    remarks text,
    _user_tags text,
    customer character varying(140),
    customer_group character varying(140),
    inst_time time(6) without time zone,
    contact_person character varying(140)
);


ALTER TABLE public."tabInstallation Note" OWNER TO postgres;

--
-- TOC entry 326 (class 1259 OID 17843)
-- Name: tabInstallation Note Item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabInstallation Note Item" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    description text,
    prevdoc_docname character varying(140),
    serial_no text,
    item_code character varying(140),
    qty numeric(18,6) DEFAULT 0.000000 NOT NULL,
    prevdoc_detail_docname character varying(140),
    prevdoc_doctype character varying(140)
);


ALTER TABLE public."tabInstallation Note Item" OWNER TO postgres;

--
-- TOC entry 328 (class 1259 OID 17860)
-- Name: tabIntegration Request; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabIntegration Request" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    status character varying(140) DEFAULT 'Queued'::character varying,
    reference_doctype character varying(140),
    _assign text,
    integration_type character varying(140),
    _user_tags text,
    error text,
    _liked_by text,
    _comments text,
    integration_request_service character varying(140),
    reference_docname character varying(140),
    output text,
    data text
);


ALTER TABLE public."tabIntegration Request" OWNER TO postgres;

--
-- TOC entry 329 (class 1259 OID 17869)
-- Name: tabIntegration Service; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabIntegration Service" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    _liked_by text,
    service character varying(140),
    enabled integer DEFAULT 0 NOT NULL,
    _assign text,
    _user_tags text,
    _comments text
);


ALTER TABLE public."tabIntegration Service" OWNER TO postgres;

--
-- TOC entry 330 (class 1259 OID 17878)
-- Name: tabIntegration Service Parameter; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabIntegration Service Parameter" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    fieldname character varying(140),
    value text,
    label text
);


ALTER TABLE public."tabIntegration Service Parameter" OWNER TO postgres;

--
-- TOC entry 334 (class 1259 OID 17942)
-- Name: tabItem Attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabItem Attribute" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    _liked_by text,
    numeric_values integer DEFAULT 0 NOT NULL,
    _comments text,
    _assign text,
    to_range numeric(18,6) DEFAULT 0.000000 NOT NULL,
    attribute_name character varying(140),
    increment numeric(18,6) DEFAULT 0.000000 NOT NULL,
    from_range numeric(18,6) DEFAULT 0.000000 NOT NULL,
    _user_tags text
);


ALTER TABLE public."tabItem Attribute" OWNER TO postgres;

--
-- TOC entry 335 (class 1259 OID 17954)
-- Name: tabItem Attribute Value; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabItem Attribute Value" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    attribute_value character varying(140),
    abbr character varying(140)
);


ALTER TABLE public."tabItem Attribute Value" OWNER TO postgres;

--
-- TOC entry 336 (class 1259 OID 17962)
-- Name: tabItem Customer Detail; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabItem Customer Detail" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    ref_code character varying(140),
    customer_name character varying(140)
);


ALTER TABLE public."tabItem Customer Detail" OWNER TO postgres;

--
-- TOC entry 337 (class 1259 OID 17970)
-- Name: tabItem Group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabItem Group" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    _assign text,
    default_income_account character varying(140),
    lft bigint DEFAULT '0'::bigint NOT NULL,
    default_cost_center character varying(140),
    route character varying(140),
    is_group integer DEFAULT 0 NOT NULL,
    slideshow character varying(140),
    parent_item_group character varying(140),
    old_parent character varying(140),
    default_expense_account character varying(140),
    _liked_by text,
    _comments text,
    show_in_website integer DEFAULT 0 NOT NULL,
    rgt bigint DEFAULT '0'::bigint NOT NULL,
    _user_tags text,
    item_group_name character varying(140),
    description text
);


ALTER TABLE public."tabItem Group" OWNER TO postgres;

--
-- TOC entry 338 (class 1259 OID 17982)
-- Name: tabItem Price; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabItem Price" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    price_list_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    selling integer DEFAULT 0 NOT NULL,
    item_description text,
    item_name character varying(140),
    _assign text,
    price_list character varying(140),
    item_code character varying(140),
    currency character varying(140),
    _liked_by text,
    _comments text,
    _user_tags text,
    buying integer DEFAULT 0 NOT NULL
);


ALTER TABLE public."tabItem Price" OWNER TO postgres;

--
-- TOC entry 339 (class 1259 OID 17993)
-- Name: tabItem Quality Inspection Parameter; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabItem Quality Inspection Parameter" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    specification character varying(140),
    value character varying(140)
);


ALTER TABLE public."tabItem Quality Inspection Parameter" OWNER TO postgres;

--
-- TOC entry 340 (class 1259 OID 18001)
-- Name: tabItem Reorder; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabItem Reorder" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    warehouse character varying(140),
    warehouse_reorder_qty numeric(18,6) DEFAULT 0.000000 NOT NULL,
    warehouse_group character varying(140),
    material_request_type character varying(140),
    warehouse_reorder_level numeric(18,6) DEFAULT 0.000000 NOT NULL
);


ALTER TABLE public."tabItem Reorder" OWNER TO postgres;

--
-- TOC entry 341 (class 1259 OID 18011)
-- Name: tabItem Supplier; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabItem Supplier" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    supplier character varying(140),
    supplier_part_no character varying(140)
);


ALTER TABLE public."tabItem Supplier" OWNER TO postgres;

--
-- TOC entry 342 (class 1259 OID 18019)
-- Name: tabItem Tax; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabItem Tax" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    tax_type character varying(140),
    tax_rate numeric(18,6) DEFAULT 0.000000 NOT NULL
);


ALTER TABLE public."tabItem Tax" OWNER TO postgres;

--
-- TOC entry 343 (class 1259 OID 18028)
-- Name: tabItem Variant; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabItem Variant" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    item_attribute_value character varying(140),
    item_attribute character varying(140)
);


ALTER TABLE public."tabItem Variant" OWNER TO postgres;

--
-- TOC entry 344 (class 1259 OID 18036)
-- Name: tabItem Variant Attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabItem Variant Attribute" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    from_range numeric(18,6) DEFAULT 0.000000 NOT NULL,
    numeric_values integer DEFAULT 0 NOT NULL,
    attribute character varying(140),
    to_range numeric(18,6) DEFAULT 0.000000 NOT NULL,
    increment numeric(18,6) DEFAULT 0.000000 NOT NULL,
    attribute_value character varying(140)
);


ALTER TABLE public."tabItem Variant Attribute" OWNER TO postgres;

--
-- TOC entry 345 (class 1259 OID 18048)
-- Name: tabItem Website Specification; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabItem Website Specification" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    description text,
    label character varying(140)
);


ALTER TABLE public."tabItem Website Specification" OWNER TO postgres;

--
-- TOC entry 346 (class 1259 OID 18056)
-- Name: tabJob Applicant; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabJob Applicant" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    cover_letter text,
    status character varying(140),
    _liked_by text,
    email_id character varying(140),
    _comments text,
    _assign text,
    resume_attachment text,
    _user_tags text,
    applicant_name character varying(140),
    job_title character varying(140)
);


ALTER TABLE public."tabJob Applicant" OWNER TO postgres;

--
-- TOC entry 347 (class 1259 OID 18064)
-- Name: tabJob Opening; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabJob Opening" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    status character varying(140),
    _liked_by text,
    description text,
    _comments text,
    route character varying(140),
    _assign text,
    publish integer DEFAULT 0 NOT NULL,
    _user_tags text,
    job_title character varying(140)
);


ALTER TABLE public."tabJob Opening" OWNER TO postgres;

--
-- TOC entry 348 (class 1259 OID 18073)
-- Name: tabJournal Entry; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabJournal Entry" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    _liked_by text,
    naming_series character varying(140),
    clearance_date date,
    voucher_type character varying(140) DEFAULT 'Journal Entry'::character varying,
    total_amount_currency character varying(140),
    letter_head character varying(140),
    cheque_no character varying(140),
    bill_no character varying(140),
    difference numeric(18,6) DEFAULT 0.000000 NOT NULL,
    write_off_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    title character varying(140),
    _comments text,
    amended_from character varying(140),
    company character varying(140),
    bill_date date,
    due_date date,
    cheque_date date,
    multi_currency integer DEFAULT 0 NOT NULL,
    total_amount_in_words character varying(140),
    _assign text,
    total_credit numeric(18,6) DEFAULT 0.000000 NOT NULL,
    user_remark text,
    _user_tags text,
    pay_to_recd_from character varying(140),
    remark text,
    total_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    write_off_based_on character varying(140) DEFAULT 'Accounts Receivable'::character varying,
    select_print_heading character varying(140),
    stock_entry character varying(140),
    total_debit numeric(18,6) DEFAULT 0.000000 NOT NULL,
    is_opening character varying(140) DEFAULT 'No'::character varying,
    posting_date date
);


ALTER TABLE public."tabJournal Entry" OWNER TO postgres;

--
-- TOC entry 349 (class 1259 OID 18090)
-- Name: tabJournal Entry Account; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabJournal Entry Account" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    exchange_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    cost_center character varying(140),
    reference_type character varying(140),
    debit numeric(18,6) DEFAULT 0.000000 NOT NULL,
    party character varying(140),
    against_account text,
    account_type character varying(140),
    reference_name character varying(140),
    debit_in_account_currency numeric(18,6) DEFAULT 0.000000 NOT NULL,
    party_balance numeric(18,6) DEFAULT 0.000000 NOT NULL,
    is_advance character varying(140),
    account_currency character varying(140),
    account character varying(140),
    project character varying(140),
    credit numeric(18,6) DEFAULT 0.000000 NOT NULL,
    party_type character varying(140),
    balance numeric(18,6) DEFAULT 0.000000 NOT NULL,
    credit_in_account_currency numeric(18,6) DEFAULT 0.000000 NOT NULL
);


ALTER TABLE public."tabJournal Entry Account" OWNER TO postgres;

--
-- TOC entry 350 (class 1259 OID 18105)
-- Name: tabKanban Board; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabKanban Board" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    reference_doctype character varying(140),
    _liked_by text,
    _user_tags text,
    _assign text,
    filters text,
    kanban_board_name character varying(140),
    field_name character varying(140),
    _comments text
);


ALTER TABLE public."tabKanban Board" OWNER TO postgres;

--
-- TOC entry 351 (class 1259 OID 18113)
-- Name: tabKanban Board Column; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabKanban Board Column" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    status character varying(140) DEFAULT 'Active'::character varying,
    indicator character varying(140) DEFAULT 'darkgrey'::character varying,
    "order" text,
    column_name character varying(140)
);


ALTER TABLE public."tabKanban Board Column" OWNER TO postgres;

--
-- TOC entry 352 (class 1259 OID 18123)
-- Name: tabLanded Cost Item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabLanded Cost Item" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    description text,
    amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    item_code character varying(140),
    qty numeric(18,6) DEFAULT 0.000000 NOT NULL,
    rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    receipt_document character varying(140),
    applicable_charges numeric(18,6) DEFAULT 0.000000 NOT NULL,
    receipt_document_type character varying(140),
    purchase_receipt_item character varying(140)
);


ALTER TABLE public."tabLanded Cost Item" OWNER TO postgres;

--
-- TOC entry 353 (class 1259 OID 18135)
-- Name: tabLanded Cost Purchase Receipt; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabLanded Cost Purchase Receipt" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    grand_total numeric(18,6) DEFAULT 0.000000 NOT NULL,
    receipt_document_type character varying(140),
    supplier character varying(140),
    receipt_document character varying(140),
    posting_date date
);


ALTER TABLE public."tabLanded Cost Purchase Receipt" OWNER TO postgres;

--
-- TOC entry 354 (class 1259 OID 18144)
-- Name: tabLanded Cost Taxes and Charges; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabLanded Cost Taxes and Charges" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    description text
);


ALTER TABLE public."tabLanded Cost Taxes and Charges" OWNER TO postgres;

--
-- TOC entry 355 (class 1259 OID 18153)
-- Name: tabLanded Cost Voucher; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabLanded Cost Voucher" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    naming_series character varying(140),
    _liked_by text,
    company character varying(140),
    _assign text,
    amended_from character varying(140),
    total_taxes_and_charges numeric(18,6) DEFAULT 0.000000 NOT NULL,
    _comments text,
    distribute_charges_based_on character varying(140),
    _user_tags text
);


ALTER TABLE public."tabLanded Cost Voucher" OWNER TO postgres;

--
-- TOC entry 358 (class 1259 OID 18181)
-- Name: tabLead Source; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabLead Source" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    _liked_by text,
    source_name character varying(140),
    _comments text,
    _assign text,
    details text,
    _user_tags text
);


ALTER TABLE public."tabLead Source" OWNER TO postgres;

--
-- TOC entry 359 (class 1259 OID 18189)
-- Name: tabLeave Allocation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabLeave Allocation" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    naming_series character varying(140),
    _liked_by text,
    description text,
    new_leaves_allocated numeric(18,6) DEFAULT 0.000000 NOT NULL,
    carry_forwarded_leaves numeric(18,6) DEFAULT 0.000000 NOT NULL,
    carry_forward integer DEFAULT 0 NOT NULL,
    _assign text,
    amended_from character varying(140),
    leave_type character varying(140),
    _comments text,
    to_date date,
    employee_name character varying(140),
    employee character varying(140),
    total_leaves_allocated numeric(18,6) DEFAULT 0.000000 NOT NULL,
    from_date date,
    _user_tags text
);


ALTER TABLE public."tabLeave Allocation" OWNER TO postgres;

--
-- TOC entry 360 (class 1259 OID 18201)
-- Name: tabLeave Application; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabLeave Application" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    naming_series character varying(140),
    leave_approver character varying(140),
    letter_head character varying(140),
    to_date date,
    half_day integer DEFAULT 0 NOT NULL,
    leave_balance numeric(18,6) DEFAULT 0.000000 NOT NULL,
    _comments text,
    amended_from character varying(140),
    from_date date,
    employee character varying(140),
    status character varying(140) DEFAULT 'Open'::character varying,
    _liked_by text,
    description text,
    company character varying(140),
    _assign text,
    total_leave_days numeric(18,6) DEFAULT 0.000000 NOT NULL,
    employee_name character varying(140),
    _user_tags text,
    follow_via_email integer DEFAULT 1 NOT NULL,
    leave_approver_name character varying(140),
    leave_type character varying(140),
    posting_date date
);


ALTER TABLE public."tabLeave Application" OWNER TO postgres;

--
-- TOC entry 361 (class 1259 OID 18214)
-- Name: tabLeave Block List; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabLeave Block List" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    _liked_by text,
    applies_to_all_departments integer DEFAULT 0 NOT NULL,
    _comments text,
    _assign text,
    leave_block_list_name character varying(140),
    _user_tags text,
    company character varying(140)
);


ALTER TABLE public."tabLeave Block List" OWNER TO postgres;

--
-- TOC entry 362 (class 1259 OID 18223)
-- Name: tabLeave Block List Allow; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabLeave Block List Allow" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    allow_user character varying(140)
);


ALTER TABLE public."tabLeave Block List Allow" OWNER TO postgres;

--
-- TOC entry 363 (class 1259 OID 18231)
-- Name: tabLeave Block List Date; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabLeave Block List Date" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    block_date date,
    reason text
);


ALTER TABLE public."tabLeave Block List Date" OWNER TO postgres;

--
-- TOC entry 364 (class 1259 OID 18239)
-- Name: tabLeave Type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabLeave Type" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    is_lwp integer DEFAULT 0 NOT NULL,
    _liked_by text,
    is_carry_forward integer DEFAULT 0 NOT NULL,
    is_encash integer DEFAULT 0 NOT NULL,
    allow_negative integer DEFAULT 0 NOT NULL,
    _assign text,
    leave_type_name character varying(140),
    max_days_allowed character varying(140),
    include_holiday integer DEFAULT 0 NOT NULL,
    _comments text,
    _user_tags text
);


ALTER TABLE public."tabLeave Type" OWNER TO postgres;

--
-- TOC entry 365 (class 1259 OID 18252)
-- Name: tabLetter Head; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabLetter Head" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    is_default integer DEFAULT 0 NOT NULL,
    _liked_by text,
    footer text,
    _comments text,
    _assign text,
    letter_head_name character varying(140),
    disabled integer DEFAULT 0 NOT NULL,
    content text,
    _user_tags text
);


ALTER TABLE public."tabLetter Head" OWNER TO postgres;

--
-- TOC entry 366 (class 1259 OID 18262)
-- Name: tabMaintenance Schedule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabMaintenance Schedule" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    address_display text,
    naming_series character varying(140),
    customer_name character varying(140),
    _comments text,
    amended_from character varying(140),
    transaction_date date,
    contact_display text,
    territory character varying(140),
    status character varying(140) DEFAULT 'Draft'::character varying,
    _liked_by text,
    company character varying(140),
    _assign text,
    customer_address character varying(140),
    contact_email character varying(140),
    contact_mobile character varying(140),
    _user_tags text,
    customer character varying(140),
    customer_group character varying(140),
    contact_person character varying(140)
);


ALTER TABLE public."tabMaintenance Schedule" OWNER TO postgres;

--
-- TOC entry 367 (class 1259 OID 18271)
-- Name: tabMaintenance Schedule Detail; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabMaintenance Schedule Detail" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    item_name character varying(140),
    serial_no text,
    item_code character varying(140),
    scheduled_date date,
    sales_person character varying(140),
    actual_date date
);


ALTER TABLE public."tabMaintenance Schedule Detail" OWNER TO postgres;

--
-- TOC entry 368 (class 1259 OID 18279)
-- Name: tabMaintenance Schedule Item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabMaintenance Schedule Item" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    end_date date,
    periodicity character varying(140),
    item_name character varying(140),
    sales_order character varying(140),
    serial_no text,
    item_code character varying(140),
    no_of_visits bigint DEFAULT '0'::bigint NOT NULL,
    sales_person character varying(140),
    start_date date,
    description text
);


ALTER TABLE public."tabMaintenance Schedule Item" OWNER TO postgres;

--
-- TOC entry 369 (class 1259 OID 18288)
-- Name: tabMaintenance Visit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabMaintenance Visit" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    maintenance_type character varying(140) DEFAULT 'Unscheduled'::character varying,
    naming_series character varying(140),
    customer_name character varying(140),
    completion_status character varying(140),
    _comments text,
    amended_from character varying(140),
    contact_display text,
    territory character varying(140),
    status character varying(140) DEFAULT 'Draft'::character varying,
    customer character varying(140),
    _liked_by text,
    customer_feedback text,
    company character varying(140),
    _assign text,
    customer_address character varying(140),
    mntc_time time(6) without time zone,
    contact_email character varying(140),
    contact_mobile character varying(140),
    _user_tags text,
    mntc_date date,
    address_display text,
    customer_group character varying(140),
    contact_person character varying(140)
);


ALTER TABLE public."tabMaintenance Visit" OWNER TO postgres;

--
-- TOC entry 370 (class 1259 OID 18298)
-- Name: tabMaintenance Visit Purpose; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabMaintenance Visit Purpose" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    work_done text,
    service_person character varying(140),
    prevdoc_docname character varying(140),
    item_name character varying(140),
    serial_no text,
    item_code character varying(140),
    prevdoc_detail_docname character varying(140),
    prevdoc_doctype character varying(140),
    description text
);


ALTER TABLE public."tabMaintenance Visit Purpose" OWNER TO postgres;

--
-- TOC entry 372 (class 1259 OID 18314)
-- Name: tabMaterial Request; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabMaterial Request" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    naming_series character varying(140),
    requested_by character varying(140),
    letter_head character varying(140),
    title character varying(140) DEFAULT '{material_request_type}'::character varying,
    _comments text,
    tc_name character varying(140),
    amended_from character varying(140),
    transaction_date date,
    status character varying(140),
    _liked_by text,
    terms text,
    company character varying(140),
    _assign text,
    per_ordered numeric(18,6) DEFAULT 0.000000 NOT NULL,
    _user_tags text,
    material_request_type character varying(140),
    select_print_heading character varying(140)
);


ALTER TABLE public."tabMaterial Request" OWNER TO postgres;

--
-- TOC entry 373 (class 1259 OID 18324)
-- Name: tabMaterial Request Item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabMaterial Request Item" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    actual_qty numeric(18,6) DEFAULT 0.000000 NOT NULL,
    lead_time_date date,
    schedule_date date,
    item_name character varying(140),
    ordered_qty numeric(18,6) DEFAULT 0.000000 NOT NULL,
    warehouse character varying(140),
    image text,
    uom character varying(140),
    description text,
    brand character varying(140),
    item_code character varying(140),
    projected_qty numeric(18,6) DEFAULT 0.000000 NOT NULL,
    qty numeric(18,6) DEFAULT 0.000000 NOT NULL,
    sales_order character varying(140),
    page_break integer DEFAULT 0 NOT NULL,
    item_group character varying(140),
    min_order_qty numeric(18,6) DEFAULT 0.000000 NOT NULL,
    project character varying(140)
);


ALTER TABLE public."tabMaterial Request Item" OWNER TO postgres;

--
-- TOC entry 374 (class 1259 OID 18338)
-- Name: tabMode of Payment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabMode of Payment" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    mode_of_payment character varying(140),
    type character varying(140),
    _assign text,
    _liked_by text,
    _user_tags text,
    _comments text
);


ALTER TABLE public."tabMode of Payment" OWNER TO postgres;

--
-- TOC entry 375 (class 1259 OID 18346)
-- Name: tabMode of Payment Account; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabMode of Payment Account" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    company character varying(140),
    default_account character varying(140)
);


ALTER TABLE public."tabMode of Payment Account" OWNER TO postgres;

--
-- TOC entry 376 (class 1259 OID 18354)
-- Name: tabModule Def; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabModule Def" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    _liked_by text,
    app_name character varying(140),
    _comments text,
    _assign text,
    module_name character varying(140),
    _user_tags text
);


ALTER TABLE public."tabModule Def" OWNER TO postgres;

--
-- TOC entry 377 (class 1259 OID 18362)
-- Name: tabMonthly Distribution; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabMonthly Distribution" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    _liked_by text,
    _comments text,
    _assign text,
    fiscal_year character varying(140),
    distribution_id character varying(140),
    _user_tags text
);


ALTER TABLE public."tabMonthly Distribution" OWNER TO postgres;

--
-- TOC entry 378 (class 1259 OID 18370)
-- Name: tabMonthly Distribution Percentage; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabMonthly Distribution Percentage" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    percentage_allocation numeric(18,6) DEFAULT 0.000000 NOT NULL,
    month character varying(140)
);


ALTER TABLE public."tabMonthly Distribution Percentage" OWNER TO postgres;

--
-- TOC entry 381 (class 1259 OID 18399)
-- Name: tabNote Seen By; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabNote Seen By" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    "user" character varying(140)
);


ALTER TABLE public."tabNote Seen By" OWNER TO postgres;

--
-- TOC entry 382 (class 1259 OID 18407)
-- Name: tabOAuth Authorization Code; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabOAuth Authorization Code" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    redirect_uri_bound_to_authorization_code character varying(140),
    scopes text,
    _liked_by text,
    authorization_code text,
    _comments text,
    _assign text,
    validity character varying(140),
    client character varying(140),
    "user" character varying(140),
    expiration_time timestamp with time zone,
    _user_tags text
);


ALTER TABLE public."tabOAuth Authorization Code" OWNER TO postgres;

--
-- TOC entry 383 (class 1259 OID 18415)
-- Name: tabOAuth Bearer Token; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabOAuth Bearer Token" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    status character varying(140),
    scopes text,
    _liked_by text,
    access_token character varying(140),
    _comments text,
    _assign text,
    expires_in bigint DEFAULT '0'::bigint NOT NULL,
    client character varying(140),
    "user" character varying(140),
    expiration_time timestamp with time zone,
    _user_tags text,
    refresh_token character varying(140)
);


ALTER TABLE public."tabOAuth Bearer Token" OWNER TO postgres;

--
-- TOC entry 384 (class 1259 OID 18424)
-- Name: tabOAuth Client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabOAuth Client" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    scopes text,
    redirect_uris text,
    app_name character varying(140),
    default_redirect_uri character varying(140),
    _assign text,
    _liked_by text,
    _comments text,
    "user" character varying(140),
    client_id character varying(140),
    client_secret character varying(140),
    skip_authorization integer DEFAULT 0 NOT NULL,
    grant_type character varying(140),
    _user_tags text,
    response_type character varying(140) DEFAULT 'Code'::character varying
);


ALTER TABLE public."tabOAuth Client" OWNER TO postgres;

--
-- TOC entry 385 (class 1259 OID 18434)
-- Name: tabOffer Letter; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabOffer Letter" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    status character varying(140),
    job_applicant character varying(140),
    terms text,
    designation character varying(140),
    select_terms character varying(140),
    _comments text,
    company character varying(140),
    _assign text,
    _liked_by text,
    amended_from character varying(140),
    _user_tags text,
    applicant_name character varying(140),
    offer_date date
);


ALTER TABLE public."tabOffer Letter" OWNER TO postgres;

--
-- TOC entry 386 (class 1259 OID 18442)
-- Name: tabOffer Letter Term; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabOffer Letter Term" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    offer_term character varying(140),
    value text
);


ALTER TABLE public."tabOffer Letter Term" OWNER TO postgres;

--
-- TOC entry 387 (class 1259 OID 18450)
-- Name: tabOffer Term; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabOffer Term" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    offer_term character varying(140),
    _assign text,
    _user_tags text,
    _comments text,
    _liked_by text
);


ALTER TABLE public."tabOffer Term" OWNER TO postgres;

--
-- TOC entry 390 (class 1259 OID 18478)
-- Name: tabOpportunity Item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabOpportunity Item" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    basic_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    description text,
    item_name character varying(140),
    brand character varying(140),
    item_group character varying(140),
    item_code character varying(140),
    qty numeric(18,6) DEFAULT 0.000000 NOT NULL,
    image text,
    uom character varying(140)
);


ALTER TABLE public."tabOpportunity Item" OWNER TO postgres;

--
-- TOC entry 408 (class 1259 OID 18662)
-- Name: tabPOS Customer Group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabPOS Customer Group" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    customer_group character varying(140)
);


ALTER TABLE public."tabPOS Customer Group" OWNER TO postgres;

--
-- TOC entry 409 (class 1259 OID 18670)
-- Name: tabPOS Item Group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabPOS Item Group" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    item_group character varying(140)
);


ALTER TABLE public."tabPOS Item Group" OWNER TO postgres;

--
-- TOC entry 410 (class 1259 OID 18678)
-- Name: tabPOS Profile; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabPOS Profile" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    campaign character varying(140),
    apply_discount integer DEFAULT 0 NOT NULL,
    naming_series character varying(140),
    expense_account character varying(140),
    currency character varying(140),
    letter_head character varying(140),
    cost_center character varying(140),
    apply_discount_on character varying(140) DEFAULT 'Grand Total'::character varying,
    update_stock integer DEFAULT 1 NOT NULL,
    _comments text,
    selling_price_list character varying(140),
    tc_name character varying(140),
    allow_delete integer DEFAULT 0 NOT NULL,
    allow_user_to_edit_rate integer DEFAULT 0 NOT NULL,
    warehouse character varying(140),
    account_for_change_amount character varying(140),
    territory character varying(140),
    company character varying(140),
    write_off_account character varying(140),
    _liked_by text,
    ignore_pricing_rule integer DEFAULT 0 NOT NULL,
    write_off_cost_center character varying(140),
    taxes_and_charges character varying(140),
    _assign text,
    "user" character varying(140),
    _user_tags text,
    customer character varying(140),
    print_format character varying(140) DEFAULT 'Point of Sale'::character varying,
    income_account character varying(140),
    select_print_heading character varying(140)
);


ALTER TABLE public."tabPOS Profile" OWNER TO postgres;

--
-- TOC entry 391 (class 1259 OID 18488)
-- Name: tabPacked Item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabPacked Item" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    serial_no text,
    qty numeric(18,6) DEFAULT 0.000000 NOT NULL,
    parent_detail_docname character varying(140),
    target_warehouse character varying(140),
    actual_qty numeric(18,6) DEFAULT 0.000000 NOT NULL,
    page_break integer DEFAULT 0 NOT NULL,
    item_name character varying(140),
    warehouse character varying(140),
    uom character varying(140),
    description text,
    item_code character varying(140),
    projected_qty numeric(18,6) DEFAULT 0.000000 NOT NULL,
    parent_item character varying(140),
    batch_no character varying(140),
    prevdoc_doctype character varying(140)
);


ALTER TABLE public."tabPacked Item" OWNER TO postgres;

--
-- TOC entry 392 (class 1259 OID 18500)
-- Name: tabPacking Slip; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabPacking Slip" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    net_weight_uom character varying(140),
    from_case_no character varying(140),
    naming_series character varying(140),
    gross_weight_uom character varying(140),
    letter_head character varying(140),
    to_case_no character varying(140),
    _user_tags text,
    amended_from character varying(140),
    net_weight_pkg numeric(18,6) DEFAULT 0.000000 NOT NULL,
    _liked_by text,
    _assign text,
    _comments text,
    gross_weight_pkg numeric(18,6) DEFAULT 0.000000 NOT NULL,
    delivery_note character varying(140)
);


ALTER TABLE public."tabPacking Slip" OWNER TO postgres;

--
-- TOC entry 393 (class 1259 OID 18510)
-- Name: tabPacking Slip Item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabPacking Slip Item" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    weight_uom character varying(140),
    description text,
    item_name character varying(140),
    page_break integer DEFAULT 0 NOT NULL,
    net_weight numeric(18,6) DEFAULT 0.000000 NOT NULL,
    qty numeric(18,6) DEFAULT 0.000000 NOT NULL,
    stock_uom character varying(140),
    item_code character varying(140),
    batch_no character varying(140),
    dn_detail character varying(140)
);


ALTER TABLE public."tabPacking Slip Item" OWNER TO postgres;

--
-- TOC entry 395 (class 1259 OID 18529)
-- Name: tabPage Role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabPage Role" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    role character varying(140)
);


ALTER TABLE public."tabPage Role" OWNER TO postgres;

--
-- TOC entry 396 (class 1259 OID 18537)
-- Name: tabParty Account; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabParty Account" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    company character varying(140),
    account character varying(140)
);


ALTER TABLE public."tabParty Account" OWNER TO postgres;

--
-- TOC entry 397 (class 1259 OID 18545)
-- Name: tabPatch Log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabPatch Log" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    _comments text,
    _assign text,
    _user_tags text,
    _liked_by text,
    patch text
);


ALTER TABLE public."tabPatch Log" OWNER TO postgres;

--
-- TOC entry 398 (class 1259 OID 18553)
-- Name: tabPayment Entry; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabPayment Entry" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    naming_series character varying(140),
    clearance_date date,
    paid_to character varying(140),
    base_paid_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    reference_date date,
    letter_head character varying(140),
    _liked_by text,
    reference_no character varying(140),
    print_heading character varying(140),
    unallocated_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    allocate_payment_amount integer DEFAULT 1 NOT NULL,
    mode_of_payment character varying(140),
    target_exchange_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    title character varying(140),
    party_type character varying(140),
    total_allocated_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    amended_from character varying(140),
    base_total_allocated_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    party character varying(140),
    base_received_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    _comments text,
    source_exchange_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    company character varying(140),
    paid_from character varying(140),
    party_balance numeric(18,6) DEFAULT 0.000000 NOT NULL,
    party_name character varying(140),
    remarks text,
    _user_tags text,
    paid_to_account_currency character varying(140),
    paid_from_account_balance numeric(18,6) DEFAULT 0.000000 NOT NULL,
    paid_from_account_currency character varying(140),
    paid_to_account_balance numeric(18,6) DEFAULT 0.000000 NOT NULL,
    paid_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    _assign text,
    received_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    project character varying(140),
    payment_type character varying(140),
    difference_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    posting_date date
);


ALTER TABLE public."tabPayment Entry" OWNER TO postgres;

--
-- TOC entry 399 (class 1259 OID 18575)
-- Name: tabPayment Entry Deduction; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabPayment Entry Deduction" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    account character varying(140),
    cost_center character varying(140)
);


ALTER TABLE public."tabPayment Entry Deduction" OWNER TO postgres;

--
-- TOC entry 400 (class 1259 OID 18584)
-- Name: tabPayment Entry Reference; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabPayment Entry Reference" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    due_date date,
    total_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    reference_doctype character varying(140),
    reference_name character varying(140),
    outstanding_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    exchange_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    allocated_amount numeric(18,6) DEFAULT 0.000000 NOT NULL
);


ALTER TABLE public."tabPayment Entry Reference" OWNER TO postgres;

--
-- TOC entry 401 (class 1259 OID 18596)
-- Name: tabPayment Gateway; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabPayment Gateway" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    _comments text,
    _assign text,
    _user_tags text,
    gateway character varying(140),
    _liked_by text
);


ALTER TABLE public."tabPayment Gateway" OWNER TO postgres;

--
-- TOC entry 402 (class 1259 OID 18604)
-- Name: tabPayment Gateway Account; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabPayment Gateway Account" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    _liked_by text,
    _comments text,
    _assign text,
    is_default integer DEFAULT 0 NOT NULL,
    currency character varying(140),
    message text,
    _user_tags text,
    payment_account character varying(140),
    payment_gateway character varying(140)
);


ALTER TABLE public."tabPayment Gateway Account" OWNER TO postgres;

--
-- TOC entry 403 (class 1259 OID 18613)
-- Name: tabPayment Reconciliation Invoice; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabPayment Reconciliation Invoice" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    invoice_type character varying(140),
    invoice_date date,
    outstanding_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    invoice_number character varying(140)
);


ALTER TABLE public."tabPayment Reconciliation Invoice" OWNER TO postgres;

--
-- TOC entry 404 (class 1259 OID 18623)
-- Name: tabPayment Reconciliation Payment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabPayment Reconciliation Payment" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    remark text,
    reference_type character varying(140),
    amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    reference_row character varying(140),
    is_advance character varying(140),
    reference_name character varying(140),
    invoice_number character varying(140),
    allocated_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    posting_date date
);


ALTER TABLE public."tabPayment Reconciliation Payment" OWNER TO postgres;

--
-- TOC entry 405 (class 1259 OID 18633)
-- Name: tabPayment Request; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabPayment Request" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    payment_url text,
    naming_series character varying(140),
    currency character varying(140),
    message text,
    subject character varying(140),
    reference_doctype character varying(140),
    payment_gateway character varying(140),
    _comments text,
    amended_from character varying(140),
    status character varying(140) DEFAULT 'Draft'::character varying,
    _liked_by text,
    reference_name character varying(140),
    _assign text,
    email_to character varying(140),
    _user_tags text,
    payment_account character varying(140),
    mute_email integer DEFAULT 0 NOT NULL,
    grand_total numeric(18,6) DEFAULT 0.000000 NOT NULL,
    print_format character varying(140),
    make_sales_invoice integer DEFAULT 0 NOT NULL,
    payment_gateway_account character varying(140)
);


ALTER TABLE public."tabPayment Request" OWNER TO postgres;

--
-- TOC entry 406 (class 1259 OID 18645)
-- Name: tabPeriod Closing Voucher; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabPeriod Closing Voucher" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    _liked_by text,
    _comments text,
    company character varying(140),
    _assign text,
    fiscal_year character varying(140),
    amended_from character varying(140),
    transaction_date date,
    remarks text,
    posting_date date,
    _user_tags text,
    closing_account_head character varying(140)
);


ALTER TABLE public."tabPeriod Closing Voucher" OWNER TO postgres;

--
-- TOC entry 407 (class 1259 OID 18653)
-- Name: tabPortal Menu Item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabPortal Menu Item" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    reference_doctype character varying(140),
    target character varying(140),
    title character varying(140),
    route character varying(140),
    enabled integer DEFAULT 0 NOT NULL,
    role character varying(140)
);


ALTER TABLE public."tabPortal Menu Item" OWNER TO postgres;

--
-- TOC entry 411 (class 1259 OID 18693)
-- Name: tabPrice List; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabPrice List" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    selling integer DEFAULT 0 NOT NULL,
    _comments text,
    _assign text,
    enabled integer DEFAULT 1 NOT NULL,
    _liked_by text,
    currency character varying(140),
    price_list_name character varying(140),
    _user_tags text,
    buying integer DEFAULT 0 NOT NULL
);


ALTER TABLE public."tabPrice List" OWNER TO postgres;

--
-- TOC entry 412 (class 1259 OID 18704)
-- Name: tabPrice List Country; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabPrice List Country" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    country character varying(140)
);


ALTER TABLE public."tabPrice List Country" OWNER TO postgres;

--
-- TOC entry 413 (class 1259 OID 18712)
-- Name: tabPricing Rule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabPricing Rule" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    item_group character varying(140),
    price_or_discount character varying(140) DEFAULT 'Discount Percentage'::character varying,
    campaign character varying(140),
    margin_rate_or_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    _liked_by text,
    supplier_type character varying(140),
    priority character varying(140),
    valid_from date,
    title character varying(140),
    _comments text,
    margin_type character varying(140) DEFAULT 'Percentage'::character varying,
    supplier character varying(140),
    territory character varying(140),
    company character varying(140),
    price numeric(18,6) DEFAULT 0.000000 NOT NULL,
    sales_partner character varying(140),
    selling integer DEFAULT 0 NOT NULL,
    applicable_for character varying(140),
    brand character varying(140),
    _assign text,
    apply_on character varying(140) DEFAULT 'Item Code'::character varying,
    item_code character varying(140),
    disable integer DEFAULT 0 NOT NULL,
    for_price_list character varying(140),
    max_qty numeric(18,6) DEFAULT 0.000000 NOT NULL,
    min_qty numeric(18,6) DEFAULT 0.000000 NOT NULL,
    _user_tags text,
    buying integer DEFAULT 0 NOT NULL,
    customer character varying(140),
    valid_upto date,
    customer_group character varying(140),
    discount_percentage numeric(18,6) DEFAULT 0.000000 NOT NULL
);


ALTER TABLE public."tabPricing Rule" OWNER TO postgres;

--
-- TOC entry 414 (class 1259 OID 18731)
-- Name: tabPrint Format; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabPrint Format" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    module character varying(140),
    disabled integer DEFAULT 0 NOT NULL,
    custom_format integer DEFAULT 0 NOT NULL,
    font character varying(140) DEFAULT 'Default'::character varying,
    _comments text,
    html text,
    show_section_headings integer DEFAULT 0 NOT NULL,
    _liked_by text,
    _assign text,
    print_format_builder integer DEFAULT 0 NOT NULL,
    standard character varying(140) DEFAULT 'No'::character varying,
    _user_tags text,
    print_format_type character varying(140) DEFAULT 'Server'::character varying,
    format_data text,
    doc_type character varying(140),
    line_breaks integer DEFAULT 0 NOT NULL,
    align_labels_left integer DEFAULT 1 NOT NULL,
    css text
);


ALTER TABLE public."tabPrint Format" OWNER TO postgres;

--
-- TOC entry 415 (class 1259 OID 18748)
-- Name: tabPrint Heading; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabPrint Heading" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    _liked_by text,
    description text,
    _user_tags text,
    _assign text,
    print_heading character varying(140),
    _comments text
);


ALTER TABLE public."tabPrint Heading" OWNER TO postgres;

--
-- TOC entry 416 (class 1259 OID 18756)
-- Name: tabProduct Bundle; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabProduct Bundle" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    _liked_by text,
    new_item_code character varying(140),
    _assign text,
    _comments text,
    _user_tags text
);


ALTER TABLE public."tabProduct Bundle" OWNER TO postgres;

--
-- TOC entry 417 (class 1259 OID 18764)
-- Name: tabProduct Bundle Item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabProduct Bundle Item" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    uom character varying(140),
    description text,
    item_code character varying(140),
    qty numeric(18,6) DEFAULT 0.000000 NOT NULL
);


ALTER TABLE public."tabProduct Bundle Item" OWNER TO postgres;

--
-- TOC entry 418 (class 1259 OID 18774)
-- Name: tabProduction Order; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabProduction Order" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    additional_operating_cost numeric(18,6) DEFAULT 0.000000 NOT NULL,
    naming_series character varying(140) DEFAULT 'PRO-'::character varying,
    produced_qty numeric(18,6) DEFAULT 0.000000 NOT NULL,
    qty numeric(18,6) DEFAULT 0.000000 NOT NULL,
    fg_warehouse character varying(140),
    use_multi_level_bom integer DEFAULT 1 NOT NULL,
    project character varying(140),
    planned_end_date timestamp with time zone,
    material_transferred_for_manufacturing numeric(18,6) DEFAULT 0.000000 NOT NULL,
    actual_end_date timestamp with time zone,
    amended_from character varying(140),
    stock_uom character varying(140),
    _comments text,
    status character varying(140) DEFAULT 'Draft'::character varying,
    _liked_by text,
    planned_operating_cost numeric(18,6) DEFAULT 0.000000 NOT NULL,
    description text,
    company character varying(140),
    _assign text,
    production_item character varying(140),
    planned_start_date timestamp with time zone,
    actual_start_date timestamp with time zone,
    material_request character varying(140),
    actual_operating_cost numeric(18,6) DEFAULT 0.000000 NOT NULL,
    _user_tags text,
    source_warehouse character varying(140),
    expected_delivery_date date,
    bom_no character varying(140),
    wip_warehouse character varying(140),
    sales_order character varying(140),
    material_request_item character varying(140),
    scrap_warehouse character varying(140),
    total_operating_cost numeric(18,6) DEFAULT 0.000000 NOT NULL
);


ALTER TABLE public."tabProduction Order" OWNER TO postgres;

--
-- TOC entry 419 (class 1259 OID 18792)
-- Name: tabProduction Order Item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabProduction Order Item" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    required_qty numeric(18,6) DEFAULT 0.000000 NOT NULL,
    transferred_qty numeric(18,6) DEFAULT 0.000000 NOT NULL,
    item_code character varying(140)
);


ALTER TABLE public."tabProduction Order Item" OWNER TO postgres;

--
-- TOC entry 420 (class 1259 OID 18802)
-- Name: tabProduction Order Operation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabProduction Order Operation" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    status character varying(140) DEFAULT 'Pending'::character varying,
    actual_start_time timestamp with time zone,
    workstation character varying(140),
    completed_qty numeric(18,6) DEFAULT 0.000000 NOT NULL,
    planned_operating_cost numeric(18,6) DEFAULT 0.000000 NOT NULL,
    description text,
    hour_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    actual_end_time timestamp with time zone,
    actual_operating_cost numeric(18,6) DEFAULT 0.000000 NOT NULL,
    actual_operation_time numeric(18,6) DEFAULT 0.000000 NOT NULL,
    operation character varying(140),
    planned_end_time timestamp with time zone,
    time_in_mins numeric(18,6) DEFAULT 0.000000 NOT NULL,
    planned_start_time timestamp with time zone
);


ALTER TABLE public."tabProduction Order Operation" OWNER TO postgres;

--
-- TOC entry 421 (class 1259 OID 18817)
-- Name: tabProduction Plan Item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabProduction Plan Item" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    material_request_item character varying(140),
    bom_no character varying(140),
    description text,
    sales_order character varying(140),
    pending_qty numeric(18,6) DEFAULT 0.000000 NOT NULL,
    planned_qty numeric(18,6) DEFAULT 0.000000 NOT NULL,
    item_code character varying(140),
    planned_start_date timestamp with time zone,
    stock_uom character varying(140),
    material_request character varying(140),
    warehouse character varying(140)
);


ALTER TABLE public."tabProduction Plan Item" OWNER TO postgres;

--
-- TOC entry 422 (class 1259 OID 18827)
-- Name: tabProduction Plan Material Request; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabProduction Plan Material Request" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    material_request character varying(140),
    material_request_date date
);


ALTER TABLE public."tabProduction Plan Material Request" OWNER TO postgres;

--
-- TOC entry 423 (class 1259 OID 18835)
-- Name: tabProduction Plan Sales Order; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabProduction Plan Sales Order" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    customer character varying(140),
    grand_total numeric(18,6) DEFAULT 0.000000 NOT NULL,
    sales_order_date date,
    sales_order character varying(140)
);


ALTER TABLE public."tabProduction Plan Sales Order" OWNER TO postgres;

--
-- TOC entry 425 (class 1259 OID 18852)
-- Name: tabProgram Course; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabProgram Course" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    course character varying(140),
    required integer DEFAULT 0 NOT NULL,
    course_code character varying(140),
    academic_term character varying(140)
);


ALTER TABLE public."tabProgram Course" OWNER TO postgres;

--
-- TOC entry 426 (class 1259 OID 18861)
-- Name: tabProgram Enrollment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabProgram Enrollment" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    enrollment_date date,
    academic_year character varying(140),
    _liked_by text,
    student_category character varying(140),
    _comments text,
    image text,
    _assign text,
    amended_from character varying(140),
    program character varying(140),
    student_batch_name character varying(140),
    student character varying(140),
    student_name character varying(140),
    _user_tags text
);


ALTER TABLE public."tabProgram Enrollment" OWNER TO postgres;

--
-- TOC entry 427 (class 1259 OID 18869)
-- Name: tabProgram Enrollment Fee; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabProgram Enrollment Fee" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    due_date date,
    fee_structure character varying(140),
    amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    academic_term character varying(140)
);


ALTER TABLE public."tabProgram Enrollment Fee" OWNER TO postgres;

--
-- TOC entry 428 (class 1259 OID 18878)
-- Name: tabProgram Enrollment Tool Student; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabProgram Enrollment Tool Student" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    student_name character varying(140),
    student character varying(140),
    student_applicant character varying(140)
);


ALTER TABLE public."tabProgram Enrollment Tool Student" OWNER TO postgres;

--
-- TOC entry 429 (class 1259 OID 18886)
-- Name: tabProgram Fee; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabProgram Fee" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    due_date date,
    student_category character varying(140),
    fee_structure character varying(140),
    academic_term character varying(140),
    amount numeric(18,6) DEFAULT 0.000000 NOT NULL
);


ALTER TABLE public."tabProgram Fee" OWNER TO postgres;

--
-- TOC entry 431 (class 1259 OID 18914)
-- Name: tabProject Task; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabProject Task" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    status character varying(140) DEFAULT 'Open'::character varying,
    end_date date,
    task_id character varying(140),
    title character varying(140),
    task_weight numeric(18,6) DEFAULT 0.000000 NOT NULL,
    start_date date,
    description text
);


ALTER TABLE public."tabProject Task" OWNER TO postgres;

--
-- TOC entry 432 (class 1259 OID 18924)
-- Name: tabProject User; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabProject User" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    welcome_email_sent integer DEFAULT 0 NOT NULL,
    "user" character varying(140)
);


ALTER TABLE public."tabProject User" OWNER TO postgres;

--
-- TOC entry 433 (class 1259 OID 18933)
-- Name: tabProperty Setter; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabProperty Setter" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    default_value character varying(140),
    doc_type character varying(140),
    property character varying(140),
    _user_tags text,
    _assign text,
    value text,
    doctype_or_field character varying(140),
    _comments text,
    property_type character varying(140),
    field_name character varying(140),
    _liked_by text
);


ALTER TABLE public."tabProperty Setter" OWNER TO postgres;

--
-- TOC entry 434 (class 1259 OID 18941)
-- Name: tabPurchase Invoice; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabPurchase Invoice" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    cash_bank_account character varying(140),
    base_write_off_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    apply_discount_on character varying(140) DEFAULT 'Grand Total'::character varying,
    return_against character varying(140),
    tc_name character varying(140),
    submit_on_creation integer DEFAULT 0 NOT NULL,
    discount_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    base_in_words character varying(140),
    due_date date,
    ignore_pricing_rule integer DEFAULT 0 NOT NULL,
    write_off_cost_center character varying(140),
    _assign text,
    base_discount_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    base_total_taxes_and_charges numeric(18,6) DEFAULT 0.000000 NOT NULL,
    supplier_name character varying(140),
    taxes_and_charges_added numeric(18,6) DEFAULT 0.000000 NOT NULL,
    is_paid integer DEFAULT 0 NOT NULL,
    is_return integer DEFAULT 0 NOT NULL,
    select_print_heading character varying(140),
    total_taxes_and_charges numeric(18,6) DEFAULT 0.000000 NOT NULL,
    write_off_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    supplier_address character varying(140),
    mode_of_payment character varying(140),
    party_account_currency character varying(140),
    price_list_currency character varying(140),
    base_taxes_and_charges_added numeric(18,6) DEFAULT 0.000000 NOT NULL,
    contact_display text,
    supplier character varying(140),
    buying_price_list character varying(140),
    write_off_account character varying(140),
    next_date date,
    terms text,
    supplier_warehouse character varying(140),
    shipping_address character varying(140),
    contact_mobile text,
    _user_tags text,
    base_net_total numeric(18,6) DEFAULT 0.000000 NOT NULL,
    language character varying(140),
    title character varying(140) DEFAULT '{supplier_name}'::character varying,
    repeat_on_day_of_month bigint DEFAULT '0'::bigint NOT NULL,
    contact_person character varying(140),
    in_words character varying(140),
    recurring_print_format character varying(140),
    additional_discount_percentage numeric(18,6) DEFAULT 0.000000 NOT NULL,
    base_paid_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    conversion_rate numeric(21,9) DEFAULT 0.000000000 NOT NULL,
    to_date date,
    total_advance numeric(18,6) DEFAULT 0.000000 NOT NULL,
    posting_time time(6) without time zone,
    total numeric(18,6) DEFAULT 0.000000 NOT NULL,
    bill_no character varying(140),
    rejected_warehouse character varying(140),
    is_subcontracted character varying(140) DEFAULT 'No'::character varying,
    update_stock integer DEFAULT 0 NOT NULL,
    _comments text,
    base_total numeric(18,6) DEFAULT 0.000000 NOT NULL,
    from_date date,
    notification_email_address text,
    end_date date,
    company character varying(140),
    contact_email text,
    grand_total numeric(18,6) DEFAULT 0.000000 NOT NULL,
    notify_by_email integer DEFAULT 0 NOT NULL,
    is_recurring integer DEFAULT 0 NOT NULL,
    taxes_and_charges_deducted numeric(18,6) DEFAULT 0.000000 NOT NULL,
    is_opening character varying(140) DEFAULT 'No'::character varying,
    posting_date date,
    address_display text,
    against_expense_account text,
    naming_series character varying(140),
    currency character varying(140),
    letter_head character varying(140),
    recurring_id character varying(140),
    base_taxes_and_charges_deducted numeric(18,6) DEFAULT 0.000000 NOT NULL,
    paid_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    credit_to character varying(140),
    amended_from character varying(140),
    base_grand_total numeric(18,6) DEFAULT 0.000000 NOT NULL,
    recurring_type character varying(140),
    bill_date date,
    status character varying(140) DEFAULT 'Draft'::character varying,
    _liked_by text,
    taxes_and_charges character varying(140),
    outstanding_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    remarks text,
    shipping_address_display text,
    plc_conversion_rate numeric(21,9) DEFAULT 0.000000000 NOT NULL,
    net_total numeric(18,6) DEFAULT 0.000000 NOT NULL
);


ALTER TABLE public."tabPurchase Invoice" OWNER TO postgres;

--
-- TOC entry 435 (class 1259 OID 18985)
-- Name: tabPurchase Invoice Advance; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabPurchase Invoice Advance" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    reference_type character varying(140),
    advance_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    reference_row character varying(140),
    reference_name character varying(140),
    remarks text,
    allocated_amount numeric(18,6) DEFAULT 0.000000 NOT NULL
);


ALTER TABLE public."tabPurchase Invoice Advance" OWNER TO postgres;

--
-- TOC entry 436 (class 1259 OID 18995)
-- Name: tabPurchase Invoice Item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabPurchase Invoice Item" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    purchase_receipt character varying(140),
    po_detail character varying(140),
    image text,
    landed_cost_voucher_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    qty numeric(18,6) DEFAULT 0.000000 NOT NULL,
    item_tax_rate text,
    rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    expense_account character varying(140),
    cost_center character varying(140),
    received_qty numeric(18,6) DEFAULT 0.000000 NOT NULL,
    rm_supp_cost numeric(18,6) DEFAULT 0.000000 NOT NULL,
    item_tax_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    quality_inspection character varying(140),
    page_break integer DEFAULT 0 NOT NULL,
    base_net_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    discount_percentage numeric(18,6) DEFAULT 0.000000 NOT NULL,
    item_name character varying(140),
    base_net_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    purchase_order character varying(140),
    conversion_factor numeric(18,6) DEFAULT 0.000000 NOT NULL,
    asset character varying(140),
    pr_detail character varying(140),
    warehouse character varying(140),
    uom character varying(140),
    serial_no text,
    description text,
    brand character varying(140),
    rejected_serial_no text,
    base_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    item_code character varying(140),
    base_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    rejected_qty numeric(18,6) DEFAULT 0.000000 NOT NULL,
    base_price_list_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    rejected_warehouse character varying(140),
    pricing_rule character varying(140),
    price_list_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    item_group character varying(140),
    project character varying(140),
    amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    net_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    bom character varying(140),
    batch_no character varying(140),
    valuation_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    net_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    is_fixed_asset integer DEFAULT 0 NOT NULL
);


ALTER TABLE public."tabPurchase Invoice Item" OWNER TO postgres;

--
-- TOC entry 437 (class 1259 OID 19024)
-- Name: tabPurchase Order; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabPurchase Order" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    ref_sq character varying(140),
    title character varying(140) DEFAULT '{supplier_name}'::character varying,
    tc_name character varying(140),
    base_grand_total numeric(18,6) DEFAULT 0.000000 NOT NULL,
    submit_on_creation integer DEFAULT 0 NOT NULL,
    taxes_and_charges_added numeric(18,6) DEFAULT 0.000000 NOT NULL,
    base_in_words character varying(140),
    ignore_pricing_rule integer DEFAULT 0 NOT NULL,
    _assign text,
    base_discount_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    base_total_taxes_and_charges numeric(18,6) DEFAULT 0.000000 NOT NULL,
    supplier_name character varying(140),
    discount_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    select_print_heading character varying(140),
    customer_contact_person character varying(140),
    total_taxes_and_charges numeric(18,6) DEFAULT 0.000000 NOT NULL,
    supplier_address character varying(140),
    party_account_currency character varying(140),
    price_list_currency character varying(140),
    base_taxes_and_charges_added numeric(18,6) DEFAULT 0.000000 NOT NULL,
    customer_contact_email text,
    contact_display text,
    supplier character varying(140),
    buying_price_list character varying(140),
    next_date date,
    terms text,
    advance_paid numeric(18,6) DEFAULT 0.000000 NOT NULL,
    contact_mobile text,
    _user_tags text,
    base_net_total numeric(18,6) DEFAULT 0.000000 NOT NULL,
    language character varying(140),
    apply_discount_on character varying(140) DEFAULT 'Grand Total'::character varying,
    repeat_on_day_of_month bigint DEFAULT '0'::bigint NOT NULL,
    contact_person character varying(140),
    in_words character varying(140),
    recurring_print_format character varying(140),
    additional_discount_percentage numeric(18,6) DEFAULT 0.000000 NOT NULL,
    conversion_rate numeric(21,9) DEFAULT 0.000000000 NOT NULL,
    to_date date,
    total numeric(18,6) DEFAULT 0.000000 NOT NULL,
    customer_name character varying(140),
    is_subcontracted character varying(140) DEFAULT 'No'::character varying,
    _comments text,
    base_total numeric(18,6) DEFAULT 0.000000 NOT NULL,
    from_date date,
    notification_email_address text,
    end_date date,
    company character varying(140),
    base_rounded_total numeric(18,6) DEFAULT 0.000000 NOT NULL,
    customer character varying(140),
    grand_total numeric(18,6) DEFAULT 0.000000 NOT NULL,
    notify_by_email integer DEFAULT 0 NOT NULL,
    is_recurring integer DEFAULT 0 NOT NULL,
    taxes_and_charges_deducted numeric(18,6) DEFAULT 0.000000 NOT NULL,
    shipping_address character varying(140),
    address_display text,
    naming_series character varying(140),
    currency character varying(140),
    letter_head character varying(140),
    recurring_id character varying(140),
    base_taxes_and_charges_deducted numeric(18,6) DEFAULT 0.000000 NOT NULL,
    amended_from character varying(140),
    transaction_date date,
    recurring_type character varying(140),
    _liked_by text,
    status character varying(140) DEFAULT 'Draft'::character varying,
    group_same_items integer DEFAULT 0 NOT NULL,
    customer_contact_display text,
    taxes_and_charges character varying(140),
    per_billed numeric(18,6) DEFAULT 0.000000 NOT NULL,
    shipping_address_display text,
    customer_contact_mobile text,
    per_received numeric(18,6) DEFAULT 0.000000 NOT NULL,
    plc_conversion_rate numeric(21,9) DEFAULT 0.000000000 NOT NULL,
    net_total numeric(18,6) DEFAULT 0.000000 NOT NULL,
    contact_email text
);


ALTER TABLE public."tabPurchase Order" OWNER TO postgres;

--
-- TOC entry 438 (class 1259 OID 19063)
-- Name: tabPurchase Order Item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabPurchase Order Item" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    schedule_date date,
    stock_qty numeric(18,6) DEFAULT 0.000000 NOT NULL,
    base_price_list_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    image text,
    base_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    base_net_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    item_tax_rate text,
    rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    received_qty numeric(18,6) DEFAULT 0.000000 NOT NULL,
    stock_uom character varying(140),
    project character varying(140),
    page_break integer DEFAULT 0 NOT NULL,
    base_net_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    item_name character varying(140),
    qty numeric(18,6) DEFAULT 0.000000 NOT NULL,
    supplier_quotation character varying(140),
    supplier_quotation_item character varying(140),
    net_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    conversion_factor numeric(18,6) DEFAULT 0.000000 NOT NULL,
    warehouse character varying(140),
    billed_amt numeric(18,6) DEFAULT 0.000000 NOT NULL,
    supplier_part_no character varying(140),
    uom character varying(140),
    price_list_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    description text,
    returned_qty numeric(18,6) DEFAULT 0.000000 NOT NULL,
    net_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    brand character varying(140),
    base_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    item_code character varying(140),
    material_request character varying(140),
    pricing_rule character varying(140),
    sales_order_item character varying(140),
    expected_delivery_date date,
    sales_order character varying(140),
    item_group character varying(140),
    discount_percentage numeric(18,6) DEFAULT 0.000000 NOT NULL,
    material_request_item character varying(140),
    amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    bom character varying(140),
    delivered_by_supplier integer DEFAULT 0 NOT NULL
);


ALTER TABLE public."tabPurchase Order Item" OWNER TO postgres;

--
-- TOC entry 439 (class 1259 OID 19090)
-- Name: tabPurchase Order Item Supplied; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabPurchase Order Item Supplied" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    rm_item_code character varying(140),
    rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    reference_name character varying(140),
    bom_detail_no character varying(140),
    required_qty numeric(18,6) DEFAULT 0.000000 NOT NULL,
    main_item_code character varying(140),
    amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    conversion_factor numeric(18,6) DEFAULT 0.000000 NOT NULL,
    stock_uom character varying(140)
);


ALTER TABLE public."tabPurchase Order Item Supplied" OWNER TO postgres;

--
-- TOC entry 440 (class 1259 OID 19102)
-- Name: tabPurchase Receipt; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabPurchase Receipt" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    lr_date date,
    apply_discount_on character varying(140) DEFAULT 'Grand Total'::character varying,
    tc_name character varying(140),
    taxes_and_charges_added numeric(18,6) DEFAULT 0.000000 NOT NULL,
    base_in_words character varying(140),
    ignore_pricing_rule integer DEFAULT 0 NOT NULL,
    _assign text,
    base_discount_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    base_total_taxes_and_charges numeric(18,6) DEFAULT 0.000000 NOT NULL,
    supplier_name character varying(140),
    instructions text,
    buying_price_list character varying(140),
    discount_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    is_return integer DEFAULT 0 NOT NULL,
    select_print_heading character varying(140),
    total_taxes_and_charges numeric(18,6) DEFAULT 0.000000 NOT NULL,
    supplier_address character varying(140),
    lr_no character varying(140),
    price_list_currency character varying(140),
    base_taxes_and_charges_added numeric(18,6) DEFAULT 0.000000 NOT NULL,
    contact_display text,
    supplier character varying(140),
    terms text,
    supplier_warehouse character varying(140),
    _user_tags text,
    base_net_total numeric(18,6) DEFAULT 0.000000 NOT NULL,
    language character varying(140),
    title character varying(140) DEFAULT '{supplier_name}'::character varying,
    range character varying(140),
    contact_person character varying(140),
    in_words character varying(140),
    additional_discount_percentage numeric(18,6) DEFAULT 0.000000 NOT NULL,
    return_against character varying(140),
    contact_mobile text,
    conversion_rate numeric(21,9) DEFAULT 0.000000000 NOT NULL,
    posting_time time(6) without time zone,
    total numeric(18,6) DEFAULT 0.000000 NOT NULL,
    bill_no character varying(140),
    rejected_warehouse character varying(140),
    is_subcontracted character varying(140) DEFAULT 'No'::character varying,
    _comments text,
    base_total numeric(18,6) DEFAULT 0.000000 NOT NULL,
    company character varying(140),
    base_rounded_total numeric(18,6) DEFAULT 0.000000 NOT NULL,
    grand_total numeric(18,6) DEFAULT 0.000000 NOT NULL,
    taxes_and_charges_deducted numeric(18,6) DEFAULT 0.000000 NOT NULL,
    shipping_address character varying(140),
    posting_date date,
    address_display text,
    naming_series character varying(140),
    currency character varying(140),
    letter_head character varying(140),
    base_taxes_and_charges_deducted numeric(18,6) DEFAULT 0.000000 NOT NULL,
    amended_from character varying(140),
    base_grand_total numeric(18,6) DEFAULT 0.000000 NOT NULL,
    bill_date date,
    status character varying(140) DEFAULT 'Draft'::character varying,
    _liked_by text,
    taxes_and_charges character varying(140),
    per_billed numeric(18,6) DEFAULT 0.000000 NOT NULL,
    transporter_name character varying(140),
    remarks text,
    shipping_address_display text,
    plc_conversion_rate numeric(21,9) DEFAULT 0.000000000 NOT NULL,
    net_total numeric(18,6) DEFAULT 0.000000 NOT NULL,
    contact_email text
);


ALTER TABLE public."tabPurchase Receipt" OWNER TO postgres;

--
-- TOC entry 441 (class 1259 OID 19135)
-- Name: tabPurchase Receipt Item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabPurchase Receipt Item" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    schedule_date date,
    stock_qty numeric(18,6) DEFAULT 0.000000 NOT NULL,
    image text,
    qty numeric(18,6) DEFAULT 0.000000 NOT NULL,
    rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    cost_center character varying(140),
    received_qty numeric(18,6) DEFAULT 0.000000 NOT NULL,
    stock_uom character varying(140),
    item_tax_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    quality_inspection character varying(140),
    page_break integer DEFAULT 0 NOT NULL,
    rejected_warehouse character varying(140),
    base_net_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    item_name character varying(140),
    rejected_serial_no text,
    base_net_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    item_group character varying(140),
    net_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    conversion_factor numeric(18,6) DEFAULT 0.000000 NOT NULL,
    rm_supp_cost numeric(18,6) DEFAULT 0.000000 NOT NULL,
    base_price_list_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    warehouse character varying(140),
    billed_amt numeric(18,6) DEFAULT 0.000000 NOT NULL,
    uom character varying(140),
    serial_no text,
    description text,
    landed_cost_voucher_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    brand character varying(140),
    barcode character varying(140),
    base_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    item_code character varying(140),
    base_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    rejected_qty numeric(18,6) DEFAULT 0.000000 NOT NULL,
    pricing_rule character varying(140),
    price_list_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    item_tax_rate text,
    discount_percentage numeric(18,6) DEFAULT 0.000000 NOT NULL,
    purchase_order character varying(140),
    project character varying(140),
    amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    bom character varying(140),
    batch_no character varying(140),
    valuation_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    purchase_order_item character varying(140),
    net_amount numeric(18,6) DEFAULT 0.000000 NOT NULL
);


ALTER TABLE public."tabPurchase Receipt Item" OWNER TO postgres;

--
-- TOC entry 442 (class 1259 OID 19165)
-- Name: tabPurchase Receipt Item Supplied; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabPurchase Receipt Item Supplied" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    rm_item_code character varying(140),
    description text,
    rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    conversion_factor numeric(18,6) DEFAULT 0.000000 NOT NULL,
    reference_name character varying(140),
    serial_no text,
    amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    main_item_code character varying(140),
    required_qty numeric(18,6) DEFAULT 0.000000 NOT NULL,
    stock_uom character varying(140),
    current_stock numeric(18,6) DEFAULT 0.000000 NOT NULL,
    batch_no character varying(140),
    consumed_qty numeric(18,6) DEFAULT 0.000000 NOT NULL,
    bom_detail_no character varying(140)
);


ALTER TABLE public."tabPurchase Receipt Item Supplied" OWNER TO postgres;

--
-- TOC entry 443 (class 1259 OID 19179)
-- Name: tabPurchase Taxes and Charges; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabPurchase Taxes and Charges" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    charge_type character varying(140),
    category character varying(140) DEFAULT 'Valuation and Total'::character varying,
    total numeric(18,6) DEFAULT 0.000000 NOT NULL,
    tax_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    description text,
    item_wise_tax_detail text,
    base_tax_amount_after_discount_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    row_id character varying(140),
    base_total numeric(18,6) DEFAULT 0.000000 NOT NULL,
    add_deduct_tax character varying(140) DEFAULT 'Add'::character varying,
    included_in_print_rate integer DEFAULT 0 NOT NULL,
    rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    tax_amount_after_discount_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    cost_center character varying(140),
    base_tax_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    account_head character varying(140)
);


ALTER TABLE public."tabPurchase Taxes and Charges" OWNER TO postgres;

--
-- TOC entry 444 (class 1259 OID 19197)
-- Name: tabPurchase Taxes and Charges Template; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabPurchase Taxes and Charges Template" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    disabled integer DEFAULT 0 NOT NULL,
    _liked_by text,
    title character varying(140),
    _comments text,
    company character varying(140),
    _assign text,
    is_default integer DEFAULT 0 NOT NULL,
    _user_tags text
);


ALTER TABLE public."tabPurchase Taxes and Charges Template" OWNER TO postgres;

--
-- TOC entry 445 (class 1259 OID 19207)
-- Name: tabQuality Inspection; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabQuality Inspection" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    naming_series character varying(140),
    report_date date,
    item_name character varying(140),
    _comments text,
    verified_by character varying(140),
    reference_type character varying(140),
    amended_from character varying(140),
    _liked_by text,
    description text,
    reference_name character varying(140),
    inspection_type character varying(140),
    _assign text,
    item_serial_no character varying(140),
    item_code character varying(140),
    remarks text,
    _user_tags text,
    inspected_by character varying(140) DEFAULT 'user'::character varying,
    sample_size numeric(18,6) DEFAULT 0.000000 NOT NULL,
    batch_no character varying(140)
);


ALTER TABLE public."tabQuality Inspection" OWNER TO postgres;

--
-- TOC entry 446 (class 1259 OID 19217)
-- Name: tabQuality Inspection Reading; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabQuality Inspection Reading" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    status character varying(140) DEFAULT 'Accepted'::character varying,
    reading_10 character varying(140),
    value character varying(140),
    reading_5 character varying(140),
    reading_8 character varying(140),
    reading_9 character varying(140),
    reading_1 character varying(140),
    reading_2 character varying(140),
    reading_3 character varying(140),
    reading_4 character varying(140),
    specification character varying(140),
    reading_6 character varying(140),
    reading_7 character varying(140)
);


ALTER TABLE public."tabQuality Inspection Reading" OWNER TO postgres;

--
-- TOC entry 448 (class 1259 OID 19255)
-- Name: tabQuotation Item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabQuotation Item" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    base_price_list_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    base_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    qty numeric(18,6) DEFAULT 0.000000 NOT NULL,
    item_tax_rate text,
    rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    actual_qty numeric(18,6) DEFAULT 0.000000 NOT NULL,
    page_break integer DEFAULT 0 NOT NULL,
    base_net_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    discount_percentage numeric(18,6) DEFAULT 0.000000 NOT NULL,
    item_name character varying(140),
    base_net_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    net_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    stock_uom character varying(140),
    warehouse character varying(140),
    image text,
    description text,
    prevdoc_docname character varying(140),
    brand character varying(140),
    base_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    item_code character varying(140),
    projected_qty numeric(18,6) DEFAULT 0.000000 NOT NULL,
    margin_type character varying(140),
    pricing_rule character varying(140),
    price_list_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    margin_rate_or_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    item_group character varying(140),
    amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    customer_item_code character varying(140),
    net_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    total_margin numeric(18,6) DEFAULT 0.000000 NOT NULL,
    prevdoc_doctype character varying(140)
);


ALTER TABLE public."tabQuotation Item" OWNER TO postgres;

--
-- TOC entry 449 (class 1259 OID 19280)
-- Name: tabQuotation Lost Reason; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabQuotation Lost Reason" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    order_lost_reason character varying(140),
    _assign text,
    _user_tags text,
    _comments text,
    _liked_by text
);


ALTER TABLE public."tabQuotation Lost Reason" OWNER TO postgres;

--
-- TOC entry 451 (class 1259 OID 19299)
-- Name: tabRequest for Quotation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabRequest for Quotation" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    standard_reply character varying(140),
    naming_series character varying(140),
    fiscal_year character varying(140),
    letter_head character varying(140),
    terms text,
    _comments text,
    tc_name character varying(140),
    amended_from character varying(140),
    transaction_date date,
    status character varying(140),
    _liked_by text,
    vendor character varying(140),
    company character varying(140),
    _assign text,
    _user_tags text,
    select_print_heading character varying(140),
    message_for_supplier text
);


ALTER TABLE public."tabRequest for Quotation" OWNER TO postgres;

--
-- TOC entry 452 (class 1259 OID 19307)
-- Name: tabRequest for Quotation Item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabRequest for Quotation Item" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    image text,
    qty numeric(18,6) DEFAULT 0.000000 NOT NULL,
    page_break integer DEFAULT 0 NOT NULL,
    item_name character varying(140),
    warehouse character varying(140),
    supplier_part_no character varying(140),
    uom character varying(140),
    project_name character varying(140),
    description text,
    brand character varying(140),
    item_code character varying(140),
    material_request character varying(140),
    schedule_date date,
    item_group character varying(140),
    material_request_item character varying(140)
);


ALTER TABLE public."tabRequest for Quotation Item" OWNER TO postgres;

--
-- TOC entry 453 (class 1259 OID 19317)
-- Name: tabRequest for Quotation Supplier; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabRequest for Quotation Supplier" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    email_id character varying(140),
    contact character varying(140),
    send_email integer DEFAULT 1 NOT NULL,
    supplier_name character varying(140),
    supplier character varying(140)
);


ALTER TABLE public."tabRequest for Quotation Supplier" OWNER TO postgres;

--
-- TOC entry 482 (class 1259 OID 19720)
-- Name: tabSMS Log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabSMS Log" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    requested_numbers text,
    _liked_by text,
    sender_name character varying(140),
    _comments text,
    _assign text,
    sent_on date,
    no_of_sent_sms bigint DEFAULT '0'::bigint NOT NULL,
    message text,
    no_of_requested_sms bigint DEFAULT '0'::bigint NOT NULL,
    _user_tags text,
    sent_to text
);


ALTER TABLE public."tabSMS Log" OWNER TO postgres;

--
-- TOC entry 483 (class 1259 OID 19730)
-- Name: tabSMS Parameter; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabSMS Parameter" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    parameter character varying(140),
    value character varying(140)
);


ALTER TABLE public."tabSMS Parameter" OWNER TO postgres;

--
-- TOC entry 456 (class 1259 OID 19344)
-- Name: tabSalary Component; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabSalary Component" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    _liked_by text,
    description text,
    _user_tags text,
    _assign text,
    salary_component_abbr character varying(140),
    salary_component character varying(140),
    type character varying(140),
    _comments text
);


ALTER TABLE public."tabSalary Component" OWNER TO postgres;

--
-- TOC entry 457 (class 1259 OID 19352)
-- Name: tabSalary Component Account; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabSalary Component Account" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    company character varying(140),
    default_account character varying(140)
);


ALTER TABLE public."tabSalary Component Account" OWNER TO postgres;

--
-- TOC entry 458 (class 1259 OID 19360)
-- Name: tabSalary Detail; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabSalary Detail" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    default_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    amount_based_on_formula integer DEFAULT 1 NOT NULL,
    depends_on_lwp integer DEFAULT 0 NOT NULL,
    amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    abbr character varying(140),
    salary_component character varying(140),
    formula text,
    condition text
);


ALTER TABLE public."tabSalary Detail" OWNER TO postgres;

--
-- TOC entry 459 (class 1259 OID 19372)
-- Name: tabSalary Slip; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabSalary Slip" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    payment_days numeric(18,6) DEFAULT 0.000000 NOT NULL,
    salary_structure character varying(140),
    journal_entry character varying(140),
    total_in_words character varying(140),
    letter_head character varying(140),
    _liked_by text,
    payroll_frequency character varying(140),
    salary_slip_based_on_timesheet integer DEFAULT 0 NOT NULL,
    leave_encashment_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    _comments text,
    amended_from character varying(140),
    branch character varying(140),
    department character varying(140),
    start_date date,
    leave_without_pay numeric(18,6) DEFAULT 0.000000 NOT NULL,
    status character varying(140),
    bank_name character varying(140),
    _assign text,
    total_deduction numeric(18,6) DEFAULT 0.000000 NOT NULL,
    end_date date,
    company character varying(140),
    employee character varying(140),
    total_working_days numeric(18,6) DEFAULT 0.000000 NOT NULL,
    employee_name character varying(140),
    _user_tags text,
    bank_account_no character varying(140),
    designation character varying(140),
    net_pay numeric(18,6) DEFAULT 0.000000 NOT NULL,
    rounded_total numeric(18,6) DEFAULT 0.000000 NOT NULL,
    hour_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    total_working_hours numeric(18,6) DEFAULT 0.000000 NOT NULL,
    posting_date date,
    gross_pay numeric(18,6) DEFAULT 0.000000 NOT NULL,
    arrear_amount numeric(18,6) DEFAULT 0.000000 NOT NULL
);


ALTER TABLE public."tabSalary Slip" OWNER TO postgres;

--
-- TOC entry 460 (class 1259 OID 19392)
-- Name: tabSalary Slip Timesheet; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabSalary Slip Timesheet" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    working_hours numeric(18,6) DEFAULT 0.000000 NOT NULL,
    time_sheet character varying(140)
);


ALTER TABLE public."tabSalary Slip Timesheet" OWNER TO postgres;

--
-- TOC entry 461 (class 1259 OID 19401)
-- Name: tabSalary Structure; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabSalary Structure" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    mode_of_payment character varying(140),
    letter_head character varying(140),
    to_date date,
    total_earning numeric(18,6) DEFAULT 0.000000 NOT NULL,
    _comments text,
    from_date date,
    salary_component character varying(140),
    _liked_by text,
    total_deduction numeric(18,6) DEFAULT 0.000000 NOT NULL,
    company character varying(140),
    _assign text,
    is_active character varying(140) DEFAULT 'Yes'::character varying,
    is_default character varying(140) DEFAULT 'No'::character varying,
    net_pay numeric(18,6) DEFAULT 0.000000 NOT NULL,
    _user_tags text,
    payment_account character varying(140),
    hour_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    salary_slip_based_on_timesheet integer DEFAULT 0 NOT NULL,
    payroll_frequency character varying(140) DEFAULT 'Monthly'::character varying
);


ALTER TABLE public."tabSalary Structure" OWNER TO postgres;

--
-- TOC entry 462 (class 1259 OID 19417)
-- Name: tabSalary Structure Employee; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabSalary Structure Employee" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    employee character varying(140),
    variable numeric(18,6) DEFAULT 0.000000 NOT NULL,
    base numeric(18,6) DEFAULT 0.000000 NOT NULL,
    employee_name character varying(140)
);


ALTER TABLE public."tabSalary Structure Employee" OWNER TO postgres;

--
-- TOC entry 463 (class 1259 OID 19427)
-- Name: tabSales Invoice; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabSales Invoice" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    cash_bank_account character varying(140),
    base_write_off_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    title character varying(140) DEFAULT '{customer_name}'::character varying,
    selling_price_list character varying(140),
    return_against character varying(140),
    tc_name character varying(140),
    submit_on_creation integer DEFAULT 0 NOT NULL,
    base_in_words character varying(140),
    due_date date,
    write_off_cost_center character varying(140),
    _assign text,
    base_discount_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    base_total_taxes_and_charges numeric(18,6) DEFAULT 0.000000 NOT NULL,
    discount_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    is_return integer DEFAULT 0 NOT NULL,
    write_off_outstanding_amount_automatically integer DEFAULT 0 NOT NULL,
    select_print_heading character varying(140),
    source character varying(140),
    against_income_account text,
    write_off_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    party_account_currency character varying(140),
    net_total numeric(18,6) DEFAULT 0.000000 NOT NULL,
    price_list_currency character varying(140),
    contact_display text,
    next_date date,
    terms text,
    is_opening character varying(140) DEFAULT 'No'::character varying,
    customer_address character varying(140),
    total_commission numeric(18,6) DEFAULT 0.000000 NOT NULL,
    contact_mobile text,
    _user_tags text,
    c_form_applicable character varying(140),
    base_net_total numeric(18,6) DEFAULT 0.000000 NOT NULL,
    shipping_address_name character varying(140),
    apply_discount_on character varying(140) DEFAULT 'Grand Total'::character varying,
    offline_pos_name character varying(140),
    repeat_on_day_of_month bigint DEFAULT '0'::bigint NOT NULL,
    contact_person character varying(140),
    in_words character varying(140),
    shipping_address text,
    recurring_print_format character varying(140),
    additional_discount_percentage numeric(18,6) DEFAULT 0.000000 NOT NULL,
    campaign character varying(140),
    base_paid_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    remarks text,
    conversion_rate numeric(21,9) DEFAULT 0.000000000 NOT NULL,
    to_date date,
    total_advance numeric(18,6) DEFAULT 0.000000 NOT NULL,
    posting_time time(6) without time zone,
    total numeric(18,6) DEFAULT 0.000000 NOT NULL,
    customer_name character varying(140),
    commission_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    update_stock integer DEFAULT 0 NOT NULL,
    _comments text,
    base_total numeric(18,6) DEFAULT 0.000000 NOT NULL,
    from_date date,
    account_for_change_amount character varying(140),
    territory character varying(140),
    sales_partner character varying(140),
    end_date date,
    company character varying(140),
    base_rounded_total numeric(18,6) DEFAULT 0.000000 NOT NULL,
    is_pos integer DEFAULT 0 NOT NULL,
    customer character varying(140),
    grand_total numeric(18,6) DEFAULT 0.000000 NOT NULL,
    notify_by_email integer DEFAULT 0 NOT NULL,
    is_recurring integer DEFAULT 0 NOT NULL,
    language character varying(140),
    project character varying(140),
    rounded_total numeric(18,6) DEFAULT 0.000000 NOT NULL,
    posting_date date,
    customer_group character varying(140),
    address_display text,
    naming_series character varying(140),
    currency character varying(140),
    letter_head character varying(140),
    recurring_id character varying(140),
    shipping_rule character varying(140),
    ignore_pricing_rule integer DEFAULT 0 NOT NULL,
    paid_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    debit_to character varying(140),
    base_change_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    amended_from character varying(140),
    base_grand_total numeric(18,6) DEFAULT 0.000000 NOT NULL,
    recurring_type character varying(140),
    status character varying(140) DEFAULT 'Draft'::character varying,
    total_billing_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    _liked_by text,
    taxes_and_charges character varying(140),
    outstanding_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    change_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    write_off_account character varying(140),
    notification_email_address text,
    c_form_no character varying(140),
    plc_conversion_rate numeric(21,9) DEFAULT 0.000000000 NOT NULL,
    total_taxes_and_charges numeric(18,6) DEFAULT 0.000000 NOT NULL,
    contact_email character varying(140)
);


ALTER TABLE public."tabSales Invoice" OWNER TO postgres;

--
-- TOC entry 464 (class 1259 OID 19474)
-- Name: tabSales Invoice Advance; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabSales Invoice Advance" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    reference_type character varying(140),
    advance_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    reference_row character varying(140),
    reference_name character varying(140),
    remarks text,
    allocated_amount numeric(18,6) DEFAULT 0.000000 NOT NULL
);


ALTER TABLE public."tabSales Invoice Advance" OWNER TO postgres;

--
-- TOC entry 465 (class 1259 OID 19484)
-- Name: tabSales Invoice Item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabSales Invoice Item" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    item_group character varying(140),
    base_price_list_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    actual_batch_qty numeric(18,6) DEFAULT 0.000000 NOT NULL,
    serial_no text,
    base_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    expense_account character varying(140),
    item_tax_rate text,
    delivery_note character varying(140),
    cost_center character varying(140),
    target_warehouse character varying(140),
    dn_detail character varying(140),
    actual_qty numeric(18,6) DEFAULT 0.000000 NOT NULL,
    quality_inspection character varying(140),
    so_detail character varying(140),
    base_net_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    discount_percentage numeric(18,6) DEFAULT 0.000000 NOT NULL,
    item_name character varying(140),
    qty numeric(18,6) DEFAULT 0.000000 NOT NULL,
    base_net_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    margin_type character varying(140),
    net_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    stock_uom character varying(140),
    asset character varying(140),
    warehouse character varying(140),
    image text,
    description text,
    brand character varying(140),
    barcode character varying(140),
    base_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    item_code character varying(140),
    page_break integer DEFAULT 0 NOT NULL,
    pricing_rule character varying(140),
    delivered_qty numeric(18,6) DEFAULT 0.000000 NOT NULL,
    net_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    price_list_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    sales_order character varying(140),
    margin_rate_or_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    income_account character varying(140),
    amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    customer_item_code character varying(140),
    batch_no character varying(140),
    delivered_by_supplier integer DEFAULT 0 NOT NULL,
    is_fixed_asset integer DEFAULT 0 NOT NULL,
    total_margin numeric(18,6) DEFAULT 0.000000 NOT NULL
);


ALTER TABLE public."tabSales Invoice Item" OWNER TO postgres;

--
-- TOC entry 466 (class 1259 OID 19512)
-- Name: tabSales Invoice Payment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabSales Invoice Payment" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    account character varying(140),
    mode_of_payment character varying(140),
    base_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    type character varying(140)
);


ALTER TABLE public."tabSales Invoice Payment" OWNER TO postgres;

--
-- TOC entry 467 (class 1259 OID 19522)
-- Name: tabSales Invoice Timesheet; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabSales Invoice Timesheet" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    timesheet_detail character varying(140),
    billing_hours numeric(18,6) DEFAULT 0.000000 NOT NULL,
    time_sheet character varying(140),
    billing_amount numeric(18,6) DEFAULT 0.000000 NOT NULL
);


ALTER TABLE public."tabSales Invoice Timesheet" OWNER TO postgres;

--
-- TOC entry 468 (class 1259 OID 19532)
-- Name: tabSales Order; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabSales Order" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    billing_status character varying(140),
    title character varying(140) DEFAULT '{customer_name}'::character varying,
    selling_price_list character varying(140),
    tc_name character varying(140),
    source character varying(140),
    submit_on_creation integer DEFAULT 0 NOT NULL,
    base_in_words character varying(140),
    ignore_pricing_rule integer DEFAULT 0 NOT NULL,
    _assign text,
    base_discount_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    notify_by_email integer DEFAULT 0 NOT NULL,
    base_total_taxes_and_charges numeric(18,6) DEFAULT 0.000000 NOT NULL,
    discount_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    base_grand_total numeric(18,6) DEFAULT 0.000000 NOT NULL,
    select_print_heading character varying(140),
    delivery_date date,
    total_taxes_and_charges numeric(18,6) DEFAULT 0.000000 NOT NULL,
    party_account_currency character varying(140),
    po_date date,
    price_list_currency character varying(140),
    contact_display text,
    next_date date,
    terms text,
    advance_paid numeric(18,6) DEFAULT 0.000000 NOT NULL,
    customer_address character varying(140),
    total_commission numeric(18,6) DEFAULT 0.000000 NOT NULL,
    contact_mobile text,
    delivery_status character varying(140),
    _user_tags text,
    base_net_total numeric(18,6) DEFAULT 0.000000 NOT NULL,
    language character varying(140),
    rounded_total numeric(18,6) DEFAULT 0.000000 NOT NULL,
    shipping_address_name character varying(140),
    apply_discount_on character varying(140) DEFAULT 'Grand Total'::character varying,
    po_no character varying(140),
    repeat_on_day_of_month bigint DEFAULT '0'::bigint NOT NULL,
    contact_person character varying(140),
    in_words character varying(140),
    recurring_print_format character varying(140),
    additional_discount_percentage numeric(18,6) DEFAULT 0.000000 NOT NULL,
    campaign character varying(140),
    conversion_rate numeric(21,9) DEFAULT 0.000000000 NOT NULL,
    to_date date,
    total numeric(18,6) DEFAULT 0.000000 NOT NULL,
    customer_name character varying(140),
    commission_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    _comments text,
    base_total numeric(18,6) DEFAULT 0.000000 NOT NULL,
    from_date date,
    territory character varying(140),
    sales_partner character varying(140),
    end_date date,
    company character varying(140),
    contact_email character varying(140),
    customer character varying(140),
    grand_total numeric(18,6) DEFAULT 0.000000 NOT NULL,
    notification_email_address text,
    is_recurring integer DEFAULT 0 NOT NULL,
    project character varying(140),
    shipping_address text,
    customer_group character varying(140),
    address_display text,
    naming_series character varying(140),
    currency character varying(140),
    letter_head character varying(140),
    recurring_id character varying(140),
    shipping_rule character varying(140),
    order_type character varying(140) DEFAULT 'Sales'::character varying,
    amended_from character varying(140),
    transaction_date date,
    recurring_type character varying(140),
    per_delivered numeric(18,6) DEFAULT 0.000000 NOT NULL,
    _liked_by text,
    status character varying(140) DEFAULT 'Draft'::character varying,
    group_same_items integer DEFAULT 0 NOT NULL,
    taxes_and_charges character varying(140),
    per_billed numeric(18,6) DEFAULT 0.000000 NOT NULL,
    plc_conversion_rate numeric(21,9) DEFAULT 0.000000000 NOT NULL,
    net_total numeric(18,6) DEFAULT 0.000000 NOT NULL,
    base_rounded_total numeric(18,6) DEFAULT 0.000000 NOT NULL
);


ALTER TABLE public."tabSales Order" OWNER TO postgres;

--
-- TOC entry 469 (class 1259 OID 19570)
-- Name: tabSales Order Item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabSales Order Item" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    image text,
    base_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    qty numeric(18,6) DEFAULT 0.000000 NOT NULL,
    margin_rate_or_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    target_warehouse character varying(140),
    actual_qty numeric(18,6) DEFAULT 0.000000 NOT NULL,
    stock_uom character varying(140),
    page_break integer DEFAULT 0 NOT NULL,
    base_net_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    discount_percentage numeric(18,6) DEFAULT 0.000000 NOT NULL,
    item_name character varying(140),
    base_net_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    margin_type character varying(140),
    net_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    transaction_date date,
    ordered_qty numeric(18,6) DEFAULT 0.000000 NOT NULL,
    base_price_list_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    supplier character varying(140),
    description text,
    prevdoc_docname character varying(140),
    returned_qty numeric(18,6) DEFAULT 0.000000 NOT NULL,
    brand character varying(140),
    base_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    item_code character varying(140),
    produced_qty numeric(18,6) DEFAULT 0.000000 NOT NULL,
    projected_qty numeric(18,6) DEFAULT 0.000000 NOT NULL,
    warehouse character varying(140),
    billed_amt numeric(18,6) DEFAULT 0.000000 NOT NULL,
    pricing_rule character varying(140),
    delivered_qty numeric(18,6) DEFAULT 0.000000 NOT NULL,
    net_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    price_list_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    item_tax_rate text,
    item_group character varying(140),
    planned_qty numeric(18,6) DEFAULT 0.000000 NOT NULL,
    gross_profit numeric(18,6) DEFAULT 0.000000 NOT NULL,
    amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    customer_item_code character varying(140),
    valuation_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    delivered_by_supplier integer DEFAULT 0 NOT NULL,
    total_margin numeric(18,6) DEFAULT 0.000000 NOT NULL
);


ALTER TABLE public."tabSales Order Item" OWNER TO postgres;

--
-- TOC entry 470 (class 1259 OID 19604)
-- Name: tabSales Partner; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabSales Partner" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    partner_website character varying(140),
    logo text,
    commission_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    partner_name character varying(140),
    _comments text,
    distribution_id character varying(140),
    territory character varying(140),
    _liked_by text,
    description text,
    _assign text,
    partner_type character varying(140),
    show_in_website integer DEFAULT 0 NOT NULL,
    _user_tags text,
    route character varying(140),
    introduction text
);


ALTER TABLE public."tabSales Partner" OWNER TO postgres;

--
-- TOC entry 471 (class 1259 OID 19614)
-- Name: tabSales Person; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabSales Person" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    old_parent character varying(140),
    _assign text,
    rgt bigint DEFAULT '0'::bigint NOT NULL,
    lft bigint DEFAULT '0'::bigint NOT NULL,
    is_group integer DEFAULT 0 NOT NULL,
    sales_person_name character varying(140),
    enabled integer DEFAULT 1 NOT NULL,
    distribution_id character varying(140),
    _liked_by text,
    _comments text,
    employee character varying(140),
    parent_sales_person character varying(140),
    _user_tags text
);


ALTER TABLE public."tabSales Person" OWNER TO postgres;

--
-- TOC entry 472 (class 1259 OID 19626)
-- Name: tabSales Taxes and Charges; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabSales Taxes and Charges" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    charge_type character varying(140),
    base_tax_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    tax_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    description text,
    item_wise_tax_detail text,
    base_tax_amount_after_discount_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    base_total numeric(18,6) DEFAULT 0.000000 NOT NULL,
    included_in_print_rate integer DEFAULT 0 NOT NULL,
    rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    account_head character varying(140),
    cost_center character varying(140),
    tax_amount_after_discount_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    row_id character varying(140),
    total numeric(18,6) DEFAULT 0.000000 NOT NULL
);


ALTER TABLE public."tabSales Taxes and Charges" OWNER TO postgres;

--
-- TOC entry 473 (class 1259 OID 19642)
-- Name: tabSales Taxes and Charges Template; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabSales Taxes and Charges Template" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    disabled integer DEFAULT 0 NOT NULL,
    _liked_by text,
    title character varying(140),
    _comments text,
    company character varying(140),
    _assign text,
    is_default integer DEFAULT 0 NOT NULL,
    _user_tags text
);


ALTER TABLE public."tabSales Taxes and Charges Template" OWNER TO postgres;

--
-- TOC entry 474 (class 1259 OID 19652)
-- Name: tabSales Team; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabSales Team" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    contact_no character varying(140),
    incentives numeric(18,6) DEFAULT 0.000000 NOT NULL,
    allocated_percentage numeric(18,6) DEFAULT 0.000000 NOT NULL,
    sales_person character varying(140),
    allocated_amount numeric(18,6) DEFAULT 0.000000 NOT NULL
);


ALTER TABLE public."tabSales Team" OWNER TO postgres;

--
-- TOC entry 475 (class 1259 OID 19663)
-- Name: tabSerial No; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabSerial No" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    purchase_time time(6) without time zone,
    delivery_document_type character varying(140),
    serial_no character varying(140),
    purchase_document_no character varying(140),
    supplier character varying(140),
    customer_name character varying(140),
    amc_expiry_date date,
    purchase_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    item_name character varying(140),
    _user_tags text,
    purchase_document_type character varying(140),
    brand character varying(140),
    _liked_by text,
    description text,
    purchase_date date,
    company character varying(140),
    _assign text,
    item_code character varying(140),
    warehouse character varying(140),
    _comments text,
    supplier_name character varying(140),
    is_cancelled character varying(140),
    maintenance_status character varying(140),
    customer character varying(140),
    delivery_time time(6) without time zone,
    delivery_document_no character varying(140),
    item_group character varying(140),
    warranty_period bigint DEFAULT '0'::bigint NOT NULL,
    serial_no_details text,
    warranty_expiry_date date,
    delivery_date date
);


ALTER TABLE public."tabSerial No" OWNER TO postgres;

--
-- TOC entry 478 (class 1259 OID 19684)
-- Name: tabShipping Rule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabShipping Rule" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    calculate_based_on character varying(140) DEFAULT 'Net Total'::character varying,
    _assign text,
    _user_tags text,
    worldwide_shipping integer DEFAULT 0 NOT NULL,
    company character varying(140),
    account character varying(140),
    label character varying(140),
    disabled integer DEFAULT 0 NOT NULL,
    _liked_by text,
    _comments text,
    cost_center character varying(140)
);


ALTER TABLE public."tabShipping Rule" OWNER TO postgres;

--
-- TOC entry 479 (class 1259 OID 19695)
-- Name: tabShipping Rule Condition; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabShipping Rule Condition" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    to_value numeric(18,6) DEFAULT 0.000000 NOT NULL,
    from_value numeric(18,6) DEFAULT 0.000000 NOT NULL,
    shipping_amount numeric(18,6) DEFAULT 0.000000 NOT NULL
);


ALTER TABLE public."tabShipping Rule Condition" OWNER TO postgres;

--
-- TOC entry 480 (class 1259 OID 19706)
-- Name: tabShipping Rule Country; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabShipping Rule Country" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    country character varying(140)
);


ALTER TABLE public."tabShipping Rule Country" OWNER TO postgres;

--
-- TOC entry 484 (class 1259 OID 19738)
-- Name: tabStandard Reply; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabStandard Reply" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    _liked_by text,
    _comments text,
    _assign text,
    _user_tags text,
    response text,
    subject character varying(140)
);


ALTER TABLE public."tabStandard Reply" OWNER TO postgres;

--
-- TOC entry 485 (class 1259 OID 19746)
-- Name: tabStock Entry; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabStock Entry" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    use_multi_level_bom integer DEFAULT 1 NOT NULL,
    delivery_note_no character varying(140),
    supplier_address text,
    naming_series character varying(140),
    fg_completed_qty numeric(18,6) DEFAULT 0.000000 NOT NULL,
    letter_head character varying(140),
    _liked_by text,
    purchase_receipt_no character varying(140),
    posting_time time(6) without time zone,
    customer_name character varying(140),
    title character varying(140) DEFAULT '{purpose}'::character varying,
    _comments text,
    from_warehouse character varying(140),
    amended_from character varying(140),
    purchase_order character varying(140),
    from_bom integer DEFAULT 0 NOT NULL,
    to_warehouse character varying(140),
    supplier character varying(140),
    value_difference numeric(18,6) DEFAULT 0.000000 NOT NULL,
    credit_note character varying(140),
    sales_invoice_no character varying(140),
    company character varying(140),
    bom_no character varying(140),
    customer_address text,
    purpose character varying(140) DEFAULT 'Material Issue'::character varying,
    supplier_name character varying(140),
    remarks text,
    _user_tags text,
    total_additional_costs numeric(18,6) DEFAULT 0.000000 NOT NULL,
    customer character varying(140),
    total_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    total_incoming_value numeric(18,6) DEFAULT 0.000000 NOT NULL,
    project character varying(140),
    _assign text,
    select_print_heading character varying(140),
    posting_date date,
    production_order character varying(140),
    total_outgoing_value numeric(18,6) DEFAULT 0.000000 NOT NULL
);


ALTER TABLE public."tabStock Entry" OWNER TO postgres;

--
-- TOC entry 486 (class 1259 OID 19764)
-- Name: tabStock Entry Detail; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabStock Entry Detail" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    t_warehouse character varying(140),
    transfer_qty numeric(18,6) DEFAULT 0.000000 NOT NULL,
    basic_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    image text,
    serial_no text,
    expense_account character varying(140),
    cost_center character varying(140),
    actual_qty numeric(18,6) DEFAULT 0.000000 NOT NULL,
    s_warehouse character varying(140),
    stock_uom character varying(140),
    item_name character varying(140),
    additional_cost numeric(18,6) DEFAULT 0.000000 NOT NULL,
    conversion_factor numeric(18,6) DEFAULT 0.000000 NOT NULL,
    uom character varying(140),
    basic_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    description text,
    barcode character varying(140),
    item_code character varying(140),
    qty numeric(18,6) DEFAULT 0.000000 NOT NULL,
    bom_no character varying(140),
    material_request_item character varying(140),
    amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    batch_no character varying(140),
    valuation_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    material_request character varying(140)
);


ALTER TABLE public."tabStock Entry Detail" OWNER TO postgres;

--
-- TOC entry 487 (class 1259 OID 19781)
-- Name: tabStock Ledger Entry; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabStock Ledger Entry" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    serial_no text,
    fiscal_year character varying(140),
    voucher_type character varying(140),
    posting_time time(6) without time zone,
    voucher_no character varying(140),
    qty_after_transaction numeric(18,6) DEFAULT 0.000000 NOT NULL,
    _comments text,
    incoming_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    voucher_detail_no character varying(140),
    actual_qty numeric(18,6) DEFAULT 0.000000 NOT NULL,
    stock_uom character varying(140),
    warehouse character varying(140),
    _liked_by text,
    company character varying(140),
    _assign text,
    item_code character varying(140),
    stock_queue text,
    valuation_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    outgoing_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    is_cancelled character varying(140),
    stock_value numeric(18,6) DEFAULT 0.000000 NOT NULL,
    _user_tags text,
    project character varying(140),
    batch_no character varying(140),
    stock_value_difference numeric(18,6) DEFAULT 0.000000 NOT NULL,
    posting_date date
);


ALTER TABLE public."tabStock Ledger Entry" OWNER TO postgres;

--
-- TOC entry 488 (class 1259 OID 19796)
-- Name: tabStock Reconciliation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabStock Reconciliation" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    _assign text,
    difference_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    company character varying(140),
    _liked_by text,
    amended_from character varying(140),
    reconciliation_json text,
    _comments text,
    naming_series character varying(140),
    expense_account character varying(140),
    posting_date date,
    cost_center character varying(140),
    _user_tags text,
    posting_time time(6) without time zone
);


ALTER TABLE public."tabStock Reconciliation" OWNER TO postgres;

--
-- TOC entry 489 (class 1259 OID 19805)
-- Name: tabStock Reconciliation Item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabStock Reconciliation Item" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    barcode character varying(140),
    amount_difference numeric(18,6) DEFAULT 0.000000 NOT NULL,
    current_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    item_name character varying(140),
    current_qty numeric(18,6) DEFAULT 0.000000 NOT NULL,
    quantity_difference character varying(140),
    item_code character varying(140),
    qty numeric(18,6) DEFAULT 0.000000 NOT NULL,
    warehouse character varying(140),
    amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    valuation_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    current_valuation_rate numeric(18,6) DEFAULT 0.000000 NOT NULL
);


ALTER TABLE public."tabStock Reconciliation Item" OWNER TO postgres;

--
-- TOC entry 491 (class 1259 OID 19828)
-- Name: tabStudent Admission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabStudent Admission" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    academic_year character varying(140),
    _liked_by text,
    application_fee numeric(18,6) DEFAULT 0.000000 NOT NULL,
    title character varying(140),
    introduction text,
    _user_tags text,
    route character varying(140),
    _assign text,
    admission_start_date date,
    admission_end_date date,
    currency character varying(140),
    program character varying(140),
    naming_series_for_student_applicant character varying(140),
    publish integer DEFAULT 0 NOT NULL,
    _comments text,
    eligibility text,
    application_form_route character varying(140)
);


ALTER TABLE public."tabStudent Admission" OWNER TO postgres;

--
-- TOC entry 492 (class 1259 OID 19838)
-- Name: tabStudent Applicant; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabStudent Applicant" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    program character varying(140),
    academic_year character varying(140),
    last_name character varying(140),
    blood_group character varying(140),
    naming_series character varying(140),
    image text,
    pincode character varying(140),
    student_mobile_number character varying(140),
    student_email_id character varying(140),
    city character varying(140),
    first_name character varying(140),
    middle_name character varying(140),
    title character varying(140),
    _comments text,
    amended_from character varying(140),
    state character varying(140),
    date_of_birth date,
    application_status character varying(140),
    _liked_by text,
    _assign text,
    paid integer DEFAULT 0 NOT NULL,
    student_admission character varying(140),
    nationality character varying(140),
    _user_tags text,
    application_date date,
    gender character varying(140),
    address_line_2 character varying(140),
    address_line_1 character varying(140)
);


ALTER TABLE public."tabStudent Applicant" OWNER TO postgres;

--
-- TOC entry 493 (class 1259 OID 19847)
-- Name: tabStudent Attendance; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabStudent Attendance" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    status character varying(140) DEFAULT 'Present'::character varying,
    _liked_by text,
    course_schedule character varying(140),
    student_batch character varying(140),
    _assign text,
    amended_from character varying(140),
    _comments text,
    student character varying(140),
    date date,
    student_name character varying(140),
    _user_tags text
);


ALTER TABLE public."tabStudent Attendance" OWNER TO postgres;

--
-- TOC entry 494 (class 1259 OID 19856)
-- Name: tabStudent Batch; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabStudent Batch" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    academic_year character varying(140),
    _comments text,
    enabled integer DEFAULT 1 NOT NULL,
    academic_term character varying(140),
    _assign text,
    program character varying(140),
    student_batch_name character varying(140),
    _user_tags text,
    _liked_by text
);


ALTER TABLE public."tabStudent Batch" OWNER TO postgres;

--
-- TOC entry 495 (class 1259 OID 19865)
-- Name: tabStudent Batch Instructor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabStudent Batch Instructor" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    instructor_name character varying(140),
    instructor character varying(140)
);


ALTER TABLE public."tabStudent Batch Instructor" OWNER TO postgres;

--
-- TOC entry 496 (class 1259 OID 19873)
-- Name: tabStudent Batch Name; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabStudent Batch Name" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    batch_name character varying(140),
    _comments text,
    _assign text,
    _user_tags text,
    _liked_by text
);


ALTER TABLE public."tabStudent Batch Name" OWNER TO postgres;

--
-- TOC entry 497 (class 1259 OID 19881)
-- Name: tabStudent Batch Student; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabStudent Batch Student" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    active integer DEFAULT 1 NOT NULL,
    student_name character varying(140),
    student character varying(140)
);


ALTER TABLE public."tabStudent Batch Student" OWNER TO postgres;

--
-- TOC entry 498 (class 1259 OID 19890)
-- Name: tabStudent Category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabStudent Category" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    category character varying(140),
    _comments text,
    _assign text,
    _user_tags text,
    _liked_by text
);


ALTER TABLE public."tabStudent Category" OWNER TO postgres;

--
-- TOC entry 499 (class 1259 OID 19898)
-- Name: tabStudent Group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabStudent Group" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    academic_year character varying(140),
    _liked_by text,
    student_batch character varying(140),
    _assign text,
    max_strength bigint DEFAULT '0'::bigint NOT NULL,
    academic_term character varying(140),
    amended_from character varying(140),
    program character varying(140),
    course character varying(140),
    _user_tags text,
    _comments text
);


ALTER TABLE public."tabStudent Group" OWNER TO postgres;

--
-- TOC entry 500 (class 1259 OID 19907)
-- Name: tabStudent Group Creation Tool Course; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabStudent Group Creation Tool Course" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    course character varying(140),
    student_group_name character varying(140),
    course_code character varying(140),
    max_strength bigint DEFAULT '0'::bigint NOT NULL
);


ALTER TABLE public."tabStudent Group Creation Tool Course" OWNER TO postgres;

--
-- TOC entry 501 (class 1259 OID 19916)
-- Name: tabStudent Group Student; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabStudent Group Student" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    active integer DEFAULT 1 NOT NULL,
    student_name character varying(140),
    student character varying(140)
);


ALTER TABLE public."tabStudent Group Student" OWNER TO postgres;

--
-- TOC entry 502 (class 1259 OID 19925)
-- Name: tabStudent Guardian; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabStudent Guardian" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    guardian character varying(140),
    relation character varying(140)
);


ALTER TABLE public."tabStudent Guardian" OWNER TO postgres;

--
-- TOC entry 503 (class 1259 OID 19933)
-- Name: tabStudent Leave Application; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabStudent Leave Application" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    _liked_by text,
    amended_from character varying(140),
    _comments text,
    _assign text,
    from_date date,
    mark_as_present integer DEFAULT 0 NOT NULL,
    reason text,
    to_date date,
    student character varying(140),
    student_name character varying(140),
    _user_tags text
);


ALTER TABLE public."tabStudent Leave Application" OWNER TO postgres;

--
-- TOC entry 504 (class 1259 OID 19942)
-- Name: tabStudent Log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabStudent Log" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    _liked_by text,
    log text,
    _user_tags text,
    _assign text,
    _seen text,
    _comments text,
    student character varying(140),
    date date,
    student_name character varying(140),
    type character varying(140)
);


ALTER TABLE public."tabStudent Log" OWNER TO postgres;

--
-- TOC entry 505 (class 1259 OID 19950)
-- Name: tabStudent Sibling; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabStudent Sibling" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    gender character varying(140),
    date_of_birth date,
    program character varying(140),
    full_name character varying(140),
    institution character varying(140)
);


ALTER TABLE public."tabStudent Sibling" OWNER TO postgres;

--
-- TOC entry 506 (class 1259 OID 19958)
-- Name: tabStudent Siblings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabStudent Siblings" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    gender character varying(140),
    date_of_birth date,
    name1 character varying(140)
);


ALTER TABLE public."tabStudent Siblings" OWNER TO postgres;

--
-- TOC entry 508 (class 1259 OID 19977)
-- Name: tabSupplier Quotation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabSupplier Quotation" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    additional_discount_percentage numeric(18,6) DEFAULT 0.000000 NOT NULL,
    naming_series character varying(140),
    contact_mobile text,
    net_total numeric(18,6) DEFAULT 0.000000 NOT NULL,
    currency character varying(140),
    conversion_rate numeric(21,9) DEFAULT 0.000000000 NOT NULL,
    base_taxes_and_charges_deducted numeric(18,6) DEFAULT 0.000000 NOT NULL,
    total numeric(18,6) DEFAULT 0.000000 NOT NULL,
    select_print_heading character varying(140),
    is_subcontracted character varying(140) DEFAULT 'No'::character varying,
    title character varying(140) DEFAULT '{supplier_name}'::character varying,
    _user_tags text,
    base_total numeric(18,6) DEFAULT 0.000000 NOT NULL,
    transaction_date date,
    base_taxes_and_charges_added numeric(18,6) DEFAULT 0.000000 NOT NULL,
    tc_name character varying(140),
    amended_from character varying(140),
    base_grand_total numeric(18,6) DEFAULT 0.000000 NOT NULL,
    _comments text,
    supplier_address character varying(140),
    supplier character varying(140),
    contact_display text,
    buying_price_list character varying(140),
    company character varying(140),
    status character varying(140),
    _liked_by text,
    terms text,
    ignore_pricing_rule integer DEFAULT 0 NOT NULL,
    base_rounded_total numeric(18,6) DEFAULT 0.000000 NOT NULL,
    taxes_and_charges character varying(140),
    _assign text,
    grand_total numeric(18,6) DEFAULT 0.000000 NOT NULL,
    base_discount_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    base_total_taxes_and_charges numeric(18,6) DEFAULT 0.000000 NOT NULL,
    supplier_name character varying(140),
    base_in_words character varying(140),
    opportunity character varying(140),
    taxes_and_charges_added numeric(18,6) DEFAULT 0.000000 NOT NULL,
    base_net_total numeric(18,6) DEFAULT 0.000000 NOT NULL,
    in_words character varying(140),
    taxes_and_charges_deducted numeric(18,6) DEFAULT 0.000000 NOT NULL,
    language character varying(140),
    address_display text,
    discount_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    apply_discount_on character varying(140) DEFAULT 'Grand Total'::character varying,
    letter_head character varying(140),
    plc_conversion_rate numeric(21,9) DEFAULT 0.000000000 NOT NULL,
    total_taxes_and_charges numeric(18,6) DEFAULT 0.000000 NOT NULL,
    price_list_currency character varying(140),
    contact_email character varying(140),
    contact_person character varying(140)
);


ALTER TABLE public."tabSupplier Quotation" OWNER TO postgres;

--
-- TOC entry 509 (class 1259 OID 20007)
-- Name: tabSupplier Quotation Item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabSupplier Quotation Item" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    stock_qty numeric(18,6) DEFAULT 0.000000 NOT NULL,
    image text,
    base_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    qty numeric(18,6) DEFAULT 0.000000 NOT NULL,
    item_tax_rate text,
    rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    stock_uom character varying(140),
    project character varying(140),
    page_break integer DEFAULT 0 NOT NULL,
    base_net_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    discount_percentage numeric(18,6) DEFAULT 0.000000 NOT NULL,
    item_name character varying(140),
    base_net_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    net_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    conversion_factor numeric(18,6) DEFAULT 0.000000 NOT NULL,
    base_price_list_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    warehouse character varying(140),
    supplier_part_no character varying(140),
    uom character varying(140),
    description text,
    brand character varying(140),
    base_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    item_code character varying(140),
    material_request character varying(140),
    pricing_rule character varying(140),
    price_list_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    request_for_quotation character varying(140),
    item_group character varying(140),
    material_request_item character varying(140),
    amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    request_for_quotation_item character varying(140),
    net_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    prevdoc_doctype character varying(140)
);


ALTER TABLE public."tabSupplier Quotation Item" OWNER TO postgres;

--
-- TOC entry 510 (class 1259 OID 20030)
-- Name: tabSupplier Type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabSupplier Type" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    _liked_by text,
    _comments text,
    _assign text,
    credit_days_based_on character varying(140),
    credit_days bigint DEFAULT '0'::bigint NOT NULL,
    supplier_type character varying(140),
    _user_tags text
);


ALTER TABLE public."tabSupplier Type" OWNER TO postgres;

--
-- TOC entry 512 (class 1259 OID 20047)
-- Name: tabTag Category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabTag Category" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    _liked_by text,
    _user_tags text,
    _assign text,
    _comments text,
    category_name character varying(140)
);


ALTER TABLE public."tabTag Category" OWNER TO postgres;

--
-- TOC entry 513 (class 1259 OID 20055)
-- Name: tabTag Doc Category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabTag Doc Category" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    tagdoc character varying(140)
);


ALTER TABLE public."tabTag Doc Category" OWNER TO postgres;

--
-- TOC entry 514 (class 1259 OID 20063)
-- Name: tabTarget Detail; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabTarget Detail" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    item_group character varying(140),
    target_qty numeric(18,6) DEFAULT 0.000000 NOT NULL,
    fiscal_year character varying(140),
    target_amount numeric(18,6) DEFAULT 0.000000 NOT NULL
);


ALTER TABLE public."tabTarget Detail" OWNER TO postgres;

--
-- TOC entry 516 (class 1259 OID 20088)
-- Name: tabTask Depends On; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabTask Depends On" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    task character varying(140),
    subject text
);


ALTER TABLE public."tabTask Depends On" OWNER TO postgres;

--
-- TOC entry 517 (class 1259 OID 20096)
-- Name: tabTax Rule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabTax Rule" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    sales_tax_template character varying(140),
    to_date date,
    billing_country character varying(140),
    use_for_shopping_cart integer DEFAULT 0 NOT NULL,
    _comments text,
    tax_type character varying(140) DEFAULT 'Sales'::character varying,
    priority bigint DEFAULT '1'::bigint NOT NULL,
    from_date date,
    supplier character varying(140),
    billing_county character varying(140),
    _liked_by text,
    shipping_city character varying(140),
    purchase_tax_template character varying(140),
    company character varying(140),
    _assign text,
    shipping_state character varying(140),
    shipping_county character varying(140),
    supplier_type character varying(140),
    _user_tags text,
    customer character varying(140),
    billing_city character varying(140),
    customer_group character varying(140),
    shipping_country character varying(140),
    billing_state character varying(140)
);


ALTER TABLE public."tabTax Rule" OWNER TO postgres;

--
-- TOC entry 518 (class 1259 OID 20107)
-- Name: tabTerms and Conditions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabTerms and Conditions" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    _liked_by text,
    terms text,
    title character varying(140),
    _comments text,
    _assign text,
    disabled integer DEFAULT 0 NOT NULL,
    _user_tags text
);


ALTER TABLE public."tabTerms and Conditions" OWNER TO postgres;

--
-- TOC entry 521 (class 1259 OID 20143)
-- Name: tabTimesheet Detail; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabTimesheet Detail" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    billing_hours numeric(18,6) DEFAULT 0.000000 NOT NULL,
    costing_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    billing_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    operation character varying(140),
    costing_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    completed_qty numeric(18,6) DEFAULT 0.000000 NOT NULL,
    billable integer DEFAULT 0 NOT NULL,
    to_time timestamp with time zone,
    from_time timestamp with time zone,
    hours numeric(18,6) DEFAULT 0.000000 NOT NULL,
    workstation character varying(140),
    task character varying(140),
    sales_invoice character varying(140),
    billing_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    project character varying(140),
    operation_id character varying(140),
    activity_type character varying(140)
);


ALTER TABLE public."tabTimesheet Detail" OWNER TO postgres;

--
-- TOC entry 523 (class 1259 OID 20169)
-- Name: tabTop Bar Item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabTop Bar Item" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    url character varying(140),
    parent_label character varying(140),
    "right" integer DEFAULT 1 NOT NULL,
    target character varying(140),
    label character varying(140)
);


ALTER TABLE public."tabTop Bar Item" OWNER TO postgres;

--
-- TOC entry 525 (class 1259 OID 20186)
-- Name: tabTraining Event; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabTraining Event" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    trainer_email character varying(140),
    course character varying(140),
    event_status character varying(140),
    contact_number character varying(140),
    introduction text,
    _comments text,
    amended_from character varying(140),
    location character varying(140),
    supplier character varying(140),
    type character varying(140),
    _liked_by text,
    event_name character varying(140),
    start_time timestamp with time zone,
    _assign text,
    _user_tags text,
    send_email integer DEFAULT 0 NOT NULL,
    trainer_name character varying(140),
    end_time timestamp with time zone
);


ALTER TABLE public."tabTraining Event" OWNER TO postgres;

--
-- TOC entry 526 (class 1259 OID 20195)
-- Name: tabTraining Event Employee; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabTraining Event Employee" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    status character varying(140) DEFAULT 'Open'::character varying,
    employee character varying(140),
    employee_name character varying(140)
);


ALTER TABLE public."tabTraining Event Employee" OWNER TO postgres;

--
-- TOC entry 527 (class 1259 OID 20204)
-- Name: tabTraining Feedback; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabTraining Feedback" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    _liked_by text,
    feedback text,
    amended_from character varying(140),
    event_name character varying(140),
    _comments text,
    _assign text,
    course character varying(140),
    trainer_name character varying(140),
    employee_name character varying(140),
    employee character varying(140),
    _user_tags text,
    training_event character varying(140)
);


ALTER TABLE public."tabTraining Feedback" OWNER TO postgres;

--
-- TOC entry 528 (class 1259 OID 20212)
-- Name: tabTraining Result; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabTraining Result" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    _liked_by text,
    training_event character varying(140),
    _comments text,
    _assign text,
    amended_from character varying(140),
    _user_tags text
);


ALTER TABLE public."tabTraining Result" OWNER TO postgres;

--
-- TOC entry 529 (class 1259 OID 20220)
-- Name: tabTraining Result Employee; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabTraining Result Employee" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    grade character varying(140),
    comments text,
    hours numeric(18,6) DEFAULT 0.000000 NOT NULL,
    employee_name character varying(140),
    employee character varying(140)
);


ALTER TABLE public."tabTraining Result Employee" OWNER TO postgres;

--
-- TOC entry 533 (class 1259 OID 20254)
-- Name: tabUOM Conversion Detail; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabUOM Conversion Detail" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    conversion_factor numeric(18,6) DEFAULT 0.000000 NOT NULL,
    uom character varying(140)
);


ALTER TABLE public."tabUOM Conversion Detail" OWNER TO postgres;

--
-- TOC entry 531 (class 1259 OID 20237)
-- Name: tabUnhandled Email; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabUnhandled Email" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    _liked_by text,
    uid character varying(140),
    _comments text,
    _assign text,
    raw text,
    reason text,
    email_account character varying(140),
    _user_tags text,
    message_id text
);


ALTER TABLE public."tabUnhandled Email" OWNER TO postgres;

--
-- TOC entry 535 (class 1259 OID 20281)
-- Name: tabUser Email; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabUser Email" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    email_id character varying(140),
    email_account character varying(140),
    awaiting_password integer DEFAULT 0 NOT NULL
);


ALTER TABLE public."tabUser Email" OWNER TO postgres;

--
-- TOC entry 538 (class 1259 OID 20311)
-- Name: tabVehicle Log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabVehicle Log" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    naming_series character varying(140),
    license_plate character varying(140),
    invoice character varying(140),
    fuel_qty numeric(18,6) DEFAULT 0.000000 NOT NULL,
    _comments text,
    make character varying(140),
    odometer bigint DEFAULT '0'::bigint NOT NULL,
    amended_from character varying(140),
    supplier character varying(140),
    _liked_by text,
    price numeric(18,6) DEFAULT 0.000000 NOT NULL,
    _assign text,
    employee character varying(140),
    date date,
    _user_tags text,
    model character varying(140)
);


ALTER TABLE public."tabVehicle Log" OWNER TO postgres;

--
-- TOC entry 539 (class 1259 OID 20322)
-- Name: tabVehicle Service; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabVehicle Service" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    expense_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    frequency character varying(140),
    type character varying(140),
    service_item character varying(140)
);


ALTER TABLE public."tabVehicle Service" OWNER TO postgres;

--
-- TOC entry 542 (class 1259 OID 20351)
-- Name: tabWarranty Claim; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabWarranty Claim" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    status character varying(140) DEFAULT 'Open'::character varying,
    contact_email character varying(140),
    naming_series character varying(140),
    serial_no character varying(140),
    _liked_by text,
    resolved_by character varying(140),
    warranty_amc_status character varying(140),
    customer_name character varying(140),
    amc_expiry_date date,
    complaint_date date,
    item_name character varying(140),
    _comments text,
    from_company character varying(140),
    amended_from character varying(140),
    contact_display text,
    territory character varying(140),
    address_display text,
    complaint text,
    service_address text,
    description text,
    complaint_raised_by character varying(140),
    company character varying(140),
    _assign text,
    item_code character varying(140),
    customer_address character varying(140),
    contact_mobile character varying(140),
    _user_tags text,
    resolution_date timestamp with time zone,
    customer character varying(140),
    resolution_details text,
    customer_group character varying(140),
    warranty_expiry_date date,
    contact_person character varying(140)
);


ALTER TABLE public."tabWarranty Claim" OWNER TO postgres;

--
-- TOC entry 543 (class 1259 OID 20360)
-- Name: tabWeb Form; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabWeb Form" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    allow_edit integer DEFAULT 0 NOT NULL,
    amount_based_on_field integer DEFAULT 0 NOT NULL,
    amount_field character varying(140),
    currency character varying(140),
    accept_payment integer DEFAULT 0 NOT NULL,
    payment_button_help text,
    title character varying(140),
    breadcrumbs text,
    login_required integer DEFAULT 0 NOT NULL,
    allow_delete integer DEFAULT 0 NOT NULL,
    max_attachment_size bigint DEFAULT '0'::bigint NOT NULL,
    show_sidebar integer DEFAULT 1 NOT NULL,
    payment_button_label character varying(140) DEFAULT 'Buy Now'::character varying,
    success_message text,
    introduction_text text,
    _liked_by text,
    allow_multiple integer DEFAULT 0 NOT NULL,
    _assign text,
    allow_print integer DEFAULT 0 NOT NULL,
    allow_incomplete integer DEFAULT 0 NOT NULL,
    is_standard integer DEFAULT 0 NOT NULL,
    _comments text,
    module character varying(140),
    _user_tags text,
    doc_type character varying(140),
    allow_comments integer DEFAULT 0 NOT NULL,
    print_format character varying(140),
    route character varying(140),
    amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    success_url character varying(140),
    published integer DEFAULT 0 NOT NULL,
    web_page_link_text character varying(140),
    payment_gateway character varying(140)
);


ALTER TABLE public."tabWeb Form" OWNER TO postgres;

--
-- TOC entry 544 (class 1259 OID 20383)
-- Name: tabWeb Form Field; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabWeb Form Field" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    read_only integer DEFAULT 0 NOT NULL,
    description text,
    "default" character varying(140),
    max_value bigint DEFAULT '0'::bigint NOT NULL,
    label character varying(140),
    max_length bigint DEFAULT '0'::bigint NOT NULL,
    fieldname character varying(140),
    fieldtype character varying(140),
    reqd integer DEFAULT 0 NOT NULL,
    hidden integer DEFAULT 0 NOT NULL,
    options text
);


ALTER TABLE public."tabWeb Form Field" OWNER TO postgres;

--
-- TOC entry 545 (class 1259 OID 20396)
-- Name: tabWeb Page; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabWeb Page" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    insert_style integer DEFAULT 0 NOT NULL,
    header text,
    _liked_by text,
    title character varying(140),
    _comments text,
    text_align character varying(140),
    show_sidebar integer DEFAULT 0 NOT NULL,
    enable_comments integer DEFAULT 0 NOT NULL,
    css text,
    _assign text,
    description text,
    insert_code integer DEFAULT 0 NOT NULL,
    javascript text,
    slideshow character varying(140),
    show_title integer DEFAULT 1 NOT NULL,
    _user_tags text,
    main_section text,
    route character varying(140),
    published integer DEFAULT 0 NOT NULL,
    website_sidebar character varying(140)
);


ALTER TABLE public."tabWeb Page" OWNER TO postgres;

--
-- TOC entry 546 (class 1259 OID 20410)
-- Name: tabWebsite Item Group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabWebsite Item Group" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    item_group character varying(140)
);


ALTER TABLE public."tabWebsite Item Group" OWNER TO postgres;

--
-- TOC entry 547 (class 1259 OID 20418)
-- Name: tabWebsite Sidebar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabWebsite Sidebar" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    _liked_by text,
    title character varying(140),
    _comments text,
    _assign text,
    _user_tags text
);


ALTER TABLE public."tabWebsite Sidebar" OWNER TO postgres;

--
-- TOC entry 548 (class 1259 OID 20426)
-- Name: tabWebsite Sidebar Item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabWebsite Sidebar Item" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    route character varying(140),
    "group" character varying(140),
    title character varying(140)
);


ALTER TABLE public."tabWebsite Sidebar Item" OWNER TO postgres;

--
-- TOC entry 549 (class 1259 OID 20434)
-- Name: tabWebsite Slideshow; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabWebsite Slideshow" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    _liked_by text,
    slideshow_name character varying(140),
    _comments text,
    _assign text,
    header text,
    _user_tags text
);


ALTER TABLE public."tabWebsite Slideshow" OWNER TO postgres;

--
-- TOC entry 550 (class 1259 OID 20442)
-- Name: tabWebsite Slideshow Item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabWebsite Slideshow Item" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    image text,
    description text,
    heading character varying(140)
);


ALTER TABLE public."tabWebsite Slideshow Item" OWNER TO postgres;

--
-- TOC entry 551 (class 1259 OID 20450)
-- Name: tabWebsite Theme; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabWebsite Theme" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    heading_style character varying(140),
    link_color character varying(140),
    module character varying(140) DEFAULT 'Website'::character varying,
    _liked_by text,
    footer_text_color character varying(140),
    heading_webfont character varying(140),
    background_color character varying(140),
    apply_style integer DEFAULT 1 NOT NULL,
    background_image text,
    top_bar_text_color character varying(140),
    _comments text,
    apply_text_styles integer DEFAULT 0 NOT NULL,
    custom integer DEFAULT 1 NOT NULL,
    theme character varying(140),
    footer_color character varying(140),
    css text,
    _assign text,
    text_webfont character varying(140),
    text_color character varying(140),
    js text,
    _user_tags text,
    font_size character varying(140),
    top_bar_color character varying(140),
    bootstrap text
);


ALTER TABLE public."tabWebsite Theme" OWNER TO postgres;

--
-- TOC entry 553 (class 1259 OID 20473)
-- Name: tabWorkflow Action; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabWorkflow Action" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    _comments text,
    workflow_action_name character varying(140),
    _assign text,
    _user_tags text,
    _liked_by text
);


ALTER TABLE public."tabWorkflow Action" OWNER TO postgres;

--
-- TOC entry 554 (class 1259 OID 20481)
-- Name: tabWorkflow Document State; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabWorkflow Document State" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    allow_edit character varying(140),
    update_field character varying(140),
    doc_status character varying(140),
    state character varying(140),
    message text,
    update_value character varying(140)
);


ALTER TABLE public."tabWorkflow Document State" OWNER TO postgres;

--
-- TOC entry 555 (class 1259 OID 20489)
-- Name: tabWorkflow State; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabWorkflow State" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    style character varying(140),
    _liked_by text,
    _user_tags text,
    _assign text,
    _comments text,
    workflow_state_name character varying(140),
    icon character varying(140)
);


ALTER TABLE public."tabWorkflow State" OWNER TO postgres;

--
-- TOC entry 556 (class 1259 OID 20497)
-- Name: tabWorkflow Transition; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabWorkflow Transition" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    action character varying(140),
    state character varying(140),
    next_state character varying(140),
    allowed character varying(140)
);


ALTER TABLE public."tabWorkflow Transition" OWNER TO postgres;

--
-- TOC entry 558 (class 1259 OID 20518)
-- Name: tabWorkstation Working Hour; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tabWorkstation Working Hour" (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    start_time time(6) without time zone,
    enabled integer DEFAULT 1 NOT NULL,
    end_time time(6) without time zone
);


ALTER TABLE public."tabWorkstation Working Hour" OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 16409)
-- Name: tabaccount; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabaccount (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    lft bigint DEFAULT '0'::bigint NOT NULL,
    _liked_by text,
    report_type character varying(140),
    account_name character varying(140),
    freeze_account character varying(140),
    rgt bigint DEFAULT '0'::bigint NOT NULL,
    root_type character varying(140),
    _user_tags text,
    warehouse character varying(140),
    balance_must_be character varying(140),
    account_type character varying(140),
    company character varying(140),
    _assign text,
    is_group integer DEFAULT 0 NOT NULL,
    tax_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    account_currency character varying(140),
    _comments text,
    parent_account character varying(140),
    old_parent character varying(140)
);


ALTER TABLE public.tabaccount OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 16441)
-- Name: tabaddress; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabaddress (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    email_id character varying(140),
    pincode character varying(140),
    county character varying(140),
    is_your_company_address integer DEFAULT 0 NOT NULL,
    address_line2 character varying(140),
    city character varying(140),
    address_line1 character varying(140),
    _comments text,
    is_primary_address integer DEFAULT 0 NOT NULL,
    state character varying(140),
    address_type character varying(140),
    fax character varying(140),
    _liked_by text,
    address_title character varying(140),
    _assign text,
    phone character varying(140),
    _user_tags text,
    country character varying(140),
    is_shipping_address integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.tabaddress OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 16461)
-- Name: tabannouncement; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabannouncement (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    _liked_by text,
    description text,
    _comments text,
    posted_by character varying(140),
    _assign text,
    student_group character varying(140),
    amended_from character varying(140),
    _seen text,
    student character varying(140),
    receiver character varying(140),
    instructor character varying(140),
    _user_tags text,
    subject text
);


ALTER TABLE public.tabannouncement OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 16469)
-- Name: tabappraisal; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabappraisal (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    kra_template character varying(140),
    naming_series character varying(140),
    _user_tags text,
    amended_from character varying(140),
    employee character varying(140),
    company character varying(140),
    start_date date,
    status character varying(140) DEFAULT 'Draft'::character varying,
    _liked_by text,
    end_date date,
    total_score numeric(18,6) DEFAULT 0.000000 NOT NULL,
    _assign text,
    employee_name character varying(140),
    remarks text,
    _comments text
);


ALTER TABLE public.tabappraisal OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16553)
-- Name: tabasset; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabasset (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    expected_value_after_useful_life numeric(18,6) DEFAULT 0.000000 NOT NULL,
    image text,
    journal_entry_for_scrap character varying(140),
    total_number_of_depreciations bigint DEFAULT '0'::bigint NOT NULL,
    is_existing_asset integer DEFAULT 0 NOT NULL,
    _comments text,
    amended_from character varying(140),
    purchase_date date,
    supplier character varying(140),
    status character varying(140) DEFAULT 'Draft'::character varying,
    _liked_by text,
    company character varying(140),
    _assign text,
    purchase_invoice character varying(140),
    item_code character varying(140),
    opening_accumulated_depreciation numeric(18,6) DEFAULT 0.000000 NOT NULL,
    asset_name character varying(140),
    value_after_depreciation numeric(18,6) DEFAULT 0.000000 NOT NULL,
    warehouse character varying(140),
    frequency_of_depreciation bigint DEFAULT '0'::bigint NOT NULL,
    _user_tags text,
    asset_category character varying(140),
    next_depreciation_date date,
    gross_purchase_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    number_of_depreciations_booked bigint DEFAULT '0'::bigint NOT NULL,
    disposal_date date,
    depreciation_method character varying(140)
);


ALTER TABLE public.tabasset OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16597)
-- Name: tabattendance; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabattendance (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    status character varying(140) DEFAULT 'Present'::character varying,
    _assign text,
    _user_tags text,
    naming_series character varying(140),
    company character varying(140),
    employee_name character varying(140),
    amended_from character varying(140),
    leave_type character varying(140),
    _liked_by text,
    _comments text,
    attendance_date date,
    employee character varying(140)
);


ALTER TABLE public.tabattendance OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16645)
-- Name: tabbatch; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabbatch (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    _liked_by text,
    description text,
    _comments text,
    _assign text,
    item character varying(140),
    expiry_date date,
    batch_id character varying(140),
    _user_tags text
);


ALTER TABLE public.tabbatch OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16653)
-- Name: tabbin; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabbin (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    reserved_qty_for_production numeric(18,6) DEFAULT 0.000000 NOT NULL,
    _liked_by text,
    fcfs_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    reserved_qty numeric(18,6) DEFAULT 0.000000 NOT NULL,
    _assign text,
    planned_qty numeric(18,6) DEFAULT 0.000000 NOT NULL,
    ma_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    item_code character varying(140),
    projected_qty numeric(18,6) DEFAULT 0.000000 NOT NULL,
    warehouse character varying(140),
    stock_uom character varying(140),
    _comments text,
    ordered_qty numeric(18,6) DEFAULT 0.000000 NOT NULL,
    indented_qty numeric(18,6) DEFAULT 0.000000 NOT NULL,
    valuation_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    stock_value numeric(18,6) DEFAULT 0.000000 NOT NULL,
    _user_tags text,
    actual_qty numeric(18,6) DEFAULT 0.000000 NOT NULL
);


ALTER TABLE public.tabbin OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 16699)
-- Name: tabblogger; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabblogger (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    bio text,
    _liked_by text,
    short_name character varying(140),
    _comments text,
    _assign text,
    posts bigint DEFAULT '0'::bigint NOT NULL,
    disabled integer DEFAULT 0 NOT NULL,
    "user" character varying(140),
    full_name character varying(140),
    _user_tags text,
    avatar text
);


ALTER TABLE public.tabblogger OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 16709)
-- Name: tabbom; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabbom (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    operating_cost numeric(18,6) DEFAULT 0.000000 NOT NULL,
    image text,
    currency character varying(140),
    conversion_rate numeric(21,9) DEFAULT 0.000000000 NOT NULL,
    _liked_by text,
    base_operating_cost numeric(18,6) DEFAULT 0.000000 NOT NULL,
    base_raw_material_cost numeric(18,6) DEFAULT 0.000000 NOT NULL,
    item character varying(140),
    total_cost numeric(18,6) DEFAULT 0.000000 NOT NULL,
    _comments text,
    amended_from character varying(140),
    base_scrap_material_cost character varying(140),
    scrap_material_cost numeric(18,6) DEFAULT 0.000000 NOT NULL,
    buying_price_list character varying(140),
    company character varying(140),
    uom character varying(140),
    _assign text,
    description text,
    with_operations integer DEFAULT 0 NOT NULL,
    raw_material_cost numeric(18,6) DEFAULT 0.000000 NOT NULL,
    is_active integer DEFAULT 1 NOT NULL,
    is_default integer DEFAULT 1 NOT NULL,
    _user_tags text,
    rm_cost_as_per character varying(140),
    project character varying(140),
    item_name character varying(140),
    quantity numeric(18,6) DEFAULT 1.000000 NOT NULL,
    base_total_cost numeric(18,6) DEFAULT 0.000000 NOT NULL
);


ALTER TABLE public.tabbom OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 16782)
-- Name: tabbranch; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabbranch (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    _comments text,
    _assign text,
    _user_tags text,
    _liked_by text,
    branch character varying(140)
);


ALTER TABLE public.tabbranch OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 16790)
-- Name: tabbrand; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabbrand (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    _liked_by text,
    description text,
    _user_tags text,
    brand character varying(140),
    _assign text,
    _comments text
);


ALTER TABLE public.tabbrand OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 16798)
-- Name: tabbudget; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabbudget (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    monthly_distribution character varying(140),
    _liked_by text,
    amended_from character varying(140),
    budget_against character varying(140) DEFAULT 'Cost Center'::character varying,
    _comments text,
    company character varying(140),
    _assign text,
    fiscal_year character varying(140),
    project character varying(140),
    action_if_annual_budget_exceeded character varying(140) DEFAULT 'Stop'::character varying,
    action_if_accumulated_monthly_budget_exceeded character varying(140) DEFAULT 'Warn'::character varying,
    cost_center character varying(140),
    _user_tags text
);


ALTER TABLE public.tabbudget OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 16838)
-- Name: tabcampaign; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabcampaign (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    _liked_by text,
    _user_tags text,
    description text,
    naming_series character varying(140),
    _assign text,
    campaign_name character varying(140),
    _comments text
);


ALTER TABLE public.tabcampaign OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 16877)
-- Name: tabcommunication; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabcommunication (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    comment_type character varying(140),
    cc text,
    read_receipt integer DEFAULT 0 NOT NULL,
    link_doctype character varying(140),
    timeline_doctype character varying(140),
    sender_full_name character varying(140),
    seen integer DEFAULT 0 NOT NULL,
    email_account character varying(140),
    reference_owner character varying(140),
    subject text,
    reference_doctype character varying(140),
    text_content text,
    _comments text,
    unread_notification_sent integer DEFAULT 0 NOT NULL,
    content text,
    communication_medium character varying(140),
    link_name character varying(140),
    message_id character varying(995),
    status character varying(140),
    _liked_by text,
    recipients text,
    timeline_label character varying(140),
    communication_type character varying(140) DEFAULT 'Communication'::character varying,
    _assign text,
    reference_name character varying(140),
    "user" character varying(140),
    delivery_status character varying(140),
    in_reply_to character varying(140),
    _user_tags text,
    sender character varying(255),
    sent_or_received character varying(140),
    timeline_name character varying(140),
    phone_no character varying(140),
    communication_date timestamp with time zone,
    signature character varying(140)
);


ALTER TABLE public.tabcommunication OWNER TO postgres;

--
-- TOC entry 245 (class 1259 OID 16889)
-- Name: tabcompany; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabcompany (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    website character varying(140),
    default_letter_head character varying(140),
    default_income_account character varying(140),
    default_terms character varying(140),
    create_chart_of_accounts_based_on character varying(140),
    exchange_gain_loss_account character varying(140),
    default_receivable_account character varying(140),
    domain character varying(140),
    cost_center character varying(140),
    registration_details text,
    round_off_account character varying(140),
    existing_company character varying(140),
    _comments text,
    default_expense_account character varying(140),
    depreciation_cost_center character varying(140),
    credit_days bigint DEFAULT '0'::bigint NOT NULL,
    company_name character varying(140),
    expenses_included_in_valuation character varying(140),
    default_bank_account character varying(140),
    default_currency character varying(140),
    email character varying(140),
    fax character varying(140),
    _liked_by text,
    default_holiday_list character varying(140),
    accumulated_depreciation_account character varying(140),
    _assign text,
    write_off_account character varying(140),
    credit_days_based_on character varying(140),
    default_payable_account character varying(140),
    stock_adjustment_account character varying(140),
    abbr character varying(140),
    address text,
    _user_tags text,
    credit_limit numeric(18,6) DEFAULT 0.000000 NOT NULL,
    stock_received_but_not_billed character varying(140),
    country character varying(140),
    chart_of_accounts character varying(140),
    phone_no character varying(140),
    disposal_account character varying(140),
    depreciation_expense_account character varying(140),
    default_cash_account character varying(140),
    round_off_cost_center character varying(140)
);


ALTER TABLE public.tabcompany OWNER TO postgres;

--
-- TOC entry 247 (class 1259 OID 16907)
-- Name: tabcontact; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabcontact (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    last_name character varying(140),
    email_id character varying(140),
    image text,
    mobile_no character varying(140),
    first_name character varying(140),
    _comments text,
    unsubscribed integer DEFAULT 0 NOT NULL,
    department character varying(140),
    status character varying(140) DEFAULT 'Passive'::character varying,
    _liked_by text,
    _assign text,
    phone character varying(140),
    "user" character varying(140),
    _user_tags text,
    designation character varying(140),
    is_primary_contact integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.tabcontact OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 16929)
-- Name: tabcountry; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabcountry (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    date_format character varying(140),
    code character varying(140),
    _comments text,
    _assign text,
    _liked_by text,
    time_zones text,
    country_name character varying(140),
    _user_tags text
);


ALTER TABLE public.tabcountry OWNER TO postgres;

--
-- TOC entry 250 (class 1259 OID 16937)
-- Name: tabcourse; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabcourse (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    default_grading_scale character varying(140),
    _liked_by text,
    course_name character varying(140),
    _user_tags text,
    _assign text,
    course_intro text,
    course_abbreviation character varying(140),
    department character varying(140),
    course_code character varying(140),
    _comments text
);


ALTER TABLE public.tabcourse OWNER TO postgres;

--
-- TOC entry 253 (class 1259 OID 16963)
-- Name: tabcurrency; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabcurrency (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    fraction_units bigint DEFAULT '0'::bigint NOT NULL,
    _liked_by text,
    _comments text,
    symbol character varying(140),
    _assign text,
    enabled integer DEFAULT 0 NOT NULL,
    smallest_currency_fraction_value numeric(18,6) DEFAULT 0.000000 NOT NULL,
    currency_name character varying(140),
    fraction character varying(140),
    _user_tags text,
    number_format character varying(140)
);


ALTER TABLE public.tabcurrency OWNER TO postgres;

--
-- TOC entry 258 (class 1259 OID 17043)
-- Name: tabcustomer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabcustomer (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    status character varying(140) DEFAULT 'Active'::character varying,
    customer_details text,
    image text,
    disabled integer DEFAULT 0 NOT NULL,
    lead_name character varying(140),
    default_currency character varying(140),
    _comments text,
    default_sales_partner character varying(140),
    default_price_list character varying(140),
    credit_days bigint DEFAULT '0'::bigint NOT NULL,
    naming_series character varying(140),
    customer_name character varying(140),
    website character varying(140),
    _liked_by text,
    default_commission_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    _assign text,
    credit_days_based_on character varying(140),
    _user_tags text,
    tax_id character varying(140),
    credit_limit numeric(18,6) DEFAULT 0.000000 NOT NULL,
    language character varying(140),
    customer_group character varying(140),
    territory character varying(140),
    customer_type character varying(140),
    is_frozen integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.tabcustomer OWNER TO postgres;

--
-- TOC entry 263 (class 1259 OID 17115)
-- Name: tabdefaultvalue; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabdefaultvalue (
    name character varying(255) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(255),
    owner character varying(255),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(255),
    parentfield character varying(255),
    parenttype character varying(255),
    idx integer DEFAULT 0 NOT NULL,
    defvalue text,
    defkey character varying(140)
);


ALTER TABLE public.tabdefaultvalue OWNER TO postgres;

--
-- TOC entry 267 (class 1259 OID 17192)
-- Name: tabdepartment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabdepartment (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    leave_block_list character varying(140),
    _liked_by text,
    _user_tags text,
    _assign text,
    department_name character varying(140),
    _comments text
);


ALTER TABLE public.tabdepartment OWNER TO postgres;

--
-- TOC entry 270 (class 1259 OID 17218)
-- Name: tabdesignation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabdesignation (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    _liked_by text,
    description text,
    designation_name character varying(140),
    _assign text,
    _comments text,
    _user_tags text
);


ALTER TABLE public.tabdesignation OWNER TO postgres;

--
-- TOC entry 272 (class 1259 OID 17240)
-- Name: tabdiscussion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabdiscussion (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    _liked_by text,
    description text,
    course character varying(140),
    _comments text,
    _assign text,
    amended_from character varying(140),
    _seen text,
    _user_tags text,
    subject character varying(140)
);


ALTER TABLE public.tabdiscussion OWNER TO postgres;

--
-- TOC entry 273 (class 1259 OID 17248)
-- Name: tabdocfield; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabdocfield (
    name character varying(255) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(255),
    owner character varying(255),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(255),
    parentfield character varying(255),
    parenttype character varying(255),
    idx integer DEFAULT 0 NOT NULL,
    fieldname character varying(140),
    label character varying(140),
    oldfieldname character varying(140),
    fieldtype character varying(140) DEFAULT 'Data'::character varying,
    oldfieldtype character varying(140),
    options text,
    search_index integer DEFAULT 0 NOT NULL,
    hidden integer DEFAULT 0 NOT NULL,
    set_only_once integer DEFAULT 0 NOT NULL,
    print_hide integer DEFAULT 0 NOT NULL,
    report_hide integer DEFAULT 0 NOT NULL,
    reqd integer DEFAULT 0 NOT NULL,
    bold integer DEFAULT 0 NOT NULL,
    collapsible integer DEFAULT 0 NOT NULL,
    "unique" integer DEFAULT 0 NOT NULL,
    no_copy integer DEFAULT 0 NOT NULL,
    allow_on_submit integer DEFAULT 0 NOT NULL,
    trigger character varying(255),
    collapsible_depends_on text,
    depends_on text,
    permlevel bigint DEFAULT '0'::bigint NOT NULL,
    ignore_user_permissions integer DEFAULT 0 NOT NULL,
    width character varying(140),
    print_width character varying(140),
    columns bigint DEFAULT '0'::bigint NOT NULL,
    "default" text,
    description text,
    in_filter integer DEFAULT 0 NOT NULL,
    in_list_view integer DEFAULT 0 NOT NULL,
    in_standard_filter integer DEFAULT 0 NOT NULL,
    read_only integer DEFAULT 0 NOT NULL,
    "precision" character varying(140),
    length bigint DEFAULT '0'::bigint NOT NULL,
    ignore_xss_filter integer DEFAULT 0 NOT NULL,
    print_hide_if_no_value integer DEFAULT 0 NOT NULL,
    remember_last_selected_value integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.tabdocfield OWNER TO postgres;

--
-- TOC entry 274 (class 1259 OID 17279)
-- Name: tabdocperm; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabdocperm (
    name character varying(255) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(255),
    owner character varying(255),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(255),
    parentfield character varying(255),
    parenttype character varying(255),
    idx integer DEFAULT 0 NOT NULL,
    permlevel bigint DEFAULT '0'::bigint,
    role character varying(140),
    match character varying(255),
    read integer DEFAULT 1 NOT NULL,
    write integer DEFAULT 1 NOT NULL,
    "create" integer DEFAULT 1 NOT NULL,
    submit integer DEFAULT 0 NOT NULL,
    cancel integer DEFAULT 0 NOT NULL,
    delete integer DEFAULT 1 NOT NULL,
    amend integer DEFAULT 0 NOT NULL,
    report integer DEFAULT 1 NOT NULL,
    export integer DEFAULT 1 NOT NULL,
    import integer DEFAULT 0 NOT NULL,
    share integer DEFAULT 1 NOT NULL,
    print integer DEFAULT 1 NOT NULL,
    email integer DEFAULT 1 NOT NULL,
    user_permission_doctypes text,
    set_user_permissions integer DEFAULT 0 NOT NULL,
    apply_user_permissions integer DEFAULT 0 NOT NULL,
    if_owner integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.tabdocperm OWNER TO postgres;

--
-- TOC entry 275 (class 1259 OID 17304)
-- Name: tabdocshare; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabdocshare (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    everyone integer DEFAULT 0 NOT NULL,
    share_name character varying(140),
    read integer DEFAULT 0 NOT NULL,
    _comments text,
    _assign text,
    share integer DEFAULT 0 NOT NULL,
    write integer DEFAULT 0 NOT NULL,
    _liked_by text,
    "user" character varying(140),
    share_doctype character varying(140),
    _user_tags text
);


ALTER TABLE public.tabdocshare OWNER TO postgres;

--
-- TOC entry 276 (class 1259 OID 17316)
-- Name: tabdoctype; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabdoctype (
    name character varying(255) DEFAULT ''::character varying NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(255),
    owner character varying(255),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(255),
    parentfield character varying(255),
    parenttype character varying(255),
    idx integer DEFAULT 0 NOT NULL,
    search_fields character varying(140),
    issingle integer DEFAULT 0 NOT NULL,
    istable integer DEFAULT 0 NOT NULL,
    editable_grid integer DEFAULT 1 NOT NULL,
    track_changes integer DEFAULT 1 NOT NULL,
    module character varying(140),
    app character varying(140),
    autoname character varying(140),
    name_case character varying(140),
    title_field character varying(140),
    image_field character varying(140),
    timeline_field character varying(140),
    sort_field character varying(140) DEFAULT 'modified'::character varying,
    sort_order character varying(140) DEFAULT 'DESC'::character varying,
    description text,
    colour character varying(255),
    read_only integer DEFAULT 0 NOT NULL,
    in_create integer DEFAULT 0 NOT NULL,
    menu_index bigint,
    parent_node character varying(255),
    smallicon character varying(255),
    allow_copy integer DEFAULT 0 NOT NULL,
    allow_rename integer DEFAULT 0 NOT NULL,
    allow_import integer DEFAULT 0 NOT NULL,
    hide_toolbar integer DEFAULT 0 NOT NULL,
    hide_heading integer DEFAULT 0 NOT NULL,
    track_seen integer DEFAULT 0 NOT NULL,
    max_attachments bigint DEFAULT '0'::bigint NOT NULL,
    print_outline character varying(255),
    read_only_onload integer DEFAULT 0 NOT NULL,
    in_dialog integer DEFAULT 0 NOT NULL,
    document_type character varying(140),
    icon character varying(140),
    tag_fields character varying(255),
    subject character varying(255),
    _last_update character varying(32),
    engine character varying(140) DEFAULT 'InnoDB'::character varying,
    default_print_format character varying(140),
    is_submittable integer DEFAULT 0 NOT NULL,
    _user_tags text,
    custom integer DEFAULT 0 NOT NULL,
    beta integer DEFAULT 0 NOT NULL,
    image_view integer DEFAULT 0 NOT NULL,
    _comments text,
    _liked_by text,
    _assign text,
    quick_entry integer DEFAULT 1 NOT NULL
);


ALTER TABLE public.tabdoctype OWNER TO postgres;

--
-- TOC entry 289 (class 1259 OID 17496)
-- Name: tabemployee; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabemployee (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    status character varying(140) DEFAULT 'Active'::character varying,
    marital_status character varying(140),
    feedback text,
    permanent_accommodation_type character varying(140),
    blood_group character varying(140),
    naming_series character varying(140),
    image text,
    reason_for_leaving character varying(140),
    _liked_by text,
    holiday_list character varying(140),
    relation character varying(140),
    prefered_email character varying(140),
    salutation character varying(140),
    held_on date,
    permanent_address text,
    company_email character varying(140),
    prefered_contact_email character varying(140),
    user_id character varying(140),
    bank_name character varying(140),
    resignation_letter_date date,
    employee_number character varying(140),
    encashment_date date,
    _comments text,
    employment_type character varying(140),
    personal_email character varying(140),
    reports_to character varying(140),
    date_of_issue date,
    date_of_birth date,
    new_workplace character varying(140),
    current_accommodation_type character varying(140),
    employee character varying(140),
    unsubscribed integer DEFAULT 0 NOT NULL,
    bio text,
    _assign text,
    branch character varying(140),
    scheduled_confirmation_date date,
    company character varying(140),
    family_background text,
    leave_encashed character varying(140),
    bank_ac_no character varying(140),
    department character varying(140),
    person_to_be_contacted character varying(140),
    date_of_joining date,
    employee_name character varying(140),
    final_confirmation_date date,
    place_of_issue character varying(140),
    salary_mode character varying(140),
    _user_tags text,
    current_address text,
    passport_number character varying(140),
    designation character varying(140),
    cell_number character varying(140),
    gender character varying(140),
    valid_upto date,
    contract_end_date date,
    notice_number_of_days bigint DEFAULT '0'::bigint NOT NULL,
    emergency_phone_number character varying(140),
    reason_for_resignation character varying(140),
    health_details text,
    relieving_date date,
    date_of_retirement date
);


ALTER TABLE public.tabemployee OWNER TO postgres;

--
-- TOC entry 298 (class 1259 OID 17576)
-- Name: tabevent; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabevent (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    event_type character varying(140),
    tuesday integer DEFAULT 0 NOT NULL,
    wednesday integer DEFAULT 0 NOT NULL,
    _liked_by text,
    thursday integer DEFAULT 0 NOT NULL,
    saturday integer DEFAULT 0 NOT NULL,
    subject character varying(140),
    repeat_this_event integer DEFAULT 0 NOT NULL,
    _comments text,
    repeat_till date,
    sunday integer DEFAULT 0 NOT NULL,
    send_reminder integer DEFAULT 1 NOT NULL,
    ref_type character varying(140),
    ref_name character varying(140),
    _assign text,
    description text,
    monday integer DEFAULT 0 NOT NULL,
    friday integer DEFAULT 0 NOT NULL,
    _seen text,
    _user_tags text,
    all_day integer DEFAULT 0 NOT NULL,
    starts_on timestamp with time zone,
    ends_on timestamp with time zone,
    repeat_on character varying(140)
);


ALTER TABLE public.tabevent OWNER TO postgres;

--
-- TOC entry 307 (class 1259 OID 17668)
-- Name: tabfees; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabfees (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    academic_year character varying(140),
    naming_series character varying(140),
    academic_term character varying(140),
    program_enrollment character varying(140),
    paid_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    _user_tags text,
    amended_from character varying(140),
    program character varying(140),
    student_name character varying(140),
    due_date date,
    _liked_by text,
    fee_structure character varying(140),
    _assign text,
    outstanding_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    student character varying(140),
    _comments text,
    student_category character varying(140),
    total_amount numeric(18,6) DEFAULT 0.000000 NOT NULL
);


ALTER TABLE public.tabfees OWNER TO postgres;

--
-- TOC entry 308 (class 1259 OID 17679)
-- Name: tabfile; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabfile (
    name character varying(255) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(255),
    owner character varying(255),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(255),
    parentfield character varying(255),
    parenttype character varying(255),
    idx integer DEFAULT 0 NOT NULL,
    file_name character varying(140),
    file_url text,
    module character varying(255),
    attached_to_name character varying(140),
    file_size bigint DEFAULT '0'::bigint NOT NULL,
    attached_to_doctype character varying(140),
    lft bigint DEFAULT '0'::bigint NOT NULL,
    is_attachments_folder integer DEFAULT 0 NOT NULL,
    is_folder integer DEFAULT 0 NOT NULL,
    content_hash character varying(140),
    rgt bigint DEFAULT '0'::bigint NOT NULL,
    _comments text,
    is_home_folder integer DEFAULT 0 NOT NULL,
    folder character varying(140),
    _liked_by text,
    _assign text,
    _user_tags text,
    is_private integer DEFAULT 0 NOT NULL,
    old_parent character varying(140),
    thumbnail_url text
);


ALTER TABLE public.tabfile OWNER TO postgres;

--
-- TOC entry 317 (class 1259 OID 17765)
-- Name: tabguardian; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabguardian (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    _liked_by text,
    designation character varying(140),
    guardian_name character varying(140),
    _user_tags text,
    image text,
    _assign text,
    alternate_number character varying(140),
    date_of_birth date,
    _comments text,
    work_address text,
    mobile_number character varying(140),
    occupation character varying(140),
    education character varying(140),
    email_address character varying(140)
);


ALTER TABLE public.tabguardian OWNER TO postgres;

--
-- TOC entry 321 (class 1259 OID 17802)
-- Name: tabholiday; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabholiday (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    holiday_date date,
    description text
);


ALTER TABLE public.tabholiday OWNER TO postgres;

--
-- TOC entry 327 (class 1259 OID 17852)
-- Name: tabinstructor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabinstructor (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    _liked_by text,
    naming_series character varying(140),
    image text,
    _assign text,
    employee character varying(140),
    _comments text,
    department character varying(140),
    instructor_name character varying(140),
    _user_tags text
);


ALTER TABLE public.tabinstructor OWNER TO postgres;

--
-- TOC entry 331 (class 1259 OID 17886)
-- Name: tabinterest; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabinterest (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    _comments text,
    _assign text,
    _user_tags text,
    _liked_by text,
    interest character varying(140)
);


ALTER TABLE public.tabinterest OWNER TO postgres;

--
-- TOC entry 332 (class 1259 OID 17894)
-- Name: tabissue; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabissue (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    naming_series character varying(140),
    mins_to_first_response numeric(18,6) DEFAULT 0.000000 NOT NULL,
    opening_date date,
    subject character varying(140),
    raised_by character varying(140),
    first_responded_on timestamp with time zone,
    lead character varying(140),
    _comments text,
    attachment text,
    opening_time time(6) without time zone,
    customer_name character varying(140),
    status character varying(140) DEFAULT 'Open'::character varying,
    customer character varying(140),
    _liked_by text,
    description text,
    company character varying(140),
    _assign text,
    _seen text,
    content_type character varying(140),
    resolution_details text,
    _user_tags text,
    resolution_date timestamp with time zone,
    project character varying(140),
    contact character varying(140)
);


ALTER TABLE public.tabissue OWNER TO postgres;

--
-- TOC entry 333 (class 1259 OID 17904)
-- Name: tabitem; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabitem (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    default_supplier character varying(140),
    selling_cost_center character varying(140),
    net_weight numeric(18,6) DEFAULT 0.000000 NOT NULL,
    expense_account character varying(140),
    max_discount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    income_account character varying(140),
    item_name character varying(140),
    website_warehouse character varying(140),
    default_material_request_type character varying(140) DEFAULT 'Purchase'::character varying,
    _assign text,
    disabled integer DEFAULT 0 NOT NULL,
    tolerance numeric(18,6) DEFAULT 0.000000 NOT NULL,
    item_group character varying(140),
    web_long_description text,
    valuation_method character varying(140),
    variant_of character varying(140),
    has_variants integer DEFAULT 0 NOT NULL,
    default_warehouse character varying(140),
    inspection_required_before_delivery integer DEFAULT 0 NOT NULL,
    is_sales_item integer DEFAULT 1 NOT NULL,
    is_sub_contracted_item integer DEFAULT 0 NOT NULL,
    thumbnail character varying(140),
    customer_code character varying(140),
    barcode character varying(140),
    is_stock_item integer DEFAULT 1 NOT NULL,
    _user_tags text,
    manufacturer character varying(140),
    route text,
    min_order_qty numeric(18,6) DEFAULT 0.000000 NOT NULL,
    valuation_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    image text,
    last_purchase_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    _comments text,
    brand character varying(140),
    slideshow character varying(140),
    item_code character varying(140),
    show_in_website integer DEFAULT 0 NOT NULL,
    is_purchase_item integer DEFAULT 1 NOT NULL,
    safety_stock numeric(18,6) DEFAULT 0.000000 NOT NULL,
    weight_uom character varying(140),
    warranty_period character varying(140),
    manufacturer_part_no character varying(140),
    delivered_by_supplier integer DEFAULT 0 NOT NULL,
    serial_no_series character varying(140),
    naming_series character varying(140),
    website_image text,
    buying_cost_center character varying(140),
    publish_in_hub integer DEFAULT 0 NOT NULL,
    end_of_life date DEFAULT '2099-12-31'::date,
    synced_with_hub integer DEFAULT 0 NOT NULL,
    stock_uom character varying(140),
    show_variant_in_website integer DEFAULT 0 NOT NULL,
    _liked_by text,
    description text,
    asset_category character varying(140),
    default_bom character varying(140),
    weightage bigint DEFAULT '0'::bigint NOT NULL,
    total_projected_qty numeric(18,6) DEFAULT 0.000000 NOT NULL,
    lead_time_days bigint DEFAULT '0'::bigint NOT NULL,
    opening_stock numeric(18,6) DEFAULT 0.000000 NOT NULL,
    has_batch_no integer DEFAULT 0 NOT NULL,
    has_serial_no integer DEFAULT 0 NOT NULL,
    standard_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    is_fixed_asset integer DEFAULT 0 NOT NULL,
    inspection_required_before_purchase integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.tabitem OWNER TO postgres;

--
-- TOC entry 356 (class 1259 OID 18162)
-- Name: tablanguage; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tablanguage (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    _assign text,
    _comments text,
    language_code character varying(140),
    flag character varying(140),
    _liked_by text,
    based_on character varying(140),
    language_name character varying(140),
    _user_tags text
);


ALTER TABLE public.tablanguage OWNER TO postgres;

--
-- TOC entry 357 (class 1259 OID 18170)
-- Name: tablead; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tablead (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    website character varying(140),
    email_id character varying(140),
    image text,
    mobile_no character varying(140),
    campaign_name character varying(140),
    lead_name character varying(140),
    type character varying(140),
    _comments text,
    source character varying(140),
    contact_by character varying(140),
    company_name character varying(140),
    naming_series character varying(140),
    territory character varying(140),
    status character varying(140) DEFAULT 'Lead'::character varying,
    fax character varying(140),
    _liked_by text,
    company character varying(140),
    _assign text,
    market_segment character varying(140),
    lead_owner character varying(140),
    phone character varying(140),
    request_type character varying(140),
    _user_tags text,
    customer character varying(140),
    blog_subscriber integer DEFAULT 0 NOT NULL,
    industry character varying(140),
    unsubscribed integer DEFAULT 0 NOT NULL,
    contact_date timestamp with time zone
);


ALTER TABLE public.tablead OWNER TO postgres;

--
-- TOC entry 371 (class 1259 OID 18306)
-- Name: tabmanufacturer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabmanufacturer (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    website character varying(140),
    _liked_by text,
    short_name character varying(140),
    _comments text,
    notes text,
    _assign text,
    data_6 character varying(140),
    full_name character varying(140),
    logo text,
    _user_tags text
);


ALTER TABLE public.tabmanufacturer OWNER TO postgres;

--
-- TOC entry 379 (class 1259 OID 18379)
-- Name: tabnewsletter; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabnewsletter (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    _liked_by text,
    _assign text,
    send_from character varying(140),
    scheduled_to_send bigint DEFAULT '0'::bigint NOT NULL,
    email_sent integer DEFAULT 0 NOT NULL,
    _comments text,
    message text,
    email_group character varying(140),
    _user_tags text,
    test_email_id character varying(140),
    subject text
);


ALTER TABLE public.tabnewsletter OWNER TO postgres;

--
-- TOC entry 380 (class 1259 OID 18389)
-- Name: tabnote; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabnote (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    content text,
    _liked_by text,
    expire_notification_on date,
    title character varying(140),
    _comments text,
    _assign text,
    notify_on_login integer DEFAULT 0 NOT NULL,
    _user_tags text,
    public integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.tabnote OWNER TO postgres;

--
-- TOC entry 388 (class 1259 OID 18458)
-- Name: taboperation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.taboperation (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    workstation character varying(140),
    _liked_by text,
    description text,
    _user_tags text,
    _assign text,
    _comments text
);


ALTER TABLE public.taboperation OWNER TO postgres;

--
-- TOC entry 389 (class 1259 OID 18466)
-- Name: tabopportunity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabopportunity (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    address_display text,
    campaign character varying(140),
    naming_series character varying(140),
    mins_to_first_response numeric(18,6) DEFAULT 0.000000 NOT NULL,
    enquiry_type character varying(140) DEFAULT 'Sales'::character varying,
    enquiry_from character varying(140),
    customer_name character varying(140),
    lead character varying(140),
    amended_from character varying(140),
    _comments text,
    source character varying(140),
    contact_by character varying(140),
    transaction_date date,
    contact_display text,
    territory character varying(140),
    status character varying(140) DEFAULT 'Open'::character varying,
    _liked_by text,
    company character varying(140),
    _assign text,
    customer_address character varying(140),
    _seen text,
    contact_email character varying(140),
    contact_mobile text,
    _user_tags text,
    customer character varying(140),
    order_lost_reason text,
    customer_group character varying(140),
    title character varying(140),
    with_items integer DEFAULT 0 NOT NULL,
    to_discuss text,
    contact_person character varying(140),
    contact_date timestamp with time zone
);


ALTER TABLE public.tabopportunity OWNER TO postgres;

--
-- TOC entry 394 (class 1259 OID 18521)
-- Name: tabpage; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabpage (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    _liked_by text,
    title character varying(140),
    _comments text,
    _assign text,
    module character varying(140),
    standard character varying(140),
    page_name character varying(140),
    _user_tags text,
    icon character varying(140)
);


ALTER TABLE public.tabpage OWNER TO postgres;

--
-- TOC entry 424 (class 1259 OID 18844)
-- Name: tabprogram; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabprogram (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    _liked_by text,
    _comments text,
    _assign text,
    program_code character varying(140),
    department character varying(140),
    program_name character varying(140),
    program_abbreviation character varying(140),
    _user_tags text
);


ALTER TABLE public.tabprogram OWNER TO postgres;

--
-- TOC entry 430 (class 1259 OID 18895)
-- Name: tabproject; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabproject (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    total_expense_claim numeric(18,6) DEFAULT 0.000000 NOT NULL,
    _liked_by text,
    per_gross_margin numeric(18,6) DEFAULT 0.000000 NOT NULL,
    project_type character varying(140),
    cost_center character varying(140),
    actual_start_date character varying(140),
    _comments text,
    actual_end_date date,
    total_costing_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    priority character varying(140),
    total_purchase_cost numeric(18,6) DEFAULT 0.000000 NOT NULL,
    company character varying(140),
    status character varying(140) DEFAULT 'Open'::character varying,
    total_billing_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    project_name character varying(140),
    percent_complete_method character varying(140) DEFAULT 'Task Completion'::character varying,
    estimated_costing numeric(18,6) DEFAULT 0.000000 NOT NULL,
    is_active character varying(140),
    expected_end_date date,
    gross_margin numeric(18,6) DEFAULT 0.000000 NOT NULL,
    _assign text,
    _seen text,
    percent_complete numeric(18,6) DEFAULT 0.000000 NOT NULL,
    _user_tags text,
    customer character varying(140),
    sales_order character varying(140),
    expected_start_date date,
    notes text,
    actual_time numeric(18,6) DEFAULT 0.000000 NOT NULL
);


ALTER TABLE public.tabproject OWNER TO postgres;

--
-- TOC entry 447 (class 1259 OID 19226)
-- Name: tabquotation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabquotation (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    additional_discount_percentage numeric(18,6) DEFAULT 0.000000 NOT NULL,
    base_in_words character varying(140),
    enq_det text,
    campaign character varying(140),
    contact_email character varying(140),
    naming_series character varying(140),
    contact_mobile text,
    currency character varying(140),
    conversion_rate numeric(21,9) DEFAULT 0.000000000 NOT NULL,
    _liked_by text,
    total numeric(18,6) DEFAULT 0.000000 NOT NULL,
    shipping_rule character varying(140),
    customer_name character varying(140),
    taxes_and_charges character varying(140),
    select_print_heading character varying(140),
    order_type character varying(140) DEFAULT 'Sales'::character varying,
    lead character varying(140),
    price_list_currency character varying(140),
    _user_tags text,
    base_total numeric(18,6) DEFAULT 0.000000 NOT NULL,
    selling_price_list character varying(140),
    supplier_quotation character varying(140),
    tc_name character varying(140),
    source character varying(140),
    transaction_date date,
    contact_display text,
    ignore_pricing_rule integer DEFAULT 0 NOT NULL,
    territory character varying(140),
    company character varying(140),
    address_display text,
    _assign text,
    terms text,
    amended_from character varying(140),
    base_rounded_total numeric(18,6) DEFAULT 0.000000 NOT NULL,
    customer_group character varying(140),
    quotation_to character varying(140) DEFAULT 'Customer'::character varying,
    grand_total numeric(18,6) DEFAULT 0.000000 NOT NULL,
    base_discount_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    customer_address character varying(140),
    base_total_taxes_and_charges numeric(18,6) DEFAULT 0.000000 NOT NULL,
    _comments text,
    base_grand_total numeric(18,6) DEFAULT 0.000000 NOT NULL,
    discount_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    customer character varying(140),
    order_lost_reason text,
    base_net_total numeric(18,6) DEFAULT 0.000000 NOT NULL,
    language character varying(140),
    rounded_total numeric(18,6) DEFAULT 0.000000 NOT NULL,
    shipping_address_name character varying(140),
    title character varying(140) DEFAULT '{customer_name}'::character varying,
    letter_head character varying(140),
    plc_conversion_rate numeric(21,9) DEFAULT 0.000000000 NOT NULL,
    net_total numeric(18,6) DEFAULT 0.000000 NOT NULL,
    status character varying(140) DEFAULT 'Draft'::character varying,
    shipping_address text,
    apply_discount_on character varying(140) DEFAULT 'Grand Total'::character varying,
    contact_person character varying(140),
    in_words character varying(140),
    total_taxes_and_charges numeric(18,6) DEFAULT 0.000000 NOT NULL
);


ALTER TABLE public.tabquotation OWNER TO postgres;

--
-- TOC entry 450 (class 1259 OID 19288)
-- Name: tabreport; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabreport (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    apply_user_permissions integer DEFAULT 1 NOT NULL,
    ref_doctype character varying(140),
    report_type character varying(140),
    _assign text,
    _comments text,
    javascript text,
    letter_head character varying(140),
    module character varying(140),
    report_name character varying(140),
    disabled integer DEFAULT 0 NOT NULL,
    json text,
    is_standard character varying(140),
    add_total_row integer DEFAULT 0 NOT NULL,
    query text,
    _user_tags text,
    _liked_by text
);


ALTER TABLE public.tabreport OWNER TO postgres;

--
-- TOC entry 454 (class 1259 OID 19326)
-- Name: tabrole; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabrole (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    _liked_by text,
    desk_access integer DEFAULT 1 NOT NULL,
    _user_tags text,
    _assign text,
    disabled integer DEFAULT 0 NOT NULL,
    role_name character varying(140),
    _comments text
);


ALTER TABLE public.tabrole OWNER TO postgres;

--
-- TOC entry 455 (class 1259 OID 19336)
-- Name: tabroom; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabroom (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    _liked_by text,
    room_name character varying(140),
    _assign text,
    seating_capacity character varying(140),
    _comments text,
    room_number character varying(140),
    _user_tags text
);


ALTER TABLE public.tabroom OWNER TO postgres;

--
-- TOC entry 476 (class 1259 OID 19673)
-- Name: tabseries; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabseries (
    name character varying(100),
    current bigint DEFAULT '0'::bigint NOT NULL
);


ALTER TABLE public.tabseries OWNER TO postgres;

--
-- TOC entry 477 (class 1259 OID 19677)
-- Name: tabsessions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabsessions (
    "user" character varying(255),
    sid character varying(255),
    sessiondata text,
    ipaddress character varying(16),
    lastupdate timestamp with time zone,
    device character varying(255) DEFAULT 'desktop'::character varying,
    status character varying(20)
);


ALTER TABLE public.tabsessions OWNER TO postgres;

--
-- TOC entry 481 (class 1259 OID 19714)
-- Name: tabsingles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabsingles (
    doctype character varying(255),
    field character varying(255),
    value text
);


ALTER TABLE public.tabsingles OWNER TO postgres;

--
-- TOC entry 490 (class 1259 OID 19820)
-- Name: tabstudent; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabstudent (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    last_name character varying(140),
    blood_group character varying(140),
    naming_series character varying(140),
    image text,
    pincode character varying(140),
    student_mobile_number character varying(140),
    student_email_id character varying(140),
    city character varying(140),
    first_name character varying(140),
    middle_name character varying(140),
    title character varying(140),
    _comments text,
    state character varying(140),
    date_of_birth date,
    student_applicant character varying(140),
    _liked_by text,
    _assign text,
    nationality character varying(140),
    _user_tags text,
    joining_date date,
    gender character varying(140),
    address_line_2 character varying(140),
    address_line_1 character varying(140)
);


ALTER TABLE public.tabstudent OWNER TO postgres;

--
-- TOC entry 507 (class 1259 OID 19966)
-- Name: tabsupplier; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabsupplier (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    website character varying(140),
    naming_series character varying(140),
    image text,
    disabled integer DEFAULT 0 NOT NULL,
    default_currency character varying(140),
    _comments text,
    credit_days bigint DEFAULT '0'::bigint NOT NULL,
    status character varying(140),
    _liked_by text,
    _assign text,
    credit_days_based_on character varying(140),
    supplier_name character varying(140),
    supplier_type character varying(140),
    _user_tags text,
    language character varying(140),
    country character varying(140),
    default_price_list character varying(140),
    is_frozen integer DEFAULT 0 NOT NULL,
    supplier_details text
);


ALTER TABLE public.tabsupplier OWNER TO postgres;

--
-- TOC entry 511 (class 1259 OID 20039)
-- Name: tabtag; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabtag (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    tag_name character varying(140)
);


ALTER TABLE public.tabtag OWNER TO postgres;

--
-- TOC entry 515 (class 1259 OID 20073)
-- Name: tabtask; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabtask (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    status character varying(140),
    exp_end_date date,
    review_date date,
    total_expense_claim numeric(18,6) DEFAULT 0.000000 NOT NULL,
    expected_time numeric(18,6) DEFAULT 0.000000 NOT NULL,
    subject character varying(140),
    act_end_date date,
    task_weight numeric(18,6) DEFAULT 0.000000 NOT NULL,
    depends_on_tasks character varying(140),
    total_costing_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    priority character varying(140),
    progress numeric(18,6) DEFAULT 0.000000 NOT NULL,
    total_billing_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    _liked_by text,
    description text,
    company character varying(140),
    _assign text,
    _seen text,
    _comments text,
    act_start_date date,
    _user_tags text,
    closing_date date,
    project character varying(140),
    exp_start_date date,
    actual_time numeric(18,6) DEFAULT 0.000000 NOT NULL
);


ALTER TABLE public.tabtask OWNER TO postgres;

--
-- TOC entry 519 (class 1259 OID 20116)
-- Name: tabterritory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabterritory (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    _liked_by text,
    rgt bigint DEFAULT '0'::bigint NOT NULL,
    distribution_id character varying(140),
    _comments text,
    _assign text,
    is_group integer DEFAULT 0 NOT NULL,
    territory_name character varying(140),
    old_parent character varying(140),
    lft bigint DEFAULT '0'::bigint NOT NULL,
    parent_territory character varying(140),
    _user_tags text,
    territory_manager character varying(140)
);


ALTER TABLE public.tabterritory OWNER TO postgres;

--
-- TOC entry 520 (class 1259 OID 20127)
-- Name: tabtimesheet; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabtimesheet (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    naming_series character varying(140),
    _liked_by text,
    total_billable_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    _comments text,
    total_costing_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    note text,
    amended_from character varying(140),
    employee character varying(140),
    total_billable_hours numeric(18,6) DEFAULT 0.000000 NOT NULL,
    start_date date,
    status character varying(140) DEFAULT 'Draft'::character varying,
    total_billed_amount numeric(18,6) DEFAULT 0.000000 NOT NULL,
    end_date date,
    company character varying(140),
    _assign text,
    per_billed numeric(18,6) DEFAULT 0.000000 NOT NULL,
    salary_slip character varying(140),
    total_billed_hours numeric(18,6) DEFAULT 0.000000 NOT NULL,
    "user" character varying(140),
    employee_name character varying(140),
    _user_tags text,
    sales_invoice character varying(140),
    total_hours numeric(18,6) DEFAULT 0.000000 NOT NULL,
    production_order character varying(140)
);


ALTER TABLE public.tabtimesheet OWNER TO postgres;

--
-- TOC entry 522 (class 1259 OID 20159)
-- Name: tabtodo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabtodo (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    status character varying(140) DEFAULT 'Open'::character varying,
    sender character varying(140),
    assigned_by character varying(140),
    _seen text,
    reference_name character varying(140),
    reference_type character varying(140),
    priority character varying(140) DEFAULT 'Medium'::character varying,
    date date,
    _assign text,
    _liked_by text,
    role character varying(140),
    assigned_by_full_name character varying(140),
    _user_tags text,
    _comments text,
    description text
);


ALTER TABLE public.tabtodo OWNER TO postgres;

--
-- TOC entry 524 (class 1259 OID 20178)
-- Name: tabtopic; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabtopic (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    _assign text,
    introduction text,
    _comments text,
    topic_name character varying(140),
    content text,
    course character varying(140),
    _liked_by text,
    _user_tags text
);


ALTER TABLE public.tabtopic OWNER TO postgres;

--
-- TOC entry 530 (class 1259 OID 20229)
-- Name: tabtranslation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabtranslation (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    _liked_by text,
    source_name text,
    language character varying(140),
    target_name text,
    _comments text,
    _assign text,
    _user_tags text
);


ALTER TABLE public.tabtranslation OWNER TO postgres;

--
-- TOC entry 532 (class 1259 OID 20245)
-- Name: tabuom; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabuom (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    uom_name character varying(140),
    _liked_by text,
    _comments text,
    _assign text,
    must_be_whole_number integer DEFAULT 0 NOT NULL,
    _user_tags text
);


ALTER TABLE public.tabuom OWNER TO postgres;

--
-- TOC entry 534 (class 1259 OID 20263)
-- Name: tabuser; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabuser (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    user_image text,
    _liked_by text,
    full_name character varying(140),
    frappe_userid character varying(140),
    simultaneous_sessions bigint DEFAULT '1'::bigint NOT NULL,
    google_userid character varying(140),
    user_type character varying(140) DEFAULT 'System User'::character varying,
    time_zone character varying(140),
    mute_sounds integer DEFAULT 0 NOT NULL,
    last_name character varying(140),
    github_username character varying(140),
    last_known_versions text,
    thread_notify integer DEFAULT 1 NOT NULL,
    background_image text,
    last_active timestamp with time zone,
    _comments text,
    new_password character varying(140),
    last_login character varying(140),
    github_userid character varying(140),
    login_after bigint DEFAULT '0'::bigint NOT NULL,
    email character varying(140),
    restrict_ip character varying(140),
    username character varying(140),
    bio text,
    last_ip character varying(140),
    fb_userid character varying(140),
    background_style character varying(140),
    _assign text,
    first_name character varying(140),
    send_password_update_notification integer DEFAULT 0 NOT NULL,
    phone character varying(140),
    middle_name character varying(140),
    _user_tags text,
    send_welcome_email integer DEFAULT 1 NOT NULL,
    email_signature text,
    language character varying(140),
    reset_password_key character varying(140),
    gender character varying(140),
    login_before bigint DEFAULT '0'::bigint NOT NULL,
    enabled integer DEFAULT 1 NOT NULL,
    location character varying(140),
    fb_username character varying(140),
    redirect_url text,
    birth_date date,
    unsubscribed integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.tabuser OWNER TO postgres;

--
-- TOC entry 536 (class 1259 OID 20290)
-- Name: tabuserrole; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabuserrole (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    role character varying(140)
);


ALTER TABLE public.tabuserrole OWNER TO postgres;

--
-- TOC entry 537 (class 1259 OID 20298)
-- Name: tabvehicle; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabvehicle (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    color character varying(140),
    acquisition_date date,
    license_plate character varying(140),
    carbon_check_date date,
    last_odometer bigint DEFAULT '0'::bigint NOT NULL,
    policy_no character varying(140),
    amended_from character varying(140),
    _comments text,
    make character varying(140),
    vehicle_value numeric(18,6) DEFAULT 0.000000 NOT NULL,
    location character varying(140),
    doors bigint DEFAULT '0'::bigint NOT NULL,
    employee character varying(140),
    start_date date,
    uom character varying(140) DEFAULT 'Litre'::character varying,
    _liked_by text,
    end_date date,
    _assign text,
    insurance_company character varying(140),
    _user_tags text,
    wheels bigint DEFAULT '0'::bigint NOT NULL,
    chassis_no character varying(140),
    model character varying(140),
    fuel_type character varying(140)
);


ALTER TABLE public.tabvehicle OWNER TO postgres;

--
-- TOC entry 540 (class 1259 OID 20331)
-- Name: tabversion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabversion (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    _assign text,
    _user_tags text,
    ref_doctype character varying(140),
    _comments text,
    docname character varying(140),
    data text,
    _liked_by text
);


ALTER TABLE public.tabversion OWNER TO postgres;

--
-- TOC entry 541 (class 1259 OID 20339)
-- Name: tabwarehouse; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabwarehouse (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    pin character varying(140),
    email_id character varying(140),
    disabled integer DEFAULT 0 NOT NULL,
    lft bigint DEFAULT '0'::bigint NOT NULL,
    parent_warehouse character varying(140),
    mobile_no character varying(140),
    city character varying(140),
    rgt bigint DEFAULT '0'::bigint NOT NULL,
    _comments text,
    state character varying(140),
    create_account_under character varying(140),
    _liked_by text,
    company character varying(140),
    _assign text,
    is_group integer DEFAULT 0 NOT NULL,
    warehouse_name character varying(140),
    _user_tags text,
    old_parent character varying(140),
    phone_no character varying(140),
    address_line_2 character varying(140),
    address_line_1 character varying(140)
);


ALTER TABLE public.tabwarehouse OWNER TO postgres;

--
-- TOC entry 552 (class 1259 OID 20462)
-- Name: tabworkflow; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabworkflow (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    override_status integer DEFAULT 0 NOT NULL,
    workflow_name character varying(140),
    _assign text,
    is_active integer DEFAULT 0 NOT NULL,
    _liked_by text,
    workflow_state_field character varying(140) DEFAULT 'workflow_state'::character varying,
    document_type character varying(140),
    _user_tags text,
    _comments text
);


ALTER TABLE public.tabworkflow OWNER TO postgres;

--
-- TOC entry 557 (class 1259 OID 20505)
-- Name: tabworkstation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabworkstation (
    name character varying(140) NOT NULL,
    creation timestamp with time zone,
    modified timestamp with time zone,
    modified_by character varying(140),
    owner character varying(140),
    docstatus integer DEFAULT 0 NOT NULL,
    parent character varying(140),
    parentfield character varying(140),
    parenttype character varying(140),
    idx integer DEFAULT 0 NOT NULL,
    hour_rate_rent numeric(18,6) DEFAULT 0.000000 NOT NULL,
    _liked_by text,
    description text,
    hour_rate_electricity numeric(18,6) DEFAULT 0.000000 NOT NULL,
    _user_tags text,
    _assign text,
    hour_rate_labour numeric(18,6) DEFAULT 0.000000 NOT NULL,
    hour_rate numeric(18,6) DEFAULT 0.000000 NOT NULL,
    holiday_list character varying(140),
    _comments text,
    hour_rate_consumable numeric(18,6) DEFAULT 0.000000 NOT NULL,
    workstation_name character varying(140)
);


ALTER TABLE public.tabworkstation OWNER TO postgres;

--
-- TOC entry 8350 (class 0 OID 20527)
-- Dependencies: 559
-- Data for Name: __auth; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.__auth (doctype, name, fieldname, password, salt, encrypted) FROM stdin;
\.


--
-- TOC entry 8351 (class 0 OID 20534)
-- Dependencies: 560
-- Data for Name: __listsettings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.__listsettings ("user", doctype, data) FROM stdin;
\.


--
-- TOC entry 7989 (class 0 OID 16385)
-- Dependencies: 198
-- Data for Name: tabAbout Us Team Member; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabAbout Us Team Member" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, image_link, bio, full_name) FROM stdin;
\.


--
-- TOC entry 7990 (class 0 OID 16393)
-- Dependencies: 199
-- Data for Name: tabAcademic Term; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabAcademic Term" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, academic_year, _liked_by, term_name, title, term_start_date, _assign, term_end_date, _comments, _user_tags) FROM stdin;
\.


--
-- TOC entry 7991 (class 0 OID 16401)
-- Dependencies: 200
-- Data for Name: tabAcademic Year; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabAcademic Year" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, year_end_date, _liked_by, year_start_date, _user_tags, _assign, academic_year_name, _comments) FROM stdin;
\.


--
-- TOC entry 7993 (class 0 OID 16421)
-- Dependencies: 202
-- Data for Name: tabActivity Cost; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabActivity Cost" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, _assign, title, _comments, billing_rate, costing_rate, employee_name, employee, _user_tags, _liked_by, activity_type) FROM stdin;
\.


--
-- TOC entry 7994 (class 0 OID 16431)
-- Dependencies: 203
-- Data for Name: tabActivity Type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabActivity Type" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, _liked_by, _user_tags, _assign, billing_rate, costing_rate, _comments, activity_type) FROM stdin;
\.


--
-- TOC entry 7996 (class 0 OID 16452)
-- Dependencies: 205
-- Data for Name: tabAddress Template; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabAddress Template" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, _liked_by, country, _assign, is_default, _comments, template, _user_tags) FROM stdin;
\.


--
-- TOC entry 7999 (class 0 OID 16479)
-- Dependencies: 208
-- Data for Name: tabAppraisal Goal; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabAppraisal Goal" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, score_earned, score, kra, per_weightage) FROM stdin;
\.


--
-- TOC entry 8000 (class 0 OID 16490)
-- Dependencies: 209
-- Data for Name: tabAppraisal Template; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabAppraisal Template" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, _liked_by, description, _user_tags, kra_title, _assign, _comments) FROM stdin;
\.


--
-- TOC entry 8001 (class 0 OID 16498)
-- Dependencies: 210
-- Data for Name: tabAppraisal Template Goal; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabAppraisal Template Goal" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, kra, per_weightage) FROM stdin;
\.


--
-- TOC entry 8002 (class 0 OID 16507)
-- Dependencies: 211
-- Data for Name: tabAssessment Evaluation Criteria; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabAssessment Evaluation Criteria" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, maximum_score, evaluation_criteria) FROM stdin;
\.


--
-- TOC entry 8003 (class 0 OID 16516)
-- Dependencies: 212
-- Data for Name: tabAssessment Group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabAssessment Group" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, _liked_by, _user_tags, _assign, assessment_group_code, _comments, assessment_group_name) FROM stdin;
\.


--
-- TOC entry 8004 (class 0 OID 16524)
-- Dependencies: 213
-- Data for Name: tabAssessment Plan; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabAssessment Plan" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, supervisor, examiner, course, assessment_name, supervisor_name, maximum_assessment_score, _comments, amended_from, _liked_by, assessment_group, _assign, student_group, to_time, schedule_date, _user_tags, from_time, room, student_batch, grading_scale, examiner_name, assessment_code) FROM stdin;
\.


--
-- TOC entry 8005 (class 0 OID 16533)
-- Dependencies: 214
-- Data for Name: tabAssessment Result; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabAssessment Result" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, _liked_by, grade, _comments, _assign, grading_scale, amended_from, student, maximum_score, student_name, assessment_plan, _user_tags, total_score) FROM stdin;
\.


--
-- TOC entry 8006 (class 0 OID 16543)
-- Dependencies: 215
-- Data for Name: tabAssessment Result Detail; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabAssessment Result Detail" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, maximum_score, grade, evaluation_criteria, score) FROM stdin;
\.


--
-- TOC entry 8008 (class 0 OID 16570)
-- Dependencies: 217
-- Data for Name: tabAsset Category; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabAsset Category" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, asset_category_name, _liked_by, _comments, _assign, total_number_of_depreciations, frequency_of_depreciation, _user_tags, depreciation_method) FROM stdin;
\.


--
-- TOC entry 8009 (class 0 OID 16581)
-- Dependencies: 218
-- Data for Name: tabAsset Category Account; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabAsset Category Account" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, depreciation_expense_account, accumulated_depreciation_account, fixed_asset_account, company_name) FROM stdin;
\.


--
-- TOC entry 8010 (class 0 OID 16589)
-- Dependencies: 219
-- Data for Name: tabAsset Movement; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabAsset Movement" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, _liked_by, _comments, company, _assign, amended_from, transaction_date, asset, target_warehouse, _user_tags, source_warehouse) FROM stdin;
\.


--
-- TOC entry 8012 (class 0 OID 16606)
-- Dependencies: 221
-- Data for Name: tabAttendance Tool Student; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabAttendance Tool Student" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, status, student_name, student) FROM stdin;
\.


--
-- TOC entry 8013 (class 0 OID 16614)
-- Dependencies: 222
-- Data for Name: tabAuthorization Rule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabAuthorization Rule" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, to_designation, system_role, system_user, _user_tags, to_emp, customer_or_item, approving_user, _liked_by, company, _assign, _comments, transaction, master_name, value, based_on, approving_role) FROM stdin;
\.


--
-- TOC entry 8014 (class 0 OID 16623)
-- Dependencies: 223
-- Data for Name: tabAuto Email Report; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabAuto Email Report" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, filters, frequency, day_of_week, report_type, send_if_data, _comments, filter_meta, data_modified_till, no_of_rows, _liked_by, description, format, _assign, email_to, "user", report, _user_tags, enabled) FROM stdin;
\.


--
-- TOC entry 8023 (class 0 OID 16729)
-- Dependencies: 232
-- Data for Name: tabBOM Explosion Item; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabBOM Explosion Item" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, qty_consumed_per_unit, description, item_name, image, rate, item_code, qty, amount, stock_uom) FROM stdin;
\.


--
-- TOC entry 8024 (class 0 OID 16741)
-- Dependencies: 233
-- Data for Name: tabBOM Item; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabBOM Item" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, bom_no, description, rate, item_name, qty_consumed_per_unit, base_amount, item_code, qty, amount, stock_uom, scrap, base_rate, image) FROM stdin;
\.


--
-- TOC entry 8025 (class 0 OID 16756)
-- Dependencies: 234
-- Data for Name: tabBOM Operation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabBOM Operation" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, operating_cost, workstation, description, operation, base_hour_rate, hour_rate, base_operating_cost, time_in_mins) FROM stdin;
\.


--
-- TOC entry 8026 (class 0 OID 16769)
-- Dependencies: 235
-- Data for Name: tabBOM Scrap Item; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabBOM Scrap Item" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, rate, item_name, qty, base_rate, item_code, base_amount, amount, stock_uom) FROM stdin;
\.


--
-- TOC entry 8015 (class 0 OID 16637)
-- Dependencies: 224
-- Data for Name: tabBank Reconciliation Detail; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabBank Reconciliation Detail" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, payment_document, clearance_date, cheque_date, payment_entry, amount, posting_date, cheque_number, against_account) FROM stdin;
\.


--
-- TOC entry 8018 (class 0 OID 16672)
-- Dependencies: 227
-- Data for Name: tabBlock Module; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabBlock Module" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, module) FROM stdin;
\.


--
-- TOC entry 8019 (class 0 OID 16680)
-- Dependencies: 228
-- Data for Name: tabBlog Category; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabBlog Category" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, _liked_by, title, _user_tags, route, _assign, published, _comments, category_name) FROM stdin;
\.


--
-- TOC entry 8020 (class 0 OID 16689)
-- Dependencies: 229
-- Data for Name: tabBlog Post; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabBlog Post" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, published_on, _liked_by, _user_tags, title, blogger, _assign, email_sent, content, _comments, published, blog_category, route, blog_intro) FROM stdin;
\.


--
-- TOC entry 8030 (class 0 OID 16809)
-- Dependencies: 239
-- Data for Name: tabBudget Account; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabBudget Account" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, account, budget_amount) FROM stdin;
\.


--
-- TOC entry 8031 (class 0 OID 16818)
-- Dependencies: 240
-- Data for Name: tabC-Form; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabC-Form" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, customer, _assign, total_amount, naming_series, company, c_form_no, amended_from, state, _liked_by, _comments, received_date, total_invoiced_amount, quarter, _user_tags) FROM stdin;
\.


--
-- TOC entry 8032 (class 0 OID 16828)
-- Dependencies: 241
-- Data for Name: tabC-Form Invoice Detail; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabC-Form Invoice Detail" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, territory, grand_total, net_total, invoice_date, invoice_no) FROM stdin;
\.


--
-- TOC entry 8034 (class 0 OID 16846)
-- Dependencies: 243
-- Data for Name: tabCheque Print Template; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabCheque Print Template" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, date_dist_from_left_edge, _liked_by, is_account_payable, amt_in_word_width, amt_in_figures_from_left_edge, cheque_width, amt_in_words_from_top_edge, acc_pay_dist_from_left_edge, payer_name_from_top_edge, starting_position_from_top_edge, _comments, message_to_show, date_dist_from_top_edge, signatory_from_top_edge, payer_name_from_left_edge, bank_name, acc_no_dist_from_top_edge, signatory_from_left_edge, amt_in_figures_from_top_edge, acc_pay_dist_from_top_edge, amt_in_words_from_left_edge, amt_in_words_line_spacing, has_print_format, _user_tags, scanned_cheque, cheque_height, _assign, cheque_size, acc_no_dist_from_left_edge) FROM stdin;
\.


--
-- TOC entry 8037 (class 0 OID 16899)
-- Dependencies: 246
-- Data for Name: tabCompany History; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabCompany History" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, highlight, year) FROM stdin;
\.


--
-- TOC entry 8039 (class 0 OID 16918)
-- Dependencies: 248
-- Data for Name: tabCost Center; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabCost Center" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, _liked_by, rgt, cost_center_name, _comments, company, _assign, is_group, old_parent, lft, parent_cost_center, _user_tags) FROM stdin;
\.


--
-- TOC entry 8042 (class 0 OID 16945)
-- Dependencies: 251
-- Data for Name: tabCourse Evaluation Criteria; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabCourse Evaluation Criteria" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, weightage, evaluation_criteria) FROM stdin;
\.


--
-- TOC entry 8043 (class 0 OID 16954)
-- Dependencies: 252
-- Data for Name: tabCourse Schedule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabCourse Schedule" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, instructor, room, title, naming_series, student_group, course, _assign, _liked_by, _comments, to_time, student_batch, instructor_name, schedule_date, _user_tags, from_time) FROM stdin;
\.


--
-- TOC entry 8045 (class 0 OID 16974)
-- Dependencies: 254
-- Data for Name: tabCurrency Exchange; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabCurrency Exchange" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, to_currency, _liked_by, _comments, _assign, exchange_rate, from_currency, date, _user_tags) FROM stdin;
\.


--
-- TOC entry 8046 (class 0 OID 16983)
-- Dependencies: 255
-- Data for Name: tabCustom DocPerm; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabCustom DocPerm" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, share, export, cancel, user_permission_doctypes, "create", submit, write, role, print, import, email, _liked_by, _user_tags, apply_user_permissions, read, _assign, _comments, set_user_permissions, report, amend, permlevel, if_owner, delete) FROM stdin;
\.


--
-- TOC entry 8047 (class 0 OID 17008)
-- Dependencies: 256
-- Data for Name: tabCustom Field; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabCustom Field" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, collapsible, print_width, no_copy, depends_on, _liked_by, in_list_view, reqd, ignore_xss_filter, collapsible_depends_on, in_filter, read_only, print_hide, _comments, ignore_user_permissions, label, print_hide_if_no_value, width, options, hidden, permlevel, insert_after, _assign, description, search_index, allow_on_submit, "precision", dt, "unique", _user_tags, "default", in_standard_filter, fieldname, fieldtype, report_hide) FROM stdin;
\.


--
-- TOC entry 8048 (class 0 OID 17034)
-- Dependencies: 257
-- Data for Name: tabCustom Script; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabCustom Script" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, _liked_by, script, _user_tags, _assign, dt, _comments, script_type) FROM stdin;
\.


--
-- TOC entry 8050 (class 0 OID 17057)
-- Dependencies: 259
-- Data for Name: tabCustomer Group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabCustomer Group" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, credit_limit, rgt, lft, _comments, parent_customer_group, _assign, is_group, old_parent, credit_days_based_on, default_price_list, _liked_by, credit_days, customer_group_name, _user_tags) FROM stdin;
\.


--
-- TOC entry 8051 (class 0 OID 17070)
-- Dependencies: 260
-- Data for Name: tabCustomize Form Field; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabCustomize Form Field" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, collapsible, print_width, in_list_view, reqd, collapsible_depends_on, in_filter, read_only, print_hide, ignore_user_permissions, label, print_hide_if_no_value, width, depends_on, hidden, permlevel, columns, description, allow_on_submit, "precision", is_custom_field, remember_last_selected_value, "unique", "default", in_standard_filter, options, length, fieldname, fieldtype, report_hide) FROM stdin;
\.


--
-- TOC entry 8052 (class 0 OID 17097)
-- Dependencies: 261
-- Data for Name: tabDaily Work Summary; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabDaily Work Summary" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, status, _liked_by, _user_tags, company, _assign, email_sent_to, _comments) FROM stdin;
\.


--
-- TOC entry 8053 (class 0 OID 17106)
-- Dependencies: 262
-- Data for Name: tabDaily Work Summary Settings Company; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabDaily Work Summary Settings Company" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, company, send_emails_at) FROM stdin;
\.


--
-- TOC entry 8055 (class 0 OID 17123)
-- Dependencies: 264
-- Data for Name: tabDeleted Document; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabDeleted Document" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, new_name, _assign, _user_tags, deleted_name, _liked_by, _comments, data, restored, deleted_doctype) FROM stdin;
\.


--
-- TOC entry 8056 (class 0 OID 17132)
-- Dependencies: 265
-- Data for Name: tabDelivery Note; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabDelivery Note" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, lr_date, title, excise_page, selling_price_list, return_against, tc_name, source, instructions, base_in_words, ignore_pricing_rule, _assign, base_discount_amount, base_total_taxes_and_charges, discount_amount, is_return, select_print_heading, total_taxes_and_charges, per_installed, po_date, price_list_currency, contact_display, terms, shipping_address, customer_address, total_commission, contact_mobile, _user_tags, base_net_total, language, rounded_total, customer_group, apply_discount_on, po_no, contact_person, print_without_amount, additional_discount_percentage, campaign, conversion_rate, posting_time, total, customer_name, commission_rate, _comments, base_total, territory, sales_partner, company, contact_email, customer, grand_total, project, posting_date, shipping_address_name, address_display, naming_series, currency, letter_head, installation_status, shipping_rule, amended_from, base_grand_total, to_warehouse, status, _liked_by, lr_no, taxes_and_charges, per_billed, transporter_name, in_words, plc_conversion_rate, net_total, base_rounded_total) FROM stdin;
\.


--
-- TOC entry 8057 (class 0 OID 17165)
-- Dependencies: 266
-- Data for Name: tabDelivery Note Item; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabDelivery Note Item" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, image, serial_no, base_amount, expense_account, item_tax_rate, rate, installed_qty, cost_center, target_warehouse, actual_qty, quality_inspection, page_break, base_net_rate, discount_percentage, item_name, qty, base_net_amount, against_sales_invoice, net_rate, stock_uom, base_price_list_rate, warehouse, billed_amt, against_sales_order, description, brand, barcode, base_rate, item_code, margin_type, pricing_rule, price_list_rate, margin_rate_or_amount, actual_batch_qty, item_group, so_detail, amount, customer_item_code, batch_no, net_amount, si_detail, total_margin) FROM stdin;
\.


--
-- TOC entry 8059 (class 0 OID 17200)
-- Dependencies: 268
-- Data for Name: tabDependent Task; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabDependent Task" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, task) FROM stdin;
\.


--
-- TOC entry 8060 (class 0 OID 17208)
-- Dependencies: 269
-- Data for Name: tabDepreciation Schedule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabDepreciation Schedule" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, journal_entry, depreciation_amount, schedule_date, accumulated_depreciation_amount) FROM stdin;
\.


--
-- TOC entry 8062 (class 0 OID 17226)
-- Dependencies: 271
-- Data for Name: tabDesktop Icon; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabDesktop Icon" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, color, app, label, blocked, _comments, custom, hidden, type, _liked_by, _assign, standard, link, force_show, _user_tags, icon, reverse, module_name, _doctype) FROM stdin;
\.


--
-- TOC entry 8068 (class 0 OID 17348)
-- Dependencies: 277
-- Data for Name: tabDynamic Link; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabDynamic Link" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, link_name, link_doctype) FROM stdin;
\.


--
-- TOC entry 8069 (class 0 OID 17356)
-- Dependencies: 278
-- Data for Name: tabEmail Account; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabEmail Account" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, default_outgoing, domain, email_id, uidnext, use_imap, auto_reply_message, use_ssl, email_server, uid_validity, send_notification_to, always_use_account_email_id_as_sender, default_incoming, service, _comments, smtp_port, smtp_server, no_failed, use_tls, enable_incoming, attachment_limit, awaiting_password, login_id, _liked_by, enable_auto_reply, _assign, send_unsubscribe_message, enable_outgoing, add_signature, password, _user_tags, email_account_name, footer, unreplied_for_mins, login_id_is_different, no_remaining, append_to, signature, notify_if_unreplied) FROM stdin;
\.


--
-- TOC entry 8070 (class 0 OID 17381)
-- Dependencies: 279
-- Data for Name: tabEmail Alert; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabEmail Alert" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, enabled, module, days_in_advance, message, event, subject, attach_print, condition, date_changed, _liked_by, _assign, is_standard, _comments, document_type, _user_tags, method, value_changed) FROM stdin;
\.


--
-- TOC entry 8071 (class 0 OID 17393)
-- Dependencies: 280
-- Data for Name: tabEmail Alert Recipient; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabEmail Alert Recipient" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, cc, email_by_document_field, email_by_role, condition) FROM stdin;
\.


--
-- TOC entry 8072 (class 0 OID 17401)
-- Dependencies: 281
-- Data for Name: tabEmail Digest; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabEmail Digest" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, calendar_events, _liked_by, frequency, pending_quotations, expense_year_to_date, expenses_booked, new_quotations, next_send, purchase_order, income, issue, income_year_to_date, recipient_list, invoiced_amount, company, bank_balance, pending_sales_orders, notifications, _assign, _comments, add_quote, _user_tags, sales_order, enabled, project, credit_balance, todo_list, pending_purchase_orders, payables) FROM stdin;
\.


--
-- TOC entry 8073 (class 0 OID 17430)
-- Dependencies: 282
-- Data for Name: tabEmail Domain; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabEmail Domain" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, _assign, email_id, _comments, smtp_port, smtp_server, domain_name, use_tls, _liked_by, use_imap, attachment_limit, use_ssl, email_server, _user_tags, append_to) FROM stdin;
\.


--
-- TOC entry 8074 (class 0 OID 17442)
-- Dependencies: 283
-- Data for Name: tabEmail Flag Queue; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabEmail Flag Queue" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, _liked_by, _user_tags, _assign, flag, comm_name, action, _comments) FROM stdin;
\.


--
-- TOC entry 8075 (class 0 OID 17450)
-- Dependencies: 284
-- Data for Name: tabEmail Group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabEmail Group" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, _liked_by, title, _user_tags, _assign, total_subscribers, _comments) FROM stdin;
\.


--
-- TOC entry 8076 (class 0 OID 17459)
-- Dependencies: 285
-- Data for Name: tabEmail Group Member; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabEmail Group Member" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, _liked_by, _comments, _assign, unsubscribed, _user_tags, email, email_group) FROM stdin;
\.


--
-- TOC entry 8077 (class 0 OID 17468)
-- Dependencies: 286
-- Data for Name: tabEmail Queue; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabEmail Queue" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, status, reference_doctype, _liked_by, sender, reference_name, _assign, unsubscribe_param, expose_recipients, priority, send_after, _comments, error, communication, show_as_cc, message, unsubscribe_method, _user_tags, message_id) FROM stdin;
\.


--
-- TOC entry 8078 (class 0 OID 17478)
-- Dependencies: 287
-- Data for Name: tabEmail Queue Recipient; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabEmail Queue Recipient" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, status, recipient, error) FROM stdin;
\.


--
-- TOC entry 8079 (class 0 OID 17487)
-- Dependencies: 288
-- Data for Name: tabEmail Unsubscribe; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabEmail Unsubscribe" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, reference_doctype, _liked_by, _comments, _assign, global_unsubscribe, reference_name, _user_tags, email) FROM stdin;
\.


--
-- TOC entry 8081 (class 0 OID 17507)
-- Dependencies: 290
-- Data for Name: tabEmployee Education; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabEmployee Education" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, maj_opt_subj, level, class_per, qualification, school_univ, year_of_passing) FROM stdin;
\.


--
-- TOC entry 8082 (class 0 OID 17516)
-- Dependencies: 291
-- Data for Name: tabEmployee External Work History; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabEmployee External Work History" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, salary, designation, contact, company_name, address, total_experience) FROM stdin;
\.


--
-- TOC entry 8083 (class 0 OID 17525)
-- Dependencies: 292
-- Data for Name: tabEmployee Internal Work History; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabEmployee Internal Work History" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, department, from_date, designation, branch, to_date) FROM stdin;
\.


--
-- TOC entry 8084 (class 0 OID 17533)
-- Dependencies: 293
-- Data for Name: tabEmployee Leave Approver; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabEmployee Leave Approver" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, leave_approver) FROM stdin;
\.


--
-- TOC entry 8085 (class 0 OID 17541)
-- Dependencies: 294
-- Data for Name: tabEmployment Type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabEmployment Type" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, _comments, _assign, _user_tags, employee_type_name, _liked_by) FROM stdin;
\.


--
-- TOC entry 8086 (class 0 OID 17549)
-- Dependencies: 295
-- Data for Name: tabError Log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabError Log" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, _liked_by, _comments, _assign, error, seen, _user_tags, method) FROM stdin;
\.


--
-- TOC entry 8087 (class 0 OID 17558)
-- Dependencies: 296
-- Data for Name: tabError Snapshot; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabError Snapshot" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, exception, _assign, pyver, "timestamp", evalue, traceback, parent_error_snapshot, etype, _liked_by, _comments, frames, seen, _user_tags, relapses, locals) FROM stdin;
\.


--
-- TOC entry 8088 (class 0 OID 17568)
-- Dependencies: 297
-- Data for Name: tabEvaluation Criteria; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabEvaluation Criteria" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, _comments, _assign, _user_tags, evaluation_criteria, _liked_by) FROM stdin;
\.


--
-- TOC entry 8090 (class 0 OID 17594)
-- Dependencies: 299
-- Data for Name: tabEvent Role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabEvent Role" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, role) FROM stdin;
\.


--
-- TOC entry 8091 (class 0 OID 17602)
-- Dependencies: 300
-- Data for Name: tabExpense Claim; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabExpense Claim" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, total_claimed_amount, email_id, naming_series, approval_status, total_amount_reimbursed, vehicle_log, _comments, amended_from, total_sanctioned_amount, employee, _liked_by, company, _assign, employee_name, exp_approver, _user_tags, remark, task, title, project, posting_date) FROM stdin;
\.


--
-- TOC entry 8092 (class 0 OID 17616)
-- Dependencies: 301
-- Data for Name: tabExpense Claim Account; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabExpense Claim Account" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, company, default_account) FROM stdin;
\.


--
-- TOC entry 8093 (class 0 OID 17624)
-- Dependencies: 302
-- Data for Name: tabExpense Claim Detail; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabExpense Claim Detail" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, description, claim_amount, sanctioned_amount, expense_type, default_account, expense_date) FROM stdin;
\.


--
-- TOC entry 8094 (class 0 OID 17634)
-- Dependencies: 303
-- Data for Name: tabExpense Claim Type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabExpense Claim Type" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, _liked_by, description, _comments, _assign, expense_type, _user_tags) FROM stdin;
\.


--
-- TOC entry 8095 (class 0 OID 17642)
-- Dependencies: 304
-- Data for Name: tabFee Category; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabFee Category" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, _liked_by, description, _user_tags, _assign, _comments, category_name) FROM stdin;
\.


--
-- TOC entry 8096 (class 0 OID 17650)
-- Dependencies: 305
-- Data for Name: tabFee Component; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabFee Component" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, amount, fees_category) FROM stdin;
\.


--
-- TOC entry 8097 (class 0 OID 17659)
-- Dependencies: 306
-- Data for Name: tabFee Structure; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabFee Structure" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, _assign, student_category, total_amount, naming_series, academic_term, program, _comments, _user_tags, _liked_by) FROM stdin;
\.


--
-- TOC entry 8100 (class 0 OID 17694)
-- Dependencies: 309
-- Data for Name: tabFiscal Year; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabFiscal Year" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, year_end_date, _liked_by, year_start_date, _comments, _assign, disabled, year, _user_tags) FROM stdin;
\.


--
-- TOC entry 8101 (class 0 OID 17703)
-- Dependencies: 310
-- Data for Name: tabFiscal Year Company; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabFiscal Year Company" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, company) FROM stdin;
\.


--
-- TOC entry 8102 (class 0 OID 17711)
-- Dependencies: 311
-- Data for Name: tabFooter Item; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabFooter Item" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, url, group_label, target, label) FROM stdin;
\.


--
-- TOC entry 8103 (class 0 OID 17719)
-- Dependencies: 312
-- Data for Name: tabGL Entry; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabGL Entry" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, fiscal_year, voucher_no, cost_center, against_voucher, party_type, transaction_date, debit, party, _liked_by, company, _assign, voucher_type, _comments, is_advance, remarks, account_currency, debit_in_account_currency, _user_tags, account, against_voucher_type, against, project, credit, is_opening, posting_date, credit_in_account_currency) FROM stdin;
\.


--
-- TOC entry 8104 (class 0 OID 17731)
-- Dependencies: 313
-- Data for Name: tabGrade Interval; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabGrade Interval" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, min_score, grade_code, grade_description) FROM stdin;
\.


--
-- TOC entry 8105 (class 0 OID 17740)
-- Dependencies: 314
-- Data for Name: tabGrading Scale; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabGrading Scale" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, _liked_by, description, grading_scale_name, _comments, _assign, amended_from, _user_tags) FROM stdin;
\.


--
-- TOC entry 8106 (class 0 OID 17748)
-- Dependencies: 315
-- Data for Name: tabGrading Scale Interval; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabGrading Scale Interval" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, threshold, grade_code, grade_description) FROM stdin;
\.


--
-- TOC entry 8107 (class 0 OID 17757)
-- Dependencies: 316
-- Data for Name: tabGrading Structure; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabGrading Structure" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, _assign, description, _comments, grading_system_name, _liked_by, _user_tags) FROM stdin;
\.


--
-- TOC entry 8109 (class 0 OID 17773)
-- Dependencies: 318
-- Data for Name: tabGuardian Interest; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabGuardian Interest" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, interest) FROM stdin;
\.


--
-- TOC entry 8110 (class 0 OID 17781)
-- Dependencies: 319
-- Data for Name: tabHelp Article; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabHelp Article" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, category, _assign, author, _comments, route, level, content, _liked_by, likes, published, title, _user_tags) FROM stdin;
\.


--
-- TOC entry 8111 (class 0 OID 17792)
-- Dependencies: 320
-- Data for Name: tabHelp Category; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabHelp Category" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, _assign, _comments, route, published, help_articles, _liked_by, category_description, _user_tags, category_name) FROM stdin;
\.


--
-- TOC entry 8113 (class 0 OID 17810)
-- Dependencies: 322
-- Data for Name: tabHoliday List; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabHoliday List" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, _liked_by, holiday_list_name, _comments, _assign, weekly_off, from_date, _user_tags, to_date) FROM stdin;
\.


--
-- TOC entry 8114 (class 0 OID 17818)
-- Dependencies: 323
-- Data for Name: tabHomepage Featured Product; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabHomepage Featured Product" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, description, item_name, route, item_code, image, thumbnail) FROM stdin;
\.


--
-- TOC entry 8115 (class 0 OID 17826)
-- Dependencies: 324
-- Data for Name: tabIndustry Type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabIndustry Type" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, _comments, industry, _assign, _user_tags, _liked_by) FROM stdin;
\.


--
-- TOC entry 8116 (class 0 OID 17834)
-- Dependencies: 325
-- Data for Name: tabInstallation Note; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabInstallation Note" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, address_display, inst_date, naming_series, customer_name, _comments, amended_from, contact_display, territory, status, _liked_by, company, _assign, customer_address, contact_email, contact_mobile, remarks, _user_tags, customer, customer_group, inst_time, contact_person) FROM stdin;
\.


--
-- TOC entry 8117 (class 0 OID 17843)
-- Dependencies: 326
-- Data for Name: tabInstallation Note Item; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabInstallation Note Item" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, description, prevdoc_docname, serial_no, item_code, qty, prevdoc_detail_docname, prevdoc_doctype) FROM stdin;
\.


--
-- TOC entry 8119 (class 0 OID 17860)
-- Dependencies: 328
-- Data for Name: tabIntegration Request; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabIntegration Request" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, status, reference_doctype, _assign, integration_type, _user_tags, error, _liked_by, _comments, integration_request_service, reference_docname, output, data) FROM stdin;
\.


--
-- TOC entry 8120 (class 0 OID 17869)
-- Dependencies: 329
-- Data for Name: tabIntegration Service; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabIntegration Service" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, _liked_by, service, enabled, _assign, _user_tags, _comments) FROM stdin;
\.


--
-- TOC entry 8121 (class 0 OID 17878)
-- Dependencies: 330
-- Data for Name: tabIntegration Service Parameter; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabIntegration Service Parameter" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, fieldname, value, label) FROM stdin;
\.


--
-- TOC entry 8125 (class 0 OID 17942)
-- Dependencies: 334
-- Data for Name: tabItem Attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabItem Attribute" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, _liked_by, numeric_values, _comments, _assign, to_range, attribute_name, increment, from_range, _user_tags) FROM stdin;
\.


--
-- TOC entry 8126 (class 0 OID 17954)
-- Dependencies: 335
-- Data for Name: tabItem Attribute Value; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabItem Attribute Value" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, attribute_value, abbr) FROM stdin;
\.


--
-- TOC entry 8127 (class 0 OID 17962)
-- Dependencies: 336
-- Data for Name: tabItem Customer Detail; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabItem Customer Detail" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, ref_code, customer_name) FROM stdin;
\.


--
-- TOC entry 8128 (class 0 OID 17970)
-- Dependencies: 337
-- Data for Name: tabItem Group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabItem Group" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, _assign, default_income_account, lft, default_cost_center, route, is_group, slideshow, parent_item_group, old_parent, default_expense_account, _liked_by, _comments, show_in_website, rgt, _user_tags, item_group_name, description) FROM stdin;
\.


--
-- TOC entry 8129 (class 0 OID 17982)
-- Dependencies: 338
-- Data for Name: tabItem Price; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabItem Price" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, price_list_rate, selling, item_description, item_name, _assign, price_list, item_code, currency, _liked_by, _comments, _user_tags, buying) FROM stdin;
\.


--
-- TOC entry 8130 (class 0 OID 17993)
-- Dependencies: 339
-- Data for Name: tabItem Quality Inspection Parameter; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabItem Quality Inspection Parameter" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, specification, value) FROM stdin;
\.


--
-- TOC entry 8131 (class 0 OID 18001)
-- Dependencies: 340
-- Data for Name: tabItem Reorder; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabItem Reorder" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, warehouse, warehouse_reorder_qty, warehouse_group, material_request_type, warehouse_reorder_level) FROM stdin;
\.


--
-- TOC entry 8132 (class 0 OID 18011)
-- Dependencies: 341
-- Data for Name: tabItem Supplier; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabItem Supplier" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, supplier, supplier_part_no) FROM stdin;
\.


--
-- TOC entry 8133 (class 0 OID 18019)
-- Dependencies: 342
-- Data for Name: tabItem Tax; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabItem Tax" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, tax_type, tax_rate) FROM stdin;
\.


--
-- TOC entry 8134 (class 0 OID 18028)
-- Dependencies: 343
-- Data for Name: tabItem Variant; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabItem Variant" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, item_attribute_value, item_attribute) FROM stdin;
\.


--
-- TOC entry 8135 (class 0 OID 18036)
-- Dependencies: 344
-- Data for Name: tabItem Variant Attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabItem Variant Attribute" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, from_range, numeric_values, attribute, to_range, increment, attribute_value) FROM stdin;
\.


--
-- TOC entry 8136 (class 0 OID 18048)
-- Dependencies: 345
-- Data for Name: tabItem Website Specification; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabItem Website Specification" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, description, label) FROM stdin;
\.


--
-- TOC entry 8137 (class 0 OID 18056)
-- Dependencies: 346
-- Data for Name: tabJob Applicant; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabJob Applicant" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, cover_letter, status, _liked_by, email_id, _comments, _assign, resume_attachment, _user_tags, applicant_name, job_title) FROM stdin;
\.


--
-- TOC entry 8138 (class 0 OID 18064)
-- Dependencies: 347
-- Data for Name: tabJob Opening; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabJob Opening" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, status, _liked_by, description, _comments, route, _assign, publish, _user_tags, job_title) FROM stdin;
\.


--
-- TOC entry 8139 (class 0 OID 18073)
-- Dependencies: 348
-- Data for Name: tabJournal Entry; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabJournal Entry" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, _liked_by, naming_series, clearance_date, voucher_type, total_amount_currency, letter_head, cheque_no, bill_no, difference, write_off_amount, title, _comments, amended_from, company, bill_date, due_date, cheque_date, multi_currency, total_amount_in_words, _assign, total_credit, user_remark, _user_tags, pay_to_recd_from, remark, total_amount, write_off_based_on, select_print_heading, stock_entry, total_debit, is_opening, posting_date) FROM stdin;
\.


--
-- TOC entry 8140 (class 0 OID 18090)
-- Dependencies: 349
-- Data for Name: tabJournal Entry Account; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabJournal Entry Account" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, exchange_rate, cost_center, reference_type, debit, party, against_account, account_type, reference_name, debit_in_account_currency, party_balance, is_advance, account_currency, account, project, credit, party_type, balance, credit_in_account_currency) FROM stdin;
\.


--
-- TOC entry 8141 (class 0 OID 18105)
-- Dependencies: 350
-- Data for Name: tabKanban Board; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabKanban Board" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, reference_doctype, _liked_by, _user_tags, _assign, filters, kanban_board_name, field_name, _comments) FROM stdin;
\.


--
-- TOC entry 8142 (class 0 OID 18113)
-- Dependencies: 351
-- Data for Name: tabKanban Board Column; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabKanban Board Column" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, status, indicator, "order", column_name) FROM stdin;
\.


--
-- TOC entry 8143 (class 0 OID 18123)
-- Dependencies: 352
-- Data for Name: tabLanded Cost Item; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabLanded Cost Item" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, description, amount, item_code, qty, rate, receipt_document, applicable_charges, receipt_document_type, purchase_receipt_item) FROM stdin;
\.


--
-- TOC entry 8144 (class 0 OID 18135)
-- Dependencies: 353
-- Data for Name: tabLanded Cost Purchase Receipt; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabLanded Cost Purchase Receipt" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, grand_total, receipt_document_type, supplier, receipt_document, posting_date) FROM stdin;
\.


--
-- TOC entry 8145 (class 0 OID 18144)
-- Dependencies: 354
-- Data for Name: tabLanded Cost Taxes and Charges; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabLanded Cost Taxes and Charges" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, amount, description) FROM stdin;
\.


--
-- TOC entry 8146 (class 0 OID 18153)
-- Dependencies: 355
-- Data for Name: tabLanded Cost Voucher; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabLanded Cost Voucher" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, naming_series, _liked_by, company, _assign, amended_from, total_taxes_and_charges, _comments, distribute_charges_based_on, _user_tags) FROM stdin;
\.


--
-- TOC entry 8149 (class 0 OID 18181)
-- Dependencies: 358
-- Data for Name: tabLead Source; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabLead Source" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, _liked_by, source_name, _comments, _assign, details, _user_tags) FROM stdin;
\.


--
-- TOC entry 8150 (class 0 OID 18189)
-- Dependencies: 359
-- Data for Name: tabLeave Allocation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabLeave Allocation" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, naming_series, _liked_by, description, new_leaves_allocated, carry_forwarded_leaves, carry_forward, _assign, amended_from, leave_type, _comments, to_date, employee_name, employee, total_leaves_allocated, from_date, _user_tags) FROM stdin;
\.


--
-- TOC entry 8151 (class 0 OID 18201)
-- Dependencies: 360
-- Data for Name: tabLeave Application; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabLeave Application" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, naming_series, leave_approver, letter_head, to_date, half_day, leave_balance, _comments, amended_from, from_date, employee, status, _liked_by, description, company, _assign, total_leave_days, employee_name, _user_tags, follow_via_email, leave_approver_name, leave_type, posting_date) FROM stdin;
\.


--
-- TOC entry 8152 (class 0 OID 18214)
-- Dependencies: 361
-- Data for Name: tabLeave Block List; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabLeave Block List" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, _liked_by, applies_to_all_departments, _comments, _assign, leave_block_list_name, _user_tags, company) FROM stdin;
\.


--
-- TOC entry 8153 (class 0 OID 18223)
-- Dependencies: 362
-- Data for Name: tabLeave Block List Allow; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabLeave Block List Allow" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, allow_user) FROM stdin;
\.


--
-- TOC entry 8154 (class 0 OID 18231)
-- Dependencies: 363
-- Data for Name: tabLeave Block List Date; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabLeave Block List Date" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, block_date, reason) FROM stdin;
\.


--
-- TOC entry 8155 (class 0 OID 18239)
-- Dependencies: 364
-- Data for Name: tabLeave Type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabLeave Type" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, is_lwp, _liked_by, is_carry_forward, is_encash, allow_negative, _assign, leave_type_name, max_days_allowed, include_holiday, _comments, _user_tags) FROM stdin;
\.


--
-- TOC entry 8156 (class 0 OID 18252)
-- Dependencies: 365
-- Data for Name: tabLetter Head; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabLetter Head" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, is_default, _liked_by, footer, _comments, _assign, letter_head_name, disabled, content, _user_tags) FROM stdin;
\.


--
-- TOC entry 8157 (class 0 OID 18262)
-- Dependencies: 366
-- Data for Name: tabMaintenance Schedule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabMaintenance Schedule" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, address_display, naming_series, customer_name, _comments, amended_from, transaction_date, contact_display, territory, status, _liked_by, company, _assign, customer_address, contact_email, contact_mobile, _user_tags, customer, customer_group, contact_person) FROM stdin;
\.


--
-- TOC entry 8158 (class 0 OID 18271)
-- Dependencies: 367
-- Data for Name: tabMaintenance Schedule Detail; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabMaintenance Schedule Detail" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, item_name, serial_no, item_code, scheduled_date, sales_person, actual_date) FROM stdin;
\.


--
-- TOC entry 8159 (class 0 OID 18279)
-- Dependencies: 368
-- Data for Name: tabMaintenance Schedule Item; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabMaintenance Schedule Item" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, end_date, periodicity, item_name, sales_order, serial_no, item_code, no_of_visits, sales_person, start_date, description) FROM stdin;
\.


--
-- TOC entry 8160 (class 0 OID 18288)
-- Dependencies: 369
-- Data for Name: tabMaintenance Visit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabMaintenance Visit" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, maintenance_type, naming_series, customer_name, completion_status, _comments, amended_from, contact_display, territory, status, customer, _liked_by, customer_feedback, company, _assign, customer_address, mntc_time, contact_email, contact_mobile, _user_tags, mntc_date, address_display, customer_group, contact_person) FROM stdin;
\.


--
-- TOC entry 8161 (class 0 OID 18298)
-- Dependencies: 370
-- Data for Name: tabMaintenance Visit Purpose; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabMaintenance Visit Purpose" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, work_done, service_person, prevdoc_docname, item_name, serial_no, item_code, prevdoc_detail_docname, prevdoc_doctype, description) FROM stdin;
\.


--
-- TOC entry 8163 (class 0 OID 18314)
-- Dependencies: 372
-- Data for Name: tabMaterial Request; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabMaterial Request" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, naming_series, requested_by, letter_head, title, _comments, tc_name, amended_from, transaction_date, status, _liked_by, terms, company, _assign, per_ordered, _user_tags, material_request_type, select_print_heading) FROM stdin;
\.


--
-- TOC entry 8164 (class 0 OID 18324)
-- Dependencies: 373
-- Data for Name: tabMaterial Request Item; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabMaterial Request Item" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, actual_qty, lead_time_date, schedule_date, item_name, ordered_qty, warehouse, image, uom, description, brand, item_code, projected_qty, qty, sales_order, page_break, item_group, min_order_qty, project) FROM stdin;
\.


--
-- TOC entry 8165 (class 0 OID 18338)
-- Dependencies: 374
-- Data for Name: tabMode of Payment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabMode of Payment" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, mode_of_payment, type, _assign, _liked_by, _user_tags, _comments) FROM stdin;
\.


--
-- TOC entry 8166 (class 0 OID 18346)
-- Dependencies: 375
-- Data for Name: tabMode of Payment Account; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabMode of Payment Account" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, company, default_account) FROM stdin;
\.


--
-- TOC entry 8167 (class 0 OID 18354)
-- Dependencies: 376
-- Data for Name: tabModule Def; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabModule Def" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, _liked_by, app_name, _comments, _assign, module_name, _user_tags) FROM stdin;
\.


--
-- TOC entry 8168 (class 0 OID 18362)
-- Dependencies: 377
-- Data for Name: tabMonthly Distribution; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabMonthly Distribution" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, _liked_by, _comments, _assign, fiscal_year, distribution_id, _user_tags) FROM stdin;
\.


--
-- TOC entry 8169 (class 0 OID 18370)
-- Dependencies: 378
-- Data for Name: tabMonthly Distribution Percentage; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabMonthly Distribution Percentage" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, percentage_allocation, month) FROM stdin;
\.


--
-- TOC entry 8172 (class 0 OID 18399)
-- Dependencies: 381
-- Data for Name: tabNote Seen By; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabNote Seen By" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, "user") FROM stdin;
\.


--
-- TOC entry 8173 (class 0 OID 18407)
-- Dependencies: 382
-- Data for Name: tabOAuth Authorization Code; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabOAuth Authorization Code" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, redirect_uri_bound_to_authorization_code, scopes, _liked_by, authorization_code, _comments, _assign, validity, client, "user", expiration_time, _user_tags) FROM stdin;
\.


--
-- TOC entry 8174 (class 0 OID 18415)
-- Dependencies: 383
-- Data for Name: tabOAuth Bearer Token; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabOAuth Bearer Token" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, status, scopes, _liked_by, access_token, _comments, _assign, expires_in, client, "user", expiration_time, _user_tags, refresh_token) FROM stdin;
\.


--
-- TOC entry 8175 (class 0 OID 18424)
-- Dependencies: 384
-- Data for Name: tabOAuth Client; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabOAuth Client" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, scopes, redirect_uris, app_name, default_redirect_uri, _assign, _liked_by, _comments, "user", client_id, client_secret, skip_authorization, grant_type, _user_tags, response_type) FROM stdin;
\.


--
-- TOC entry 8176 (class 0 OID 18434)
-- Dependencies: 385
-- Data for Name: tabOffer Letter; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabOffer Letter" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, status, job_applicant, terms, designation, select_terms, _comments, company, _assign, _liked_by, amended_from, _user_tags, applicant_name, offer_date) FROM stdin;
\.


--
-- TOC entry 8177 (class 0 OID 18442)
-- Dependencies: 386
-- Data for Name: tabOffer Letter Term; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabOffer Letter Term" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, offer_term, value) FROM stdin;
\.


--
-- TOC entry 8178 (class 0 OID 18450)
-- Dependencies: 387
-- Data for Name: tabOffer Term; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabOffer Term" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, offer_term, _assign, _user_tags, _comments, _liked_by) FROM stdin;
\.


--
-- TOC entry 8181 (class 0 OID 18478)
-- Dependencies: 390
-- Data for Name: tabOpportunity Item; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabOpportunity Item" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, basic_rate, description, item_name, brand, item_group, item_code, qty, image, uom) FROM stdin;
\.


--
-- TOC entry 8199 (class 0 OID 18662)
-- Dependencies: 408
-- Data for Name: tabPOS Customer Group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabPOS Customer Group" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, customer_group) FROM stdin;
\.


--
-- TOC entry 8200 (class 0 OID 18670)
-- Dependencies: 409
-- Data for Name: tabPOS Item Group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabPOS Item Group" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, item_group) FROM stdin;
\.


--
-- TOC entry 8201 (class 0 OID 18678)
-- Dependencies: 410
-- Data for Name: tabPOS Profile; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabPOS Profile" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, campaign, apply_discount, naming_series, expense_account, currency, letter_head, cost_center, apply_discount_on, update_stock, _comments, selling_price_list, tc_name, allow_delete, allow_user_to_edit_rate, warehouse, account_for_change_amount, territory, company, write_off_account, _liked_by, ignore_pricing_rule, write_off_cost_center, taxes_and_charges, _assign, "user", _user_tags, customer, print_format, income_account, select_print_heading) FROM stdin;
\.


--
-- TOC entry 8182 (class 0 OID 18488)
-- Dependencies: 391
-- Data for Name: tabPacked Item; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabPacked Item" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, serial_no, qty, parent_detail_docname, target_warehouse, actual_qty, page_break, item_name, warehouse, uom, description, item_code, projected_qty, parent_item, batch_no, prevdoc_doctype) FROM stdin;
\.


--
-- TOC entry 8183 (class 0 OID 18500)
-- Dependencies: 392
-- Data for Name: tabPacking Slip; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabPacking Slip" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, net_weight_uom, from_case_no, naming_series, gross_weight_uom, letter_head, to_case_no, _user_tags, amended_from, net_weight_pkg, _liked_by, _assign, _comments, gross_weight_pkg, delivery_note) FROM stdin;
\.


--
-- TOC entry 8184 (class 0 OID 18510)
-- Dependencies: 393
-- Data for Name: tabPacking Slip Item; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabPacking Slip Item" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, weight_uom, description, item_name, page_break, net_weight, qty, stock_uom, item_code, batch_no, dn_detail) FROM stdin;
\.


--
-- TOC entry 8186 (class 0 OID 18529)
-- Dependencies: 395
-- Data for Name: tabPage Role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabPage Role" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, role) FROM stdin;
\.


--
-- TOC entry 8187 (class 0 OID 18537)
-- Dependencies: 396
-- Data for Name: tabParty Account; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabParty Account" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, company, account) FROM stdin;
\.


--
-- TOC entry 8188 (class 0 OID 18545)
-- Dependencies: 397
-- Data for Name: tabPatch Log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabPatch Log" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, _comments, _assign, _user_tags, _liked_by, patch) FROM stdin;
\.


--
-- TOC entry 8189 (class 0 OID 18553)
-- Dependencies: 398
-- Data for Name: tabPayment Entry; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabPayment Entry" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, naming_series, clearance_date, paid_to, base_paid_amount, reference_date, letter_head, _liked_by, reference_no, print_heading, unallocated_amount, allocate_payment_amount, mode_of_payment, target_exchange_rate, title, party_type, total_allocated_amount, amended_from, base_total_allocated_amount, party, base_received_amount, _comments, source_exchange_rate, company, paid_from, party_balance, party_name, remarks, _user_tags, paid_to_account_currency, paid_from_account_balance, paid_from_account_currency, paid_to_account_balance, paid_amount, _assign, received_amount, project, payment_type, difference_amount, posting_date) FROM stdin;
\.


--
-- TOC entry 8190 (class 0 OID 18575)
-- Dependencies: 399
-- Data for Name: tabPayment Entry Deduction; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabPayment Entry Deduction" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, amount, account, cost_center) FROM stdin;
\.


--
-- TOC entry 8191 (class 0 OID 18584)
-- Dependencies: 400
-- Data for Name: tabPayment Entry Reference; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabPayment Entry Reference" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, due_date, total_amount, reference_doctype, reference_name, outstanding_amount, exchange_rate, allocated_amount) FROM stdin;
\.


--
-- TOC entry 8192 (class 0 OID 18596)
-- Dependencies: 401
-- Data for Name: tabPayment Gateway; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabPayment Gateway" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, _comments, _assign, _user_tags, gateway, _liked_by) FROM stdin;
\.


--
-- TOC entry 8193 (class 0 OID 18604)
-- Dependencies: 402
-- Data for Name: tabPayment Gateway Account; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabPayment Gateway Account" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, _liked_by, _comments, _assign, is_default, currency, message, _user_tags, payment_account, payment_gateway) FROM stdin;
\.


--
-- TOC entry 8194 (class 0 OID 18613)
-- Dependencies: 403
-- Data for Name: tabPayment Reconciliation Invoice; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabPayment Reconciliation Invoice" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, invoice_type, invoice_date, outstanding_amount, amount, invoice_number) FROM stdin;
\.


--
-- TOC entry 8195 (class 0 OID 18623)
-- Dependencies: 404
-- Data for Name: tabPayment Reconciliation Payment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabPayment Reconciliation Payment" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, remark, reference_type, amount, reference_row, is_advance, reference_name, invoice_number, allocated_amount, posting_date) FROM stdin;
\.


--
-- TOC entry 8196 (class 0 OID 18633)
-- Dependencies: 405
-- Data for Name: tabPayment Request; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabPayment Request" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, payment_url, naming_series, currency, message, subject, reference_doctype, payment_gateway, _comments, amended_from, status, _liked_by, reference_name, _assign, email_to, _user_tags, payment_account, mute_email, grand_total, print_format, make_sales_invoice, payment_gateway_account) FROM stdin;
\.


--
-- TOC entry 8197 (class 0 OID 18645)
-- Dependencies: 406
-- Data for Name: tabPeriod Closing Voucher; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabPeriod Closing Voucher" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, _liked_by, _comments, company, _assign, fiscal_year, amended_from, transaction_date, remarks, posting_date, _user_tags, closing_account_head) FROM stdin;
\.


--
-- TOC entry 8198 (class 0 OID 18653)
-- Dependencies: 407
-- Data for Name: tabPortal Menu Item; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabPortal Menu Item" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, reference_doctype, target, title, route, enabled, role) FROM stdin;
\.


--
-- TOC entry 8202 (class 0 OID 18693)
-- Dependencies: 411
-- Data for Name: tabPrice List; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabPrice List" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, selling, _comments, _assign, enabled, _liked_by, currency, price_list_name, _user_tags, buying) FROM stdin;
\.


--
-- TOC entry 8203 (class 0 OID 18704)
-- Dependencies: 412
-- Data for Name: tabPrice List Country; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabPrice List Country" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, country) FROM stdin;
\.


--
-- TOC entry 8204 (class 0 OID 18712)
-- Dependencies: 413
-- Data for Name: tabPricing Rule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabPricing Rule" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, item_group, price_or_discount, campaign, margin_rate_or_amount, _liked_by, supplier_type, priority, valid_from, title, _comments, margin_type, supplier, territory, company, price, sales_partner, selling, applicable_for, brand, _assign, apply_on, item_code, disable, for_price_list, max_qty, min_qty, _user_tags, buying, customer, valid_upto, customer_group, discount_percentage) FROM stdin;
\.


--
-- TOC entry 8205 (class 0 OID 18731)
-- Dependencies: 414
-- Data for Name: tabPrint Format; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabPrint Format" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, module, disabled, custom_format, font, _comments, html, show_section_headings, _liked_by, _assign, print_format_builder, standard, _user_tags, print_format_type, format_data, doc_type, line_breaks, align_labels_left, css) FROM stdin;
\.


--
-- TOC entry 8206 (class 0 OID 18748)
-- Dependencies: 415
-- Data for Name: tabPrint Heading; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabPrint Heading" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, _liked_by, description, _user_tags, _assign, print_heading, _comments) FROM stdin;
\.


--
-- TOC entry 8207 (class 0 OID 18756)
-- Dependencies: 416
-- Data for Name: tabProduct Bundle; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabProduct Bundle" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, _liked_by, new_item_code, _assign, _comments, _user_tags) FROM stdin;
\.


--
-- TOC entry 8208 (class 0 OID 18764)
-- Dependencies: 417
-- Data for Name: tabProduct Bundle Item; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabProduct Bundle Item" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, rate, uom, description, item_code, qty) FROM stdin;
\.


--
-- TOC entry 8209 (class 0 OID 18774)
-- Dependencies: 418
-- Data for Name: tabProduction Order; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabProduction Order" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, additional_operating_cost, naming_series, produced_qty, qty, fg_warehouse, use_multi_level_bom, project, planned_end_date, material_transferred_for_manufacturing, actual_end_date, amended_from, stock_uom, _comments, status, _liked_by, planned_operating_cost, description, company, _assign, production_item, planned_start_date, actual_start_date, material_request, actual_operating_cost, _user_tags, source_warehouse, expected_delivery_date, bom_no, wip_warehouse, sales_order, material_request_item, scrap_warehouse, total_operating_cost) FROM stdin;
\.


--
-- TOC entry 8210 (class 0 OID 18792)
-- Dependencies: 419
-- Data for Name: tabProduction Order Item; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabProduction Order Item" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, required_qty, transferred_qty, item_code) FROM stdin;
\.


--
-- TOC entry 8211 (class 0 OID 18802)
-- Dependencies: 420
-- Data for Name: tabProduction Order Operation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabProduction Order Operation" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, status, actual_start_time, workstation, completed_qty, planned_operating_cost, description, hour_rate, actual_end_time, actual_operating_cost, actual_operation_time, operation, planned_end_time, time_in_mins, planned_start_time) FROM stdin;
\.


--
-- TOC entry 8212 (class 0 OID 18817)
-- Dependencies: 421
-- Data for Name: tabProduction Plan Item; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabProduction Plan Item" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, material_request_item, bom_no, description, sales_order, pending_qty, planned_qty, item_code, planned_start_date, stock_uom, material_request, warehouse) FROM stdin;
\.


--
-- TOC entry 8213 (class 0 OID 18827)
-- Dependencies: 422
-- Data for Name: tabProduction Plan Material Request; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabProduction Plan Material Request" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, material_request, material_request_date) FROM stdin;
\.


--
-- TOC entry 8214 (class 0 OID 18835)
-- Dependencies: 423
-- Data for Name: tabProduction Plan Sales Order; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabProduction Plan Sales Order" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, customer, grand_total, sales_order_date, sales_order) FROM stdin;
\.


--
-- TOC entry 8216 (class 0 OID 18852)
-- Dependencies: 425
-- Data for Name: tabProgram Course; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabProgram Course" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, course, required, course_code, academic_term) FROM stdin;
\.


--
-- TOC entry 8217 (class 0 OID 18861)
-- Dependencies: 426
-- Data for Name: tabProgram Enrollment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabProgram Enrollment" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, enrollment_date, academic_year, _liked_by, student_category, _comments, image, _assign, amended_from, program, student_batch_name, student, student_name, _user_tags) FROM stdin;
\.


--
-- TOC entry 8218 (class 0 OID 18869)
-- Dependencies: 427
-- Data for Name: tabProgram Enrollment Fee; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabProgram Enrollment Fee" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, due_date, fee_structure, amount, academic_term) FROM stdin;
\.


--
-- TOC entry 8219 (class 0 OID 18878)
-- Dependencies: 428
-- Data for Name: tabProgram Enrollment Tool Student; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabProgram Enrollment Tool Student" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, student_name, student, student_applicant) FROM stdin;
\.


--
-- TOC entry 8220 (class 0 OID 18886)
-- Dependencies: 429
-- Data for Name: tabProgram Fee; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabProgram Fee" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, due_date, student_category, fee_structure, academic_term, amount) FROM stdin;
\.


--
-- TOC entry 8222 (class 0 OID 18914)
-- Dependencies: 431
-- Data for Name: tabProject Task; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabProject Task" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, status, end_date, task_id, title, task_weight, start_date, description) FROM stdin;
\.


--
-- TOC entry 8223 (class 0 OID 18924)
-- Dependencies: 432
-- Data for Name: tabProject User; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabProject User" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, welcome_email_sent, "user") FROM stdin;
\.


--
-- TOC entry 8224 (class 0 OID 18933)
-- Dependencies: 433
-- Data for Name: tabProperty Setter; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabProperty Setter" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, default_value, doc_type, property, _user_tags, _assign, value, doctype_or_field, _comments, property_type, field_name, _liked_by) FROM stdin;
\.


--
-- TOC entry 8225 (class 0 OID 18941)
-- Dependencies: 434
-- Data for Name: tabPurchase Invoice; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabPurchase Invoice" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, cash_bank_account, base_write_off_amount, apply_discount_on, return_against, tc_name, submit_on_creation, discount_amount, base_in_words, due_date, ignore_pricing_rule, write_off_cost_center, _assign, base_discount_amount, base_total_taxes_and_charges, supplier_name, taxes_and_charges_added, is_paid, is_return, select_print_heading, total_taxes_and_charges, write_off_amount, supplier_address, mode_of_payment, party_account_currency, price_list_currency, base_taxes_and_charges_added, contact_display, supplier, buying_price_list, write_off_account, next_date, terms, supplier_warehouse, shipping_address, contact_mobile, _user_tags, base_net_total, language, title, repeat_on_day_of_month, contact_person, in_words, recurring_print_format, additional_discount_percentage, base_paid_amount, conversion_rate, to_date, total_advance, posting_time, total, bill_no, rejected_warehouse, is_subcontracted, update_stock, _comments, base_total, from_date, notification_email_address, end_date, company, contact_email, grand_total, notify_by_email, is_recurring, taxes_and_charges_deducted, is_opening, posting_date, address_display, against_expense_account, naming_series, currency, letter_head, recurring_id, base_taxes_and_charges_deducted, paid_amount, credit_to, amended_from, base_grand_total, recurring_type, bill_date, status, _liked_by, taxes_and_charges, outstanding_amount, remarks, shipping_address_display, plc_conversion_rate, net_total) FROM stdin;
\.


--
-- TOC entry 8226 (class 0 OID 18985)
-- Dependencies: 435
-- Data for Name: tabPurchase Invoice Advance; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabPurchase Invoice Advance" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, reference_type, advance_amount, reference_row, reference_name, remarks, allocated_amount) FROM stdin;
\.


--
-- TOC entry 8227 (class 0 OID 18995)
-- Dependencies: 436
-- Data for Name: tabPurchase Invoice Item; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabPurchase Invoice Item" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, purchase_receipt, po_detail, image, landed_cost_voucher_amount, qty, item_tax_rate, rate, expense_account, cost_center, received_qty, rm_supp_cost, item_tax_amount, quality_inspection, page_break, base_net_rate, discount_percentage, item_name, base_net_amount, purchase_order, conversion_factor, asset, pr_detail, warehouse, uom, serial_no, description, brand, rejected_serial_no, base_rate, item_code, base_amount, rejected_qty, base_price_list_rate, rejected_warehouse, pricing_rule, price_list_rate, item_group, project, amount, net_rate, bom, batch_no, valuation_rate, net_amount, is_fixed_asset) FROM stdin;
\.


--
-- TOC entry 8228 (class 0 OID 19024)
-- Dependencies: 437
-- Data for Name: tabPurchase Order; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabPurchase Order" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, ref_sq, title, tc_name, base_grand_total, submit_on_creation, taxes_and_charges_added, base_in_words, ignore_pricing_rule, _assign, base_discount_amount, base_total_taxes_and_charges, supplier_name, discount_amount, select_print_heading, customer_contact_person, total_taxes_and_charges, supplier_address, party_account_currency, price_list_currency, base_taxes_and_charges_added, customer_contact_email, contact_display, supplier, buying_price_list, next_date, terms, advance_paid, contact_mobile, _user_tags, base_net_total, language, apply_discount_on, repeat_on_day_of_month, contact_person, in_words, recurring_print_format, additional_discount_percentage, conversion_rate, to_date, total, customer_name, is_subcontracted, _comments, base_total, from_date, notification_email_address, end_date, company, base_rounded_total, customer, grand_total, notify_by_email, is_recurring, taxes_and_charges_deducted, shipping_address, address_display, naming_series, currency, letter_head, recurring_id, base_taxes_and_charges_deducted, amended_from, transaction_date, recurring_type, _liked_by, status, group_same_items, customer_contact_display, taxes_and_charges, per_billed, shipping_address_display, customer_contact_mobile, per_received, plc_conversion_rate, net_total, contact_email) FROM stdin;
\.


--
-- TOC entry 8229 (class 0 OID 19063)
-- Dependencies: 438
-- Data for Name: tabPurchase Order Item; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabPurchase Order Item" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, schedule_date, stock_qty, base_price_list_rate, image, base_amount, base_net_amount, item_tax_rate, rate, received_qty, stock_uom, project, page_break, base_net_rate, item_name, qty, supplier_quotation, supplier_quotation_item, net_rate, conversion_factor, warehouse, billed_amt, supplier_part_no, uom, price_list_rate, description, returned_qty, net_amount, brand, base_rate, item_code, material_request, pricing_rule, sales_order_item, expected_delivery_date, sales_order, item_group, discount_percentage, material_request_item, amount, bom, delivered_by_supplier) FROM stdin;
\.


--
-- TOC entry 8230 (class 0 OID 19090)
-- Dependencies: 439
-- Data for Name: tabPurchase Order Item Supplied; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabPurchase Order Item Supplied" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, rm_item_code, rate, reference_name, bom_detail_no, required_qty, main_item_code, amount, conversion_factor, stock_uom) FROM stdin;
\.


--
-- TOC entry 8231 (class 0 OID 19102)
-- Dependencies: 440
-- Data for Name: tabPurchase Receipt; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabPurchase Receipt" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, lr_date, apply_discount_on, tc_name, taxes_and_charges_added, base_in_words, ignore_pricing_rule, _assign, base_discount_amount, base_total_taxes_and_charges, supplier_name, instructions, buying_price_list, discount_amount, is_return, select_print_heading, total_taxes_and_charges, supplier_address, lr_no, price_list_currency, base_taxes_and_charges_added, contact_display, supplier, terms, supplier_warehouse, _user_tags, base_net_total, language, title, range, contact_person, in_words, additional_discount_percentage, return_against, contact_mobile, conversion_rate, posting_time, total, bill_no, rejected_warehouse, is_subcontracted, _comments, base_total, company, base_rounded_total, grand_total, taxes_and_charges_deducted, shipping_address, posting_date, address_display, naming_series, currency, letter_head, base_taxes_and_charges_deducted, amended_from, base_grand_total, bill_date, status, _liked_by, taxes_and_charges, per_billed, transporter_name, remarks, shipping_address_display, plc_conversion_rate, net_total, contact_email) FROM stdin;
\.


--
-- TOC entry 8232 (class 0 OID 19135)
-- Dependencies: 441
-- Data for Name: tabPurchase Receipt Item; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabPurchase Receipt Item" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, schedule_date, stock_qty, image, qty, rate, cost_center, received_qty, stock_uom, item_tax_amount, quality_inspection, page_break, rejected_warehouse, base_net_rate, item_name, rejected_serial_no, base_net_amount, item_group, net_rate, conversion_factor, rm_supp_cost, base_price_list_rate, warehouse, billed_amt, uom, serial_no, description, landed_cost_voucher_amount, brand, barcode, base_rate, item_code, base_amount, rejected_qty, pricing_rule, price_list_rate, item_tax_rate, discount_percentage, purchase_order, project, amount, bom, batch_no, valuation_rate, purchase_order_item, net_amount) FROM stdin;
\.


--
-- TOC entry 8233 (class 0 OID 19165)
-- Dependencies: 442
-- Data for Name: tabPurchase Receipt Item Supplied; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabPurchase Receipt Item Supplied" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, rm_item_code, description, rate, conversion_factor, reference_name, serial_no, amount, main_item_code, required_qty, stock_uom, current_stock, batch_no, consumed_qty, bom_detail_no) FROM stdin;
\.


--
-- TOC entry 8234 (class 0 OID 19179)
-- Dependencies: 443
-- Data for Name: tabPurchase Taxes and Charges; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabPurchase Taxes and Charges" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, charge_type, category, total, tax_amount, description, item_wise_tax_detail, base_tax_amount_after_discount_amount, row_id, base_total, add_deduct_tax, included_in_print_rate, rate, tax_amount_after_discount_amount, cost_center, base_tax_amount, account_head) FROM stdin;
\.


--
-- TOC entry 8235 (class 0 OID 19197)
-- Dependencies: 444
-- Data for Name: tabPurchase Taxes and Charges Template; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabPurchase Taxes and Charges Template" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, disabled, _liked_by, title, _comments, company, _assign, is_default, _user_tags) FROM stdin;
\.


--
-- TOC entry 8236 (class 0 OID 19207)
-- Dependencies: 445
-- Data for Name: tabQuality Inspection; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabQuality Inspection" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, naming_series, report_date, item_name, _comments, verified_by, reference_type, amended_from, _liked_by, description, reference_name, inspection_type, _assign, item_serial_no, item_code, remarks, _user_tags, inspected_by, sample_size, batch_no) FROM stdin;
\.


--
-- TOC entry 8237 (class 0 OID 19217)
-- Dependencies: 446
-- Data for Name: tabQuality Inspection Reading; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabQuality Inspection Reading" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, status, reading_10, value, reading_5, reading_8, reading_9, reading_1, reading_2, reading_3, reading_4, specification, reading_6, reading_7) FROM stdin;
\.


--
-- TOC entry 8239 (class 0 OID 19255)
-- Dependencies: 448
-- Data for Name: tabQuotation Item; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabQuotation Item" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, base_price_list_rate, base_amount, qty, item_tax_rate, rate, actual_qty, page_break, base_net_rate, discount_percentage, item_name, base_net_amount, net_rate, stock_uom, warehouse, image, description, prevdoc_docname, brand, base_rate, item_code, projected_qty, margin_type, pricing_rule, price_list_rate, margin_rate_or_amount, item_group, amount, customer_item_code, net_amount, total_margin, prevdoc_doctype) FROM stdin;
\.


--
-- TOC entry 8240 (class 0 OID 19280)
-- Dependencies: 449
-- Data for Name: tabQuotation Lost Reason; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabQuotation Lost Reason" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, order_lost_reason, _assign, _user_tags, _comments, _liked_by) FROM stdin;
\.


--
-- TOC entry 8242 (class 0 OID 19299)
-- Dependencies: 451
-- Data for Name: tabRequest for Quotation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabRequest for Quotation" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, standard_reply, naming_series, fiscal_year, letter_head, terms, _comments, tc_name, amended_from, transaction_date, status, _liked_by, vendor, company, _assign, _user_tags, select_print_heading, message_for_supplier) FROM stdin;
\.


--
-- TOC entry 8243 (class 0 OID 19307)
-- Dependencies: 452
-- Data for Name: tabRequest for Quotation Item; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabRequest for Quotation Item" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, image, qty, page_break, item_name, warehouse, supplier_part_no, uom, project_name, description, brand, item_code, material_request, schedule_date, item_group, material_request_item) FROM stdin;
\.


--
-- TOC entry 8244 (class 0 OID 19317)
-- Dependencies: 453
-- Data for Name: tabRequest for Quotation Supplier; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabRequest for Quotation Supplier" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, email_id, contact, send_email, supplier_name, supplier) FROM stdin;
\.


--
-- TOC entry 8273 (class 0 OID 19720)
-- Dependencies: 482
-- Data for Name: tabSMS Log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabSMS Log" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, requested_numbers, _liked_by, sender_name, _comments, _assign, sent_on, no_of_sent_sms, message, no_of_requested_sms, _user_tags, sent_to) FROM stdin;
\.


--
-- TOC entry 8274 (class 0 OID 19730)
-- Dependencies: 483
-- Data for Name: tabSMS Parameter; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabSMS Parameter" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, parameter, value) FROM stdin;
\.


--
-- TOC entry 8247 (class 0 OID 19344)
-- Dependencies: 456
-- Data for Name: tabSalary Component; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabSalary Component" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, _liked_by, description, _user_tags, _assign, salary_component_abbr, salary_component, type, _comments) FROM stdin;
\.


--
-- TOC entry 8248 (class 0 OID 19352)
-- Dependencies: 457
-- Data for Name: tabSalary Component Account; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabSalary Component Account" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, company, default_account) FROM stdin;
\.


--
-- TOC entry 8249 (class 0 OID 19360)
-- Dependencies: 458
-- Data for Name: tabSalary Detail; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabSalary Detail" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, default_amount, amount_based_on_formula, depends_on_lwp, amount, abbr, salary_component, formula, condition) FROM stdin;
\.


--
-- TOC entry 8250 (class 0 OID 19372)
-- Dependencies: 459
-- Data for Name: tabSalary Slip; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabSalary Slip" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, payment_days, salary_structure, journal_entry, total_in_words, letter_head, _liked_by, payroll_frequency, salary_slip_based_on_timesheet, leave_encashment_amount, _comments, amended_from, branch, department, start_date, leave_without_pay, status, bank_name, _assign, total_deduction, end_date, company, employee, total_working_days, employee_name, _user_tags, bank_account_no, designation, net_pay, rounded_total, hour_rate, total_working_hours, posting_date, gross_pay, arrear_amount) FROM stdin;
\.


--
-- TOC entry 8251 (class 0 OID 19392)
-- Dependencies: 460
-- Data for Name: tabSalary Slip Timesheet; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabSalary Slip Timesheet" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, working_hours, time_sheet) FROM stdin;
\.


--
-- TOC entry 8252 (class 0 OID 19401)
-- Dependencies: 461
-- Data for Name: tabSalary Structure; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabSalary Structure" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, mode_of_payment, letter_head, to_date, total_earning, _comments, from_date, salary_component, _liked_by, total_deduction, company, _assign, is_active, is_default, net_pay, _user_tags, payment_account, hour_rate, salary_slip_based_on_timesheet, payroll_frequency) FROM stdin;
\.


--
-- TOC entry 8253 (class 0 OID 19417)
-- Dependencies: 462
-- Data for Name: tabSalary Structure Employee; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabSalary Structure Employee" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, employee, variable, base, employee_name) FROM stdin;
\.


--
-- TOC entry 8254 (class 0 OID 19427)
-- Dependencies: 463
-- Data for Name: tabSales Invoice; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabSales Invoice" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, cash_bank_account, base_write_off_amount, title, selling_price_list, return_against, tc_name, submit_on_creation, base_in_words, due_date, write_off_cost_center, _assign, base_discount_amount, base_total_taxes_and_charges, discount_amount, is_return, write_off_outstanding_amount_automatically, select_print_heading, source, against_income_account, write_off_amount, party_account_currency, net_total, price_list_currency, contact_display, next_date, terms, is_opening, customer_address, total_commission, contact_mobile, _user_tags, c_form_applicable, base_net_total, shipping_address_name, apply_discount_on, offline_pos_name, repeat_on_day_of_month, contact_person, in_words, shipping_address, recurring_print_format, additional_discount_percentage, campaign, base_paid_amount, remarks, conversion_rate, to_date, total_advance, posting_time, total, customer_name, commission_rate, update_stock, _comments, base_total, from_date, account_for_change_amount, territory, sales_partner, end_date, company, base_rounded_total, is_pos, customer, grand_total, notify_by_email, is_recurring, language, project, rounded_total, posting_date, customer_group, address_display, naming_series, currency, letter_head, recurring_id, shipping_rule, ignore_pricing_rule, paid_amount, debit_to, base_change_amount, amended_from, base_grand_total, recurring_type, status, total_billing_amount, _liked_by, taxes_and_charges, outstanding_amount, change_amount, write_off_account, notification_email_address, c_form_no, plc_conversion_rate, total_taxes_and_charges, contact_email) FROM stdin;
\.


--
-- TOC entry 8255 (class 0 OID 19474)
-- Dependencies: 464
-- Data for Name: tabSales Invoice Advance; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabSales Invoice Advance" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, reference_type, advance_amount, reference_row, reference_name, remarks, allocated_amount) FROM stdin;
\.


--
-- TOC entry 8256 (class 0 OID 19484)
-- Dependencies: 465
-- Data for Name: tabSales Invoice Item; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabSales Invoice Item" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, item_group, base_price_list_rate, actual_batch_qty, serial_no, base_amount, expense_account, item_tax_rate, delivery_note, cost_center, target_warehouse, dn_detail, actual_qty, quality_inspection, so_detail, base_net_rate, rate, discount_percentage, item_name, qty, base_net_amount, margin_type, net_rate, stock_uom, asset, warehouse, image, description, brand, barcode, base_rate, item_code, page_break, pricing_rule, delivered_qty, net_amount, price_list_rate, sales_order, margin_rate_or_amount, income_account, amount, customer_item_code, batch_no, delivered_by_supplier, is_fixed_asset, total_margin) FROM stdin;
\.


--
-- TOC entry 8257 (class 0 OID 19512)
-- Dependencies: 466
-- Data for Name: tabSales Invoice Payment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabSales Invoice Payment" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, account, mode_of_payment, base_amount, amount, type) FROM stdin;
\.


--
-- TOC entry 8258 (class 0 OID 19522)
-- Dependencies: 467
-- Data for Name: tabSales Invoice Timesheet; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabSales Invoice Timesheet" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, timesheet_detail, billing_hours, time_sheet, billing_amount) FROM stdin;
\.


--
-- TOC entry 8259 (class 0 OID 19532)
-- Dependencies: 468
-- Data for Name: tabSales Order; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabSales Order" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, billing_status, title, selling_price_list, tc_name, source, submit_on_creation, base_in_words, ignore_pricing_rule, _assign, base_discount_amount, notify_by_email, base_total_taxes_and_charges, discount_amount, base_grand_total, select_print_heading, delivery_date, total_taxes_and_charges, party_account_currency, po_date, price_list_currency, contact_display, next_date, terms, advance_paid, customer_address, total_commission, contact_mobile, delivery_status, _user_tags, base_net_total, language, rounded_total, shipping_address_name, apply_discount_on, po_no, repeat_on_day_of_month, contact_person, in_words, recurring_print_format, additional_discount_percentage, campaign, conversion_rate, to_date, total, customer_name, commission_rate, _comments, base_total, from_date, territory, sales_partner, end_date, company, contact_email, customer, grand_total, notification_email_address, is_recurring, project, shipping_address, customer_group, address_display, naming_series, currency, letter_head, recurring_id, shipping_rule, order_type, amended_from, transaction_date, recurring_type, per_delivered, _liked_by, status, group_same_items, taxes_and_charges, per_billed, plc_conversion_rate, net_total, base_rounded_total) FROM stdin;
\.


--
-- TOC entry 8260 (class 0 OID 19570)
-- Dependencies: 469
-- Data for Name: tabSales Order Item; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabSales Order Item" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, image, base_amount, qty, margin_rate_or_amount, rate, target_warehouse, actual_qty, stock_uom, page_break, base_net_rate, discount_percentage, item_name, base_net_amount, margin_type, net_rate, transaction_date, ordered_qty, base_price_list_rate, supplier, description, prevdoc_docname, returned_qty, brand, base_rate, item_code, produced_qty, projected_qty, warehouse, billed_amt, pricing_rule, delivered_qty, net_amount, price_list_rate, item_tax_rate, item_group, planned_qty, gross_profit, amount, customer_item_code, valuation_rate, delivered_by_supplier, total_margin) FROM stdin;
\.


--
-- TOC entry 8261 (class 0 OID 19604)
-- Dependencies: 470
-- Data for Name: tabSales Partner; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabSales Partner" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, partner_website, logo, commission_rate, partner_name, _comments, distribution_id, territory, _liked_by, description, _assign, partner_type, show_in_website, _user_tags, route, introduction) FROM stdin;
\.


--
-- TOC entry 8262 (class 0 OID 19614)
-- Dependencies: 471
-- Data for Name: tabSales Person; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabSales Person" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, old_parent, _assign, rgt, lft, is_group, sales_person_name, enabled, distribution_id, _liked_by, _comments, employee, parent_sales_person, _user_tags) FROM stdin;
\.


--
-- TOC entry 8263 (class 0 OID 19626)
-- Dependencies: 472
-- Data for Name: tabSales Taxes and Charges; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabSales Taxes and Charges" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, charge_type, base_tax_amount, tax_amount, description, item_wise_tax_detail, base_tax_amount_after_discount_amount, base_total, included_in_print_rate, rate, account_head, cost_center, tax_amount_after_discount_amount, row_id, total) FROM stdin;
\.


--
-- TOC entry 8264 (class 0 OID 19642)
-- Dependencies: 473
-- Data for Name: tabSales Taxes and Charges Template; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabSales Taxes and Charges Template" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, disabled, _liked_by, title, _comments, company, _assign, is_default, _user_tags) FROM stdin;
\.


--
-- TOC entry 8265 (class 0 OID 19652)
-- Dependencies: 474
-- Data for Name: tabSales Team; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabSales Team" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, contact_no, incentives, allocated_percentage, sales_person, allocated_amount) FROM stdin;
\.


--
-- TOC entry 8266 (class 0 OID 19663)
-- Dependencies: 475
-- Data for Name: tabSerial No; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabSerial No" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, purchase_time, delivery_document_type, serial_no, purchase_document_no, supplier, customer_name, amc_expiry_date, purchase_rate, item_name, _user_tags, purchase_document_type, brand, _liked_by, description, purchase_date, company, _assign, item_code, warehouse, _comments, supplier_name, is_cancelled, maintenance_status, customer, delivery_time, delivery_document_no, item_group, warranty_period, serial_no_details, warranty_expiry_date, delivery_date) FROM stdin;
\.


--
-- TOC entry 8269 (class 0 OID 19684)
-- Dependencies: 478
-- Data for Name: tabShipping Rule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabShipping Rule" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, calculate_based_on, _assign, _user_tags, worldwide_shipping, company, account, label, disabled, _liked_by, _comments, cost_center) FROM stdin;
\.


--
-- TOC entry 8270 (class 0 OID 19695)
-- Dependencies: 479
-- Data for Name: tabShipping Rule Condition; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabShipping Rule Condition" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, to_value, from_value, shipping_amount) FROM stdin;
\.


--
-- TOC entry 8271 (class 0 OID 19706)
-- Dependencies: 480
-- Data for Name: tabShipping Rule Country; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabShipping Rule Country" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, country) FROM stdin;
\.


--
-- TOC entry 8275 (class 0 OID 19738)
-- Dependencies: 484
-- Data for Name: tabStandard Reply; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabStandard Reply" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, _liked_by, _comments, _assign, _user_tags, response, subject) FROM stdin;
\.


--
-- TOC entry 8276 (class 0 OID 19746)
-- Dependencies: 485
-- Data for Name: tabStock Entry; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabStock Entry" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, use_multi_level_bom, delivery_note_no, supplier_address, naming_series, fg_completed_qty, letter_head, _liked_by, purchase_receipt_no, posting_time, customer_name, title, _comments, from_warehouse, amended_from, purchase_order, from_bom, to_warehouse, supplier, value_difference, credit_note, sales_invoice_no, company, bom_no, customer_address, purpose, supplier_name, remarks, _user_tags, total_additional_costs, customer, total_amount, total_incoming_value, project, _assign, select_print_heading, posting_date, production_order, total_outgoing_value) FROM stdin;
\.


--
-- TOC entry 8277 (class 0 OID 19764)
-- Dependencies: 486
-- Data for Name: tabStock Entry Detail; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabStock Entry Detail" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, t_warehouse, transfer_qty, basic_amount, image, serial_no, expense_account, cost_center, actual_qty, s_warehouse, stock_uom, item_name, additional_cost, conversion_factor, uom, basic_rate, description, barcode, item_code, qty, bom_no, material_request_item, amount, batch_no, valuation_rate, material_request) FROM stdin;
\.


--
-- TOC entry 8278 (class 0 OID 19781)
-- Dependencies: 487
-- Data for Name: tabStock Ledger Entry; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabStock Ledger Entry" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, serial_no, fiscal_year, voucher_type, posting_time, voucher_no, qty_after_transaction, _comments, incoming_rate, voucher_detail_no, actual_qty, stock_uom, warehouse, _liked_by, company, _assign, item_code, stock_queue, valuation_rate, outgoing_rate, is_cancelled, stock_value, _user_tags, project, batch_no, stock_value_difference, posting_date) FROM stdin;
\.


--
-- TOC entry 8279 (class 0 OID 19796)
-- Dependencies: 488
-- Data for Name: tabStock Reconciliation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabStock Reconciliation" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, _assign, difference_amount, company, _liked_by, amended_from, reconciliation_json, _comments, naming_series, expense_account, posting_date, cost_center, _user_tags, posting_time) FROM stdin;
\.


--
-- TOC entry 8280 (class 0 OID 19805)
-- Dependencies: 489
-- Data for Name: tabStock Reconciliation Item; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabStock Reconciliation Item" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, barcode, amount_difference, current_amount, item_name, current_qty, quantity_difference, item_code, qty, warehouse, amount, valuation_rate, current_valuation_rate) FROM stdin;
\.


--
-- TOC entry 8282 (class 0 OID 19828)
-- Dependencies: 491
-- Data for Name: tabStudent Admission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabStudent Admission" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, academic_year, _liked_by, application_fee, title, introduction, _user_tags, route, _assign, admission_start_date, admission_end_date, currency, program, naming_series_for_student_applicant, publish, _comments, eligibility, application_form_route) FROM stdin;
\.


--
-- TOC entry 8283 (class 0 OID 19838)
-- Dependencies: 492
-- Data for Name: tabStudent Applicant; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabStudent Applicant" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, program, academic_year, last_name, blood_group, naming_series, image, pincode, student_mobile_number, student_email_id, city, first_name, middle_name, title, _comments, amended_from, state, date_of_birth, application_status, _liked_by, _assign, paid, student_admission, nationality, _user_tags, application_date, gender, address_line_2, address_line_1) FROM stdin;
\.


--
-- TOC entry 8284 (class 0 OID 19847)
-- Dependencies: 493
-- Data for Name: tabStudent Attendance; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabStudent Attendance" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, status, _liked_by, course_schedule, student_batch, _assign, amended_from, _comments, student, date, student_name, _user_tags) FROM stdin;
\.


--
-- TOC entry 8285 (class 0 OID 19856)
-- Dependencies: 494
-- Data for Name: tabStudent Batch; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabStudent Batch" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, academic_year, _comments, enabled, academic_term, _assign, program, student_batch_name, _user_tags, _liked_by) FROM stdin;
\.


--
-- TOC entry 8286 (class 0 OID 19865)
-- Dependencies: 495
-- Data for Name: tabStudent Batch Instructor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabStudent Batch Instructor" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, instructor_name, instructor) FROM stdin;
\.


--
-- TOC entry 8287 (class 0 OID 19873)
-- Dependencies: 496
-- Data for Name: tabStudent Batch Name; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabStudent Batch Name" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, batch_name, _comments, _assign, _user_tags, _liked_by) FROM stdin;
\.


--
-- TOC entry 8288 (class 0 OID 19881)
-- Dependencies: 497
-- Data for Name: tabStudent Batch Student; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabStudent Batch Student" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, active, student_name, student) FROM stdin;
\.


--
-- TOC entry 8289 (class 0 OID 19890)
-- Dependencies: 498
-- Data for Name: tabStudent Category; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabStudent Category" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, category, _comments, _assign, _user_tags, _liked_by) FROM stdin;
\.


--
-- TOC entry 8290 (class 0 OID 19898)
-- Dependencies: 499
-- Data for Name: tabStudent Group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabStudent Group" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, academic_year, _liked_by, student_batch, _assign, max_strength, academic_term, amended_from, program, course, _user_tags, _comments) FROM stdin;
\.


--
-- TOC entry 8291 (class 0 OID 19907)
-- Dependencies: 500
-- Data for Name: tabStudent Group Creation Tool Course; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabStudent Group Creation Tool Course" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, course, student_group_name, course_code, max_strength) FROM stdin;
\.


--
-- TOC entry 8292 (class 0 OID 19916)
-- Dependencies: 501
-- Data for Name: tabStudent Group Student; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabStudent Group Student" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, active, student_name, student) FROM stdin;
\.


--
-- TOC entry 8293 (class 0 OID 19925)
-- Dependencies: 502
-- Data for Name: tabStudent Guardian; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabStudent Guardian" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, guardian, relation) FROM stdin;
\.


--
-- TOC entry 8294 (class 0 OID 19933)
-- Dependencies: 503
-- Data for Name: tabStudent Leave Application; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabStudent Leave Application" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, _liked_by, amended_from, _comments, _assign, from_date, mark_as_present, reason, to_date, student, student_name, _user_tags) FROM stdin;
\.


--
-- TOC entry 8295 (class 0 OID 19942)
-- Dependencies: 504
-- Data for Name: tabStudent Log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabStudent Log" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, _liked_by, log, _user_tags, _assign, _seen, _comments, student, date, student_name, type) FROM stdin;
\.


--
-- TOC entry 8296 (class 0 OID 19950)
-- Dependencies: 505
-- Data for Name: tabStudent Sibling; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabStudent Sibling" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, gender, date_of_birth, program, full_name, institution) FROM stdin;
\.


--
-- TOC entry 8297 (class 0 OID 19958)
-- Dependencies: 506
-- Data for Name: tabStudent Siblings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabStudent Siblings" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, gender, date_of_birth, name1) FROM stdin;
\.


--
-- TOC entry 8299 (class 0 OID 19977)
-- Dependencies: 508
-- Data for Name: tabSupplier Quotation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabSupplier Quotation" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, additional_discount_percentage, naming_series, contact_mobile, net_total, currency, conversion_rate, base_taxes_and_charges_deducted, total, select_print_heading, is_subcontracted, title, _user_tags, base_total, transaction_date, base_taxes_and_charges_added, tc_name, amended_from, base_grand_total, _comments, supplier_address, supplier, contact_display, buying_price_list, company, status, _liked_by, terms, ignore_pricing_rule, base_rounded_total, taxes_and_charges, _assign, grand_total, base_discount_amount, base_total_taxes_and_charges, supplier_name, base_in_words, opportunity, taxes_and_charges_added, base_net_total, in_words, taxes_and_charges_deducted, language, address_display, discount_amount, apply_discount_on, letter_head, plc_conversion_rate, total_taxes_and_charges, price_list_currency, contact_email, contact_person) FROM stdin;
\.


--
-- TOC entry 8300 (class 0 OID 20007)
-- Dependencies: 509
-- Data for Name: tabSupplier Quotation Item; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabSupplier Quotation Item" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, stock_qty, image, base_amount, qty, item_tax_rate, rate, stock_uom, project, page_break, base_net_rate, discount_percentage, item_name, base_net_amount, net_rate, conversion_factor, base_price_list_rate, warehouse, supplier_part_no, uom, description, brand, base_rate, item_code, material_request, pricing_rule, price_list_rate, request_for_quotation, item_group, material_request_item, amount, request_for_quotation_item, net_amount, prevdoc_doctype) FROM stdin;
\.


--
-- TOC entry 8301 (class 0 OID 20030)
-- Dependencies: 510
-- Data for Name: tabSupplier Type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabSupplier Type" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, _liked_by, _comments, _assign, credit_days_based_on, credit_days, supplier_type, _user_tags) FROM stdin;
\.


--
-- TOC entry 8303 (class 0 OID 20047)
-- Dependencies: 512
-- Data for Name: tabTag Category; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabTag Category" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, _liked_by, _user_tags, _assign, _comments, category_name) FROM stdin;
\.


--
-- TOC entry 8304 (class 0 OID 20055)
-- Dependencies: 513
-- Data for Name: tabTag Doc Category; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabTag Doc Category" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, tagdoc) FROM stdin;
\.


--
-- TOC entry 8305 (class 0 OID 20063)
-- Dependencies: 514
-- Data for Name: tabTarget Detail; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabTarget Detail" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, item_group, target_qty, fiscal_year, target_amount) FROM stdin;
\.


--
-- TOC entry 8307 (class 0 OID 20088)
-- Dependencies: 516
-- Data for Name: tabTask Depends On; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabTask Depends On" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, task, subject) FROM stdin;
\.


--
-- TOC entry 8308 (class 0 OID 20096)
-- Dependencies: 517
-- Data for Name: tabTax Rule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabTax Rule" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, sales_tax_template, to_date, billing_country, use_for_shopping_cart, _comments, tax_type, priority, from_date, supplier, billing_county, _liked_by, shipping_city, purchase_tax_template, company, _assign, shipping_state, shipping_county, supplier_type, _user_tags, customer, billing_city, customer_group, shipping_country, billing_state) FROM stdin;
\.


--
-- TOC entry 8309 (class 0 OID 20107)
-- Dependencies: 518
-- Data for Name: tabTerms and Conditions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabTerms and Conditions" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, _liked_by, terms, title, _comments, _assign, disabled, _user_tags) FROM stdin;
\.


--
-- TOC entry 8312 (class 0 OID 20143)
-- Dependencies: 521
-- Data for Name: tabTimesheet Detail; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabTimesheet Detail" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, billing_hours, costing_rate, billing_amount, operation, costing_amount, completed_qty, billable, to_time, from_time, hours, workstation, task, sales_invoice, billing_rate, project, operation_id, activity_type) FROM stdin;
\.


--
-- TOC entry 8314 (class 0 OID 20169)
-- Dependencies: 523
-- Data for Name: tabTop Bar Item; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabTop Bar Item" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, url, parent_label, "right", target, label) FROM stdin;
\.


--
-- TOC entry 8316 (class 0 OID 20186)
-- Dependencies: 525
-- Data for Name: tabTraining Event; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabTraining Event" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, trainer_email, course, event_status, contact_number, introduction, _comments, amended_from, location, supplier, type, _liked_by, event_name, start_time, _assign, _user_tags, send_email, trainer_name, end_time) FROM stdin;
\.


--
-- TOC entry 8317 (class 0 OID 20195)
-- Dependencies: 526
-- Data for Name: tabTraining Event Employee; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabTraining Event Employee" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, status, employee, employee_name) FROM stdin;
\.


--
-- TOC entry 8318 (class 0 OID 20204)
-- Dependencies: 527
-- Data for Name: tabTraining Feedback; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabTraining Feedback" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, _liked_by, feedback, amended_from, event_name, _comments, _assign, course, trainer_name, employee_name, employee, _user_tags, training_event) FROM stdin;
\.


--
-- TOC entry 8319 (class 0 OID 20212)
-- Dependencies: 528
-- Data for Name: tabTraining Result; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabTraining Result" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, _liked_by, training_event, _comments, _assign, amended_from, _user_tags) FROM stdin;
\.


--
-- TOC entry 8320 (class 0 OID 20220)
-- Dependencies: 529
-- Data for Name: tabTraining Result Employee; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabTraining Result Employee" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, grade, comments, hours, employee_name, employee) FROM stdin;
\.


--
-- TOC entry 8324 (class 0 OID 20254)
-- Dependencies: 533
-- Data for Name: tabUOM Conversion Detail; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabUOM Conversion Detail" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, conversion_factor, uom) FROM stdin;
\.


--
-- TOC entry 8322 (class 0 OID 20237)
-- Dependencies: 531
-- Data for Name: tabUnhandled Email; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabUnhandled Email" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, _liked_by, uid, _comments, _assign, raw, reason, email_account, _user_tags, message_id) FROM stdin;
\.


--
-- TOC entry 8326 (class 0 OID 20281)
-- Dependencies: 535
-- Data for Name: tabUser Email; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabUser Email" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, email_id, email_account, awaiting_password) FROM stdin;
\.


--
-- TOC entry 8329 (class 0 OID 20311)
-- Dependencies: 538
-- Data for Name: tabVehicle Log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabVehicle Log" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, naming_series, license_plate, invoice, fuel_qty, _comments, make, odometer, amended_from, supplier, _liked_by, price, _assign, employee, date, _user_tags, model) FROM stdin;
\.


--
-- TOC entry 8330 (class 0 OID 20322)
-- Dependencies: 539
-- Data for Name: tabVehicle Service; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabVehicle Service" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, expense_amount, frequency, type, service_item) FROM stdin;
\.


--
-- TOC entry 8333 (class 0 OID 20351)
-- Dependencies: 542
-- Data for Name: tabWarranty Claim; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabWarranty Claim" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, status, contact_email, naming_series, serial_no, _liked_by, resolved_by, warranty_amc_status, customer_name, amc_expiry_date, complaint_date, item_name, _comments, from_company, amended_from, contact_display, territory, address_display, complaint, service_address, description, complaint_raised_by, company, _assign, item_code, customer_address, contact_mobile, _user_tags, resolution_date, customer, resolution_details, customer_group, warranty_expiry_date, contact_person) FROM stdin;
\.


--
-- TOC entry 8334 (class 0 OID 20360)
-- Dependencies: 543
-- Data for Name: tabWeb Form; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabWeb Form" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, allow_edit, amount_based_on_field, amount_field, currency, accept_payment, payment_button_help, title, breadcrumbs, login_required, allow_delete, max_attachment_size, show_sidebar, payment_button_label, success_message, introduction_text, _liked_by, allow_multiple, _assign, allow_print, allow_incomplete, is_standard, _comments, module, _user_tags, doc_type, allow_comments, print_format, route, amount, success_url, published, web_page_link_text, payment_gateway) FROM stdin;
\.


--
-- TOC entry 8335 (class 0 OID 20383)
-- Dependencies: 544
-- Data for Name: tabWeb Form Field; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabWeb Form Field" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, read_only, description, "default", max_value, label, max_length, fieldname, fieldtype, reqd, hidden, options) FROM stdin;
\.


--
-- TOC entry 8336 (class 0 OID 20396)
-- Dependencies: 545
-- Data for Name: tabWeb Page; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabWeb Page" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, insert_style, header, _liked_by, title, _comments, text_align, show_sidebar, enable_comments, css, _assign, description, insert_code, javascript, slideshow, show_title, _user_tags, main_section, route, published, website_sidebar) FROM stdin;
\.


--
-- TOC entry 8337 (class 0 OID 20410)
-- Dependencies: 546
-- Data for Name: tabWebsite Item Group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabWebsite Item Group" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, item_group) FROM stdin;
\.


--
-- TOC entry 8338 (class 0 OID 20418)
-- Dependencies: 547
-- Data for Name: tabWebsite Sidebar; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabWebsite Sidebar" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, _liked_by, title, _comments, _assign, _user_tags) FROM stdin;
\.


--
-- TOC entry 8339 (class 0 OID 20426)
-- Dependencies: 548
-- Data for Name: tabWebsite Sidebar Item; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabWebsite Sidebar Item" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, route, "group", title) FROM stdin;
\.


--
-- TOC entry 8340 (class 0 OID 20434)
-- Dependencies: 549
-- Data for Name: tabWebsite Slideshow; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabWebsite Slideshow" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, _liked_by, slideshow_name, _comments, _assign, header, _user_tags) FROM stdin;
\.


--
-- TOC entry 8341 (class 0 OID 20442)
-- Dependencies: 550
-- Data for Name: tabWebsite Slideshow Item; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabWebsite Slideshow Item" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, image, description, heading) FROM stdin;
\.


--
-- TOC entry 8342 (class 0 OID 20450)
-- Dependencies: 551
-- Data for Name: tabWebsite Theme; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabWebsite Theme" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, heading_style, link_color, module, _liked_by, footer_text_color, heading_webfont, background_color, apply_style, background_image, top_bar_text_color, _comments, apply_text_styles, custom, theme, footer_color, css, _assign, text_webfont, text_color, js, _user_tags, font_size, top_bar_color, bootstrap) FROM stdin;
\.


--
-- TOC entry 8344 (class 0 OID 20473)
-- Dependencies: 553
-- Data for Name: tabWorkflow Action; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabWorkflow Action" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, _comments, workflow_action_name, _assign, _user_tags, _liked_by) FROM stdin;
\.


--
-- TOC entry 8345 (class 0 OID 20481)
-- Dependencies: 554
-- Data for Name: tabWorkflow Document State; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabWorkflow Document State" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, allow_edit, update_field, doc_status, state, message, update_value) FROM stdin;
\.


--
-- TOC entry 8346 (class 0 OID 20489)
-- Dependencies: 555
-- Data for Name: tabWorkflow State; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabWorkflow State" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, style, _liked_by, _user_tags, _assign, _comments, workflow_state_name, icon) FROM stdin;
\.


--
-- TOC entry 8347 (class 0 OID 20497)
-- Dependencies: 556
-- Data for Name: tabWorkflow Transition; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabWorkflow Transition" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, action, state, next_state, allowed) FROM stdin;
\.


--
-- TOC entry 8349 (class 0 OID 20518)
-- Dependencies: 558
-- Data for Name: tabWorkstation Working Hour; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."tabWorkstation Working Hour" (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, start_time, enabled, end_time) FROM stdin;
\.


--
-- TOC entry 7992 (class 0 OID 16409)
-- Dependencies: 201
-- Data for Name: tabaccount; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tabaccount (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, lft, _liked_by, report_type, account_name, freeze_account, rgt, root_type, _user_tags, warehouse, balance_must_be, account_type, company, _assign, is_group, tax_rate, account_currency, _comments, parent_account, old_parent) FROM stdin;
\.


--
-- TOC entry 7995 (class 0 OID 16441)
-- Dependencies: 204
-- Data for Name: tabaddress; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tabaddress (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, email_id, pincode, county, is_your_company_address, address_line2, city, address_line1, _comments, is_primary_address, state, address_type, fax, _liked_by, address_title, _assign, phone, _user_tags, country, is_shipping_address) FROM stdin;
\.


--
-- TOC entry 7997 (class 0 OID 16461)
-- Dependencies: 206
-- Data for Name: tabannouncement; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tabannouncement (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, _liked_by, description, _comments, posted_by, _assign, student_group, amended_from, _seen, student, receiver, instructor, _user_tags, subject) FROM stdin;
\.


--
-- TOC entry 7998 (class 0 OID 16469)
-- Dependencies: 207
-- Data for Name: tabappraisal; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tabappraisal (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, kra_template, naming_series, _user_tags, amended_from, employee, company, start_date, status, _liked_by, end_date, total_score, _assign, employee_name, remarks, _comments) FROM stdin;
\.


--
-- TOC entry 8007 (class 0 OID 16553)
-- Dependencies: 216
-- Data for Name: tabasset; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tabasset (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, expected_value_after_useful_life, image, journal_entry_for_scrap, total_number_of_depreciations, is_existing_asset, _comments, amended_from, purchase_date, supplier, status, _liked_by, company, _assign, purchase_invoice, item_code, opening_accumulated_depreciation, asset_name, value_after_depreciation, warehouse, frequency_of_depreciation, _user_tags, asset_category, next_depreciation_date, gross_purchase_amount, number_of_depreciations_booked, disposal_date, depreciation_method) FROM stdin;
\.


--
-- TOC entry 8011 (class 0 OID 16597)
-- Dependencies: 220
-- Data for Name: tabattendance; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tabattendance (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, status, _assign, _user_tags, naming_series, company, employee_name, amended_from, leave_type, _liked_by, _comments, attendance_date, employee) FROM stdin;
\.


--
-- TOC entry 8016 (class 0 OID 16645)
-- Dependencies: 225
-- Data for Name: tabbatch; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tabbatch (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, _liked_by, description, _comments, _assign, item, expiry_date, batch_id, _user_tags) FROM stdin;
\.


--
-- TOC entry 8017 (class 0 OID 16653)
-- Dependencies: 226
-- Data for Name: tabbin; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tabbin (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, reserved_qty_for_production, _liked_by, fcfs_rate, reserved_qty, _assign, planned_qty, ma_rate, item_code, projected_qty, warehouse, stock_uom, _comments, ordered_qty, indented_qty, valuation_rate, stock_value, _user_tags, actual_qty) FROM stdin;
\.


--
-- TOC entry 8021 (class 0 OID 16699)
-- Dependencies: 230
-- Data for Name: tabblogger; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tabblogger (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, bio, _liked_by, short_name, _comments, _assign, posts, disabled, "user", full_name, _user_tags, avatar) FROM stdin;
\.


--
-- TOC entry 8022 (class 0 OID 16709)
-- Dependencies: 231
-- Data for Name: tabbom; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tabbom (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, operating_cost, image, currency, conversion_rate, _liked_by, base_operating_cost, base_raw_material_cost, item, total_cost, _comments, amended_from, base_scrap_material_cost, scrap_material_cost, buying_price_list, company, uom, _assign, description, with_operations, raw_material_cost, is_active, is_default, _user_tags, rm_cost_as_per, project, item_name, quantity, base_total_cost) FROM stdin;
\.


--
-- TOC entry 8027 (class 0 OID 16782)
-- Dependencies: 236
-- Data for Name: tabbranch; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tabbranch (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, _comments, _assign, _user_tags, _liked_by, branch) FROM stdin;
\.


--
-- TOC entry 8028 (class 0 OID 16790)
-- Dependencies: 237
-- Data for Name: tabbrand; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tabbrand (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, _liked_by, description, _user_tags, brand, _assign, _comments) FROM stdin;
\.


--
-- TOC entry 8029 (class 0 OID 16798)
-- Dependencies: 238
-- Data for Name: tabbudget; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tabbudget (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, monthly_distribution, _liked_by, amended_from, budget_against, _comments, company, _assign, fiscal_year, project, action_if_annual_budget_exceeded, action_if_accumulated_monthly_budget_exceeded, cost_center, _user_tags) FROM stdin;
\.


--
-- TOC entry 8033 (class 0 OID 16838)
-- Dependencies: 242
-- Data for Name: tabcampaign; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tabcampaign (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, _liked_by, _user_tags, description, naming_series, _assign, campaign_name, _comments) FROM stdin;
\.


--
-- TOC entry 8035 (class 0 OID 16877)
-- Dependencies: 244
-- Data for Name: tabcommunication; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tabcommunication (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, comment_type, cc, read_receipt, link_doctype, timeline_doctype, sender_full_name, seen, email_account, reference_owner, subject, reference_doctype, text_content, _comments, unread_notification_sent, content, communication_medium, link_name, message_id, status, _liked_by, recipients, timeline_label, communication_type, _assign, reference_name, "user", delivery_status, in_reply_to, _user_tags, sender, sent_or_received, timeline_name, phone_no, communication_date, signature) FROM stdin;
\.


--
-- TOC entry 8036 (class 0 OID 16889)
-- Dependencies: 245
-- Data for Name: tabcompany; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tabcompany (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, website, default_letter_head, default_income_account, default_terms, create_chart_of_accounts_based_on, exchange_gain_loss_account, default_receivable_account, domain, cost_center, registration_details, round_off_account, existing_company, _comments, default_expense_account, depreciation_cost_center, credit_days, company_name, expenses_included_in_valuation, default_bank_account, default_currency, email, fax, _liked_by, default_holiday_list, accumulated_depreciation_account, _assign, write_off_account, credit_days_based_on, default_payable_account, stock_adjustment_account, abbr, address, _user_tags, credit_limit, stock_received_but_not_billed, country, chart_of_accounts, phone_no, disposal_account, depreciation_expense_account, default_cash_account, round_off_cost_center) FROM stdin;
\.


--
-- TOC entry 8038 (class 0 OID 16907)
-- Dependencies: 247
-- Data for Name: tabcontact; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tabcontact (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, last_name, email_id, image, mobile_no, first_name, _comments, unsubscribed, department, status, _liked_by, _assign, phone, "user", _user_tags, designation, is_primary_contact) FROM stdin;
\.


--
-- TOC entry 8040 (class 0 OID 16929)
-- Dependencies: 249
-- Data for Name: tabcountry; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tabcountry (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, date_format, code, _comments, _assign, _liked_by, time_zones, country_name, _user_tags) FROM stdin;
\.


--
-- TOC entry 8041 (class 0 OID 16937)
-- Dependencies: 250
-- Data for Name: tabcourse; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tabcourse (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, default_grading_scale, _liked_by, course_name, _user_tags, _assign, course_intro, course_abbreviation, department, course_code, _comments) FROM stdin;
\.


--
-- TOC entry 8044 (class 0 OID 16963)
-- Dependencies: 253
-- Data for Name: tabcurrency; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tabcurrency (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, fraction_units, _liked_by, _comments, symbol, _assign, enabled, smallest_currency_fraction_value, currency_name, fraction, _user_tags, number_format) FROM stdin;
\.


--
-- TOC entry 8049 (class 0 OID 17043)
-- Dependencies: 258
-- Data for Name: tabcustomer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tabcustomer (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, status, customer_details, image, disabled, lead_name, default_currency, _comments, default_sales_partner, default_price_list, credit_days, naming_series, customer_name, website, _liked_by, default_commission_rate, _assign, credit_days_based_on, _user_tags, tax_id, credit_limit, language, customer_group, territory, customer_type, is_frozen) FROM stdin;
\.


--
-- TOC entry 8054 (class 0 OID 17115)
-- Dependencies: 263
-- Data for Name: tabdefaultvalue; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tabdefaultvalue (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, defvalue, defkey) FROM stdin;
\.


--
-- TOC entry 8058 (class 0 OID 17192)
-- Dependencies: 267
-- Data for Name: tabdepartment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tabdepartment (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, leave_block_list, _liked_by, _user_tags, _assign, department_name, _comments) FROM stdin;
\.


--
-- TOC entry 8061 (class 0 OID 17218)
-- Dependencies: 270
-- Data for Name: tabdesignation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tabdesignation (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, _liked_by, description, designation_name, _assign, _comments, _user_tags) FROM stdin;
\.


--
-- TOC entry 8063 (class 0 OID 17240)
-- Dependencies: 272
-- Data for Name: tabdiscussion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tabdiscussion (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, _liked_by, description, course, _comments, _assign, amended_from, _seen, _user_tags, subject) FROM stdin;
\.


--
-- TOC entry 8064 (class 0 OID 17248)
-- Dependencies: 273
-- Data for Name: tabdocfield; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tabdocfield (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, fieldname, label, oldfieldname, fieldtype, oldfieldtype, options, search_index, hidden, set_only_once, print_hide, report_hide, reqd, bold, collapsible, "unique", no_copy, allow_on_submit, trigger, collapsible_depends_on, depends_on, permlevel, ignore_user_permissions, width, print_width, columns, "default", description, in_filter, in_list_view, in_standard_filter, read_only, "precision", length, ignore_xss_filter, print_hide_if_no_value, remember_last_selected_value) FROM stdin;
\.


--
-- TOC entry 8065 (class 0 OID 17279)
-- Dependencies: 274
-- Data for Name: tabdocperm; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tabdocperm (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, permlevel, role, match, read, write, "create", submit, cancel, delete, amend, report, export, import, share, print, email, user_permission_doctypes, set_user_permissions, apply_user_permissions, if_owner) FROM stdin;
\.


--
-- TOC entry 8066 (class 0 OID 17304)
-- Dependencies: 275
-- Data for Name: tabdocshare; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tabdocshare (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, everyone, share_name, read, _comments, _assign, share, write, _liked_by, "user", share_doctype, _user_tags) FROM stdin;
\.


--
-- TOC entry 8067 (class 0 OID 17316)
-- Dependencies: 276
-- Data for Name: tabdoctype; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tabdoctype (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, search_fields, issingle, istable, editable_grid, track_changes, module, app, autoname, name_case, title_field, image_field, timeline_field, sort_field, sort_order, description, colour, read_only, in_create, menu_index, parent_node, smallicon, allow_copy, allow_rename, allow_import, hide_toolbar, hide_heading, track_seen, max_attachments, print_outline, read_only_onload, in_dialog, document_type, icon, tag_fields, subject, _last_update, engine, default_print_format, is_submittable, _user_tags, custom, beta, image_view, _comments, _liked_by, _assign, quick_entry) FROM stdin;
\.


--
-- TOC entry 8080 (class 0 OID 17496)
-- Dependencies: 289
-- Data for Name: tabemployee; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tabemployee (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, status, marital_status, feedback, permanent_accommodation_type, blood_group, naming_series, image, reason_for_leaving, _liked_by, holiday_list, relation, prefered_email, salutation, held_on, permanent_address, company_email, prefered_contact_email, user_id, bank_name, resignation_letter_date, employee_number, encashment_date, _comments, employment_type, personal_email, reports_to, date_of_issue, date_of_birth, new_workplace, current_accommodation_type, employee, unsubscribed, bio, _assign, branch, scheduled_confirmation_date, company, family_background, leave_encashed, bank_ac_no, department, person_to_be_contacted, date_of_joining, employee_name, final_confirmation_date, place_of_issue, salary_mode, _user_tags, current_address, passport_number, designation, cell_number, gender, valid_upto, contract_end_date, notice_number_of_days, emergency_phone_number, reason_for_resignation, health_details, relieving_date, date_of_retirement) FROM stdin;
\.


--
-- TOC entry 8089 (class 0 OID 17576)
-- Dependencies: 298
-- Data for Name: tabevent; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tabevent (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, event_type, tuesday, wednesday, _liked_by, thursday, saturday, subject, repeat_this_event, _comments, repeat_till, sunday, send_reminder, ref_type, ref_name, _assign, description, monday, friday, _seen, _user_tags, all_day, starts_on, ends_on, repeat_on) FROM stdin;
\.


--
-- TOC entry 8098 (class 0 OID 17668)
-- Dependencies: 307
-- Data for Name: tabfees; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tabfees (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, academic_year, naming_series, academic_term, program_enrollment, paid_amount, _user_tags, amended_from, program, student_name, due_date, _liked_by, fee_structure, _assign, outstanding_amount, student, _comments, student_category, total_amount) FROM stdin;
\.


--
-- TOC entry 8099 (class 0 OID 17679)
-- Dependencies: 308
-- Data for Name: tabfile; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tabfile (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, file_name, file_url, module, attached_to_name, file_size, attached_to_doctype, lft, is_attachments_folder, is_folder, content_hash, rgt, _comments, is_home_folder, folder, _liked_by, _assign, _user_tags, is_private, old_parent, thumbnail_url) FROM stdin;
\.


--
-- TOC entry 8108 (class 0 OID 17765)
-- Dependencies: 317
-- Data for Name: tabguardian; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tabguardian (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, _liked_by, designation, guardian_name, _user_tags, image, _assign, alternate_number, date_of_birth, _comments, work_address, mobile_number, occupation, education, email_address) FROM stdin;
\.


--
-- TOC entry 8112 (class 0 OID 17802)
-- Dependencies: 321
-- Data for Name: tabholiday; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tabholiday (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, holiday_date, description) FROM stdin;
\.


--
-- TOC entry 8118 (class 0 OID 17852)
-- Dependencies: 327
-- Data for Name: tabinstructor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tabinstructor (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, _liked_by, naming_series, image, _assign, employee, _comments, department, instructor_name, _user_tags) FROM stdin;
\.


--
-- TOC entry 8122 (class 0 OID 17886)
-- Dependencies: 331
-- Data for Name: tabinterest; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tabinterest (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, _comments, _assign, _user_tags, _liked_by, interest) FROM stdin;
\.


--
-- TOC entry 8123 (class 0 OID 17894)
-- Dependencies: 332
-- Data for Name: tabissue; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tabissue (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, naming_series, mins_to_first_response, opening_date, subject, raised_by, first_responded_on, lead, _comments, attachment, opening_time, customer_name, status, customer, _liked_by, description, company, _assign, _seen, content_type, resolution_details, _user_tags, resolution_date, project, contact) FROM stdin;
\.


--
-- TOC entry 8124 (class 0 OID 17904)
-- Dependencies: 333
-- Data for Name: tabitem; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tabitem (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, default_supplier, selling_cost_center, net_weight, expense_account, max_discount, income_account, item_name, website_warehouse, default_material_request_type, _assign, disabled, tolerance, item_group, web_long_description, valuation_method, variant_of, has_variants, default_warehouse, inspection_required_before_delivery, is_sales_item, is_sub_contracted_item, thumbnail, customer_code, barcode, is_stock_item, _user_tags, manufacturer, route, min_order_qty, valuation_rate, image, last_purchase_rate, _comments, brand, slideshow, item_code, show_in_website, is_purchase_item, safety_stock, weight_uom, warranty_period, manufacturer_part_no, delivered_by_supplier, serial_no_series, naming_series, website_image, buying_cost_center, publish_in_hub, end_of_life, synced_with_hub, stock_uom, show_variant_in_website, _liked_by, description, asset_category, default_bom, weightage, total_projected_qty, lead_time_days, opening_stock, has_batch_no, has_serial_no, standard_rate, is_fixed_asset, inspection_required_before_purchase) FROM stdin;
\.


--
-- TOC entry 8147 (class 0 OID 18162)
-- Dependencies: 356
-- Data for Name: tablanguage; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tablanguage (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, _assign, _comments, language_code, flag, _liked_by, based_on, language_name, _user_tags) FROM stdin;
\.


--
-- TOC entry 8148 (class 0 OID 18170)
-- Dependencies: 357
-- Data for Name: tablead; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tablead (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, website, email_id, image, mobile_no, campaign_name, lead_name, type, _comments, source, contact_by, company_name, naming_series, territory, status, fax, _liked_by, company, _assign, market_segment, lead_owner, phone, request_type, _user_tags, customer, blog_subscriber, industry, unsubscribed, contact_date) FROM stdin;
\.


--
-- TOC entry 8162 (class 0 OID 18306)
-- Dependencies: 371
-- Data for Name: tabmanufacturer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tabmanufacturer (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, website, _liked_by, short_name, _comments, notes, _assign, data_6, full_name, logo, _user_tags) FROM stdin;
\.


--
-- TOC entry 8170 (class 0 OID 18379)
-- Dependencies: 379
-- Data for Name: tabnewsletter; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tabnewsletter (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, _liked_by, _assign, send_from, scheduled_to_send, email_sent, _comments, message, email_group, _user_tags, test_email_id, subject) FROM stdin;
\.


--
-- TOC entry 8171 (class 0 OID 18389)
-- Dependencies: 380
-- Data for Name: tabnote; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tabnote (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, content, _liked_by, expire_notification_on, title, _comments, _assign, notify_on_login, _user_tags, public) FROM stdin;
\.


--
-- TOC entry 8179 (class 0 OID 18458)
-- Dependencies: 388
-- Data for Name: taboperation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.taboperation (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, workstation, _liked_by, description, _user_tags, _assign, _comments) FROM stdin;
\.


--
-- TOC entry 8180 (class 0 OID 18466)
-- Dependencies: 389
-- Data for Name: tabopportunity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tabopportunity (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, address_display, campaign, naming_series, mins_to_first_response, enquiry_type, enquiry_from, customer_name, lead, amended_from, _comments, source, contact_by, transaction_date, contact_display, territory, status, _liked_by, company, _assign, customer_address, _seen, contact_email, contact_mobile, _user_tags, customer, order_lost_reason, customer_group, title, with_items, to_discuss, contact_person, contact_date) FROM stdin;
\.


--
-- TOC entry 8185 (class 0 OID 18521)
-- Dependencies: 394
-- Data for Name: tabpage; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tabpage (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, _liked_by, title, _comments, _assign, module, standard, page_name, _user_tags, icon) FROM stdin;
\.


--
-- TOC entry 8215 (class 0 OID 18844)
-- Dependencies: 424
-- Data for Name: tabprogram; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tabprogram (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, _liked_by, _comments, _assign, program_code, department, program_name, program_abbreviation, _user_tags) FROM stdin;
\.


--
-- TOC entry 8221 (class 0 OID 18895)
-- Dependencies: 430
-- Data for Name: tabproject; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tabproject (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, total_expense_claim, _liked_by, per_gross_margin, project_type, cost_center, actual_start_date, _comments, actual_end_date, total_costing_amount, priority, total_purchase_cost, company, status, total_billing_amount, project_name, percent_complete_method, estimated_costing, is_active, expected_end_date, gross_margin, _assign, _seen, percent_complete, _user_tags, customer, sales_order, expected_start_date, notes, actual_time) FROM stdin;
\.


--
-- TOC entry 8238 (class 0 OID 19226)
-- Dependencies: 447
-- Data for Name: tabquotation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tabquotation (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, additional_discount_percentage, base_in_words, enq_det, campaign, contact_email, naming_series, contact_mobile, currency, conversion_rate, _liked_by, total, shipping_rule, customer_name, taxes_and_charges, select_print_heading, order_type, lead, price_list_currency, _user_tags, base_total, selling_price_list, supplier_quotation, tc_name, source, transaction_date, contact_display, ignore_pricing_rule, territory, company, address_display, _assign, terms, amended_from, base_rounded_total, customer_group, quotation_to, grand_total, base_discount_amount, customer_address, base_total_taxes_and_charges, _comments, base_grand_total, discount_amount, customer, order_lost_reason, base_net_total, language, rounded_total, shipping_address_name, title, letter_head, plc_conversion_rate, net_total, status, shipping_address, apply_discount_on, contact_person, in_words, total_taxes_and_charges) FROM stdin;
\.


--
-- TOC entry 8241 (class 0 OID 19288)
-- Dependencies: 450
-- Data for Name: tabreport; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tabreport (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, apply_user_permissions, ref_doctype, report_type, _assign, _comments, javascript, letter_head, module, report_name, disabled, json, is_standard, add_total_row, query, _user_tags, _liked_by) FROM stdin;
\.


--
-- TOC entry 8245 (class 0 OID 19326)
-- Dependencies: 454
-- Data for Name: tabrole; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tabrole (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, _liked_by, desk_access, _user_tags, _assign, disabled, role_name, _comments) FROM stdin;
\.


--
-- TOC entry 8246 (class 0 OID 19336)
-- Dependencies: 455
-- Data for Name: tabroom; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tabroom (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, _liked_by, room_name, _assign, seating_capacity, _comments, room_number, _user_tags) FROM stdin;
\.


--
-- TOC entry 8267 (class 0 OID 19673)
-- Dependencies: 476
-- Data for Name: tabseries; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tabseries (name, current) FROM stdin;
\.


--
-- TOC entry 8268 (class 0 OID 19677)
-- Dependencies: 477
-- Data for Name: tabsessions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tabsessions ("user", sid, sessiondata, ipaddress, lastupdate, device, status) FROM stdin;
\.


--
-- TOC entry 8272 (class 0 OID 19714)
-- Dependencies: 481
-- Data for Name: tabsingles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tabsingles (doctype, field, value) FROM stdin;
\.


--
-- TOC entry 8281 (class 0 OID 19820)
-- Dependencies: 490
-- Data for Name: tabstudent; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tabstudent (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, last_name, blood_group, naming_series, image, pincode, student_mobile_number, student_email_id, city, first_name, middle_name, title, _comments, state, date_of_birth, student_applicant, _liked_by, _assign, nationality, _user_tags, joining_date, gender, address_line_2, address_line_1) FROM stdin;
\.


--
-- TOC entry 8298 (class 0 OID 19966)
-- Dependencies: 507
-- Data for Name: tabsupplier; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tabsupplier (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, website, naming_series, image, disabled, default_currency, _comments, credit_days, status, _liked_by, _assign, credit_days_based_on, supplier_name, supplier_type, _user_tags, language, country, default_price_list, is_frozen, supplier_details) FROM stdin;
\.


--
-- TOC entry 8302 (class 0 OID 20039)
-- Dependencies: 511
-- Data for Name: tabtag; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tabtag (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, tag_name) FROM stdin;
\.


--
-- TOC entry 8306 (class 0 OID 20073)
-- Dependencies: 515
-- Data for Name: tabtask; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tabtask (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, status, exp_end_date, review_date, total_expense_claim, expected_time, subject, act_end_date, task_weight, depends_on_tasks, total_costing_amount, priority, progress, total_billing_amount, _liked_by, description, company, _assign, _seen, _comments, act_start_date, _user_tags, closing_date, project, exp_start_date, actual_time) FROM stdin;
\.


--
-- TOC entry 8310 (class 0 OID 20116)
-- Dependencies: 519
-- Data for Name: tabterritory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tabterritory (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, _liked_by, rgt, distribution_id, _comments, _assign, is_group, territory_name, old_parent, lft, parent_territory, _user_tags, territory_manager) FROM stdin;
\.


--
-- TOC entry 8311 (class 0 OID 20127)
-- Dependencies: 520
-- Data for Name: tabtimesheet; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tabtimesheet (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, naming_series, _liked_by, total_billable_amount, _comments, total_costing_amount, note, amended_from, employee, total_billable_hours, start_date, status, total_billed_amount, end_date, company, _assign, per_billed, salary_slip, total_billed_hours, "user", employee_name, _user_tags, sales_invoice, total_hours, production_order) FROM stdin;
\.


--
-- TOC entry 8313 (class 0 OID 20159)
-- Dependencies: 522
-- Data for Name: tabtodo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tabtodo (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, status, sender, assigned_by, _seen, reference_name, reference_type, priority, date, _assign, _liked_by, role, assigned_by_full_name, _user_tags, _comments, description) FROM stdin;
\.


--
-- TOC entry 8315 (class 0 OID 20178)
-- Dependencies: 524
-- Data for Name: tabtopic; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tabtopic (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, _assign, introduction, _comments, topic_name, content, course, _liked_by, _user_tags) FROM stdin;
\.


--
-- TOC entry 8321 (class 0 OID 20229)
-- Dependencies: 530
-- Data for Name: tabtranslation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tabtranslation (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, _liked_by, source_name, language, target_name, _comments, _assign, _user_tags) FROM stdin;
\.


--
-- TOC entry 8323 (class 0 OID 20245)
-- Dependencies: 532
-- Data for Name: tabuom; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tabuom (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, uom_name, _liked_by, _comments, _assign, must_be_whole_number, _user_tags) FROM stdin;
\.


--
-- TOC entry 8325 (class 0 OID 20263)
-- Dependencies: 534
-- Data for Name: tabuser; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tabuser (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, user_image, _liked_by, full_name, frappe_userid, simultaneous_sessions, google_userid, user_type, time_zone, mute_sounds, last_name, github_username, last_known_versions, thread_notify, background_image, last_active, _comments, new_password, last_login, github_userid, login_after, email, restrict_ip, username, bio, last_ip, fb_userid, background_style, _assign, first_name, send_password_update_notification, phone, middle_name, _user_tags, send_welcome_email, email_signature, language, reset_password_key, gender, login_before, enabled, location, fb_username, redirect_url, birth_date, unsubscribed) FROM stdin;
\.


--
-- TOC entry 8327 (class 0 OID 20290)
-- Dependencies: 536
-- Data for Name: tabuserrole; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tabuserrole (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, role) FROM stdin;
\.


--
-- TOC entry 8328 (class 0 OID 20298)
-- Dependencies: 537
-- Data for Name: tabvehicle; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tabvehicle (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, color, acquisition_date, license_plate, carbon_check_date, last_odometer, policy_no, amended_from, _comments, make, vehicle_value, location, doors, employee, start_date, uom, _liked_by, end_date, _assign, insurance_company, _user_tags, wheels, chassis_no, model, fuel_type) FROM stdin;
\.


--
-- TOC entry 8331 (class 0 OID 20331)
-- Dependencies: 540
-- Data for Name: tabversion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tabversion (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, _assign, _user_tags, ref_doctype, _comments, docname, data, _liked_by) FROM stdin;
\.


--
-- TOC entry 8332 (class 0 OID 20339)
-- Dependencies: 541
-- Data for Name: tabwarehouse; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tabwarehouse (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, pin, email_id, disabled, lft, parent_warehouse, mobile_no, city, rgt, _comments, state, create_account_under, _liked_by, company, _assign, is_group, warehouse_name, _user_tags, old_parent, phone_no, address_line_2, address_line_1) FROM stdin;
\.


--
-- TOC entry 8343 (class 0 OID 20462)
-- Dependencies: 552
-- Data for Name: tabworkflow; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tabworkflow (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, override_status, workflow_name, _assign, is_active, _liked_by, workflow_state_field, document_type, _user_tags, _comments) FROM stdin;
\.


--
-- TOC entry 8348 (class 0 OID 20505)
-- Dependencies: 557
-- Data for Name: tabworkstation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tabworkstation (name, creation, modified, modified_by, owner, docstatus, parent, parentfield, parenttype, idx, hour_rate_rent, _liked_by, description, hour_rate_electricity, _user_tags, _assign, hour_rate_labour, hour_rate, holiday_list, _comments, hour_rate_consumable, workstation_name) FROM stdin;
\.


--
-- TOC entry 6517 (class 2606 OID 21541)
-- Name: tabAbout Us Team Member idx_16385_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabAbout Us Team Member"
    ADD CONSTRAINT idx_16385_primary PRIMARY KEY (name);


--
-- TOC entry 6520 (class 2606 OID 21542)
-- Name: tabAcademic Term idx_16393_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabAcademic Term"
    ADD CONSTRAINT idx_16393_primary PRIMARY KEY (name);


--
-- TOC entry 6525 (class 2606 OID 21543)
-- Name: tabAcademic Year idx_16401_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabAcademic Year"
    ADD CONSTRAINT idx_16401_primary PRIMARY KEY (name);


--
-- TOC entry 6530 (class 2606 OID 21544)
-- Name: tabaccount idx_16409_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabaccount
    ADD CONSTRAINT idx_16409_primary PRIMARY KEY (name);


--
-- TOC entry 6534 (class 2606 OID 21545)
-- Name: tabActivity Cost idx_16421_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabActivity Cost"
    ADD CONSTRAINT idx_16421_primary PRIMARY KEY (name);


--
-- TOC entry 6537 (class 2606 OID 21546)
-- Name: tabActivity Type idx_16431_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabActivity Type"
    ADD CONSTRAINT idx_16431_primary PRIMARY KEY (name);


--
-- TOC entry 6543 (class 2606 OID 21547)
-- Name: tabaddress idx_16441_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabaddress
    ADD CONSTRAINT idx_16441_primary PRIMARY KEY (name);


--
-- TOC entry 6547 (class 2606 OID 21548)
-- Name: tabAddress Template idx_16452_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabAddress Template"
    ADD CONSTRAINT idx_16452_primary PRIMARY KEY (name);


--
-- TOC entry 6550 (class 2606 OID 21549)
-- Name: tabannouncement idx_16461_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabannouncement
    ADD CONSTRAINT idx_16461_primary PRIMARY KEY (name);


--
-- TOC entry 6557 (class 2606 OID 21550)
-- Name: tabappraisal idx_16469_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabappraisal
    ADD CONSTRAINT idx_16469_primary PRIMARY KEY (name);


--
-- TOC entry 6561 (class 2606 OID 21551)
-- Name: tabAppraisal Goal idx_16479_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabAppraisal Goal"
    ADD CONSTRAINT idx_16479_primary PRIMARY KEY (name);


--
-- TOC entry 6564 (class 2606 OID 21552)
-- Name: tabAppraisal Template idx_16490_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabAppraisal Template"
    ADD CONSTRAINT idx_16490_primary PRIMARY KEY (name);


--
-- TOC entry 6567 (class 2606 OID 21553)
-- Name: tabAppraisal Template Goal idx_16498_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabAppraisal Template Goal"
    ADD CONSTRAINT idx_16498_primary PRIMARY KEY (name);


--
-- TOC entry 6570 (class 2606 OID 21554)
-- Name: tabAssessment Evaluation Criteria idx_16507_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabAssessment Evaluation Criteria"
    ADD CONSTRAINT idx_16507_primary PRIMARY KEY (name);


--
-- TOC entry 6573 (class 2606 OID 21555)
-- Name: tabAssessment Group idx_16516_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabAssessment Group"
    ADD CONSTRAINT idx_16516_primary PRIMARY KEY (name);


--
-- TOC entry 6576 (class 2606 OID 21556)
-- Name: tabAssessment Plan idx_16524_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabAssessment Plan"
    ADD CONSTRAINT idx_16524_primary PRIMARY KEY (name);


--
-- TOC entry 6579 (class 2606 OID 21557)
-- Name: tabAssessment Result idx_16533_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabAssessment Result"
    ADD CONSTRAINT idx_16533_primary PRIMARY KEY (name);


--
-- TOC entry 6582 (class 2606 OID 21558)
-- Name: tabAssessment Result Detail idx_16543_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabAssessment Result Detail"
    ADD CONSTRAINT idx_16543_primary PRIMARY KEY (name);


--
-- TOC entry 6585 (class 2606 OID 21559)
-- Name: tabasset idx_16553_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabasset
    ADD CONSTRAINT idx_16553_primary PRIMARY KEY (name);


--
-- TOC entry 6588 (class 2606 OID 21560)
-- Name: tabAsset Category idx_16570_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabAsset Category"
    ADD CONSTRAINT idx_16570_primary PRIMARY KEY (name);


--
-- TOC entry 6591 (class 2606 OID 21561)
-- Name: tabAsset Category Account idx_16581_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabAsset Category Account"
    ADD CONSTRAINT idx_16581_primary PRIMARY KEY (name);


--
-- TOC entry 6594 (class 2606 OID 21562)
-- Name: tabAsset Movement idx_16589_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabAsset Movement"
    ADD CONSTRAINT idx_16589_primary PRIMARY KEY (name);


--
-- TOC entry 6598 (class 2606 OID 21563)
-- Name: tabattendance idx_16597_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabattendance
    ADD CONSTRAINT idx_16597_primary PRIMARY KEY (name);


--
-- TOC entry 6602 (class 2606 OID 21564)
-- Name: tabAttendance Tool Student idx_16606_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabAttendance Tool Student"
    ADD CONSTRAINT idx_16606_primary PRIMARY KEY (name);


--
-- TOC entry 6605 (class 2606 OID 21565)
-- Name: tabAuthorization Rule idx_16614_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabAuthorization Rule"
    ADD CONSTRAINT idx_16614_primary PRIMARY KEY (name);


--
-- TOC entry 6608 (class 2606 OID 21566)
-- Name: tabAuto Email Report idx_16623_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabAuto Email Report"
    ADD CONSTRAINT idx_16623_primary PRIMARY KEY (name);


--
-- TOC entry 6611 (class 2606 OID 21567)
-- Name: tabBank Reconciliation Detail idx_16637_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabBank Reconciliation Detail"
    ADD CONSTRAINT idx_16637_primary PRIMARY KEY (name);


--
-- TOC entry 6614 (class 2606 OID 21568)
-- Name: tabbatch idx_16645_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabbatch
    ADD CONSTRAINT idx_16645_primary PRIMARY KEY (name);


--
-- TOC entry 6618 (class 2606 OID 21569)
-- Name: tabbin idx_16653_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabbin
    ADD CONSTRAINT idx_16653_primary PRIMARY KEY (name);


--
-- TOC entry 6622 (class 2606 OID 21570)
-- Name: tabBlock Module idx_16672_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabBlock Module"
    ADD CONSTRAINT idx_16672_primary PRIMARY KEY (name);


--
-- TOC entry 6625 (class 2606 OID 21571)
-- Name: tabBlog Category idx_16680_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabBlog Category"
    ADD CONSTRAINT idx_16680_primary PRIMARY KEY (name);


--
-- TOC entry 6629 (class 2606 OID 21572)
-- Name: tabBlog Post idx_16689_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabBlog Post"
    ADD CONSTRAINT idx_16689_primary PRIMARY KEY (name);


--
-- TOC entry 6633 (class 2606 OID 21573)
-- Name: tabblogger idx_16699_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabblogger
    ADD CONSTRAINT idx_16699_primary PRIMARY KEY (name);


--
-- TOC entry 6637 (class 2606 OID 21574)
-- Name: tabbom idx_16709_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabbom
    ADD CONSTRAINT idx_16709_primary PRIMARY KEY (name);


--
-- TOC entry 6640 (class 2606 OID 21575)
-- Name: tabBOM Explosion Item idx_16729_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabBOM Explosion Item"
    ADD CONSTRAINT idx_16729_primary PRIMARY KEY (name);


--
-- TOC entry 6645 (class 2606 OID 21576)
-- Name: tabBOM Item idx_16741_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabBOM Item"
    ADD CONSTRAINT idx_16741_primary PRIMARY KEY (name);


--
-- TOC entry 6648 (class 2606 OID 21577)
-- Name: tabBOM Operation idx_16756_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabBOM Operation"
    ADD CONSTRAINT idx_16756_primary PRIMARY KEY (name);


--
-- TOC entry 6651 (class 2606 OID 21578)
-- Name: tabBOM Scrap Item idx_16769_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabBOM Scrap Item"
    ADD CONSTRAINT idx_16769_primary PRIMARY KEY (name);


--
-- TOC entry 6654 (class 2606 OID 21579)
-- Name: tabbranch idx_16782_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabbranch
    ADD CONSTRAINT idx_16782_primary PRIMARY KEY (name);


--
-- TOC entry 6657 (class 2606 OID 21580)
-- Name: tabbrand idx_16790_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabbrand
    ADD CONSTRAINT idx_16790_primary PRIMARY KEY (name);


--
-- TOC entry 6660 (class 2606 OID 21581)
-- Name: tabbudget idx_16798_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabbudget
    ADD CONSTRAINT idx_16798_primary PRIMARY KEY (name);


--
-- TOC entry 6663 (class 2606 OID 21582)
-- Name: tabBudget Account idx_16809_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabBudget Account"
    ADD CONSTRAINT idx_16809_primary PRIMARY KEY (name);


--
-- TOC entry 6666 (class 2606 OID 21583)
-- Name: tabC-Form idx_16818_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabC-Form"
    ADD CONSTRAINT idx_16818_primary PRIMARY KEY (name);


--
-- TOC entry 6669 (class 2606 OID 21584)
-- Name: tabC-Form Invoice Detail idx_16828_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabC-Form Invoice Detail"
    ADD CONSTRAINT idx_16828_primary PRIMARY KEY (name);


--
-- TOC entry 6672 (class 2606 OID 21585)
-- Name: tabcampaign idx_16838_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabcampaign
    ADD CONSTRAINT idx_16838_primary PRIMARY KEY (name);


--
-- TOC entry 6675 (class 2606 OID 21586)
-- Name: tabCheque Print Template idx_16846_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabCheque Print Template"
    ADD CONSTRAINT idx_16846_primary PRIMARY KEY (name);


--
-- TOC entry 6681 (class 2606 OID 21587)
-- Name: tabcommunication idx_16877_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabcommunication
    ADD CONSTRAINT idx_16877_primary PRIMARY KEY (name);


--
-- TOC entry 6688 (class 2606 OID 21588)
-- Name: tabcompany idx_16889_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabcompany
    ADD CONSTRAINT idx_16889_primary PRIMARY KEY (name);


--
-- TOC entry 6691 (class 2606 OID 21589)
-- Name: tabCompany History idx_16899_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabCompany History"
    ADD CONSTRAINT idx_16899_primary PRIMARY KEY (name);


--
-- TOC entry 6695 (class 2606 OID 21590)
-- Name: tabcontact idx_16907_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabcontact
    ADD CONSTRAINT idx_16907_primary PRIMARY KEY (name);


--
-- TOC entry 6699 (class 2606 OID 21591)
-- Name: tabCost Center idx_16918_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabCost Center"
    ADD CONSTRAINT idx_16918_primary PRIMARY KEY (name);


--
-- TOC entry 6703 (class 2606 OID 21592)
-- Name: tabcountry idx_16929_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabcountry
    ADD CONSTRAINT idx_16929_primary PRIMARY KEY (name);


--
-- TOC entry 6706 (class 2606 OID 21593)
-- Name: tabcourse idx_16937_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabcourse
    ADD CONSTRAINT idx_16937_primary PRIMARY KEY (name);


--
-- TOC entry 6709 (class 2606 OID 21595)
-- Name: tabCourse Evaluation Criteria idx_16945_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabCourse Evaluation Criteria"
    ADD CONSTRAINT idx_16945_primary PRIMARY KEY (name);


--
-- TOC entry 6712 (class 2606 OID 21594)
-- Name: tabCourse Schedule idx_16954_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabCourse Schedule"
    ADD CONSTRAINT idx_16954_primary PRIMARY KEY (name);


--
-- TOC entry 6715 (class 2606 OID 21596)
-- Name: tabcurrency idx_16963_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabcurrency
    ADD CONSTRAINT idx_16963_primary PRIMARY KEY (name);


--
-- TOC entry 6718 (class 2606 OID 21597)
-- Name: tabCurrency Exchange idx_16974_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabCurrency Exchange"
    ADD CONSTRAINT idx_16974_primary PRIMARY KEY (name);


--
-- TOC entry 6721 (class 2606 OID 21598)
-- Name: tabCustom DocPerm idx_16983_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabCustom DocPerm"
    ADD CONSTRAINT idx_16983_primary PRIMARY KEY (name);


--
-- TOC entry 6725 (class 2606 OID 21599)
-- Name: tabCustom Field idx_17008_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabCustom Field"
    ADD CONSTRAINT idx_17008_primary PRIMARY KEY (name);


--
-- TOC entry 6728 (class 2606 OID 21601)
-- Name: tabCustom Script idx_17034_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabCustom Script"
    ADD CONSTRAINT idx_17034_primary PRIMARY KEY (name);


--
-- TOC entry 6733 (class 2606 OID 21600)
-- Name: tabcustomer idx_17043_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabcustomer
    ADD CONSTRAINT idx_17043_primary PRIMARY KEY (name);


--
-- TOC entry 6737 (class 2606 OID 21602)
-- Name: tabCustomer Group idx_17057_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabCustomer Group"
    ADD CONSTRAINT idx_17057_primary PRIMARY KEY (name);


--
-- TOC entry 6744 (class 2606 OID 21603)
-- Name: tabCustomize Form Field idx_17070_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabCustomize Form Field"
    ADD CONSTRAINT idx_17070_primary PRIMARY KEY (name);


--
-- TOC entry 6747 (class 2606 OID 21604)
-- Name: tabDaily Work Summary idx_17097_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabDaily Work Summary"
    ADD CONSTRAINT idx_17097_primary PRIMARY KEY (name);


--
-- TOC entry 6750 (class 2606 OID 21605)
-- Name: tabDaily Work Summary Settings Company idx_17106_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabDaily Work Summary Settings Company"
    ADD CONSTRAINT idx_17106_primary PRIMARY KEY (name);


--
-- TOC entry 6755 (class 2606 OID 21606)
-- Name: tabdefaultvalue idx_17115_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabdefaultvalue
    ADD CONSTRAINT idx_17115_primary PRIMARY KEY (name);


--
-- TOC entry 6758 (class 2606 OID 21607)
-- Name: tabDeleted Document idx_17123_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabDeleted Document"
    ADD CONSTRAINT idx_17123_primary PRIMARY KEY (name);


--
-- TOC entry 6766 (class 2606 OID 21608)
-- Name: tabDelivery Note idx_17132_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabDelivery Note"
    ADD CONSTRAINT idx_17132_primary PRIMARY KEY (name);


--
-- TOC entry 6773 (class 2606 OID 21609)
-- Name: tabDelivery Note Item idx_17165_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabDelivery Note Item"
    ADD CONSTRAINT idx_17165_primary PRIMARY KEY (name);


--
-- TOC entry 6777 (class 2606 OID 21610)
-- Name: tabdepartment idx_17192_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabdepartment
    ADD CONSTRAINT idx_17192_primary PRIMARY KEY (name);


--
-- TOC entry 6780 (class 2606 OID 21611)
-- Name: tabDependent Task idx_17200_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabDependent Task"
    ADD CONSTRAINT idx_17200_primary PRIMARY KEY (name);


--
-- TOC entry 6783 (class 2606 OID 21612)
-- Name: tabDepreciation Schedule idx_17208_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabDepreciation Schedule"
    ADD CONSTRAINT idx_17208_primary PRIMARY KEY (name);


--
-- TOC entry 6786 (class 2606 OID 21613)
-- Name: tabdesignation idx_17218_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabdesignation
    ADD CONSTRAINT idx_17218_primary PRIMARY KEY (name);


--
-- TOC entry 6789 (class 2606 OID 21614)
-- Name: tabDesktop Icon idx_17226_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabDesktop Icon"
    ADD CONSTRAINT idx_17226_primary PRIMARY KEY (name);


--
-- TOC entry 6794 (class 2606 OID 21615)
-- Name: tabdiscussion idx_17240_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabdiscussion
    ADD CONSTRAINT idx_17240_primary PRIMARY KEY (name);


--
-- TOC entry 6801 (class 2606 OID 21616)
-- Name: tabdocfield idx_17248_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabdocfield
    ADD CONSTRAINT idx_17248_primary PRIMARY KEY (name);


--
-- TOC entry 6804 (class 2606 OID 21617)
-- Name: tabdocperm idx_17279_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabdocperm
    ADD CONSTRAINT idx_17279_primary PRIMARY KEY (name);


--
-- TOC entry 6807 (class 2606 OID 21618)
-- Name: tabdocshare idx_17304_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabdocshare
    ADD CONSTRAINT idx_17304_primary PRIMARY KEY (name);


--
-- TOC entry 6816 (class 2606 OID 21619)
-- Name: tabdoctype idx_17316_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabdoctype
    ADD CONSTRAINT idx_17316_primary PRIMARY KEY (name);


--
-- TOC entry 6820 (class 2606 OID 21620)
-- Name: tabDynamic Link idx_17348_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabDynamic Link"
    ADD CONSTRAINT idx_17348_primary PRIMARY KEY (name);


--
-- TOC entry 6823 (class 2606 OID 21621)
-- Name: tabEmail Account idx_17356_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabEmail Account"
    ADD CONSTRAINT idx_17356_primary PRIMARY KEY (name);


--
-- TOC entry 6828 (class 2606 OID 21622)
-- Name: tabEmail Alert idx_17381_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabEmail Alert"
    ADD CONSTRAINT idx_17381_primary PRIMARY KEY (name);


--
-- TOC entry 6831 (class 2606 OID 21623)
-- Name: tabEmail Alert Recipient idx_17393_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabEmail Alert Recipient"
    ADD CONSTRAINT idx_17393_primary PRIMARY KEY (name);


--
-- TOC entry 6834 (class 2606 OID 21624)
-- Name: tabEmail Digest idx_17401_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabEmail Digest"
    ADD CONSTRAINT idx_17401_primary PRIMARY KEY (name);


--
-- TOC entry 6837 (class 2606 OID 21625)
-- Name: tabEmail Domain idx_17430_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabEmail Domain"
    ADD CONSTRAINT idx_17430_primary PRIMARY KEY (name);


--
-- TOC entry 6840 (class 2606 OID 21626)
-- Name: tabEmail Flag Queue idx_17442_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabEmail Flag Queue"
    ADD CONSTRAINT idx_17442_primary PRIMARY KEY (name);


--
-- TOC entry 6843 (class 2606 OID 21627)
-- Name: tabEmail Group idx_17450_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabEmail Group"
    ADD CONSTRAINT idx_17450_primary PRIMARY KEY (name);


--
-- TOC entry 6846 (class 2606 OID 21628)
-- Name: tabEmail Group Member idx_17459_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabEmail Group Member"
    ADD CONSTRAINT idx_17459_primary PRIMARY KEY (name);


--
-- TOC entry 6853 (class 2606 OID 21629)
-- Name: tabEmail Queue idx_17468_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabEmail Queue"
    ADD CONSTRAINT idx_17468_primary PRIMARY KEY (name);


--
-- TOC entry 6856 (class 2606 OID 21630)
-- Name: tabEmail Queue Recipient idx_17478_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabEmail Queue Recipient"
    ADD CONSTRAINT idx_17478_primary PRIMARY KEY (name);


--
-- TOC entry 6859 (class 2606 OID 21631)
-- Name: tabEmail Unsubscribe idx_17487_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabEmail Unsubscribe"
    ADD CONSTRAINT idx_17487_primary PRIMARY KEY (name);


--
-- TOC entry 6863 (class 2606 OID 21632)
-- Name: tabemployee idx_17496_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabemployee
    ADD CONSTRAINT idx_17496_primary PRIMARY KEY (name);


--
-- TOC entry 6867 (class 2606 OID 21633)
-- Name: tabEmployee Education idx_17507_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabEmployee Education"
    ADD CONSTRAINT idx_17507_primary PRIMARY KEY (name);


--
-- TOC entry 6870 (class 2606 OID 21634)
-- Name: tabEmployee External Work History idx_17516_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabEmployee External Work History"
    ADD CONSTRAINT idx_17516_primary PRIMARY KEY (name);


--
-- TOC entry 6873 (class 2606 OID 21635)
-- Name: tabEmployee Internal Work History idx_17525_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabEmployee Internal Work History"
    ADD CONSTRAINT idx_17525_primary PRIMARY KEY (name);


--
-- TOC entry 6876 (class 2606 OID 21636)
-- Name: tabEmployee Leave Approver idx_17533_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabEmployee Leave Approver"
    ADD CONSTRAINT idx_17533_primary PRIMARY KEY (name);


--
-- TOC entry 6879 (class 2606 OID 21637)
-- Name: tabEmployment Type idx_17541_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabEmployment Type"
    ADD CONSTRAINT idx_17541_primary PRIMARY KEY (name);


--
-- TOC entry 6882 (class 2606 OID 21638)
-- Name: tabError Log idx_17549_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabError Log"
    ADD CONSTRAINT idx_17549_primary PRIMARY KEY (name);


--
-- TOC entry 6885 (class 2606 OID 21639)
-- Name: tabError Snapshot idx_17558_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabError Snapshot"
    ADD CONSTRAINT idx_17558_primary PRIMARY KEY (name);


--
-- TOC entry 6888 (class 2606 OID 21640)
-- Name: tabEvaluation Criteria idx_17568_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabEvaluation Criteria"
    ADD CONSTRAINT idx_17568_primary PRIMARY KEY (name);


--
-- TOC entry 6892 (class 2606 OID 21641)
-- Name: tabevent idx_17576_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabevent
    ADD CONSTRAINT idx_17576_primary PRIMARY KEY (name);


--
-- TOC entry 6895 (class 2606 OID 21642)
-- Name: tabEvent Role idx_17594_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabEvent Role"
    ADD CONSTRAINT idx_17594_primary PRIMARY KEY (name);


--
-- TOC entry 6900 (class 2606 OID 21643)
-- Name: tabExpense Claim idx_17602_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabExpense Claim"
    ADD CONSTRAINT idx_17602_primary PRIMARY KEY (name);


--
-- TOC entry 6903 (class 2606 OID 21644)
-- Name: tabExpense Claim Account idx_17616_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabExpense Claim Account"
    ADD CONSTRAINT idx_17616_primary PRIMARY KEY (name);


--
-- TOC entry 6906 (class 2606 OID 21645)
-- Name: tabExpense Claim Detail idx_17624_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabExpense Claim Detail"
    ADD CONSTRAINT idx_17624_primary PRIMARY KEY (name);


--
-- TOC entry 6909 (class 2606 OID 21646)
-- Name: tabExpense Claim Type idx_17634_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabExpense Claim Type"
    ADD CONSTRAINT idx_17634_primary PRIMARY KEY (name);


--
-- TOC entry 6912 (class 2606 OID 21647)
-- Name: tabFee Category idx_17642_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabFee Category"
    ADD CONSTRAINT idx_17642_primary PRIMARY KEY (name);


--
-- TOC entry 6915 (class 2606 OID 21648)
-- Name: tabFee Component idx_17650_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabFee Component"
    ADD CONSTRAINT idx_17650_primary PRIMARY KEY (name);


--
-- TOC entry 6919 (class 2606 OID 21649)
-- Name: tabFee Structure idx_17659_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabFee Structure"
    ADD CONSTRAINT idx_17659_primary PRIMARY KEY (name);


--
-- TOC entry 6923 (class 2606 OID 21650)
-- Name: tabfees idx_17668_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabfees
    ADD CONSTRAINT idx_17668_primary PRIMARY KEY (name);


--
-- TOC entry 6929 (class 2606 OID 21651)
-- Name: tabfile idx_17679_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabfile
    ADD CONSTRAINT idx_17679_primary PRIMARY KEY (name);


--
-- TOC entry 6932 (class 2606 OID 21652)
-- Name: tabFiscal Year idx_17694_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabFiscal Year"
    ADD CONSTRAINT idx_17694_primary PRIMARY KEY (name);


--
-- TOC entry 6935 (class 2606 OID 21653)
-- Name: tabFiscal Year Company idx_17703_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabFiscal Year Company"
    ADD CONSTRAINT idx_17703_primary PRIMARY KEY (name);


--
-- TOC entry 6938 (class 2606 OID 21654)
-- Name: tabFooter Item idx_17711_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabFooter Item"
    ADD CONSTRAINT idx_17711_primary PRIMARY KEY (name);


--
-- TOC entry 6945 (class 2606 OID 21655)
-- Name: tabGL Entry idx_17719_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabGL Entry"
    ADD CONSTRAINT idx_17719_primary PRIMARY KEY (name);


--
-- TOC entry 6949 (class 2606 OID 21656)
-- Name: tabGrade Interval idx_17731_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabGrade Interval"
    ADD CONSTRAINT idx_17731_primary PRIMARY KEY (name);


--
-- TOC entry 6952 (class 2606 OID 21657)
-- Name: tabGrading Scale idx_17740_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabGrading Scale"
    ADD CONSTRAINT idx_17740_primary PRIMARY KEY (name);


--
-- TOC entry 6955 (class 2606 OID 21658)
-- Name: tabGrading Scale Interval idx_17748_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabGrading Scale Interval"
    ADD CONSTRAINT idx_17748_primary PRIMARY KEY (name);


--
-- TOC entry 6958 (class 2606 OID 21659)
-- Name: tabGrading Structure idx_17757_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabGrading Structure"
    ADD CONSTRAINT idx_17757_primary PRIMARY KEY (name);


--
-- TOC entry 6961 (class 2606 OID 21660)
-- Name: tabguardian idx_17765_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabguardian
    ADD CONSTRAINT idx_17765_primary PRIMARY KEY (name);


--
-- TOC entry 6964 (class 2606 OID 21661)
-- Name: tabGuardian Interest idx_17773_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabGuardian Interest"
    ADD CONSTRAINT idx_17773_primary PRIMARY KEY (name);


--
-- TOC entry 6967 (class 2606 OID 21662)
-- Name: tabHelp Article idx_17781_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabHelp Article"
    ADD CONSTRAINT idx_17781_primary PRIMARY KEY (name);


--
-- TOC entry 6970 (class 2606 OID 21663)
-- Name: tabHelp Category idx_17792_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabHelp Category"
    ADD CONSTRAINT idx_17792_primary PRIMARY KEY (name);


--
-- TOC entry 6973 (class 2606 OID 21664)
-- Name: tabholiday idx_17802_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabholiday
    ADD CONSTRAINT idx_17802_primary PRIMARY KEY (name);


--
-- TOC entry 6976 (class 2606 OID 21665)
-- Name: tabHoliday List idx_17810_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabHoliday List"
    ADD CONSTRAINT idx_17810_primary PRIMARY KEY (name);


--
-- TOC entry 6980 (class 2606 OID 21666)
-- Name: tabHomepage Featured Product idx_17818_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabHomepage Featured Product"
    ADD CONSTRAINT idx_17818_primary PRIMARY KEY (name);


--
-- TOC entry 6983 (class 2606 OID 21667)
-- Name: tabIndustry Type idx_17826_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabIndustry Type"
    ADD CONSTRAINT idx_17826_primary PRIMARY KEY (name);


--
-- TOC entry 6988 (class 2606 OID 21668)
-- Name: tabInstallation Note idx_17834_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabInstallation Note"
    ADD CONSTRAINT idx_17834_primary PRIMARY KEY (name);


--
-- TOC entry 6994 (class 2606 OID 21669)
-- Name: tabInstallation Note Item idx_17843_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabInstallation Note Item"
    ADD CONSTRAINT idx_17843_primary PRIMARY KEY (name);


--
-- TOC entry 6997 (class 2606 OID 21670)
-- Name: tabinstructor idx_17852_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabinstructor
    ADD CONSTRAINT idx_17852_primary PRIMARY KEY (name);


--
-- TOC entry 7000 (class 2606 OID 21671)
-- Name: tabIntegration Request idx_17860_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabIntegration Request"
    ADD CONSTRAINT idx_17860_primary PRIMARY KEY (name);


--
-- TOC entry 7003 (class 2606 OID 21672)
-- Name: tabIntegration Service idx_17869_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabIntegration Service"
    ADD CONSTRAINT idx_17869_primary PRIMARY KEY (name);


--
-- TOC entry 7006 (class 2606 OID 21673)
-- Name: tabIntegration Service Parameter idx_17878_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabIntegration Service Parameter"
    ADD CONSTRAINT idx_17878_primary PRIMARY KEY (name);


--
-- TOC entry 7009 (class 2606 OID 21674)
-- Name: tabinterest idx_17886_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabinterest
    ADD CONSTRAINT idx_17886_primary PRIMARY KEY (name);


--
-- TOC entry 7013 (class 2606 OID 21675)
-- Name: tabissue idx_17894_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabissue
    ADD CONSTRAINT idx_17894_primary PRIMARY KEY (name);


--
-- TOC entry 7018 (class 2606 OID 21676)
-- Name: tabitem idx_17904_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabitem
    ADD CONSTRAINT idx_17904_primary PRIMARY KEY (name);


--
-- TOC entry 7022 (class 2606 OID 21677)
-- Name: tabItem Attribute idx_17942_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabItem Attribute"
    ADD CONSTRAINT idx_17942_primary PRIMARY KEY (name);


--
-- TOC entry 7026 (class 2606 OID 21678)
-- Name: tabItem Attribute Value idx_17954_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabItem Attribute Value"
    ADD CONSTRAINT idx_17954_primary PRIMARY KEY (name);


--
-- TOC entry 7030 (class 2606 OID 21679)
-- Name: tabItem Customer Detail idx_17962_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabItem Customer Detail"
    ADD CONSTRAINT idx_17962_primary PRIMARY KEY (name);


--
-- TOC entry 7035 (class 2606 OID 21680)
-- Name: tabItem Group idx_17970_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabItem Group"
    ADD CONSTRAINT idx_17970_primary PRIMARY KEY (name);


--
-- TOC entry 7041 (class 2606 OID 21681)
-- Name: tabItem Price idx_17982_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabItem Price"
    ADD CONSTRAINT idx_17982_primary PRIMARY KEY (name);


--
-- TOC entry 7044 (class 2606 OID 21682)
-- Name: tabItem Quality Inspection Parameter idx_17993_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabItem Quality Inspection Parameter"
    ADD CONSTRAINT idx_17993_primary PRIMARY KEY (name);


--
-- TOC entry 7047 (class 2606 OID 21683)
-- Name: tabItem Reorder idx_18001_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabItem Reorder"
    ADD CONSTRAINT idx_18001_primary PRIMARY KEY (name);


--
-- TOC entry 7050 (class 2606 OID 21684)
-- Name: tabItem Supplier idx_18011_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabItem Supplier"
    ADD CONSTRAINT idx_18011_primary PRIMARY KEY (name);


--
-- TOC entry 7053 (class 2606 OID 21685)
-- Name: tabItem Tax idx_18019_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabItem Tax"
    ADD CONSTRAINT idx_18019_primary PRIMARY KEY (name);


--
-- TOC entry 7056 (class 2606 OID 21686)
-- Name: tabItem Variant idx_18028_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabItem Variant"
    ADD CONSTRAINT idx_18028_primary PRIMARY KEY (name);


--
-- TOC entry 7059 (class 2606 OID 21687)
-- Name: tabItem Variant Attribute idx_18036_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabItem Variant Attribute"
    ADD CONSTRAINT idx_18036_primary PRIMARY KEY (name);


--
-- TOC entry 7062 (class 2606 OID 21688)
-- Name: tabItem Website Specification idx_18048_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabItem Website Specification"
    ADD CONSTRAINT idx_18048_primary PRIMARY KEY (name);


--
-- TOC entry 7065 (class 2606 OID 21689)
-- Name: tabJob Applicant idx_18056_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabJob Applicant"
    ADD CONSTRAINT idx_18056_primary PRIMARY KEY (name);


--
-- TOC entry 7068 (class 2606 OID 21690)
-- Name: tabJob Opening idx_18064_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabJob Opening"
    ADD CONSTRAINT idx_18064_primary PRIMARY KEY (name);


--
-- TOC entry 7077 (class 2606 OID 21691)
-- Name: tabJournal Entry idx_18073_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabJournal Entry"
    ADD CONSTRAINT idx_18073_primary PRIMARY KEY (name);


--
-- TOC entry 7082 (class 2606 OID 21692)
-- Name: tabJournal Entry Account idx_18090_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabJournal Entry Account"
    ADD CONSTRAINT idx_18090_primary PRIMARY KEY (name);


--
-- TOC entry 7086 (class 2606 OID 21693)
-- Name: tabKanban Board idx_18105_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabKanban Board"
    ADD CONSTRAINT idx_18105_primary PRIMARY KEY (name);


--
-- TOC entry 7089 (class 2606 OID 21694)
-- Name: tabKanban Board Column idx_18113_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabKanban Board Column"
    ADD CONSTRAINT idx_18113_primary PRIMARY KEY (name);


--
-- TOC entry 7092 (class 2606 OID 21695)
-- Name: tabLanded Cost Item idx_18123_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabLanded Cost Item"
    ADD CONSTRAINT idx_18123_primary PRIMARY KEY (name);


--
-- TOC entry 7095 (class 2606 OID 21696)
-- Name: tabLanded Cost Purchase Receipt idx_18135_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabLanded Cost Purchase Receipt"
    ADD CONSTRAINT idx_18135_primary PRIMARY KEY (name);


--
-- TOC entry 7098 (class 2606 OID 21697)
-- Name: tabLanded Cost Taxes and Charges idx_18144_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabLanded Cost Taxes and Charges"
    ADD CONSTRAINT idx_18144_primary PRIMARY KEY (name);


--
-- TOC entry 7101 (class 2606 OID 21698)
-- Name: tabLanded Cost Voucher idx_18153_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabLanded Cost Voucher"
    ADD CONSTRAINT idx_18153_primary PRIMARY KEY (name);


--
-- TOC entry 7104 (class 2606 OID 21699)
-- Name: tablanguage idx_18162_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tablanguage
    ADD CONSTRAINT idx_18162_primary PRIMARY KEY (name);


--
-- TOC entry 7110 (class 2606 OID 21700)
-- Name: tablead idx_18170_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tablead
    ADD CONSTRAINT idx_18170_primary PRIMARY KEY (name);


--
-- TOC entry 7114 (class 2606 OID 21701)
-- Name: tabLead Source idx_18181_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabLead Source"
    ADD CONSTRAINT idx_18181_primary PRIMARY KEY (name);


--
-- TOC entry 7120 (class 2606 OID 21702)
-- Name: tabLeave Allocation idx_18189_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabLeave Allocation"
    ADD CONSTRAINT idx_18189_primary PRIMARY KEY (name);


--
-- TOC entry 7126 (class 2606 OID 21703)
-- Name: tabLeave Application idx_18201_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabLeave Application"
    ADD CONSTRAINT idx_18201_primary PRIMARY KEY (name);


--
-- TOC entry 7130 (class 2606 OID 21704)
-- Name: tabLeave Block List idx_18214_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabLeave Block List"
    ADD CONSTRAINT idx_18214_primary PRIMARY KEY (name);


--
-- TOC entry 7133 (class 2606 OID 21705)
-- Name: tabLeave Block List Allow idx_18223_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabLeave Block List Allow"
    ADD CONSTRAINT idx_18223_primary PRIMARY KEY (name);


--
-- TOC entry 7136 (class 2606 OID 21706)
-- Name: tabLeave Block List Date idx_18231_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabLeave Block List Date"
    ADD CONSTRAINT idx_18231_primary PRIMARY KEY (name);


--
-- TOC entry 7139 (class 2606 OID 21707)
-- Name: tabLeave Type idx_18239_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabLeave Type"
    ADD CONSTRAINT idx_18239_primary PRIMARY KEY (name);


--
-- TOC entry 7143 (class 2606 OID 21708)
-- Name: tabLetter Head idx_18252_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabLetter Head"
    ADD CONSTRAINT idx_18252_primary PRIMARY KEY (name);


--
-- TOC entry 7147 (class 2606 OID 21709)
-- Name: tabMaintenance Schedule idx_18262_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabMaintenance Schedule"
    ADD CONSTRAINT idx_18262_primary PRIMARY KEY (name);


--
-- TOC entry 7151 (class 2606 OID 21710)
-- Name: tabMaintenance Schedule Detail idx_18271_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabMaintenance Schedule Detail"
    ADD CONSTRAINT idx_18271_primary PRIMARY KEY (name);


--
-- TOC entry 7157 (class 2606 OID 21711)
-- Name: tabMaintenance Schedule Item idx_18279_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabMaintenance Schedule Item"
    ADD CONSTRAINT idx_18279_primary PRIMARY KEY (name);


--
-- TOC entry 7162 (class 2606 OID 21712)
-- Name: tabMaintenance Visit idx_18288_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabMaintenance Visit"
    ADD CONSTRAINT idx_18288_primary PRIMARY KEY (name);


--
-- TOC entry 7165 (class 2606 OID 21713)
-- Name: tabMaintenance Visit Purpose idx_18298_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabMaintenance Visit Purpose"
    ADD CONSTRAINT idx_18298_primary PRIMARY KEY (name);


--
-- TOC entry 7168 (class 2606 OID 21714)
-- Name: tabmanufacturer idx_18306_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabmanufacturer
    ADD CONSTRAINT idx_18306_primary PRIMARY KEY (name);


--
-- TOC entry 7172 (class 2606 OID 21715)
-- Name: tabMaterial Request idx_18314_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabMaterial Request"
    ADD CONSTRAINT idx_18314_primary PRIMARY KEY (name);


--
-- TOC entry 7180 (class 2606 OID 21716)
-- Name: tabMaterial Request Item idx_18324_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabMaterial Request Item"
    ADD CONSTRAINT idx_18324_primary PRIMARY KEY (name);


--
-- TOC entry 7183 (class 2606 OID 21717)
-- Name: tabMode of Payment idx_18338_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabMode of Payment"
    ADD CONSTRAINT idx_18338_primary PRIMARY KEY (name);


--
-- TOC entry 7186 (class 2606 OID 21718)
-- Name: tabMode of Payment Account idx_18346_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabMode of Payment Account"
    ADD CONSTRAINT idx_18346_primary PRIMARY KEY (name);


--
-- TOC entry 7189 (class 2606 OID 21719)
-- Name: tabModule Def idx_18354_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabModule Def"
    ADD CONSTRAINT idx_18354_primary PRIMARY KEY (name);


--
-- TOC entry 7193 (class 2606 OID 21720)
-- Name: tabMonthly Distribution idx_18362_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabMonthly Distribution"
    ADD CONSTRAINT idx_18362_primary PRIMARY KEY (name);


--
-- TOC entry 7196 (class 2606 OID 21721)
-- Name: tabMonthly Distribution Percentage idx_18370_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabMonthly Distribution Percentage"
    ADD CONSTRAINT idx_18370_primary PRIMARY KEY (name);


--
-- TOC entry 7199 (class 2606 OID 21722)
-- Name: tabnewsletter idx_18379_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabnewsletter
    ADD CONSTRAINT idx_18379_primary PRIMARY KEY (name);


--
-- TOC entry 7203 (class 2606 OID 21723)
-- Name: tabnote idx_18389_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabnote
    ADD CONSTRAINT idx_18389_primary PRIMARY KEY (name);


--
-- TOC entry 7206 (class 2606 OID 21724)
-- Name: tabNote Seen By idx_18399_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabNote Seen By"
    ADD CONSTRAINT idx_18399_primary PRIMARY KEY (name);


--
-- TOC entry 7209 (class 2606 OID 21725)
-- Name: tabOAuth Authorization Code idx_18407_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabOAuth Authorization Code"
    ADD CONSTRAINT idx_18407_primary PRIMARY KEY (name);


--
-- TOC entry 7212 (class 2606 OID 21726)
-- Name: tabOAuth Bearer Token idx_18415_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabOAuth Bearer Token"
    ADD CONSTRAINT idx_18415_primary PRIMARY KEY (name);


--
-- TOC entry 7215 (class 2606 OID 21727)
-- Name: tabOAuth Client idx_18424_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabOAuth Client"
    ADD CONSTRAINT idx_18424_primary PRIMARY KEY (name);


--
-- TOC entry 7218 (class 2606 OID 21728)
-- Name: tabOffer Letter idx_18434_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabOffer Letter"
    ADD CONSTRAINT idx_18434_primary PRIMARY KEY (name);


--
-- TOC entry 7221 (class 2606 OID 21729)
-- Name: tabOffer Letter Term idx_18442_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabOffer Letter Term"
    ADD CONSTRAINT idx_18442_primary PRIMARY KEY (name);


--
-- TOC entry 7224 (class 2606 OID 21730)
-- Name: tabOffer Term idx_18450_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabOffer Term"
    ADD CONSTRAINT idx_18450_primary PRIMARY KEY (name);


--
-- TOC entry 7227 (class 2606 OID 21731)
-- Name: taboperation idx_18458_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.taboperation
    ADD CONSTRAINT idx_18458_primary PRIMARY KEY (name);


--
-- TOC entry 7232 (class 2606 OID 21732)
-- Name: tabopportunity idx_18466_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabopportunity
    ADD CONSTRAINT idx_18466_primary PRIMARY KEY (name);


--
-- TOC entry 7236 (class 2606 OID 21733)
-- Name: tabOpportunity Item idx_18478_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabOpportunity Item"
    ADD CONSTRAINT idx_18478_primary PRIMARY KEY (name);


--
-- TOC entry 7239 (class 2606 OID 21734)
-- Name: tabPacked Item idx_18488_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabPacked Item"
    ADD CONSTRAINT idx_18488_primary PRIMARY KEY (name);


--
-- TOC entry 7242 (class 2606 OID 21735)
-- Name: tabPacking Slip idx_18500_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabPacking Slip"
    ADD CONSTRAINT idx_18500_primary PRIMARY KEY (name);


--
-- TOC entry 7245 (class 2606 OID 21736)
-- Name: tabPacking Slip Item idx_18510_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabPacking Slip Item"
    ADD CONSTRAINT idx_18510_primary PRIMARY KEY (name);


--
-- TOC entry 7248 (class 2606 OID 21737)
-- Name: tabpage idx_18521_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabpage
    ADD CONSTRAINT idx_18521_primary PRIMARY KEY (name);


--
-- TOC entry 7252 (class 2606 OID 21738)
-- Name: tabPage Role idx_18529_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabPage Role"
    ADD CONSTRAINT idx_18529_primary PRIMARY KEY (name);


--
-- TOC entry 7255 (class 2606 OID 21739)
-- Name: tabParty Account idx_18537_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabParty Account"
    ADD CONSTRAINT idx_18537_primary PRIMARY KEY (name);


--
-- TOC entry 7258 (class 2606 OID 21740)
-- Name: tabPatch Log idx_18545_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabPatch Log"
    ADD CONSTRAINT idx_18545_primary PRIMARY KEY (name);


--
-- TOC entry 7261 (class 2606 OID 21741)
-- Name: tabPayment Entry idx_18553_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabPayment Entry"
    ADD CONSTRAINT idx_18553_primary PRIMARY KEY (name);


--
-- TOC entry 7264 (class 2606 OID 21742)
-- Name: tabPayment Entry Deduction idx_18575_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabPayment Entry Deduction"
    ADD CONSTRAINT idx_18575_primary PRIMARY KEY (name);


--
-- TOC entry 7267 (class 2606 OID 21743)
-- Name: tabPayment Entry Reference idx_18584_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabPayment Entry Reference"
    ADD CONSTRAINT idx_18584_primary PRIMARY KEY (name);


--
-- TOC entry 7270 (class 2606 OID 21744)
-- Name: tabPayment Gateway idx_18596_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabPayment Gateway"
    ADD CONSTRAINT idx_18596_primary PRIMARY KEY (name);


--
-- TOC entry 7273 (class 2606 OID 21745)
-- Name: tabPayment Gateway Account idx_18604_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabPayment Gateway Account"
    ADD CONSTRAINT idx_18604_primary PRIMARY KEY (name);


--
-- TOC entry 7276 (class 2606 OID 21746)
-- Name: tabPayment Reconciliation Invoice idx_18613_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabPayment Reconciliation Invoice"
    ADD CONSTRAINT idx_18613_primary PRIMARY KEY (name);


--
-- TOC entry 7279 (class 2606 OID 21747)
-- Name: tabPayment Reconciliation Payment idx_18623_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabPayment Reconciliation Payment"
    ADD CONSTRAINT idx_18623_primary PRIMARY KEY (name);


--
-- TOC entry 7282 (class 2606 OID 21748)
-- Name: tabPayment Request idx_18633_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabPayment Request"
    ADD CONSTRAINT idx_18633_primary PRIMARY KEY (name);


--
-- TOC entry 7285 (class 2606 OID 21749)
-- Name: tabPeriod Closing Voucher idx_18645_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabPeriod Closing Voucher"
    ADD CONSTRAINT idx_18645_primary PRIMARY KEY (name);


--
-- TOC entry 7288 (class 2606 OID 21750)
-- Name: tabPortal Menu Item idx_18653_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabPortal Menu Item"
    ADD CONSTRAINT idx_18653_primary PRIMARY KEY (name);


--
-- TOC entry 7291 (class 2606 OID 21751)
-- Name: tabPOS Customer Group idx_18662_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabPOS Customer Group"
    ADD CONSTRAINT idx_18662_primary PRIMARY KEY (name);


--
-- TOC entry 7294 (class 2606 OID 21752)
-- Name: tabPOS Item Group idx_18670_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabPOS Item Group"
    ADD CONSTRAINT idx_18670_primary PRIMARY KEY (name);


--
-- TOC entry 7297 (class 2606 OID 21753)
-- Name: tabPOS Profile idx_18678_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabPOS Profile"
    ADD CONSTRAINT idx_18678_primary PRIMARY KEY (name);


--
-- TOC entry 7300 (class 2606 OID 21754)
-- Name: tabPrice List idx_18693_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabPrice List"
    ADD CONSTRAINT idx_18693_primary PRIMARY KEY (name);


--
-- TOC entry 7303 (class 2606 OID 21755)
-- Name: tabPrice List Country idx_18704_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabPrice List Country"
    ADD CONSTRAINT idx_18704_primary PRIMARY KEY (name);


--
-- TOC entry 7306 (class 2606 OID 21756)
-- Name: tabPricing Rule idx_18712_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabPricing Rule"
    ADD CONSTRAINT idx_18712_primary PRIMARY KEY (name);


--
-- TOC entry 7309 (class 2606 OID 21757)
-- Name: tabPrint Format idx_18731_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabPrint Format"
    ADD CONSTRAINT idx_18731_primary PRIMARY KEY (name);


--
-- TOC entry 7313 (class 2606 OID 21758)
-- Name: tabPrint Heading idx_18748_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabPrint Heading"
    ADD CONSTRAINT idx_18748_primary PRIMARY KEY (name);


--
-- TOC entry 7316 (class 2606 OID 21759)
-- Name: tabProduct Bundle idx_18756_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabProduct Bundle"
    ADD CONSTRAINT idx_18756_primary PRIMARY KEY (name);


--
-- TOC entry 7319 (class 2606 OID 21760)
-- Name: tabProduct Bundle Item idx_18764_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabProduct Bundle Item"
    ADD CONSTRAINT idx_18764_primary PRIMARY KEY (name);


--
-- TOC entry 7322 (class 2606 OID 21761)
-- Name: tabProduction Order idx_18774_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabProduction Order"
    ADD CONSTRAINT idx_18774_primary PRIMARY KEY (name);


--
-- TOC entry 7326 (class 2606 OID 21762)
-- Name: tabProduction Order Item idx_18792_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabProduction Order Item"
    ADD CONSTRAINT idx_18792_primary PRIMARY KEY (name);


--
-- TOC entry 7329 (class 2606 OID 21763)
-- Name: tabProduction Order Operation idx_18802_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabProduction Order Operation"
    ADD CONSTRAINT idx_18802_primary PRIMARY KEY (name);


--
-- TOC entry 7332 (class 2606 OID 21764)
-- Name: tabProduction Plan Item idx_18817_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabProduction Plan Item"
    ADD CONSTRAINT idx_18817_primary PRIMARY KEY (name);


--
-- TOC entry 7335 (class 2606 OID 21765)
-- Name: tabProduction Plan Material Request idx_18827_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabProduction Plan Material Request"
    ADD CONSTRAINT idx_18827_primary PRIMARY KEY (name);


--
-- TOC entry 7338 (class 2606 OID 21766)
-- Name: tabProduction Plan Sales Order idx_18835_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabProduction Plan Sales Order"
    ADD CONSTRAINT idx_18835_primary PRIMARY KEY (name);


--
-- TOC entry 7341 (class 2606 OID 21767)
-- Name: tabprogram idx_18844_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabprogram
    ADD CONSTRAINT idx_18844_primary PRIMARY KEY (name);


--
-- TOC entry 7344 (class 2606 OID 21768)
-- Name: tabProgram Course idx_18852_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabProgram Course"
    ADD CONSTRAINT idx_18852_primary PRIMARY KEY (name);


--
-- TOC entry 7347 (class 2606 OID 21769)
-- Name: tabProgram Enrollment idx_18861_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabProgram Enrollment"
    ADD CONSTRAINT idx_18861_primary PRIMARY KEY (name);


--
-- TOC entry 7350 (class 2606 OID 21770)
-- Name: tabProgram Enrollment Fee idx_18869_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabProgram Enrollment Fee"
    ADD CONSTRAINT idx_18869_primary PRIMARY KEY (name);


--
-- TOC entry 7353 (class 2606 OID 21771)
-- Name: tabProgram Enrollment Tool Student idx_18878_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabProgram Enrollment Tool Student"
    ADD CONSTRAINT idx_18878_primary PRIMARY KEY (name);


--
-- TOC entry 7356 (class 2606 OID 21772)
-- Name: tabProgram Fee idx_18886_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabProgram Fee"
    ADD CONSTRAINT idx_18886_primary PRIMARY KEY (name);


--
-- TOC entry 7360 (class 2606 OID 21773)
-- Name: tabproject idx_18895_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabproject
    ADD CONSTRAINT idx_18895_primary PRIMARY KEY (name);


--
-- TOC entry 7364 (class 2606 OID 21774)
-- Name: tabProject Task idx_18914_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabProject Task"
    ADD CONSTRAINT idx_18914_primary PRIMARY KEY (name);


--
-- TOC entry 7367 (class 2606 OID 21775)
-- Name: tabProject User idx_18924_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabProject User"
    ADD CONSTRAINT idx_18924_primary PRIMARY KEY (name);


--
-- TOC entry 7373 (class 2606 OID 21776)
-- Name: tabProperty Setter idx_18933_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabProperty Setter"
    ADD CONSTRAINT idx_18933_primary PRIMARY KEY (name);


--
-- TOC entry 7379 (class 2606 OID 21777)
-- Name: tabPurchase Invoice idx_18941_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabPurchase Invoice"
    ADD CONSTRAINT idx_18941_primary PRIMARY KEY (name);


--
-- TOC entry 7383 (class 2606 OID 21778)
-- Name: tabPurchase Invoice Advance idx_18985_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabPurchase Invoice Advance"
    ADD CONSTRAINT idx_18985_primary PRIMARY KEY (name);


--
-- TOC entry 7390 (class 2606 OID 21779)
-- Name: tabPurchase Invoice Item idx_18995_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabPurchase Invoice Item"
    ADD CONSTRAINT idx_18995_primary PRIMARY KEY (name);


--
-- TOC entry 7396 (class 2606 OID 21780)
-- Name: tabPurchase Order idx_19024_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabPurchase Order"
    ADD CONSTRAINT idx_19024_primary PRIMARY KEY (name);


--
-- TOC entry 7407 (class 2606 OID 21781)
-- Name: tabPurchase Order Item idx_19063_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabPurchase Order Item"
    ADD CONSTRAINT idx_19063_primary PRIMARY KEY (name);


--
-- TOC entry 7413 (class 2606 OID 21782)
-- Name: tabPurchase Order Item Supplied idx_19090_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabPurchase Order Item Supplied"
    ADD CONSTRAINT idx_19090_primary PRIMARY KEY (name);


--
-- TOC entry 7418 (class 2606 OID 21783)
-- Name: tabPurchase Receipt idx_19102_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabPurchase Receipt"
    ADD CONSTRAINT idx_19102_primary PRIMARY KEY (name);


--
-- TOC entry 7425 (class 2606 OID 21784)
-- Name: tabPurchase Receipt Item idx_19135_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabPurchase Receipt Item"
    ADD CONSTRAINT idx_19135_primary PRIMARY KEY (name);


--
-- TOC entry 7430 (class 2606 OID 21785)
-- Name: tabPurchase Receipt Item Supplied idx_19165_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabPurchase Receipt Item Supplied"
    ADD CONSTRAINT idx_19165_primary PRIMARY KEY (name);


--
-- TOC entry 7433 (class 2606 OID 21786)
-- Name: tabPurchase Taxes and Charges idx_19179_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabPurchase Taxes and Charges"
    ADD CONSTRAINT idx_19179_primary PRIMARY KEY (name);


--
-- TOC entry 7436 (class 2606 OID 21787)
-- Name: tabPurchase Taxes and Charges Template idx_19197_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabPurchase Taxes and Charges Template"
    ADD CONSTRAINT idx_19197_primary PRIMARY KEY (name);


--
-- TOC entry 7440 (class 2606 OID 21788)
-- Name: tabQuality Inspection idx_19207_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabQuality Inspection"
    ADD CONSTRAINT idx_19207_primary PRIMARY KEY (name);


--
-- TOC entry 7444 (class 2606 OID 21789)
-- Name: tabQuality Inspection Reading idx_19217_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabQuality Inspection Reading"
    ADD CONSTRAINT idx_19217_primary PRIMARY KEY (name);


--
-- TOC entry 7448 (class 2606 OID 21790)
-- Name: tabquotation idx_19226_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabquotation
    ADD CONSTRAINT idx_19226_primary PRIMARY KEY (name);


--
-- TOC entry 7456 (class 2606 OID 21791)
-- Name: tabQuotation Item idx_19255_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabQuotation Item"
    ADD CONSTRAINT idx_19255_primary PRIMARY KEY (name);


--
-- TOC entry 7459 (class 2606 OID 21792)
-- Name: tabQuotation Lost Reason idx_19280_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabQuotation Lost Reason"
    ADD CONSTRAINT idx_19280_primary PRIMARY KEY (name);


--
-- TOC entry 7462 (class 2606 OID 21793)
-- Name: tabreport idx_19288_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabreport
    ADD CONSTRAINT idx_19288_primary PRIMARY KEY (name);


--
-- TOC entry 7467 (class 2606 OID 21794)
-- Name: tabRequest for Quotation idx_19299_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabRequest for Quotation"
    ADD CONSTRAINT idx_19299_primary PRIMARY KEY (name);


--
-- TOC entry 7474 (class 2606 OID 21795)
-- Name: tabRequest for Quotation Item idx_19307_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabRequest for Quotation Item"
    ADD CONSTRAINT idx_19307_primary PRIMARY KEY (name);


--
-- TOC entry 7477 (class 2606 OID 21796)
-- Name: tabRequest for Quotation Supplier idx_19317_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabRequest for Quotation Supplier"
    ADD CONSTRAINT idx_19317_primary PRIMARY KEY (name);


--
-- TOC entry 7480 (class 2606 OID 21797)
-- Name: tabrole idx_19326_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabrole
    ADD CONSTRAINT idx_19326_primary PRIMARY KEY (name);


--
-- TOC entry 7483 (class 2606 OID 21798)
-- Name: tabroom idx_19336_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabroom
    ADD CONSTRAINT idx_19336_primary PRIMARY KEY (name);


--
-- TOC entry 7486 (class 2606 OID 21799)
-- Name: tabSalary Component idx_19344_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabSalary Component"
    ADD CONSTRAINT idx_19344_primary PRIMARY KEY (name);


--
-- TOC entry 7489 (class 2606 OID 21800)
-- Name: tabSalary Component Account idx_19352_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabSalary Component Account"
    ADD CONSTRAINT idx_19352_primary PRIMARY KEY (name);


--
-- TOC entry 7492 (class 2606 OID 21801)
-- Name: tabSalary Detail idx_19360_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabSalary Detail"
    ADD CONSTRAINT idx_19360_primary PRIMARY KEY (name);


--
-- TOC entry 7496 (class 2606 OID 21802)
-- Name: tabSalary Slip idx_19372_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabSalary Slip"
    ADD CONSTRAINT idx_19372_primary PRIMARY KEY (name);


--
-- TOC entry 7499 (class 2606 OID 21803)
-- Name: tabSalary Slip Timesheet idx_19392_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabSalary Slip Timesheet"
    ADD CONSTRAINT idx_19392_primary PRIMARY KEY (name);


--
-- TOC entry 7502 (class 2606 OID 21804)
-- Name: tabSalary Structure idx_19401_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabSalary Structure"
    ADD CONSTRAINT idx_19401_primary PRIMARY KEY (name);


--
-- TOC entry 7505 (class 2606 OID 21805)
-- Name: tabSalary Structure Employee idx_19417_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabSalary Structure Employee"
    ADD CONSTRAINT idx_19417_primary PRIMARY KEY (name);


--
-- TOC entry 7511 (class 2606 OID 21806)
-- Name: tabSales Invoice idx_19427_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabSales Invoice"
    ADD CONSTRAINT idx_19427_primary PRIMARY KEY (name);


--
-- TOC entry 7514 (class 2606 OID 21807)
-- Name: tabSales Invoice Advance idx_19474_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabSales Invoice Advance"
    ADD CONSTRAINT idx_19474_primary PRIMARY KEY (name);


--
-- TOC entry 7520 (class 2606 OID 21808)
-- Name: tabSales Invoice Item idx_19484_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabSales Invoice Item"
    ADD CONSTRAINT idx_19484_primary PRIMARY KEY (name);


--
-- TOC entry 7525 (class 2606 OID 21809)
-- Name: tabSales Invoice Payment idx_19512_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabSales Invoice Payment"
    ADD CONSTRAINT idx_19512_primary PRIMARY KEY (name);


--
-- TOC entry 7528 (class 2606 OID 21810)
-- Name: tabSales Invoice Timesheet idx_19522_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabSales Invoice Timesheet"
    ADD CONSTRAINT idx_19522_primary PRIMARY KEY (name);


--
-- TOC entry 7535 (class 2606 OID 21811)
-- Name: tabSales Order idx_19532_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabSales Order"
    ADD CONSTRAINT idx_19532_primary PRIMARY KEY (name);


--
-- TOC entry 7546 (class 2606 OID 21812)
-- Name: tabSales Order Item idx_19570_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabSales Order Item"
    ADD CONSTRAINT idx_19570_primary PRIMARY KEY (name);


--
-- TOC entry 7549 (class 2606 OID 21813)
-- Name: tabSales Partner idx_19604_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabSales Partner"
    ADD CONSTRAINT idx_19604_primary PRIMARY KEY (name);


--
-- TOC entry 7554 (class 2606 OID 21814)
-- Name: tabSales Person idx_19614_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabSales Person"
    ADD CONSTRAINT idx_19614_primary PRIMARY KEY (name);


--
-- TOC entry 7560 (class 2606 OID 21815)
-- Name: tabSales Taxes and Charges idx_19626_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabSales Taxes and Charges"
    ADD CONSTRAINT idx_19626_primary PRIMARY KEY (name);


--
-- TOC entry 7563 (class 2606 OID 21816)
-- Name: tabSales Taxes and Charges Template idx_19642_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabSales Taxes and Charges Template"
    ADD CONSTRAINT idx_19642_primary PRIMARY KEY (name);


--
-- TOC entry 7566 (class 2606 OID 21817)
-- Name: tabSales Team idx_19652_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabSales Team"
    ADD CONSTRAINT idx_19652_primary PRIMARY KEY (name);


--
-- TOC entry 7572 (class 2606 OID 21818)
-- Name: tabSerial No idx_19663_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabSerial No"
    ADD CONSTRAINT idx_19663_primary PRIMARY KEY (name);


--
-- TOC entry 7578 (class 2606 OID 21819)
-- Name: tabShipping Rule idx_19684_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabShipping Rule"
    ADD CONSTRAINT idx_19684_primary PRIMARY KEY (name);


--
-- TOC entry 7581 (class 2606 OID 21820)
-- Name: tabShipping Rule Condition idx_19695_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabShipping Rule Condition"
    ADD CONSTRAINT idx_19695_primary PRIMARY KEY (name);


--
-- TOC entry 7584 (class 2606 OID 21821)
-- Name: tabShipping Rule Country idx_19706_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabShipping Rule Country"
    ADD CONSTRAINT idx_19706_primary PRIMARY KEY (name);


--
-- TOC entry 7588 (class 2606 OID 21822)
-- Name: tabSMS Log idx_19720_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabSMS Log"
    ADD CONSTRAINT idx_19720_primary PRIMARY KEY (name);


--
-- TOC entry 7591 (class 2606 OID 21823)
-- Name: tabSMS Parameter idx_19730_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabSMS Parameter"
    ADD CONSTRAINT idx_19730_primary PRIMARY KEY (name);


--
-- TOC entry 7594 (class 2606 OID 21824)
-- Name: tabStandard Reply idx_19738_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabStandard Reply"
    ADD CONSTRAINT idx_19738_primary PRIMARY KEY (name);


--
-- TOC entry 7599 (class 2606 OID 21825)
-- Name: tabStock Entry idx_19746_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabStock Entry"
    ADD CONSTRAINT idx_19746_primary PRIMARY KEY (name);


--
-- TOC entry 7606 (class 2606 OID 21826)
-- Name: tabStock Entry Detail idx_19764_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabStock Entry Detail"
    ADD CONSTRAINT idx_19764_primary PRIMARY KEY (name);


--
-- TOC entry 7612 (class 2606 OID 21827)
-- Name: tabStock Ledger Entry idx_19781_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabStock Ledger Entry"
    ADD CONSTRAINT idx_19781_primary PRIMARY KEY (name);


--
-- TOC entry 7616 (class 2606 OID 21828)
-- Name: tabStock Reconciliation idx_19796_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabStock Reconciliation"
    ADD CONSTRAINT idx_19796_primary PRIMARY KEY (name);


--
-- TOC entry 7619 (class 2606 OID 21829)
-- Name: tabStock Reconciliation Item idx_19805_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabStock Reconciliation Item"
    ADD CONSTRAINT idx_19805_primary PRIMARY KEY (name);


--
-- TOC entry 7622 (class 2606 OID 21830)
-- Name: tabstudent idx_19820_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabstudent
    ADD CONSTRAINT idx_19820_primary PRIMARY KEY (name);


--
-- TOC entry 7626 (class 2606 OID 21831)
-- Name: tabStudent Admission idx_19828_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabStudent Admission"
    ADD CONSTRAINT idx_19828_primary PRIMARY KEY (name);


--
-- TOC entry 7630 (class 2606 OID 21832)
-- Name: tabStudent Applicant idx_19838_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabStudent Applicant"
    ADD CONSTRAINT idx_19838_primary PRIMARY KEY (name);


--
-- TOC entry 7634 (class 2606 OID 21833)
-- Name: tabStudent Attendance idx_19847_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabStudent Attendance"
    ADD CONSTRAINT idx_19847_primary PRIMARY KEY (name);


--
-- TOC entry 7637 (class 2606 OID 21834)
-- Name: tabStudent Batch idx_19856_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabStudent Batch"
    ADD CONSTRAINT idx_19856_primary PRIMARY KEY (name);


--
-- TOC entry 7640 (class 2606 OID 21835)
-- Name: tabStudent Batch Instructor idx_19865_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabStudent Batch Instructor"
    ADD CONSTRAINT idx_19865_primary PRIMARY KEY (name);


--
-- TOC entry 7643 (class 2606 OID 21836)
-- Name: tabStudent Batch Name idx_19873_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabStudent Batch Name"
    ADD CONSTRAINT idx_19873_primary PRIMARY KEY (name);


--
-- TOC entry 7646 (class 2606 OID 21837)
-- Name: tabStudent Batch Student idx_19881_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabStudent Batch Student"
    ADD CONSTRAINT idx_19881_primary PRIMARY KEY (name);


--
-- TOC entry 7649 (class 2606 OID 21838)
-- Name: tabStudent Category idx_19890_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabStudent Category"
    ADD CONSTRAINT idx_19890_primary PRIMARY KEY (name);


--
-- TOC entry 7652 (class 2606 OID 21839)
-- Name: tabStudent Group idx_19898_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabStudent Group"
    ADD CONSTRAINT idx_19898_primary PRIMARY KEY (name);


--
-- TOC entry 7655 (class 2606 OID 21840)
-- Name: tabStudent Group Creation Tool Course idx_19907_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabStudent Group Creation Tool Course"
    ADD CONSTRAINT idx_19907_primary PRIMARY KEY (name);


--
-- TOC entry 7658 (class 2606 OID 21841)
-- Name: tabStudent Group Student idx_19916_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabStudent Group Student"
    ADD CONSTRAINT idx_19916_primary PRIMARY KEY (name);


--
-- TOC entry 7661 (class 2606 OID 21842)
-- Name: tabStudent Guardian idx_19925_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabStudent Guardian"
    ADD CONSTRAINT idx_19925_primary PRIMARY KEY (name);


--
-- TOC entry 7664 (class 2606 OID 21843)
-- Name: tabStudent Leave Application idx_19933_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabStudent Leave Application"
    ADD CONSTRAINT idx_19933_primary PRIMARY KEY (name);


--
-- TOC entry 7667 (class 2606 OID 21844)
-- Name: tabStudent Log idx_19942_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabStudent Log"
    ADD CONSTRAINT idx_19942_primary PRIMARY KEY (name);


--
-- TOC entry 7670 (class 2606 OID 21845)
-- Name: tabStudent Sibling idx_19950_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabStudent Sibling"
    ADD CONSTRAINT idx_19950_primary PRIMARY KEY (name);


--
-- TOC entry 7673 (class 2606 OID 21846)
-- Name: tabStudent Siblings idx_19958_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabStudent Siblings"
    ADD CONSTRAINT idx_19958_primary PRIMARY KEY (name);


--
-- TOC entry 7676 (class 2606 OID 21847)
-- Name: tabsupplier idx_19966_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabsupplier
    ADD CONSTRAINT idx_19966_primary PRIMARY KEY (name);


--
-- TOC entry 7680 (class 2606 OID 21848)
-- Name: tabSupplier Quotation idx_19977_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabSupplier Quotation"
    ADD CONSTRAINT idx_19977_primary PRIMARY KEY (name);


--
-- TOC entry 7690 (class 2606 OID 21849)
-- Name: tabSupplier Quotation Item idx_20007_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabSupplier Quotation Item"
    ADD CONSTRAINT idx_20007_primary PRIMARY KEY (name);


--
-- TOC entry 7693 (class 2606 OID 21850)
-- Name: tabSupplier Type idx_20030_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabSupplier Type"
    ADD CONSTRAINT idx_20030_primary PRIMARY KEY (name);


--
-- TOC entry 7696 (class 2606 OID 21851)
-- Name: tabtag idx_20039_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabtag
    ADD CONSTRAINT idx_20039_primary PRIMARY KEY (name);


--
-- TOC entry 7699 (class 2606 OID 21852)
-- Name: tabTag Category idx_20047_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabTag Category"
    ADD CONSTRAINT idx_20047_primary PRIMARY KEY (name);


--
-- TOC entry 7702 (class 2606 OID 21853)
-- Name: tabTag Doc Category idx_20055_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabTag Doc Category"
    ADD CONSTRAINT idx_20055_primary PRIMARY KEY (name);


--
-- TOC entry 7707 (class 2606 OID 21854)
-- Name: tabTarget Detail idx_20063_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabTarget Detail"
    ADD CONSTRAINT idx_20063_primary PRIMARY KEY (name);


--
-- TOC entry 7712 (class 2606 OID 21855)
-- Name: tabtask idx_20073_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabtask
    ADD CONSTRAINT idx_20073_primary PRIMARY KEY (name);


--
-- TOC entry 7716 (class 2606 OID 21856)
-- Name: tabTask Depends On idx_20088_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabTask Depends On"
    ADD CONSTRAINT idx_20088_primary PRIMARY KEY (name);


--
-- TOC entry 7719 (class 2606 OID 21857)
-- Name: tabTax Rule idx_20096_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabTax Rule"
    ADD CONSTRAINT idx_20096_primary PRIMARY KEY (name);


--
-- TOC entry 7722 (class 2606 OID 21858)
-- Name: tabTerms and Conditions idx_20107_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabTerms and Conditions"
    ADD CONSTRAINT idx_20107_primary PRIMARY KEY (name);


--
-- TOC entry 7726 (class 2606 OID 21859)
-- Name: tabterritory idx_20116_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabterritory
    ADD CONSTRAINT idx_20116_primary PRIMARY KEY (name);


--
-- TOC entry 7731 (class 2606 OID 21860)
-- Name: tabtimesheet idx_20127_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabtimesheet
    ADD CONSTRAINT idx_20127_primary PRIMARY KEY (name);


--
-- TOC entry 7734 (class 2606 OID 21861)
-- Name: tabTimesheet Detail idx_20143_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabTimesheet Detail"
    ADD CONSTRAINT idx_20143_primary PRIMARY KEY (name);


--
-- TOC entry 7737 (class 2606 OID 21862)
-- Name: tabtodo idx_20159_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabtodo
    ADD CONSTRAINT idx_20159_primary PRIMARY KEY (name);


--
-- TOC entry 7741 (class 2606 OID 21863)
-- Name: tabTop Bar Item idx_20169_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabTop Bar Item"
    ADD CONSTRAINT idx_20169_primary PRIMARY KEY (name);


--
-- TOC entry 7745 (class 2606 OID 21864)
-- Name: tabtopic idx_20178_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabtopic
    ADD CONSTRAINT idx_20178_primary PRIMARY KEY (name);


--
-- TOC entry 7748 (class 2606 OID 21865)
-- Name: tabTraining Event idx_20186_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabTraining Event"
    ADD CONSTRAINT idx_20186_primary PRIMARY KEY (name);


--
-- TOC entry 7751 (class 2606 OID 21866)
-- Name: tabTraining Event Employee idx_20195_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabTraining Event Employee"
    ADD CONSTRAINT idx_20195_primary PRIMARY KEY (name);


--
-- TOC entry 7754 (class 2606 OID 21867)
-- Name: tabTraining Feedback idx_20204_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabTraining Feedback"
    ADD CONSTRAINT idx_20204_primary PRIMARY KEY (name);


--
-- TOC entry 7757 (class 2606 OID 21868)
-- Name: tabTraining Result idx_20212_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabTraining Result"
    ADD CONSTRAINT idx_20212_primary PRIMARY KEY (name);


--
-- TOC entry 7761 (class 2606 OID 21869)
-- Name: tabTraining Result Employee idx_20220_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabTraining Result Employee"
    ADD CONSTRAINT idx_20220_primary PRIMARY KEY (name);


--
-- TOC entry 7765 (class 2606 OID 21870)
-- Name: tabtranslation idx_20229_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabtranslation
    ADD CONSTRAINT idx_20229_primary PRIMARY KEY (name);


--
-- TOC entry 7768 (class 2606 OID 21871)
-- Name: tabUnhandled Email idx_20237_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabUnhandled Email"
    ADD CONSTRAINT idx_20237_primary PRIMARY KEY (name);


--
-- TOC entry 7771 (class 2606 OID 21872)
-- Name: tabuom idx_20245_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabuom
    ADD CONSTRAINT idx_20245_primary PRIMARY KEY (name);


--
-- TOC entry 7774 (class 2606 OID 21873)
-- Name: tabUOM Conversion Detail idx_20254_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabUOM Conversion Detail"
    ADD CONSTRAINT idx_20254_primary PRIMARY KEY (name);


--
-- TOC entry 7777 (class 2606 OID 21874)
-- Name: tabuser idx_20263_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabuser
    ADD CONSTRAINT idx_20263_primary PRIMARY KEY (name);


--
-- TOC entry 7781 (class 2606 OID 21875)
-- Name: tabUser Email idx_20281_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabUser Email"
    ADD CONSTRAINT idx_20281_primary PRIMARY KEY (name);


--
-- TOC entry 7784 (class 2606 OID 21876)
-- Name: tabuserrole idx_20290_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabuserrole
    ADD CONSTRAINT idx_20290_primary PRIMARY KEY (name);


--
-- TOC entry 7788 (class 2606 OID 21878)
-- Name: tabvehicle idx_20298_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabvehicle
    ADD CONSTRAINT idx_20298_primary PRIMARY KEY (name);


--
-- TOC entry 7791 (class 2606 OID 21877)
-- Name: tabVehicle Log idx_20311_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabVehicle Log"
    ADD CONSTRAINT idx_20311_primary PRIMARY KEY (name);


--
-- TOC entry 7794 (class 2606 OID 21879)
-- Name: tabVehicle Service idx_20322_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabVehicle Service"
    ADD CONSTRAINT idx_20322_primary PRIMARY KEY (name);


--
-- TOC entry 7797 (class 2606 OID 21880)
-- Name: tabversion idx_20331_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabversion
    ADD CONSTRAINT idx_20331_primary PRIMARY KEY (name);


--
-- TOC entry 7802 (class 2606 OID 21881)
-- Name: tabwarehouse idx_20339_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabwarehouse
    ADD CONSTRAINT idx_20339_primary PRIMARY KEY (name);


--
-- TOC entry 7809 (class 2606 OID 21882)
-- Name: tabWarranty Claim idx_20351_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabWarranty Claim"
    ADD CONSTRAINT idx_20351_primary PRIMARY KEY (name);


--
-- TOC entry 7816 (class 2606 OID 21883)
-- Name: tabWeb Form idx_20360_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabWeb Form"
    ADD CONSTRAINT idx_20360_primary PRIMARY KEY (name);


--
-- TOC entry 7820 (class 2606 OID 21884)
-- Name: tabWeb Form Field idx_20383_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabWeb Form Field"
    ADD CONSTRAINT idx_20383_primary PRIMARY KEY (name);


--
-- TOC entry 7823 (class 2606 OID 21885)
-- Name: tabWeb Page idx_20396_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabWeb Page"
    ADD CONSTRAINT idx_20396_primary PRIMARY KEY (name);


--
-- TOC entry 7827 (class 2606 OID 21886)
-- Name: tabWebsite Item Group idx_20410_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabWebsite Item Group"
    ADD CONSTRAINT idx_20410_primary PRIMARY KEY (name);


--
-- TOC entry 7830 (class 2606 OID 21887)
-- Name: tabWebsite Sidebar idx_20418_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabWebsite Sidebar"
    ADD CONSTRAINT idx_20418_primary PRIMARY KEY (name);


--
-- TOC entry 7833 (class 2606 OID 21888)
-- Name: tabWebsite Sidebar Item idx_20426_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabWebsite Sidebar Item"
    ADD CONSTRAINT idx_20426_primary PRIMARY KEY (name);


--
-- TOC entry 7836 (class 2606 OID 21889)
-- Name: tabWebsite Slideshow idx_20434_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabWebsite Slideshow"
    ADD CONSTRAINT idx_20434_primary PRIMARY KEY (name);


--
-- TOC entry 7839 (class 2606 OID 21890)
-- Name: tabWebsite Slideshow Item idx_20442_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabWebsite Slideshow Item"
    ADD CONSTRAINT idx_20442_primary PRIMARY KEY (name);


--
-- TOC entry 7842 (class 2606 OID 21891)
-- Name: tabWebsite Theme idx_20450_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabWebsite Theme"
    ADD CONSTRAINT idx_20450_primary PRIMARY KEY (name);


--
-- TOC entry 7846 (class 2606 OID 21892)
-- Name: tabworkflow idx_20462_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabworkflow
    ADD CONSTRAINT idx_20462_primary PRIMARY KEY (name);


--
-- TOC entry 7849 (class 2606 OID 21893)
-- Name: tabWorkflow Action idx_20473_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabWorkflow Action"
    ADD CONSTRAINT idx_20473_primary PRIMARY KEY (name);


--
-- TOC entry 7852 (class 2606 OID 21894)
-- Name: tabWorkflow Document State idx_20481_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabWorkflow Document State"
    ADD CONSTRAINT idx_20481_primary PRIMARY KEY (name);


--
-- TOC entry 7855 (class 2606 OID 21895)
-- Name: tabWorkflow State idx_20489_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabWorkflow State"
    ADD CONSTRAINT idx_20489_primary PRIMARY KEY (name);


--
-- TOC entry 7858 (class 2606 OID 21896)
-- Name: tabWorkflow Transition idx_20497_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabWorkflow Transition"
    ADD CONSTRAINT idx_20497_primary PRIMARY KEY (name);


--
-- TOC entry 7861 (class 2606 OID 21897)
-- Name: tabworkstation idx_20505_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabworkstation
    ADD CONSTRAINT idx_20505_primary PRIMARY KEY (name);


--
-- TOC entry 7864 (class 2606 OID 21898)
-- Name: tabWorkstation Working Hour idx_20518_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tabWorkstation Working Hour"
    ADD CONSTRAINT idx_20518_primary PRIMARY KEY (name);


--
-- TOC entry 7866 (class 2606 OID 21899)
-- Name: __auth idx_20527_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.__auth
    ADD CONSTRAINT idx_20527_primary PRIMARY KEY (doctype, name, fieldname);


--
-- TOC entry 6515 (class 1259 OID 20540)
-- Name: idx_16385_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16385_parent ON public."tabAbout Us Team Member" USING btree (parent);


--
-- TOC entry 6518 (class 1259 OID 20542)
-- Name: idx_16393_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16393_parent ON public."tabAcademic Term" USING btree (parent);


--
-- TOC entry 6521 (class 1259 OID 20544)
-- Name: idx_16393_term_end_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16393_term_end_date ON public."tabAcademic Term" USING btree (term_end_date);


--
-- TOC entry 6522 (class 1259 OID 20545)
-- Name: idx_16393_term_start_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16393_term_start_date ON public."tabAcademic Term" USING btree (term_start_date);


--
-- TOC entry 6523 (class 1259 OID 20548)
-- Name: idx_16401_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16401_parent ON public."tabAcademic Year" USING btree (parent);


--
-- TOC entry 6526 (class 1259 OID 20547)
-- Name: idx_16409_lft; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16409_lft ON public.tabaccount USING btree (lft);


--
-- TOC entry 6527 (class 1259 OID 20549)
-- Name: idx_16409_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16409_parent ON public.tabaccount USING btree (parent);


--
-- TOC entry 6528 (class 1259 OID 20546)
-- Name: idx_16409_parent_account; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16409_parent_account ON public.tabaccount USING btree (parent_account);


--
-- TOC entry 6531 (class 1259 OID 20560)
-- Name: idx_16409_rgt; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16409_rgt ON public.tabaccount USING btree (rgt);


--
-- TOC entry 6532 (class 1259 OID 20551)
-- Name: idx_16421_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16421_parent ON public."tabActivity Cost" USING btree (parent);


--
-- TOC entry 6535 (class 1259 OID 20555)
-- Name: idx_16431_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16431_parent ON public."tabActivity Type" USING btree (parent);


--
-- TOC entry 6538 (class 1259 OID 20554)
-- Name: idx_16441_city; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16441_city ON public.tabaddress USING btree (city);


--
-- TOC entry 6539 (class 1259 OID 20556)
-- Name: idx_16441_country; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16441_country ON public.tabaddress USING btree (country);


--
-- TOC entry 6540 (class 1259 OID 20557)
-- Name: idx_16441_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16441_parent ON public.tabaddress USING btree (parent);


--
-- TOC entry 6541 (class 1259 OID 20553)
-- Name: idx_16441_pincode; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16441_pincode ON public.tabaddress USING btree (pincode);


--
-- TOC entry 6544 (class 1259 OID 20563)
-- Name: idx_16452_country; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16452_country ON public."tabAddress Template" USING btree (country);


--
-- TOC entry 6545 (class 1259 OID 20571)
-- Name: idx_16452_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16452_parent ON public."tabAddress Template" USING btree (parent);


--
-- TOC entry 6548 (class 1259 OID 20573)
-- Name: idx_16461_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16461_parent ON public.tabannouncement USING btree (parent);


--
-- TOC entry 6551 (class 1259 OID 20568)
-- Name: idx_16461_receiver; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16461_receiver ON public.tabannouncement USING btree (receiver);


--
-- TOC entry 6552 (class 1259 OID 20567)
-- Name: idx_16461_student; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16461_student ON public.tabannouncement USING btree (student);


--
-- TOC entry 6553 (class 1259 OID 20566)
-- Name: idx_16461_student_group; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16461_student_group ON public.tabannouncement USING btree (student_group);


--
-- TOC entry 6554 (class 1259 OID 20572)
-- Name: idx_16469_employee; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16469_employee ON public.tabappraisal USING btree (employee);


--
-- TOC entry 6555 (class 1259 OID 20564)
-- Name: idx_16469_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16469_parent ON public.tabappraisal USING btree (parent);


--
-- TOC entry 6558 (class 1259 OID 20575)
-- Name: idx_16469_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16469_status ON public.tabappraisal USING btree (status);


--
-- TOC entry 6559 (class 1259 OID 20583)
-- Name: idx_16479_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16479_parent ON public."tabAppraisal Goal" USING btree (parent);


--
-- TOC entry 6562 (class 1259 OID 20581)
-- Name: idx_16490_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16490_parent ON public."tabAppraisal Template" USING btree (parent);


--
-- TOC entry 6565 (class 1259 OID 20579)
-- Name: idx_16498_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16498_parent ON public."tabAppraisal Template Goal" USING btree (parent);


--
-- TOC entry 6568 (class 1259 OID 20577)
-- Name: idx_16507_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16507_parent ON public."tabAssessment Evaluation Criteria" USING btree (parent);


--
-- TOC entry 6571 (class 1259 OID 20574)
-- Name: idx_16516_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16516_parent ON public."tabAssessment Group" USING btree (parent);


--
-- TOC entry 6574 (class 1259 OID 20582)
-- Name: idx_16524_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16524_parent ON public."tabAssessment Plan" USING btree (parent);


--
-- TOC entry 6577 (class 1259 OID 20584)
-- Name: idx_16533_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16533_parent ON public."tabAssessment Result" USING btree (parent);


--
-- TOC entry 6580 (class 1259 OID 20587)
-- Name: idx_16543_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16543_parent ON public."tabAssessment Result Detail" USING btree (parent);


--
-- TOC entry 6583 (class 1259 OID 20589)
-- Name: idx_16553_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16553_parent ON public.tabasset USING btree (parent);


--
-- TOC entry 6586 (class 1259 OID 20590)
-- Name: idx_16570_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16570_parent ON public."tabAsset Category" USING btree (parent);


--
-- TOC entry 6589 (class 1259 OID 20597)
-- Name: idx_16581_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16581_parent ON public."tabAsset Category Account" USING btree (parent);


--
-- TOC entry 6592 (class 1259 OID 20604)
-- Name: idx_16589_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16589_parent ON public."tabAsset Movement" USING btree (parent);


--
-- TOC entry 6595 (class 1259 OID 20603)
-- Name: idx_16597_employee; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16597_employee ON public.tabattendance USING btree (employee);


--
-- TOC entry 6596 (class 1259 OID 20595)
-- Name: idx_16597_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16597_parent ON public.tabattendance USING btree (parent);


--
-- TOC entry 6599 (class 1259 OID 20599)
-- Name: idx_16597_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16597_status ON public.tabattendance USING btree (status);


--
-- TOC entry 6600 (class 1259 OID 20600)
-- Name: idx_16606_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16606_parent ON public."tabAttendance Tool Student" USING btree (parent);


--
-- TOC entry 6603 (class 1259 OID 20598)
-- Name: idx_16614_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16614_parent ON public."tabAuthorization Rule" USING btree (parent);


--
-- TOC entry 6606 (class 1259 OID 20606)
-- Name: idx_16623_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16623_parent ON public."tabAuto Email Report" USING btree (parent);


--
-- TOC entry 6609 (class 1259 OID 20601)
-- Name: idx_16637_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16637_parent ON public."tabBank Reconciliation Detail" USING btree (parent);


--
-- TOC entry 6612 (class 1259 OID 20611)
-- Name: idx_16645_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16645_parent ON public.tabbatch USING btree (parent);


--
-- TOC entry 6615 (class 1259 OID 20608)
-- Name: idx_16653_item_code; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16653_item_code ON public.tabbin USING btree (item_code);


--
-- TOC entry 6616 (class 1259 OID 20607)
-- Name: idx_16653_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16653_parent ON public.tabbin USING btree (parent);


--
-- TOC entry 6619 (class 1259 OID 20610)
-- Name: idx_16653_warehouse; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16653_warehouse ON public.tabbin USING btree (warehouse);


--
-- TOC entry 6620 (class 1259 OID 20620)
-- Name: idx_16672_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16672_parent ON public."tabBlock Module" USING btree (parent);


--
-- TOC entry 6623 (class 1259 OID 20625)
-- Name: idx_16680_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16680_parent ON public."tabBlog Category" USING btree (parent);


--
-- TOC entry 6626 (class 1259 OID 20624)
-- Name: idx_16680_route; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_16680_route ON public."tabBlog Category" USING btree (route);


--
-- TOC entry 6627 (class 1259 OID 20619)
-- Name: idx_16689_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16689_parent ON public."tabBlog Post" USING btree (parent);


--
-- TOC entry 6630 (class 1259 OID 20618)
-- Name: idx_16689_route; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_16689_route ON public."tabBlog Post" USING btree (route);


--
-- TOC entry 6631 (class 1259 OID 20616)
-- Name: idx_16699_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16699_parent ON public.tabblogger USING btree (parent);


--
-- TOC entry 6634 (class 1259 OID 20622)
-- Name: idx_16709_item; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16709_item ON public.tabbom USING btree (item);


--
-- TOC entry 6635 (class 1259 OID 20633)
-- Name: idx_16709_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16709_parent ON public.tabbom USING btree (parent);


--
-- TOC entry 6638 (class 1259 OID 20643)
-- Name: idx_16729_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16729_parent ON public."tabBOM Explosion Item" USING btree (parent);


--
-- TOC entry 6641 (class 1259 OID 20635)
-- Name: idx_16741_bom_no; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16741_bom_no ON public."tabBOM Item" USING btree (bom_no);


--
-- TOC entry 6642 (class 1259 OID 20630)
-- Name: idx_16741_item_code; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16741_item_code ON public."tabBOM Item" USING btree (item_code);


--
-- TOC entry 6643 (class 1259 OID 20641)
-- Name: idx_16741_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16741_parent ON public."tabBOM Item" USING btree (parent);


--
-- TOC entry 6646 (class 1259 OID 20627)
-- Name: idx_16756_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16756_parent ON public."tabBOM Operation" USING btree (parent);


--
-- TOC entry 6649 (class 1259 OID 20629)
-- Name: idx_16769_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16769_parent ON public."tabBOM Scrap Item" USING btree (parent);


--
-- TOC entry 6652 (class 1259 OID 20639)
-- Name: idx_16782_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16782_parent ON public.tabbranch USING btree (parent);


--
-- TOC entry 6655 (class 1259 OID 20634)
-- Name: idx_16790_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16790_parent ON public.tabbrand USING btree (parent);


--
-- TOC entry 6658 (class 1259 OID 20638)
-- Name: idx_16798_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16798_parent ON public.tabbudget USING btree (parent);


--
-- TOC entry 6661 (class 1259 OID 20636)
-- Name: idx_16809_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16809_parent ON public."tabBudget Account" USING btree (parent);


--
-- TOC entry 6664 (class 1259 OID 20653)
-- Name: idx_16818_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16818_parent ON public."tabC-Form" USING btree (parent);


--
-- TOC entry 6667 (class 1259 OID 20649)
-- Name: idx_16828_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16828_parent ON public."tabC-Form Invoice Detail" USING btree (parent);


--
-- TOC entry 6670 (class 1259 OID 20661)
-- Name: idx_16838_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16838_parent ON public.tabcampaign USING btree (parent);


--
-- TOC entry 6673 (class 1259 OID 20657)
-- Name: idx_16846_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16846_parent ON public."tabCheque Print Template" USING btree (parent);


--
-- TOC entry 6676 (class 1259 OID 20662)
-- Name: idx_16877_communication_date_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16877_communication_date_index ON public.tabcommunication USING btree (communication_date);


--
-- TOC entry 6677 (class 1259 OID 20652)
-- Name: idx_16877_link_doctype_link_name_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16877_link_doctype_link_name_index ON public.tabcommunication USING btree (link_doctype, link_name);


--
-- TOC entry 6678 (class 1259 OID 20654)
-- Name: idx_16877_message_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16877_message_id_index ON public.tabcommunication USING btree (message_id);


--
-- TOC entry 6679 (class 1259 OID 20665)
-- Name: idx_16877_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16877_parent ON public.tabcommunication USING btree (parent);


--
-- TOC entry 6682 (class 1259 OID 20664)
-- Name: idx_16877_reference_doctype_reference_name_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16877_reference_doctype_reference_name_index ON public.tabcommunication USING btree (reference_doctype, reference_name);


--
-- TOC entry 6683 (class 1259 OID 20658)
-- Name: idx_16877_reference_owner; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16877_reference_owner ON public.tabcommunication USING btree (reference_owner);


--
-- TOC entry 6684 (class 1259 OID 20671)
-- Name: idx_16877_status_communication_type_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16877_status_communication_type_index ON public.tabcommunication USING btree (status, communication_type);


--
-- TOC entry 6685 (class 1259 OID 20656)
-- Name: idx_16877_timeline_doctype_timeline_name_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16877_timeline_doctype_timeline_name_index ON public.tabcommunication USING btree (timeline_doctype, timeline_name);


--
-- TOC entry 6686 (class 1259 OID 20669)
-- Name: idx_16889_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16889_parent ON public.tabcompany USING btree (parent);


--
-- TOC entry 6689 (class 1259 OID 20673)
-- Name: idx_16899_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16899_parent ON public."tabCompany History" USING btree (parent);


--
-- TOC entry 6692 (class 1259 OID 20663)
-- Name: idx_16907_email_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16907_email_id ON public.tabcontact USING btree (email_id);


--
-- TOC entry 6693 (class 1259 OID 20674)
-- Name: idx_16907_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16907_parent ON public.tabcontact USING btree (parent);


--
-- TOC entry 6696 (class 1259 OID 20672)
-- Name: idx_16918_lft; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16918_lft ON public."tabCost Center" USING btree (lft);


--
-- TOC entry 6697 (class 1259 OID 20668)
-- Name: idx_16918_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16918_parent ON public."tabCost Center" USING btree (parent);


--
-- TOC entry 6700 (class 1259 OID 20667)
-- Name: idx_16918_rgt; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16918_rgt ON public."tabCost Center" USING btree (rgt);


--
-- TOC entry 6701 (class 1259 OID 20681)
-- Name: idx_16929_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16929_parent ON public.tabcountry USING btree (parent);


--
-- TOC entry 6704 (class 1259 OID 20686)
-- Name: idx_16937_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16937_parent ON public.tabcourse USING btree (parent);


--
-- TOC entry 6707 (class 1259 OID 20677)
-- Name: idx_16945_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16945_parent ON public."tabCourse Evaluation Criteria" USING btree (parent);


--
-- TOC entry 6710 (class 1259 OID 20676)
-- Name: idx_16954_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16954_parent ON public."tabCourse Schedule" USING btree (parent);


--
-- TOC entry 6713 (class 1259 OID 20680)
-- Name: idx_16963_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16963_parent ON public.tabcurrency USING btree (parent);


--
-- TOC entry 6716 (class 1259 OID 20678)
-- Name: idx_16974_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16974_parent ON public."tabCurrency Exchange" USING btree (parent);


--
-- TOC entry 6719 (class 1259 OID 20687)
-- Name: idx_16983_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_16983_parent ON public."tabCustom DocPerm" USING btree (parent);


--
-- TOC entry 6722 (class 1259 OID 20682)
-- Name: idx_17008_dt; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17008_dt ON public."tabCustom Field" USING btree (dt);


--
-- TOC entry 6723 (class 1259 OID 20683)
-- Name: idx_17008_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17008_parent ON public."tabCustom Field" USING btree (parent);


--
-- TOC entry 6726 (class 1259 OID 20689)
-- Name: idx_17034_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17034_parent ON public."tabCustom Script" USING btree (parent);


--
-- TOC entry 6729 (class 1259 OID 20684)
-- Name: idx_17043_customer_group; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17043_customer_group ON public.tabcustomer USING btree (customer_group);


--
-- TOC entry 6730 (class 1259 OID 20696)
-- Name: idx_17043_customer_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17043_customer_name ON public.tabcustomer USING btree (customer_name);


--
-- TOC entry 6731 (class 1259 OID 20692)
-- Name: idx_17043_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17043_parent ON public.tabcustomer USING btree (parent);


--
-- TOC entry 6734 (class 1259 OID 20698)
-- Name: idx_17057_lft; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17057_lft ON public."tabCustomer Group" USING btree (lft);


--
-- TOC entry 6735 (class 1259 OID 20708)
-- Name: idx_17057_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17057_parent ON public."tabCustomer Group" USING btree (parent);


--
-- TOC entry 6738 (class 1259 OID 20694)
-- Name: idx_17057_rgt; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17057_rgt ON public."tabCustomer Group" USING btree (rgt);


--
-- TOC entry 6739 (class 1259 OID 20706)
-- Name: idx_17070_fieldname; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17070_fieldname ON public."tabCustomize Form Field" USING btree (fieldname);


--
-- TOC entry 6740 (class 1259 OID 20699)
-- Name: idx_17070_fieldtype; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17070_fieldtype ON public."tabCustomize Form Field" USING btree (fieldtype);


--
-- TOC entry 6741 (class 1259 OID 20707)
-- Name: idx_17070_label; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17070_label ON public."tabCustomize Form Field" USING btree (label);


--
-- TOC entry 6742 (class 1259 OID 20701)
-- Name: idx_17070_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17070_parent ON public."tabCustomize Form Field" USING btree (parent);


--
-- TOC entry 6745 (class 1259 OID 20700)
-- Name: idx_17097_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17097_parent ON public."tabDaily Work Summary" USING btree (parent);


--
-- TOC entry 6748 (class 1259 OID 20710)
-- Name: idx_17106_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17106_parent ON public."tabDaily Work Summary Settings Company" USING btree (parent);


--
-- TOC entry 6751 (class 1259 OID 20702)
-- Name: idx_17115_defaultvalue_parent_defkey_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17115_defaultvalue_parent_defkey_index ON public.tabdefaultvalue USING btree (parent, defkey);


--
-- TOC entry 6752 (class 1259 OID 20705)
-- Name: idx_17115_defaultvalue_parent_parenttype_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17115_defaultvalue_parent_parenttype_index ON public.tabdefaultvalue USING btree (parent, parenttype);


--
-- TOC entry 6753 (class 1259 OID 20718)
-- Name: idx_17115_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17115_parent ON public.tabdefaultvalue USING btree (parent);


--
-- TOC entry 6756 (class 1259 OID 20721)
-- Name: idx_17123_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17123_parent ON public."tabDeleted Document" USING btree (parent);


--
-- TOC entry 6759 (class 1259 OID 20725)
-- Name: idx_17132_company; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17132_company ON public."tabDelivery Note" USING btree (company);


--
-- TOC entry 6760 (class 1259 OID 20711)
-- Name: idx_17132_customer; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17132_customer ON public."tabDelivery Note" USING btree (customer);


--
-- TOC entry 6761 (class 1259 OID 20723)
-- Name: idx_17132_customer_group; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17132_customer_group ON public."tabDelivery Note" USING btree (customer_group);


--
-- TOC entry 6762 (class 1259 OID 20717)
-- Name: idx_17132_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17132_parent ON public."tabDelivery Note" USING btree (parent);


--
-- TOC entry 6763 (class 1259 OID 20731)
-- Name: idx_17132_per_installed; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17132_per_installed ON public."tabDelivery Note" USING btree (per_installed);


--
-- TOC entry 6764 (class 1259 OID 20715)
-- Name: idx_17132_posting_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17132_posting_date ON public."tabDelivery Note" USING btree (posting_date);


--
-- TOC entry 6767 (class 1259 OID 20730)
-- Name: idx_17132_project; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17132_project ON public."tabDelivery Note" USING btree (project);


--
-- TOC entry 6768 (class 1259 OID 20719)
-- Name: idx_17132_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17132_status ON public."tabDelivery Note" USING btree (status);


--
-- TOC entry 6769 (class 1259 OID 20728)
-- Name: idx_17132_territory; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17132_territory ON public."tabDelivery Note" USING btree (territory);


--
-- TOC entry 6770 (class 1259 OID 20727)
-- Name: idx_17165_item_code; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17165_item_code ON public."tabDelivery Note Item" USING btree (item_code);


--
-- TOC entry 6771 (class 1259 OID 20737)
-- Name: idx_17165_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17165_parent ON public."tabDelivery Note Item" USING btree (parent);


--
-- TOC entry 6774 (class 1259 OID 20735)
-- Name: idx_17165_so_detail; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17165_so_detail ON public."tabDelivery Note Item" USING btree (so_detail);


--
-- TOC entry 6775 (class 1259 OID 20729)
-- Name: idx_17192_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17192_parent ON public.tabdepartment USING btree (parent);


--
-- TOC entry 6778 (class 1259 OID 20726)
-- Name: idx_17200_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17200_parent ON public."tabDependent Task" USING btree (parent);


--
-- TOC entry 6781 (class 1259 OID 20744)
-- Name: idx_17208_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17208_parent ON public."tabDepreciation Schedule" USING btree (parent);


--
-- TOC entry 6784 (class 1259 OID 20739)
-- Name: idx_17218_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17218_parent ON public.tabdesignation USING btree (parent);


--
-- TOC entry 6787 (class 1259 OID 20750)
-- Name: idx_17226_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17226_parent ON public."tabDesktop Icon" USING btree (parent);


--
-- TOC entry 6790 (class 1259 OID 20745)
-- Name: idx_17226_unique_module_name_owner_standard; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_17226_unique_module_name_owner_standard ON public."tabDesktop Icon" USING btree (module_name, owner, standard);


--
-- TOC entry 6791 (class 1259 OID 20743)
-- Name: idx_17240_course; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17240_course ON public.tabdiscussion USING btree (course);


--
-- TOC entry 6792 (class 1259 OID 20752)
-- Name: idx_17240_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17240_parent ON public.tabdiscussion USING btree (parent);


--
-- TOC entry 6795 (class 1259 OID 20733)
-- Name: idx_17240_subject; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17240_subject ON public.tabdiscussion USING btree (subject);


--
-- TOC entry 6796 (class 1259 OID 20755)
-- Name: idx_17248_fieldname; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17248_fieldname ON public.tabdocfield USING btree (fieldname);


--
-- TOC entry 6797 (class 1259 OID 20742)
-- Name: idx_17248_fieldtype; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17248_fieldtype ON public.tabdocfield USING btree (fieldtype);


--
-- TOC entry 6798 (class 1259 OID 20747)
-- Name: idx_17248_label; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17248_label ON public.tabdocfield USING btree (label);


--
-- TOC entry 6799 (class 1259 OID 20748)
-- Name: idx_17248_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17248_parent ON public.tabdocfield USING btree (parent);


--
-- TOC entry 6802 (class 1259 OID 20746)
-- Name: idx_17279_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17279_parent ON public.tabdocperm USING btree (parent);


--
-- TOC entry 6805 (class 1259 OID 20751)
-- Name: idx_17304_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17304_parent ON public.tabdocshare USING btree (parent);


--
-- TOC entry 6808 (class 1259 OID 20749)
-- Name: idx_17304_share_doctype; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17304_share_doctype ON public.tabdocshare USING btree (share_doctype);


--
-- TOC entry 6809 (class 1259 OID 20740)
-- Name: idx_17304_share_doctype_share_name_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17304_share_doctype_share_name_index ON public.tabdocshare USING btree (share_doctype, share_name);


--
-- TOC entry 6810 (class 1259 OID 20765)
-- Name: idx_17304_share_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17304_share_name ON public.tabdocshare USING btree (share_name);


--
-- TOC entry 6811 (class 1259 OID 20753)
-- Name: idx_17304_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17304_user ON public.tabdocshare USING btree ("user");


--
-- TOC entry 6812 (class 1259 OID 20759)
-- Name: idx_17304_user_share_doctype_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17304_user_share_doctype_index ON public.tabdocshare USING btree ("user", share_doctype);


--
-- TOC entry 6813 (class 1259 OID 20760)
-- Name: idx_17316_module; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17316_module ON public.tabdoctype USING btree (module);


--
-- TOC entry 6814 (class 1259 OID 20770)
-- Name: idx_17316_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17316_parent ON public.tabdoctype USING btree (parent);


--
-- TOC entry 6817 (class 1259 OID 20769)
-- Name: idx_17348_link_doctype_link_name_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17348_link_doctype_link_name_index ON public."tabDynamic Link" USING btree (link_doctype, link_name);


--
-- TOC entry 6818 (class 1259 OID 20762)
-- Name: idx_17348_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17348_parent ON public."tabDynamic Link" USING btree (parent);


--
-- TOC entry 6821 (class 1259 OID 20761)
-- Name: idx_17356_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17356_parent ON public."tabEmail Account" USING btree (parent);


--
-- TOC entry 6824 (class 1259 OID 20776)
-- Name: idx_17381_document_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17381_document_type ON public."tabEmail Alert" USING btree (document_type);


--
-- TOC entry 6825 (class 1259 OID 20767)
-- Name: idx_17381_event; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17381_event ON public."tabEmail Alert" USING btree (event);


--
-- TOC entry 6826 (class 1259 OID 20773)
-- Name: idx_17381_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17381_parent ON public."tabEmail Alert" USING btree (parent);


--
-- TOC entry 6829 (class 1259 OID 20782)
-- Name: idx_17393_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17393_parent ON public."tabEmail Alert Recipient" USING btree (parent);


--
-- TOC entry 6832 (class 1259 OID 20779)
-- Name: idx_17401_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17401_parent ON public."tabEmail Digest" USING btree (parent);


--
-- TOC entry 6835 (class 1259 OID 20789)
-- Name: idx_17430_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17430_parent ON public."tabEmail Domain" USING btree (parent);


--
-- TOC entry 6838 (class 1259 OID 20766)
-- Name: idx_17442_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17442_parent ON public."tabEmail Flag Queue" USING btree (parent);


--
-- TOC entry 6841 (class 1259 OID 20774)
-- Name: idx_17450_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17450_parent ON public."tabEmail Group" USING btree (parent);


--
-- TOC entry 6844 (class 1259 OID 20780)
-- Name: idx_17459_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17459_parent ON public."tabEmail Group Member" USING btree (parent);


--
-- TOC entry 6847 (class 1259 OID 20775)
-- Name: idx_17459_unique_email_group_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_17459_unique_email_group_email ON public."tabEmail Group Member" USING btree (email_group, email);


--
-- TOC entry 6848 (class 1259 OID 20792)
-- Name: idx_17468_communication; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17468_communication ON public."tabEmail Queue" USING btree (communication);


--
-- TOC entry 6849 (class 1259 OID 20783)
-- Name: idx_17468_index_bulk_flush; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17468_index_bulk_flush ON public."tabEmail Queue" USING btree (status, send_after, priority, creation);


--
-- TOC entry 6850 (class 1259 OID 20800)
-- Name: idx_17468_message_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17468_message_id ON public."tabEmail Queue" USING btree (message_id);


--
-- TOC entry 6851 (class 1259 OID 20781)
-- Name: idx_17468_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17468_parent ON public."tabEmail Queue" USING btree (parent);


--
-- TOC entry 6854 (class 1259 OID 20797)
-- Name: idx_17478_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17478_parent ON public."tabEmail Queue Recipient" USING btree (parent);


--
-- TOC entry 6857 (class 1259 OID 20795)
-- Name: idx_17487_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17487_parent ON public."tabEmail Unsubscribe" USING btree (parent);


--
-- TOC entry 6860 (class 1259 OID 20804)
-- Name: idx_17496_designation; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17496_designation ON public.tabemployee USING btree (designation);


--
-- TOC entry 6861 (class 1259 OID 20786)
-- Name: idx_17496_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17496_parent ON public.tabemployee USING btree (parent);


--
-- TOC entry 6864 (class 1259 OID 20794)
-- Name: idx_17496_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17496_status ON public.tabemployee USING btree (status);


--
-- TOC entry 6865 (class 1259 OID 20811)
-- Name: idx_17507_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17507_parent ON public."tabEmployee Education" USING btree (parent);


--
-- TOC entry 6868 (class 1259 OID 20787)
-- Name: idx_17516_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17516_parent ON public."tabEmployee External Work History" USING btree (parent);


--
-- TOC entry 6871 (class 1259 OID 20793)
-- Name: idx_17525_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17525_parent ON public."tabEmployee Internal Work History" USING btree (parent);


--
-- TOC entry 6874 (class 1259 OID 20802)
-- Name: idx_17533_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17533_parent ON public."tabEmployee Leave Approver" USING btree (parent);


--
-- TOC entry 6877 (class 1259 OID 20801)
-- Name: idx_17541_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17541_parent ON public."tabEmployment Type" USING btree (parent);


--
-- TOC entry 6880 (class 1259 OID 20807)
-- Name: idx_17549_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17549_parent ON public."tabError Log" USING btree (parent);


--
-- TOC entry 6883 (class 1259 OID 20806)
-- Name: idx_17558_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17558_parent ON public."tabError Snapshot" USING btree (parent);


--
-- TOC entry 6886 (class 1259 OID 20819)
-- Name: idx_17568_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17568_parent ON public."tabEvaluation Criteria" USING btree (parent);


--
-- TOC entry 6889 (class 1259 OID 20817)
-- Name: idx_17576_event_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17576_event_type ON public.tabevent USING btree (event_type);


--
-- TOC entry 6890 (class 1259 OID 20815)
-- Name: idx_17576_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17576_parent ON public.tabevent USING btree (parent);


--
-- TOC entry 6893 (class 1259 OID 20809)
-- Name: idx_17594_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17594_parent ON public."tabEvent Role" USING btree (parent);


--
-- TOC entry 6896 (class 1259 OID 20814)
-- Name: idx_17602_approval_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17602_approval_status ON public."tabExpense Claim" USING btree (approval_status);


--
-- TOC entry 6897 (class 1259 OID 20832)
-- Name: idx_17602_employee; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17602_employee ON public."tabExpense Claim" USING btree (employee);


--
-- TOC entry 6898 (class 1259 OID 20816)
-- Name: idx_17602_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17602_parent ON public."tabExpense Claim" USING btree (parent);


--
-- TOC entry 6901 (class 1259 OID 20830)
-- Name: idx_17616_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17616_parent ON public."tabExpense Claim Account" USING btree (parent);


--
-- TOC entry 6904 (class 1259 OID 20828)
-- Name: idx_17624_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17624_parent ON public."tabExpense Claim Detail" USING btree (parent);


--
-- TOC entry 6907 (class 1259 OID 20833)
-- Name: idx_17634_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17634_parent ON public."tabExpense Claim Type" USING btree (parent);


--
-- TOC entry 6910 (class 1259 OID 20834)
-- Name: idx_17642_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17642_parent ON public."tabFee Category" USING btree (parent);


--
-- TOC entry 6913 (class 1259 OID 20843)
-- Name: idx_17650_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17650_parent ON public."tabFee Component" USING btree (parent);


--
-- TOC entry 6916 (class 1259 OID 20822)
-- Name: idx_17659_academic_term; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17659_academic_term ON public."tabFee Structure" USING btree (academic_term);


--
-- TOC entry 6917 (class 1259 OID 20840)
-- Name: idx_17659_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17659_parent ON public."tabFee Structure" USING btree (parent);


--
-- TOC entry 6920 (class 1259 OID 20841)
-- Name: idx_17659_program; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17659_program ON public."tabFee Structure" USING btree (program);


--
-- TOC entry 6921 (class 1259 OID 20839)
-- Name: idx_17668_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17668_parent ON public.tabfees USING btree (parent);


--
-- TOC entry 6924 (class 1259 OID 20831)
-- Name: idx_17679_attached_to_doctype; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17679_attached_to_doctype ON public.tabfile USING btree (attached_to_doctype);


--
-- TOC entry 6925 (class 1259 OID 20844)
-- Name: idx_17679_attached_to_doctype_attached_to_name_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17679_attached_to_doctype_attached_to_name_index ON public.tabfile USING btree (attached_to_doctype, attached_to_name);


--
-- TOC entry 6926 (class 1259 OID 20838)
-- Name: idx_17679_attached_to_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17679_attached_to_name ON public.tabfile USING btree (attached_to_name);


--
-- TOC entry 6927 (class 1259 OID 20854)
-- Name: idx_17679_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17679_parent ON public.tabfile USING btree (parent);


--
-- TOC entry 6930 (class 1259 OID 20835)
-- Name: idx_17694_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17694_parent ON public."tabFiscal Year" USING btree (parent);


--
-- TOC entry 6933 (class 1259 OID 20837)
-- Name: idx_17703_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17703_parent ON public."tabFiscal Year Company" USING btree (parent);


--
-- TOC entry 6936 (class 1259 OID 20851)
-- Name: idx_17711_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17711_parent ON public."tabFooter Item" USING btree (parent);


--
-- TOC entry 6939 (class 1259 OID 20842)
-- Name: idx_17719_account; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17719_account ON public."tabGL Entry" USING btree (account);


--
-- TOC entry 6940 (class 1259 OID 20855)
-- Name: idx_17719_against_voucher; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17719_against_voucher ON public."tabGL Entry" USING btree (against_voucher);


--
-- TOC entry 6941 (class 1259 OID 20849)
-- Name: idx_17719_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17719_parent ON public."tabGL Entry" USING btree (parent);


--
-- TOC entry 6942 (class 1259 OID 20865)
-- Name: idx_17719_party; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17719_party ON public."tabGL Entry" USING btree (party);


--
-- TOC entry 6943 (class 1259 OID 20846)
-- Name: idx_17719_posting_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17719_posting_date ON public."tabGL Entry" USING btree (posting_date);


--
-- TOC entry 6946 (class 1259 OID 20862)
-- Name: idx_17719_voucher_no; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17719_voucher_no ON public."tabGL Entry" USING btree (voucher_no);


--
-- TOC entry 6947 (class 1259 OID 20852)
-- Name: idx_17731_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17731_parent ON public."tabGrade Interval" USING btree (parent);


--
-- TOC entry 6950 (class 1259 OID 20859)
-- Name: idx_17740_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17740_parent ON public."tabGrading Scale" USING btree (parent);


--
-- TOC entry 6953 (class 1259 OID 20853)
-- Name: idx_17748_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17748_parent ON public."tabGrading Scale Interval" USING btree (parent);


--
-- TOC entry 6956 (class 1259 OID 20864)
-- Name: idx_17757_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17757_parent ON public."tabGrading Structure" USING btree (parent);


--
-- TOC entry 6959 (class 1259 OID 20856)
-- Name: idx_17765_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17765_parent ON public.tabguardian USING btree (parent);


--
-- TOC entry 6962 (class 1259 OID 20874)
-- Name: idx_17773_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17773_parent ON public."tabGuardian Interest" USING btree (parent);


--
-- TOC entry 6965 (class 1259 OID 20866)
-- Name: idx_17781_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17781_parent ON public."tabHelp Article" USING btree (parent);


--
-- TOC entry 6968 (class 1259 OID 20878)
-- Name: idx_17792_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17792_parent ON public."tabHelp Category" USING btree (parent);


--
-- TOC entry 6971 (class 1259 OID 20880)
-- Name: idx_17802_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17802_parent ON public.tabholiday USING btree (parent);


--
-- TOC entry 6974 (class 1259 OID 20887)
-- Name: idx_17810_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17810_parent ON public."tabHoliday List" USING btree (parent);


--
-- TOC entry 6977 (class 1259 OID 20869)
-- Name: idx_17818_item_code; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17818_item_code ON public."tabHomepage Featured Product" USING btree (item_code);


--
-- TOC entry 6978 (class 1259 OID 20886)
-- Name: idx_17818_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17818_parent ON public."tabHomepage Featured Product" USING btree (parent);


--
-- TOC entry 6981 (class 1259 OID 20883)
-- Name: idx_17826_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17826_parent ON public."tabIndustry Type" USING btree (parent);


--
-- TOC entry 6984 (class 1259 OID 20891)
-- Name: idx_17834_customer; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17834_customer ON public."tabInstallation Note" USING btree (customer);


--
-- TOC entry 6985 (class 1259 OID 20873)
-- Name: idx_17834_inst_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17834_inst_date ON public."tabInstallation Note" USING btree (inst_date);


--
-- TOC entry 6986 (class 1259 OID 20892)
-- Name: idx_17834_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17834_parent ON public."tabInstallation Note" USING btree (parent);


--
-- TOC entry 6989 (class 1259 OID 20898)
-- Name: idx_17834_territory; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17834_territory ON public."tabInstallation Note" USING btree (territory);


--
-- TOC entry 6990 (class 1259 OID 20885)
-- Name: idx_17843_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17843_parent ON public."tabInstallation Note Item" USING btree (parent);


--
-- TOC entry 6991 (class 1259 OID 20877)
-- Name: idx_17843_prevdoc_docname; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17843_prevdoc_docname ON public."tabInstallation Note Item" USING btree (prevdoc_docname);


--
-- TOC entry 6992 (class 1259 OID 20895)
-- Name: idx_17843_prevdoc_doctype; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17843_prevdoc_doctype ON public."tabInstallation Note Item" USING btree (prevdoc_doctype);


--
-- TOC entry 6995 (class 1259 OID 20896)
-- Name: idx_17852_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17852_parent ON public.tabinstructor USING btree (parent);


--
-- TOC entry 6998 (class 1259 OID 20902)
-- Name: idx_17860_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17860_parent ON public."tabIntegration Request" USING btree (parent);


--
-- TOC entry 7001 (class 1259 OID 20903)
-- Name: idx_17869_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17869_parent ON public."tabIntegration Service" USING btree (parent);


--
-- TOC entry 7004 (class 1259 OID 20910)
-- Name: idx_17878_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17878_parent ON public."tabIntegration Service Parameter" USING btree (parent);


--
-- TOC entry 7007 (class 1259 OID 20888)
-- Name: idx_17886_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17886_parent ON public.tabinterest USING btree (parent);


--
-- TOC entry 7010 (class 1259 OID 20889)
-- Name: idx_17894_customer; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17894_customer ON public.tabissue USING btree (customer);


--
-- TOC entry 7011 (class 1259 OID 20900)
-- Name: idx_17894_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17894_parent ON public.tabissue USING btree (parent);


--
-- TOC entry 7014 (class 1259 OID 20917)
-- Name: idx_17894_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17894_status ON public.tabissue USING btree (status);


--
-- TOC entry 7015 (class 1259 OID 20893)
-- Name: idx_17904_item_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17904_item_name ON public.tabitem USING btree (item_name);


--
-- TOC entry 7016 (class 1259 OID 20918)
-- Name: idx_17904_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17904_parent ON public.tabitem USING btree (parent);


--
-- TOC entry 7019 (class 1259 OID 20922)
-- Name: idx_17904_weightage; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17904_weightage ON public.tabitem USING btree (weightage);


--
-- TOC entry 7020 (class 1259 OID 20905)
-- Name: idx_17942_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17942_parent ON public."tabItem Attribute" USING btree (parent);


--
-- TOC entry 7023 (class 1259 OID 20919)
-- Name: idx_17954_abbr; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17954_abbr ON public."tabItem Attribute Value" USING btree (abbr);


--
-- TOC entry 7024 (class 1259 OID 20906)
-- Name: idx_17954_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17954_parent ON public."tabItem Attribute Value" USING btree (parent);


--
-- TOC entry 7027 (class 1259 OID 20916)
-- Name: idx_17962_customer_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17962_customer_name ON public."tabItem Customer Detail" USING btree (customer_name);


--
-- TOC entry 7028 (class 1259 OID 20927)
-- Name: idx_17962_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17962_parent ON public."tabItem Customer Detail" USING btree (parent);


--
-- TOC entry 7031 (class 1259 OID 20931)
-- Name: idx_17962_ref_code; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17962_ref_code ON public."tabItem Customer Detail" USING btree (ref_code);


--
-- TOC entry 7032 (class 1259 OID 20913)
-- Name: idx_17970_lft; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17970_lft ON public."tabItem Group" USING btree (lft);


--
-- TOC entry 7033 (class 1259 OID 20932)
-- Name: idx_17970_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17970_parent ON public."tabItem Group" USING btree (parent);


--
-- TOC entry 7036 (class 1259 OID 20911)
-- Name: idx_17970_rgt; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17970_rgt ON public."tabItem Group" USING btree (rgt);


--
-- TOC entry 7037 (class 1259 OID 20928)
-- Name: idx_17970_route; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_17970_route ON public."tabItem Group" USING btree (route);


--
-- TOC entry 7038 (class 1259 OID 20920)
-- Name: idx_17982_item_code; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17982_item_code ON public."tabItem Price" USING btree (item_code);


--
-- TOC entry 7039 (class 1259 OID 20923)
-- Name: idx_17982_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17982_parent ON public."tabItem Price" USING btree (parent);


--
-- TOC entry 7042 (class 1259 OID 20939)
-- Name: idx_17993_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_17993_parent ON public."tabItem Quality Inspection Parameter" USING btree (parent);


--
-- TOC entry 7045 (class 1259 OID 20943)
-- Name: idx_18001_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18001_parent ON public."tabItem Reorder" USING btree (parent);


--
-- TOC entry 7048 (class 1259 OID 20944)
-- Name: idx_18011_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18011_parent ON public."tabItem Supplier" USING btree (parent);


--
-- TOC entry 7051 (class 1259 OID 20924)
-- Name: idx_18019_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18019_parent ON public."tabItem Tax" USING btree (parent);


--
-- TOC entry 7054 (class 1259 OID 20929)
-- Name: idx_18028_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18028_parent ON public."tabItem Variant" USING btree (parent);


--
-- TOC entry 7057 (class 1259 OID 20936)
-- Name: idx_18036_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18036_parent ON public."tabItem Variant Attribute" USING btree (parent);


--
-- TOC entry 7060 (class 1259 OID 20926)
-- Name: idx_18048_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18048_parent ON public."tabItem Website Specification" USING btree (parent);


--
-- TOC entry 7063 (class 1259 OID 20945)
-- Name: idx_18056_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18056_parent ON public."tabJob Applicant" USING btree (parent);


--
-- TOC entry 7066 (class 1259 OID 20938)
-- Name: idx_18064_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18064_parent ON public."tabJob Opening" USING btree (parent);


--
-- TOC entry 7069 (class 1259 OID 20952)
-- Name: idx_18064_route; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_18064_route ON public."tabJob Opening" USING btree (route);


--
-- TOC entry 7070 (class 1259 OID 20937)
-- Name: idx_18073_cheque_no; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18073_cheque_no ON public."tabJournal Entry" USING btree (cheque_no);


--
-- TOC entry 7071 (class 1259 OID 20947)
-- Name: idx_18073_clearance_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18073_clearance_date ON public."tabJournal Entry" USING btree (clearance_date);


--
-- TOC entry 7072 (class 1259 OID 20946)
-- Name: idx_18073_company; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18073_company ON public."tabJournal Entry" USING btree (company);


--
-- TOC entry 7073 (class 1259 OID 20961)
-- Name: idx_18073_is_opening; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18073_is_opening ON public."tabJournal Entry" USING btree (is_opening);


--
-- TOC entry 7074 (class 1259 OID 20941)
-- Name: idx_18073_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18073_parent ON public."tabJournal Entry" USING btree (parent);


--
-- TOC entry 7075 (class 1259 OID 20966)
-- Name: idx_18073_posting_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18073_posting_date ON public."tabJournal Entry" USING btree (posting_date);


--
-- TOC entry 7078 (class 1259 OID 20965)
-- Name: idx_18073_voucher_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18073_voucher_type ON public."tabJournal Entry" USING btree (voucher_type);


--
-- TOC entry 7079 (class 1259 OID 20951)
-- Name: idx_18090_account; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18090_account ON public."tabJournal Entry Account" USING btree (account);


--
-- TOC entry 7080 (class 1259 OID 20942)
-- Name: idx_18090_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18090_parent ON public."tabJournal Entry Account" USING btree (parent);


--
-- TOC entry 7083 (class 1259 OID 20948)
-- Name: idx_18105_kanban_board_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_18105_kanban_board_name ON public."tabKanban Board" USING btree (kanban_board_name);


--
-- TOC entry 7084 (class 1259 OID 20958)
-- Name: idx_18105_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18105_parent ON public."tabKanban Board" USING btree (parent);


--
-- TOC entry 7087 (class 1259 OID 20972)
-- Name: idx_18113_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18113_parent ON public."tabKanban Board Column" USING btree (parent);


--
-- TOC entry 7090 (class 1259 OID 20977)
-- Name: idx_18123_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18123_parent ON public."tabLanded Cost Item" USING btree (parent);


--
-- TOC entry 7093 (class 1259 OID 20979)
-- Name: idx_18135_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18135_parent ON public."tabLanded Cost Purchase Receipt" USING btree (parent);


--
-- TOC entry 7096 (class 1259 OID 20954)
-- Name: idx_18144_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18144_parent ON public."tabLanded Cost Taxes and Charges" USING btree (parent);


--
-- TOC entry 7099 (class 1259 OID 20957)
-- Name: idx_18153_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18153_parent ON public."tabLanded Cost Voucher" USING btree (parent);


--
-- TOC entry 7102 (class 1259 OID 20968)
-- Name: idx_18162_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18162_parent ON public.tablanguage USING btree (parent);


--
-- TOC entry 7105 (class 1259 OID 20960)
-- Name: idx_18170_email_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18170_email_id ON public.tablead USING btree (email_id);


--
-- TOC entry 7106 (class 1259 OID 20984)
-- Name: idx_18170_lead_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18170_lead_name ON public.tablead USING btree (lead_name);


--
-- TOC entry 7107 (class 1259 OID 20974)
-- Name: idx_18170_lead_owner; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18170_lead_owner ON public.tablead USING btree (lead_owner);


--
-- TOC entry 7108 (class 1259 OID 20988)
-- Name: idx_18170_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18170_parent ON public.tablead USING btree (parent);


--
-- TOC entry 7111 (class 1259 OID 20967)
-- Name: idx_18170_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18170_status ON public.tablead USING btree (status);


--
-- TOC entry 7112 (class 1259 OID 20987)
-- Name: idx_18181_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18181_parent ON public."tabLead Source" USING btree (parent);


--
-- TOC entry 7115 (class 1259 OID 20981)
-- Name: idx_18189_employee; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18189_employee ON public."tabLeave Allocation" USING btree (employee);


--
-- TOC entry 7116 (class 1259 OID 20978)
-- Name: idx_18189_employee_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18189_employee_name ON public."tabLeave Allocation" USING btree (employee_name);


--
-- TOC entry 7117 (class 1259 OID 20994)
-- Name: idx_18189_leave_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18189_leave_type ON public."tabLeave Allocation" USING btree (leave_type);


--
-- TOC entry 7118 (class 1259 OID 20971)
-- Name: idx_18189_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18189_parent ON public."tabLeave Allocation" USING btree (parent);


--
-- TOC entry 7121 (class 1259 OID 20983)
-- Name: idx_18201_employee; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18201_employee ON public."tabLeave Application" USING btree (employee);


--
-- TOC entry 7122 (class 1259 OID 21000)
-- Name: idx_18201_from_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18201_from_date ON public."tabLeave Application" USING btree (from_date);


--
-- TOC entry 7123 (class 1259 OID 20985)
-- Name: idx_18201_leave_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18201_leave_type ON public."tabLeave Application" USING btree (leave_type);


--
-- TOC entry 7124 (class 1259 OID 20976)
-- Name: idx_18201_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18201_parent ON public."tabLeave Application" USING btree (parent);


--
-- TOC entry 7127 (class 1259 OID 20980)
-- Name: idx_18201_to_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18201_to_date ON public."tabLeave Application" USING btree (to_date);


--
-- TOC entry 7128 (class 1259 OID 20991)
-- Name: idx_18214_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18214_parent ON public."tabLeave Block List" USING btree (parent);


--
-- TOC entry 7131 (class 1259 OID 21005)
-- Name: idx_18223_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18223_parent ON public."tabLeave Block List Allow" USING btree (parent);


--
-- TOC entry 7134 (class 1259 OID 21007)
-- Name: idx_18231_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18231_parent ON public."tabLeave Block List Date" USING btree (parent);


--
-- TOC entry 7137 (class 1259 OID 21013)
-- Name: idx_18239_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18239_parent ON public."tabLeave Type" USING btree (parent);


--
-- TOC entry 7140 (class 1259 OID 20989)
-- Name: idx_18252_is_default; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18252_is_default ON public."tabLetter Head" USING btree (is_default);


--
-- TOC entry 7141 (class 1259 OID 21006)
-- Name: idx_18252_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18252_parent ON public."tabLetter Head" USING btree (parent);


--
-- TOC entry 7144 (class 1259 OID 21002)
-- Name: idx_18262_customer; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18262_customer ON public."tabMaintenance Schedule" USING btree (customer);


--
-- TOC entry 7145 (class 1259 OID 20997)
-- Name: idx_18262_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18262_parent ON public."tabMaintenance Schedule" USING btree (parent);


--
-- TOC entry 7148 (class 1259 OID 20992)
-- Name: idx_18271_item_code; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18271_item_code ON public."tabMaintenance Schedule Detail" USING btree (item_code);


--
-- TOC entry 7149 (class 1259 OID 21018)
-- Name: idx_18271_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18271_parent ON public."tabMaintenance Schedule Detail" USING btree (parent);


--
-- TOC entry 7152 (class 1259 OID 21023)
-- Name: idx_18271_scheduled_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18271_scheduled_date ON public."tabMaintenance Schedule Detail" USING btree (scheduled_date);


--
-- TOC entry 7153 (class 1259 OID 21009)
-- Name: idx_18279_end_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18279_end_date ON public."tabMaintenance Schedule Item" USING btree (end_date);


--
-- TOC entry 7154 (class 1259 OID 21001)
-- Name: idx_18279_item_code; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18279_item_code ON public."tabMaintenance Schedule Item" USING btree (item_code);


--
-- TOC entry 7155 (class 1259 OID 21016)
-- Name: idx_18279_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18279_parent ON public."tabMaintenance Schedule Item" USING btree (parent);


--
-- TOC entry 7158 (class 1259 OID 21012)
-- Name: idx_18279_sales_order; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18279_sales_order ON public."tabMaintenance Schedule Item" USING btree (sales_order);


--
-- TOC entry 7159 (class 1259 OID 21010)
-- Name: idx_18279_start_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18279_start_date ON public."tabMaintenance Schedule Item" USING btree (start_date);


--
-- TOC entry 7160 (class 1259 OID 21028)
-- Name: idx_18288_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18288_parent ON public."tabMaintenance Visit" USING btree (parent);


--
-- TOC entry 7163 (class 1259 OID 21027)
-- Name: idx_18298_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18298_parent ON public."tabMaintenance Visit Purpose" USING btree (parent);


--
-- TOC entry 7166 (class 1259 OID 21035)
-- Name: idx_18306_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18306_parent ON public.tabmanufacturer USING btree (parent);


--
-- TOC entry 7169 (class 1259 OID 21011)
-- Name: idx_18314_company; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18314_company ON public."tabMaterial Request" USING btree (company);


--
-- TOC entry 7170 (class 1259 OID 21030)
-- Name: idx_18314_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18314_parent ON public."tabMaterial Request" USING btree (parent);


--
-- TOC entry 7173 (class 1259 OID 21024)
-- Name: idx_18314_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18314_status ON public."tabMaterial Request" USING btree (status);


--
-- TOC entry 7174 (class 1259 OID 21020)
-- Name: idx_18314_transaction_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18314_transaction_date ON public."tabMaterial Request" USING btree (transaction_date);


--
-- TOC entry 7175 (class 1259 OID 21038)
-- Name: idx_18324_item_code; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18324_item_code ON public."tabMaterial Request Item" USING btree (item_code);


--
-- TOC entry 7176 (class 1259 OID 21015)
-- Name: idx_18324_item_group; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18324_item_group ON public."tabMaterial Request Item" USING btree (item_group);


--
-- TOC entry 7177 (class 1259 OID 21039)
-- Name: idx_18324_item_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18324_item_name ON public."tabMaterial Request Item" USING btree (item_name);


--
-- TOC entry 7178 (class 1259 OID 21029)
-- Name: idx_18324_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18324_parent ON public."tabMaterial Request Item" USING btree (parent);


--
-- TOC entry 7181 (class 1259 OID 21031)
-- Name: idx_18338_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18338_parent ON public."tabMode of Payment" USING btree (parent);


--
-- TOC entry 7184 (class 1259 OID 21040)
-- Name: idx_18346_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18346_parent ON public."tabMode of Payment Account" USING btree (parent);


--
-- TOC entry 7187 (class 1259 OID 21037)
-- Name: idx_18354_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18354_parent ON public."tabModule Def" USING btree (parent);


--
-- TOC entry 7190 (class 1259 OID 21050)
-- Name: idx_18362_fiscal_year; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18362_fiscal_year ON public."tabMonthly Distribution" USING btree (fiscal_year);


--
-- TOC entry 7191 (class 1259 OID 21026)
-- Name: idx_18362_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18362_parent ON public."tabMonthly Distribution" USING btree (parent);


--
-- TOC entry 7194 (class 1259 OID 21041)
-- Name: idx_18370_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18370_parent ON public."tabMonthly Distribution Percentage" USING btree (parent);


--
-- TOC entry 7197 (class 1259 OID 21042)
-- Name: idx_18379_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18379_parent ON public.tabnewsletter USING btree (parent);


--
-- TOC entry 7200 (class 1259 OID 21052)
-- Name: idx_18389_expire_notification_on; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18389_expire_notification_on ON public.tabnote USING btree (expire_notification_on);


--
-- TOC entry 7201 (class 1259 OID 21033)
-- Name: idx_18389_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18389_parent ON public.tabnote USING btree (parent);


--
-- TOC entry 7204 (class 1259 OID 21043)
-- Name: idx_18399_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18399_parent ON public."tabNote Seen By" USING btree (parent);


--
-- TOC entry 7207 (class 1259 OID 21036)
-- Name: idx_18407_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18407_parent ON public."tabOAuth Authorization Code" USING btree (parent);


--
-- TOC entry 7210 (class 1259 OID 21051)
-- Name: idx_18415_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18415_parent ON public."tabOAuth Bearer Token" USING btree (parent);


--
-- TOC entry 7213 (class 1259 OID 21053)
-- Name: idx_18424_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18424_parent ON public."tabOAuth Client" USING btree (parent);


--
-- TOC entry 7216 (class 1259 OID 21063)
-- Name: idx_18434_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18434_parent ON public."tabOffer Letter" USING btree (parent);


--
-- TOC entry 7219 (class 1259 OID 21058)
-- Name: idx_18442_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18442_parent ON public."tabOffer Letter Term" USING btree (parent);


--
-- TOC entry 7222 (class 1259 OID 21072)
-- Name: idx_18450_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18450_parent ON public."tabOffer Term" USING btree (parent);


--
-- TOC entry 7225 (class 1259 OID 21071)
-- Name: idx_18458_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18458_parent ON public.taboperation USING btree (parent);


--
-- TOC entry 7228 (class 1259 OID 21082)
-- Name: idx_18466_company; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18466_company ON public.tabopportunity USING btree (company);


--
-- TOC entry 7229 (class 1259 OID 21064)
-- Name: idx_18466_customer_group; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18466_customer_group ON public.tabopportunity USING btree (customer_group);


--
-- TOC entry 7230 (class 1259 OID 21059)
-- Name: idx_18466_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18466_parent ON public.tabopportunity USING btree (parent);


--
-- TOC entry 7233 (class 1259 OID 21055)
-- Name: idx_18466_territory; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18466_territory ON public.tabopportunity USING btree (territory);


--
-- TOC entry 7234 (class 1259 OID 21069)
-- Name: idx_18478_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18478_parent ON public."tabOpportunity Item" USING btree (parent);


--
-- TOC entry 7237 (class 1259 OID 21081)
-- Name: idx_18488_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18488_parent ON public."tabPacked Item" USING btree (parent);


--
-- TOC entry 7240 (class 1259 OID 21083)
-- Name: idx_18500_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18500_parent ON public."tabPacking Slip" USING btree (parent);


--
-- TOC entry 7243 (class 1259 OID 21092)
-- Name: idx_18510_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18510_parent ON public."tabPacking Slip Item" USING btree (parent);


--
-- TOC entry 7246 (class 1259 OID 21068)
-- Name: idx_18521_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18521_parent ON public.tabpage USING btree (parent);


--
-- TOC entry 7249 (class 1259 OID 21067)
-- Name: idx_18521_standard; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18521_standard ON public.tabpage USING btree (standard);


--
-- TOC entry 7250 (class 1259 OID 21079)
-- Name: idx_18529_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18529_parent ON public."tabPage Role" USING btree (parent);


--
-- TOC entry 7253 (class 1259 OID 21093)
-- Name: idx_18537_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18537_parent ON public."tabParty Account" USING btree (parent);


--
-- TOC entry 7256 (class 1259 OID 21094)
-- Name: idx_18545_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18545_parent ON public."tabPatch Log" USING btree (parent);


--
-- TOC entry 7259 (class 1259 OID 21103)
-- Name: idx_18553_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18553_parent ON public."tabPayment Entry" USING btree (parent);


--
-- TOC entry 7262 (class 1259 OID 21080)
-- Name: idx_18575_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18575_parent ON public."tabPayment Entry Deduction" USING btree (parent);


--
-- TOC entry 7265 (class 1259 OID 21078)
-- Name: idx_18584_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18584_parent ON public."tabPayment Entry Reference" USING btree (parent);


--
-- TOC entry 7268 (class 1259 OID 21089)
-- Name: idx_18596_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18596_parent ON public."tabPayment Gateway" USING btree (parent);


--
-- TOC entry 7271 (class 1259 OID 21074)
-- Name: idx_18604_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18604_parent ON public."tabPayment Gateway Account" USING btree (parent);


--
-- TOC entry 7274 (class 1259 OID 21096)
-- Name: idx_18613_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18613_parent ON public."tabPayment Reconciliation Invoice" USING btree (parent);


--
-- TOC entry 7277 (class 1259 OID 21095)
-- Name: idx_18623_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18623_parent ON public."tabPayment Reconciliation Payment" USING btree (parent);


--
-- TOC entry 7280 (class 1259 OID 21107)
-- Name: idx_18633_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18633_parent ON public."tabPayment Request" USING btree (parent);


--
-- TOC entry 7283 (class 1259 OID 21104)
-- Name: idx_18645_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18645_parent ON public."tabPeriod Closing Voucher" USING btree (parent);


--
-- TOC entry 7286 (class 1259 OID 21114)
-- Name: idx_18653_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18653_parent ON public."tabPortal Menu Item" USING btree (parent);


--
-- TOC entry 7289 (class 1259 OID 21115)
-- Name: idx_18662_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18662_parent ON public."tabPOS Customer Group" USING btree (parent);


--
-- TOC entry 7292 (class 1259 OID 21127)
-- Name: idx_18670_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18670_parent ON public."tabPOS Item Group" USING btree (parent);


--
-- TOC entry 7295 (class 1259 OID 21102)
-- Name: idx_18678_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18678_parent ON public."tabPOS Profile" USING btree (parent);


--
-- TOC entry 7298 (class 1259 OID 21100)
-- Name: idx_18693_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18693_parent ON public."tabPrice List" USING btree (parent);


--
-- TOC entry 7301 (class 1259 OID 21110)
-- Name: idx_18704_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18704_parent ON public."tabPrice List Country" USING btree (parent);


--
-- TOC entry 7304 (class 1259 OID 21097)
-- Name: idx_18712_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18712_parent ON public."tabPricing Rule" USING btree (parent);


--
-- TOC entry 7307 (class 1259 OID 21121)
-- Name: idx_18731_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18731_parent ON public."tabPrint Format" USING btree (parent);


--
-- TOC entry 7310 (class 1259 OID 21118)
-- Name: idx_18731_standard; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18731_standard ON public."tabPrint Format" USING btree (standard);


--
-- TOC entry 7311 (class 1259 OID 21112)
-- Name: idx_18748_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18748_parent ON public."tabPrint Heading" USING btree (parent);


--
-- TOC entry 7314 (class 1259 OID 21111)
-- Name: idx_18756_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18756_parent ON public."tabProduct Bundle" USING btree (parent);


--
-- TOC entry 7317 (class 1259 OID 21119)
-- Name: idx_18764_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18764_parent ON public."tabProduct Bundle Item" USING btree (parent);


--
-- TOC entry 7320 (class 1259 OID 21108)
-- Name: idx_18774_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18774_parent ON public."tabProduction Order" USING btree (parent);


--
-- TOC entry 7323 (class 1259 OID 21130)
-- Name: idx_18774_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18774_status ON public."tabProduction Order" USING btree (status);


--
-- TOC entry 7324 (class 1259 OID 21150)
-- Name: idx_18792_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18792_parent ON public."tabProduction Order Item" USING btree (parent);


--
-- TOC entry 7327 (class 1259 OID 21125)
-- Name: idx_18802_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18802_parent ON public."tabProduction Order Operation" USING btree (parent);


--
-- TOC entry 7330 (class 1259 OID 21122)
-- Name: idx_18817_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18817_parent ON public."tabProduction Plan Item" USING btree (parent);


--
-- TOC entry 7333 (class 1259 OID 21133)
-- Name: idx_18827_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18827_parent ON public."tabProduction Plan Material Request" USING btree (parent);


--
-- TOC entry 7336 (class 1259 OID 21117)
-- Name: idx_18835_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18835_parent ON public."tabProduction Plan Sales Order" USING btree (parent);


--
-- TOC entry 7339 (class 1259 OID 21140)
-- Name: idx_18844_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18844_parent ON public.tabprogram USING btree (parent);


--
-- TOC entry 7342 (class 1259 OID 21135)
-- Name: idx_18852_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18852_parent ON public."tabProgram Course" USING btree (parent);


--
-- TOC entry 7345 (class 1259 OID 21152)
-- Name: idx_18861_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18861_parent ON public."tabProgram Enrollment" USING btree (parent);


--
-- TOC entry 7348 (class 1259 OID 21148)
-- Name: idx_18869_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18869_parent ON public."tabProgram Enrollment Fee" USING btree (parent);


--
-- TOC entry 7351 (class 1259 OID 21158)
-- Name: idx_18878_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18878_parent ON public."tabProgram Enrollment Tool Student" USING btree (parent);


--
-- TOC entry 7354 (class 1259 OID 21154)
-- Name: idx_18886_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18886_parent ON public."tabProgram Fee" USING btree (parent);


--
-- TOC entry 7357 (class 1259 OID 21172)
-- Name: idx_18895_customer; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18895_customer ON public.tabproject USING btree (customer);


--
-- TOC entry 7358 (class 1259 OID 21145)
-- Name: idx_18895_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18895_parent ON public.tabproject USING btree (parent);


--
-- TOC entry 7361 (class 1259 OID 21165)
-- Name: idx_18895_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18895_status ON public.tabproject USING btree (status);


--
-- TOC entry 7362 (class 1259 OID 21144)
-- Name: idx_18914_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18914_parent ON public."tabProject Task" USING btree (parent);


--
-- TOC entry 7365 (class 1259 OID 21155)
-- Name: idx_18924_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18924_parent ON public."tabProject User" USING btree (parent);


--
-- TOC entry 7368 (class 1259 OID 21141)
-- Name: idx_18924_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18924_user ON public."tabProject User" USING btree ("user");


--
-- TOC entry 7369 (class 1259 OID 21163)
-- Name: idx_18933_doc_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18933_doc_type ON public."tabProperty Setter" USING btree (doc_type);


--
-- TOC entry 7370 (class 1259 OID 21162)
-- Name: idx_18933_field_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18933_field_name ON public."tabProperty Setter" USING btree (field_name);


--
-- TOC entry 7371 (class 1259 OID 21181)
-- Name: idx_18933_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18933_parent ON public."tabProperty Setter" USING btree (parent);


--
-- TOC entry 7374 (class 1259 OID 21161)
-- Name: idx_18933_property; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18933_property ON public."tabProperty Setter" USING btree (property);


--
-- TOC entry 7375 (class 1259 OID 21173)
-- Name: idx_18941_credit_to; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18941_credit_to ON public."tabPurchase Invoice" USING btree (credit_to);


--
-- TOC entry 7376 (class 1259 OID 21156)
-- Name: idx_18941_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18941_parent ON public."tabPurchase Invoice" USING btree (parent);


--
-- TOC entry 7377 (class 1259 OID 21169)
-- Name: idx_18941_posting_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18941_posting_date ON public."tabPurchase Invoice" USING btree (posting_date);


--
-- TOC entry 7380 (class 1259 OID 21183)
-- Name: idx_18941_supplier; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18941_supplier ON public."tabPurchase Invoice" USING btree (supplier);


--
-- TOC entry 7381 (class 1259 OID 21151)
-- Name: idx_18985_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18985_parent ON public."tabPurchase Invoice Advance" USING btree (parent);


--
-- TOC entry 7384 (class 1259 OID 21175)
-- Name: idx_18995_item_code; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18995_item_code ON public."tabPurchase Invoice Item" USING btree (item_code);


--
-- TOC entry 7385 (class 1259 OID 21193)
-- Name: idx_18995_item_group; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18995_item_group ON public."tabPurchase Invoice Item" USING btree (item_group);


--
-- TOC entry 7386 (class 1259 OID 21168)
-- Name: idx_18995_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18995_parent ON public."tabPurchase Invoice Item" USING btree (parent);


--
-- TOC entry 7387 (class 1259 OID 21170)
-- Name: idx_18995_po_detail; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18995_po_detail ON public."tabPurchase Invoice Item" USING btree (po_detail);


--
-- TOC entry 7388 (class 1259 OID 21166)
-- Name: idx_18995_pr_detail; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18995_pr_detail ON public."tabPurchase Invoice Item" USING btree (pr_detail);


--
-- TOC entry 7391 (class 1259 OID 21180)
-- Name: idx_18995_purchase_order; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18995_purchase_order ON public."tabPurchase Invoice Item" USING btree (purchase_order);


--
-- TOC entry 7392 (class 1259 OID 21178)
-- Name: idx_18995_purchase_receipt; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_18995_purchase_receipt ON public."tabPurchase Invoice Item" USING btree (purchase_receipt);


--
-- TOC entry 7393 (class 1259 OID 21194)
-- Name: idx_19024_company; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19024_company ON public."tabPurchase Order" USING btree (company);


--
-- TOC entry 7394 (class 1259 OID 21164)
-- Name: idx_19024_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19024_parent ON public."tabPurchase Order" USING btree (parent);


--
-- TOC entry 7397 (class 1259 OID 21185)
-- Name: idx_19024_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19024_status ON public."tabPurchase Order" USING btree (status);


--
-- TOC entry 7398 (class 1259 OID 21206)
-- Name: idx_19024_supplier; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19024_supplier ON public."tabPurchase Order" USING btree (supplier);


--
-- TOC entry 7399 (class 1259 OID 21179)
-- Name: idx_19024_transaction_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19024_transaction_date ON public."tabPurchase Order" USING btree (transaction_date);


--
-- TOC entry 7400 (class 1259 OID 21182)
-- Name: idx_19063_expected_delivery_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19063_expected_delivery_date ON public."tabPurchase Order Item" USING btree (expected_delivery_date);


--
-- TOC entry 7401 (class 1259 OID 21196)
-- Name: idx_19063_item_code; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19063_item_code ON public."tabPurchase Order Item" USING btree (item_code);


--
-- TOC entry 7402 (class 1259 OID 21174)
-- Name: idx_19063_item_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19063_item_name ON public."tabPurchase Order Item" USING btree (item_name);


--
-- TOC entry 7403 (class 1259 OID 21191)
-- Name: idx_19063_material_request; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19063_material_request ON public."tabPurchase Order Item" USING btree (material_request);


--
-- TOC entry 7404 (class 1259 OID 21189)
-- Name: idx_19063_material_request_item; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19063_material_request_item ON public."tabPurchase Order Item" USING btree (material_request_item);


--
-- TOC entry 7405 (class 1259 OID 21204)
-- Name: idx_19063_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19063_parent ON public."tabPurchase Order Item" USING btree (parent);


--
-- TOC entry 7408 (class 1259 OID 21195)
-- Name: idx_19063_sales_order; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19063_sales_order ON public."tabPurchase Order Item" USING btree (sales_order);


--
-- TOC entry 7409 (class 1259 OID 21197)
-- Name: idx_19063_sales_order_item; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19063_sales_order_item ON public."tabPurchase Order Item" USING btree (sales_order_item);


--
-- TOC entry 7410 (class 1259 OID 21215)
-- Name: idx_19063_schedule_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19063_schedule_date ON public."tabPurchase Order Item" USING btree (schedule_date);


--
-- TOC entry 7411 (class 1259 OID 21190)
-- Name: idx_19090_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19090_parent ON public."tabPurchase Order Item Supplied" USING btree (parent);


--
-- TOC entry 7414 (class 1259 OID 21205)
-- Name: idx_19102_company; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19102_company ON public."tabPurchase Receipt" USING btree (company);


--
-- TOC entry 7415 (class 1259 OID 21184)
-- Name: idx_19102_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19102_parent ON public."tabPurchase Receipt" USING btree (parent);


--
-- TOC entry 7416 (class 1259 OID 21202)
-- Name: idx_19102_posting_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19102_posting_date ON public."tabPurchase Receipt" USING btree (posting_date);


--
-- TOC entry 7419 (class 1259 OID 21216)
-- Name: idx_19102_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19102_status ON public."tabPurchase Receipt" USING btree (status);


--
-- TOC entry 7420 (class 1259 OID 21187)
-- Name: idx_19102_supplier; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19102_supplier ON public."tabPurchase Receipt" USING btree (supplier);


--
-- TOC entry 7421 (class 1259 OID 21207)
-- Name: idx_19135_item_code; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19135_item_code ON public."tabPurchase Receipt Item" USING btree (item_code);


--
-- TOC entry 7422 (class 1259 OID 21210)
-- Name: idx_19135_item_group; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19135_item_group ON public."tabPurchase Receipt Item" USING btree (item_group);


--
-- TOC entry 7423 (class 1259 OID 21228)
-- Name: idx_19135_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19135_parent ON public."tabPurchase Receipt Item" USING btree (parent);


--
-- TOC entry 7426 (class 1259 OID 21201)
-- Name: idx_19135_purchase_order; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19135_purchase_order ON public."tabPurchase Receipt Item" USING btree (purchase_order);


--
-- TOC entry 7427 (class 1259 OID 21218)
-- Name: idx_19135_purchase_order_item; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19135_purchase_order_item ON public."tabPurchase Receipt Item" USING btree (purchase_order_item);


--
-- TOC entry 7428 (class 1259 OID 21199)
-- Name: idx_19165_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19165_parent ON public."tabPurchase Receipt Item Supplied" USING btree (parent);


--
-- TOC entry 7431 (class 1259 OID 21211)
-- Name: idx_19179_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19179_parent ON public."tabPurchase Taxes and Charges" USING btree (parent);


--
-- TOC entry 7434 (class 1259 OID 21198)
-- Name: idx_19197_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19197_parent ON public."tabPurchase Taxes and Charges Template" USING btree (parent);


--
-- TOC entry 7437 (class 1259 OID 21220)
-- Name: idx_19207_item_code; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19207_item_code ON public."tabQuality Inspection" USING btree (item_code);


--
-- TOC entry 7438 (class 1259 OID 21239)
-- Name: idx_19207_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19207_parent ON public."tabQuality Inspection" USING btree (parent);


--
-- TOC entry 7441 (class 1259 OID 21213)
-- Name: idx_19207_report_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19207_report_date ON public."tabQuality Inspection" USING btree (report_date);


--
-- TOC entry 7442 (class 1259 OID 21227)
-- Name: idx_19217_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19217_parent ON public."tabQuality Inspection Reading" USING btree (parent);


--
-- TOC entry 7445 (class 1259 OID 21223)
-- Name: idx_19226_customer; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19226_customer ON public.tabquotation USING btree (customer);


--
-- TOC entry 7446 (class 1259 OID 21222)
-- Name: idx_19226_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19226_parent ON public.tabquotation USING btree (parent);


--
-- TOC entry 7449 (class 1259 OID 21208)
-- Name: idx_19226_transaction_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19226_transaction_date ON public.tabquotation USING btree (transaction_date);


--
-- TOC entry 7450 (class 1259 OID 21231)
-- Name: idx_19255_brand; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19255_brand ON public."tabQuotation Item" USING btree (brand);


--
-- TOC entry 7451 (class 1259 OID 21230)
-- Name: idx_19255_item_code; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19255_item_code ON public."tabQuotation Item" USING btree (item_code);


--
-- TOC entry 7452 (class 1259 OID 21251)
-- Name: idx_19255_item_group; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19255_item_group ON public."tabQuotation Item" USING btree (item_group);


--
-- TOC entry 7453 (class 1259 OID 21224)
-- Name: idx_19255_item_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19255_item_name ON public."tabQuotation Item" USING btree (item_name);


--
-- TOC entry 7454 (class 1259 OID 21225)
-- Name: idx_19255_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19255_parent ON public."tabQuotation Item" USING btree (parent);


--
-- TOC entry 7457 (class 1259 OID 21217)
-- Name: idx_19280_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19280_parent ON public."tabQuotation Lost Reason" USING btree (parent);


--
-- TOC entry 7460 (class 1259 OID 21233)
-- Name: idx_19288_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19288_parent ON public.tabreport USING btree (parent);


--
-- TOC entry 7463 (class 1259 OID 21221)
-- Name: idx_19299_company; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19299_company ON public."tabRequest for Quotation" USING btree (company);


--
-- TOC entry 7464 (class 1259 OID 21241)
-- Name: idx_19299_fiscal_year; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19299_fiscal_year ON public."tabRequest for Quotation" USING btree (fiscal_year);


--
-- TOC entry 7465 (class 1259 OID 21243)
-- Name: idx_19299_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19299_parent ON public."tabRequest for Quotation" USING btree (parent);


--
-- TOC entry 7468 (class 1259 OID 21236)
-- Name: idx_19299_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19299_status ON public."tabRequest for Quotation" USING btree (status);


--
-- TOC entry 7469 (class 1259 OID 21235)
-- Name: idx_19299_transaction_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19299_transaction_date ON public."tabRequest for Quotation" USING btree (transaction_date);


--
-- TOC entry 7470 (class 1259 OID 21248)
-- Name: idx_19307_item_code; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19307_item_code ON public."tabRequest for Quotation Item" USING btree (item_code);


--
-- TOC entry 7471 (class 1259 OID 21229)
-- Name: idx_19307_item_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19307_item_name ON public."tabRequest for Quotation Item" USING btree (item_name);


--
-- TOC entry 7472 (class 1259 OID 21247)
-- Name: idx_19307_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19307_parent ON public."tabRequest for Quotation Item" USING btree (parent);


--
-- TOC entry 7475 (class 1259 OID 21262)
-- Name: idx_19317_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19317_parent ON public."tabRequest for Quotation Supplier" USING btree (parent);


--
-- TOC entry 7478 (class 1259 OID 21253)
-- Name: idx_19326_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19326_parent ON public.tabrole USING btree (parent);


--
-- TOC entry 7481 (class 1259 OID 21271)
-- Name: idx_19336_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19336_parent ON public.tabroom USING btree (parent);


--
-- TOC entry 7484 (class 1259 OID 21244)
-- Name: idx_19344_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19344_parent ON public."tabSalary Component" USING btree (parent);


--
-- TOC entry 7487 (class 1259 OID 21240)
-- Name: idx_19352_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19352_parent ON public."tabSalary Component Account" USING btree (parent);


--
-- TOC entry 7490 (class 1259 OID 21255)
-- Name: idx_19360_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19360_parent ON public."tabSalary Detail" USING btree (parent);


--
-- TOC entry 7493 (class 1259 OID 21242)
-- Name: idx_19372_employee; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19372_employee ON public."tabSalary Slip" USING btree (employee);


--
-- TOC entry 7494 (class 1259 OID 21263)
-- Name: idx_19372_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19372_parent ON public."tabSalary Slip" USING btree (parent);


--
-- TOC entry 7497 (class 1259 OID 21285)
-- Name: idx_19392_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19392_parent ON public."tabSalary Slip Timesheet" USING btree (parent);


--
-- TOC entry 7500 (class 1259 OID 21256)
-- Name: idx_19401_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19401_parent ON public."tabSalary Structure" USING btree (parent);


--
-- TOC entry 7503 (class 1259 OID 21250)
-- Name: idx_19417_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19417_parent ON public."tabSalary Structure Employee" USING btree (parent);


--
-- TOC entry 7506 (class 1259 OID 21265)
-- Name: idx_19427_customer; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19427_customer ON public."tabSales Invoice" USING btree (customer);


--
-- TOC entry 7507 (class 1259 OID 21282)
-- Name: idx_19427_debit_to; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19427_debit_to ON public."tabSales Invoice" USING btree (debit_to);


--
-- TOC entry 7508 (class 1259 OID 21254)
-- Name: idx_19427_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19427_parent ON public."tabSales Invoice" USING btree (parent);


--
-- TOC entry 7509 (class 1259 OID 21274)
-- Name: idx_19427_posting_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19427_posting_date ON public."tabSales Invoice" USING btree (posting_date);


--
-- TOC entry 7512 (class 1259 OID 21293)
-- Name: idx_19474_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19474_parent ON public."tabSales Invoice Advance" USING btree (parent);


--
-- TOC entry 7515 (class 1259 OID 21268)
-- Name: idx_19484_delivery_note; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19484_delivery_note ON public."tabSales Invoice Item" USING btree (delivery_note);


--
-- TOC entry 7516 (class 1259 OID 21281)
-- Name: idx_19484_dn_detail; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19484_dn_detail ON public."tabSales Invoice Item" USING btree (dn_detail);


--
-- TOC entry 7517 (class 1259 OID 21260)
-- Name: idx_19484_item_code; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19484_item_code ON public."tabSales Invoice Item" USING btree (item_code);


--
-- TOC entry 7518 (class 1259 OID 21278)
-- Name: idx_19484_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19484_parent ON public."tabSales Invoice Item" USING btree (parent);


--
-- TOC entry 7521 (class 1259 OID 21296)
-- Name: idx_19484_sales_order; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19484_sales_order ON public."tabSales Invoice Item" USING btree (sales_order);


--
-- TOC entry 7522 (class 1259 OID 21266)
-- Name: idx_19484_so_detail; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19484_so_detail ON public."tabSales Invoice Item" USING btree (so_detail);


--
-- TOC entry 7523 (class 1259 OID 21284)
-- Name: idx_19512_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19512_parent ON public."tabSales Invoice Payment" USING btree (parent);


--
-- TOC entry 7526 (class 1259 OID 21304)
-- Name: idx_19522_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19522_parent ON public."tabSales Invoice Timesheet" USING btree (parent);


--
-- TOC entry 7529 (class 1259 OID 21279)
-- Name: idx_19532_company; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19532_company ON public."tabSales Order" USING btree (company);


--
-- TOC entry 7530 (class 1259 OID 21292)
-- Name: idx_19532_customer; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19532_customer ON public."tabSales Order" USING btree (customer);


--
-- TOC entry 7531 (class 1259 OID 21272)
-- Name: idx_19532_customer_group; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19532_customer_group ON public."tabSales Order" USING btree (customer_group);


--
-- TOC entry 7532 (class 1259 OID 21289)
-- Name: idx_19532_delivery_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19532_delivery_date ON public."tabSales Order" USING btree (delivery_date);


--
-- TOC entry 7533 (class 1259 OID 21288)
-- Name: idx_19532_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19532_parent ON public."tabSales Order" USING btree (parent);


--
-- TOC entry 7536 (class 1259 OID 21276)
-- Name: idx_19532_project; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19532_project ON public."tabSales Order" USING btree (project);


--
-- TOC entry 7537 (class 1259 OID 21294)
-- Name: idx_19532_sales_partner; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19532_sales_partner ON public."tabSales Order" USING btree (sales_partner);


--
-- TOC entry 7538 (class 1259 OID 21295)
-- Name: idx_19532_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19532_status ON public."tabSales Order" USING btree (status);


--
-- TOC entry 7539 (class 1259 OID 21314)
-- Name: idx_19532_territory; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19532_territory ON public."tabSales Order" USING btree (territory);


--
-- TOC entry 7540 (class 1259 OID 21290)
-- Name: idx_19532_transaction_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19532_transaction_date ON public."tabSales Order" USING btree (transaction_date);


--
-- TOC entry 7541 (class 1259 OID 21291)
-- Name: idx_19570_brand; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19570_brand ON public."tabSales Order Item" USING btree (brand);


--
-- TOC entry 7542 (class 1259 OID 21303)
-- Name: idx_19570_item_group; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19570_item_group ON public."tabSales Order Item" USING btree (item_group);


--
-- TOC entry 7543 (class 1259 OID 21283)
-- Name: idx_19570_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19570_parent ON public."tabSales Order Item" USING btree (parent);


--
-- TOC entry 7544 (class 1259 OID 21299)
-- Name: idx_19570_prevdoc_docname; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19570_prevdoc_docname ON public."tabSales Order Item" USING btree (prevdoc_docname);


--
-- TOC entry 7547 (class 1259 OID 21316)
-- Name: idx_19604_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19604_parent ON public."tabSales Partner" USING btree (parent);


--
-- TOC entry 7550 (class 1259 OID 21307)
-- Name: idx_19604_route; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_19604_route ON public."tabSales Partner" USING btree (route);


--
-- TOC entry 7551 (class 1259 OID 21306)
-- Name: idx_19614_lft; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19614_lft ON public."tabSales Person" USING btree (lft);


--
-- TOC entry 7552 (class 1259 OID 21325)
-- Name: idx_19614_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19614_parent ON public."tabSales Person" USING btree (parent);


--
-- TOC entry 7555 (class 1259 OID 21301)
-- Name: idx_19614_rgt; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19614_rgt ON public."tabSales Person" USING btree (rgt);


--
-- TOC entry 7556 (class 1259 OID 21315)
-- Name: idx_19626_account_head; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19626_account_head ON public."tabSales Taxes and Charges" USING btree (account_head);


--
-- TOC entry 7557 (class 1259 OID 21297)
-- Name: idx_19626_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19626_parent ON public."tabSales Taxes and Charges" USING btree (parent);


--
-- TOC entry 7558 (class 1259 OID 21309)
-- Name: idx_19626_parenttype; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19626_parenttype ON public."tabSales Taxes and Charges" USING btree (parenttype);


--
-- TOC entry 7561 (class 1259 OID 21328)
-- Name: idx_19642_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19642_parent ON public."tabSales Taxes and Charges Template" USING btree (parent);


--
-- TOC entry 7564 (class 1259 OID 21318)
-- Name: idx_19652_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19652_parent ON public."tabSales Team" USING btree (parent);


--
-- TOC entry 7567 (class 1259 OID 21332)
-- Name: idx_19652_sales_person; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19652_sales_person ON public."tabSales Team" USING btree (sales_person);


--
-- TOC entry 7568 (class 1259 OID 21312)
-- Name: idx_19663_company; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19663_company ON public."tabSerial No" USING btree (company);


--
-- TOC entry 7569 (class 1259 OID 21313)
-- Name: idx_19663_maintenance_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19663_maintenance_status ON public."tabSerial No" USING btree (maintenance_status);


--
-- TOC entry 7570 (class 1259 OID 21326)
-- Name: idx_19663_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19663_parent ON public."tabSerial No" USING btree (parent);


--
-- TOC entry 7573 (class 1259 OID 21322)
-- Name: idx_19663_serial_no; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19663_serial_no ON public."tabSerial No" USING btree (serial_no);


--
-- TOC entry 7574 (class 1259 OID 21319)
-- Name: idx_19663_warehouse; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19663_warehouse ON public."tabSerial No" USING btree (warehouse);


--
-- TOC entry 7575 (class 1259 OID 21340)
-- Name: idx_19677_sid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19677_sid ON public.tabsessions USING btree (sid);


--
-- TOC entry 7576 (class 1259 OID 21311)
-- Name: idx_19684_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19684_parent ON public."tabShipping Rule" USING btree (parent);


--
-- TOC entry 7579 (class 1259 OID 21331)
-- Name: idx_19695_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19695_parent ON public."tabShipping Rule Condition" USING btree (parent);


--
-- TOC entry 7582 (class 1259 OID 21323)
-- Name: idx_19706_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19706_parent ON public."tabShipping Rule Country" USING btree (parent);


--
-- TOC entry 7585 (class 1259 OID 21337)
-- Name: idx_19714_singles_doctype_field_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19714_singles_doctype_field_index ON public.tabsingles USING btree (doctype, field);


--
-- TOC entry 7586 (class 1259 OID 21320)
-- Name: idx_19720_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19720_parent ON public."tabSMS Log" USING btree (parent);


--
-- TOC entry 7589 (class 1259 OID 21327)
-- Name: idx_19730_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19730_parent ON public."tabSMS Parameter" USING btree (parent);


--
-- TOC entry 7592 (class 1259 OID 21321)
-- Name: idx_19738_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19738_parent ON public."tabStandard Reply" USING btree (parent);


--
-- TOC entry 7595 (class 1259 OID 21343)
-- Name: idx_19746_delivery_note_no; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19746_delivery_note_no ON public."tabStock Entry" USING btree (delivery_note_no);


--
-- TOC entry 7596 (class 1259 OID 21354)
-- Name: idx_19746_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19746_parent ON public."tabStock Entry" USING btree (parent);


--
-- TOC entry 7597 (class 1259 OID 21336)
-- Name: idx_19746_posting_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19746_posting_date ON public."tabStock Entry" USING btree (posting_date);


--
-- TOC entry 7600 (class 1259 OID 21347)
-- Name: idx_19746_production_order; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19746_production_order ON public."tabStock Entry" USING btree (production_order);


--
-- TOC entry 7601 (class 1259 OID 21330)
-- Name: idx_19746_purchase_receipt_no; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19746_purchase_receipt_no ON public."tabStock Entry" USING btree (purchase_receipt_no);


--
-- TOC entry 7602 (class 1259 OID 21344)
-- Name: idx_19764_actual_qty; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19764_actual_qty ON public."tabStock Entry Detail" USING btree (actual_qty);


--
-- TOC entry 7603 (class 1259 OID 21338)
-- Name: idx_19764_item_code; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19764_item_code ON public."tabStock Entry Detail" USING btree (item_code);


--
-- TOC entry 7604 (class 1259 OID 21366)
-- Name: idx_19764_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19764_parent ON public."tabStock Entry Detail" USING btree (parent);


--
-- TOC entry 7607 (class 1259 OID 21351)
-- Name: idx_19781_item_code; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19781_item_code ON public."tabStock Ledger Entry" USING btree (item_code);


--
-- TOC entry 7608 (class 1259 OID 21353)
-- Name: idx_19781_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19781_parent ON public."tabStock Ledger Entry" USING btree (parent);


--
-- TOC entry 7609 (class 1259 OID 21363)
-- Name: idx_19781_posting_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19781_posting_date ON public."tabStock Ledger Entry" USING btree (posting_date);


--
-- TOC entry 7610 (class 1259 OID 21346)
-- Name: idx_19781_posting_sort_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19781_posting_sort_index ON public."tabStock Ledger Entry" USING btree (posting_date, posting_time, name);


--
-- TOC entry 7613 (class 1259 OID 21360)
-- Name: idx_19781_warehouse; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19781_warehouse ON public."tabStock Ledger Entry" USING btree (warehouse);


--
-- TOC entry 7614 (class 1259 OID 21341)
-- Name: idx_19796_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19796_parent ON public."tabStock Reconciliation" USING btree (parent);


--
-- TOC entry 7617 (class 1259 OID 21349)
-- Name: idx_19805_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19805_parent ON public."tabStock Reconciliation Item" USING btree (parent);


--
-- TOC entry 7620 (class 1259 OID 21345)
-- Name: idx_19820_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19820_parent ON public.tabstudent USING btree (parent);


--
-- TOC entry 7623 (class 1259 OID 21362)
-- Name: idx_19820_student_email_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_19820_student_email_id ON public.tabstudent USING btree (student_email_id);


--
-- TOC entry 7624 (class 1259 OID 21375)
-- Name: idx_19828_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19828_parent ON public."tabStudent Admission" USING btree (parent);


--
-- TOC entry 7627 (class 1259 OID 21359)
-- Name: idx_19828_route; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_19828_route ON public."tabStudent Admission" USING btree (route);


--
-- TOC entry 7628 (class 1259 OID 21370)
-- Name: idx_19838_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19838_parent ON public."tabStudent Applicant" USING btree (parent);


--
-- TOC entry 7631 (class 1259 OID 21367)
-- Name: idx_19838_student_email_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_19838_student_email_id ON public."tabStudent Applicant" USING btree (student_email_id);


--
-- TOC entry 7632 (class 1259 OID 21361)
-- Name: idx_19847_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19847_parent ON public."tabStudent Attendance" USING btree (parent);


--
-- TOC entry 7635 (class 1259 OID 21356)
-- Name: idx_19856_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19856_parent ON public."tabStudent Batch" USING btree (parent);


--
-- TOC entry 7638 (class 1259 OID 21376)
-- Name: idx_19865_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19865_parent ON public."tabStudent Batch Instructor" USING btree (parent);


--
-- TOC entry 7641 (class 1259 OID 21369)
-- Name: idx_19873_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19873_parent ON public."tabStudent Batch Name" USING btree (parent);


--
-- TOC entry 7644 (class 1259 OID 21382)
-- Name: idx_19881_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19881_parent ON public."tabStudent Batch Student" USING btree (parent);


--
-- TOC entry 7647 (class 1259 OID 21380)
-- Name: idx_19890_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19890_parent ON public."tabStudent Category" USING btree (parent);


--
-- TOC entry 7650 (class 1259 OID 21395)
-- Name: idx_19898_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19898_parent ON public."tabStudent Group" USING btree (parent);


--
-- TOC entry 7653 (class 1259 OID 21389)
-- Name: idx_19907_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19907_parent ON public."tabStudent Group Creation Tool Course" USING btree (parent);


--
-- TOC entry 7656 (class 1259 OID 21398)
-- Name: idx_19916_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19916_parent ON public."tabStudent Group Student" USING btree (parent);


--
-- TOC entry 7659 (class 1259 OID 21381)
-- Name: idx_19925_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19925_parent ON public."tabStudent Guardian" USING btree (parent);


--
-- TOC entry 7662 (class 1259 OID 21368)
-- Name: idx_19933_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19933_parent ON public."tabStudent Leave Application" USING btree (parent);


--
-- TOC entry 7665 (class 1259 OID 21383)
-- Name: idx_19942_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19942_parent ON public."tabStudent Log" USING btree (parent);


--
-- TOC entry 7668 (class 1259 OID 21373)
-- Name: idx_19950_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19950_parent ON public."tabStudent Sibling" USING btree (parent);


--
-- TOC entry 7671 (class 1259 OID 21396)
-- Name: idx_19958_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19958_parent ON public."tabStudent Siblings" USING btree (parent);


--
-- TOC entry 7674 (class 1259 OID 21392)
-- Name: idx_19966_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19966_parent ON public.tabsupplier USING btree (parent);


--
-- TOC entry 7677 (class 1259 OID 21403)
-- Name: idx_19977_company; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19977_company ON public."tabSupplier Quotation" USING btree (company);


--
-- TOC entry 7678 (class 1259 OID 21378)
-- Name: idx_19977_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19977_parent ON public."tabSupplier Quotation" USING btree (parent);


--
-- TOC entry 7681 (class 1259 OID 21394)
-- Name: idx_19977_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19977_status ON public."tabSupplier Quotation" USING btree (status);


--
-- TOC entry 7682 (class 1259 OID 21418)
-- Name: idx_19977_supplier; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19977_supplier ON public."tabSupplier Quotation" USING btree (supplier);


--
-- TOC entry 7683 (class 1259 OID 21388)
-- Name: idx_19977_transaction_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_19977_transaction_date ON public."tabSupplier Quotation" USING btree (transaction_date);


--
-- TOC entry 7684 (class 1259 OID 21409)
-- Name: idx_20007_item_code; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_20007_item_code ON public."tabSupplier Quotation Item" USING btree (item_code);


--
-- TOC entry 7685 (class 1259 OID 21407)
-- Name: idx_20007_item_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_20007_item_name ON public."tabSupplier Quotation Item" USING btree (item_name);


--
-- TOC entry 7686 (class 1259 OID 21422)
-- Name: idx_20007_material_request; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_20007_material_request ON public."tabSupplier Quotation Item" USING btree (material_request);


--
-- TOC entry 7687 (class 1259 OID 21404)
-- Name: idx_20007_material_request_item; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_20007_material_request_item ON public."tabSupplier Quotation Item" USING btree (material_request_item);


--
-- TOC entry 7688 (class 1259 OID 21402)
-- Name: idx_20007_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_20007_parent ON public."tabSupplier Quotation Item" USING btree (parent);


--
-- TOC entry 7691 (class 1259 OID 21393)
-- Name: idx_20030_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_20030_parent ON public."tabSupplier Type" USING btree (parent);


--
-- TOC entry 7694 (class 1259 OID 21405)
-- Name: idx_20039_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_20039_parent ON public.tabtag USING btree (parent);


--
-- TOC entry 7697 (class 1259 OID 21400)
-- Name: idx_20047_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_20047_parent ON public."tabTag Category" USING btree (parent);


--
-- TOC entry 7700 (class 1259 OID 21417)
-- Name: idx_20055_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_20055_parent ON public."tabTag Doc Category" USING btree (parent);


--
-- TOC entry 7703 (class 1259 OID 21412)
-- Name: idx_20063_fiscal_year; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_20063_fiscal_year ON public."tabTarget Detail" USING btree (fiscal_year);


--
-- TOC entry 7704 (class 1259 OID 21413)
-- Name: idx_20063_item_group; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_20063_item_group ON public."tabTarget Detail" USING btree (item_group);


--
-- TOC entry 7705 (class 1259 OID 21426)
-- Name: idx_20063_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_20063_parent ON public."tabTarget Detail" USING btree (parent);


--
-- TOC entry 7708 (class 1259 OID 21420)
-- Name: idx_20063_target_amount; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_20063_target_amount ON public."tabTarget Detail" USING btree (target_amount);


--
-- TOC entry 7709 (class 1259 OID 21416)
-- Name: idx_20073_exp_end_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_20073_exp_end_date ON public.tabtask USING btree (exp_end_date);


--
-- TOC entry 7710 (class 1259 OID 21440)
-- Name: idx_20073_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_20073_parent ON public.tabtask USING btree (parent);


--
-- TOC entry 7713 (class 1259 OID 21432)
-- Name: idx_20073_priority; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_20073_priority ON public.tabtask USING btree (priority);


--
-- TOC entry 7714 (class 1259 OID 21428)
-- Name: idx_20088_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_20088_parent ON public."tabTask Depends On" USING btree (parent);


--
-- TOC entry 7717 (class 1259 OID 21425)
-- Name: idx_20096_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_20096_parent ON public."tabTax Rule" USING btree (parent);


--
-- TOC entry 7720 (class 1259 OID 21434)
-- Name: idx_20107_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_20107_parent ON public."tabTerms and Conditions" USING btree (parent);


--
-- TOC entry 7723 (class 1259 OID 21430)
-- Name: idx_20116_lft; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_20116_lft ON public.tabterritory USING btree (lft);


--
-- TOC entry 7724 (class 1259 OID 21427)
-- Name: idx_20116_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_20116_parent ON public.tabterritory USING btree (parent);


--
-- TOC entry 7727 (class 1259 OID 21419)
-- Name: idx_20116_rgt; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_20116_rgt ON public.tabterritory USING btree (rgt);


--
-- TOC entry 7728 (class 1259 OID 21441)
-- Name: idx_20116_territory_manager; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_20116_territory_manager ON public.tabterritory USING btree (territory_manager);


--
-- TOC entry 7729 (class 1259 OID 21439)
-- Name: idx_20127_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_20127_parent ON public.tabtimesheet USING btree (parent);


--
-- TOC entry 7732 (class 1259 OID 21436)
-- Name: idx_20143_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_20143_parent ON public."tabTimesheet Detail" USING btree (parent);


--
-- TOC entry 7735 (class 1259 OID 21447)
-- Name: idx_20159_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_20159_parent ON public.tabtodo USING btree (parent);


--
-- TOC entry 7738 (class 1259 OID 21443)
-- Name: idx_20159_reference_type_reference_name_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_20159_reference_type_reference_name_index ON public.tabtodo USING btree (reference_type, reference_name);


--
-- TOC entry 7739 (class 1259 OID 21438)
-- Name: idx_20169_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_20169_parent ON public."tabTop Bar Item" USING btree (parent);


--
-- TOC entry 7742 (class 1259 OID 21431)
-- Name: idx_20178_course; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_20178_course ON public.tabtopic USING btree (course);


--
-- TOC entry 7743 (class 1259 OID 21454)
-- Name: idx_20178_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_20178_parent ON public.tabtopic USING btree (parent);


--
-- TOC entry 7746 (class 1259 OID 21463)
-- Name: idx_20186_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_20186_parent ON public."tabTraining Event" USING btree (parent);


--
-- TOC entry 7749 (class 1259 OID 21445)
-- Name: idx_20195_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_20195_parent ON public."tabTraining Event Employee" USING btree (parent);


--
-- TOC entry 7752 (class 1259 OID 21435)
-- Name: idx_20204_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_20204_parent ON public."tabTraining Feedback" USING btree (parent);


--
-- TOC entry 7755 (class 1259 OID 21446)
-- Name: idx_20212_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_20212_parent ON public."tabTraining Result" USING btree (parent);


--
-- TOC entry 7758 (class 1259 OID 21442)
-- Name: idx_20212_training_event; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_20212_training_event ON public."tabTraining Result" USING btree (training_event);


--
-- TOC entry 7759 (class 1259 OID 21465)
-- Name: idx_20220_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_20220_parent ON public."tabTraining Result Employee" USING btree (parent);


--
-- TOC entry 7762 (class 1259 OID 21474)
-- Name: idx_20229_language; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_20229_language ON public.tabtranslation USING btree (language);


--
-- TOC entry 7763 (class 1259 OID 21459)
-- Name: idx_20229_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_20229_parent ON public.tabtranslation USING btree (parent);


--
-- TOC entry 7766 (class 1259 OID 21471)
-- Name: idx_20237_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_20237_parent ON public."tabUnhandled Email" USING btree (parent);


--
-- TOC entry 7769 (class 1259 OID 21467)
-- Name: idx_20245_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_20245_parent ON public.tabuom USING btree (parent);


--
-- TOC entry 7772 (class 1259 OID 21484)
-- Name: idx_20254_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_20254_parent ON public."tabUOM Conversion Detail" USING btree (parent);


--
-- TOC entry 7775 (class 1259 OID 21476)
-- Name: idx_20263_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_20263_parent ON public.tabuser USING btree (parent);


--
-- TOC entry 7778 (class 1259 OID 21486)
-- Name: idx_20263_username; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_20263_username ON public.tabuser USING btree (username);


--
-- TOC entry 7779 (class 1259 OID 21464)
-- Name: idx_20281_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_20281_parent ON public."tabUser Email" USING btree (parent);


--
-- TOC entry 7782 (class 1259 OID 21480)
-- Name: idx_20290_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_20290_parent ON public.tabuserrole USING btree (parent);


--
-- TOC entry 7785 (class 1259 OID 21495)
-- Name: idx_20298_license_plate; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_20298_license_plate ON public.tabvehicle USING btree (license_plate);


--
-- TOC entry 7786 (class 1259 OID 21466)
-- Name: idx_20298_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_20298_parent ON public.tabvehicle USING btree (parent);


--
-- TOC entry 7789 (class 1259 OID 21479)
-- Name: idx_20311_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_20311_parent ON public."tabVehicle Log" USING btree (parent);


--
-- TOC entry 7792 (class 1259 OID 21481)
-- Name: idx_20322_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_20322_parent ON public."tabVehicle Service" USING btree (parent);


--
-- TOC entry 7795 (class 1259 OID 21478)
-- Name: idx_20331_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_20331_parent ON public.tabversion USING btree (parent);


--
-- TOC entry 7798 (class 1259 OID 21491)
-- Name: idx_20339_company; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_20339_company ON public.tabwarehouse USING btree (company);


--
-- TOC entry 7799 (class 1259 OID 21472)
-- Name: idx_20339_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_20339_parent ON public.tabwarehouse USING btree (parent);


--
-- TOC entry 7800 (class 1259 OID 21492)
-- Name: idx_20339_parent_warehouse; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_20339_parent_warehouse ON public.tabwarehouse USING btree (parent_warehouse);


--
-- TOC entry 7803 (class 1259 OID 21507)
-- Name: idx_20351_company; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_20351_company ON public."tabWarranty Claim" USING btree (company);


--
-- TOC entry 7804 (class 1259 OID 21477)
-- Name: idx_20351_complaint_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_20351_complaint_date ON public."tabWarranty Claim" USING btree (complaint_date);


--
-- TOC entry 7805 (class 1259 OID 21503)
-- Name: idx_20351_customer; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_20351_customer ON public."tabWarranty Claim" USING btree (customer);


--
-- TOC entry 7806 (class 1259 OID 21493)
-- Name: idx_20351_item_code; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_20351_item_code ON public."tabWarranty Claim" USING btree (item_code);


--
-- TOC entry 7807 (class 1259 OID 21506)
-- Name: idx_20351_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_20351_parent ON public."tabWarranty Claim" USING btree (parent);


--
-- TOC entry 7810 (class 1259 OID 21490)
-- Name: idx_20351_resolution_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_20351_resolution_date ON public."tabWarranty Claim" USING btree (resolution_date);


--
-- TOC entry 7811 (class 1259 OID 21502)
-- Name: idx_20351_resolved_by; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_20351_resolved_by ON public."tabWarranty Claim" USING btree (resolved_by);


--
-- TOC entry 7812 (class 1259 OID 21482)
-- Name: idx_20351_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_20351_status ON public."tabWarranty Claim" USING btree (status);


--
-- TOC entry 7813 (class 1259 OID 21499)
-- Name: idx_20351_territory; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_20351_territory ON public."tabWarranty Claim" USING btree (territory);


--
-- TOC entry 7814 (class 1259 OID 21494)
-- Name: idx_20360_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_20360_parent ON public."tabWeb Form" USING btree (parent);


--
-- TOC entry 7817 (class 1259 OID 21488)
-- Name: idx_20360_route; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_20360_route ON public."tabWeb Form" USING btree (route);


--
-- TOC entry 7818 (class 1259 OID 21513)
-- Name: idx_20383_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_20383_parent ON public."tabWeb Form Field" USING btree (parent);


--
-- TOC entry 7821 (class 1259 OID 21515)
-- Name: idx_20396_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_20396_parent ON public."tabWeb Page" USING btree (parent);


--
-- TOC entry 7824 (class 1259 OID 21500)
-- Name: idx_20396_route; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_20396_route ON public."tabWeb Page" USING btree (route);


--
-- TOC entry 7825 (class 1259 OID 21511)
-- Name: idx_20410_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_20410_parent ON public."tabWebsite Item Group" USING btree (parent);


--
-- TOC entry 7828 (class 1259 OID 21514)
-- Name: idx_20418_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_20418_parent ON public."tabWebsite Sidebar" USING btree (parent);


--
-- TOC entry 7831 (class 1259 OID 21529)
-- Name: idx_20426_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_20426_parent ON public."tabWebsite Sidebar Item" USING btree (parent);


--
-- TOC entry 7834 (class 1259 OID 21525)
-- Name: idx_20434_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_20434_parent ON public."tabWebsite Slideshow" USING btree (parent);


--
-- TOC entry 7837 (class 1259 OID 21526)
-- Name: idx_20442_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_20442_parent ON public."tabWebsite Slideshow Item" USING btree (parent);


--
-- TOC entry 7840 (class 1259 OID 21510)
-- Name: idx_20450_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_20450_parent ON public."tabWebsite Theme" USING btree (parent);


--
-- TOC entry 7843 (class 1259 OID 21497)
-- Name: idx_20450_theme; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_20450_theme ON public."tabWebsite Theme" USING btree (theme);


--
-- TOC entry 7844 (class 1259 OID 21519)
-- Name: idx_20462_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_20462_parent ON public.tabworkflow USING btree (parent);


--
-- TOC entry 7847 (class 1259 OID 21535)
-- Name: idx_20473_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_20473_parent ON public."tabWorkflow Action" USING btree (parent);


--
-- TOC entry 7850 (class 1259 OID 21531)
-- Name: idx_20481_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_20481_parent ON public."tabWorkflow Document State" USING btree (parent);


--
-- TOC entry 7853 (class 1259 OID 21532)
-- Name: idx_20489_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_20489_parent ON public."tabWorkflow State" USING btree (parent);


--
-- TOC entry 7856 (class 1259 OID 21522)
-- Name: idx_20497_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_20497_parent ON public."tabWorkflow Transition" USING btree (parent);


--
-- TOC entry 7859 (class 1259 OID 21509)
-- Name: idx_20505_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_20505_parent ON public.tabworkstation USING btree (parent);


--
-- TOC entry 7862 (class 1259 OID 21527)
-- Name: idx_20518_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_20518_parent ON public."tabWorkstation Working Hour" USING btree (parent);


--
-- TOC entry 7867 (class 1259 OID 21533)
-- Name: idx_20534_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_20534_user ON public.__listsettings USING btree ("user", doctype);


-- Completed on 2018-06-02 15:52:50 UTC

--
-- PostgreSQL database dump complete
--

