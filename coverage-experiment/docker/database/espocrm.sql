--
-- PostgreSQL database dump
--

-- Dumped from database version 10.4 (Debian 10.4-2.pgdg90+1)
-- Dumped by pg_dump version 10.3

-- Started on 2018-06-02 15:52:13 UTC

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
-- TOC entry 4349 (class 1262 OID 21900)
-- Name: espocrm; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE espocrm WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';


ALTER DATABASE espocrm OWNER TO postgres;

\connect espocrm

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
-- TOC entry 4351 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 198 (class 1259 OID 21901)
-- Name: account; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.account (
    id character varying(24) NOT NULL,
    name character varying(255),
    deleted boolean DEFAULT false,
    website character varying(255),
    type character varying(255) DEFAULT ''::character varying,
    industry character varying(255) DEFAULT ''::character varying,
    sic_code character varying(40),
    billing_address_street character varying(255),
    billing_address_city character varying(255),
    billing_address_state character varying(255),
    billing_address_country character varying(255),
    billing_address_postal_code character varying(255),
    shipping_address_street character varying(255),
    shipping_address_city character varying(255),
    shipping_address_state character varying(255),
    shipping_address_country character varying(255),
    shipping_address_postal_code character varying(255),
    description text,
    created_at timestamp with time zone,
    modified_at timestamp with time zone,
    campaign_id character varying(24),
    created_by_id character varying(24),
    modified_by_id character varying(24),
    assigned_user_id character varying(24)
);


ALTER TABLE public.account OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 21912)
-- Name: account_contact; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.account_contact (
    id bigint NOT NULL,
    account_id character varying(24),
    contact_id character varying(24),
    role character varying(50),
    deleted boolean DEFAULT false
);


ALTER TABLE public.account_contact OWNER TO postgres;

--
-- TOC entry 199 (class 1259 OID 21910)
-- Name: account_contact_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.account_contact_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.account_contact_id_seq OWNER TO postgres;

--
-- TOC entry 4352 (class 0 OID 0)
-- Dependencies: 199
-- Name: account_contact_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.account_contact_id_seq OWNED BY public.account_contact.id;


--
-- TOC entry 202 (class 1259 OID 21919)
-- Name: account_document; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.account_document (
    id bigint NOT NULL,
    account_id character varying(24),
    document_id character varying(24),
    deleted boolean DEFAULT false
);


ALTER TABLE public.account_document OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 21917)
-- Name: account_document_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.account_document_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.account_document_id_seq OWNER TO postgres;

--
-- TOC entry 4353 (class 0 OID 0)
-- Dependencies: 201
-- Name: account_document_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.account_document_id_seq OWNED BY public.account_document.id;


--
-- TOC entry 204 (class 1259 OID 21926)
-- Name: account_portal_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.account_portal_user (
    id bigint NOT NULL,
    user_id character varying(24),
    account_id character varying(24),
    deleted boolean DEFAULT false
);


ALTER TABLE public.account_portal_user OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 21924)
-- Name: account_portal_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.account_portal_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.account_portal_user_id_seq OWNER TO postgres;

--
-- TOC entry 4354 (class 0 OID 0)
-- Dependencies: 203
-- Name: account_portal_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.account_portal_user_id_seq OWNED BY public.account_portal_user.id;


--
-- TOC entry 206 (class 1259 OID 21933)
-- Name: account_target_list; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.account_target_list (
    id bigint NOT NULL,
    account_id character varying(24),
    target_list_id character varying(24),
    opted_out boolean DEFAULT false,
    deleted boolean DEFAULT false
);


ALTER TABLE public.account_target_list OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 21931)
-- Name: account_target_list_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.account_target_list_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.account_target_list_id_seq OWNER TO postgres;

--
-- TOC entry 4355 (class 0 OID 0)
-- Dependencies: 205
-- Name: account_target_list_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.account_target_list_id_seq OWNED BY public.account_target_list.id;


--
-- TOC entry 207 (class 1259 OID 21939)
-- Name: attachment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.attachment (
    id character varying(24) NOT NULL,
    name character varying(255),
    deleted boolean DEFAULT false,
    type character varying(100),
    size bigint,
    source_id character varying(36),
    created_at timestamp with time zone,
    role character varying(36),
    storage character varying(24),
    global boolean DEFAULT false NOT NULL,
    parent_id character varying(24),
    parent_type character varying(100),
    related_id character varying(24),
    related_type character varying(100),
    created_by_id character varying(24)
);


ALTER TABLE public.attachment OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 21947)
-- Name: auth_token; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_token (
    id character varying(24) NOT NULL,
    deleted boolean DEFAULT false,
    token character varying(36),
    hash character varying(150),
    user_id character varying(36),
    ip_address character varying(36),
    last_access timestamp with time zone,
    created_at timestamp with time zone,
    modified_at timestamp with time zone,
    portal_id character varying(24)
);


ALTER TABLE public.auth_token OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 21953)
-- Name: autofollow; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.autofollow (
    id bigint NOT NULL,
    entity_type character varying(100),
    user_id character varying(24)
);


ALTER TABLE public.autofollow OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 21951)
-- Name: autofollow_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.autofollow_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.autofollow_id_seq OWNER TO postgres;

--
-- TOC entry 4356 (class 0 OID 0)
-- Dependencies: 209
-- Name: autofollow_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.autofollow_id_seq OWNED BY public.autofollow.id;


--
-- TOC entry 211 (class 1259 OID 21957)
-- Name: call; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.call (
    id character varying(24) NOT NULL,
    name character varying(255),
    deleted boolean DEFAULT false,
    status character varying(255) DEFAULT 'Planned'::character varying,
    date_start timestamp with time zone,
    date_end timestamp with time zone,
    direction character varying(255) DEFAULT 'Outbound'::character varying,
    description text,
    created_at timestamp with time zone,
    modified_at timestamp with time zone,
    parent_id character varying(24),
    parent_type character varying(100),
    account_id character varying(24),
    created_by_id character varying(24),
    modified_by_id character varying(24),
    assigned_user_id character varying(24)
);


ALTER TABLE public.call OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 21968)
-- Name: call_contact; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.call_contact (
    id bigint NOT NULL,
    call_id character varying(24),
    contact_id character varying(24),
    status character varying(36) DEFAULT 'None'::character varying,
    deleted boolean DEFAULT false
);


ALTER TABLE public.call_contact OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 21966)
-- Name: call_contact_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.call_contact_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.call_contact_id_seq OWNER TO postgres;

--
-- TOC entry 4357 (class 0 OID 0)
-- Dependencies: 212
-- Name: call_contact_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.call_contact_id_seq OWNED BY public.call_contact.id;


--
-- TOC entry 215 (class 1259 OID 21976)
-- Name: call_lead; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.call_lead (
    id bigint NOT NULL,
    call_id character varying(24),
    lead_id character varying(24),
    status character varying(36) DEFAULT 'None'::character varying,
    deleted boolean DEFAULT false
);


ALTER TABLE public.call_lead OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 21974)
-- Name: call_lead_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.call_lead_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.call_lead_id_seq OWNER TO postgres;

--
-- TOC entry 4358 (class 0 OID 0)
-- Dependencies: 214
-- Name: call_lead_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.call_lead_id_seq OWNED BY public.call_lead.id;


--
-- TOC entry 217 (class 1259 OID 21984)
-- Name: call_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.call_user (
    id bigint NOT NULL,
    user_id character varying(24),
    call_id character varying(24),
    status character varying(36) DEFAULT 'None'::character varying,
    deleted boolean DEFAULT false
);


ALTER TABLE public.call_user OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 21982)
-- Name: call_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.call_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.call_user_id_seq OWNER TO postgres;

--
-- TOC entry 4359 (class 0 OID 0)
-- Dependencies: 216
-- Name: call_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.call_user_id_seq OWNED BY public.call_user.id;


--
-- TOC entry 218 (class 1259 OID 21990)
-- Name: campaign; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.campaign (
    id character varying(24) NOT NULL,
    name character varying(255),
    deleted boolean DEFAULT false,
    status character varying(255) DEFAULT 'Planning'::character varying,
    type character varying(255) DEFAULT 'Email'::character varying,
    start_date date,
    end_date date,
    description text,
    created_at timestamp with time zone,
    modified_at timestamp with time zone,
    budget double precision,
    budget_currency character varying(255),
    created_by_id character varying(24),
    modified_by_id character varying(24),
    assigned_user_id character varying(24)
);


ALTER TABLE public.campaign OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 21999)
-- Name: campaign_log_record; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.campaign_log_record (
    id character varying(24) NOT NULL,
    deleted boolean DEFAULT false,
    action character varying(50),
    action_date timestamp with time zone,
    data text,
    string_data character varying(100),
    string_additional_data character varying(100),
    application character varying(36) DEFAULT 'Espo'::character varying,
    created_at timestamp with time zone,
    is_test boolean DEFAULT false NOT NULL,
    created_by_id character varying(24),
    campaign_id character varying(24),
    parent_id character varying(24),
    parent_type character varying(100),
    object_id character varying(24),
    object_type character varying(100),
    queue_item_id character varying(24)
);


ALTER TABLE public.campaign_log_record OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 22010)
-- Name: campaign_target_list; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.campaign_target_list (
    id bigint NOT NULL,
    campaign_id character varying(24),
    target_list_id character varying(24),
    deleted boolean DEFAULT false
);


ALTER TABLE public.campaign_target_list OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 22017)
-- Name: campaign_target_list_excluding; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.campaign_target_list_excluding (
    id bigint NOT NULL,
    campaign_id character varying(24),
    target_list_id character varying(24),
    deleted boolean DEFAULT false
);


ALTER TABLE public.campaign_target_list_excluding OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 22015)
-- Name: campaign_target_list_excluding_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.campaign_target_list_excluding_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.campaign_target_list_excluding_id_seq OWNER TO postgres;

--
-- TOC entry 4360 (class 0 OID 0)
-- Dependencies: 222
-- Name: campaign_target_list_excluding_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.campaign_target_list_excluding_id_seq OWNED BY public.campaign_target_list_excluding.id;


--
-- TOC entry 220 (class 1259 OID 22008)
-- Name: campaign_target_list_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.campaign_target_list_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.campaign_target_list_id_seq OWNER TO postgres;

--
-- TOC entry 4361 (class 0 OID 0)
-- Dependencies: 220
-- Name: campaign_target_list_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.campaign_target_list_id_seq OWNED BY public.campaign_target_list.id;


--
-- TOC entry 224 (class 1259 OID 22022)
-- Name: campaign_tracking_url; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.campaign_tracking_url (
    id character varying(24) NOT NULL,
    name character varying(255),
    deleted boolean DEFAULT false,
    url character varying(255),
    modified_at timestamp with time zone,
    created_at timestamp with time zone,
    campaign_id character varying(24),
    modified_by_id character varying(24),
    created_by_id character varying(24)
);


ALTER TABLE public.campaign_tracking_url OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 22031)
-- Name: case; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."case" (
    id character varying(24) NOT NULL,
    name character varying(255),
    deleted boolean DEFAULT false,
    number bigint NOT NULL,
    status character varying(255) DEFAULT 'New'::character varying,
    priority character varying(255) DEFAULT 'Normal'::character varying,
    type character varying(255) DEFAULT ''::character varying,
    description text,
    created_at timestamp with time zone,
    modified_at timestamp with time zone,
    account_id character varying(24),
    lead_id character varying(24),
    contact_id character varying(24),
    inbound_email_id character varying(24),
    created_by_id character varying(24),
    modified_by_id character varying(24),
    assigned_user_id character varying(24)
);


ALTER TABLE public."case" OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 22044)
-- Name: case_contact; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.case_contact (
    id bigint NOT NULL,
    case_id character varying(24),
    contact_id character varying(24),
    deleted boolean DEFAULT false
);


ALTER TABLE public.case_contact OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 22042)
-- Name: case_contact_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.case_contact_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.case_contact_id_seq OWNER TO postgres;

--
-- TOC entry 4362 (class 0 OID 0)
-- Dependencies: 227
-- Name: case_contact_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.case_contact_id_seq OWNED BY public.case_contact.id;


--
-- TOC entry 230 (class 1259 OID 22051)
-- Name: case_knowledge_base_article; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.case_knowledge_base_article (
    id bigint NOT NULL,
    case_id character varying(24),
    knowledge_base_article_id character varying(24),
    deleted boolean DEFAULT false
);


ALTER TABLE public.case_knowledge_base_article OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 22049)
-- Name: case_knowledge_base_article_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.case_knowledge_base_article_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.case_knowledge_base_article_id_seq OWNER TO postgres;

--
-- TOC entry 4363 (class 0 OID 0)
-- Dependencies: 229
-- Name: case_knowledge_base_article_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.case_knowledge_base_article_id_seq OWNED BY public.case_knowledge_base_article.id;


--
-- TOC entry 225 (class 1259 OID 22029)
-- Name: case_number_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.case_number_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.case_number_seq OWNER TO postgres;

--
-- TOC entry 4364 (class 0 OID 0)
-- Dependencies: 225
-- Name: case_number_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.case_number_seq OWNED BY public."case".number;


--
-- TOC entry 231 (class 1259 OID 22056)
-- Name: contact; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contact (
    id character varying(24) NOT NULL,
    deleted boolean DEFAULT false,
    salutation_name character varying(255),
    first_name character varying(100) DEFAULT ''::character varying,
    last_name character varying(100) DEFAULT ''::character varying,
    account_id character varying(24),
    description text,
    do_not_call boolean DEFAULT false NOT NULL,
    address_street character varying(255),
    address_city character varying(255),
    address_state character varying(255),
    address_country character varying(255),
    address_postal_code character varying(255),
    created_at timestamp with time zone,
    modified_at timestamp with time zone,
    campaign_id character varying(24),
    created_by_id character varying(24),
    modified_by_id character varying(24),
    assigned_user_id character varying(24)
);


ALTER TABLE public.contact OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 22068)
-- Name: contact_document; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contact_document (
    id bigint NOT NULL,
    contact_id character varying(24),
    document_id character varying(24),
    deleted boolean DEFAULT false
);


ALTER TABLE public.contact_document OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 22066)
-- Name: contact_document_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.contact_document_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.contact_document_id_seq OWNER TO postgres;

--
-- TOC entry 4365 (class 0 OID 0)
-- Dependencies: 232
-- Name: contact_document_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.contact_document_id_seq OWNED BY public.contact_document.id;


--
-- TOC entry 235 (class 1259 OID 22075)
-- Name: contact_meeting; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contact_meeting (
    id bigint NOT NULL,
    contact_id character varying(24),
    meeting_id character varying(24),
    status character varying(36) DEFAULT 'None'::character varying,
    deleted boolean DEFAULT false
);


ALTER TABLE public.contact_meeting OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 22073)
-- Name: contact_meeting_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.contact_meeting_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.contact_meeting_id_seq OWNER TO postgres;

--
-- TOC entry 4366 (class 0 OID 0)
-- Dependencies: 234
-- Name: contact_meeting_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.contact_meeting_id_seq OWNED BY public.contact_meeting.id;


--
-- TOC entry 237 (class 1259 OID 22083)
-- Name: contact_opportunity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contact_opportunity (
    id bigint NOT NULL,
    contact_id character varying(24),
    opportunity_id character varying(24),
    role character varying(50),
    deleted boolean DEFAULT false
);


ALTER TABLE public.contact_opportunity OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 22081)
-- Name: contact_opportunity_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.contact_opportunity_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.contact_opportunity_id_seq OWNER TO postgres;

--
-- TOC entry 4367 (class 0 OID 0)
-- Dependencies: 236
-- Name: contact_opportunity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.contact_opportunity_id_seq OWNED BY public.contact_opportunity.id;


--
-- TOC entry 239 (class 1259 OID 22090)
-- Name: contact_target_list; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contact_target_list (
    id bigint NOT NULL,
    contact_id character varying(24),
    target_list_id character varying(24),
    opted_out boolean DEFAULT false,
    deleted boolean DEFAULT false
);


ALTER TABLE public.contact_target_list OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 22088)
-- Name: contact_target_list_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.contact_target_list_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.contact_target_list_id_seq OWNER TO postgres;

--
-- TOC entry 4368 (class 0 OID 0)
-- Dependencies: 238
-- Name: contact_target_list_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.contact_target_list_id_seq OWNED BY public.contact_target_list.id;


--
-- TOC entry 240 (class 1259 OID 22096)
-- Name: currency; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.currency (
    id character varying(24) NOT NULL,
    deleted boolean DEFAULT false,
    rate double precision
);


ALTER TABLE public.currency OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 22100)
-- Name: document; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.document (
    id character varying(24) NOT NULL,
    name character varying(255),
    deleted boolean DEFAULT false,
    status character varying(255),
    source character varying(255) DEFAULT 'Espo'::character varying,
    type character varying(255),
    publish_date date,
    expiration_date date,
    description text,
    created_at timestamp with time zone,
    modified_at timestamp with time zone,
    created_by_id character varying(24),
    modified_by_id character varying(24),
    assigned_user_id character varying(24),
    folder_id character varying(24),
    file_id character varying(24)
);


ALTER TABLE public.document OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 22108)
-- Name: document_folder; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.document_folder (
    id character varying(24) NOT NULL,
    name character varying(255),
    deleted boolean DEFAULT false,
    description text,
    created_at timestamp with time zone,
    modified_at timestamp with time zone,
    created_by_id character varying(24),
    modified_by_id character varying(24),
    parent_id character varying(24)
);


ALTER TABLE public.document_folder OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 22117)
-- Name: document_folder_path; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.document_folder_path (
    id bigint NOT NULL,
    ascendor_id character varying(100),
    descendor_id character varying(24)
);


ALTER TABLE public.document_folder_path OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 22115)
-- Name: document_folder_path_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.document_folder_path_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.document_folder_path_id_seq OWNER TO postgres;

--
-- TOC entry 4369 (class 0 OID 0)
-- Dependencies: 243
-- Name: document_folder_path_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.document_folder_path_id_seq OWNED BY public.document_folder_path.id;


--
-- TOC entry 246 (class 1259 OID 22123)
-- Name: document_lead; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.document_lead (
    id bigint NOT NULL,
    document_id character varying(24),
    lead_id character varying(24),
    deleted boolean DEFAULT false
);


ALTER TABLE public.document_lead OWNER TO postgres;

--
-- TOC entry 245 (class 1259 OID 22121)
-- Name: document_lead_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.document_lead_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.document_lead_id_seq OWNER TO postgres;

--
-- TOC entry 4370 (class 0 OID 0)
-- Dependencies: 245
-- Name: document_lead_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.document_lead_id_seq OWNED BY public.document_lead.id;


--
-- TOC entry 248 (class 1259 OID 22130)
-- Name: document_opportunity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.document_opportunity (
    id bigint NOT NULL,
    document_id character varying(24),
    opportunity_id character varying(24),
    deleted boolean DEFAULT false
);


ALTER TABLE public.document_opportunity OWNER TO postgres;

--
-- TOC entry 247 (class 1259 OID 22128)
-- Name: document_opportunity_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.document_opportunity_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.document_opportunity_id_seq OWNER TO postgres;

--
-- TOC entry 4371 (class 0 OID 0)
-- Dependencies: 247
-- Name: document_opportunity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.document_opportunity_id_seq OWNED BY public.document_opportunity.id;


--
-- TOC entry 249 (class 1259 OID 22135)
-- Name: email; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.email (
    id character varying(24) NOT NULL,
    name character varying(255),
    deleted boolean DEFAULT false,
    from_name character varying(255),
    from_string character varying(255),
    reply_to_string character varying(255),
    is_replied boolean DEFAULT false NOT NULL,
    message_id character varying(255),
    message_id_internal character varying(300),
    body_plain text,
    body text,
    is_html boolean DEFAULT true NOT NULL,
    status character varying(255) DEFAULT 'Archived'::character varying,
    has_attachment boolean DEFAULT false NOT NULL,
    date_sent timestamp with time zone,
    delivery_date timestamp with time zone,
    created_at timestamp with time zone,
    modified_at timestamp with time zone,
    is_system boolean DEFAULT false NOT NULL,
    from_email_address_id character varying(24),
    parent_id character varying(24),
    parent_type character varying(100),
    created_by_id character varying(24),
    sent_by_id character varying(24),
    modified_by_id character varying(24),
    assigned_user_id character varying(24),
    replied_id character varying(24),
    account_id character varying(24)
);


ALTER TABLE public.email OWNER TO postgres;

--
-- TOC entry 250 (class 1259 OID 22147)
-- Name: email_account; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.email_account (
    id character varying(24) NOT NULL,
    name character varying(255),
    deleted boolean DEFAULT false,
    email_address character varying(100),
    status character varying(255),
    host character varying(255),
    port character varying(255) DEFAULT '143'::character varying,
    ssl boolean DEFAULT false NOT NULL,
    username character varying(255),
    password character varying(255),
    monitored_folders character varying(255) DEFAULT 'INBOX'::character varying,
    sent_folder character varying(255),
    store_sent_emails boolean DEFAULT false NOT NULL,
    keep_fetched_emails_unread boolean DEFAULT false NOT NULL,
    fetch_since date,
    fetch_data text,
    created_at timestamp with time zone,
    modified_at timestamp with time zone,
    use_smtp boolean DEFAULT false NOT NULL,
    smtp_host character varying(255),
    smtp_port bigint DEFAULT '25'::bigint,
    smtp_auth boolean DEFAULT false NOT NULL,
    smtp_security character varying(255),
    smtp_username character varying(255),
    smtp_password character varying(255),
    email_folder_id character varying(24),
    assigned_user_id character varying(24),
    created_by_id character varying(24),
    modified_by_id character varying(24)
);


ALTER TABLE public.email_account OWNER TO postgres;

--
-- TOC entry 251 (class 1259 OID 22162)
-- Name: email_address; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.email_address (
    id character varying(24) NOT NULL,
    name character varying(255),
    deleted boolean DEFAULT false,
    lower character varying(255),
    invalid boolean DEFAULT false NOT NULL,
    opt_out boolean DEFAULT false NOT NULL
);


ALTER TABLE public.email_address OWNER TO postgres;

--
-- TOC entry 253 (class 1259 OID 22173)
-- Name: email_email_account; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.email_email_account (
    id bigint NOT NULL,
    email_id character varying(24),
    email_account_id character varying(24),
    deleted boolean DEFAULT false
);


ALTER TABLE public.email_email_account OWNER TO postgres;

--
-- TOC entry 252 (class 1259 OID 22171)
-- Name: email_email_account_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.email_email_account_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.email_email_account_id_seq OWNER TO postgres;

--
-- TOC entry 4372 (class 0 OID 0)
-- Dependencies: 252
-- Name: email_email_account_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.email_email_account_id_seq OWNED BY public.email_email_account.id;


--
-- TOC entry 255 (class 1259 OID 22180)
-- Name: email_email_address; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.email_email_address (
    id bigint NOT NULL,
    email_id character varying(24),
    email_address_id character varying(24),
    address_type character varying(4),
    deleted boolean DEFAULT false
);


ALTER TABLE public.email_email_address OWNER TO postgres;

--
-- TOC entry 254 (class 1259 OID 22178)
-- Name: email_email_address_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.email_email_address_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.email_email_address_id_seq OWNER TO postgres;

--
-- TOC entry 4373 (class 0 OID 0)
-- Dependencies: 254
-- Name: email_email_address_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.email_email_address_id_seq OWNED BY public.email_email_address.id;


--
-- TOC entry 256 (class 1259 OID 22185)
-- Name: email_filter; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.email_filter (
    id character varying(24) NOT NULL,
    name character varying(100),
    deleted boolean DEFAULT false,
    "from" character varying(255),
    "to" character varying(255),
    subject character varying(255),
    body_contains text,
    is_global boolean DEFAULT false NOT NULL,
    action character varying(255) DEFAULT 'Skip'::character varying,
    created_at timestamp with time zone,
    modified_at timestamp with time zone,
    parent_id character varying(24),
    parent_type character varying(100),
    email_folder_id character varying(24),
    created_by_id character varying(24),
    modified_by_id character varying(24)
);


ALTER TABLE public.email_filter OWNER TO postgres;

--
-- TOC entry 257 (class 1259 OID 22194)
-- Name: email_folder; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.email_folder (
    id character varying(24) NOT NULL,
    name character varying(64),
    deleted boolean DEFAULT false,
    "order" bigint,
    skip_notifications boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone,
    modified_at timestamp with time zone,
    assigned_user_id character varying(24),
    created_by_id character varying(24),
    modified_by_id character varying(24)
);


ALTER TABLE public.email_folder OWNER TO postgres;

--
-- TOC entry 259 (class 1259 OID 22201)
-- Name: email_inbound_email; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.email_inbound_email (
    id bigint NOT NULL,
    email_id character varying(24),
    inbound_email_id character varying(24),
    deleted boolean DEFAULT false
);


ALTER TABLE public.email_inbound_email OWNER TO postgres;

--
-- TOC entry 258 (class 1259 OID 22199)
-- Name: email_inbound_email_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.email_inbound_email_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.email_inbound_email_id_seq OWNER TO postgres;

--
-- TOC entry 4374 (class 0 OID 0)
-- Dependencies: 258
-- Name: email_inbound_email_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.email_inbound_email_id_seq OWNED BY public.email_inbound_email.id;


