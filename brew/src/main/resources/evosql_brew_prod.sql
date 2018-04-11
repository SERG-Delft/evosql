--
-- PostgreSQL database dump
--

-- Dumped from database version 10.3 (Debian 10.3-1.pgdg90+1)
-- Dumped by pg_dump version 10.1

-- Started on 2018-04-11 11:49:05

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 2858 (class 1262 OID 16384)
-- Name: evosql_brew_prod; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE evosql_brew_prod WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';


ALTER DATABASE evosql_brew_prod OWNER TO postgres;

\connect evosql_brew_prod

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 1 (class 3079 OID 12980)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2860 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 198 (class 1259 OID 16398)
-- Name: Extra_Product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "Extra_Product" (
    "ID" integer,
    "Extra" character varying(50)
);


ALTER TABLE "Extra_Product" OWNER TO postgres;

--
-- TOC entry 197 (class 1259 OID 16392)
-- Name: Product_Detail; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "Product_Detail" (
    "ID" integer,
    "Name" character varying(500),
    "Type" integer
);


ALTER TABLE "Product_Detail" OWNER TO postgres;

--
-- TOC entry 196 (class 1259 OID 16386)
-- Name: Products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "Products" (
    "ID" integer,
    "Product" character varying(500),
    "Price" real NOT NULL
);


ALTER TABLE "Products" OWNER TO postgres;

-- Completed on 2018-04-11 11:49:05

--
-- PostgreSQL database dump complete
--