--
-- TOC entry 260 (class 1259 OID 22206)
-- Name: email_queue_item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.email_queue_item (
    id character varying(24) NOT NULL,
    deleted boolean DEFAULT false,
    status character varying(255),
    attempt_count bigint DEFAULT '0'::bigint,
    created_at timestamp with time zone,
    sent_at timestamp with time zone,
    email_address character varying(255),
    is_test boolean DEFAULT false NOT NULL,
    mass_email_id character varying(24),
    target_id character varying(24),
    target_type character varying(100)
);


ALTER TABLE public.email_queue_item OWNER TO postgres;

--
-- TOC entry 261 (class 1259 OID 22215)
-- Name: email_template; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.email_template (
    id character varying(24) NOT NULL,
    name character varying(255),
    deleted boolean DEFAULT false,
    subject character varying(255),
    body text,
    is_html boolean DEFAULT true NOT NULL,
    one_off boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone,
    modified_at timestamp with time zone,
    assigned_user_id character varying(24),
    created_by_id character varying(24),
    modified_by_id character varying(24)
);


ALTER TABLE public.email_template OWNER TO postgres;

--
-- TOC entry 263 (class 1259 OID 22226)
-- Name: email_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.email_user (
    id bigint NOT NULL,
    email_id character varying(24),
    user_id character varying(24),
    is_read boolean DEFAULT false,
    is_important boolean DEFAULT false,
    in_trash boolean DEFAULT false,
    folder_id character varying(255),
    deleted boolean DEFAULT false
);


ALTER TABLE public.email_user OWNER TO postgres;

--
-- TOC entry 262 (class 1259 OID 22224)
-- Name: email_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.email_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.email_user_id_seq OWNER TO postgres;

--
-- TOC entry 4375 (class 0 OID 0)
-- Dependencies: 262
-- Name: email_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.email_user_id_seq OWNED BY public.email_user.id;


--
-- TOC entry 265 (class 1259 OID 22236)
-- Name: entity_email_address; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.entity_email_address (
    id bigint NOT NULL,
    entity_id character varying(24),
    email_address_id character varying(24),
    entity_type character varying(100),
    "primary" boolean DEFAULT false,
    deleted boolean DEFAULT false
);


ALTER TABLE public.entity_email_address OWNER TO postgres;

--
-- TOC entry 264 (class 1259 OID 22234)
-- Name: entity_email_address_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.entity_email_address_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.entity_email_address_id_seq OWNER TO postgres;

--
-- TOC entry 4376 (class 0 OID 0)
-- Dependencies: 264
-- Name: entity_email_address_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.entity_email_address_id_seq OWNED BY public.entity_email_address.id;


--
-- TOC entry 267 (class 1259 OID 22244)
-- Name: entity_phone_number; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.entity_phone_number (
    id bigint NOT NULL,
    entity_id character varying(24),
    phone_number_id character varying(24),
    entity_type character varying(100),
    "primary" boolean DEFAULT false,
    deleted boolean DEFAULT false
);


ALTER TABLE public.entity_phone_number OWNER TO postgres;

--
-- TOC entry 266 (class 1259 OID 22242)
-- Name: entity_phone_number_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.entity_phone_number_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.entity_phone_number_id_seq OWNER TO postgres;

--
-- TOC entry 4377 (class 0 OID 0)
-- Dependencies: 266
-- Name: entity_phone_number_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.entity_phone_number_id_seq OWNED BY public.entity_phone_number.id;


--
-- TOC entry 269 (class 1259 OID 22252)
-- Name: entity_team; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.entity_team (
    id bigint NOT NULL,
    entity_id character varying(24),
    team_id character varying(24),
    entity_type character varying(100),
    deleted boolean DEFAULT false
);


ALTER TABLE public.entity_team OWNER TO postgres;

--
-- TOC entry 268 (class 1259 OID 22250)
-- Name: entity_team_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.entity_team_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.entity_team_id_seq OWNER TO postgres;

--
-- TOC entry 4378 (class 0 OID 0)
-- Dependencies: 268
-- Name: entity_team_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.entity_team_id_seq OWNED BY public.entity_team.id;


--
-- TOC entry 271 (class 1259 OID 22259)
-- Name: entity_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.entity_user (
    id bigint NOT NULL,
    entity_id character varying(24),
    user_id character varying(24),
    entity_type character varying(100),
    deleted boolean DEFAULT false
);


ALTER TABLE public.entity_user OWNER TO postgres;

--
-- TOC entry 270 (class 1259 OID 22257)
-- Name: entity_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.entity_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.entity_user_id_seq OWNER TO postgres;

--
-- TOC entry 4379 (class 0 OID 0)
-- Dependencies: 270
-- Name: entity_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.entity_user_id_seq OWNED BY public.entity_user.id;


--
-- TOC entry 272 (class 1259 OID 22264)
-- Name: extension; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.extension (
    id character varying(24) NOT NULL,
    name character varying(255),
    deleted boolean DEFAULT false,
    version character varying(50),
    file_list text,
    description text,
    is_installed boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone,
    created_by_id character varying(24)
);


ALTER TABLE public.extension OWNER TO postgres;

--
-- TOC entry 273 (class 1259 OID 22272)
-- Name: external_account; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.external_account (
    id character varying(64) NOT NULL,
    deleted boolean DEFAULT false,
    data text,
    enabled boolean DEFAULT false NOT NULL
);


ALTER TABLE public.external_account OWNER TO postgres;

--
-- TOC entry 274 (class 1259 OID 22280)
-- Name: import; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.import (
    id character varying(24) NOT NULL,
    deleted boolean DEFAULT false,
    entity_type character varying(255),
    status character varying(255),
    created_at timestamp with time zone,
    created_by_id character varying(24),
    file_id character varying(24)
);


ALTER TABLE public.import OWNER TO postgres;

--
-- TOC entry 276 (class 1259 OID 22289)
-- Name: import_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.import_entity (
    id bigint NOT NULL,
    entity_id character varying(24),
    entity_type character varying(100),
    import_id character varying(24),
    is_imported boolean DEFAULT false,
    is_updated boolean DEFAULT false,
    is_duplicate boolean DEFAULT false
);


ALTER TABLE public.import_entity OWNER TO postgres;

--
-- TOC entry 275 (class 1259 OID 22287)
-- Name: import_entity_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.import_entity_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.import_entity_id_seq OWNER TO postgres;

--
-- TOC entry 4380 (class 0 OID 0)
-- Dependencies: 275
-- Name: import_entity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.import_entity_id_seq OWNED BY public.import_entity.id;


--
-- TOC entry 277 (class 1259 OID 22296)
-- Name: inbound_email; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inbound_email (
    id character varying(24) NOT NULL,
    name character varying(255),
    deleted boolean DEFAULT false,
    email_address character varying(100),
    status character varying(255),
    host character varying(255),
    port character varying(255) DEFAULT '143'::character varying,
    ssl boolean DEFAULT false NOT NULL,
    username character varying(255),
    password character varying(255),
    monitored_folders character varying(255) DEFAULT 'INBOX'::character varying,
    fetch_since date,
    fetch_data text,
    add_all_team_users boolean DEFAULT false NOT NULL,
    create_case boolean DEFAULT false NOT NULL,
    case_distribution character varying(255) DEFAULT 'Direct-Assignment'::character varying,
    target_user_position character varying(255),
    reply boolean DEFAULT false NOT NULL,
    reply_from_address character varying(255),
    reply_to_address character varying(255),
    reply_from_name character varying(255),
    created_at timestamp with time zone,
    modified_at timestamp with time zone,
    assign_to_user_id character varying(24),
    team_id character varying(24),
    reply_email_template_id character varying(24),
    created_by_id character varying(24),
    modified_by_id character varying(24)
);


ALTER TABLE public.inbound_email OWNER TO postgres;

--
-- TOC entry 278 (class 1259 OID 22310)
-- Name: integration; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.integration (
    id character varying(24) NOT NULL,
    deleted boolean DEFAULT false,
    data text,
    enabled boolean DEFAULT false NOT NULL
);


ALTER TABLE public.integration OWNER TO postgres;

--
-- TOC entry 279 (class 1259 OID 22318)
-- Name: job; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.job (
    id character varying(24) NOT NULL,
    name character varying(255),
    deleted boolean DEFAULT false,
    status character varying(255) DEFAULT 'Pending'::character varying,
    execute_time timestamp with time zone,
    service_name character varying(100),
    method character varying(100),
    data text,
    attempts bigint,
    target_id character varying(48),
    target_type character varying(64),
    failed_attempts bigint,
    created_at timestamp with time zone,
    modified_at timestamp with time zone,
    scheduled_job_id character varying(24)
);


ALTER TABLE public.job OWNER TO postgres;

--
-- TOC entry 280 (class 1259 OID 22326)
-- Name: knowledge_base_article; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.knowledge_base_article (
    id character varying(24) NOT NULL,
    name character varying(255),
    deleted boolean DEFAULT false,
    status character varying(255) DEFAULT 'Draft'::character varying,
    language character varying(255) DEFAULT ''::character varying,
    type character varying(255),
    publish_date date,
    expiration_date date,
    "order" bigint,
    description text,
    created_at timestamp with time zone,
    modified_at timestamp with time zone,
    body text,
    created_by_id character varying(24),
    modified_by_id character varying(24),
    assigned_user_id character varying(24)
);


ALTER TABLE public.knowledge_base_article OWNER TO postgres;

--
-- TOC entry 282 (class 1259 OID 22337)
-- Name: knowledge_base_article_knowledge_base_category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.knowledge_base_article_knowledge_base_category (
    id bigint NOT NULL,
    knowledge_base_article_id character varying(24),
    knowledge_base_category_id character varying(24),
    deleted boolean DEFAULT false
);


ALTER TABLE public.knowledge_base_article_knowledge_base_category OWNER TO postgres;

--
-- TOC entry 281 (class 1259 OID 22335)
-- Name: knowledge_base_article_knowledge_base_category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.knowledge_base_article_knowledge_base_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.knowledge_base_article_knowledge_base_category_id_seq OWNER TO postgres;

--
-- TOC entry 4381 (class 0 OID 0)
-- Dependencies: 281
-- Name: knowledge_base_article_knowledge_base_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.knowledge_base_article_knowledge_base_category_id_seq OWNED BY public.knowledge_base_article_knowledge_base_category.id;


--
-- TOC entry 284 (class 1259 OID 22344)
-- Name: knowledge_base_article_portal; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.knowledge_base_article_portal (
    id bigint NOT NULL,
    portal_id character varying(24),
    knowledge_base_article_id character varying(24),
    deleted boolean DEFAULT false
);


ALTER TABLE public.knowledge_base_article_portal OWNER TO postgres;

--
-- TOC entry 283 (class 1259 OID 22342)
-- Name: knowledge_base_article_portal_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.knowledge_base_article_portal_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.knowledge_base_article_portal_id_seq OWNER TO postgres;

--
-- TOC entry 4382 (class 0 OID 0)
-- Dependencies: 283
-- Name: knowledge_base_article_portal_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.knowledge_base_article_portal_id_seq OWNED BY public.knowledge_base_article_portal.id;


--
-- TOC entry 285 (class 1259 OID 22349)
-- Name: knowledge_base_category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.knowledge_base_category (
    id character varying(24) NOT NULL,
    name character varying(255),
    deleted boolean DEFAULT false,
    description text,
    created_at timestamp with time zone,
    modified_at timestamp with time zone,
    "order" bigint,
    created_by_id character varying(24),
    modified_by_id character varying(24),
    parent_id character varying(24)
);


ALTER TABLE public.knowledge_base_category OWNER TO postgres;

--
-- TOC entry 287 (class 1259 OID 22358)
-- Name: knowledge_base_category_path; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.knowledge_base_category_path (
    id bigint NOT NULL,
    ascendor_id character varying(100),
    descendor_id character varying(24)
);


ALTER TABLE public.knowledge_base_category_path OWNER TO postgres;

--
-- TOC entry 286 (class 1259 OID 22356)
-- Name: knowledge_base_category_path_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.knowledge_base_category_path_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.knowledge_base_category_path_id_seq OWNER TO postgres;

--
-- TOC entry 4383 (class 0 OID 0)
-- Dependencies: 286
-- Name: knowledge_base_category_path_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.knowledge_base_category_path_id_seq OWNED BY public.knowledge_base_category_path.id;


--
-- TOC entry 288 (class 1259 OID 22362)
-- Name: lead; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lead (
    id character varying(24) NOT NULL,
    deleted boolean DEFAULT false,
    salutation_name character varying(255),
    first_name character varying(100) DEFAULT ''::character varying,
    last_name character varying(100) DEFAULT ''::character varying,
    title character varying(100),
    status character varying(255) DEFAULT 'New'::character varying,
    source character varying(255) DEFAULT ''::character varying,
    industry character varying(255) DEFAULT ''::character varying,
    opportunity_amount double precision,
    website character varying(255),
    address_street character varying(255),
    address_city character varying(255),
    address_state character varying(255),
    address_country character varying(255),
    address_postal_code character varying(255),
    do_not_call boolean DEFAULT false NOT NULL,
    description text,
    created_at timestamp with time zone,
    modified_at timestamp with time zone,
    account_name character varying(255),
    opportunity_amount_currency character varying(255),
    created_by_id character varying(24),
    modified_by_id character varying(24),
    assigned_user_id character varying(24),
    campaign_id character varying(24),
    created_account_id character varying(24),
    created_contact_id character varying(24),
    created_opportunity_id character varying(24)
);


ALTER TABLE public.lead OWNER TO postgres;

--
-- TOC entry 290 (class 1259 OID 22377)
-- Name: lead_meeting; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lead_meeting (
    id bigint NOT NULL,
    lead_id character varying(24),
    meeting_id character varying(24),
    status character varying(36) DEFAULT 'None'::character varying,
    deleted boolean DEFAULT false
);


ALTER TABLE public.lead_meeting OWNER TO postgres;

--
-- TOC entry 289 (class 1259 OID 22375)
-- Name: lead_meeting_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.lead_meeting_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lead_meeting_id_seq OWNER TO postgres;

--
-- TOC entry 4384 (class 0 OID 0)
-- Dependencies: 289
-- Name: lead_meeting_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.lead_meeting_id_seq OWNED BY public.lead_meeting.id;


--
-- TOC entry 292 (class 1259 OID 22385)
-- Name: lead_target_list; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lead_target_list (
    id bigint NOT NULL,
    lead_id character varying(24),
    target_list_id character varying(24),
    opted_out boolean DEFAULT false,
    deleted boolean DEFAULT false
);


ALTER TABLE public.lead_target_list OWNER TO postgres;

--
-- TOC entry 291 (class 1259 OID 22383)
-- Name: lead_target_list_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.lead_target_list_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lead_target_list_id_seq OWNER TO postgres;

--
-- TOC entry 4385 (class 0 OID 0)
-- Dependencies: 291
-- Name: lead_target_list_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.lead_target_list_id_seq OWNED BY public.lead_target_list.id;


--
-- TOC entry 293 (class 1259 OID 22391)
-- Name: mass_email; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mass_email (
    id character varying(24) NOT NULL,
    name character varying(255),
    deleted boolean DEFAULT false,
    status character varying(255) DEFAULT 'Pending'::character varying,
    store_sent_emails boolean DEFAULT false NOT NULL,
    opt_out_entirely boolean DEFAULT false NOT NULL,
    from_address character varying(255),
    from_name character varying(255),
    reply_to_address character varying(255),
    reply_to_name character varying(255),
    start_at timestamp with time zone,
    created_at timestamp with time zone,
    modified_at timestamp with time zone,
    email_template_id character varying(24),
    campaign_id character varying(24),
    inbound_email_id character varying(24),
    created_by_id character varying(24),
    modified_by_id character varying(24)
);


ALTER TABLE public.mass_email OWNER TO postgres;

--
-- TOC entry 295 (class 1259 OID 22403)
-- Name: mass_email_target_list; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mass_email_target_list (
    id bigint NOT NULL,
    mass_email_id character varying(24),
    target_list_id character varying(24),
    deleted boolean DEFAULT false
);


ALTER TABLE public.mass_email_target_list OWNER TO postgres;

--
-- TOC entry 297 (class 1259 OID 22410)
-- Name: mass_email_target_list_excluding; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mass_email_target_list_excluding (
    id bigint NOT NULL,
    mass_email_id character varying(24),
    target_list_id character varying(24),
    deleted boolean DEFAULT false
);


ALTER TABLE public.mass_email_target_list_excluding OWNER TO postgres;

--
-- TOC entry 296 (class 1259 OID 22408)
-- Name: mass_email_target_list_excluding_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.mass_email_target_list_excluding_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.mass_email_target_list_excluding_id_seq OWNER TO postgres;

--
-- TOC entry 4386 (class 0 OID 0)
-- Dependencies: 296
-- Name: mass_email_target_list_excluding_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.mass_email_target_list_excluding_id_seq OWNED BY public.mass_email_target_list_excluding.id;


--
-- TOC entry 294 (class 1259 OID 22401)
-- Name: mass_email_target_list_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.mass_email_target_list_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.mass_email_target_list_id_seq OWNER TO postgres;

--
-- TOC entry 4387 (class 0 OID 0)
-- Dependencies: 294
-- Name: mass_email_target_list_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.mass_email_target_list_id_seq OWNED BY public.mass_email_target_list.id;


--
-- TOC entry 298 (class 1259 OID 22415)
-- Name: meeting; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.meeting (
    id character varying(24) NOT NULL,
    name character varying(255),
    deleted boolean DEFAULT false,
    status character varying(255) DEFAULT 'Planned'::character varying,
    date_start timestamp with time zone,
    date_end timestamp with time zone,
    description text,
    created_at timestamp with time zone,
    modified_at timestamp with time zone,
    parent_id character varying(24),
    parent_type character varying(100),
    account_id character varying(24),
    created_by_id character varying(24),
    modified_by_id character varying(24),
    assigned_user_id character varying(24)
);


ALTER TABLE public.meeting OWNER TO postgres;

--
-- TOC entry 300 (class 1259 OID 22425)
-- Name: meeting_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.meeting_user (
    id bigint NOT NULL,
    user_id character varying(24),
    meeting_id character varying(24),
    status character varying(36) DEFAULT 'None'::character varying,
    deleted boolean DEFAULT false
);


ALTER TABLE public.meeting_user OWNER TO postgres;

--
-- TOC entry 299 (class 1259 OID 22423)
-- Name: meeting_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.meeting_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.meeting_user_id_seq OWNER TO postgres;

--
-- TOC entry 4388 (class 0 OID 0)
-- Dependencies: 299
-- Name: meeting_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.meeting_user_id_seq OWNED BY public.meeting_user.id;


--
-- TOC entry 301 (class 1259 OID 22431)
-- Name: next_number; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.next_number (
    id character varying(24) NOT NULL,
    deleted boolean DEFAULT false,
    entity_type character varying(255),
    field_name character varying(255),
    value bigint DEFAULT '1'::bigint
);


ALTER TABLE public.next_number OWNER TO postgres;

--
-- TOC entry 303 (class 1259 OID 22441)
-- Name: note; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.note (
    id character varying(24) NOT NULL,
    deleted boolean DEFAULT false,
    post text,
    data text,
    type character varying(255),
    target_type character varying(255),
    number bigint NOT NULL,
    is_global boolean DEFAULT false NOT NULL,
    is_internal boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone,
    modified_at timestamp with time zone,
    parent_id character varying(24),
    parent_type character varying(100),
    related_id character varying(24),
    related_type character varying(100),
    created_by_id character varying(24),
    modified_by_id character varying(24),
    super_parent_id character varying(24),
    super_parent_type character varying(100)
);


ALTER TABLE public.note OWNER TO postgres;

--
-- TOC entry 302 (class 1259 OID 22439)
-- Name: note_number_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.note_number_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.note_number_seq OWNER TO postgres;

--
-- TOC entry 4389 (class 0 OID 0)
-- Dependencies: 302
-- Name: note_number_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.note_number_seq OWNED BY public.note.number;


--
-- TOC entry 305 (class 1259 OID 22453)
-- Name: note_portal; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.note_portal (
    id bigint NOT NULL,
    note_id character varying(24),
    portal_id character varying(24),
    deleted boolean DEFAULT false
);


ALTER TABLE public.note_portal OWNER TO postgres;

--
-- TOC entry 304 (class 1259 OID 22451)
-- Name: note_portal_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.note_portal_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.note_portal_id_seq OWNER TO postgres;

--
-- TOC entry 4390 (class 0 OID 0)
-- Dependencies: 304
-- Name: note_portal_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.note_portal_id_seq OWNED BY public.note_portal.id;


--
-- TOC entry 307 (class 1259 OID 22460)
-- Name: note_team; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.note_team (
    id bigint NOT NULL,
    note_id character varying(24),
    team_id character varying(24),
    deleted boolean DEFAULT false
);


ALTER TABLE public.note_team OWNER TO postgres;

--
-- TOC entry 306 (class 1259 OID 22458)
-- Name: note_team_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.note_team_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.note_team_id_seq OWNER TO postgres;

--
-- TOC entry 4391 (class 0 OID 0)
-- Dependencies: 306
-- Name: note_team_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.note_team_id_seq OWNED BY public.note_team.id;


--
-- TOC entry 309 (class 1259 OID 22467)
-- Name: note_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.note_user (
    id bigint NOT NULL,
    note_id character varying(24),
    user_id character varying(24),
    deleted boolean DEFAULT false
);


ALTER TABLE public.note_user OWNER TO postgres;

--
-- TOC entry 308 (class 1259 OID 22465)
-- Name: note_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.note_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.note_user_id_seq OWNER TO postgres;

--
-- TOC entry 4392 (class 0 OID 0)
-- Dependencies: 308
-- Name: note_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.note_user_id_seq OWNED BY public.note_user.id;


--
-- TOC entry 311 (class 1259 OID 22474)
-- Name: notification; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notification (
    id character varying(24) NOT NULL,
    deleted boolean DEFAULT false,
    number bigint NOT NULL,
    data text,
    type character varying(255),
    read boolean DEFAULT false NOT NULL,
    email_is_processed boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone,
    message text,
    user_id character varying(24),
    related_id character varying(24),
    related_type character varying(100),
    related_parent_id character varying(24),
    related_parent_type character varying(100)
);


ALTER TABLE public.notification OWNER TO postgres;

--
-- TOC entry 310 (class 1259 OID 22472)
-- Name: notification_number_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.notification_number_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.notification_number_seq OWNER TO postgres;

--
-- TOC entry 4393 (class 0 OID 0)
-- Dependencies: 310
-- Name: notification_number_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.notification_number_seq OWNED BY public.notification.number;


--
-- TOC entry 312 (class 1259 OID 22484)
-- Name: opportunity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.opportunity (
    id character varying(24) NOT NULL,
    name character varying(255),
    deleted boolean DEFAULT false,
    amount double precision,
    stage character varying(255) DEFAULT 'Prospecting'::character varying,
    probability bigint,
    lead_source character varying(255) DEFAULT ''::character varying,
    close_date date,
    description text,
    created_at timestamp with time zone,
    modified_at timestamp with time zone,
    amount_currency character varying(255),
    account_id character varying(24),
    campaign_id character varying(24),
    created_by_id character varying(24),
    modified_by_id character varying(24),
    assigned_user_id character varying(24)
);


ALTER TABLE public.opportunity OWNER TO postgres;

--
-- TOC entry 313 (class 1259 OID 22493)
-- Name: password_change_request; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.password_change_request (
    id character varying(24) NOT NULL,
    deleted boolean DEFAULT false,
    request_id character varying(24),
    url character varying(255),
    created_at timestamp with time zone,
    user_id character varying(24)
);


ALTER TABLE public.password_change_request OWNER TO postgres;

--
-- TOC entry 314 (class 1259 OID 22497)
-- Name: phone_number; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.phone_number (
    id character varying(24) NOT NULL,
    name character varying(36),
    deleted boolean DEFAULT false,
    type character varying(255)
);


ALTER TABLE public.phone_number OWNER TO postgres;

--
-- TOC entry 315 (class 1259 OID 22501)
-- Name: portal; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.portal (
    id character varying(24) NOT NULL,
    name character varying(100),
    deleted boolean DEFAULT false,
    custom_id character varying(36),
    is_active boolean DEFAULT true NOT NULL,
    tab_list text,
    quick_create_list text,
    theme character varying(255) DEFAULT ''::character varying,
    language character varying(255) DEFAULT ''::character varying,
    time_zone character varying(255),
    date_format character varying(255) DEFAULT ''::character varying,
    time_format character varying(255) DEFAULT ''::character varying,
    week_start bigint DEFAULT '-1'::bigint,
    default_currency character varying(255) DEFAULT ''::character varying,
    dashboard_layout text,
    dashlets_options text,
    custom_url character varying(255),
    modified_at timestamp with time zone,
    created_at timestamp with time zone,
    modified_by_id character varying(24),
    created_by_id character varying(24),
    logo_id character varying(24),
    company_logo_id character varying(24)
);


ALTER TABLE public.portal OWNER TO postgres;

--
-- TOC entry 317 (class 1259 OID 22517)
-- Name: portal_portal_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.portal_portal_role (
    id bigint NOT NULL,
    portal_id character varying(24),
    portal_role_id character varying(24),
    deleted boolean DEFAULT false
);


ALTER TABLE public.portal_portal_role OWNER TO postgres;

--
-- TOC entry 316 (class 1259 OID 22515)
-- Name: portal_portal_role_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.portal_portal_role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.portal_portal_role_id_seq OWNER TO postgres;

--
-- TOC entry 4394 (class 0 OID 0)
-- Dependencies: 316
-- Name: portal_portal_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.portal_portal_role_id_seq OWNED BY public.portal_portal_role.id;


--
-- TOC entry 318 (class 1259 OID 22522)
-- Name: portal_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.portal_role (
    id character varying(24) NOT NULL,
    name character varying(150),
    deleted boolean DEFAULT false,
    data text,
    field_data text
);


ALTER TABLE public.portal_role OWNER TO postgres;

--
-- TOC entry 320 (class 1259 OID 22531)
-- Name: portal_role_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.portal_role_user (
    id bigint NOT NULL,
    portal_role_id character varying(24),
    user_id character varying(24),
    deleted boolean DEFAULT false
);


ALTER TABLE public.portal_role_user OWNER TO postgres;

--
-- TOC entry 319 (class 1259 OID 22529)
-- Name: portal_role_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.portal_role_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.portal_role_user_id_seq OWNER TO postgres;

--
-- TOC entry 4395 (class 0 OID 0)
-- Dependencies: 319
-- Name: portal_role_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.portal_role_user_id_seq OWNED BY public.portal_role_user.id;


--
-- TOC entry 322 (class 1259 OID 22538)
-- Name: portal_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.portal_user (
    id bigint NOT NULL,
    portal_id character varying(24),
    user_id character varying(24),
    deleted boolean DEFAULT false
);


ALTER TABLE public.portal_user OWNER TO postgres;

--
-- TOC entry 321 (class 1259 OID 22536)
-- Name: portal_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.portal_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.portal_user_id_seq OWNER TO postgres;

--
-- TOC entry 4396 (class 0 OID 0)
-- Dependencies: 321
-- Name: portal_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.portal_user_id_seq OWNED BY public.portal_user.id;


--
-- TOC entry 323 (class 1259 OID 22543)
-- Name: preferences; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.preferences (
    id character varying(24) NOT NULL,
    deleted boolean DEFAULT false,
    time_zone character varying(255),
    date_format character varying(255) DEFAULT ''::character varying,
    time_format character varying(255) DEFAULT ''::character varying,
    week_start bigint DEFAULT '-1'::bigint,
    default_currency character varying(255) DEFAULT ''::character varying,
    thousand_separator character varying(1) DEFAULT ','::character varying,
    decimal_mark character varying(1) DEFAULT '.'::character varying,
    dashboard_layout text,
    dashlets_options text,
    shared_calendar_user_list text,
    preset_filters text,
    smtp_server character varying(255),
    smtp_port bigint DEFAULT '25'::bigint,
    smtp_auth boolean DEFAULT false NOT NULL,
    smtp_security character varying(255),
    smtp_username character varying(255),
    smtp_password character varying(255),
    language character varying(255) DEFAULT ''::character varying,
    export_delimiter character varying(1) DEFAULT ','::character varying,
    receive_assignment_email_notifications boolean DEFAULT true NOT NULL,
    receive_mention_email_notifications boolean DEFAULT true NOT NULL,
    receive_stream_email_notifications boolean DEFAULT true NOT NULL,
    signature text,
    default_reminders text,
    theme character varying(255),
    use_custom_tab_list boolean DEFAULT false NOT NULL,
    tab_list text,
    email_reply_to_all_by_default boolean DEFAULT true NOT NULL,
    email_reply_force_html boolean DEFAULT false NOT NULL,
    do_not_fill_assigned_user_if_not_required boolean DEFAULT false NOT NULL
);


ALTER TABLE public.preferences OWNER TO postgres;

--
-- TOC entry 324 (class 1259 OID 22567)
-- Name: reminder; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reminder (
    id character varying(24) NOT NULL,
    deleted boolean DEFAULT false,
    remind_at timestamp with time zone,
    start_at timestamp with time zone,
    type character varying(36) DEFAULT 'Popup'::character varying,
    seconds bigint DEFAULT '0'::bigint,
    entity_type character varying(100),
    entity_id character varying(50),
    user_id character varying(50)
);


ALTER TABLE public.reminder OWNER TO postgres;

--
-- TOC entry 325 (class 1259 OID 22573)
-- Name: role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role (
    id character varying(24) NOT NULL,
    name character varying(150),
    deleted boolean DEFAULT false,
    assignment_permission character varying(255) DEFAULT 'not-set'::character varying,
    user_permission character varying(255) DEFAULT 'not-set'::character varying,
    portal_permission character varying(255) DEFAULT 'not-set'::character varying,
    data text,
    field_data text
);


ALTER TABLE public.role OWNER TO postgres;

--
-- TOC entry 327 (class 1259 OID 22585)
-- Name: role_team; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role_team (
    id bigint NOT NULL,
    role_id character varying(24),
    team_id character varying(24),
    deleted boolean DEFAULT false
);


ALTER TABLE public.role_team OWNER TO postgres;

--
-- TOC entry 326 (class 1259 OID 22583)
-- Name: role_team_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.role_team_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.role_team_id_seq OWNER TO postgres;

--
-- TOC entry 4397 (class 0 OID 0)
-- Dependencies: 326
-- Name: role_team_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.role_team_id_seq OWNED BY public.role_team.id;


--
-- TOC entry 329 (class 1259 OID 22592)
-- Name: role_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role_user (
    id bigint NOT NULL,
    role_id character varying(24),
    user_id character varying(24),
    deleted boolean DEFAULT false
);


ALTER TABLE public.role_user OWNER TO postgres;

--
-- TOC entry 328 (class 1259 OID 22590)
-- Name: role_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.role_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.role_user_id_seq OWNER TO postgres;

--
-- TOC entry 4398 (class 0 OID 0)
-- Dependencies: 328
-- Name: role_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.role_user_id_seq OWNED BY public.role_user.id;


--
-- TOC entry 330 (class 1259 OID 22597)
-- Name: scheduled_job; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scheduled_job (
    id character varying(24) NOT NULL,
    name character varying(255),
    deleted boolean DEFAULT false,
    job character varying(255),
    status character varying(255),
    scheduling character varying(255),
    last_run timestamp with time zone,
    created_at timestamp with time zone,
    modified_at timestamp with time zone,
    created_by_id character varying(24),
    modified_by_id character varying(24)
);


ALTER TABLE public.scheduled_job OWNER TO postgres;

--
-- TOC entry 331 (class 1259 OID 22604)
-- Name: scheduled_job_log_record; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scheduled_job_log_record (
    id character varying(24) NOT NULL,
    name character varying(255),
    deleted boolean DEFAULT false,
    status character varying(255),
    execution_time timestamp with time zone,
    created_at timestamp with time zone,
    scheduled_job_id character varying(24),
    target_id character varying(24),
    target_type character varying(255)
);


ALTER TABLE public.scheduled_job_log_record OWNER TO postgres;

--
-- TOC entry 333 (class 1259 OID 22613)
-- Name: subscription; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.subscription (
    id bigint NOT NULL,
    entity_id character varying(24),
    entity_type character varying(100),
    user_id character varying(24)
);


ALTER TABLE public.subscription OWNER TO postgres;

--
-- TOC entry 332 (class 1259 OID 22611)
-- Name: subscription_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.subscription_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.subscription_id_seq OWNER TO postgres;

--
-- TOC entry 4399 (class 0 OID 0)
-- Dependencies: 332
-- Name: subscription_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.subscription_id_seq OWNED BY public.subscription.id;


--
-- TOC entry 334 (class 1259 OID 22617)
-- Name: target; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.target (
    id character varying(24) NOT NULL,
    deleted boolean DEFAULT false,
    salutation_name character varying(255),
    first_name character varying(100) DEFAULT ''::character varying,
    last_name character varying(100) DEFAULT ''::character varying,
    title character varying(100),
    account_name character varying(100),
    website character varying(255),
    address_street character varying(255),
    address_city character varying(255),
    address_state character varying(255),
    address_country character varying(255),
    address_postal_code character varying(255),
    do_not_call boolean DEFAULT false NOT NULL,
    description text,
    created_at timestamp with time zone,
    modified_at timestamp with time zone,
    created_by_id character varying(24),
    modified_by_id character varying(24),
    assigned_user_id character varying(24)
);


ALTER TABLE public.target OWNER TO postgres;

--
-- TOC entry 335 (class 1259 OID 22627)
-- Name: target_list; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.target_list (
    id character varying(24) NOT NULL,
    name character varying(255),
    deleted boolean DEFAULT false,
    description text,
    created_at timestamp with time zone,
    modified_at timestamp with time zone,
    created_by_id character varying(24),
    modified_by_id character varying(24),
    assigned_user_id character varying(24),
    campaigns_id character varying(24)
);


ALTER TABLE public.target_list OWNER TO postgres;

--
-- TOC entry 337 (class 1259 OID 22636)
-- Name: target_list_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.target_list_user (
    id bigint NOT NULL,
    user_id character varying(24),
    target_list_id character varying(24),
    opted_out boolean DEFAULT false,
    deleted boolean DEFAULT false
);


ALTER TABLE public.target_list_user OWNER TO postgres;

--
-- TOC entry 336 (class 1259 OID 22634)
-- Name: target_list_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.target_list_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.target_list_user_id_seq OWNER TO postgres;

--
-- TOC entry 4400 (class 0 OID 0)
-- Dependencies: 336
-- Name: target_list_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.target_list_user_id_seq OWNED BY public.target_list_user.id;


--
-- TOC entry 338 (class 1259 OID 22642)
-- Name: task; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.task (
    id character varying(24) NOT NULL,
    name character varying(255),
    deleted boolean DEFAULT false,
    status character varying(255) DEFAULT 'Not Started'::character varying,
    priority character varying(255) DEFAULT 'Normal'::character varying,
    date_start timestamp with time zone,
    date_end timestamp with time zone,
    date_start_date date,
    date_end_date date,
    date_completed timestamp with time zone,
    description text,
    created_at timestamp with time zone,
    modified_at timestamp with time zone,
    parent_id character varying(24),
    parent_type character varying(100),
    account_id character varying(24),
    created_by_id character varying(24),
    modified_by_id character varying(24),
    assigned_user_id character varying(24)
);


ALTER TABLE public.task OWNER TO postgres;

--
-- TOC entry 339 (class 1259 OID 22651)
-- Name: team; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.team (
    id character varying(24) NOT NULL,
    name character varying(100),
    deleted boolean DEFAULT false,
    position_list text,
    created_at timestamp with time zone
);


ALTER TABLE public.team OWNER TO postgres;

--
-- TOC entry 341 (class 1259 OID 22660)
-- Name: team_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.team_user (
    id bigint NOT NULL,
    team_id character varying(24),
    user_id character varying(24),
    role character varying(100),
    deleted boolean DEFAULT false
);


ALTER TABLE public.team_user OWNER TO postgres;

--
-- TOC entry 340 (class 1259 OID 22658)
-- Name: team_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.team_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.team_user_id_seq OWNER TO postgres;

--
-- TOC entry 4401 (class 0 OID 0)
-- Dependencies: 340
-- Name: team_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.team_user_id_seq OWNED BY public.team_user.id;


--
-- TOC entry 342 (class 1259 OID 22665)
-- Name: template; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.template (
    id character varying(24) NOT NULL,
    name character varying(255),
    deleted boolean DEFAULT false,
    body text,
    header text,
    footer text,
    entity_type character varying(255),
    left_margin double precision DEFAULT '10'::double precision,
    right_margin double precision DEFAULT '10'::double precision,
    top_margin double precision DEFAULT '10'::double precision,
    bottom_margin double precision DEFAULT '25'::double precision,
    print_footer boolean DEFAULT false NOT NULL,
    footer_position double precision DEFAULT '15'::double precision,
    created_at timestamp with time zone,
    modified_at timestamp with time zone,
    created_by_id character varying(24),
    modified_by_id character varying(24)
);


ALTER TABLE public.template OWNER TO postgres;

--
-- TOC entry 343 (class 1259 OID 22678)
-- Name: unique_id; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.unique_id (
    id character varying(24) NOT NULL,
    name character varying(255),
    deleted boolean DEFAULT false,
    data text,
    created_at timestamp with time zone,
    created_by_id character varying(24)
);


ALTER TABLE public.unique_id OWNER TO postgres;

--
-- TOC entry 344 (class 1259 OID 22685)
-- Name: user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."user" (
    id character varying(24) NOT NULL,
    deleted boolean DEFAULT false,
    is_admin boolean DEFAULT false NOT NULL,
    user_name character varying(50),
    password character varying(150),
    salutation_name character varying(255),
    first_name character varying(100) DEFAULT ''::character varying,
    last_name character varying(100) DEFAULT ''::character varying,
    is_active boolean DEFAULT true NOT NULL,
    is_portal_user boolean DEFAULT false NOT NULL,
    is_super_admin boolean DEFAULT false NOT NULL,
    title character varying(100),
    gender character varying(255) DEFAULT ''::character varying,
    created_at timestamp with time zone,
    default_team_id character varying(24),
    contact_id character varying(24),
    avatar_id character varying(24)
);


ALTER TABLE public."user" OWNER TO postgres;

--
-- TOC entry 3256 (class 2604 OID 21915)
-- Name: account_contact id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_contact ALTER COLUMN id SET DEFAULT nextval('public.account_contact_id_seq'::regclass);


--
-- TOC entry 3258 (class 2604 OID 21922)
-- Name: account_document id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_document ALTER COLUMN id SET DEFAULT nextval('public.account_document_id_seq'::regclass);


--
-- TOC entry 3260 (class 2604 OID 21929)
-- Name: account_portal_user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_portal_user ALTER COLUMN id SET DEFAULT nextval('public.account_portal_user_id_seq'::regclass);


--
-- TOC entry 3262 (class 2604 OID 21936)
-- Name: account_target_list id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_target_list ALTER COLUMN id SET DEFAULT nextval('public.account_target_list_id_seq'::regclass);


--
-- TOC entry 3268 (class 2604 OID 21956)
-- Name: autofollow id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.autofollow ALTER COLUMN id SET DEFAULT nextval('public.autofollow_id_seq'::regclass);


--
-- TOC entry 3272 (class 2604 OID 21971)
-- Name: call_contact id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.call_contact ALTER COLUMN id SET DEFAULT nextval('public.call_contact_id_seq'::regclass);


--
-- TOC entry 3275 (class 2604 OID 21979)
-- Name: call_lead id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.call_lead ALTER COLUMN id SET DEFAULT nextval('public.call_lead_id_seq'::regclass);


--
-- TOC entry 3278 (class 2604 OID 21987)
-- Name: call_user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.call_user ALTER COLUMN id SET DEFAULT nextval('public.call_user_id_seq'::regclass);


--
-- TOC entry 3287 (class 2604 OID 22013)
-- Name: campaign_target_list id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.campaign_target_list ALTER COLUMN id SET DEFAULT nextval('public.campaign_target_list_id_seq'::regclass);


--
-- TOC entry 3289 (class 2604 OID 22020)
-- Name: campaign_target_list_excluding id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.campaign_target_list_excluding ALTER COLUMN id SET DEFAULT nextval('public.campaign_target_list_excluding_id_seq'::regclass);


--
-- TOC entry 3293 (class 2604 OID 22035)
-- Name: case number; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."case" ALTER COLUMN number SET DEFAULT nextval('public.case_number_seq'::regclass);


--
-- TOC entry 3297 (class 2604 OID 22047)
-- Name: case_contact id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.case_contact ALTER COLUMN id SET DEFAULT nextval('public.case_contact_id_seq'::regclass);


--
-- TOC entry 3299 (class 2604 OID 22054)
-- Name: case_knowledge_base_article id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.case_knowledge_base_article ALTER COLUMN id SET DEFAULT nextval('public.case_knowledge_base_article_id_seq'::regclass);


--
-- TOC entry 3305 (class 2604 OID 22071)
-- Name: contact_document id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contact_document ALTER COLUMN id SET DEFAULT nextval('public.contact_document_id_seq'::regclass);


--
-- TOC entry 3307 (class 2604 OID 22078)
-- Name: contact_meeting id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contact_meeting ALTER COLUMN id SET DEFAULT nextval('public.contact_meeting_id_seq'::regclass);


--
-- TOC entry 3310 (class 2604 OID 22086)
-- Name: contact_opportunity id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contact_opportunity ALTER COLUMN id SET DEFAULT nextval('public.contact_opportunity_id_seq'::regclass);


--
-- TOC entry 3312 (class 2604 OID 22093)
-- Name: contact_target_list id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contact_target_list ALTER COLUMN id SET DEFAULT nextval('public.contact_target_list_id_seq'::regclass);


--
-- TOC entry 3319 (class 2604 OID 22120)
-- Name: document_folder_path id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.document_folder_path ALTER COLUMN id SET DEFAULT nextval('public.document_folder_path_id_seq'::regclass);


--
-- TOC entry 3320 (class 2604 OID 22126)
-- Name: document_lead id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.document_lead ALTER COLUMN id SET DEFAULT nextval('public.document_lead_id_seq'::regclass);


--
-- TOC entry 3322 (class 2604 OID 22133)
-- Name: document_opportunity id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.document_opportunity ALTER COLUMN id SET DEFAULT nextval('public.document_opportunity_id_seq'::regclass);


--
-- TOC entry 3343 (class 2604 OID 22176)
-- Name: email_email_account id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.email_email_account ALTER COLUMN id SET DEFAULT nextval('public.email_email_account_id_seq'::regclass);


--
-- TOC entry 3344 (class 2604 OID 22183)
-- Name: email_email_address id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.email_email_address ALTER COLUMN id SET DEFAULT nextval('public.email_email_address_id_seq'::regclass);


--
-- TOC entry 3351 (class 2604 OID 22204)
-- Name: email_inbound_email id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.email_inbound_email ALTER COLUMN id SET DEFAULT nextval('public.email_inbound_email_id_seq'::regclass);


--
-- TOC entry 3359 (class 2604 OID 22229)
-- Name: email_user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.email_user ALTER COLUMN id SET DEFAULT nextval('public.email_user_id_seq'::regclass);


--
-- TOC entry 3364 (class 2604 OID 22239)
-- Name: entity_email_address id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entity_email_address ALTER COLUMN id SET DEFAULT nextval('public.entity_email_address_id_seq'::regclass);


--
-- TOC entry 3367 (class 2604 OID 22247)
-- Name: entity_phone_number id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entity_phone_number ALTER COLUMN id SET DEFAULT nextval('public.entity_phone_number_id_seq'::regclass);


--
-- TOC entry 3370 (class 2604 OID 22255)
-- Name: entity_team id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entity_team ALTER COLUMN id SET DEFAULT nextval('public.entity_team_id_seq'::regclass);


--
-- TOC entry 3372 (class 2604 OID 22262)
-- Name: entity_user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entity_user ALTER COLUMN id SET DEFAULT nextval('public.entity_user_id_seq'::regclass);


--
-- TOC entry 3379 (class 2604 OID 22292)
-- Name: import_entity id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.import_entity ALTER COLUMN id SET DEFAULT nextval('public.import_entity_id_seq'::regclass);


--
-- TOC entry 3398 (class 2604 OID 22340)
-- Name: knowledge_base_article_knowledge_base_category id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.knowledge_base_article_knowledge_base_category ALTER COLUMN id SET DEFAULT nextval('public.knowledge_base_article_knowledge_base_category_id_seq'::regclass);


--
-- TOC entry 3400 (class 2604 OID 22347)
-- Name: knowledge_base_article_portal id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.knowledge_base_article_portal ALTER COLUMN id SET DEFAULT nextval('public.knowledge_base_article_portal_id_seq'::regclass);


--
-- TOC entry 3403 (class 2604 OID 22361)
-- Name: knowledge_base_category_path id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.knowledge_base_category_path ALTER COLUMN id SET DEFAULT nextval('public.knowledge_base_category_path_id_seq'::regclass);


--
-- TOC entry 3411 (class 2604 OID 22380)
-- Name: lead_meeting id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lead_meeting ALTER COLUMN id SET DEFAULT nextval('public.lead_meeting_id_seq'::regclass);


--
-- TOC entry 3414 (class 2604 OID 22388)
-- Name: lead_target_list id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lead_target_list ALTER COLUMN id SET DEFAULT nextval('public.lead_target_list_id_seq'::regclass);


--
-- TOC entry 3421 (class 2604 OID 22406)
-- Name: mass_email_target_list id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mass_email_target_list ALTER COLUMN id SET DEFAULT nextval('public.mass_email_target_list_id_seq'::regclass);


--
-- TOC entry 3423 (class 2604 OID 22413)
-- Name: mass_email_target_list_excluding id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mass_email_target_list_excluding ALTER COLUMN id SET DEFAULT nextval('public.mass_email_target_list_excluding_id_seq'::regclass);


--
-- TOC entry 3427 (class 2604 OID 22428)
-- Name: meeting_user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.meeting_user ALTER COLUMN id SET DEFAULT nextval('public.meeting_user_id_seq'::regclass);


--
-- TOC entry 3433 (class 2604 OID 22445)
-- Name: note number; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.note ALTER COLUMN number SET DEFAULT nextval('public.note_number_seq'::regclass);


--
-- TOC entry 3436 (class 2604 OID 22456)
-- Name: note_portal id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.note_portal ALTER COLUMN id SET DEFAULT nextval('public.note_portal_id_seq'::regclass);


--
-- TOC entry 3438 (class 2604 OID 22463)
-- Name: note_team id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.note_team ALTER COLUMN id SET DEFAULT nextval('public.note_team_id_seq'::regclass);


--
-- TOC entry 3440 (class 2604 OID 22470)
-- Name: note_user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.note_user ALTER COLUMN id SET DEFAULT nextval('public.note_user_id_seq'::regclass);


--
-- TOC entry 3443 (class 2604 OID 22478)
-- Name: notification number; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification ALTER COLUMN number SET DEFAULT nextval('public.notification_number_seq'::regclass);


--
-- TOC entry 3459 (class 2604 OID 22520)
-- Name: portal_portal_role id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.portal_portal_role ALTER COLUMN id SET DEFAULT nextval('public.portal_portal_role_id_seq'::regclass);


--
-- TOC entry 3463 (class 2604 OID 22534)
-- Name: portal_role_user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.portal_role_user ALTER COLUMN id SET DEFAULT nextval('public.portal_role_user_id_seq'::regclass);


--
-- TOC entry 3464 (class 2604 OID 22541)
-- Name: portal_user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.portal_user ALTER COLUMN id SET DEFAULT nextval('public.portal_user_id_seq'::regclass);


--
-- TOC entry 3491 (class 2604 OID 22588)
-- Name: role_team id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_team ALTER COLUMN id SET DEFAULT nextval('public.role_team_id_seq'::regclass);


--
-- TOC entry 3493 (class 2604 OID 22595)
-- Name: role_user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_user ALTER COLUMN id SET DEFAULT nextval('public.role_user_id_seq'::regclass);


--
-- TOC entry 3497 (class 2604 OID 22616)
-- Name: subscription id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscription ALTER COLUMN id SET DEFAULT nextval('public.subscription_id_seq'::regclass);


--
-- TOC entry 3503 (class 2604 OID 22639)
-- Name: target_list_user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.target_list_user ALTER COLUMN id SET DEFAULT nextval('public.target_list_user_id_seq'::regclass);


--
-- TOC entry 3510 (class 2604 OID 22663)
-- Name: team_user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.team_user ALTER COLUMN id SET DEFAULT nextval('public.team_user_id_seq'::regclass);


--
-- TOC entry 4197 (class 0 OID 21901)
-- Dependencies: 198
-- Data for Name: account; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.account (id, name, deleted, website, type, industry, sic_code, billing_address_street, billing_address_city, billing_address_state, billing_address_country, billing_address_postal_code, shipping_address_street, shipping_address_city, shipping_address_state, shipping_address_country, shipping_address_postal_code, description, created_at, modified_at, campaign_id, created_by_id, modified_by_id, assigned_user_id) FROM stdin;
\.


--
-- TOC entry 4199 (class 0 OID 21912)
-- Dependencies: 200
-- Data for Name: account_contact; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.account_contact (id, account_id, contact_id, role, deleted) FROM stdin;
\.


--
-- TOC entry 4201 (class 0 OID 21919)
-- Dependencies: 202
-- Data for Name: account_document; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.account_document (id, account_id, document_id, deleted) FROM stdin;
\.


--
-- TOC entry 4203 (class 0 OID 21926)
-- Dependencies: 204
-- Data for Name: account_portal_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.account_portal_user (id, user_id, account_id, deleted) FROM stdin;
\.


--
-- TOC entry 4205 (class 0 OID 21933)
-- Dependencies: 206
-- Data for Name: account_target_list; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.account_target_list (id, account_id, target_list_id, opted_out, deleted) FROM stdin;
\.


--
-- TOC entry 4206 (class 0 OID 21939)
-- Dependencies: 207
-- Data for Name: attachment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.attachment (id, name, deleted, type, size, source_id, created_at, role, storage, global, parent_id, parent_type, related_id, related_type, created_by_id) FROM stdin;
\.


--
-- TOC entry 4207 (class 0 OID 21947)
-- Dependencies: 208
-- Data for Name: auth_token; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_token (id, deleted, token, hash, user_id, ip_address, last_access, created_at, modified_at, portal_id) FROM stdin;
\.


--
-- TOC entry 4209 (class 0 OID 21953)
-- Dependencies: 210
-- Data for Name: autofollow; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.autofollow (id, entity_type, user_id) FROM stdin;
\.


--
-- TOC entry 4210 (class 0 OID 21957)
-- Dependencies: 211
-- Data for Name: call; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.call (id, name, deleted, status, date_start, date_end, direction, description, created_at, modified_at, parent_id, parent_type, account_id, created_by_id, modified_by_id, assigned_user_id) FROM stdin;
\.


--
-- TOC entry 4212 (class 0 OID 21968)
-- Dependencies: 213
-- Data for Name: call_contact; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.call_contact (id, call_id, contact_id, status, deleted) FROM stdin;
\.


--
-- TOC entry 4214 (class 0 OID 21976)
-- Dependencies: 215
-- Data for Name: call_lead; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.call_lead (id, call_id, lead_id, status, deleted) FROM stdin;
\.


--
-- TOC entry 4216 (class 0 OID 21984)
-- Dependencies: 217
-- Data for Name: call_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.call_user (id, user_id, call_id, status, deleted) FROM stdin;
\.


--
-- TOC entry 4217 (class 0 OID 21990)
-- Dependencies: 218
-- Data for Name: campaign; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.campaign (id, name, deleted, status, type, start_date, end_date, description, created_at, modified_at, budget, budget_currency, created_by_id, modified_by_id, assigned_user_id) FROM stdin;
\.


--
-- TOC entry 4218 (class 0 OID 21999)
-- Dependencies: 219
-- Data for Name: campaign_log_record; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.campaign_log_record (id, deleted, action, action_date, data, string_data, string_additional_data, application, created_at, is_test, created_by_id, campaign_id, parent_id, parent_type, object_id, object_type, queue_item_id) FROM stdin;
\.


--
-- TOC entry 4220 (class 0 OID 22010)
-- Dependencies: 221
-- Data for Name: campaign_target_list; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.campaign_target_list (id, campaign_id, target_list_id, deleted) FROM stdin;
\.


--
-- TOC entry 4222 (class 0 OID 22017)
-- Dependencies: 223
-- Data for Name: campaign_target_list_excluding; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.campaign_target_list_excluding (id, campaign_id, target_list_id, deleted) FROM stdin;
\.


--
-- TOC entry 4223 (class 0 OID 22022)
-- Dependencies: 224
-- Data for Name: campaign_tracking_url; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.campaign_tracking_url (id, name, deleted, url, modified_at, created_at, campaign_id, modified_by_id, created_by_id) FROM stdin;
\.


--
-- TOC entry 4225 (class 0 OID 22031)
-- Dependencies: 226
-- Data for Name: case; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."case" (id, name, deleted, number, status, priority, type, description, created_at, modified_at, account_id, lead_id, contact_id, inbound_email_id, created_by_id, modified_by_id, assigned_user_id) FROM stdin;
\.


--
-- TOC entry 4227 (class 0 OID 22044)
-- Dependencies: 228
-- Data for Name: case_contact; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.case_contact (id, case_id, contact_id, deleted) FROM stdin;
\.


--
-- TOC entry 4229 (class 0 OID 22051)
-- Dependencies: 230
-- Data for Name: case_knowledge_base_article; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.case_knowledge_base_article (id, case_id, knowledge_base_article_id, deleted) FROM stdin;
\.


--
-- TOC entry 4230 (class 0 OID 22056)
-- Dependencies: 231
-- Data for Name: contact; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contact (id, deleted, salutation_name, first_name, last_name, account_id, description, do_not_call, address_street, address_city, address_state, address_country, address_postal_code, created_at, modified_at, campaign_id, created_by_id, modified_by_id, assigned_user_id) FROM stdin;
\.


--
-- TOC entry 4232 (class 0 OID 22068)
-- Dependencies: 233
-- Data for Name: contact_document; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contact_document (id, contact_id, document_id, deleted) FROM stdin;
\.


--
-- TOC entry 4234 (class 0 OID 22075)
-- Dependencies: 235
-- Data for Name: contact_meeting; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contact_meeting (id, contact_id, meeting_id, status, deleted) FROM stdin;
\.


--
-- TOC entry 4236 (class 0 OID 22083)
-- Dependencies: 237
-- Data for Name: contact_opportunity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contact_opportunity (id, contact_id, opportunity_id, role, deleted) FROM stdin;
\.


--
-- TOC entry 4238 (class 0 OID 22090)
-- Dependencies: 239
-- Data for Name: contact_target_list; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contact_target_list (id, contact_id, target_list_id, opted_out, deleted) FROM stdin;
\.


--
-- TOC entry 4239 (class 0 OID 22096)
-- Dependencies: 240
-- Data for Name: currency; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.currency (id, deleted, rate) FROM stdin;
\.


--
-- TOC entry 4240 (class 0 OID 22100)
-- Dependencies: 241
-- Data for Name: document; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.document (id, name, deleted, status, source, type, publish_date, expiration_date, description, created_at, modified_at, created_by_id, modified_by_id, assigned_user_id, folder_id, file_id) FROM stdin;
\.


--
-- TOC entry 4241 (class 0 OID 22108)
-- Dependencies: 242
-- Data for Name: document_folder; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.document_folder (id, name, deleted, description, created_at, modified_at, created_by_id, modified_by_id, parent_id) FROM stdin;
\.


--
-- TOC entry 4243 (class 0 OID 22117)
-- Dependencies: 244
-- Data for Name: document_folder_path; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.document_folder_path (id, ascendor_id, descendor_id) FROM stdin;
\.


--
-- TOC entry 4245 (class 0 OID 22123)
-- Dependencies: 246
-- Data for Name: document_lead; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.document_lead (id, document_id, lead_id, deleted) FROM stdin;
\.


--
-- TOC entry 4247 (class 0 OID 22130)
-- Dependencies: 248
-- Data for Name: document_opportunity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.document_opportunity (id, document_id, opportunity_id, deleted) FROM stdin;
\.


--
-- TOC entry 4248 (class 0 OID 22135)
-- Dependencies: 249
-- Data for Name: email; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.email (id, name, deleted, from_name, from_string, reply_to_string, is_replied, message_id, message_id_internal, body_plain, body, is_html, status, has_attachment, date_sent, delivery_date, created_at, modified_at, is_system, from_email_address_id, parent_id, parent_type, created_by_id, sent_by_id, modified_by_id, assigned_user_id, replied_id, account_id) FROM stdin;
\.


--
-- TOC entry 4249 (class 0 OID 22147)
-- Dependencies: 250
-- Data for Name: email_account; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.email_account (id, name, deleted, email_address, status, host, port, ssl, username, password, monitored_folders, sent_folder, store_sent_emails, keep_fetched_emails_unread, fetch_since, fetch_data, created_at, modified_at, use_smtp, smtp_host, smtp_port, smtp_auth, smtp_security, smtp_username, smtp_password, email_folder_id, assigned_user_id, created_by_id, modified_by_id) FROM stdin;
\.


--
-- TOC entry 4250 (class 0 OID 22162)
-- Dependencies: 251
-- Data for Name: email_address; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.email_address (id, name, deleted, lower, invalid, opt_out) FROM stdin;
\.


--
-- TOC entry 4252 (class 0 OID 22173)
-- Dependencies: 253
-- Data for Name: email_email_account; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.email_email_account (id, email_id, email_account_id, deleted) FROM stdin;
\.


--
-- TOC entry 4254 (class 0 OID 22180)
-- Dependencies: 255
-- Data for Name: email_email_address; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.email_email_address (id, email_id, email_address_id, address_type, deleted) FROM stdin;
\.


--
-- TOC entry 4255 (class 0 OID 22185)
-- Dependencies: 256
-- Data for Name: email_filter; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.email_filter (id, name, deleted, "from", "to", subject, body_contains, is_global, action, created_at, modified_at, parent_id, parent_type, email_folder_id, created_by_id, modified_by_id) FROM stdin;
\.


--
-- TOC entry 4256 (class 0 OID 22194)
-- Dependencies: 257
-- Data for Name: email_folder; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.email_folder (id, name, deleted, "order", skip_notifications, created_at, modified_at, assigned_user_id, created_by_id, modified_by_id) FROM stdin;
\.


--
-- TOC entry 4258 (class 0 OID 22201)
-- Dependencies: 259
-- Data for Name: email_inbound_email; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.email_inbound_email (id, email_id, inbound_email_id, deleted) FROM stdin;
\.


--
-- TOC entry 4259 (class 0 OID 22206)
-- Dependencies: 260
-- Data for Name: email_queue_item; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.email_queue_item (id, deleted, status, attempt_count, created_at, sent_at, email_address, is_test, mass_email_id, target_id, target_type) FROM stdin;
\.


--
-- TOC entry 4260 (class 0 OID 22215)
-- Dependencies: 261
-- Data for Name: email_template; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.email_template (id, name, deleted, subject, body, is_html, one_off, created_at, modified_at, assigned_user_id, created_by_id, modified_by_id) FROM stdin;
\.


--
-- TOC entry 4262 (class 0 OID 22226)
-- Dependencies: 263
-- Data for Name: email_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.email_user (id, email_id, user_id, is_read, is_important, in_trash, folder_id, deleted) FROM stdin;
\.


--
-- TOC entry 4264 (class 0 OID 22236)
-- Dependencies: 265
-- Data for Name: entity_email_address; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.entity_email_address (id, entity_id, email_address_id, entity_type, "primary", deleted) FROM stdin;
\.


--
-- TOC entry 4266 (class 0 OID 22244)
-- Dependencies: 267
-- Data for Name: entity_phone_number; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.entity_phone_number (id, entity_id, phone_number_id, entity_type, "primary", deleted) FROM stdin;
\.


--
-- TOC entry 4268 (class 0 OID 22252)
-- Dependencies: 269
-- Data for Name: entity_team; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.entity_team (id, entity_id, team_id, entity_type, deleted) FROM stdin;
\.


--
-- TOC entry 4270 (class 0 OID 22259)
-- Dependencies: 271
-- Data for Name: entity_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.entity_user (id, entity_id, user_id, entity_type, deleted) FROM stdin;
\.


--
-- TOC entry 4271 (class 0 OID 22264)
-- Dependencies: 272
-- Data for Name: extension; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.extension (id, name, deleted, version, file_list, description, is_installed, created_at, created_by_id) FROM stdin;
\.


--
-- TOC entry 4272 (class 0 OID 22272)
-- Dependencies: 273
-- Data for Name: external_account; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.external_account (id, deleted, data, enabled) FROM stdin;
\.


--
-- TOC entry 4273 (class 0 OID 22280)
-- Dependencies: 274
-- Data for Name: import; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.import (id, deleted, entity_type, status, created_at, created_by_id, file_id) FROM stdin;
\.


--
-- TOC entry 4275 (class 0 OID 22289)
-- Dependencies: 276
-- Data for Name: import_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.import_entity (id, entity_id, entity_type, import_id, is_imported, is_updated, is_duplicate) FROM stdin;
\.


--
-- TOC entry 4276 (class 0 OID 22296)
-- Dependencies: 277
-- Data for Name: inbound_email; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inbound_email (id, name, deleted, email_address, status, host, port, ssl, username, password, monitored_folders, fetch_since, fetch_data, add_all_team_users, create_case, case_distribution, target_user_position, reply, reply_from_address, reply_to_address, reply_from_name, created_at, modified_at, assign_to_user_id, team_id, reply_email_template_id, created_by_id, modified_by_id) FROM stdin;
\.


--
-- TOC entry 4277 (class 0 OID 22310)
-- Dependencies: 278
-- Data for Name: integration; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.integration (id, deleted, data, enabled) FROM stdin;
\.


--
-- TOC entry 4278 (class 0 OID 22318)
-- Dependencies: 279
-- Data for Name: job; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.job (id, name, deleted, status, execute_time, service_name, method, data, attempts, target_id, target_type, failed_attempts, created_at, modified_at, scheduled_job_id) FROM stdin;
\.


--
-- TOC entry 4279 (class 0 OID 22326)
-- Dependencies: 280
-- Data for Name: knowledge_base_article; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.knowledge_base_article (id, name, deleted, status, language, type, publish_date, expiration_date, "order", description, created_at, modified_at, body, created_by_id, modified_by_id, assigned_user_id) FROM stdin;
\.


--
-- TOC entry 4281 (class 0 OID 22337)
-- Dependencies: 282
-- Data for Name: knowledge_base_article_knowledge_base_category; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.knowledge_base_article_knowledge_base_category (id, knowledge_base_article_id, knowledge_base_category_id, deleted) FROM stdin;
\.


--
-- TOC entry 4283 (class 0 OID 22344)
-- Dependencies: 284
-- Data for Name: knowledge_base_article_portal; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.knowledge_base_article_portal (id, portal_id, knowledge_base_article_id, deleted) FROM stdin;
\.


--
-- TOC entry 4284 (class 0 OID 22349)
-- Dependencies: 285
-- Data for Name: knowledge_base_category; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.knowledge_base_category (id, name, deleted, description, created_at, modified_at, "order", created_by_id, modified_by_id, parent_id) FROM stdin;
\.


--
-- TOC entry 4286 (class 0 OID 22358)
-- Dependencies: 287
-- Data for Name: knowledge_base_category_path; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.knowledge_base_category_path (id, ascendor_id, descendor_id) FROM stdin;
\.


--
-- TOC entry 4287 (class 0 OID 22362)
-- Dependencies: 288
-- Data for Name: lead; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lead (id, deleted, salutation_name, first_name, last_name, title, status, source, industry, opportunity_amount, website, address_street, address_city, address_state, address_country, address_postal_code, do_not_call, description, created_at, modified_at, account_name, opportunity_amount_currency, created_by_id, modified_by_id, assigned_user_id, campaign_id, created_account_id, created_contact_id, created_opportunity_id) FROM stdin;
\.


--
-- TOC entry 4289 (class 0 OID 22377)
-- Dependencies: 290
-- Data for Name: lead_meeting; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lead_meeting (id, lead_id, meeting_id, status, deleted) FROM stdin;
\.


--
-- TOC entry 4291 (class 0 OID 22385)
-- Dependencies: 292
-- Data for Name: lead_target_list; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lead_target_list (id, lead_id, target_list_id, opted_out, deleted) FROM stdin;
\.


--
-- TOC entry 4292 (class 0 OID 22391)
-- Dependencies: 293
-- Data for Name: mass_email; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mass_email (id, name, deleted, status, store_sent_emails, opt_out_entirely, from_address, from_name, reply_to_address, reply_to_name, start_at, created_at, modified_at, email_template_id, campaign_id, inbound_email_id, created_by_id, modified_by_id) FROM stdin;
\.


--
-- TOC entry 4294 (class 0 OID 22403)
-- Dependencies: 295
-- Data for Name: mass_email_target_list; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mass_email_target_list (id, mass_email_id, target_list_id, deleted) FROM stdin;
\.


--
-- TOC entry 4296 (class 0 OID 22410)
-- Dependencies: 297
-- Data for Name: mass_email_target_list_excluding; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mass_email_target_list_excluding (id, mass_email_id, target_list_id, deleted) FROM stdin;
\.


--
-- TOC entry 4297 (class 0 OID 22415)
-- Dependencies: 298
-- Data for Name: meeting; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.meeting (id, name, deleted, status, date_start, date_end, description, created_at, modified_at, parent_id, parent_type, account_id, created_by_id, modified_by_id, assigned_user_id) FROM stdin;
\.


--
-- TOC entry 4299 (class 0 OID 22425)
-- Dependencies: 300
-- Data for Name: meeting_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.meeting_user (id, user_id, meeting_id, status, deleted) FROM stdin;
\.


--
-- TOC entry 4300 (class 0 OID 22431)
-- Dependencies: 301
-- Data for Name: next_number; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.next_number (id, deleted, entity_type, field_name, value) FROM stdin;
\.


--
-- TOC entry 4302 (class 0 OID 22441)
-- Dependencies: 303
-- Data for Name: note; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.note (id, deleted, post, data, type, target_type, number, is_global, is_internal, created_at, modified_at, parent_id, parent_type, related_id, related_type, created_by_id, modified_by_id, super_parent_id, super_parent_type) FROM stdin;
\.


--
-- TOC entry 4304 (class 0 OID 22453)
-- Dependencies: 305
-- Data for Name: note_portal; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.note_portal (id, note_id, portal_id, deleted) FROM stdin;
\.


--
-- TOC entry 4306 (class 0 OID 22460)
-- Dependencies: 307
-- Data for Name: note_team; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.note_team (id, note_id, team_id, deleted) FROM stdin;
\.


--
-- TOC entry 4308 (class 0 OID 22467)
-- Dependencies: 309
-- Data for Name: note_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.note_user (id, note_id, user_id, deleted) FROM stdin;
\.


--
-- TOC entry 4310 (class 0 OID 22474)
-- Dependencies: 311
-- Data for Name: notification; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notification (id, deleted, number, data, type, read, email_is_processed, created_at, message, user_id, related_id, related_type, related_parent_id, related_parent_type) FROM stdin;
\.


--
-- TOC entry 4311 (class 0 OID 22484)
-- Dependencies: 312
-- Data for Name: opportunity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.opportunity (id, name, deleted, amount, stage, probability, lead_source, close_date, description, created_at, modified_at, amount_currency, account_id, campaign_id, created_by_id, modified_by_id, assigned_user_id) FROM stdin;
\.


--
-- TOC entry 4312 (class 0 OID 22493)
-- Dependencies: 313
-- Data for Name: password_change_request; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.password_change_request (id, deleted, request_id, url, created_at, user_id) FROM stdin;
\.


--
-- TOC entry 4313 (class 0 OID 22497)
-- Dependencies: 314
-- Data for Name: phone_number; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.phone_number (id, name, deleted, type) FROM stdin;
\.


--
-- TOC entry 4314 (class 0 OID 22501)
-- Dependencies: 315
-- Data for Name: portal; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.portal (id, name, deleted, custom_id, is_active, tab_list, quick_create_list, theme, language, time_zone, date_format, time_format, week_start, default_currency, dashboard_layout, dashlets_options, custom_url, modified_at, created_at, modified_by_id, created_by_id, logo_id, company_logo_id) FROM stdin;
\.


--
-- TOC entry 4316 (class 0 OID 22517)
-- Dependencies: 317
-- Data for Name: portal_portal_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.portal_portal_role (id, portal_id, portal_role_id, deleted) FROM stdin;
\.


--
-- TOC entry 4317 (class 0 OID 22522)
-- Dependencies: 318
-- Data for Name: portal_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.portal_role (id, name, deleted, data, field_data) FROM stdin;
\.


--
-- TOC entry 4319 (class 0 OID 22531)
-- Dependencies: 320
-- Data for Name: portal_role_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.portal_role_user (id, portal_role_id, user_id, deleted) FROM stdin;
\.


--
-- TOC entry 4321 (class 0 OID 22538)
-- Dependencies: 322
-- Data for Name: portal_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.portal_user (id, portal_id, user_id, deleted) FROM stdin;
\.


--
-- TOC entry 4322 (class 0 OID 22543)
-- Dependencies: 323
-- Data for Name: preferences; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.preferences (id, deleted, time_zone, date_format, time_format, week_start, default_currency, thousand_separator, decimal_mark, dashboard_layout, dashlets_options, shared_calendar_user_list, preset_filters, smtp_server, smtp_port, smtp_auth, smtp_security, smtp_username, smtp_password, language, export_delimiter, receive_assignment_email_notifications, receive_mention_email_notifications, receive_stream_email_notifications, signature, default_reminders, theme, use_custom_tab_list, tab_list, email_reply_to_all_by_default, email_reply_force_html, do_not_fill_assigned_user_if_not_required) FROM stdin;
\.


--
-- TOC entry 4323 (class 0 OID 22567)
-- Dependencies: 324
-- Data for Name: reminder; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reminder (id, deleted, remind_at, start_at, type, seconds, entity_type, entity_id, user_id) FROM stdin;
\.


--
-- TOC entry 4324 (class 0 OID 22573)
-- Dependencies: 325
-- Data for Name: role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.role (id, name, deleted, assignment_permission, user_permission, portal_permission, data, field_data) FROM stdin;
\.


--
-- TOC entry 4326 (class 0 OID 22585)
-- Dependencies: 327
-- Data for Name: role_team; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.role_team (id, role_id, team_id, deleted) FROM stdin;
\.


--
-- TOC entry 4328 (class 0 OID 22592)
-- Dependencies: 329
-- Data for Name: role_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.role_user (id, role_id, user_id, deleted) FROM stdin;
\.


--
-- TOC entry 4329 (class 0 OID 22597)
-- Dependencies: 330
-- Data for Name: scheduled_job; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scheduled_job (id, name, deleted, job, status, scheduling, last_run, created_at, modified_at, created_by_id, modified_by_id) FROM stdin;
\.


--
-- TOC entry 4330 (class 0 OID 22604)
-- Dependencies: 331
-- Data for Name: scheduled_job_log_record; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scheduled_job_log_record (id, name, deleted, status, execution_time, created_at, scheduled_job_id, target_id, target_type) FROM stdin;
\.


--
-- TOC entry 4332 (class 0 OID 22613)
-- Dependencies: 333
-- Data for Name: subscription; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.subscription (id, entity_id, entity_type, user_id) FROM stdin;
\.


--
-- TOC entry 4333 (class 0 OID 22617)
-- Dependencies: 334
-- Data for Name: target; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.target (id, deleted, salutation_name, first_name, last_name, title, account_name, website, address_street, address_city, address_state, address_country, address_postal_code, do_not_call, description, created_at, modified_at, created_by_id, modified_by_id, assigned_user_id) FROM stdin;
\.


--
-- TOC entry 4334 (class 0 OID 22627)
-- Dependencies: 335
-- Data for Name: target_list; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.target_list (id, name, deleted, description, created_at, modified_at, created_by_id, modified_by_id, assigned_user_id, campaigns_id) FROM stdin;
\.


--
-- TOC entry 4336 (class 0 OID 22636)
-- Dependencies: 337
-- Data for Name: target_list_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.target_list_user (id, user_id, target_list_id, opted_out, deleted) FROM stdin;
\.


--
-- TOC entry 4337 (class 0 OID 22642)
-- Dependencies: 338
-- Data for Name: task; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.task (id, name, deleted, status, priority, date_start, date_end, date_start_date, date_end_date, date_completed, description, created_at, modified_at, parent_id, parent_type, account_id, created_by_id, modified_by_id, assigned_user_id) FROM stdin;
\.


--
-- TOC entry 4338 (class 0 OID 22651)
-- Dependencies: 339
-- Data for Name: team; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.team (id, name, deleted, position_list, created_at) FROM stdin;
\.


--
-- TOC entry 4340 (class 0 OID 22660)
-- Dependencies: 341
-- Data for Name: team_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.team_user (id, team_id, user_id, role, deleted) FROM stdin;
\.


--
-- TOC entry 4341 (class 0 OID 22665)
-- Dependencies: 342
-- Data for Name: template; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.template (id, name, deleted, body, header, footer, entity_type, left_margin, right_margin, top_margin, bottom_margin, print_footer, footer_position, created_at, modified_at, created_by_id, modified_by_id) FROM stdin;
\.


--
-- TOC entry 4342 (class 0 OID 22678)
-- Dependencies: 343
-- Data for Name: unique_id; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.unique_id (id, name, deleted, data, created_at, created_by_id) FROM stdin;
\.


--
-- TOC entry 4343 (class 0 OID 22685)
-- Dependencies: 344
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."user" (id, deleted, is_admin, user_name, password, salutation_name, first_name, last_name, is_active, is_portal_user, is_super_admin, title, gender, created_at, default_team_id, contact_id, avatar_id) FROM stdin;
\.


--
-- TOC entry 4402 (class 0 OID 0)
-- Dependencies: 199
-- Name: account_contact_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.account_contact_id_seq', 1, true);


--
-- TOC entry 4403 (class 0 OID 0)
-- Dependencies: 201
-- Name: account_document_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.account_document_id_seq', 1, true);


--
-- TOC entry 4404 (class 0 OID 0)
-- Dependencies: 203
-- Name: account_portal_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.account_portal_user_id_seq', 1, true);


--
-- TOC entry 4405 (class 0 OID 0)
-- Dependencies: 205
-- Name: account_target_list_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.account_target_list_id_seq', 1, true);


--
-- TOC entry 4406 (class 0 OID 0)
-- Dependencies: 209
-- Name: autofollow_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.autofollow_id_seq', 1, true);


--
-- TOC entry 4407 (class 0 OID 0)
-- Dependencies: 212
-- Name: call_contact_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.call_contact_id_seq', 1, true);


--
-- TOC entry 4408 (class 0 OID 0)
-- Dependencies: 214
-- Name: call_lead_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.call_lead_id_seq', 1, true);


--
-- TOC entry 4409 (class 0 OID 0)
-- Dependencies: 216
-- Name: call_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.call_user_id_seq', 1, true);


--
-- TOC entry 4410 (class 0 OID 0)
-- Dependencies: 222
-- Name: campaign_target_list_excluding_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.campaign_target_list_excluding_id_seq', 1, true);


--
-- TOC entry 4411 (class 0 OID 0)
-- Dependencies: 220
-- Name: campaign_target_list_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.campaign_target_list_id_seq', 1, true);


--
-- TOC entry 4412 (class 0 OID 0)
-- Dependencies: 227
-- Name: case_contact_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.case_contact_id_seq', 1, true);


--
-- TOC entry 4413 (class 0 OID 0)
-- Dependencies: 229
-- Name: case_knowledge_base_article_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.case_knowledge_base_article_id_seq', 1, true);


--
-- TOC entry 4414 (class 0 OID 0)
-- Dependencies: 225
-- Name: case_number_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.case_number_seq', 1, true);


--
-- TOC entry 4415 (class 0 OID 0)
-- Dependencies: 232
-- Name: contact_document_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.contact_document_id_seq', 1, true);


--
-- TOC entry 4416 (class 0 OID 0)
-- Dependencies: 234
-- Name: contact_meeting_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.contact_meeting_id_seq', 1, true);


--
-- TOC entry 4417 (class 0 OID 0)
-- Dependencies: 236
-- Name: contact_opportunity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.contact_opportunity_id_seq', 1, true);


--
-- TOC entry 4418 (class 0 OID 0)
-- Dependencies: 238
-- Name: contact_target_list_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.contact_target_list_id_seq', 1, true);


--
-- TOC entry 4419 (class 0 OID 0)
-- Dependencies: 243
-- Name: document_folder_path_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.document_folder_path_id_seq', 1, true);


--
-- TOC entry 4420 (class 0 OID 0)
-- Dependencies: 245
-- Name: document_lead_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.document_lead_id_seq', 1, true);


--
-- TOC entry 4421 (class 0 OID 0)
-- Dependencies: 247
-- Name: document_opportunity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.document_opportunity_id_seq', 1, true);


--
-- TOC entry 4422 (class 0 OID 0)
-- Dependencies: 252
-- Name: email_email_account_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.email_email_account_id_seq', 1, true);


--
-- TOC entry 4423 (class 0 OID 0)
-- Dependencies: 254
-- Name: email_email_address_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.email_email_address_id_seq', 1, true);


--
-- TOC entry 4424 (class 0 OID 0)
-- Dependencies: 258
-- Name: email_inbound_email_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.email_inbound_email_id_seq', 1, true);


--
-- TOC entry 4425 (class 0 OID 0)
-- Dependencies: 262
-- Name: email_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.email_user_id_seq', 1, true);


--
-- TOC entry 4426 (class 0 OID 0)
-- Dependencies: 264
-- Name: entity_email_address_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.entity_email_address_id_seq', 1, true);


--
-- TOC entry 4427 (class 0 OID 0)
-- Dependencies: 266
-- Name: entity_phone_number_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.entity_phone_number_id_seq', 1, true);


--
-- TOC entry 4428 (class 0 OID 0)
-- Dependencies: 268
-- Name: entity_team_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.entity_team_id_seq', 1, true);


--
-- TOC entry 4429 (class 0 OID 0)
-- Dependencies: 270
-- Name: entity_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.entity_user_id_seq', 1, true);


--
-- TOC entry 4430 (class 0 OID 0)
-- Dependencies: 275
-- Name: import_entity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.import_entity_id_seq', 1, true);


--
-- TOC entry 4431 (class 0 OID 0)
-- Dependencies: 281
-- Name: knowledge_base_article_knowledge_base_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.knowledge_base_article_knowledge_base_category_id_seq', 1, true);


--
-- TOC entry 4432 (class 0 OID 0)
-- Dependencies: 283
-- Name: knowledge_base_article_portal_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.knowledge_base_article_portal_id_seq', 1, true);


--
-- TOC entry 4433 (class 0 OID 0)
-- Dependencies: 286
-- Name: knowledge_base_category_path_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.knowledge_base_category_path_id_seq', 1, true);


--
-- TOC entry 4434 (class 0 OID 0)
-- Dependencies: 289
-- Name: lead_meeting_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.lead_meeting_id_seq', 1, true);


--
-- TOC entry 4435 (class 0 OID 0)
-- Dependencies: 291
-- Name: lead_target_list_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.lead_target_list_id_seq', 1, true);


--
-- TOC entry 4436 (class 0 OID 0)
-- Dependencies: 296
-- Name: mass_email_target_list_excluding_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.mass_email_target_list_excluding_id_seq', 1, true);


--
-- TOC entry 4437 (class 0 OID 0)
-- Dependencies: 294
-- Name: mass_email_target_list_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.mass_email_target_list_id_seq', 1, true);


--
-- TOC entry 4438 (class 0 OID 0)
-- Dependencies: 299
-- Name: meeting_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.meeting_user_id_seq', 1, true);


--
-- TOC entry 4439 (class 0 OID 0)
-- Dependencies: 302
-- Name: note_number_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.note_number_seq', 1, true);


--
-- TOC entry 4440 (class 0 OID 0)
-- Dependencies: 304
-- Name: note_portal_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.note_portal_id_seq', 1, true);


--
-- TOC entry 4441 (class 0 OID 0)
-- Dependencies: 306
-- Name: note_team_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.note_team_id_seq', 1, true);


--
-- TOC entry 4442 (class 0 OID 0)
-- Dependencies: 308
-- Name: note_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.note_user_id_seq', 1, true);


--
-- TOC entry 4443 (class 0 OID 0)
-- Dependencies: 310
-- Name: notification_number_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.notification_number_seq', 1, true);


--
-- TOC entry 4444 (class 0 OID 0)
-- Dependencies: 316
-- Name: portal_portal_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.portal_portal_role_id_seq', 1, true);


--
-- TOC entry 4445 (class 0 OID 0)
-- Dependencies: 319
-- Name: portal_role_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.portal_role_user_id_seq', 1, true);


--
-- TOC entry 4446 (class 0 OID 0)
-- Dependencies: 321
-- Name: portal_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.portal_user_id_seq', 1, true);


--
-- TOC entry 4447 (class 0 OID 0)
-- Dependencies: 326
-- Name: role_team_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.role_team_id_seq', 1, true);


--
-- TOC entry 4448 (class 0 OID 0)
-- Dependencies: 328
-- Name: role_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.role_user_id_seq', 1, true);


--
-- TOC entry 4449 (class 0 OID 0)
-- Dependencies: 332
-- Name: subscription_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.subscription_id_seq', 1, true);


--
-- TOC entry 4450 (class 0 OID 0)
-- Dependencies: 336
-- Name: target_list_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.target_list_user_id_seq', 1, true);


--
-- TOC entry 4451 (class 0 OID 0)
-- Dependencies: 340
-- Name: team_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.team_user_id_seq', 1, true);


--
-- TOC entry 3535 (class 2606 OID 23155)
-- Name: account idx_21901_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account
    ADD CONSTRAINT idx_21901_primary PRIMARY KEY (id);


--
-- TOC entry 3539 (class 2606 OID 23156)
-- Name: account_contact idx_21912_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_contact
    ADD CONSTRAINT idx_21912_primary PRIMARY KEY (id);


--
-- TOC entry 3544 (class 2606 OID 23157)
-- Name: account_document idx_21919_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_document
    ADD CONSTRAINT idx_21919_primary PRIMARY KEY (id);


--
-- TOC entry 3549 (class 2606 OID 23158)
-- Name: account_portal_user idx_21926_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_portal_user
    ADD CONSTRAINT idx_21926_primary PRIMARY KEY (id);


--
-- TOC entry 3554 (class 2606 OID 23159)
-- Name: account_target_list idx_21933_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_target_list
    ADD CONSTRAINT idx_21933_primary PRIMARY KEY (id);


--
-- TOC entry 3560 (class 2606 OID 23160)
-- Name: attachment idx_21939_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attachment
    ADD CONSTRAINT idx_21939_primary PRIMARY KEY (id);


--
-- TOC entry 3568 (class 2606 OID 23161)
-- Name: auth_token idx_21947_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_token
    ADD CONSTRAINT idx_21947_primary PRIMARY KEY (id);


--
-- TOC entry 3573 (class 2606 OID 23162)
-- Name: autofollow idx_21953_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.autofollow
    ADD CONSTRAINT idx_21953_primary PRIMARY KEY (id);


--
-- TOC entry 3585 (class 2606 OID 23163)
-- Name: call idx_21957_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.call
    ADD CONSTRAINT idx_21957_primary PRIMARY KEY (id);


--
-- TOC entry 3589 (class 2606 OID 23164)
-- Name: call_contact idx_21968_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.call_contact
    ADD CONSTRAINT idx_21968_primary PRIMARY KEY (id);


--
-- TOC entry 3594 (class 2606 OID 23165)
-- Name: call_lead idx_21976_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.call_lead
    ADD CONSTRAINT idx_21976_primary PRIMARY KEY (id);


--
-- TOC entry 3599 (class 2606 OID 23166)
-- Name: call_user idx_21984_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.call_user
    ADD CONSTRAINT idx_21984_primary PRIMARY KEY (id);


--
-- TOC entry 3606 (class 2606 OID 23167)
-- Name: campaign idx_21990_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.campaign
    ADD CONSTRAINT idx_21990_primary PRIMARY KEY (id);


--
-- TOC entry 3615 (class 2606 OID 23168)
-- Name: campaign_log_record idx_21999_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.campaign_log_record
    ADD CONSTRAINT idx_21999_primary PRIMARY KEY (id);


--
-- TOC entry 3619 (class 2606 OID 23169)
-- Name: campaign_target_list idx_22010_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.campaign_target_list
    ADD CONSTRAINT idx_22010_primary PRIMARY KEY (id);


--
-- TOC entry 3624 (class 2606 OID 23170)
-- Name: campaign_target_list_excluding idx_22017_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.campaign_target_list_excluding
    ADD CONSTRAINT idx_22017_primary PRIMARY KEY (id);


--
-- TOC entry 3630 (class 2606 OID 23171)
-- Name: campaign_tracking_url idx_22022_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.campaign_tracking_url
    ADD CONSTRAINT idx_22022_primary PRIMARY KEY (id);


--
-- TOC entry 3643 (class 2606 OID 23172)
-- Name: case idx_22031_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."case"
    ADD CONSTRAINT idx_22031_primary PRIMARY KEY (id);


--
-- TOC entry 3648 (class 2606 OID 23173)
-- Name: case_contact idx_22044_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.case_contact
    ADD CONSTRAINT idx_22044_primary PRIMARY KEY (id);


--
-- TOC entry 3653 (class 2606 OID 23174)
-- Name: case_knowledge_base_article idx_22051_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.case_knowledge_base_article
    ADD CONSTRAINT idx_22051_primary PRIMARY KEY (id);


--
-- TOC entry 3664 (class 2606 OID 23175)
-- Name: contact idx_22056_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contact
    ADD CONSTRAINT idx_22056_primary PRIMARY KEY (id);


--
-- TOC entry 3668 (class 2606 OID 23176)
-- Name: contact_document idx_22068_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contact_document
    ADD CONSTRAINT idx_22068_primary PRIMARY KEY (id);


--
-- TOC entry 3673 (class 2606 OID 23177)
-- Name: contact_meeting idx_22075_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contact_meeting
    ADD CONSTRAINT idx_22075_primary PRIMARY KEY (id);


--
-- TOC entry 3678 (class 2606 OID 23178)
-- Name: contact_opportunity idx_22083_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contact_opportunity
    ADD CONSTRAINT idx_22083_primary PRIMARY KEY (id);


--
-- TOC entry 3683 (class 2606 OID 23179)
-- Name: contact_target_list idx_22090_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contact_target_list
    ADD CONSTRAINT idx_22090_primary PRIMARY KEY (id);


--
-- TOC entry 3686 (class 2606 OID 23180)
-- Name: currency idx_22096_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.currency
    ADD CONSTRAINT idx_22096_primary PRIMARY KEY (id);


--
-- TOC entry 3693 (class 2606 OID 23181)
-- Name: document idx_22100_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.document
    ADD CONSTRAINT idx_22100_primary PRIMARY KEY (id);


--
-- TOC entry 3698 (class 2606 OID 23182)
-- Name: document_folder idx_22108_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.document_folder
    ADD CONSTRAINT idx_22108_primary PRIMARY KEY (id);


--
-- TOC entry 3703 (class 2606 OID 23183)
-- Name: document_folder_path idx_22117_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.document_folder_path
    ADD CONSTRAINT idx_22117_primary PRIMARY KEY (id);


--
-- TOC entry 3707 (class 2606 OID 23184)
-- Name: document_lead idx_22123_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.document_lead
    ADD CONSTRAINT idx_22123_primary PRIMARY KEY (id);


--
-- TOC entry 3712 (class 2606 OID 23185)
-- Name: document_opportunity idx_22130_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.document_opportunity
    ADD CONSTRAINT idx_22130_primary PRIMARY KEY (id);


--
-- TOC entry 3726 (class 2606 OID 23186)
-- Name: email idx_22135_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.email
    ADD CONSTRAINT idx_22135_primary PRIMARY KEY (id);


--
-- TOC entry 3732 (class 2606 OID 23187)
-- Name: email_account idx_22147_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.email_account
    ADD CONSTRAINT idx_22147_primary PRIMARY KEY (id);


--
-- TOC entry 3735 (class 2606 OID 23188)
-- Name: email_address idx_22162_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.email_address
    ADD CONSTRAINT idx_22162_primary PRIMARY KEY (id);


--
-- TOC entry 3739 (class 2606 OID 23189)
-- Name: email_email_account idx_22173_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.email_email_account
    ADD CONSTRAINT idx_22173_primary PRIMARY KEY (id);


--
-- TOC entry 3744 (class 2606 OID 23190)
-- Name: email_email_address idx_22180_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.email_email_address
    ADD CONSTRAINT idx_22180_primary PRIMARY KEY (id);


--
-- TOC entry 3751 (class 2606 OID 23191)
-- Name: email_filter idx_22185_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.email_filter
    ADD CONSTRAINT idx_22185_primary PRIMARY KEY (id);


--
-- TOC entry 3756 (class 2606 OID 23192)
-- Name: email_folder idx_22194_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.email_folder
    ADD CONSTRAINT idx_22194_primary PRIMARY KEY (id);


--
-- TOC entry 3760 (class 2606 OID 23193)
-- Name: email_inbound_email idx_22201_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.email_inbound_email
    ADD CONSTRAINT idx_22201_primary PRIMARY KEY (id);


--
-- TOC entry 3764 (class 2606 OID 23194)
-- Name: email_queue_item idx_22206_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.email_queue_item
    ADD CONSTRAINT idx_22206_primary PRIMARY KEY (id);


--
-- TOC entry 3770 (class 2606 OID 23195)
-- Name: email_template idx_22215_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.email_template
    ADD CONSTRAINT idx_22215_primary PRIMARY KEY (id);


--
-- TOC entry 3774 (class 2606 OID 23196)
-- Name: email_user idx_22226_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.email_user
    ADD CONSTRAINT idx_22226_primary PRIMARY KEY (id);


--
-- TOC entry 3779 (class 2606 OID 23197)
-- Name: entity_email_address idx_22236_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entity_email_address
    ADD CONSTRAINT idx_22236_primary PRIMARY KEY (id);


--
-- TOC entry 3784 (class 2606 OID 23198)
-- Name: entity_phone_number idx_22244_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entity_phone_number
    ADD CONSTRAINT idx_22244_primary PRIMARY KEY (id);


--
-- TOC entry 3789 (class 2606 OID 23199)
-- Name: entity_team idx_22252_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entity_team
    ADD CONSTRAINT idx_22252_primary PRIMARY KEY (id);


--
-- TOC entry 3794 (class 2606 OID 23200)
-- Name: entity_user idx_22259_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entity_user
    ADD CONSTRAINT idx_22259_primary PRIMARY KEY (id);


--
-- TOC entry 3798 (class 2606 OID 23201)
-- Name: extension idx_22264_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.extension
    ADD CONSTRAINT idx_22264_primary PRIMARY KEY (id);


--
-- TOC entry 3800 (class 2606 OID 23202)
-- Name: external_account idx_22272_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.external_account
    ADD CONSTRAINT idx_22272_primary PRIMARY KEY (id);


--
-- TOC entry 3804 (class 2606 OID 23203)
-- Name: import idx_22280_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.import
    ADD CONSTRAINT idx_22280_primary PRIMARY KEY (id);


--
-- TOC entry 3810 (class 2606 OID 23204)
-- Name: import_entity idx_22289_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.import_entity
    ADD CONSTRAINT idx_22289_primary PRIMARY KEY (id);


--
-- TOC entry 3817 (class 2606 OID 23205)
-- Name: inbound_email idx_22296_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inbound_email
    ADD CONSTRAINT idx_22296_primary PRIMARY KEY (id);


--
-- TOC entry 3819 (class 2606 OID 23206)
-- Name: integration idx_22310_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.integration
    ADD CONSTRAINT idx_22310_primary PRIMARY KEY (id);


--
-- TOC entry 3824 (class 2606 OID 23207)
-- Name: job idx_22318_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job
    ADD CONSTRAINT idx_22318_primary PRIMARY KEY (id);


--
-- TOC entry 3829 (class 2606 OID 23208)
-- Name: knowledge_base_article idx_22326_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.knowledge_base_article
    ADD CONSTRAINT idx_22326_primary PRIMARY KEY (id);


--
-- TOC entry 3833 (class 2606 OID 23209)
-- Name: knowledge_base_article_knowledge_base_category idx_22337_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.knowledge_base_article_knowledge_base_category
    ADD CONSTRAINT idx_22337_primary PRIMARY KEY (id);


--
-- TOC entry 3838 (class 2606 OID 23210)
-- Name: knowledge_base_article_portal idx_22344_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.knowledge_base_article_portal
    ADD CONSTRAINT idx_22344_primary PRIMARY KEY (id);


--
-- TOC entry 3844 (class 2606 OID 23211)
-- Name: knowledge_base_category idx_22349_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.knowledge_base_category
    ADD CONSTRAINT idx_22349_primary PRIMARY KEY (id);


--
-- TOC entry 3849 (class 2606 OID 23212)
-- Name: knowledge_base_category_path idx_22358_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.knowledge_base_category_path
    ADD CONSTRAINT idx_22358_primary PRIMARY KEY (id);


--
-- TOC entry 3865 (class 2606 OID 23213)
-- Name: lead idx_22362_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lead
    ADD CONSTRAINT idx_22362_primary PRIMARY KEY (id);


--
-- TOC entry 3869 (class 2606 OID 23214)
-- Name: lead_meeting idx_22377_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lead_meeting
    ADD CONSTRAINT idx_22377_primary PRIMARY KEY (id);


--
-- TOC entry 3874 (class 2606 OID 23215)
-- Name: lead_target_list idx_22385_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lead_target_list
    ADD CONSTRAINT idx_22385_primary PRIMARY KEY (id);


--
-- TOC entry 3882 (class 2606 OID 23216)
-- Name: mass_email idx_22391_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mass_email
    ADD CONSTRAINT idx_22391_primary PRIMARY KEY (id);


--
-- TOC entry 3886 (class 2606 OID 23217)
-- Name: mass_email_target_list idx_22403_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mass_email_target_list
    ADD CONSTRAINT idx_22403_primary PRIMARY KEY (id);


--
-- TOC entry 3891 (class 2606 OID 23218)
-- Name: mass_email_target_list_excluding idx_22410_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mass_email_target_list_excluding
    ADD CONSTRAINT idx_22410_primary PRIMARY KEY (id);


--
-- TOC entry 3904 (class 2606 OID 23219)
-- Name: meeting idx_22415_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.meeting
    ADD CONSTRAINT idx_22415_primary PRIMARY KEY (id);


--
-- TOC entry 3908 (class 2606 OID 23220)
-- Name: meeting_user idx_22425_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.meeting_user
    ADD CONSTRAINT idx_22425_primary PRIMARY KEY (id);


--
-- TOC entry 3912 (class 2606 OID 23221)
-- Name: next_number idx_22431_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.next_number
    ADD CONSTRAINT idx_22431_primary PRIMARY KEY (id);


--
-- TOC entry 3920 (class 2606 OID 23222)
-- Name: note idx_22441_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.note
    ADD CONSTRAINT idx_22441_primary PRIMARY KEY (id);


--
-- TOC entry 3927 (class 2606 OID 23223)
-- Name: note_portal idx_22453_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.note_portal
    ADD CONSTRAINT idx_22453_primary PRIMARY KEY (id);


--
-- TOC entry 3932 (class 2606 OID 23224)
-- Name: note_team idx_22460_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.note_team
    ADD CONSTRAINT idx_22460_primary PRIMARY KEY (id);


--
-- TOC entry 3937 (class 2606 OID 23225)
-- Name: note_user idx_22467_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.note_user
    ADD CONSTRAINT idx_22467_primary PRIMARY KEY (id);


--
-- TOC entry 3944 (class 2606 OID 23226)
-- Name: notification idx_22474_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification
    ADD CONSTRAINT idx_22474_primary PRIMARY KEY (id);


--
-- TOC entry 3959 (class 2606 OID 23227)
-- Name: opportunity idx_22484_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.opportunity
    ADD CONSTRAINT idx_22484_primary PRIMARY KEY (id);


--
-- TOC entry 3963 (class 2606 OID 23228)
-- Name: password_change_request idx_22493_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.password_change_request
    ADD CONSTRAINT idx_22493_primary PRIMARY KEY (id);


--
-- TOC entry 3966 (class 2606 OID 23229)
-- Name: phone_number idx_22497_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.phone_number
    ADD CONSTRAINT idx_22497_primary PRIMARY KEY (id);


--
-- TOC entry 3973 (class 2606 OID 23230)
-- Name: portal idx_22501_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.portal
    ADD CONSTRAINT idx_22501_primary PRIMARY KEY (id);


--
-- TOC entry 3977 (class 2606 OID 23231)
-- Name: portal_portal_role idx_22517_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.portal_portal_role
    ADD CONSTRAINT idx_22517_primary PRIMARY KEY (id);


--
-- TOC entry 3980 (class 2606 OID 23232)
-- Name: portal_role idx_22522_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.portal_role
    ADD CONSTRAINT idx_22522_primary PRIMARY KEY (id);


--
-- TOC entry 3984 (class 2606 OID 23233)
-- Name: portal_role_user idx_22531_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.portal_role_user
    ADD CONSTRAINT idx_22531_primary PRIMARY KEY (id);


--
-- TOC entry 3989 (class 2606 OID 23234)
-- Name: portal_user idx_22538_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.portal_user
    ADD CONSTRAINT idx_22538_primary PRIMARY KEY (id);


--
-- TOC entry 3992 (class 2606 OID 23235)
-- Name: preferences idx_22543_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.preferences
    ADD CONSTRAINT idx_22543_primary PRIMARY KEY (id);


--
-- TOC entry 3997 (class 2606 OID 23236)
-- Name: reminder idx_22567_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reminder
    ADD CONSTRAINT idx_22567_primary PRIMARY KEY (id);


--
-- TOC entry 3999 (class 2606 OID 23237)
-- Name: role idx_22573_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role
    ADD CONSTRAINT idx_22573_primary PRIMARY KEY (id);


--
-- TOC entry 4003 (class 2606 OID 23238)
-- Name: role_team idx_22585_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_team
    ADD CONSTRAINT idx_22585_primary PRIMARY KEY (id);


--
-- TOC entry 4008 (class 2606 OID 23239)
-- Name: role_user idx_22592_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_user
    ADD CONSTRAINT idx_22592_primary PRIMARY KEY (id);


--
-- TOC entry 4013 (class 2606 OID 23240)
-- Name: scheduled_job idx_22597_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scheduled_job
    ADD CONSTRAINT idx_22597_primary PRIMARY KEY (id);


--
-- TOC entry 4016 (class 2606 OID 23241)
-- Name: scheduled_job_log_record idx_22604_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scheduled_job_log_record
    ADD CONSTRAINT idx_22604_primary PRIMARY KEY (id);


--
-- TOC entry 4022 (class 2606 OID 23242)
-- Name: subscription idx_22613_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscription
    ADD CONSTRAINT idx_22613_primary PRIMARY KEY (id);


--
-- TOC entry 4030 (class 2606 OID 23243)
-- Name: target idx_22617_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.target
    ADD CONSTRAINT idx_22617_primary PRIMARY KEY (id);


--
-- TOC entry 4037 (class 2606 OID 23244)
-- Name: target_list idx_22627_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.target_list
    ADD CONSTRAINT idx_22627_primary PRIMARY KEY (id);


--
-- TOC entry 4041 (class 2606 OID 23245)
-- Name: target_list_user idx_22636_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.target_list_user
    ADD CONSTRAINT idx_22636_primary PRIMARY KEY (id);


--
-- TOC entry 4055 (class 2606 OID 23246)
-- Name: task idx_22642_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task
    ADD CONSTRAINT idx_22642_primary PRIMARY KEY (id);


--
-- TOC entry 4057 (class 2606 OID 23247)
-- Name: team idx_22651_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.team
    ADD CONSTRAINT idx_22651_primary PRIMARY KEY (id);


--
-- TOC entry 4061 (class 2606 OID 23248)
-- Name: team_user idx_22660_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.team_user
    ADD CONSTRAINT idx_22660_primary PRIMARY KEY (id);


--
-- TOC entry 4066 (class 2606 OID 23249)
-- Name: template idx_22665_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.template
    ADD CONSTRAINT idx_22665_primary PRIMARY KEY (id);


--
-- TOC entry 4070 (class 2606 OID 23250)
-- Name: unique_id idx_22678_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.unique_id
    ADD CONSTRAINT idx_22678_primary PRIMARY KEY (id);


--
-- TOC entry 4075 (class 2606 OID 23251)
-- Name: user idx_22685_primary; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT idx_22685_primary PRIMARY KEY (id);


--
-- TOC entry 3528 (class 1259 OID 22700)
-- Name: idx_21901_idx_7d3656a499049ece; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_21901_idx_7d3656a499049ece ON public.account USING btree (modified_by_id);


--
-- TOC entry 3529 (class 1259 OID 22699)
-- Name: idx_21901_idx_7d3656a4adf66b1a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_21901_idx_7d3656a4adf66b1a ON public.account USING btree (assigned_user_id);


--
-- TOC entry 3530 (class 1259 OID 22703)
-- Name: idx_21901_idx_7d3656a4b03a8386; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_21901_idx_7d3656a4b03a8386 ON public.account USING btree (created_by_id);


--
-- TOC entry 3531 (class 1259 OID 22702)
-- Name: idx_21901_idx_7d3656a4f639f774; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_21901_idx_7d3656a4f639f774 ON public.account USING btree (campaign_id);


--
-- TOC entry 3532 (class 1259 OID 22704)
-- Name: idx_21901_idx_account_assigned_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_21901_idx_account_assigned_user ON public.account USING btree (assigned_user_id, deleted);


--
-- TOC entry 3533 (class 1259 OID 22705)
-- Name: idx_21901_idx_account_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_21901_idx_account_name ON public.account USING btree (name, deleted);


--
-- TOC entry 3536 (class 1259 OID 22708)
-- Name: idx_21912_idx_8549f2709b6b5fba; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_21912_idx_8549f2709b6b5fba ON public.account_contact USING btree (account_id);


--
-- TOC entry 3537 (class 1259 OID 22709)
-- Name: idx_21912_idx_8549f270e7a1254a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_21912_idx_8549f270e7a1254a ON public.account_contact USING btree (contact_id);


--
-- TOC entry 3540 (class 1259 OID 22706)
-- Name: idx_21912_uniq_8549f2709b6b5fbae7a1254a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_21912_uniq_8549f2709b6b5fbae7a1254a ON public.account_contact USING btree (account_id, contact_id);


--
-- TOC entry 3541 (class 1259 OID 22711)
-- Name: idx_21919_idx_a0a768c09b6b5fba; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_21919_idx_a0a768c09b6b5fba ON public.account_document USING btree (account_id);


--
-- TOC entry 3542 (class 1259 OID 22713)
-- Name: idx_21919_idx_a0a768c0c33f7837; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_21919_idx_a0a768c0c33f7837 ON public.account_document USING btree (document_id);


--
-- TOC entry 3545 (class 1259 OID 22710)
-- Name: idx_21919_uniq_a0a768c09b6b5fbac33f7837; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_21919_uniq_a0a768c09b6b5fbac33f7837 ON public.account_document USING btree (account_id, document_id);


--
-- TOC entry 3546 (class 1259 OID 22721)
-- Name: idx_21926_idx_d622ede79b6b5fba; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_21926_idx_d622ede79b6b5fba ON public.account_portal_user USING btree (account_id);


--
-- TOC entry 3547 (class 1259 OID 22728)
-- Name: idx_21926_idx_d622ede7a76ed395; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_21926_idx_d622ede7a76ed395 ON public.account_portal_user USING btree (user_id);


--
-- TOC entry 3550 (class 1259 OID 22722)
-- Name: idx_21926_uniq_d622ede7a76ed3959b6b5fba; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_21926_uniq_d622ede7a76ed3959b6b5fba ON public.account_portal_user USING btree (user_id, account_id);


--
-- TOC entry 3551 (class 1259 OID 22727)
-- Name: idx_21933_idx_589712aa9b6b5fba; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_21933_idx_589712aa9b6b5fba ON public.account_target_list USING btree (account_id);


--
-- TOC entry 3552 (class 1259 OID 22724)
-- Name: idx_21933_idx_589712aaf6c6afe0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_21933_idx_589712aaf6c6afe0 ON public.account_target_list USING btree (target_list_id);


--
-- TOC entry 3555 (class 1259 OID 22716)
-- Name: idx_21933_uniq_589712aa9b6b5fbaf6c6afe0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_21933_uniq_589712aa9b6b5fbaf6c6afe0 ON public.account_target_list USING btree (account_id, target_list_id);


--
-- TOC entry 3556 (class 1259 OID 22723)
-- Name: idx_21939_idx_795fd9bbb03a8386; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_21939_idx_795fd9bbb03a8386 ON public.attachment USING btree (created_by_id);


--
-- TOC entry 3557 (class 1259 OID 22714)
-- Name: idx_21939_idx_attachment_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_21939_idx_attachment_parent ON public.attachment USING btree (parent_type, parent_id);


--
-- TOC entry 3558 (class 1259 OID 22715)
-- Name: idx_21939_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_21939_parent ON public.attachment USING btree (parent_id, parent_type);


--
-- TOC entry 3561 (class 1259 OID 22719)
-- Name: idx_21939_related; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_21939_related ON public.attachment USING btree (related_id, related_type);


--
-- TOC entry 3562 (class 1259 OID 22717)
-- Name: idx_21947_idx_9315f04e5f37a13b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_21947_idx_9315f04e5f37a13b ON public.auth_token USING btree (token);


--
-- TOC entry 3563 (class 1259 OID 22720)
-- Name: idx_21947_idx_9315f04ea76ed395; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_21947_idx_9315f04ea76ed395 ON public.auth_token USING btree (user_id);


--
-- TOC entry 3564 (class 1259 OID 22743)
-- Name: idx_21947_idx_9315f04eb887e1dd; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_21947_idx_9315f04eb887e1dd ON public.auth_token USING btree (portal_id);


--
-- TOC entry 3565 (class 1259 OID 22736)
-- Name: idx_21947_idx_9315f04ed1b862b8; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_21947_idx_9315f04ed1b862b8 ON public.auth_token USING btree (hash);


--
-- TOC entry 3566 (class 1259 OID 22737)
-- Name: idx_21947_idx_auth_token_token; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_21947_idx_auth_token_token ON public.auth_token USING btree (token, deleted);


--
-- TOC entry 3569 (class 1259 OID 22735)
-- Name: idx_21953_entitytype; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_21953_entitytype ON public.autofollow USING btree (entity_type);


--
-- TOC entry 3570 (class 1259 OID 22740)
-- Name: idx_21953_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_21953_id ON public.autofollow USING btree (id);


--
-- TOC entry 3571 (class 1259 OID 22739)
-- Name: idx_21953_idx_eb89c717a76ed395; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_21953_idx_eb89c717a76ed395 ON public.autofollow USING btree (user_id);


--
-- TOC entry 3574 (class 1259 OID 22741)
-- Name: idx_21957_idx_call_assigned_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_21957_idx_call_assigned_user ON public.call USING btree (assigned_user_id, deleted);


--
-- TOC entry 3575 (class 1259 OID 22729)
-- Name: idx_21957_idx_call_assigned_user_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_21957_idx_call_assigned_user_status ON public.call USING btree (assigned_user_id, status);


--
-- TOC entry 3576 (class 1259 OID 22733)
-- Name: idx_21957_idx_call_date_start; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_21957_idx_call_date_start ON public.call USING btree (date_start, deleted);


--
-- TOC entry 3577 (class 1259 OID 22730)
-- Name: idx_21957_idx_call_date_start_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_21957_idx_call_date_start_status ON public.call USING btree (date_start, status);


--
-- TOC entry 3578 (class 1259 OID 22731)
-- Name: idx_21957_idx_call_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_21957_idx_call_status ON public.call USING btree (status, deleted);


--
-- TOC entry 3579 (class 1259 OID 22734)
-- Name: idx_21957_idx_cc8e2f3e99049ece; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_21957_idx_cc8e2f3e99049ece ON public.call USING btree (modified_by_id);


--
-- TOC entry 3580 (class 1259 OID 22742)
-- Name: idx_21957_idx_cc8e2f3e9b6b5fba; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_21957_idx_cc8e2f3e9b6b5fba ON public.call USING btree (account_id);


--
-- TOC entry 3581 (class 1259 OID 22750)
-- Name: idx_21957_idx_cc8e2f3eadf66b1a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_21957_idx_cc8e2f3eadf66b1a ON public.call USING btree (assigned_user_id);


--
-- TOC entry 3582 (class 1259 OID 22753)
-- Name: idx_21957_idx_cc8e2f3eb03a8386; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_21957_idx_cc8e2f3eb03a8386 ON public.call USING btree (created_by_id);


--
-- TOC entry 3583 (class 1259 OID 22754)
-- Name: idx_21957_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_21957_parent ON public.call USING btree (parent_id, parent_type);


--
-- TOC entry 3586 (class 1259 OID 22752)
-- Name: idx_21968_idx_99c77f0d50a89b2c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_21968_idx_99c77f0d50a89b2c ON public.call_contact USING btree (call_id);


--
-- TOC entry 3587 (class 1259 OID 22757)
-- Name: idx_21968_idx_99c77f0de7a1254a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_21968_idx_99c77f0de7a1254a ON public.call_contact USING btree (contact_id);


--
-- TOC entry 3590 (class 1259 OID 22747)
-- Name: idx_21968_uniq_99c77f0d50a89b2ce7a1254a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_21968_uniq_99c77f0d50a89b2ce7a1254a ON public.call_contact USING btree (call_id, contact_id);


--
-- TOC entry 3591 (class 1259 OID 22751)
-- Name: idx_21976_idx_1f10069750a89b2c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_21976_idx_1f10069750a89b2c ON public.call_lead USING btree (call_id);


--
-- TOC entry 3592 (class 1259 OID 22745)
-- Name: idx_21976_idx_1f10069755458d; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_21976_idx_1f10069755458d ON public.call_lead USING btree (lead_id);


--
-- TOC entry 3595 (class 1259 OID 22746)
-- Name: idx_21976_uniq_1f10069750a89b2c55458d; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_21976_uniq_1f10069750a89b2c55458d ON public.call_lead USING btree (call_id, lead_id);


--
-- TOC entry 3596 (class 1259 OID 22744)
-- Name: idx_21984_idx_ba12b11550a89b2c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_21984_idx_ba12b11550a89b2c ON public.call_user USING btree (call_id);


--
-- TOC entry 3597 (class 1259 OID 22749)
-- Name: idx_21984_idx_ba12b115a76ed395; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_21984_idx_ba12b115a76ed395 ON public.call_user USING btree (user_id);


--
-- TOC entry 3600 (class 1259 OID 22767)
-- Name: idx_21984_uniq_ba12b115a76ed39550a89b2c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_21984_uniq_ba12b115a76ed39550a89b2c ON public.call_user USING btree (user_id, call_id);


--
-- TOC entry 3601 (class 1259 OID 22769)
-- Name: idx_21990_idx_1f1512dd99049ece; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_21990_idx_1f1512dd99049ece ON public.campaign USING btree (modified_by_id);


--
-- TOC entry 3602 (class 1259 OID 22771)
-- Name: idx_21990_idx_1f1512ddadf66b1a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_21990_idx_1f1512ddadf66b1a ON public.campaign USING btree (assigned_user_id);


--
-- TOC entry 3603 (class 1259 OID 22770)
-- Name: idx_21990_idx_1f1512ddb03a8386; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_21990_idx_1f1512ddb03a8386 ON public.campaign USING btree (created_by_id);


--
-- TOC entry 3604 (class 1259 OID 22765)
-- Name: idx_21990_idx_campaign_created_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_21990_idx_campaign_created_at ON public.campaign USING btree (created_at, deleted);


--
-- TOC entry 3607 (class 1259 OID 22766)
-- Name: idx_21999_idx_49d9ec9bb03a8386; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_21999_idx_49d9ec9bb03a8386 ON public.campaign_log_record USING btree (created_by_id);


--
-- TOC entry 3608 (class 1259 OID 22760)
-- Name: idx_21999_idx_49d9ec9bf0edc960; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_21999_idx_49d9ec9bf0edc960 ON public.campaign_log_record USING btree (queue_item_id);


--
-- TOC entry 3609 (class 1259 OID 22773)
-- Name: idx_21999_idx_49d9ec9bf639f774; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_21999_idx_49d9ec9bf639f774 ON public.campaign_log_record USING btree (campaign_id);


--
-- TOC entry 3610 (class 1259 OID 22759)
-- Name: idx_21999_idx_campaign_log_record_action; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_21999_idx_campaign_log_record_action ON public.campaign_log_record USING btree (action, deleted);


--
-- TOC entry 3611 (class 1259 OID 22762)
-- Name: idx_21999_idx_campaign_log_record_action_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_21999_idx_campaign_log_record_action_date ON public.campaign_log_record USING btree (action_date, deleted);


--
-- TOC entry 3612 (class 1259 OID 22764)
-- Name: idx_21999_object; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_21999_object ON public.campaign_log_record USING btree (object_id, object_type);


--
-- TOC entry 3613 (class 1259 OID 22763)
-- Name: idx_21999_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_21999_parent ON public.campaign_log_record USING btree (parent_id, parent_type);


--
-- TOC entry 3616 (class 1259 OID 22772)
-- Name: idx_22010_idx_511ad253f639f774; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22010_idx_511ad253f639f774 ON public.campaign_target_list USING btree (campaign_id);


--
-- TOC entry 3617 (class 1259 OID 22779)
-- Name: idx_22010_idx_511ad253f6c6afe0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22010_idx_511ad253f6c6afe0 ON public.campaign_target_list USING btree (target_list_id);


--
-- TOC entry 3620 (class 1259 OID 22777)
-- Name: idx_22010_uniq_511ad253f639f774f6c6afe0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22010_uniq_511ad253f639f774f6c6afe0 ON public.campaign_target_list USING btree (campaign_id, target_list_id);


--
-- TOC entry 3621 (class 1259 OID 22778)
-- Name: idx_22017_idx_ed6fb4a6f639f774; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22017_idx_ed6fb4a6f639f774 ON public.campaign_target_list_excluding USING btree (campaign_id);


--
-- TOC entry 3622 (class 1259 OID 22788)
-- Name: idx_22017_idx_ed6fb4a6f6c6afe0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22017_idx_ed6fb4a6f6c6afe0 ON public.campaign_target_list_excluding USING btree (target_list_id);


--
-- TOC entry 3625 (class 1259 OID 22782)
-- Name: idx_22017_uniq_ed6fb4a6f639f774f6c6afe0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22017_uniq_ed6fb4a6f639f774f6c6afe0 ON public.campaign_target_list_excluding USING btree (campaign_id, target_list_id);


--
-- TOC entry 3626 (class 1259 OID 22785)
-- Name: idx_22022_idx_eeb6672399049ece; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22022_idx_eeb6672399049ece ON public.campaign_tracking_url USING btree (modified_by_id);


--
-- TOC entry 3627 (class 1259 OID 22781)
-- Name: idx_22022_idx_eeb66723b03a8386; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22022_idx_eeb66723b03a8386 ON public.campaign_tracking_url USING btree (created_by_id);


--
-- TOC entry 3628 (class 1259 OID 22774)
-- Name: idx_22022_idx_eeb66723f639f774; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22022_idx_eeb66723f639f774 ON public.campaign_tracking_url USING btree (campaign_id);


--
-- TOC entry 3631 (class 1259 OID 22776)
-- Name: idx_22031_idx_7808990455458d; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22031_idx_7808990455458d ON public."case" USING btree (lead_id);


--
-- TOC entry 3632 (class 1259 OID 22775)
-- Name: idx_22031_idx_7808990499049ece; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22031_idx_7808990499049ece ON public."case" USING btree (modified_by_id);


--
-- TOC entry 3633 (class 1259 OID 22784)
-- Name: idx_22031_idx_780899049b6b5fba; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22031_idx_780899049b6b5fba ON public."case" USING btree (account_id);


--
-- TOC entry 3634 (class 1259 OID 22780)
-- Name: idx_22031_idx_78089904adf66b1a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22031_idx_78089904adf66b1a ON public."case" USING btree (assigned_user_id);


--
-- TOC entry 3635 (class 1259 OID 22803)
-- Name: idx_22031_idx_78089904b03a8386; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22031_idx_78089904b03a8386 ON public."case" USING btree (created_by_id);


--
-- TOC entry 3636 (class 1259 OID 22802)
-- Name: idx_22031_idx_78089904e540aea2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22031_idx_78089904e540aea2 ON public."case" USING btree (inbound_email_id);


--
-- TOC entry 3637 (class 1259 OID 22797)
-- Name: idx_22031_idx_78089904e7a1254a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22031_idx_78089904e7a1254a ON public."case" USING btree (contact_id);


--
-- TOC entry 3638 (class 1259 OID 22798)
-- Name: idx_22031_idx_case_assigned_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22031_idx_case_assigned_user ON public."case" USING btree (assigned_user_id, deleted);


--
-- TOC entry 3639 (class 1259 OID 22801)
-- Name: idx_22031_idx_case_assigned_user_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22031_idx_case_assigned_user_status ON public."case" USING btree (assigned_user_id, status);


--
-- TOC entry 3640 (class 1259 OID 22795)
-- Name: idx_22031_idx_case_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22031_idx_case_status ON public."case" USING btree (status, deleted);


--
-- TOC entry 3641 (class 1259 OID 22800)
-- Name: idx_22031_number; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22031_number ON public."case" USING btree (number);


--
-- TOC entry 3644 (class 1259 OID 22790)
-- Name: idx_22031_uniq_7808990496901f54; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22031_uniq_7808990496901f54 ON public."case" USING btree (number);


--
-- TOC entry 3645 (class 1259 OID 22789)
-- Name: idx_22044_idx_e3c11333cf10d4f5; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22044_idx_e3c11333cf10d4f5 ON public.case_contact USING btree (case_id);


--
-- TOC entry 3646 (class 1259 OID 22792)
-- Name: idx_22044_idx_e3c11333e7a1254a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22044_idx_e3c11333e7a1254a ON public.case_contact USING btree (contact_id);


--
-- TOC entry 3649 (class 1259 OID 22799)
-- Name: idx_22044_uniq_e3c11333cf10d4f5e7a1254a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22044_uniq_e3c11333cf10d4f5e7a1254a ON public.case_contact USING btree (case_id, contact_id);


--
-- TOC entry 3650 (class 1259 OID 22791)
-- Name: idx_22051_idx_fe20b419d68cded; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22051_idx_fe20b419d68cded ON public.case_knowledge_base_article USING btree (knowledge_base_article_id);


--
-- TOC entry 3651 (class 1259 OID 22794)
-- Name: idx_22051_idx_fe20b41cf10d4f5; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22051_idx_fe20b41cf10d4f5 ON public.case_knowledge_base_article USING btree (case_id);


--
-- TOC entry 3654 (class 1259 OID 22808)
-- Name: idx_22051_uniq_fe20b41cf10d4f59d68cded; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22051_uniq_fe20b41cf10d4f59d68cded ON public.case_knowledge_base_article USING btree (case_id, knowledge_base_article_id);


--
-- TOC entry 3655 (class 1259 OID 22810)
-- Name: idx_22056_idx_4c62e63899049ece; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22056_idx_4c62e63899049ece ON public.contact USING btree (modified_by_id);


--
-- TOC entry 3656 (class 1259 OID 22806)
-- Name: idx_22056_idx_4c62e6389b6b5fba; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22056_idx_4c62e6389b6b5fba ON public.contact USING btree (account_id);


--
-- TOC entry 3657 (class 1259 OID 22807)
-- Name: idx_22056_idx_4c62e638adf66b1a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22056_idx_4c62e638adf66b1a ON public.contact USING btree (assigned_user_id);


--
-- TOC entry 3658 (class 1259 OID 22815)
-- Name: idx_22056_idx_4c62e638b03a8386; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22056_idx_4c62e638b03a8386 ON public.contact USING btree (created_by_id);


--
-- TOC entry 3659 (class 1259 OID 22811)
-- Name: idx_22056_idx_4c62e638f639f774; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22056_idx_4c62e638f639f774 ON public.contact USING btree (campaign_id);


--
-- TOC entry 3660 (class 1259 OID 22817)
-- Name: idx_22056_idx_contact_assigned_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22056_idx_contact_assigned_user ON public.contact USING btree (assigned_user_id, deleted);


--
-- TOC entry 3661 (class 1259 OID 22805)
-- Name: idx_22056_idx_contact_first_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22056_idx_contact_first_name ON public.contact USING btree (first_name, deleted);


--
-- TOC entry 3662 (class 1259 OID 22804)
-- Name: idx_22056_idx_contact_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22056_idx_contact_name ON public.contact USING btree (first_name, last_name);


--
-- TOC entry 3665 (class 1259 OID 22812)
-- Name: idx_22068_idx_424c16e1c33f7837; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22068_idx_424c16e1c33f7837 ON public.contact_document USING btree (document_id);


--
-- TOC entry 3666 (class 1259 OID 22809)
-- Name: idx_22068_idx_424c16e1e7a1254a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22068_idx_424c16e1e7a1254a ON public.contact_document USING btree (contact_id);


--
-- TOC entry 3669 (class 1259 OID 22816)
-- Name: idx_22068_uniq_424c16e1e7a1254ac33f7837; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22068_uniq_424c16e1e7a1254ac33f7837 ON public.contact_document USING btree (contact_id, document_id);


--
-- TOC entry 3670 (class 1259 OID 22821)
-- Name: idx_22075_idx_6f3ac0b867433d9c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22075_idx_6f3ac0b867433d9c ON public.contact_meeting USING btree (meeting_id);


--
-- TOC entry 3671 (class 1259 OID 22830)
-- Name: idx_22075_idx_6f3ac0b8e7a1254a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22075_idx_6f3ac0b8e7a1254a ON public.contact_meeting USING btree (contact_id);


--
-- TOC entry 3674 (class 1259 OID 22829)
-- Name: idx_22075_uniq_6f3ac0b8e7a1254a67433d9c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22075_uniq_6f3ac0b8e7a1254a67433d9c ON public.contact_meeting USING btree (contact_id, meeting_id);


--
-- TOC entry 3675 (class 1259 OID 22828)
-- Name: idx_22083_idx_ed257c699a34590f; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22083_idx_ed257c699a34590f ON public.contact_opportunity USING btree (opportunity_id);


--
-- TOC entry 3676 (class 1259 OID 22823)
-- Name: idx_22083_idx_ed257c69e7a1254a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22083_idx_ed257c69e7a1254a ON public.contact_opportunity USING btree (contact_id);


--
-- TOC entry 3679 (class 1259 OID 22822)
-- Name: idx_22083_uniq_ed257c69e7a1254a9a34590f; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22083_uniq_ed257c69e7a1254a9a34590f ON public.contact_opportunity USING btree (contact_id, opportunity_id);


--
-- TOC entry 3680 (class 1259 OID 22820)
-- Name: idx_22090_idx_e77c5117e7a1254a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22090_idx_e77c5117e7a1254a ON public.contact_target_list USING btree (contact_id);


--
-- TOC entry 3681 (class 1259 OID 22819)
-- Name: idx_22090_idx_e77c5117f6c6afe0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22090_idx_e77c5117f6c6afe0 ON public.contact_target_list USING btree (target_list_id);


--
-- TOC entry 3684 (class 1259 OID 22827)
-- Name: idx_22090_uniq_e77c5117e7a1254af6c6afe0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22090_uniq_e77c5117e7a1254af6c6afe0 ON public.contact_target_list USING btree (contact_id, target_list_id);


--
-- TOC entry 3687 (class 1259 OID 22832)
-- Name: idx_22100_idx_d8698a76162cb942; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22100_idx_d8698a76162cb942 ON public.document USING btree (folder_id);


--
-- TOC entry 3688 (class 1259 OID 22833)
-- Name: idx_22100_idx_d8698a7693cb796c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22100_idx_d8698a7693cb796c ON public.document USING btree (file_id);


--
-- TOC entry 3689 (class 1259 OID 22836)
-- Name: idx_22100_idx_d8698a7699049ece; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22100_idx_d8698a7699049ece ON public.document USING btree (modified_by_id);


--
-- TOC entry 3690 (class 1259 OID 22845)
-- Name: idx_22100_idx_d8698a76adf66b1a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22100_idx_d8698a76adf66b1a ON public.document USING btree (assigned_user_id);


--
-- TOC entry 3691 (class 1259 OID 22841)
-- Name: idx_22100_idx_d8698a76b03a8386; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22100_idx_d8698a76b03a8386 ON public.document USING btree (created_by_id);


--
-- TOC entry 3694 (class 1259 OID 22844)
-- Name: idx_22108_idx_52c0b8ab727aca70; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22108_idx_52c0b8ab727aca70 ON public.document_folder USING btree (parent_id);


--
-- TOC entry 3695 (class 1259 OID 22848)
-- Name: idx_22108_idx_52c0b8ab99049ece; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22108_idx_52c0b8ab99049ece ON public.document_folder USING btree (modified_by_id);


--
-- TOC entry 3696 (class 1259 OID 22847)
-- Name: idx_22108_idx_52c0b8abb03a8386; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22108_idx_52c0b8abb03a8386 ON public.document_folder USING btree (created_by_id);


--
-- TOC entry 3699 (class 1259 OID 22835)
-- Name: idx_22117_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22117_id ON public.document_folder_path USING btree (id);


--
-- TOC entry 3700 (class 1259 OID 22834)
-- Name: idx_22117_idx_90629a7011fe3b6c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22117_idx_90629a7011fe3b6c ON public.document_folder_path USING btree (ascendor_id);


--
-- TOC entry 3701 (class 1259 OID 22840)
-- Name: idx_22117_idx_90629a709a21681a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22117_idx_90629a709a21681a ON public.document_folder_path USING btree (descendor_id);


--
-- TOC entry 3704 (class 1259 OID 22846)
-- Name: idx_22123_idx_8f25ed5855458d; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22123_idx_8f25ed5855458d ON public.document_lead USING btree (lead_id);


--
-- TOC entry 3705 (class 1259 OID 22837)
-- Name: idx_22123_idx_8f25ed58c33f7837; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22123_idx_8f25ed58c33f7837 ON public.document_lead USING btree (document_id);


--
-- TOC entry 3708 (class 1259 OID 22851)
-- Name: idx_22123_uniq_8f25ed58c33f783755458d; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22123_uniq_8f25ed58c33f783755458d ON public.document_lead USING btree (document_id, lead_id);


--
-- TOC entry 3709 (class 1259 OID 22864)
-- Name: idx_22130_idx_120f4bd9a34590f; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22130_idx_120f4bd9a34590f ON public.document_opportunity USING btree (opportunity_id);


--
-- TOC entry 3710 (class 1259 OID 22855)
-- Name: idx_22130_idx_120f4bdc33f7837; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22130_idx_120f4bdc33f7837 ON public.document_opportunity USING btree (document_id);


--
-- TOC entry 3713 (class 1259 OID 22859)
-- Name: idx_22130_uniq_120f4bdc33f78379a34590f; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22130_uniq_120f4bdc33f78379a34590f ON public.document_opportunity USING btree (document_id, opportunity_id);


--
-- TOC entry 3714 (class 1259 OID 22863)
-- Name: idx_22135_idx_e7927c7499049ece; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22135_idx_e7927c7499049ece ON public.email USING btree (modified_by_id);


--
-- TOC entry 3715 (class 1259 OID 22857)
-- Name: idx_22135_idx_e7927c749b6b5fba; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22135_idx_e7927c749b6b5fba ON public.email USING btree (account_id);


--
-- TOC entry 3716 (class 1259 OID 22852)
-- Name: idx_22135_idx_e7927c74a45bb98c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22135_idx_e7927c74a45bb98c ON public.email USING btree (sent_by_id);


--
-- TOC entry 3717 (class 1259 OID 22850)
-- Name: idx_22135_idx_e7927c74adf66b1a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22135_idx_e7927c74adf66b1a ON public.email USING btree (assigned_user_id);


--
-- TOC entry 3718 (class 1259 OID 22849)
-- Name: idx_22135_idx_e7927c74b03a8386; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22135_idx_e7927c74b03a8386 ON public.email USING btree (created_by_id);


--
-- TOC entry 3719 (class 1259 OID 22854)
-- Name: idx_22135_idx_e7927c74b4e994e0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22135_idx_e7927c74b4e994e0 ON public.email USING btree (replied_id);


--
-- TOC entry 3720 (class 1259 OID 22856)
-- Name: idx_22135_idx_e7927c74d445573a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22135_idx_e7927c74d445573a ON public.email USING btree (from_email_address_id);


--
-- TOC entry 3721 (class 1259 OID 22860)
-- Name: idx_22135_idx_email_date_sent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22135_idx_email_date_sent ON public.email USING btree (date_sent, deleted);


--
-- TOC entry 3722 (class 1259 OID 22862)
-- Name: idx_22135_idx_email_date_sent_assigned_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22135_idx_email_date_sent_assigned_user ON public.email USING btree (date_sent, assigned_user_id);


--
-- TOC entry 3723 (class 1259 OID 22861)
-- Name: idx_22135_idx_email_date_sent_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22135_idx_email_date_sent_status ON public.email USING btree (date_sent, status, deleted);


--
-- TOC entry 3724 (class 1259 OID 22866)
-- Name: idx_22135_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22135_parent ON public.email USING btree (parent_id, parent_type);


--
-- TOC entry 3727 (class 1259 OID 22877)
-- Name: idx_22147_idx_c0f63e6b19272669; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22147_idx_c0f63e6b19272669 ON public.email_account USING btree (email_folder_id);


--
-- TOC entry 3728 (class 1259 OID 22867)
-- Name: idx_22147_idx_c0f63e6b99049ece; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22147_idx_c0f63e6b99049ece ON public.email_account USING btree (modified_by_id);


--
-- TOC entry 3729 (class 1259 OID 22870)
-- Name: idx_22147_idx_c0f63e6badf66b1a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22147_idx_c0f63e6badf66b1a ON public.email_account USING btree (assigned_user_id);


--
-- TOC entry 3730 (class 1259 OID 22876)
-- Name: idx_22147_idx_c0f63e6bb03a8386; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22147_idx_c0f63e6bb03a8386 ON public.email_account USING btree (created_by_id);


--
-- TOC entry 3733 (class 1259 OID 22875)
-- Name: idx_22162_idx_b08e074ee9a7b23; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22162_idx_b08e074ee9a7b23 ON public.email_address USING btree (lower);


--
-- TOC entry 3736 (class 1259 OID 22853)
-- Name: idx_22173_idx_32c12dc337d8ad65; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22173_idx_32c12dc337d8ad65 ON public.email_email_account USING btree (email_account_id);


--
-- TOC entry 3737 (class 1259 OID 22878)
-- Name: idx_22173_idx_32c12dc3a832c1c9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22173_idx_32c12dc3a832c1c9 ON public.email_email_account USING btree (email_id);


--
-- TOC entry 3740 (class 1259 OID 22871)
-- Name: idx_22173_uniq_32c12dc3a832c1c937d8ad65; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22173_uniq_32c12dc3a832c1c937d8ad65 ON public.email_email_account USING btree (email_id, email_account_id);


--
-- TOC entry 3741 (class 1259 OID 22869)
-- Name: idx_22180_idx_42b914e659045daa; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22180_idx_42b914e659045daa ON public.email_email_address USING btree (email_address_id);


--
-- TOC entry 3742 (class 1259 OID 22879)
-- Name: idx_22180_idx_42b914e6a832c1c9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22180_idx_42b914e6a832c1c9 ON public.email_email_address USING btree (email_id);


--
-- TOC entry 3745 (class 1259 OID 22883)
-- Name: idx_22180_uniq_42b914e6a832c1c959045daaf19287c2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22180_uniq_42b914e6a832c1c959045daaf19287c2 ON public.email_email_address USING btree (email_id, email_address_id, address_type);


--
-- TOC entry 3746 (class 1259 OID 22889)
-- Name: idx_22185_idx_25e8ced19272669; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22185_idx_25e8ced19272669 ON public.email_filter USING btree (email_folder_id);


--
-- TOC entry 3747 (class 1259 OID 22882)
-- Name: idx_22185_idx_25e8ced99049ece; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22185_idx_25e8ced99049ece ON public.email_filter USING btree (modified_by_id);


--
-- TOC entry 3748 (class 1259 OID 22887)
-- Name: idx_22185_idx_25e8cedb03a8386; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22185_idx_25e8cedb03a8386 ON public.email_filter USING btree (created_by_id);


--
-- TOC entry 3749 (class 1259 OID 22892)
-- Name: idx_22185_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22185_parent ON public.email_filter USING btree (parent_id, parent_type);


--
-- TOC entry 3752 (class 1259 OID 22886)
-- Name: idx_22194_idx_9138da3d99049ece; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22194_idx_9138da3d99049ece ON public.email_folder USING btree (modified_by_id);


--
-- TOC entry 3753 (class 1259 OID 22868)
-- Name: idx_22194_idx_9138da3dadf66b1a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22194_idx_9138da3dadf66b1a ON public.email_folder USING btree (assigned_user_id);


--
-- TOC entry 3754 (class 1259 OID 22872)
-- Name: idx_22194_idx_9138da3db03a8386; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22194_idx_9138da3db03a8386 ON public.email_folder USING btree (created_by_id);


--
-- TOC entry 3757 (class 1259 OID 22890)
-- Name: idx_22201_idx_41d62720a832c1c9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22201_idx_41d62720a832c1c9 ON public.email_inbound_email USING btree (email_id);


--
-- TOC entry 3758 (class 1259 OID 22894)
-- Name: idx_22201_idx_41d62720e540aea2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22201_idx_41d62720e540aea2 ON public.email_inbound_email USING btree (inbound_email_id);


--
-- TOC entry 3761 (class 1259 OID 22884)
-- Name: idx_22201_uniq_41d62720a832c1c9e540aea2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22201_uniq_41d62720a832c1c9e540aea2 ON public.email_inbound_email USING btree (email_id, inbound_email_id);


--
-- TOC entry 3762 (class 1259 OID 22896)
-- Name: idx_22206_idx_16f89f37ef1946ab; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22206_idx_16f89f37ef1946ab ON public.email_queue_item USING btree (mass_email_id);


--
-- TOC entry 3765 (class 1259 OID 22904)
-- Name: idx_22206_target; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22206_target ON public.email_queue_item USING btree (target_id, target_type);


--
-- TOC entry 3766 (class 1259 OID 22897)
-- Name: idx_22215_idx_9c0600ca99049ece; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22215_idx_9c0600ca99049ece ON public.email_template USING btree (modified_by_id);


--
-- TOC entry 3767 (class 1259 OID 22901)
-- Name: idx_22215_idx_9c0600caadf66b1a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22215_idx_9c0600caadf66b1a ON public.email_template USING btree (assigned_user_id);


--
-- TOC entry 3768 (class 1259 OID 22906)
-- Name: idx_22215_idx_9c0600cab03a8386; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22215_idx_9c0600cab03a8386 ON public.email_template USING btree (created_by_id);


--
-- TOC entry 3771 (class 1259 OID 22903)
-- Name: idx_22226_idx_12a5f6cca76ed395; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22226_idx_12a5f6cca76ed395 ON public.email_user USING btree (user_id);


--
-- TOC entry 3772 (class 1259 OID 22888)
-- Name: idx_22226_idx_12a5f6cca832c1c9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22226_idx_12a5f6cca832c1c9 ON public.email_user USING btree (email_id);


--
-- TOC entry 3775 (class 1259 OID 22899)
-- Name: idx_22226_uniq_12a5f6cca832c1c9a76ed395; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22226_uniq_12a5f6cca832c1c9a76ed395 ON public.email_user USING btree (email_id, user_id);


--
-- TOC entry 3776 (class 1259 OID 22900)
-- Name: idx_22236_idx_9125ab4259045daa; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22236_idx_9125ab4259045daa ON public.entity_email_address USING btree (email_address_id);


--
-- TOC entry 3777 (class 1259 OID 22908)
-- Name: idx_22236_idx_9125ab4281257d5d; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22236_idx_9125ab4281257d5d ON public.entity_email_address USING btree (entity_id);


--
-- TOC entry 3780 (class 1259 OID 22907)
-- Name: idx_22236_uniq_9125ab4281257d5d59045daac412ee02; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22236_uniq_9125ab4281257d5d59045daac412ee02 ON public.entity_email_address USING btree (entity_id, email_address_id, entity_type);


--
-- TOC entry 3781 (class 1259 OID 22911)
-- Name: idx_22244_idx_7459056f39dfd528; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22244_idx_7459056f39dfd528 ON public.entity_phone_number USING btree (phone_number_id);


--
-- TOC entry 3782 (class 1259 OID 22913)
-- Name: idx_22244_idx_7459056f81257d5d; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22244_idx_7459056f81257d5d ON public.entity_phone_number USING btree (entity_id);


--
-- TOC entry 3785 (class 1259 OID 22912)
-- Name: idx_22244_uniq_7459056f81257d5d39dfd528c412ee02; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22244_uniq_7459056f81257d5d39dfd528c412ee02 ON public.entity_phone_number USING btree (entity_id, phone_number_id, entity_type);


--
-- TOC entry 3786 (class 1259 OID 22925)
-- Name: idx_22252_idx_8c2c1f34296cd8ae; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22252_idx_8c2c1f34296cd8ae ON public.entity_team USING btree (team_id);


--
-- TOC entry 3787 (class 1259 OID 22916)
-- Name: idx_22252_idx_8c2c1f3481257d5d; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22252_idx_8c2c1f3481257d5d ON public.entity_team USING btree (entity_id);


--
-- TOC entry 3790 (class 1259 OID 22920)
-- Name: idx_22252_uniq_8c2c1f3481257d5d296cd8aec412ee02; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22252_uniq_8c2c1f3481257d5d296cd8aec412ee02 ON public.entity_team USING btree (entity_id, team_id, entity_type);


--
-- TOC entry 3791 (class 1259 OID 22910)
-- Name: idx_22259_idx_c55f6f6281257d5d; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22259_idx_c55f6f6281257d5d ON public.entity_user USING btree (entity_id);


--
-- TOC entry 3792 (class 1259 OID 22902)
-- Name: idx_22259_idx_c55f6f62a76ed395; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22259_idx_c55f6f62a76ed395 ON public.entity_user USING btree (user_id);


--
-- TOC entry 3795 (class 1259 OID 22924)
-- Name: idx_22259_uniq_c55f6f6281257d5da76ed395c412ee02; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22259_uniq_c55f6f6281257d5da76ed395c412ee02 ON public.entity_user USING btree (entity_id, user_id, entity_type);


--
-- TOC entry 3796 (class 1259 OID 22918)
-- Name: idx_22264_idx_9fb73d77b03a8386; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22264_idx_9fb73d77b03a8386 ON public.extension USING btree (created_by_id);


--
-- TOC entry 3801 (class 1259 OID 22927)
-- Name: idx_22280_idx_9d4ece1d93cb796c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22280_idx_9d4ece1d93cb796c ON public.import USING btree (file_id);


--
-- TOC entry 3802 (class 1259 OID 22929)
-- Name: idx_22280_idx_9d4ece1db03a8386; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22280_idx_9d4ece1db03a8386 ON public.import USING btree (created_by_id);


--
-- TOC entry 3805 (class 1259 OID 22926)
-- Name: idx_22289_entity; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22289_entity ON public.import_entity USING btree (entity_id, entity_type);


--
-- TOC entry 3806 (class 1259 OID 22932)
-- Name: idx_22289_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22289_id ON public.import_entity USING btree (id);


--
-- TOC entry 3807 (class 1259 OID 22936)
-- Name: idx_22289_idx_7219fe70b6a263d9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22289_idx_7219fe70b6a263d9 ON public.import_entity USING btree (import_id);


--
-- TOC entry 3808 (class 1259 OID 22939)
-- Name: idx_22289_idx_import_entity_entity_import; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22289_idx_import_entity_entity_import ON public.import_entity USING btree (import_id, entity_type);


--
-- TOC entry 3811 (class 1259 OID 22921)
-- Name: idx_22296_idx_b3e13488296cd8ae; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22296_idx_b3e13488296cd8ae ON public.inbound_email USING btree (team_id);


--
-- TOC entry 3812 (class 1259 OID 22923)
-- Name: idx_22296_idx_b3e134885ae5a3f7; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22296_idx_b3e134885ae5a3f7 ON public.inbound_email USING btree (reply_email_template_id);


--
-- TOC entry 3813 (class 1259 OID 22928)
-- Name: idx_22296_idx_b3e134886d716643; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22296_idx_b3e134886d716643 ON public.inbound_email USING btree (assign_to_user_id);


--
-- TOC entry 3814 (class 1259 OID 22935)
-- Name: idx_22296_idx_b3e1348899049ece; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22296_idx_b3e1348899049ece ON public.inbound_email USING btree (modified_by_id);


--
-- TOC entry 3815 (class 1259 OID 22940)
-- Name: idx_22296_idx_b3e13488b03a8386; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22296_idx_b3e13488b03a8386 ON public.inbound_email USING btree (created_by_id);


--
-- TOC entry 3820 (class 1259 OID 22941)
-- Name: idx_22318_idx_fbd8e0f8a71ecab0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22318_idx_fbd8e0f8a71ecab0 ON public.job USING btree (scheduled_job_id);


--
-- TOC entry 3821 (class 1259 OID 22943)
-- Name: idx_22318_idx_job_execute_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22318_idx_job_execute_time ON public.job USING btree (status, execute_time);


--
-- TOC entry 3822 (class 1259 OID 22948)
-- Name: idx_22318_idx_job_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22318_idx_job_status ON public.job USING btree (status, deleted);


--
-- TOC entry 3825 (class 1259 OID 22951)
-- Name: idx_22326_idx_9815b63099049ece; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22326_idx_9815b63099049ece ON public.knowledge_base_article USING btree (modified_by_id);


--
-- TOC entry 3826 (class 1259 OID 22945)
-- Name: idx_22326_idx_9815b630adf66b1a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22326_idx_9815b630adf66b1a ON public.knowledge_base_article USING btree (assigned_user_id);


--
-- TOC entry 3827 (class 1259 OID 22953)
-- Name: idx_22326_idx_9815b630b03a8386; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22326_idx_9815b630b03a8386 ON public.knowledge_base_article USING btree (created_by_id);


--
-- TOC entry 3830 (class 1259 OID 22934)
-- Name: idx_22337_idx_35b2d2ac35ab2003; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22337_idx_35b2d2ac35ab2003 ON public.knowledge_base_article_knowledge_base_category USING btree (knowledge_base_category_id);


--
-- TOC entry 3831 (class 1259 OID 22931)
-- Name: idx_22337_idx_35b2d2ac9d68cded; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22337_idx_35b2d2ac9d68cded ON public.knowledge_base_article_knowledge_base_category USING btree (knowledge_base_article_id);


--
-- TOC entry 3834 (class 1259 OID 22947)
-- Name: idx_22337_uniq_35b2d2ac9d68cded35ab2003; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22337_uniq_35b2d2ac9d68cded35ab2003 ON public.knowledge_base_article_knowledge_base_category USING btree (knowledge_base_article_id, knowledge_base_category_id);


--
-- TOC entry 3835 (class 1259 OID 22955)
-- Name: idx_22344_idx_4699f0f09d68cded; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22344_idx_4699f0f09d68cded ON public.knowledge_base_article_portal USING btree (knowledge_base_article_id);


--
-- TOC entry 3836 (class 1259 OID 22946)
-- Name: idx_22344_idx_4699f0f0b887e1dd; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22344_idx_4699f0f0b887e1dd ON public.knowledge_base_article_portal USING btree (portal_id);


--
-- TOC entry 3839 (class 1259 OID 22956)
-- Name: idx_22344_uniq_4699f0f0b887e1dd9d68cded; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22344_uniq_4699f0f0b887e1dd9d68cded ON public.knowledge_base_article_portal USING btree (portal_id, knowledge_base_article_id);


--
-- TOC entry 3840 (class 1259 OID 22958)
-- Name: idx_22349_idx_84dec2b8727aca70; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22349_idx_84dec2b8727aca70 ON public.knowledge_base_category USING btree (parent_id);


--
-- TOC entry 3841 (class 1259 OID 22966)
-- Name: idx_22349_idx_84dec2b899049ece; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22349_idx_84dec2b899049ece ON public.knowledge_base_category USING btree (modified_by_id);


--
-- TOC entry 3842 (class 1259 OID 22950)
-- Name: idx_22349_idx_84dec2b8b03a8386; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22349_idx_84dec2b8b03a8386 ON public.knowledge_base_category USING btree (created_by_id);


--
-- TOC entry 3845 (class 1259 OID 22963)
-- Name: idx_22358_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22358_id ON public.knowledge_base_category_path USING btree (id);


--
-- TOC entry 3846 (class 1259 OID 22971)
-- Name: idx_22358_idx_727adb3911fe3b6c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22358_idx_727adb3911fe3b6c ON public.knowledge_base_category_path USING btree (ascendor_id);


--
-- TOC entry 3847 (class 1259 OID 22969)
-- Name: idx_22358_idx_727adb399a21681a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22358_idx_727adb399a21681a ON public.knowledge_base_category_path USING btree (descendor_id);


--
-- TOC entry 3850 (class 1259 OID 22952)
-- Name: idx_22362_idx_289161cb3aef561b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22362_idx_289161cb3aef561b ON public.lead USING btree (created_account_id);


--
-- TOC entry 3851 (class 1259 OID 22959)
-- Name: idx_22362_idx_289161cb46252ceb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22362_idx_289161cb46252ceb ON public.lead USING btree (created_contact_id);


--
-- TOC entry 3852 (class 1259 OID 22960)
-- Name: idx_22362_idx_289161cb99049ece; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22362_idx_289161cb99049ece ON public.lead USING btree (modified_by_id);


--
-- TOC entry 3853 (class 1259 OID 22972)
-- Name: idx_22362_idx_289161cb9e0cd2d1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22362_idx_289161cb9e0cd2d1 ON public.lead USING btree (created_opportunity_id);


--
-- TOC entry 3854 (class 1259 OID 22962)
-- Name: idx_22362_idx_289161cbadf66b1a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22362_idx_289161cbadf66b1a ON public.lead USING btree (assigned_user_id);


--
-- TOC entry 3855 (class 1259 OID 22968)
-- Name: idx_22362_idx_289161cbb03a8386; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22362_idx_289161cbb03a8386 ON public.lead USING btree (created_by_id);


--
-- TOC entry 3856 (class 1259 OID 22970)
-- Name: idx_22362_idx_289161cbf639f774; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22362_idx_289161cbf639f774 ON public.lead USING btree (campaign_id);


--
-- TOC entry 3857 (class 1259 OID 22973)
-- Name: idx_22362_idx_lead_assigned_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22362_idx_lead_assigned_user ON public.lead USING btree (assigned_user_id, deleted);


--
-- TOC entry 3858 (class 1259 OID 22980)
-- Name: idx_22362_idx_lead_assigned_user_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22362_idx_lead_assigned_user_status ON public.lead USING btree (assigned_user_id, status);


--
-- TOC entry 3859 (class 1259 OID 22967)
-- Name: idx_22362_idx_lead_created_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22362_idx_lead_created_at ON public.lead USING btree (created_at, deleted);


--
-- TOC entry 3860 (class 1259 OID 22982)
-- Name: idx_22362_idx_lead_created_at_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22362_idx_lead_created_at_status ON public.lead USING btree (created_at, status);


--
-- TOC entry 3861 (class 1259 OID 22976)
-- Name: idx_22362_idx_lead_first_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22362_idx_lead_first_name ON public.lead USING btree (first_name, deleted);


--
-- TOC entry 3862 (class 1259 OID 22988)
-- Name: idx_22362_idx_lead_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22362_idx_lead_name ON public.lead USING btree (first_name, last_name);


--
-- TOC entry 3863 (class 1259 OID 22983)
-- Name: idx_22362_idx_lead_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22362_idx_lead_status ON public.lead USING btree (status, deleted);


--
-- TOC entry 3866 (class 1259 OID 22965)
-- Name: idx_22377_idx_acdbbd5755458d; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22377_idx_acdbbd5755458d ON public.lead_meeting USING btree (lead_id);


--
-- TOC entry 3867 (class 1259 OID 22974)
-- Name: idx_22377_idx_acdbbd5767433d9c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22377_idx_acdbbd5767433d9c ON public.lead_meeting USING btree (meeting_id);


--
-- TOC entry 3870 (class 1259 OID 22987)
-- Name: idx_22377_uniq_acdbbd5755458d67433d9c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22377_uniq_acdbbd5755458d67433d9c ON public.lead_meeting USING btree (lead_id, meeting_id);


--
-- TOC entry 3871 (class 1259 OID 22975)
-- Name: idx_22385_idx_7041aadd55458d; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22385_idx_7041aadd55458d ON public.lead_target_list USING btree (lead_id);


--
-- TOC entry 3872 (class 1259 OID 22985)
-- Name: idx_22385_idx_7041aaddf6c6afe0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22385_idx_7041aaddf6c6afe0 ON public.lead_target_list USING btree (target_list_id);


--
-- TOC entry 3875 (class 1259 OID 22984)
-- Name: idx_22385_uniq_7041aadd55458df6c6afe0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22385_uniq_7041aadd55458df6c6afe0 ON public.lead_target_list USING btree (lead_id, target_list_id);


--
-- TOC entry 3876 (class 1259 OID 22992)
-- Name: idx_22391_idx_afbc1fdf131a730f; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22391_idx_afbc1fdf131a730f ON public.mass_email USING btree (email_template_id);


--
-- TOC entry 3877 (class 1259 OID 22979)
-- Name: idx_22391_idx_afbc1fdf99049ece; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22391_idx_afbc1fdf99049ece ON public.mass_email USING btree (modified_by_id);


--
-- TOC entry 3878 (class 1259 OID 22990)
-- Name: idx_22391_idx_afbc1fdfb03a8386; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22391_idx_afbc1fdfb03a8386 ON public.mass_email USING btree (created_by_id);


--
-- TOC entry 3879 (class 1259 OID 22997)
-- Name: idx_22391_idx_afbc1fdfe540aea2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22391_idx_afbc1fdfe540aea2 ON public.mass_email USING btree (inbound_email_id);


--
-- TOC entry 3880 (class 1259 OID 23000)
-- Name: idx_22391_idx_afbc1fdff639f774; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22391_idx_afbc1fdff639f774 ON public.mass_email USING btree (campaign_id);


--
-- TOC entry 3883 (class 1259 OID 22978)
-- Name: idx_22403_idx_6b9ce04def1946ab; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22403_idx_6b9ce04def1946ab ON public.mass_email_target_list USING btree (mass_email_id);


--
-- TOC entry 3884 (class 1259 OID 22981)
-- Name: idx_22403_idx_6b9ce04df6c6afe0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22403_idx_6b9ce04df6c6afe0 ON public.mass_email_target_list USING btree (target_list_id);


--
-- TOC entry 3887 (class 1259 OID 22993)
-- Name: idx_22403_uniq_6b9ce04def1946abf6c6afe0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22403_uniq_6b9ce04def1946abf6c6afe0 ON public.mass_email_target_list USING btree (mass_email_id, target_list_id);


--
-- TOC entry 3888 (class 1259 OID 23002)
-- Name: idx_22410_idx_4d889be8ef1946ab; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22410_idx_4d889be8ef1946ab ON public.mass_email_target_list_excluding USING btree (mass_email_id);


--
-- TOC entry 3889 (class 1259 OID 22991)
-- Name: idx_22410_idx_4d889be8f6c6afe0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22410_idx_4d889be8f6c6afe0 ON public.mass_email_target_list_excluding USING btree (target_list_id);


--
-- TOC entry 3892 (class 1259 OID 22998)
-- Name: idx_22410_uniq_4d889be8ef1946abf6c6afe0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22410_uniq_4d889be8ef1946abf6c6afe0 ON public.mass_email_target_list_excluding USING btree (mass_email_id, target_list_id);


--
-- TOC entry 3893 (class 1259 OID 22999)
-- Name: idx_22415_idx_f515e13999049ece; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22415_idx_f515e13999049ece ON public.meeting USING btree (modified_by_id);


--
-- TOC entry 3894 (class 1259 OID 23010)
-- Name: idx_22415_idx_f515e1399b6b5fba; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22415_idx_f515e1399b6b5fba ON public.meeting USING btree (account_id);


--
-- TOC entry 3895 (class 1259 OID 22996)
-- Name: idx_22415_idx_f515e139adf66b1a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22415_idx_f515e139adf66b1a ON public.meeting USING btree (assigned_user_id);


--
-- TOC entry 3896 (class 1259 OID 23005)
-- Name: idx_22415_idx_f515e139b03a8386; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22415_idx_f515e139b03a8386 ON public.meeting USING btree (created_by_id);


--
-- TOC entry 3897 (class 1259 OID 23009)
-- Name: idx_22415_idx_meeting_assigned_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22415_idx_meeting_assigned_user ON public.meeting USING btree (assigned_user_id, deleted);


--
-- TOC entry 3898 (class 1259 OID 23017)
-- Name: idx_22415_idx_meeting_assigned_user_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22415_idx_meeting_assigned_user_status ON public.meeting USING btree (assigned_user_id, status);


--
-- TOC entry 3899 (class 1259 OID 23018)
-- Name: idx_22415_idx_meeting_date_start; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22415_idx_meeting_date_start ON public.meeting USING btree (date_start, deleted);


--
-- TOC entry 3900 (class 1259 OID 22994)
-- Name: idx_22415_idx_meeting_date_start_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22415_idx_meeting_date_start_status ON public.meeting USING btree (date_start, status);


--
-- TOC entry 3901 (class 1259 OID 22995)
-- Name: idx_22415_idx_meeting_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22415_idx_meeting_status ON public.meeting USING btree (status, deleted);


--
-- TOC entry 3902 (class 1259 OID 23004)
-- Name: idx_22415_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22415_parent ON public.meeting USING btree (parent_id, parent_type);


--
-- TOC entry 3905 (class 1259 OID 23016)
-- Name: idx_22425_idx_61622e9b67433d9c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22425_idx_61622e9b67433d9c ON public.meeting_user USING btree (meeting_id);


--
-- TOC entry 3906 (class 1259 OID 23012)
-- Name: idx_22425_idx_61622e9ba76ed395; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22425_idx_61622e9ba76ed395 ON public.meeting_user USING btree (user_id);


--
-- TOC entry 3909 (class 1259 OID 23013)
-- Name: idx_22425_uniq_61622e9ba76ed39567433d9c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22425_uniq_61622e9ba76ed39567433d9c ON public.meeting_user USING btree (user_id, meeting_id);


--
-- TOC entry 3910 (class 1259 OID 23014)
-- Name: idx_22431_idx_cf451ae8c412ee02; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22431_idx_cf451ae8c412ee02 ON public.next_number USING btree (entity_type);


--
-- TOC entry 3913 (class 1259 OID 23007)
-- Name: idx_22441_idx_cfbdfa1499049ece; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22441_idx_cfbdfa1499049ece ON public.note USING btree (modified_by_id);


--
-- TOC entry 3914 (class 1259 OID 23020)
-- Name: idx_22441_idx_cfbdfa14b03a8386; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22441_idx_cfbdfa14b03a8386 ON public.note USING btree (created_by_id);


--
-- TOC entry 3915 (class 1259 OID 23026)
-- Name: idx_22441_idx_note_created_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22441_idx_note_created_at ON public.note USING btree (created_at);


--
-- TOC entry 3916 (class 1259 OID 23033)
-- Name: idx_22441_idx_note_parent_and_super_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22441_idx_note_parent_and_super_parent ON public.note USING btree (parent_id, parent_type, super_parent_id, super_parent_type);


--
-- TOC entry 3917 (class 1259 OID 23028)
-- Name: idx_22441_number; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22441_number ON public.note USING btree (number);


--
-- TOC entry 3918 (class 1259 OID 23011)
-- Name: idx_22441_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22441_parent ON public.note USING btree (parent_id, parent_type);


--
-- TOC entry 3921 (class 1259 OID 23019)
-- Name: idx_22441_related; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22441_related ON public.note USING btree (related_id, related_type);


--
-- TOC entry 3922 (class 1259 OID 23025)
-- Name: idx_22441_superparent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22441_superparent ON public.note USING btree (super_parent_id, super_parent_type);


--
-- TOC entry 3923 (class 1259 OID 23031)
-- Name: idx_22441_uniq_cfbdfa1496901f54; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22441_uniq_cfbdfa1496901f54 ON public.note USING btree (number);


--
-- TOC entry 3924 (class 1259 OID 23021)
-- Name: idx_22453_idx_137cc42426ed0855; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22453_idx_137cc42426ed0855 ON public.note_portal USING btree (note_id);


--
-- TOC entry 3925 (class 1259 OID 23032)
-- Name: idx_22453_idx_137cc424b887e1dd; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22453_idx_137cc424b887e1dd ON public.note_portal USING btree (portal_id);


--
-- TOC entry 3928 (class 1259 OID 23030)
-- Name: idx_22453_uniq_137cc42426ed0855b887e1dd; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22453_uniq_137cc42426ed0855b887e1dd ON public.note_portal USING btree (note_id, portal_id);


--
-- TOC entry 3929 (class 1259 OID 23038)
-- Name: idx_22460_idx_649ab74726ed0855; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22460_idx_649ab74726ed0855 ON public.note_team USING btree (note_id);


--
-- TOC entry 3930 (class 1259 OID 23023)
-- Name: idx_22460_idx_649ab747296cd8ae; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22460_idx_649ab747296cd8ae ON public.note_team USING btree (team_id);


--
-- TOC entry 3933 (class 1259 OID 23035)
-- Name: idx_22460_uniq_649ab74726ed0855296cd8ae; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22460_uniq_649ab74726ed0855296cd8ae ON public.note_team USING btree (note_id, team_id);


--
-- TOC entry 3934 (class 1259 OID 23046)
-- Name: idx_22467_idx_2de9c71126ed0855; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22467_idx_2de9c71126ed0855 ON public.note_user USING btree (note_id);


--
-- TOC entry 3935 (class 1259 OID 23048)
-- Name: idx_22467_idx_2de9c711a76ed395; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22467_idx_2de9c711a76ed395 ON public.note_user USING btree (user_id);


--
-- TOC entry 3938 (class 1259 OID 23027)
-- Name: idx_22467_uniq_2de9c71126ed0855a76ed395; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22467_uniq_2de9c71126ed0855a76ed395 ON public.note_user USING btree (note_id, user_id);


--
-- TOC entry 3939 (class 1259 OID 23034)
-- Name: idx_22474_idx_bf5476caa76ed395; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22474_idx_bf5476caa76ed395 ON public.notification USING btree (user_id);


--
-- TOC entry 3940 (class 1259 OID 23036)
-- Name: idx_22474_idx_notification_created_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22474_idx_notification_created_at ON public.notification USING btree (created_at);


--
-- TOC entry 3941 (class 1259 OID 23047)
-- Name: idx_22474_idx_notification_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22474_idx_notification_user ON public.notification USING btree (user_id, created_at);


--
-- TOC entry 3942 (class 1259 OID 23041)
-- Name: idx_22474_number; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22474_number ON public.notification USING btree (number);


--
-- TOC entry 3945 (class 1259 OID 23044)
-- Name: idx_22474_related; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22474_related ON public.notification USING btree (related_id, related_type);


--
-- TOC entry 3946 (class 1259 OID 23045)
-- Name: idx_22474_relatedparent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22474_relatedparent ON public.notification USING btree (related_parent_id, related_parent_type);


--
-- TOC entry 3947 (class 1259 OID 23055)
-- Name: idx_22474_uniq_bf5476ca96901f54; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22474_uniq_bf5476ca96901f54 ON public.notification USING btree (number);


--
-- TOC entry 3948 (class 1259 OID 23040)
-- Name: idx_22484_idx_8389c3d799049ece; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22484_idx_8389c3d799049ece ON public.opportunity USING btree (modified_by_id);


--
-- TOC entry 3949 (class 1259 OID 23051)
-- Name: idx_22484_idx_8389c3d79b6b5fba; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22484_idx_8389c3d79b6b5fba ON public.opportunity USING btree (account_id);


--
-- TOC entry 3950 (class 1259 OID 23050)
-- Name: idx_22484_idx_8389c3d7adf66b1a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22484_idx_8389c3d7adf66b1a ON public.opportunity USING btree (assigned_user_id);


--
-- TOC entry 3951 (class 1259 OID 23060)
-- Name: idx_22484_idx_8389c3d7b03a8386; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22484_idx_8389c3d7b03a8386 ON public.opportunity USING btree (created_by_id);


--
-- TOC entry 3952 (class 1259 OID 23059)
-- Name: idx_22484_idx_8389c3d7f639f774; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22484_idx_8389c3d7f639f774 ON public.opportunity USING btree (campaign_id);


--
-- TOC entry 3953 (class 1259 OID 23037)
-- Name: idx_22484_idx_opportunity_assigned_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22484_idx_opportunity_assigned_user ON public.opportunity USING btree (assigned_user_id, deleted);


--
-- TOC entry 3954 (class 1259 OID 23042)
-- Name: idx_22484_idx_opportunity_assigned_user_stage; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22484_idx_opportunity_assigned_user_stage ON public.opportunity USING btree (assigned_user_id, stage);


--
-- TOC entry 3955 (class 1259 OID 23049)
-- Name: idx_22484_idx_opportunity_created_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22484_idx_opportunity_created_at ON public.opportunity USING btree (created_at, deleted);


--
-- TOC entry 3956 (class 1259 OID 23052)
-- Name: idx_22484_idx_opportunity_created_at_stage; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22484_idx_opportunity_created_at_stage ON public.opportunity USING btree (created_at, stage);


--
-- TOC entry 3957 (class 1259 OID 23061)
-- Name: idx_22484_idx_opportunity_stage; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22484_idx_opportunity_stage ON public.opportunity USING btree (stage, deleted);


--
-- TOC entry 3960 (class 1259 OID 23062)
-- Name: idx_22493_idx_ac3a261f427eb8a5; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22493_idx_ac3a261f427eb8a5 ON public.password_change_request USING btree (request_id);


--
-- TOC entry 3961 (class 1259 OID 23063)
-- Name: idx_22493_idx_ac3a261fa76ed395; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22493_idx_ac3a261fa76ed395 ON public.password_change_request USING btree (user_id);


--
-- TOC entry 3964 (class 1259 OID 23066)
-- Name: idx_22497_idx_6b01bc5b5e237e06; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22497_idx_6b01bc5b5e237e06 ON public.phone_number USING btree (name);


--
-- TOC entry 3967 (class 1259 OID 23070)
-- Name: idx_22501_idx_bae93f0614a603a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22501_idx_bae93f0614a603a ON public.portal USING btree (custom_id);


--
-- TOC entry 3968 (class 1259 OID 23065)
-- Name: idx_22501_idx_bae93f099049ece; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22501_idx_bae93f099049ece ON public.portal USING btree (modified_by_id);


--
-- TOC entry 3969 (class 1259 OID 23073)
-- Name: idx_22501_idx_bae93f0b03a8386; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22501_idx_bae93f0b03a8386 ON public.portal USING btree (created_by_id);


--
-- TOC entry 3970 (class 1259 OID 23078)
-- Name: idx_22501_idx_bae93f0d9dd0e9d; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22501_idx_bae93f0d9dd0e9d ON public.portal USING btree (company_logo_id);


--
-- TOC entry 3971 (class 1259 OID 23054)
-- Name: idx_22501_idx_bae93f0f98f144a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22501_idx_bae93f0f98f144a ON public.portal USING btree (logo_id);


--
-- TOC entry 3974 (class 1259 OID 23064)
-- Name: idx_22517_idx_b29e22c7b887e1dd; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22517_idx_b29e22c7b887e1dd ON public.portal_portal_role USING btree (portal_id);


--
-- TOC entry 3975 (class 1259 OID 23068)
-- Name: idx_22517_idx_b29e22c7d7c6fab5; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22517_idx_b29e22c7d7c6fab5 ON public.portal_portal_role USING btree (portal_role_id);


--
-- TOC entry 3978 (class 1259 OID 23072)
-- Name: idx_22517_uniq_b29e22c7b887e1ddd7c6fab5; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22517_uniq_b29e22c7b887e1ddd7c6fab5 ON public.portal_portal_role USING btree (portal_id, portal_role_id);


--
-- TOC entry 3981 (class 1259 OID 23074)
-- Name: idx_22531_idx_202456e6a76ed395; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22531_idx_202456e6a76ed395 ON public.portal_role_user USING btree (user_id);


--
-- TOC entry 3982 (class 1259 OID 23077)
-- Name: idx_22531_idx_202456e6d7c6fab5; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22531_idx_202456e6d7c6fab5 ON public.portal_role_user USING btree (portal_role_id);


--
-- TOC entry 3985 (class 1259 OID 23071)
-- Name: idx_22531_uniq_202456e6d7c6fab5a76ed395; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22531_uniq_202456e6d7c6fab5a76ed395 ON public.portal_role_user USING btree (portal_role_id, user_id);


--
-- TOC entry 3986 (class 1259 OID 23087)
-- Name: idx_22538_idx_76511e4a76ed395; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22538_idx_76511e4a76ed395 ON public.portal_user USING btree (user_id);


--
-- TOC entry 3987 (class 1259 OID 23081)
-- Name: idx_22538_idx_76511e4b887e1dd; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22538_idx_76511e4b887e1dd ON public.portal_user USING btree (portal_id);


--
-- TOC entry 3990 (class 1259 OID 23089)
-- Name: idx_22538_uniq_76511e4b887e1dda76ed395; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22538_uniq_76511e4b887e1dda76ed395 ON public.portal_user USING btree (portal_id, user_id);


--
-- TOC entry 3993 (class 1259 OID 23067)
-- Name: idx_22567_idx_40374f408cde5729; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22567_idx_40374f408cde5729 ON public.reminder USING btree (type);


--
-- TOC entry 3994 (class 1259 OID 23080)
-- Name: idx_22567_idx_40374f40b75363f7; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22567_idx_40374f40b75363f7 ON public.reminder USING btree (start_at);


--
-- TOC entry 3995 (class 1259 OID 23086)
-- Name: idx_22567_idx_40374f40bbe50da3; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22567_idx_40374f40bbe50da3 ON public.reminder USING btree (remind_at);


--
-- TOC entry 4000 (class 1259 OID 23090)
-- Name: idx_22585_idx_7a5fd48b296cd8ae; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22585_idx_7a5fd48b296cd8ae ON public.role_team USING btree (team_id);


--
-- TOC entry 4001 (class 1259 OID 23092)
-- Name: idx_22585_idx_7a5fd48bd60322ac; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22585_idx_7a5fd48bd60322ac ON public.role_team USING btree (role_id);


--
-- TOC entry 4004 (class 1259 OID 23095)
-- Name: idx_22585_uniq_7a5fd48bd60322ac296cd8ae; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22585_uniq_7a5fd48bd60322ac296cd8ae ON public.role_team USING btree (role_id, team_id);


--
-- TOC entry 4005 (class 1259 OID 23082)
-- Name: idx_22592_idx_332ca4dda76ed395; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22592_idx_332ca4dda76ed395 ON public.role_user USING btree (user_id);


--
-- TOC entry 4006 (class 1259 OID 23102)
-- Name: idx_22592_idx_332ca4ddd60322ac; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22592_idx_332ca4ddd60322ac ON public.role_user USING btree (role_id);


--
-- TOC entry 4009 (class 1259 OID 23107)
-- Name: idx_22592_uniq_332ca4ddd60322aca76ed395; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22592_uniq_332ca4ddd60322aca76ed395 ON public.role_user USING btree (role_id, user_id);


--
-- TOC entry 4010 (class 1259 OID 23104)
-- Name: idx_22597_idx_800a50ce99049ece; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22597_idx_800a50ce99049ece ON public.scheduled_job USING btree (modified_by_id);


--
-- TOC entry 4011 (class 1259 OID 23083)
-- Name: idx_22597_idx_800a50ceb03a8386; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22597_idx_800a50ceb03a8386 ON public.scheduled_job USING btree (created_by_id);


--
-- TOC entry 4014 (class 1259 OID 23094)
-- Name: idx_22604_idx_615bb231a71ecab0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22604_idx_615bb231a71ecab0 ON public.scheduled_job_log_record USING btree (scheduled_job_id);


--
-- TOC entry 4017 (class 1259 OID 23105)
-- Name: idx_22604_target; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22604_target ON public.scheduled_job_log_record USING btree (target_id, target_type);


--
-- TOC entry 4018 (class 1259 OID 23098)
-- Name: idx_22613_entity; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22613_entity ON public.subscription USING btree (entity_id, entity_type);


--
-- TOC entry 4019 (class 1259 OID 23108)
-- Name: idx_22613_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22613_id ON public.subscription USING btree (id);


--
-- TOC entry 4020 (class 1259 OID 23106)
-- Name: idx_22613_idx_a3c664d3a76ed395; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22613_idx_a3c664d3a76ed395 ON public.subscription USING btree (user_id);


--
-- TOC entry 4023 (class 1259 OID 23110)
-- Name: idx_22617_idx_466f2ffc99049ece; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22617_idx_466f2ffc99049ece ON public.target USING btree (modified_by_id);


--
-- TOC entry 4024 (class 1259 OID 23101)
-- Name: idx_22617_idx_466f2ffcadf66b1a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22617_idx_466f2ffcadf66b1a ON public.target USING btree (assigned_user_id);


--
-- TOC entry 4025 (class 1259 OID 23117)
-- Name: idx_22617_idx_466f2ffcb03a8386; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22617_idx_466f2ffcb03a8386 ON public.target USING btree (created_by_id);


--
-- TOC entry 4026 (class 1259 OID 23112)
-- Name: idx_22617_idx_target_assigned_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22617_idx_target_assigned_user ON public.target USING btree (assigned_user_id, deleted);


--
-- TOC entry 4027 (class 1259 OID 23119)
-- Name: idx_22617_idx_target_first_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22617_idx_target_first_name ON public.target USING btree (first_name, deleted);


--
-- TOC entry 4028 (class 1259 OID 23121)
-- Name: idx_22617_idx_target_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22617_idx_target_name ON public.target USING btree (first_name, last_name);


--
-- TOC entry 4031 (class 1259 OID 23100)
-- Name: idx_22627_campaigns; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22627_campaigns ON public.target_list USING btree (campaigns_id);


--
-- TOC entry 4032 (class 1259 OID 23109)
-- Name: idx_22627_idx_89d0eea999049ece; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22627_idx_89d0eea999049ece ON public.target_list USING btree (modified_by_id);


--
-- TOC entry 4033 (class 1259 OID 23113)
-- Name: idx_22627_idx_89d0eea9adf66b1a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22627_idx_89d0eea9adf66b1a ON public.target_list USING btree (assigned_user_id);


--
-- TOC entry 4034 (class 1259 OID 23123)
-- Name: idx_22627_idx_89d0eea9b03a8386; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22627_idx_89d0eea9b03a8386 ON public.target_list USING btree (created_by_id);


--
-- TOC entry 4035 (class 1259 OID 23118)
-- Name: idx_22627_idx_target_list_created_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22627_idx_target_list_created_at ON public.target_list USING btree (created_at, deleted);


--
-- TOC entry 4038 (class 1259 OID 23120)
-- Name: idx_22636_idx_fce97b8ca76ed395; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22636_idx_fce97b8ca76ed395 ON public.target_list_user USING btree (user_id);


--
-- TOC entry 4039 (class 1259 OID 23114)
-- Name: idx_22636_idx_fce97b8cf6c6afe0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22636_idx_fce97b8cf6c6afe0 ON public.target_list_user USING btree (target_list_id);


--
-- TOC entry 4042 (class 1259 OID 23115)
-- Name: idx_22636_uniq_fce97b8ca76ed395f6c6afe0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22636_uniq_fce97b8ca76ed395f6c6afe0 ON public.target_list_user USING btree (user_id, target_list_id);


--
-- TOC entry 4043 (class 1259 OID 23129)
-- Name: idx_22642_idx_527edb2599049ece; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22642_idx_527edb2599049ece ON public.task USING btree (modified_by_id);


--
-- TOC entry 4044 (class 1259 OID 23126)
-- Name: idx_22642_idx_527edb259b6b5fba; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22642_idx_527edb259b6b5fba ON public.task USING btree (account_id);


--
-- TOC entry 4045 (class 1259 OID 23135)
-- Name: idx_22642_idx_527edb25adf66b1a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22642_idx_527edb25adf66b1a ON public.task USING btree (assigned_user_id);


--
-- TOC entry 4046 (class 1259 OID 23137)
-- Name: idx_22642_idx_527edb25b03a8386; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22642_idx_527edb25b03a8386 ON public.task USING btree (created_by_id);


--
-- TOC entry 4047 (class 1259 OID 23111)
-- Name: idx_22642_idx_task_assigned_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22642_idx_task_assigned_user ON public.task USING btree (assigned_user_id, deleted);


--
-- TOC entry 4048 (class 1259 OID 23116)
-- Name: idx_22642_idx_task_assigned_user_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22642_idx_task_assigned_user_status ON public.task USING btree (assigned_user_id, status);


--
-- TOC entry 4049 (class 1259 OID 23125)
-- Name: idx_22642_idx_task_date_end_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22642_idx_task_date_end_status ON public.task USING btree (date_end, status);


--
-- TOC entry 4050 (class 1259 OID 23132)
-- Name: idx_22642_idx_task_date_start; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22642_idx_task_date_start ON public.task USING btree (date_start, deleted);


--
-- TOC entry 4051 (class 1259 OID 23134)
-- Name: idx_22642_idx_task_date_start_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22642_idx_task_date_start_status ON public.task USING btree (date_start, status);


--
-- TOC entry 4052 (class 1259 OID 23130)
-- Name: idx_22642_idx_task_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22642_idx_task_status ON public.task USING btree (status, deleted);


--
-- TOC entry 4053 (class 1259 OID 23136)
-- Name: idx_22642_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22642_parent ON public.task USING btree (parent_id, parent_type);


--
-- TOC entry 4058 (class 1259 OID 23139)
-- Name: idx_22660_idx_5c722232296cd8ae; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22660_idx_5c722232296cd8ae ON public.team_user USING btree (team_id);


--
-- TOC entry 4059 (class 1259 OID 23128)
-- Name: idx_22660_idx_5c722232a76ed395; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22660_idx_5c722232a76ed395 ON public.team_user USING btree (user_id);


--
-- TOC entry 4062 (class 1259 OID 23147)
-- Name: idx_22660_uniq_5c722232296cd8aea76ed395; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_22660_uniq_5c722232296cd8aea76ed395 ON public.team_user USING btree (team_id, user_id);


--
-- TOC entry 4063 (class 1259 OID 23144)
-- Name: idx_22665_idx_97601f8399049ece; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22665_idx_97601f8399049ece ON public.template USING btree (modified_by_id);


--
-- TOC entry 4064 (class 1259 OID 23141)
-- Name: idx_22665_idx_97601f83b03a8386; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22665_idx_97601f83b03a8386 ON public.template USING btree (created_by_id);


--
-- TOC entry 4067 (class 1259 OID 23131)
-- Name: idx_22678_idx_e3c683435e237e06; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22678_idx_e3c683435e237e06 ON public.unique_id USING btree (name);


--
-- TOC entry 4068 (class 1259 OID 23140)
-- Name: idx_22678_idx_e3c68343b03a8386; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22678_idx_e3c68343b03a8386 ON public.unique_id USING btree (created_by_id);


--
-- TOC entry 4071 (class 1259 OID 23149)
-- Name: idx_22685_idx_8d93d64986383b10; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22685_idx_8d93d64986383b10 ON public."user" USING btree (avatar_id);


--
-- TOC entry 4072 (class 1259 OID 23146)
-- Name: idx_22685_idx_8d93d649dbe989eb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22685_idx_8d93d649dbe989eb ON public."user" USING btree (default_team_id);


--
-- TOC entry 4073 (class 1259 OID 23145)
-- Name: idx_22685_idx_8d93d649e7a1254a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_22685_idx_8d93d649e7a1254a ON public."user" USING btree (contact_id);


-- Completed on 2018-06-02 15:52:14 UTC

--
-- PostgreSQL database dump complete
--

