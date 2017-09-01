-- MySQL dump 10.15  Distrib 10.0.29-MariaDB, for debian-linux-gnu (i686)
--
-- Host: localhost    Database: localhost
-- ------------------------------------------------------
-- Server version	10.0.29-MariaDB-1~trusty

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `__Auth`
--

DROP TABLE IF EXISTS `__Auth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `__Auth` (
  `doctype` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fieldname` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `salt` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `encrypted` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`doctype`,`name`,`fieldname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `__ListSettings`
--

DROP TABLE IF EXISTS `__ListSettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `__ListSettings` (
  `user` varchar(180) NOT NULL,
  `doctype` varchar(180) NOT NULL,
  `data` text,
  UNIQUE KEY `user` (`user`,`doctype`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabAbout Us Team Member`
--

DROP TABLE IF EXISTS `tabAbout Us Team Member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabAbout Us Team Member` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `image_link` text COLLATE utf8mb4_unicode_ci,
  `bio` text COLLATE utf8mb4_unicode_ci,
  `full_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabAcademic Term`
--

DROP TABLE IF EXISTS `tabAcademic Term`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabAcademic Term` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `academic_year` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `term_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `term_start_date` date DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `term_end_date` date DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `term_start_date` (`term_start_date`),
  KEY `term_end_date` (`term_end_date`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabAcademic Year`
--

DROP TABLE IF EXISTS `tabAcademic Year`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabAcademic Year` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `year_end_date` date DEFAULT NULL,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `year_start_date` date DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `academic_year_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabAccount`
--

DROP TABLE IF EXISTS `tabAccount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabAccount` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `lft` int(11) NOT NULL DEFAULT '0',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `report_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `account_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `freeze_account` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rgt` int(11) NOT NULL DEFAULT '0',
  `root_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `warehouse` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `balance_must_be` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `account_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `is_group` int(1) NOT NULL DEFAULT '0',
  `tax_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `account_currency` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `parent_account` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `old_parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `lft` (`lft`),
  KEY `rgt` (`rgt`),
  KEY `parent_account` (`parent_account`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabActivity Cost`
--

DROP TABLE IF EXISTS `tabActivity Cost`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabActivity Cost` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `title` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `billing_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `costing_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `employee_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `employee` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `activity_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabActivity Type`
--

DROP TABLE IF EXISTS `tabActivity Type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabActivity Type` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `billing_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `costing_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `activity_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabAddress`
--

DROP TABLE IF EXISTS `tabAddress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabAddress` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `email_id` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pincode` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `county` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_your_company_address` int(1) NOT NULL DEFAULT '0',
  `address_line2` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_line1` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `is_primary_address` int(1) NOT NULL DEFAULT '0',
  `state` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fax` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `address_title` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `phone` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `country` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_shipping_address` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`name`),
  KEY `pincode` (`pincode`),
  KEY `city` (`city`),
  KEY `country` (`country`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabAddress Template`
--

DROP TABLE IF EXISTS `tabAddress Template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabAddress Template` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `country` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `is_default` int(1) NOT NULL DEFAULT '0',
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `template` longtext COLLATE utf8mb4_unicode_ci,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `country` (`country`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabAnnouncement`
--

DROP TABLE IF EXISTS `tabAnnouncement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabAnnouncement` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `posted_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `student_group` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amended_from` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_seen` text COLLATE utf8mb4_unicode_ci,
  `student` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `receiver` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `instructor` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `subject` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `student_group` (`student_group`),
  KEY `student` (`student`),
  KEY `receiver` (`receiver`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabAppraisal`
--

DROP TABLE IF EXISTS `tabAppraisal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabAppraisal` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `kra_template` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `naming_series` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `amended_from` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `employee` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `status` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Draft',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `end_date` date DEFAULT NULL,
  `total_score` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `employee_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remarks` text COLLATE utf8mb4_unicode_ci,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `employee` (`employee`),
  KEY `status` (`status`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabAppraisal Goal`
--

DROP TABLE IF EXISTS `tabAppraisal Goal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabAppraisal Goal` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `score_earned` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `score` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `kra` text COLLATE utf8mb4_unicode_ci,
  `per_weightage` decimal(18,6) NOT NULL DEFAULT '0.000000',
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabAppraisal Template`
--

DROP TABLE IF EXISTS `tabAppraisal Template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabAppraisal Template` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `description` text COLLATE utf8mb4_unicode_ci,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `kra_title` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabAppraisal Template Goal`
--

DROP TABLE IF EXISTS `tabAppraisal Template Goal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabAppraisal Template Goal` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `kra` text COLLATE utf8mb4_unicode_ci,
  `per_weightage` decimal(18,6) NOT NULL DEFAULT '0.000000',
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabAssessment Evaluation Criteria`
--

DROP TABLE IF EXISTS `tabAssessment Evaluation Criteria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabAssessment Evaluation Criteria` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `maximum_score` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `evaluation_criteria` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabAssessment Group`
--

DROP TABLE IF EXISTS `tabAssessment Group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabAssessment Group` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `assessment_group_code` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `assessment_group_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabAssessment Plan`
--

DROP TABLE IF EXISTS `tabAssessment Plan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabAssessment Plan` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `supervisor` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `examiner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `course` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `assessment_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `supervisor_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `maximum_assessment_score` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `amended_from` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `assessment_group` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `student_group` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `to_time` time(6) DEFAULT NULL,
  `schedule_date` date DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `from_time` time(6) DEFAULT NULL,
  `room` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `student_batch` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `grading_scale` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `examiner_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `assessment_code` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabAssessment Result`
--

DROP TABLE IF EXISTS `tabAssessment Result`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabAssessment Result` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `grade` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `grading_scale` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amended_from` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `student` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `maximum_score` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `student_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `assessment_plan` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `total_score` decimal(18,6) NOT NULL DEFAULT '0.000000',
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabAssessment Result Detail`
--

DROP TABLE IF EXISTS `tabAssessment Result Detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabAssessment Result Detail` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `maximum_score` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `grade` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `evaluation_criteria` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `score` decimal(18,6) NOT NULL DEFAULT '0.000000',
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabAsset`
--

DROP TABLE IF EXISTS `tabAsset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabAsset` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `expected_value_after_useful_life` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `image` text COLLATE utf8mb4_unicode_ci,
  `journal_entry_for_scrap` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_number_of_depreciations` int(11) NOT NULL DEFAULT '0',
  `is_existing_asset` int(1) NOT NULL DEFAULT '0',
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `amended_from` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `purchase_date` date DEFAULT NULL,
  `supplier` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Draft',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `company` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `purchase_invoice` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `item_code` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `opening_accumulated_depreciation` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `asset_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value_after_depreciation` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `warehouse` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `frequency_of_depreciation` int(11) NOT NULL DEFAULT '0',
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `asset_category` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `next_depreciation_date` date DEFAULT NULL,
  `gross_purchase_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `number_of_depreciations_booked` int(11) NOT NULL DEFAULT '0',
  `disposal_date` date DEFAULT NULL,
  `depreciation_method` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabAsset Category`
--

DROP TABLE IF EXISTS `tabAsset Category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabAsset Category` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `asset_category_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `total_number_of_depreciations` int(11) NOT NULL DEFAULT '0',
  `frequency_of_depreciation` int(11) NOT NULL DEFAULT '0',
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `depreciation_method` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Straight Line',
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabAsset Category Account`
--

DROP TABLE IF EXISTS `tabAsset Category Account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabAsset Category Account` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `depreciation_expense_account` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `accumulated_depreciation_account` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fixed_asset_account` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabAsset Movement`
--

DROP TABLE IF EXISTS `tabAsset Movement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabAsset Movement` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `company` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `amended_from` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transaction_date` datetime(6) DEFAULT NULL,
  `asset` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target_warehouse` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `source_warehouse` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabAttendance`
--

DROP TABLE IF EXISTS `tabAttendance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabAttendance` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `status` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Present',
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `naming_series` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `employee_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amended_from` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `leave_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `attendance_date` date DEFAULT NULL,
  `employee` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `status` (`status`),
  KEY `employee` (`employee`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabAttendance Tool Student`
--

DROP TABLE IF EXISTS `tabAttendance Tool Student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabAttendance Tool Student` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `status` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `student_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `student` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabAuthorization Rule`
--

DROP TABLE IF EXISTS `tabAuthorization Rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabAuthorization Rule` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `to_designation` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `system_role` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `system_user` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `to_emp` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_or_item` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `approving_user` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `company` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `transaction` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `master_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `based_on` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `approving_role` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabAuto Email Report`
--

DROP TABLE IF EXISTS `tabAuto Email Report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabAuto Email Report` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `filters` text COLLATE utf8mb4_unicode_ci,
  `frequency` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `day_of_week` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Monday',
  `report_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `send_if_data` int(1) NOT NULL DEFAULT '1',
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `filter_meta` text COLLATE utf8mb4_unicode_ci,
  `data_modified_till` int(11) NOT NULL DEFAULT '24',
  `no_of_rows` int(11) NOT NULL DEFAULT '100',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `format` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `email_to` text COLLATE utf8mb4_unicode_ci,
  `user` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'User',
  `report` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `enabled` int(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabBOM`
--

DROP TABLE IF EXISTS `tabBOM`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabBOM` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `operating_cost` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `image` text COLLATE utf8mb4_unicode_ci,
  `currency` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `conversion_rate` decimal(21,9) NOT NULL DEFAULT '0.000000000',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `base_operating_cost` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `base_raw_material_cost` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `item` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_cost` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `amended_from` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `base_scrap_material_cost` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scrap_material_cost` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `buying_price_list` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `uom` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `description` text COLLATE utf8mb4_unicode_ci,
  `with_operations` int(1) NOT NULL DEFAULT '0',
  `raw_material_cost` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `is_active` int(1) NOT NULL DEFAULT '1',
  `is_default` int(1) NOT NULL DEFAULT '1',
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `rm_cost_as_per` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `project` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `item_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `quantity` decimal(18,6) NOT NULL DEFAULT '1.000000',
  `base_total_cost` decimal(18,6) NOT NULL DEFAULT '0.000000',
  PRIMARY KEY (`name`),
  KEY `item` (`item`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabBOM Explosion Item`
--

DROP TABLE IF EXISTS `tabBOM Explosion Item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabBOM Explosion Item` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `qty_consumed_per_unit` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `item_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` text COLLATE utf8mb4_unicode_ci,
  `rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `item_code` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `stock_uom` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabBOM Item`
--

DROP TABLE IF EXISTS `tabBOM Item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabBOM Item` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `bom_no` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `item_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `qty_consumed_per_unit` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `base_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `item_code` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `stock_uom` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scrap` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `base_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `image` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `bom_no` (`bom_no`),
  KEY `item_code` (`item_code`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabBOM Operation`
--

DROP TABLE IF EXISTS `tabBOM Operation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabBOM Operation` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `operating_cost` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `workstation` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `operation` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `base_hour_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `hour_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `base_operating_cost` decimal(18,6) NOT NULL DEFAULT '5.000000',
  `time_in_mins` decimal(18,6) NOT NULL DEFAULT '0.000000',
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabBOM Scrap Item`
--

DROP TABLE IF EXISTS `tabBOM Scrap Item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabBOM Scrap Item` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `item_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `base_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `item_code` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `base_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `stock_uom` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabBank Reconciliation Detail`
--

DROP TABLE IF EXISTS `tabBank Reconciliation Detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabBank Reconciliation Detail` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `payment_document` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `clearance_date` date DEFAULT NULL,
  `cheque_date` date DEFAULT NULL,
  `payment_entry` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `posting_date` date DEFAULT NULL,
  `cheque_number` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `against_account` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabBatch`
--

DROP TABLE IF EXISTS `tabBatch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabBatch` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `description` text COLLATE utf8mb4_unicode_ci,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `item` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `expiry_date` date DEFAULT NULL,
  `batch_id` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabBin`
--

DROP TABLE IF EXISTS `tabBin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabBin` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `reserved_qty_for_production` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `fcfs_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `reserved_qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `planned_qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `ma_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `item_code` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `projected_qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `warehouse` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stock_uom` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `ordered_qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `indented_qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `valuation_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `stock_value` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `actual_qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  PRIMARY KEY (`name`),
  KEY `item_code` (`item_code`),
  KEY `warehouse` (`warehouse`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabBlock Module`
--

DROP TABLE IF EXISTS `tabBlock Module`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabBlock Module` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `module` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabBlog Category`
--

DROP TABLE IF EXISTS `tabBlog Category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabBlog Category` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `title` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `route` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `published` int(1) NOT NULL DEFAULT '0',
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `category_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  UNIQUE KEY `route` (`route`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabBlog Post`
--

DROP TABLE IF EXISTS `tabBlog Post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabBlog Post` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `published_on` date DEFAULT NULL,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `title` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `blogger` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `email_sent` int(1) NOT NULL DEFAULT '0',
  `content` longtext COLLATE utf8mb4_unicode_ci,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `published` int(1) NOT NULL DEFAULT '0',
  `blog_category` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `route` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `blog_intro` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  UNIQUE KEY `route` (`route`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabBlogger`
--

DROP TABLE IF EXISTS `tabBlogger`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabBlogger` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `bio` text COLLATE utf8mb4_unicode_ci,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `short_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `posts` int(11) NOT NULL DEFAULT '0',
  `disabled` int(1) NOT NULL DEFAULT '0',
  `user` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `full_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `avatar` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabBranch`
--

DROP TABLE IF EXISTS `tabBranch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabBranch` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `branch` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabBrand`
--

DROP TABLE IF EXISTS `tabBrand`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabBrand` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `description` text COLLATE utf8mb4_unicode_ci,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `brand` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabBudget`
--

DROP TABLE IF EXISTS `tabBudget`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabBudget` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `monthly_distribution` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `amended_from` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `budget_against` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Cost Center',
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `company` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `fiscal_year` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `project` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `action_if_annual_budget_exceeded` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Stop',
  `action_if_accumulated_monthly_budget_exceeded` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Warn',
  `cost_center` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabBudget Account`
--

DROP TABLE IF EXISTS `tabBudget Account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabBudget Account` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `account` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `budget_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabC-Form`
--

DROP TABLE IF EXISTS `tabC-Form`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabC-Form` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `customer` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `total_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `naming_series` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `c_form_no` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amended_from` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `received_date` date DEFAULT NULL,
  `total_invoiced_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `quarter` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabC-Form Invoice Detail`
--

DROP TABLE IF EXISTS `tabC-Form Invoice Detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabC-Form Invoice Detail` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `territory` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `grand_total` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `net_total` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `invoice_date` date DEFAULT NULL,
  `invoice_no` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabCampaign`
--

DROP TABLE IF EXISTS `tabCampaign`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabCampaign` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `description` text COLLATE utf8mb4_unicode_ci,
  `naming_series` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `campaign_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabCheque Print Template`
--

DROP TABLE IF EXISTS `tabCheque Print Template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabCheque Print Template` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `date_dist_from_left_edge` decimal(18,6) NOT NULL DEFAULT '15.000000',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `is_account_payable` int(1) NOT NULL DEFAULT '1',
  `amt_in_word_width` decimal(18,6) NOT NULL DEFAULT '15.000000',
  `amt_in_figures_from_left_edge` decimal(18,6) NOT NULL DEFAULT '16.000000',
  `cheque_width` decimal(18,6) NOT NULL DEFAULT '20.000000',
  `amt_in_words_from_top_edge` decimal(18,6) NOT NULL DEFAULT '3.000000',
  `acc_pay_dist_from_left_edge` decimal(18,6) NOT NULL DEFAULT '9.000000',
  `payer_name_from_top_edge` decimal(18,6) NOT NULL DEFAULT '2.000000',
  `starting_position_from_top_edge` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `message_to_show` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Acc. Payee',
  `date_dist_from_top_edge` decimal(18,6) NOT NULL DEFAULT '1.000000',
  `signatory_from_top_edge` decimal(18,6) NOT NULL DEFAULT '6.000000',
  `payer_name_from_left_edge` decimal(18,6) NOT NULL DEFAULT '3.000000',
  `bank_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `acc_no_dist_from_top_edge` decimal(18,6) NOT NULL DEFAULT '5.000000',
  `signatory_from_left_edge` decimal(18,6) NOT NULL DEFAULT '15.000000',
  `amt_in_figures_from_top_edge` decimal(18,6) NOT NULL DEFAULT '3.500000',
  `acc_pay_dist_from_top_edge` decimal(18,6) NOT NULL DEFAULT '1.000000',
  `amt_in_words_from_left_edge` decimal(18,6) NOT NULL DEFAULT '4.000000',
  `amt_in_words_line_spacing` decimal(18,6) NOT NULL DEFAULT '0.500000',
  `has_print_format` int(1) NOT NULL DEFAULT '0',
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `scanned_cheque` text COLLATE utf8mb4_unicode_ci,
  `cheque_height` decimal(18,6) NOT NULL DEFAULT '9.000000',
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `cheque_size` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Regular',
  `acc_no_dist_from_left_edge` decimal(18,6) NOT NULL DEFAULT '4.000000',
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabCommunication`
--

DROP TABLE IF EXISTS `tabCommunication`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabCommunication` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `comment_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cc` longtext COLLATE utf8mb4_unicode_ci,
  `read_receipt` int(1) NOT NULL DEFAULT '0',
  `link_doctype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `timeline_doctype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sender_full_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `seen` int(1) NOT NULL DEFAULT '0',
  `email_account` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reference_owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subject` text COLLATE utf8mb4_unicode_ci,
  `reference_doctype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `text_content` longtext COLLATE utf8mb4_unicode_ci,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `unread_notification_sent` int(1) NOT NULL DEFAULT '0',
  `content` longtext COLLATE utf8mb4_unicode_ci,
  `communication_medium` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message_id` varchar(995) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `recipients` longtext COLLATE utf8mb4_unicode_ci,
  `timeline_label` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `communication_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Communication',
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `reference_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `delivery_status` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `in_reply_to` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `sender` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sent_or_received` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `timeline_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone_no` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `communication_date` datetime(6) DEFAULT NULL,
  `signature` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `reference_owner` (`reference_owner`),
  KEY `parent` (`parent`),
  KEY `reference_doctype_reference_name_index` (`reference_doctype`,`reference_name`),
  KEY `timeline_doctype_timeline_name_index` (`timeline_doctype`,`timeline_name`),
  KEY `link_doctype_link_name_index` (`link_doctype`,`link_name`),
  KEY `status_communication_type_index` (`status`,`communication_type`),
  KEY `communication_date_index` (`communication_date`),
  KEY `message_id_index` (`message_id`(200))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabCompany`
--

DROP TABLE IF EXISTS `tabCompany`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabCompany` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `website` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `default_letter_head` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `default_income_account` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `default_terms` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_chart_of_accounts_based_on` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `exchange_gain_loss_account` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `default_receivable_account` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `domain` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cost_center` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `registration_details` longtext COLLATE utf8mb4_unicode_ci,
  `round_off_account` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `existing_company` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `default_expense_account` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `depreciation_cost_center` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `credit_days` int(11) NOT NULL DEFAULT '0',
  `company_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `expenses_included_in_valuation` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `default_bank_account` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `default_currency` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fax` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `default_holiday_list` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `accumulated_depreciation_account` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `write_off_account` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `credit_days_based_on` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `default_payable_account` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stock_adjustment_account` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `abbr` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `credit_limit` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `stock_received_but_not_billed` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `chart_of_accounts` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone_no` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `disposal_account` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `depreciation_expense_account` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `default_cash_account` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `round_off_cost_center` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabCompany History`
--

DROP TABLE IF EXISTS `tabCompany History`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabCompany History` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `highlight` text COLLATE utf8mb4_unicode_ci,
  `year` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabContact`
--

DROP TABLE IF EXISTS `tabContact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabContact` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `last_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_id` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` text COLLATE utf8mb4_unicode_ci,
  `mobile_no` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `first_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `unsubscribed` int(1) NOT NULL DEFAULT '0',
  `department` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Passive',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `phone` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `designation` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_primary_contact` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`name`),
  KEY `email_id` (`email_id`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabCost Center`
--

DROP TABLE IF EXISTS `tabCost Center`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabCost Center` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `rgt` int(11) NOT NULL DEFAULT '0',
  `cost_center_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `company` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `is_group` int(1) NOT NULL DEFAULT '0',
  `old_parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lft` int(11) NOT NULL DEFAULT '0',
  `parent_cost_center` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `rgt` (`rgt`),
  KEY `lft` (`lft`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabCountry`
--

DROP TABLE IF EXISTS `tabCountry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabCountry` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `date_format` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `time_zones` text COLLATE utf8mb4_unicode_ci,
  `country_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabCourse`
--

DROP TABLE IF EXISTS `tabCourse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabCourse` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `default_grading_scale` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `course_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `course_intro` longtext COLLATE utf8mb4_unicode_ci,
  `course_abbreviation` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `department` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `course_code` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabCourse Evaluation Criteria`
--

DROP TABLE IF EXISTS `tabCourse Evaluation Criteria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabCourse Evaluation Criteria` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `weightage` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `evaluation_criteria` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabCourse Schedule`
--

DROP TABLE IF EXISTS `tabCourse Schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabCourse Schedule` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `instructor` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `room` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `naming_series` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'SH',
  `student_group` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `course` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `to_time` time(6) DEFAULT NULL,
  `student_batch` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `instructor_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `schedule_date` date DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `from_time` time(6) DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabCurrency`
--

DROP TABLE IF EXISTS `tabCurrency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabCurrency` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `fraction_units` int(11) NOT NULL DEFAULT '0',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `symbol` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `enabled` int(1) NOT NULL DEFAULT '0',
  `smallest_currency_fraction_value` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `currency_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fraction` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `number_format` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabCurrency Exchange`
--

DROP TABLE IF EXISTS `tabCurrency Exchange`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabCurrency Exchange` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `to_currency` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `exchange_rate` decimal(21,9) NOT NULL DEFAULT '0.000000000',
  `from_currency` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date` date DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabCustom DocPerm`
--

DROP TABLE IF EXISTS `tabCustom DocPerm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabCustom DocPerm` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `share` int(1) NOT NULL DEFAULT '1',
  `export` int(1) NOT NULL DEFAULT '1',
  `cancel` int(1) NOT NULL DEFAULT '0',
  `user_permission_doctypes` longtext COLLATE utf8mb4_unicode_ci,
  `create` int(1) NOT NULL DEFAULT '1',
  `submit` int(1) NOT NULL DEFAULT '0',
  `write` int(1) NOT NULL DEFAULT '1',
  `role` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `print` int(1) NOT NULL DEFAULT '1',
  `import` int(1) NOT NULL DEFAULT '0',
  `email` int(1) NOT NULL DEFAULT '1',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `apply_user_permissions` int(1) NOT NULL DEFAULT '0',
  `read` int(1) NOT NULL DEFAULT '1',
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `set_user_permissions` int(1) NOT NULL DEFAULT '0',
  `report` int(1) NOT NULL DEFAULT '1',
  `amend` int(1) NOT NULL DEFAULT '0',
  `permlevel` int(11) NOT NULL DEFAULT '0',
  `if_owner` int(1) NOT NULL DEFAULT '0',
  `delete` int(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabCustom Field`
--

DROP TABLE IF EXISTS `tabCustom Field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabCustom Field` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `collapsible` int(1) NOT NULL DEFAULT '0',
  `print_width` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `no_copy` int(1) NOT NULL DEFAULT '0',
  `depends_on` longtext COLLATE utf8mb4_unicode_ci,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `in_list_view` int(1) NOT NULL DEFAULT '0',
  `reqd` int(1) NOT NULL DEFAULT '0',
  `ignore_xss_filter` int(1) NOT NULL DEFAULT '0',
  `collapsible_depends_on` longtext COLLATE utf8mb4_unicode_ci,
  `in_filter` int(1) NOT NULL DEFAULT '0',
  `read_only` int(1) NOT NULL DEFAULT '0',
  `print_hide` int(1) NOT NULL DEFAULT '0',
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `ignore_user_permissions` int(1) NOT NULL DEFAULT '0',
  `label` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `print_hide_if_no_value` int(1) NOT NULL DEFAULT '0',
  `width` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `options` text COLLATE utf8mb4_unicode_ci,
  `hidden` int(1) NOT NULL DEFAULT '0',
  `permlevel` int(11) NOT NULL DEFAULT '0',
  `insert_after` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `description` text COLLATE utf8mb4_unicode_ci,
  `search_index` int(1) NOT NULL DEFAULT '0',
  `allow_on_submit` int(1) NOT NULL DEFAULT '0',
  `precision` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dt` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `unique` int(1) NOT NULL DEFAULT '0',
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `default` text COLLATE utf8mb4_unicode_ci,
  `in_standard_filter` int(1) NOT NULL DEFAULT '0',
  `fieldname` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fieldtype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Data',
  `report_hide` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`name`),
  KEY `dt` (`dt`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabCustom Script`
--

DROP TABLE IF EXISTS `tabCustom Script`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabCustom Script` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `script` longtext COLLATE utf8mb4_unicode_ci,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `dt` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `script_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Client',
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabCustomer`
--

DROP TABLE IF EXISTS `tabCustomer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabCustomer` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `status` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Active',
  `customer_details` text COLLATE utf8mb4_unicode_ci,
  `image` text COLLATE utf8mb4_unicode_ci,
  `disabled` int(1) NOT NULL DEFAULT '0',
  `lead_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `default_currency` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `default_sales_partner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `default_price_list` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `credit_days` int(11) NOT NULL DEFAULT '0',
  `naming_series` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `website` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `default_commission_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `credit_days_based_on` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `tax_id` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `credit_limit` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `language` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_group` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `territory` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_frozen` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`name`),
  KEY `customer_name` (`customer_name`),
  KEY `customer_group` (`customer_group`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabCustomer Group`
--

DROP TABLE IF EXISTS `tabCustomer Group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabCustomer Group` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `credit_limit` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `rgt` int(11) NOT NULL DEFAULT '0',
  `lft` int(11) NOT NULL DEFAULT '0',
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `parent_customer_group` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `is_group` int(1) NOT NULL DEFAULT '0',
  `old_parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `credit_days_based_on` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `default_price_list` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `credit_days` int(11) NOT NULL DEFAULT '0',
  `customer_group_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `rgt` (`rgt`),
  KEY `lft` (`lft`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabCustomize Form Field`
--

DROP TABLE IF EXISTS `tabCustomize Form Field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabCustomize Form Field` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `collapsible` int(1) NOT NULL DEFAULT '0',
  `print_width` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `in_list_view` int(1) NOT NULL DEFAULT '0',
  `reqd` int(1) NOT NULL DEFAULT '0',
  `collapsible_depends_on` longtext COLLATE utf8mb4_unicode_ci,
  `in_filter` int(1) NOT NULL DEFAULT '0',
  `read_only` int(1) NOT NULL DEFAULT '0',
  `print_hide` int(1) NOT NULL DEFAULT '0',
  `ignore_user_permissions` int(1) NOT NULL DEFAULT '0',
  `label` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `print_hide_if_no_value` int(1) NOT NULL DEFAULT '0',
  `width` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `depends_on` longtext COLLATE utf8mb4_unicode_ci,
  `hidden` int(1) NOT NULL DEFAULT '0',
  `permlevel` int(11) NOT NULL DEFAULT '0',
  `columns` int(11) NOT NULL DEFAULT '0',
  `description` text COLLATE utf8mb4_unicode_ci,
  `allow_on_submit` int(1) NOT NULL DEFAULT '0',
  `precision` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_custom_field` int(1) NOT NULL DEFAULT '0',
  `remember_last_selected_value` int(1) NOT NULL DEFAULT '0',
  `unique` int(1) NOT NULL DEFAULT '0',
  `default` text COLLATE utf8mb4_unicode_ci,
  `in_standard_filter` int(1) NOT NULL DEFAULT '0',
  `options` text COLLATE utf8mb4_unicode_ci,
  `length` int(11) NOT NULL DEFAULT '0',
  `fieldname` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fieldtype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Data',
  `report_hide` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`name`),
  KEY `label` (`label`),
  KEY `fieldname` (`fieldname`),
  KEY `fieldtype` (`fieldtype`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabDaily Work Summary`
--

DROP TABLE IF EXISTS `tabDaily Work Summary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabDaily Work Summary` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `status` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Open',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `company` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `email_sent_to` longtext COLLATE utf8mb4_unicode_ci,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabDaily Work Summary Settings Company`
--

DROP TABLE IF EXISTS `tabDaily Work Summary Settings Company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabDaily Work Summary Settings Company` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `company` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `send_emails_at` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT '17:00',
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabDefaultValue`
--

DROP TABLE IF EXISTS `tabDefaultValue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabDefaultValue` (
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `defvalue` text COLLATE utf8mb4_unicode_ci,
  `defkey` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`),
  KEY `defaultvalue_parent_defkey_index` (`parent`,`defkey`),
  KEY `defaultvalue_parent_parenttype_index` (`parent`,`parenttype`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabDeleted Document`
--

DROP TABLE IF EXISTS `tabDeleted Document`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabDeleted Document` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `new_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `deleted_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `data` longtext COLLATE utf8mb4_unicode_ci,
  `restored` int(1) NOT NULL DEFAULT '0',
  `deleted_doctype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabDelivery Note`
--

DROP TABLE IF EXISTS `tabDelivery Note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabDelivery Note` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `lr_date` date DEFAULT NULL,
  `title` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT '{customer_name}',
  `excise_page` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `selling_price_list` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `return_against` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tc_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `source` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `instructions` text COLLATE utf8mb4_unicode_ci,
  `base_in_words` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ignore_pricing_rule` int(1) NOT NULL DEFAULT '0',
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `base_discount_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `base_total_taxes_and_charges` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `discount_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `is_return` int(1) NOT NULL DEFAULT '0',
  `select_print_heading` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_taxes_and_charges` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `per_installed` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `po_date` date DEFAULT NULL,
  `price_list_currency` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_display` text COLLATE utf8mb4_unicode_ci,
  `terms` longtext COLLATE utf8mb4_unicode_ci,
  `shipping_address` text COLLATE utf8mb4_unicode_ci,
  `customer_address` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_commission` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `contact_mobile` text COLLATE utf8mb4_unicode_ci,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `base_net_total` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `language` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rounded_total` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `customer_group` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `apply_discount_on` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Grand Total',
  `po_no` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_person` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `print_without_amount` int(1) NOT NULL DEFAULT '0',
  `additional_discount_percentage` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `campaign` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `conversion_rate` decimal(21,9) NOT NULL DEFAULT '0.000000000',
  `posting_time` time(6) DEFAULT NULL,
  `total` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `customer_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `commission_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `base_total` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `territory` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sales_partner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_email` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `grand_total` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `project` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `posting_date` date DEFAULT NULL,
  `shipping_address_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_display` text COLLATE utf8mb4_unicode_ci,
  `naming_series` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `currency` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `letter_head` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `installation_status` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipping_rule` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amended_from` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `base_grand_total` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `to_warehouse` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Draft',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `lr_no` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `taxes_and_charges` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `per_billed` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `transporter_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `in_words` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `plc_conversion_rate` decimal(21,9) NOT NULL DEFAULT '0.000000000',
  `net_total` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `base_rounded_total` decimal(18,6) NOT NULL DEFAULT '0.000000',
  PRIMARY KEY (`name`),
  KEY `per_installed` (`per_installed`),
  KEY `customer_group` (`customer_group`),
  KEY `territory` (`territory`),
  KEY `company` (`company`),
  KEY `customer` (`customer`),
  KEY `project` (`project`),
  KEY `posting_date` (`posting_date`),
  KEY `status` (`status`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabDelivery Note Item`
--

DROP TABLE IF EXISTS `tabDelivery Note Item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabDelivery Note Item` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `image` text COLLATE utf8mb4_unicode_ci,
  `serial_no` text COLLATE utf8mb4_unicode_ci,
  `base_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `expense_account` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `item_tax_rate` text COLLATE utf8mb4_unicode_ci,
  `rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `installed_qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `cost_center` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target_warehouse` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `actual_qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `quality_inspection` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `page_break` int(1) NOT NULL DEFAULT '0',
  `base_net_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `discount_percentage` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `item_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `base_net_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `against_sales_invoice` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `net_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `stock_uom` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `base_price_list_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `warehouse` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `billed_amt` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `against_sales_order` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `brand` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `barcode` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `base_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `item_code` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `margin_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pricing_rule` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price_list_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `margin_rate_or_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `actual_batch_qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `item_group` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `so_detail` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `customer_item_code` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `batch_no` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `net_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `si_detail` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_margin` decimal(18,6) NOT NULL DEFAULT '0.000000',
  PRIMARY KEY (`name`),
  KEY `item_code` (`item_code`),
  KEY `so_detail` (`so_detail`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabDepartment`
--

DROP TABLE IF EXISTS `tabDepartment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabDepartment` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `leave_block_list` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `department_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabDependent Task`
--

DROP TABLE IF EXISTS `tabDependent Task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabDependent Task` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `task` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabDepreciation Schedule`
--

DROP TABLE IF EXISTS `tabDepreciation Schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabDepreciation Schedule` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `journal_entry` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `depreciation_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `schedule_date` date DEFAULT NULL,
  `accumulated_depreciation_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabDesignation`
--

DROP TABLE IF EXISTS `tabDesignation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabDesignation` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `description` text COLLATE utf8mb4_unicode_ci,
  `designation_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabDesktop Icon`
--

DROP TABLE IF EXISTS `tabDesktop Icon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabDesktop Icon` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `color` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `app` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `label` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `blocked` int(1) NOT NULL DEFAULT '0',
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `custom` int(1) NOT NULL DEFAULT '0',
  `hidden` int(1) NOT NULL DEFAULT '0',
  `type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `standard` int(1) NOT NULL DEFAULT '0',
  `link` text COLLATE utf8mb4_unicode_ci,
  `force_show` int(1) NOT NULL DEFAULT '0',
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `icon` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reverse` int(1) NOT NULL DEFAULT '0',
  `module_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_doctype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  UNIQUE KEY `unique_module_name_owner_standard` (`module_name`,`owner`,`standard`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabDiscussion`
--

DROP TABLE IF EXISTS `tabDiscussion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabDiscussion` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `description` text COLLATE utf8mb4_unicode_ci,
  `course` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `amended_from` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_seen` text COLLATE utf8mb4_unicode_ci,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `subject` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `course` (`course`),
  KEY `subject` (`subject`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabDocField`
--

DROP TABLE IF EXISTS `tabDocField`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabDocField` (
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `fieldname` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `label` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `oldfieldname` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fieldtype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Data',
  `oldfieldtype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `options` text COLLATE utf8mb4_unicode_ci,
  `search_index` int(1) NOT NULL DEFAULT '0',
  `hidden` int(1) NOT NULL DEFAULT '0',
  `set_only_once` int(1) NOT NULL DEFAULT '0',
  `print_hide` int(1) NOT NULL DEFAULT '0',
  `report_hide` int(1) NOT NULL DEFAULT '0',
  `reqd` int(1) NOT NULL DEFAULT '0',
  `bold` int(1) NOT NULL DEFAULT '0',
  `collapsible` int(1) NOT NULL DEFAULT '0',
  `unique` int(1) NOT NULL DEFAULT '0',
  `no_copy` int(1) NOT NULL DEFAULT '0',
  `allow_on_submit` int(1) NOT NULL DEFAULT '0',
  `trigger` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `collapsible_depends_on` longtext COLLATE utf8mb4_unicode_ci,
  `depends_on` longtext COLLATE utf8mb4_unicode_ci,
  `permlevel` int(11) NOT NULL DEFAULT '0',
  `ignore_user_permissions` int(1) NOT NULL DEFAULT '0',
  `width` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `print_width` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `columns` int(11) NOT NULL DEFAULT '0',
  `default` text COLLATE utf8mb4_unicode_ci,
  `description` text COLLATE utf8mb4_unicode_ci,
  `in_filter` int(1) NOT NULL DEFAULT '0',
  `in_list_view` int(1) NOT NULL DEFAULT '0',
  `in_standard_filter` int(1) NOT NULL DEFAULT '0',
  `read_only` int(1) NOT NULL DEFAULT '0',
  `precision` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `length` int(11) NOT NULL DEFAULT '0',
  `ignore_xss_filter` int(1) NOT NULL DEFAULT '0',
  `print_hide_if_no_value` int(1) NOT NULL DEFAULT '0',
  `remember_last_selected_value` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`),
  KEY `label` (`label`),
  KEY `fieldtype` (`fieldtype`),
  KEY `fieldname` (`fieldname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabDocPerm`
--

DROP TABLE IF EXISTS `tabDocPerm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabDocPerm` (
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `permlevel` int(11) DEFAULT '0',
  `role` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `match` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `read` int(1) NOT NULL DEFAULT '1',
  `write` int(1) NOT NULL DEFAULT '1',
  `create` int(1) NOT NULL DEFAULT '1',
  `submit` int(1) NOT NULL DEFAULT '0',
  `cancel` int(1) NOT NULL DEFAULT '0',
  `delete` int(1) NOT NULL DEFAULT '1',
  `amend` int(1) NOT NULL DEFAULT '0',
  `report` int(1) NOT NULL DEFAULT '1',
  `export` int(1) NOT NULL DEFAULT '1',
  `import` int(1) NOT NULL DEFAULT '0',
  `share` int(1) NOT NULL DEFAULT '1',
  `print` int(1) NOT NULL DEFAULT '1',
  `email` int(1) NOT NULL DEFAULT '1',
  `user_permission_doctypes` longtext COLLATE utf8mb4_unicode_ci,
  `set_user_permissions` int(1) NOT NULL DEFAULT '0',
  `apply_user_permissions` int(1) NOT NULL DEFAULT '0',
  `if_owner` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabDocShare`
--

DROP TABLE IF EXISTS `tabDocShare`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabDocShare` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `everyone` int(1) NOT NULL DEFAULT '0',
  `share_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `read` int(1) NOT NULL DEFAULT '0',
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `share` int(1) NOT NULL DEFAULT '0',
  `write` int(1) NOT NULL DEFAULT '0',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `user` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `share_doctype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `share_name` (`share_name`),
  KEY `user` (`user`),
  KEY `share_doctype` (`share_doctype`),
  KEY `parent` (`parent`),
  KEY `user_share_doctype_index` (`user`,`share_doctype`),
  KEY `share_doctype_share_name_index` (`share_doctype`,`share_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabDocType`
--

DROP TABLE IF EXISTS `tabDocType`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabDocType` (
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `search_fields` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `issingle` int(1) NOT NULL DEFAULT '0',
  `istable` int(1) NOT NULL DEFAULT '0',
  `editable_grid` int(1) NOT NULL DEFAULT '1',
  `track_changes` int(1) NOT NULL DEFAULT '1',
  `module` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `app` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `autoname` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name_case` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title_field` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image_field` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `timeline_field` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sort_field` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'modified',
  `sort_order` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'DESC',
  `description` text COLLATE utf8mb4_unicode_ci,
  `colour` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `read_only` int(1) NOT NULL DEFAULT '0',
  `in_create` int(1) NOT NULL DEFAULT '0',
  `menu_index` int(11) DEFAULT NULL,
  `parent_node` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `smallicon` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `allow_copy` int(1) NOT NULL DEFAULT '0',
  `allow_rename` int(1) NOT NULL DEFAULT '0',
  `allow_import` int(1) NOT NULL DEFAULT '0',
  `hide_toolbar` int(1) NOT NULL DEFAULT '0',
  `hide_heading` int(1) NOT NULL DEFAULT '0',
  `track_seen` int(1) NOT NULL DEFAULT '0',
  `max_attachments` int(11) NOT NULL DEFAULT '0',
  `print_outline` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `read_only_onload` int(1) NOT NULL DEFAULT '0',
  `in_dialog` int(1) NOT NULL DEFAULT '0',
  `document_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `icon` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tag_fields` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subject` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_last_update` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `engine` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'InnoDB',
  `default_print_format` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_submittable` int(1) NOT NULL DEFAULT '0',
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `custom` int(1) NOT NULL DEFAULT '0',
  `beta` int(1) NOT NULL DEFAULT '0',
  `image_view` int(1) NOT NULL DEFAULT '0',
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `quick_entry` int(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`),
  KEY `module` (`module`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabDynamic Link`
--

DROP TABLE IF EXISTS `tabDynamic Link`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabDynamic Link` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `link_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link_doctype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`),
  KEY `link_doctype_link_name_index` (`link_doctype`,`link_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabEmail Account`
--

DROP TABLE IF EXISTS `tabEmail Account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabEmail Account` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `default_outgoing` int(1) NOT NULL DEFAULT '0',
  `domain` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_id` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `uidnext` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `use_imap` int(1) NOT NULL DEFAULT '0',
  `auto_reply_message` longtext COLLATE utf8mb4_unicode_ci,
  `use_ssl` int(1) NOT NULL DEFAULT '0',
  `email_server` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `uid_validity` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `send_notification_to` text COLLATE utf8mb4_unicode_ci,
  `always_use_account_email_id_as_sender` int(1) NOT NULL DEFAULT '0',
  `default_incoming` int(1) NOT NULL DEFAULT '0',
  `service` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `smtp_port` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `smtp_server` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `no_failed` int(11) NOT NULL DEFAULT '0',
  `use_tls` int(1) NOT NULL DEFAULT '0',
  `enable_incoming` int(1) NOT NULL DEFAULT '0',
  `attachment_limit` int(11) NOT NULL DEFAULT '1',
  `awaiting_password` int(1) NOT NULL DEFAULT '0',
  `login_id` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `enable_auto_reply` int(1) NOT NULL DEFAULT '0',
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `send_unsubscribe_message` int(1) NOT NULL DEFAULT '1',
  `enable_outgoing` int(1) NOT NULL DEFAULT '0',
  `add_signature` int(1) NOT NULL DEFAULT '0',
  `password` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `email_account_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `footer` longtext COLLATE utf8mb4_unicode_ci,
  `unreplied_for_mins` int(11) NOT NULL DEFAULT '30',
  `login_id_is_different` int(1) NOT NULL DEFAULT '0',
  `no_remaining` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `append_to` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `signature` longtext COLLATE utf8mb4_unicode_ci,
  `notify_if_unreplied` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabEmail Alert`
--

DROP TABLE IF EXISTS `tabEmail Alert`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabEmail Alert` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `enabled` int(1) NOT NULL DEFAULT '1',
  `module` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `days_in_advance` int(11) NOT NULL DEFAULT '0',
  `message` longtext COLLATE utf8mb4_unicode_ci,
  `event` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subject` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attach_print` int(1) NOT NULL DEFAULT '0',
  `condition` longtext COLLATE utf8mb4_unicode_ci,
  `date_changed` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `is_standard` int(1) NOT NULL DEFAULT '0',
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `document_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `method` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value_changed` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `event` (`event`),
  KEY `document_type` (`document_type`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabEmail Alert Recipient`
--

DROP TABLE IF EXISTS `tabEmail Alert Recipient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabEmail Alert Recipient` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `cc` longtext COLLATE utf8mb4_unicode_ci,
  `email_by_document_field` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_by_role` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `condition` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabEmail Digest`
--

DROP TABLE IF EXISTS `tabEmail Digest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabEmail Digest` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `calendar_events` int(1) NOT NULL DEFAULT '0',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `frequency` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pending_quotations` int(1) NOT NULL DEFAULT '0',
  `expense_year_to_date` int(1) NOT NULL DEFAULT '0',
  `expenses_booked` int(1) NOT NULL DEFAULT '0',
  `new_quotations` int(1) NOT NULL DEFAULT '0',
  `next_send` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `purchase_order` int(1) NOT NULL DEFAULT '0',
  `income` int(1) NOT NULL DEFAULT '0',
  `issue` int(1) NOT NULL DEFAULT '0',
  `income_year_to_date` int(1) NOT NULL DEFAULT '0',
  `recipient_list` longtext COLLATE utf8mb4_unicode_ci,
  `invoiced_amount` int(1) NOT NULL DEFAULT '0',
  `company` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_balance` int(1) NOT NULL DEFAULT '0',
  `pending_sales_orders` int(1) NOT NULL DEFAULT '0',
  `notifications` int(1) NOT NULL DEFAULT '0',
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `add_quote` int(1) NOT NULL DEFAULT '0',
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `sales_order` int(1) NOT NULL DEFAULT '0',
  `enabled` int(1) NOT NULL DEFAULT '0',
  `project` int(1) NOT NULL DEFAULT '0',
  `credit_balance` int(1) NOT NULL DEFAULT '0',
  `todo_list` int(1) NOT NULL DEFAULT '0',
  `pending_purchase_orders` int(1) NOT NULL DEFAULT '0',
  `payables` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabEmail Domain`
--

DROP TABLE IF EXISTS `tabEmail Domain`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabEmail Domain` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `email_id` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `smtp_port` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `smtp_server` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `domain_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `use_tls` int(1) NOT NULL DEFAULT '0',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `use_imap` int(1) NOT NULL DEFAULT '0',
  `attachment_limit` int(11) NOT NULL DEFAULT '1',
  `use_ssl` int(1) NOT NULL DEFAULT '0',
  `email_server` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `append_to` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabEmail Flag Queue`
--

DROP TABLE IF EXISTS `tabEmail Flag Queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabEmail Flag Queue` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `flag` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `comm_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `action` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabEmail Group`
--

DROP TABLE IF EXISTS `tabEmail Group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabEmail Group` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `title` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `total_subscribers` int(11) NOT NULL DEFAULT '0',
  `_comments` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabEmail Group Member`
--

DROP TABLE IF EXISTS `tabEmail Group Member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabEmail Group Member` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `unsubscribed` int(1) NOT NULL DEFAULT '0',
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `email` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_group` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  UNIQUE KEY `unique_email_group_email` (`email_group`,`email`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabEmail Queue`
--

DROP TABLE IF EXISTS `tabEmail Queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabEmail Queue` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `status` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Not Sent',
  `reference_doctype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `sender` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reference_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `unsubscribe_param` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `expose_recipients` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `priority` int(11) NOT NULL DEFAULT '1',
  `send_after` datetime(6) DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `error` longtext COLLATE utf8mb4_unicode_ci,
  `communication` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `show_as_cc` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message` longtext COLLATE utf8mb4_unicode_ci,
  `unsubscribe_method` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `message_id` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `communication` (`communication`),
  KEY `message_id` (`message_id`),
  KEY `parent` (`parent`),
  KEY `index_bulk_flush` (`status`,`send_after`,`priority`,`creation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabEmail Queue Recipient`
--

DROP TABLE IF EXISTS `tabEmail Queue Recipient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabEmail Queue Recipient` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `status` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Not Sent',
  `recipient` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `error` longtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabEmail Unsubscribe`
--

DROP TABLE IF EXISTS `tabEmail Unsubscribe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabEmail Unsubscribe` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `reference_doctype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `global_unsubscribe` int(1) NOT NULL DEFAULT '0',
  `reference_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `email` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabEmployee`
--

DROP TABLE IF EXISTS `tabEmployee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabEmployee` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `status` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Active',
  `marital_status` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `feedback` text COLLATE utf8mb4_unicode_ci,
  `permanent_accommodation_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `blood_group` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `naming_series` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` text COLLATE utf8mb4_unicode_ci,
  `reason_for_leaving` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `holiday_list` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `relation` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `prefered_email` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `salutation` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `held_on` date DEFAULT NULL,
  `permanent_address` text COLLATE utf8mb4_unicode_ci,
  `company_email` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `prefered_contact_email` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `resignation_letter_date` date DEFAULT NULL,
  `employee_number` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `encashment_date` date DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `employment_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `personal_email` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reports_to` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_of_issue` date DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `new_workplace` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `current_accommodation_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `employee` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `unsubscribed` int(1) NOT NULL DEFAULT '0',
  `bio` longtext COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `branch` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scheduled_confirmation_date` date DEFAULT NULL,
  `company` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `family_background` text COLLATE utf8mb4_unicode_ci,
  `leave_encashed` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_ac_no` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `department` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `person_to_be_contacted` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_of_joining` date DEFAULT NULL,
  `employee_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `final_confirmation_date` date DEFAULT NULL,
  `place_of_issue` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `salary_mode` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `current_address` text COLLATE utf8mb4_unicode_ci,
  `passport_number` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `designation` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cell_number` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gender` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `valid_upto` date DEFAULT NULL,
  `contract_end_date` date DEFAULT NULL,
  `notice_number_of_days` int(11) NOT NULL DEFAULT '0',
  `emergency_phone_number` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reason_for_resignation` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `health_details` text COLLATE utf8mb4_unicode_ci,
  `relieving_date` date DEFAULT NULL,
  `date_of_retirement` date DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `status` (`status`),
  KEY `designation` (`designation`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabEmployee Education`
--

DROP TABLE IF EXISTS `tabEmployee Education`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabEmployee Education` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `maj_opt_subj` text COLLATE utf8mb4_unicode_ci,
  `level` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `class_per` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `qualification` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `school_univ` text COLLATE utf8mb4_unicode_ci,
  `year_of_passing` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabEmployee External Work History`
--

DROP TABLE IF EXISTS `tabEmployee External Work History`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabEmployee External Work History` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `salary` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `designation` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `total_experience` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabEmployee Internal Work History`
--

DROP TABLE IF EXISTS `tabEmployee Internal Work History`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabEmployee Internal Work History` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `department` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `from_date` date DEFAULT NULL,
  `designation` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `branch` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `to_date` date DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabEmployee Leave Approver`
--

DROP TABLE IF EXISTS `tabEmployee Leave Approver`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabEmployee Leave Approver` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `leave_approver` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabEmployment Type`
--

DROP TABLE IF EXISTS `tabEmployment Type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabEmployment Type` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `employee_type_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabError Log`
--

DROP TABLE IF EXISTS `tabError Log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabError Log` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `error` longtext COLLATE utf8mb4_unicode_ci,
  `seen` int(1) NOT NULL DEFAULT '0',
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `method` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabError Snapshot`
--

DROP TABLE IF EXISTS `tabError Snapshot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabError Snapshot` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `exception` longtext COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `pyver` longtext COLLATE utf8mb4_unicode_ci,
  `timestamp` datetime(6) DEFAULT NULL,
  `evalue` longtext COLLATE utf8mb4_unicode_ci,
  `traceback` longtext COLLATE utf8mb4_unicode_ci,
  `parent_error_snapshot` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `etype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `frames` longtext COLLATE utf8mb4_unicode_ci,
  `seen` int(1) NOT NULL DEFAULT '0',
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `relapses` int(11) NOT NULL DEFAULT '1',
  `locals` longtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabEvaluation Criteria`
--

DROP TABLE IF EXISTS `tabEvaluation Criteria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabEvaluation Criteria` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `evaluation_criteria` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabEvent`
--

DROP TABLE IF EXISTS `tabEvent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabEvent` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `event_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tuesday` int(1) NOT NULL DEFAULT '0',
  `wednesday` int(1) NOT NULL DEFAULT '0',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `thursday` int(1) NOT NULL DEFAULT '0',
  `saturday` int(1) NOT NULL DEFAULT '0',
  `subject` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `repeat_this_event` int(1) NOT NULL DEFAULT '0',
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `repeat_till` date DEFAULT NULL,
  `sunday` int(1) NOT NULL DEFAULT '0',
  `send_reminder` int(1) NOT NULL DEFAULT '1',
  `ref_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ref_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `monday` int(1) NOT NULL DEFAULT '0',
  `friday` int(1) NOT NULL DEFAULT '0',
  `_seen` text COLLATE utf8mb4_unicode_ci,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `all_day` int(1) NOT NULL DEFAULT '0',
  `starts_on` datetime(6) DEFAULT NULL,
  `ends_on` datetime(6) DEFAULT NULL,
  `repeat_on` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `event_type` (`event_type`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabEvent Role`
--

DROP TABLE IF EXISTS `tabEvent Role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabEvent Role` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `role` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabExpense Claim`
--

DROP TABLE IF EXISTS `tabExpense Claim`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabExpense Claim` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `total_claimed_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `email_id` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `naming_series` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'EXP',
  `approval_status` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Draft',
  `total_amount_reimbursed` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `vehicle_log` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `amended_from` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_sanctioned_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `employee` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `company` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `employee_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `exp_approver` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `remark` text COLLATE utf8mb4_unicode_ci,
  `task` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT '{employee_name}',
  `project` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `posting_date` date DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `approval_status` (`approval_status`),
  KEY `employee` (`employee`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabExpense Claim Account`
--

DROP TABLE IF EXISTS `tabExpense Claim Account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabExpense Claim Account` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `company` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `default_account` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabExpense Claim Detail`
--

DROP TABLE IF EXISTS `tabExpense Claim Detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabExpense Claim Detail` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `claim_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `sanctioned_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `expense_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `default_account` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `expense_date` date DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabExpense Claim Type`
--

DROP TABLE IF EXISTS `tabExpense Claim Type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabExpense Claim Type` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `description` text COLLATE utf8mb4_unicode_ci,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `expense_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabFee Category`
--

DROP TABLE IF EXISTS `tabFee Category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabFee Category` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `description` text COLLATE utf8mb4_unicode_ci,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `category_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabFee Component`
--

DROP TABLE IF EXISTS `tabFee Component`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabFee Component` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `fees_category` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabFee Structure`
--

DROP TABLE IF EXISTS `tabFee Structure`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabFee Structure` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `student_category` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `naming_series` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `academic_term` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `program` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `academic_term` (`academic_term`),
  KEY `program` (`program`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabFees`
--

DROP TABLE IF EXISTS `tabFees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabFees` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `academic_year` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `naming_series` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `academic_term` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `program_enrollment` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paid_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `amended_from` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `program` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `student_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `fee_structure` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `outstanding_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `student` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `student_category` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabFile`
--

DROP TABLE IF EXISTS `tabFile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabFile` (
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `file_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `file_url` longtext COLLATE utf8mb4_unicode_ci,
  `module` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attached_to_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `file_size` int(11) NOT NULL DEFAULT '0',
  `attached_to_doctype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lft` int(11) NOT NULL DEFAULT '0',
  `is_attachments_folder` int(1) NOT NULL DEFAULT '0',
  `is_folder` int(1) NOT NULL DEFAULT '0',
  `content_hash` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rgt` int(11) NOT NULL DEFAULT '0',
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `is_home_folder` int(1) NOT NULL DEFAULT '0',
  `folder` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `is_private` int(1) NOT NULL DEFAULT '0',
  `old_parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `thumbnail_url` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`),
  KEY `attached_to_name` (`attached_to_name`),
  KEY `attached_to_doctype` (`attached_to_doctype`),
  KEY `attached_to_doctype_attached_to_name_index` (`attached_to_doctype`,`attached_to_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabFiscal Year`
--

DROP TABLE IF EXISTS `tabFiscal Year`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabFiscal Year` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `year_end_date` date DEFAULT NULL,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `year_start_date` date DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `disabled` int(1) NOT NULL DEFAULT '0',
  `year` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabFiscal Year Company`
--

DROP TABLE IF EXISTS `tabFiscal Year Company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabFiscal Year Company` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `company` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabFooter Item`
--

DROP TABLE IF EXISTS `tabFooter Item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabFooter Item` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `url` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `group_label` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `label` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabGL Entry`
--

DROP TABLE IF EXISTS `tabGL Entry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabGL Entry` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `fiscal_year` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `voucher_no` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cost_center` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `against_voucher` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `party_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transaction_date` date DEFAULT NULL,
  `debit` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `party` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `company` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `voucher_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `is_advance` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remarks` text COLLATE utf8mb4_unicode_ci,
  `account_currency` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `debit_in_account_currency` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `account` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `against_voucher_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `against` text COLLATE utf8mb4_unicode_ci,
  `project` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `credit` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `is_opening` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `posting_date` date DEFAULT NULL,
  `credit_in_account_currency` decimal(18,6) NOT NULL DEFAULT '0.000000',
  PRIMARY KEY (`name`),
  KEY `voucher_no` (`voucher_no`),
  KEY `against_voucher` (`against_voucher`),
  KEY `party` (`party`),
  KEY `account` (`account`),
  KEY `posting_date` (`posting_date`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabGrade Interval`
--

DROP TABLE IF EXISTS `tabGrade Interval`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabGrade Interval` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `min_score` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `grade_code` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `grade_description` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabGrading Scale`
--

DROP TABLE IF EXISTS `tabGrading Scale`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabGrading Scale` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `description` text COLLATE utf8mb4_unicode_ci,
  `grading_scale_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `amended_from` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabGrading Scale Interval`
--

DROP TABLE IF EXISTS `tabGrading Scale Interval`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabGrading Scale Interval` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `threshold` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `grade_code` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `grade_description` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabGrading Structure`
--

DROP TABLE IF EXISTS `tabGrading Structure`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabGrading Structure` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `description` text COLLATE utf8mb4_unicode_ci,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `grading_system_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabGuardian`
--

DROP TABLE IF EXISTS `tabGuardian`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabGuardian` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `designation` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `guardian_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `image` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `alternate_number` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `work_address` text COLLATE utf8mb4_unicode_ci,
  `mobile_number` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `occupation` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `education` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_address` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabGuardian Interest`
--

DROP TABLE IF EXISTS `tabGuardian Interest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabGuardian Interest` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `interest` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabHelp Article`
--

DROP TABLE IF EXISTS `tabHelp Article`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabHelp Article` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `category` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `author` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'user_fullname',
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `route` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `level` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` longtext COLLATE utf8mb4_unicode_ci,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `likes` int(11) NOT NULL DEFAULT '0',
  `published` int(1) NOT NULL DEFAULT '0',
  `title` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabHelp Category`
--

DROP TABLE IF EXISTS `tabHelp Category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabHelp Category` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `route` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `published` int(1) NOT NULL DEFAULT '0',
  `help_articles` int(11) NOT NULL DEFAULT '0',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `category_description` text COLLATE utf8mb4_unicode_ci,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `category_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabHoliday`
--

DROP TABLE IF EXISTS `tabHoliday`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabHoliday` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `holiday_date` date DEFAULT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabHoliday List`
--

DROP TABLE IF EXISTS `tabHoliday List`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabHoliday List` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `holiday_list_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `weekly_off` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `from_date` date DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `to_date` date DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabHomepage Featured Product`
--

DROP TABLE IF EXISTS `tabHomepage Featured Product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabHomepage Featured Product` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `item_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `route` text COLLATE utf8mb4_unicode_ci,
  `item_code` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` text COLLATE utf8mb4_unicode_ci,
  `thumbnail` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `item_code` (`item_code`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabIndustry Type`
--

DROP TABLE IF EXISTS `tabIndustry Type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabIndustry Type` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `industry` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabInstallation Note`
--

DROP TABLE IF EXISTS `tabInstallation Note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabInstallation Note` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `address_display` text COLLATE utf8mb4_unicode_ci,
  `inst_date` date DEFAULT NULL,
  `naming_series` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `amended_from` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_display` text COLLATE utf8mb4_unicode_ci,
  `territory` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Draft',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `company` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `customer_address` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_email` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_mobile` text COLLATE utf8mb4_unicode_ci,
  `remarks` text COLLATE utf8mb4_unicode_ci,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `customer` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_group` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `inst_time` time(6) DEFAULT NULL,
  `contact_person` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `inst_date` (`inst_date`),
  KEY `territory` (`territory`),
  KEY `customer` (`customer`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabInstallation Note Item`
--

DROP TABLE IF EXISTS `tabInstallation Note Item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabInstallation Note Item` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `prevdoc_docname` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `serial_no` text COLLATE utf8mb4_unicode_ci,
  `item_code` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `prevdoc_detail_docname` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `prevdoc_doctype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `prevdoc_docname` (`prevdoc_docname`),
  KEY `prevdoc_doctype` (`prevdoc_doctype`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabInstructor`
--

DROP TABLE IF EXISTS `tabInstructor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabInstructor` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `naming_series` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `employee` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `department` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `instructor_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabIntegration Request`
--

DROP TABLE IF EXISTS `tabIntegration Request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabIntegration Request` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `status` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Queued',
  `reference_doctype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `integration_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `error` longtext COLLATE utf8mb4_unicode_ci,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `integration_request_service` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reference_docname` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `output` longtext COLLATE utf8mb4_unicode_ci,
  `data` longtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabIntegration Service`
--

DROP TABLE IF EXISTS `tabIntegration Service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabIntegration Service` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `service` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `enabled` int(1) NOT NULL DEFAULT '0',
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabIntegration Service Parameter`
--

DROP TABLE IF EXISTS `tabIntegration Service Parameter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabIntegration Service Parameter` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `fieldname` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` text COLLATE utf8mb4_unicode_ci,
  `label` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabInterest`
--

DROP TABLE IF EXISTS `tabInterest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabInterest` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `interest` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabIssue`
--

DROP TABLE IF EXISTS `tabIssue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabIssue` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `naming_series` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mins_to_first_response` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `opening_date` date DEFAULT NULL,
  `subject` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `raised_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `first_responded_on` datetime(6) DEFAULT NULL,
  `lead` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `attachment` text COLLATE utf8mb4_unicode_ci,
  `opening_time` time(6) DEFAULT NULL,
  `customer_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Open',
  `customer` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `description` text COLLATE utf8mb4_unicode_ci,
  `company` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `_seen` text COLLATE utf8mb4_unicode_ci,
  `content_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `resolution_details` text COLLATE utf8mb4_unicode_ci,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `resolution_date` datetime(6) DEFAULT NULL,
  `project` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `status` (`status`),
  KEY `customer` (`customer`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabItem`
--

DROP TABLE IF EXISTS `tabItem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabItem` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `default_supplier` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `selling_cost_center` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `net_weight` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `expense_account` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `max_discount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `income_account` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `item_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `website_warehouse` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `default_material_request_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Purchase',
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `disabled` int(1) NOT NULL DEFAULT '0',
  `tolerance` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `item_group` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `web_long_description` longtext COLLATE utf8mb4_unicode_ci,
  `valuation_method` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `variant_of` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `has_variants` int(1) NOT NULL DEFAULT '0',
  `default_warehouse` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `inspection_required_before_delivery` int(1) NOT NULL DEFAULT '0',
  `is_sales_item` int(1) NOT NULL DEFAULT '1',
  `is_sub_contracted_item` int(1) NOT NULL DEFAULT '0',
  `thumbnail` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_code` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `barcode` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_stock_item` int(1) NOT NULL DEFAULT '1',
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `manufacturer` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `route` text COLLATE utf8mb4_unicode_ci,
  `min_order_qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `valuation_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `image` text COLLATE utf8mb4_unicode_ci,
  `last_purchase_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `brand` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slideshow` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `item_code` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `show_in_website` int(1) NOT NULL DEFAULT '0',
  `is_purchase_item` int(1) NOT NULL DEFAULT '1',
  `safety_stock` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `weight_uom` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `warranty_period` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `manufacturer_part_no` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `delivered_by_supplier` int(1) NOT NULL DEFAULT '0',
  `serial_no_series` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `naming_series` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `website_image` text COLLATE utf8mb4_unicode_ci,
  `buying_cost_center` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `publish_in_hub` int(1) NOT NULL DEFAULT '0',
  `end_of_life` date DEFAULT '2099-12-31',
  `synced_with_hub` int(1) NOT NULL DEFAULT '0',
  `stock_uom` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `show_variant_in_website` int(1) NOT NULL DEFAULT '0',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `asset_category` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `default_bom` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `weightage` int(11) NOT NULL DEFAULT '0',
  `total_projected_qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `lead_time_days` int(11) NOT NULL DEFAULT '0',
  `opening_stock` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `has_batch_no` int(1) NOT NULL DEFAULT '0',
  `has_serial_no` int(1) NOT NULL DEFAULT '0',
  `standard_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `is_fixed_asset` int(1) NOT NULL DEFAULT '0',
  `inspection_required_before_purchase` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`name`),
  KEY `item_name` (`item_name`),
  KEY `weightage` (`weightage`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabItem Attribute`
--

DROP TABLE IF EXISTS `tabItem Attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabItem Attribute` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `numeric_values` int(1) NOT NULL DEFAULT '0',
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `to_range` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `attribute_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `increment` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `from_range` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabItem Attribute Value`
--

DROP TABLE IF EXISTS `tabItem Attribute Value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabItem Attribute Value` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `attribute_value` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `abbr` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `abbr` (`abbr`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabItem Customer Detail`
--

DROP TABLE IF EXISTS `tabItem Customer Detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabItem Customer Detail` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `ref_code` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `ref_code` (`ref_code`),
  KEY `customer_name` (`customer_name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabItem Group`
--

DROP TABLE IF EXISTS `tabItem Group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabItem Group` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `default_income_account` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lft` int(11) NOT NULL DEFAULT '0',
  `default_cost_center` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `route` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_group` int(1) NOT NULL DEFAULT '0',
  `slideshow` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_item_group` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `old_parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `default_expense_account` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `show_in_website` int(1) NOT NULL DEFAULT '0',
  `rgt` int(11) NOT NULL DEFAULT '0',
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `item_group_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  UNIQUE KEY `route` (`route`),
  KEY `lft` (`lft`),
  KEY `rgt` (`rgt`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabItem Price`
--

DROP TABLE IF EXISTS `tabItem Price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabItem Price` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `price_list_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `selling` int(1) NOT NULL DEFAULT '0',
  `item_description` text COLLATE utf8mb4_unicode_ci,
  `item_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `price_list` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `item_code` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `currency` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `buying` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`name`),
  KEY `item_code` (`item_code`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabItem Quality Inspection Parameter`
--

DROP TABLE IF EXISTS `tabItem Quality Inspection Parameter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabItem Quality Inspection Parameter` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `specification` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabItem Reorder`
--

DROP TABLE IF EXISTS `tabItem Reorder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabItem Reorder` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `warehouse` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `warehouse_reorder_qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `warehouse_group` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `material_request_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `warehouse_reorder_level` decimal(18,6) NOT NULL DEFAULT '0.000000',
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabItem Supplier`
--

DROP TABLE IF EXISTS `tabItem Supplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabItem Supplier` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `supplier` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `supplier_part_no` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabItem Tax`
--

DROP TABLE IF EXISTS `tabItem Tax`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabItem Tax` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `tax_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tax_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabItem Variant`
--

DROP TABLE IF EXISTS `tabItem Variant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabItem Variant` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `item_attribute_value` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `item_attribute` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabItem Variant Attribute`
--

DROP TABLE IF EXISTS `tabItem Variant Attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabItem Variant Attribute` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `from_range` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `numeric_values` int(1) NOT NULL DEFAULT '0',
  `attribute` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `to_range` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `increment` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `attribute_value` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabItem Website Specification`
--

DROP TABLE IF EXISTS `tabItem Website Specification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabItem Website Specification` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `label` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabJob Applicant`
--

DROP TABLE IF EXISTS `tabJob Applicant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabJob Applicant` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `cover_letter` text COLLATE utf8mb4_unicode_ci,
  `status` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `email_id` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `resume_attachment` text COLLATE utf8mb4_unicode_ci,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `applicant_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `job_title` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabJob Opening`
--

DROP TABLE IF EXISTS `tabJob Opening`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabJob Opening` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `status` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `route` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `publish` int(1) NOT NULL DEFAULT '0',
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `job_title` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  UNIQUE KEY `route` (`route`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabJournal Entry`
--

DROP TABLE IF EXISTS `tabJournal Entry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabJournal Entry` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `naming_series` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `clearance_date` date DEFAULT NULL,
  `voucher_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Journal Entry',
  `total_amount_currency` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `letter_head` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cheque_no` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bill_no` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `difference` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `write_off_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `title` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `amended_from` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bill_date` date DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  `cheque_date` date DEFAULT NULL,
  `multi_currency` int(1) NOT NULL DEFAULT '0',
  `total_amount_in_words` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `total_credit` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `user_remark` text COLLATE utf8mb4_unicode_ci,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `pay_to_recd_from` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remark` text COLLATE utf8mb4_unicode_ci,
  `total_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `write_off_based_on` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Accounts Receivable',
  `select_print_heading` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stock_entry` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_debit` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `is_opening` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'No',
  `posting_date` date DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `clearance_date` (`clearance_date`),
  KEY `voucher_type` (`voucher_type`),
  KEY `cheque_no` (`cheque_no`),
  KEY `company` (`company`),
  KEY `is_opening` (`is_opening`),
  KEY `posting_date` (`posting_date`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabJournal Entry Account`
--

DROP TABLE IF EXISTS `tabJournal Entry Account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabJournal Entry Account` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `exchange_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `cost_center` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reference_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `debit` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `party` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `against_account` text COLLATE utf8mb4_unicode_ci,
  `account_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reference_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `debit_in_account_currency` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `party_balance` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `is_advance` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `account_currency` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `account` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `project` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `credit` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `party_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `balance` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `credit_in_account_currency` decimal(18,6) NOT NULL DEFAULT '0.000000',
  PRIMARY KEY (`name`),
  KEY `account` (`account`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabKanban Board`
--

DROP TABLE IF EXISTS `tabKanban Board`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabKanban Board` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `reference_doctype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `filters` text COLLATE utf8mb4_unicode_ci,
  `kanban_board_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  UNIQUE KEY `kanban_board_name` (`kanban_board_name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabKanban Board Column`
--

DROP TABLE IF EXISTS `tabKanban Board Column`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabKanban Board Column` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `status` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Active',
  `indicator` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'darkgrey',
  `order` longtext COLLATE utf8mb4_unicode_ci,
  `column_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabLanded Cost Item`
--

DROP TABLE IF EXISTS `tabLanded Cost Item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabLanded Cost Item` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `item_code` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `receipt_document` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `applicable_charges` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `receipt_document_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `purchase_receipt_item` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabLanded Cost Purchase Receipt`
--

DROP TABLE IF EXISTS `tabLanded Cost Purchase Receipt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabLanded Cost Purchase Receipt` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `grand_total` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `receipt_document_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `supplier` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `receipt_document` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `posting_date` date DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabLanded Cost Taxes and Charges`
--

DROP TABLE IF EXISTS `tabLanded Cost Taxes and Charges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabLanded Cost Taxes and Charges` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `description` longtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabLanded Cost Voucher`
--

DROP TABLE IF EXISTS `tabLanded Cost Voucher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabLanded Cost Voucher` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `naming_series` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `company` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `amended_from` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_taxes_and_charges` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `distribute_charges_based_on` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabLanguage`
--

DROP TABLE IF EXISTS `tabLanguage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabLanguage` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `language_code` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `flag` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `based_on` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `language_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabLead`
--

DROP TABLE IF EXISTS `tabLead`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabLead` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `website` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_id` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` text COLLATE utf8mb4_unicode_ci,
  `mobile_no` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `campaign_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lead_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `source` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `naming_series` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `territory` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Lead',
  `fax` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `company` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `market_segment` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lead_owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `request_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `customer` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `blog_subscriber` int(1) NOT NULL DEFAULT '0',
  `industry` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `unsubscribed` int(1) NOT NULL DEFAULT '0',
  `contact_date` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `email_id` (`email_id`),
  KEY `lead_name` (`lead_name`),
  KEY `status` (`status`),
  KEY `lead_owner` (`lead_owner`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabLead Source`
--

DROP TABLE IF EXISTS `tabLead Source`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabLead Source` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `source_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `details` longtext COLLATE utf8mb4_unicode_ci,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabLeave Allocation`
--

DROP TABLE IF EXISTS `tabLeave Allocation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabLeave Allocation` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `naming_series` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `description` text COLLATE utf8mb4_unicode_ci,
  `new_leaves_allocated` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `carry_forwarded_leaves` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `carry_forward` int(1) NOT NULL DEFAULT '0',
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `amended_from` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `leave_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `to_date` date DEFAULT NULL,
  `employee_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `employee` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_leaves_allocated` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `from_date` date DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `leave_type` (`leave_type`),
  KEY `employee_name` (`employee_name`),
  KEY `employee` (`employee`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabLeave Application`
--

DROP TABLE IF EXISTS `tabLeave Application`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabLeave Application` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `naming_series` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `leave_approver` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `letter_head` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `to_date` date DEFAULT NULL,
  `half_day` int(1) NOT NULL DEFAULT '0',
  `leave_balance` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `amended_from` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `from_date` date DEFAULT NULL,
  `employee` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Open',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `description` text COLLATE utf8mb4_unicode_ci,
  `company` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `total_leave_days` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `employee_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `follow_via_email` int(1) NOT NULL DEFAULT '1',
  `leave_approver_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `leave_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `posting_date` date DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `to_date` (`to_date`),
  KEY `from_date` (`from_date`),
  KEY `employee` (`employee`),
  KEY `leave_type` (`leave_type`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabLeave Block List`
--

DROP TABLE IF EXISTS `tabLeave Block List`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabLeave Block List` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `applies_to_all_departments` int(1) NOT NULL DEFAULT '0',
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `leave_block_list_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `company` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabLeave Block List Allow`
--

DROP TABLE IF EXISTS `tabLeave Block List Allow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabLeave Block List Allow` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `allow_user` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabLeave Block List Date`
--

DROP TABLE IF EXISTS `tabLeave Block List Date`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabLeave Block List Date` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `block_date` date DEFAULT NULL,
  `reason` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabLeave Type`
--

DROP TABLE IF EXISTS `tabLeave Type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabLeave Type` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `is_lwp` int(1) NOT NULL DEFAULT '0',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `is_carry_forward` int(1) NOT NULL DEFAULT '0',
  `is_encash` int(1) NOT NULL DEFAULT '0',
  `allow_negative` int(1) NOT NULL DEFAULT '0',
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `leave_type_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `max_days_allowed` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `include_holiday` int(1) NOT NULL DEFAULT '0',
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabLetter Head`
--

DROP TABLE IF EXISTS `tabLetter Head`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabLetter Head` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `is_default` int(1) NOT NULL DEFAULT '0',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `footer` longtext COLLATE utf8mb4_unicode_ci,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `letter_head_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `disabled` int(1) NOT NULL DEFAULT '0',
  `content` longtext COLLATE utf8mb4_unicode_ci,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `is_default` (`is_default`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabMaintenance Schedule`
--

DROP TABLE IF EXISTS `tabMaintenance Schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabMaintenance Schedule` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `address_display` text COLLATE utf8mb4_unicode_ci,
  `naming_series` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `amended_from` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transaction_date` date DEFAULT NULL,
  `contact_display` text COLLATE utf8mb4_unicode_ci,
  `territory` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Draft',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `company` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `customer_address` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_email` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_mobile` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `customer` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_group` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_person` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `customer` (`customer`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabMaintenance Schedule Detail`
--

DROP TABLE IF EXISTS `tabMaintenance Schedule Detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabMaintenance Schedule Detail` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `item_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `serial_no` text COLLATE utf8mb4_unicode_ci,
  `item_code` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scheduled_date` date DEFAULT NULL,
  `sales_person` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `actual_date` date DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `item_code` (`item_code`),
  KEY `scheduled_date` (`scheduled_date`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabMaintenance Schedule Item`
--

DROP TABLE IF EXISTS `tabMaintenance Schedule Item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabMaintenance Schedule Item` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `end_date` date DEFAULT NULL,
  `periodicity` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `item_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sales_order` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `serial_no` text COLLATE utf8mb4_unicode_ci,
  `item_code` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `no_of_visits` int(11) NOT NULL DEFAULT '0',
  `sales_person` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `end_date` (`end_date`),
  KEY `sales_order` (`sales_order`),
  KEY `item_code` (`item_code`),
  KEY `start_date` (`start_date`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabMaintenance Visit`
--

DROP TABLE IF EXISTS `tabMaintenance Visit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabMaintenance Visit` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `maintenance_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Unscheduled',
  `naming_series` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `completion_status` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `amended_from` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_display` text COLLATE utf8mb4_unicode_ci,
  `territory` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Draft',
  `customer` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `customer_feedback` text COLLATE utf8mb4_unicode_ci,
  `company` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `customer_address` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mntc_time` time(6) DEFAULT NULL,
  `contact_email` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_mobile` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `mntc_date` date DEFAULT NULL,
  `address_display` text COLLATE utf8mb4_unicode_ci,
  `customer_group` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_person` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabMaintenance Visit Purpose`
--

DROP TABLE IF EXISTS `tabMaintenance Visit Purpose`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabMaintenance Visit Purpose` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `work_done` text COLLATE utf8mb4_unicode_ci,
  `service_person` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `prevdoc_docname` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `item_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `serial_no` text COLLATE utf8mb4_unicode_ci,
  `item_code` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `prevdoc_detail_docname` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `prevdoc_doctype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabManufacturer`
--

DROP TABLE IF EXISTS `tabManufacturer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabManufacturer` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `website` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `short_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `data_6` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `full_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logo` text COLLATE utf8mb4_unicode_ci,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabMaterial Request`
--

DROP TABLE IF EXISTS `tabMaterial Request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabMaterial Request` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `naming_series` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `requested_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `letter_head` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT '{material_request_type}',
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `tc_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amended_from` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transaction_date` date DEFAULT NULL,
  `status` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `terms` longtext COLLATE utf8mb4_unicode_ci,
  `company` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `per_ordered` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `material_request_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `select_print_heading` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `transaction_date` (`transaction_date`),
  KEY `status` (`status`),
  KEY `company` (`company`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabMaterial Request Item`
--

DROP TABLE IF EXISTS `tabMaterial Request Item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabMaterial Request Item` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `actual_qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `lead_time_date` date DEFAULT NULL,
  `schedule_date` date DEFAULT NULL,
  `item_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ordered_qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `warehouse` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` text COLLATE utf8mb4_unicode_ci,
  `uom` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `brand` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `item_code` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `projected_qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `sales_order` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `page_break` int(1) NOT NULL DEFAULT '0',
  `item_group` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `min_order_qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `project` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `item_name` (`item_name`),
  KEY `item_code` (`item_code`),
  KEY `item_group` (`item_group`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabMode of Payment`
--

DROP TABLE IF EXISTS `tabMode of Payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabMode of Payment` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `mode_of_payment` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabMode of Payment Account`
--

DROP TABLE IF EXISTS `tabMode of Payment Account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabMode of Payment Account` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `company` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `default_account` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabModule Def`
--

DROP TABLE IF EXISTS `tabModule Def`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabModule Def` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `app_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `module_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabMonthly Distribution`
--

DROP TABLE IF EXISTS `tabMonthly Distribution`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabMonthly Distribution` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `fiscal_year` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `distribution_id` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `fiscal_year` (`fiscal_year`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabMonthly Distribution Percentage`
--

DROP TABLE IF EXISTS `tabMonthly Distribution Percentage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabMonthly Distribution Percentage` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `percentage_allocation` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `month` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabNewsletter`
--

DROP TABLE IF EXISTS `tabNewsletter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabNewsletter` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `send_from` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scheduled_to_send` int(11) NOT NULL DEFAULT '0',
  `email_sent` int(1) NOT NULL DEFAULT '0',
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `message` longtext COLLATE utf8mb4_unicode_ci,
  `email_group` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `test_email_id` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subject` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabNote`
--

DROP TABLE IF EXISTS `tabNote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabNote` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `content` longtext COLLATE utf8mb4_unicode_ci,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `expire_notification_on` date DEFAULT NULL,
  `title` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `notify_on_login` int(1) NOT NULL DEFAULT '0',
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `public` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`name`),
  KEY `expire_notification_on` (`expire_notification_on`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabNote Seen By`
--

DROP TABLE IF EXISTS `tabNote Seen By`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabNote Seen By` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `user` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabOAuth Authorization Code`
--

DROP TABLE IF EXISTS `tabOAuth Authorization Code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabOAuth Authorization Code` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `redirect_uri_bound_to_authorization_code` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `authorization_code` text COLLATE utf8mb4_unicode_ci,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `validity` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `client` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `expiration_time` datetime(6) DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabOAuth Bearer Token`
--

DROP TABLE IF EXISTS `tabOAuth Bearer Token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabOAuth Bearer Token` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `status` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `access_token` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `expires_in` int(11) NOT NULL DEFAULT '0',
  `client` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `expiration_time` datetime(6) DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `refresh_token` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabOAuth Client`
--

DROP TABLE IF EXISTS `tabOAuth Client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabOAuth Client` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `redirect_uris` text COLLATE utf8mb4_unicode_ci,
  `app_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `default_redirect_uri` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `user` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `client_id` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `client_secret` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `skip_authorization` int(1) NOT NULL DEFAULT '0',
  `grant_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `response_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Code',
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabOffer Letter`
--

DROP TABLE IF EXISTS `tabOffer Letter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabOffer Letter` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `status` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `job_applicant` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `terms` longtext COLLATE utf8mb4_unicode_ci,
  `designation` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `select_terms` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `company` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `amended_from` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `applicant_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `offer_date` date DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabOffer Letter Term`
--

DROP TABLE IF EXISTS `tabOffer Letter Term`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabOffer Letter Term` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `offer_term` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabOffer Term`
--

DROP TABLE IF EXISTS `tabOffer Term`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabOffer Term` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `offer_term` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabOperation`
--

DROP TABLE IF EXISTS `tabOperation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabOperation` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `workstation` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `description` text COLLATE utf8mb4_unicode_ci,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabOpportunity`
--

DROP TABLE IF EXISTS `tabOpportunity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabOpportunity` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `address_display` text COLLATE utf8mb4_unicode_ci,
  `campaign` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `naming_series` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mins_to_first_response` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `enquiry_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Sales',
  `enquiry_from` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lead` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amended_from` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `source` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transaction_date` date DEFAULT NULL,
  `contact_display` text COLLATE utf8mb4_unicode_ci,
  `territory` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Open',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `company` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `customer_address` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_seen` text COLLATE utf8mb4_unicode_ci,
  `contact_email` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_mobile` text COLLATE utf8mb4_unicode_ci,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `customer` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_lost_reason` text COLLATE utf8mb4_unicode_ci,
  `customer_group` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `with_items` int(1) NOT NULL DEFAULT '0',
  `to_discuss` text COLLATE utf8mb4_unicode_ci,
  `contact_person` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_date` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `territory` (`territory`),
  KEY `company` (`company`),
  KEY `customer_group` (`customer_group`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabOpportunity Item`
--

DROP TABLE IF EXISTS `tabOpportunity Item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabOpportunity Item` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `basic_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `item_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `brand` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `item_group` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `item_code` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `image` text COLLATE utf8mb4_unicode_ci,
  `uom` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabPOS Customer Group`
--

DROP TABLE IF EXISTS `tabPOS Customer Group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabPOS Customer Group` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `customer_group` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabPOS Item Group`
--

DROP TABLE IF EXISTS `tabPOS Item Group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabPOS Item Group` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `item_group` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabPOS Profile`
--

DROP TABLE IF EXISTS `tabPOS Profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabPOS Profile` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `campaign` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `apply_discount` int(1) NOT NULL DEFAULT '0',
  `naming_series` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `expense_account` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `currency` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `letter_head` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cost_center` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `apply_discount_on` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Grand Total',
  `update_stock` int(1) NOT NULL DEFAULT '1',
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `selling_price_list` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tc_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `allow_delete` int(1) NOT NULL DEFAULT '0',
  `allow_user_to_edit_rate` int(1) NOT NULL DEFAULT '0',
  `warehouse` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `account_for_change_amount` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `territory` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `write_off_account` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `ignore_pricing_rule` int(1) NOT NULL DEFAULT '0',
  `write_off_cost_center` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `taxes_and_charges` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `user` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `customer` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `print_format` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Point of Sale',
  `income_account` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `select_print_heading` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabPacked Item`
--

DROP TABLE IF EXISTS `tabPacked Item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabPacked Item` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `serial_no` text COLLATE utf8mb4_unicode_ci,
  `qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `parent_detail_docname` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target_warehouse` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `actual_qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `page_break` int(1) NOT NULL DEFAULT '0',
  `item_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `warehouse` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `uom` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `item_code` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `projected_qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `parent_item` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `batch_no` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `prevdoc_doctype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabPacking Slip`
--

DROP TABLE IF EXISTS `tabPacking Slip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabPacking Slip` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `net_weight_uom` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `from_case_no` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `naming_series` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gross_weight_uom` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `letter_head` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `to_case_no` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `amended_from` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `net_weight_pkg` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `gross_weight_pkg` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `delivery_note` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabPacking Slip Item`
--

DROP TABLE IF EXISTS `tabPacking Slip Item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabPacking Slip Item` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `weight_uom` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `item_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `page_break` int(1) NOT NULL DEFAULT '0',
  `net_weight` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `stock_uom` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `item_code` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `batch_no` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dn_detail` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabPage`
--

DROP TABLE IF EXISTS `tabPage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabPage` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `title` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `module` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `standard` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `page_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `icon` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `standard` (`standard`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabPage Role`
--

DROP TABLE IF EXISTS `tabPage Role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabPage Role` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `role` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabParty Account`
--

DROP TABLE IF EXISTS `tabParty Account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabParty Account` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `company` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `account` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabPatch Log`
--

DROP TABLE IF EXISTS `tabPatch Log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabPatch Log` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `patch` longtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabPayment Entry`
--

DROP TABLE IF EXISTS `tabPayment Entry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabPayment Entry` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `naming_series` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `clearance_date` date DEFAULT NULL,
  `paid_to` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `base_paid_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `reference_date` date DEFAULT NULL,
  `letter_head` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `reference_no` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `print_heading` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `unallocated_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `allocate_payment_amount` int(1) NOT NULL DEFAULT '1',
  `mode_of_payment` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target_exchange_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `title` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `party_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_allocated_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `amended_from` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `base_total_allocated_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `party` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `base_received_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `source_exchange_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `company` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paid_from` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `party_balance` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `party_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remarks` text COLLATE utf8mb4_unicode_ci,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `paid_to_account_currency` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paid_from_account_balance` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `paid_from_account_currency` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paid_to_account_balance` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `paid_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `received_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `project` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `difference_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `posting_date` date DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabPayment Entry Deduction`
--

DROP TABLE IF EXISTS `tabPayment Entry Deduction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabPayment Entry Deduction` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `account` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cost_center` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabPayment Entry Reference`
--

DROP TABLE IF EXISTS `tabPayment Entry Reference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabPayment Entry Reference` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `due_date` date DEFAULT NULL,
  `total_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `reference_doctype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reference_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `outstanding_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `exchange_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `allocated_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabPayment Gateway`
--

DROP TABLE IF EXISTS `tabPayment Gateway`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabPayment Gateway` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `gateway` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabPayment Gateway Account`
--

DROP TABLE IF EXISTS `tabPayment Gateway Account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabPayment Gateway Account` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `is_default` int(1) NOT NULL DEFAULT '0',
  `currency` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message` text COLLATE utf8mb4_unicode_ci,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `payment_account` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_gateway` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabPayment Reconciliation Invoice`
--

DROP TABLE IF EXISTS `tabPayment Reconciliation Invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabPayment Reconciliation Invoice` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `invoice_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `invoice_date` date DEFAULT NULL,
  `outstanding_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `invoice_number` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabPayment Reconciliation Payment`
--

DROP TABLE IF EXISTS `tabPayment Reconciliation Payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabPayment Reconciliation Payment` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `remark` text COLLATE utf8mb4_unicode_ci,
  `reference_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `reference_row` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_advance` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reference_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `invoice_number` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `allocated_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `posting_date` date DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabPayment Request`
--

DROP TABLE IF EXISTS `tabPayment Request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabPayment Request` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `payment_url` text COLLATE utf8mb4_unicode_ci,
  `naming_series` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `currency` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message` text COLLATE utf8mb4_unicode_ci,
  `subject` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reference_doctype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_gateway` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `amended_from` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Draft',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `reference_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `email_to` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `payment_account` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mute_email` int(1) NOT NULL DEFAULT '0',
  `grand_total` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `print_format` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `make_sales_invoice` int(1) NOT NULL DEFAULT '0',
  `payment_gateway_account` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabPeriod Closing Voucher`
--

DROP TABLE IF EXISTS `tabPeriod Closing Voucher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabPeriod Closing Voucher` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `company` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `fiscal_year` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amended_from` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transaction_date` date DEFAULT NULL,
  `remarks` text COLLATE utf8mb4_unicode_ci,
  `posting_date` date DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `closing_account_head` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabPortal Menu Item`
--

DROP TABLE IF EXISTS `tabPortal Menu Item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabPortal Menu Item` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `reference_doctype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `route` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `enabled` int(1) NOT NULL DEFAULT '0',
  `role` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabPrice List`
--

DROP TABLE IF EXISTS `tabPrice List`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabPrice List` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `selling` int(1) NOT NULL DEFAULT '0',
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `enabled` int(1) NOT NULL DEFAULT '1',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `currency` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price_list_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `buying` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabPrice List Country`
--

DROP TABLE IF EXISTS `tabPrice List Country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabPrice List Country` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `country` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabPricing Rule`
--

DROP TABLE IF EXISTS `tabPricing Rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabPricing Rule` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `item_group` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price_or_discount` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Discount Percentage',
  `campaign` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `margin_rate_or_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `supplier_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `priority` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `valid_from` date DEFAULT NULL,
  `title` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `margin_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Percentage',
  `supplier` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `territory` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `sales_partner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `selling` int(1) NOT NULL DEFAULT '0',
  `applicable_for` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `brand` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `apply_on` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Item Code',
  `item_code` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `disable` int(1) NOT NULL DEFAULT '0',
  `for_price_list` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `max_qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `min_qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `buying` int(1) NOT NULL DEFAULT '0',
  `customer` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `valid_upto` date DEFAULT NULL,
  `customer_group` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `discount_percentage` decimal(18,6) NOT NULL DEFAULT '0.000000',
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabPrint Format`
--

DROP TABLE IF EXISTS `tabPrint Format`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabPrint Format` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `module` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `disabled` int(1) NOT NULL DEFAULT '0',
  `custom_format` int(1) NOT NULL DEFAULT '0',
  `font` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Default',
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `html` longtext COLLATE utf8mb4_unicode_ci,
  `show_section_headings` int(1) NOT NULL DEFAULT '0',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `print_format_builder` int(1) NOT NULL DEFAULT '0',
  `standard` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'No',
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `print_format_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Server',
  `format_data` longtext COLLATE utf8mb4_unicode_ci,
  `doc_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `line_breaks` int(1) NOT NULL DEFAULT '0',
  `align_labels_left` int(1) NOT NULL DEFAULT '1',
  `css` longtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `standard` (`standard`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabPrint Heading`
--

DROP TABLE IF EXISTS `tabPrint Heading`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabPrint Heading` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `description` text COLLATE utf8mb4_unicode_ci,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `print_heading` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabProduct Bundle`
--

DROP TABLE IF EXISTS `tabProduct Bundle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabProduct Bundle` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `new_item_code` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabProduct Bundle Item`
--

DROP TABLE IF EXISTS `tabProduct Bundle Item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabProduct Bundle Item` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `uom` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `item_code` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabProduction Order`
--

DROP TABLE IF EXISTS `tabProduction Order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabProduction Order` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `additional_operating_cost` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `naming_series` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'PRO-',
  `produced_qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `fg_warehouse` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `use_multi_level_bom` int(1) NOT NULL DEFAULT '1',
  `project` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `planned_end_date` datetime(6) DEFAULT NULL,
  `material_transferred_for_manufacturing` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `actual_end_date` datetime(6) DEFAULT NULL,
  `amended_from` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stock_uom` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `status` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Draft',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `planned_operating_cost` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `description` text COLLATE utf8mb4_unicode_ci,
  `company` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `production_item` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `planned_start_date` datetime(6) DEFAULT NULL,
  `actual_start_date` datetime(6) DEFAULT NULL,
  `material_request` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `actual_operating_cost` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `source_warehouse` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `expected_delivery_date` date DEFAULT NULL,
  `bom_no` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `wip_warehouse` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sales_order` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `material_request_item` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scrap_warehouse` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_operating_cost` decimal(18,6) NOT NULL DEFAULT '0.000000',
  PRIMARY KEY (`name`),
  KEY `status` (`status`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabProduction Order Item`
--

DROP TABLE IF EXISTS `tabProduction Order Item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabProduction Order Item` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `required_qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `transferred_qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `item_code` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabProduction Order Operation`
--

DROP TABLE IF EXISTS `tabProduction Order Operation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabProduction Order Operation` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `status` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Pending',
  `actual_start_time` datetime(6) DEFAULT NULL,
  `workstation` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `completed_qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `planned_operating_cost` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `hour_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `actual_end_time` datetime(6) DEFAULT NULL,
  `actual_operating_cost` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `actual_operation_time` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `operation` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `planned_end_time` datetime(6) DEFAULT NULL,
  `time_in_mins` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `planned_start_time` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabProduction Plan Item`
--

DROP TABLE IF EXISTS `tabProduction Plan Item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabProduction Plan Item` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `material_request_item` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bom_no` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `sales_order` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pending_qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `planned_qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `item_code` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `planned_start_date` datetime(6) DEFAULT NULL,
  `stock_uom` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `material_request` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `warehouse` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabProduction Plan Material Request`
--

DROP TABLE IF EXISTS `tabProduction Plan Material Request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabProduction Plan Material Request` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `material_request` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `material_request_date` date DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabProduction Plan Sales Order`
--

DROP TABLE IF EXISTS `tabProduction Plan Sales Order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabProduction Plan Sales Order` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `customer` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `grand_total` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `sales_order_date` date DEFAULT NULL,
  `sales_order` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabProgram`
--

DROP TABLE IF EXISTS `tabProgram`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabProgram` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `program_code` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `department` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `program_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `program_abbreviation` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabProgram Course`
--

DROP TABLE IF EXISTS `tabProgram Course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabProgram Course` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `course` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `required` int(1) NOT NULL DEFAULT '0',
  `course_code` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `academic_term` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabProgram Enrollment`
--

DROP TABLE IF EXISTS `tabProgram Enrollment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabProgram Enrollment` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `enrollment_date` date DEFAULT NULL,
  `academic_year` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `student_category` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `image` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `amended_from` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `program` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `student_batch_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `student` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `student_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabProgram Enrollment Fee`
--

DROP TABLE IF EXISTS `tabProgram Enrollment Fee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabProgram Enrollment Fee` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `due_date` date DEFAULT NULL,
  `fee_structure` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `academic_term` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabProgram Enrollment Tool Student`
--

DROP TABLE IF EXISTS `tabProgram Enrollment Tool Student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabProgram Enrollment Tool Student` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `student_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `student` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `student_applicant` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabProgram Fee`
--

DROP TABLE IF EXISTS `tabProgram Fee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabProgram Fee` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `due_date` date DEFAULT NULL,
  `student_category` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fee_structure` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `academic_term` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabProject`
--

DROP TABLE IF EXISTS `tabProject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabProject` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `total_expense_claim` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `per_gross_margin` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `project_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cost_center` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `actual_start_date` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `actual_end_date` date DEFAULT NULL,
  `total_costing_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `priority` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_purchase_cost` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `company` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Open',
  `total_billing_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `project_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `percent_complete_method` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Task Completion',
  `estimated_costing` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `is_active` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `expected_end_date` date DEFAULT NULL,
  `gross_margin` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `_seen` text COLLATE utf8mb4_unicode_ci,
  `percent_complete` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `customer` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sales_order` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `expected_start_date` date DEFAULT NULL,
  `notes` longtext COLLATE utf8mb4_unicode_ci,
  `actual_time` decimal(18,6) NOT NULL DEFAULT '0.000000',
  PRIMARY KEY (`name`),
  KEY `status` (`status`),
  KEY `customer` (`customer`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabProject Task`
--

DROP TABLE IF EXISTS `tabProject Task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabProject Task` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `status` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Open',
  `end_date` date DEFAULT NULL,
  `task_id` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `task_weight` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `start_date` date DEFAULT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabProject User`
--

DROP TABLE IF EXISTS `tabProject User`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabProject User` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `welcome_email_sent` int(1) NOT NULL DEFAULT '0',
  `user` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `user` (`user`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabProperty Setter`
--

DROP TABLE IF EXISTS `tabProperty Setter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabProperty Setter` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `default_value` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `doc_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `property` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `value` text COLLATE utf8mb4_unicode_ci,
  `doctype_or_field` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `property_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `doc_type` (`doc_type`),
  KEY `property` (`property`),
  KEY `field_name` (`field_name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabPurchase Invoice`
--

DROP TABLE IF EXISTS `tabPurchase Invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabPurchase Invoice` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `cash_bank_account` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `base_write_off_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `apply_discount_on` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Grand Total',
  `return_against` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tc_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `submit_on_creation` int(1) NOT NULL DEFAULT '0',
  `discount_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `base_in_words` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  `ignore_pricing_rule` int(1) NOT NULL DEFAULT '0',
  `write_off_cost_center` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `base_discount_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `base_total_taxes_and_charges` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `supplier_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `taxes_and_charges_added` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `is_paid` int(1) NOT NULL DEFAULT '0',
  `is_return` int(1) NOT NULL DEFAULT '0',
  `select_print_heading` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_taxes_and_charges` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `write_off_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `supplier_address` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mode_of_payment` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `party_account_currency` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price_list_currency` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `base_taxes_and_charges_added` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `contact_display` text COLLATE utf8mb4_unicode_ci,
  `supplier` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `buying_price_list` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `write_off_account` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `next_date` date DEFAULT NULL,
  `terms` longtext COLLATE utf8mb4_unicode_ci,
  `supplier_warehouse` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipping_address` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_mobile` text COLLATE utf8mb4_unicode_ci,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `base_net_total` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `language` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT '{supplier_name}',
  `repeat_on_day_of_month` int(11) NOT NULL DEFAULT '0',
  `contact_person` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `in_words` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `recurring_print_format` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `additional_discount_percentage` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `base_paid_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `conversion_rate` decimal(21,9) NOT NULL DEFAULT '0.000000000',
  `to_date` date DEFAULT NULL,
  `total_advance` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `posting_time` time(6) DEFAULT NULL,
  `total` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `bill_no` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rejected_warehouse` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_subcontracted` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'No',
  `update_stock` int(1) NOT NULL DEFAULT '0',
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `base_total` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `from_date` date DEFAULT NULL,
  `notification_email_address` text COLLATE utf8mb4_unicode_ci,
  `end_date` date DEFAULT NULL,
  `company` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_email` text COLLATE utf8mb4_unicode_ci,
  `grand_total` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `notify_by_email` int(1) NOT NULL DEFAULT '0',
  `is_recurring` int(1) NOT NULL DEFAULT '0',
  `taxes_and_charges_deducted` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `is_opening` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'No',
  `posting_date` date DEFAULT NULL,
  `address_display` text COLLATE utf8mb4_unicode_ci,
  `against_expense_account` text COLLATE utf8mb4_unicode_ci,
  `naming_series` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `currency` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `letter_head` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `recurring_id` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `base_taxes_and_charges_deducted` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `paid_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `credit_to` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amended_from` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `base_grand_total` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `recurring_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bill_date` date DEFAULT NULL,
  `status` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Draft',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `taxes_and_charges` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `outstanding_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `remarks` text COLLATE utf8mb4_unicode_ci,
  `shipping_address_display` text COLLATE utf8mb4_unicode_ci,
  `plc_conversion_rate` decimal(21,9) NOT NULL DEFAULT '0.000000000',
  `net_total` decimal(18,6) NOT NULL DEFAULT '0.000000',
  PRIMARY KEY (`name`),
  KEY `supplier` (`supplier`),
  KEY `posting_date` (`posting_date`),
  KEY `credit_to` (`credit_to`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabPurchase Invoice Advance`
--

DROP TABLE IF EXISTS `tabPurchase Invoice Advance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabPurchase Invoice Advance` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `reference_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `advance_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `reference_row` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reference_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remarks` text COLLATE utf8mb4_unicode_ci,
  `allocated_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabPurchase Invoice Item`
--

DROP TABLE IF EXISTS `tabPurchase Invoice Item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabPurchase Invoice Item` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `purchase_receipt` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `po_detail` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` text COLLATE utf8mb4_unicode_ci,
  `landed_cost_voucher_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `item_tax_rate` longtext COLLATE utf8mb4_unicode_ci,
  `rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `expense_account` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cost_center` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `received_qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `rm_supp_cost` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `item_tax_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `quality_inspection` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `page_break` int(1) NOT NULL DEFAULT '0',
  `base_net_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `discount_percentage` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `item_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `base_net_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `purchase_order` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `conversion_factor` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `asset` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pr_detail` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `warehouse` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `uom` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `serial_no` text COLLATE utf8mb4_unicode_ci,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `brand` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rejected_serial_no` text COLLATE utf8mb4_unicode_ci,
  `base_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `item_code` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `base_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `rejected_qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `base_price_list_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `rejected_warehouse` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pricing_rule` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price_list_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `item_group` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `project` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `net_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `bom` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `batch_no` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `valuation_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `net_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `is_fixed_asset` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`name`),
  KEY `purchase_receipt` (`purchase_receipt`),
  KEY `po_detail` (`po_detail`),
  KEY `purchase_order` (`purchase_order`),
  KEY `pr_detail` (`pr_detail`),
  KEY `item_code` (`item_code`),
  KEY `item_group` (`item_group`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabPurchase Order`
--

DROP TABLE IF EXISTS `tabPurchase Order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabPurchase Order` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `ref_sq` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT '{supplier_name}',
  `tc_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `base_grand_total` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `submit_on_creation` int(1) NOT NULL DEFAULT '0',
  `taxes_and_charges_added` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `base_in_words` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ignore_pricing_rule` int(1) NOT NULL DEFAULT '0',
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `base_discount_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `base_total_taxes_and_charges` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `supplier_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `discount_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `select_print_heading` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_contact_person` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_taxes_and_charges` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `supplier_address` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `party_account_currency` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price_list_currency` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `base_taxes_and_charges_added` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `customer_contact_email` longtext COLLATE utf8mb4_unicode_ci,
  `contact_display` text COLLATE utf8mb4_unicode_ci,
  `supplier` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `buying_price_list` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `next_date` date DEFAULT NULL,
  `terms` longtext COLLATE utf8mb4_unicode_ci,
  `advance_paid` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `contact_mobile` text COLLATE utf8mb4_unicode_ci,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `base_net_total` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `language` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `apply_discount_on` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Grand Total',
  `repeat_on_day_of_month` int(11) NOT NULL DEFAULT '0',
  `contact_person` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `in_words` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `recurring_print_format` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `additional_discount_percentage` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `conversion_rate` decimal(21,9) NOT NULL DEFAULT '0.000000000',
  `to_date` date DEFAULT NULL,
  `total` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `customer_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_subcontracted` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'No',
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `base_total` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `from_date` date DEFAULT NULL,
  `notification_email_address` longtext COLLATE utf8mb4_unicode_ci,
  `end_date` date DEFAULT NULL,
  `company` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `base_rounded_total` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `customer` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `grand_total` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `notify_by_email` int(1) NOT NULL DEFAULT '0',
  `is_recurring` int(1) NOT NULL DEFAULT '0',
  `taxes_and_charges_deducted` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `shipping_address` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_display` text COLLATE utf8mb4_unicode_ci,
  `naming_series` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `currency` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `letter_head` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `recurring_id` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `base_taxes_and_charges_deducted` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `amended_from` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transaction_date` date DEFAULT NULL,
  `recurring_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `status` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Draft',
  `group_same_items` int(1) NOT NULL DEFAULT '0',
  `customer_contact_display` text COLLATE utf8mb4_unicode_ci,
  `taxes_and_charges` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `per_billed` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `shipping_address_display` text COLLATE utf8mb4_unicode_ci,
  `customer_contact_mobile` text COLLATE utf8mb4_unicode_ci,
  `per_received` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `plc_conversion_rate` decimal(21,9) NOT NULL DEFAULT '0.000000000',
  `net_total` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `contact_email` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `supplier` (`supplier`),
  KEY `company` (`company`),
  KEY `transaction_date` (`transaction_date`),
  KEY `status` (`status`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabPurchase Order Item`
--

DROP TABLE IF EXISTS `tabPurchase Order Item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabPurchase Order Item` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `schedule_date` date DEFAULT NULL,
  `stock_qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `base_price_list_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `image` text COLLATE utf8mb4_unicode_ci,
  `base_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `base_net_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `item_tax_rate` longtext COLLATE utf8mb4_unicode_ci,
  `rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `received_qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `stock_uom` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `project` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `page_break` int(1) NOT NULL DEFAULT '0',
  `base_net_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `item_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `supplier_quotation` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `supplier_quotation_item` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `net_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `conversion_factor` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `warehouse` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `billed_amt` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `supplier_part_no` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `uom` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price_list_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `returned_qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `net_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `brand` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `base_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `item_code` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `material_request` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pricing_rule` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sales_order_item` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `expected_delivery_date` date DEFAULT NULL,
  `sales_order` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `item_group` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `discount_percentage` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `material_request_item` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `bom` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `delivered_by_supplier` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`name`),
  KEY `schedule_date` (`schedule_date`),
  KEY `item_name` (`item_name`),
  KEY `item_code` (`item_code`),
  KEY `material_request` (`material_request`),
  KEY `sales_order_item` (`sales_order_item`),
  KEY `expected_delivery_date` (`expected_delivery_date`),
  KEY `sales_order` (`sales_order`),
  KEY `material_request_item` (`material_request_item`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabPurchase Order Item Supplied`
--

DROP TABLE IF EXISTS `tabPurchase Order Item Supplied`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabPurchase Order Item Supplied` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `rm_item_code` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `reference_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bom_detail_no` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `required_qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `main_item_code` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `conversion_factor` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `stock_uom` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabPurchase Receipt`
--

DROP TABLE IF EXISTS `tabPurchase Receipt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabPurchase Receipt` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `lr_date` date DEFAULT NULL,
  `apply_discount_on` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Grand Total',
  `tc_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `taxes_and_charges_added` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `base_in_words` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ignore_pricing_rule` int(1) NOT NULL DEFAULT '0',
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `base_discount_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `base_total_taxes_and_charges` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `supplier_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `instructions` text COLLATE utf8mb4_unicode_ci,
  `buying_price_list` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `discount_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `is_return` int(1) NOT NULL DEFAULT '0',
  `select_print_heading` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_taxes_and_charges` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `supplier_address` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lr_no` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price_list_currency` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `base_taxes_and_charges_added` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `contact_display` text COLLATE utf8mb4_unicode_ci,
  `supplier` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `terms` longtext COLLATE utf8mb4_unicode_ci,
  `supplier_warehouse` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `base_net_total` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `language` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT '{supplier_name}',
  `range` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_person` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `in_words` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `additional_discount_percentage` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `return_against` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_mobile` text COLLATE utf8mb4_unicode_ci,
  `conversion_rate` decimal(21,9) NOT NULL DEFAULT '0.000000000',
  `posting_time` time(6) DEFAULT NULL,
  `total` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `bill_no` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rejected_warehouse` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_subcontracted` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'No',
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `base_total` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `company` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `base_rounded_total` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `grand_total` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `taxes_and_charges_deducted` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `shipping_address` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `posting_date` date DEFAULT NULL,
  `address_display` text COLLATE utf8mb4_unicode_ci,
  `naming_series` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `currency` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `letter_head` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `base_taxes_and_charges_deducted` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `amended_from` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `base_grand_total` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `bill_date` date DEFAULT NULL,
  `status` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Draft',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `taxes_and_charges` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `per_billed` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `transporter_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remarks` text COLLATE utf8mb4_unicode_ci,
  `shipping_address_display` text COLLATE utf8mb4_unicode_ci,
  `plc_conversion_rate` decimal(21,9) NOT NULL DEFAULT '0.000000000',
  `net_total` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `contact_email` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `supplier` (`supplier`),
  KEY `company` (`company`),
  KEY `posting_date` (`posting_date`),
  KEY `status` (`status`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabPurchase Receipt Item`
--

DROP TABLE IF EXISTS `tabPurchase Receipt Item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabPurchase Receipt Item` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `schedule_date` date DEFAULT NULL,
  `stock_qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `image` text COLLATE utf8mb4_unicode_ci,
  `qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `cost_center` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `received_qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `stock_uom` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `item_tax_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `quality_inspection` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `page_break` int(1) NOT NULL DEFAULT '0',
  `rejected_warehouse` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `base_net_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `item_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rejected_serial_no` text COLLATE utf8mb4_unicode_ci,
  `base_net_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `item_group` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `net_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `conversion_factor` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `rm_supp_cost` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `base_price_list_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `warehouse` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `billed_amt` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `uom` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `serial_no` text COLLATE utf8mb4_unicode_ci,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `landed_cost_voucher_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `brand` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `barcode` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `base_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `item_code` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `base_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `rejected_qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `pricing_rule` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price_list_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `item_tax_rate` longtext COLLATE utf8mb4_unicode_ci,
  `discount_percentage` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `purchase_order` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `project` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `bom` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `batch_no` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `valuation_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `purchase_order_item` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `net_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  PRIMARY KEY (`name`),
  KEY `item_group` (`item_group`),
  KEY `item_code` (`item_code`),
  KEY `purchase_order` (`purchase_order`),
  KEY `purchase_order_item` (`purchase_order_item`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabPurchase Receipt Item Supplied`
--

DROP TABLE IF EXISTS `tabPurchase Receipt Item Supplied`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabPurchase Receipt Item Supplied` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `rm_item_code` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `conversion_factor` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `reference_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `serial_no` text COLLATE utf8mb4_unicode_ci,
  `amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `main_item_code` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `required_qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `stock_uom` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `current_stock` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `batch_no` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `consumed_qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `bom_detail_no` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabPurchase Taxes and Charges`
--

DROP TABLE IF EXISTS `tabPurchase Taxes and Charges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabPurchase Taxes and Charges` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `charge_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `category` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Valuation and Total',
  `total` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `tax_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `item_wise_tax_detail` longtext COLLATE utf8mb4_unicode_ci,
  `base_tax_amount_after_discount_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `row_id` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `base_total` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `add_deduct_tax` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Add',
  `included_in_print_rate` int(1) NOT NULL DEFAULT '0',
  `rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `tax_amount_after_discount_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `cost_center` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `base_tax_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `account_head` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabPurchase Taxes and Charges Template`
--

DROP TABLE IF EXISTS `tabPurchase Taxes and Charges Template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabPurchase Taxes and Charges Template` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `disabled` int(1) NOT NULL DEFAULT '0',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `title` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `company` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `is_default` int(1) NOT NULL DEFAULT '0',
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabQuality Inspection`
--

DROP TABLE IF EXISTS `tabQuality Inspection`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabQuality Inspection` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `naming_series` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `report_date` date DEFAULT NULL,
  `item_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `verified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reference_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amended_from` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `description` text COLLATE utf8mb4_unicode_ci,
  `reference_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `inspection_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `item_serial_no` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `item_code` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remarks` text COLLATE utf8mb4_unicode_ci,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `inspected_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'user',
  `sample_size` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `batch_no` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `report_date` (`report_date`),
  KEY `item_code` (`item_code`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabQuality Inspection Reading`
--

DROP TABLE IF EXISTS `tabQuality Inspection Reading`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabQuality Inspection Reading` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `status` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Accepted',
  `reading_10` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reading_5` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reading_8` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reading_9` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reading_1` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reading_2` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reading_3` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reading_4` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `specification` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reading_6` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reading_7` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabQuotation`
--

DROP TABLE IF EXISTS `tabQuotation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabQuotation` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `additional_discount_percentage` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `base_in_words` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `enq_det` text COLLATE utf8mb4_unicode_ci,
  `campaign` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_email` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `naming_series` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_mobile` text COLLATE utf8mb4_unicode_ci,
  `currency` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `conversion_rate` decimal(21,9) NOT NULL DEFAULT '0.000000000',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `total` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `shipping_rule` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `taxes_and_charges` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `select_print_heading` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Sales',
  `lead` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price_list_currency` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `base_total` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `selling_price_list` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `supplier_quotation` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tc_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `source` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transaction_date` date DEFAULT NULL,
  `contact_display` text COLLATE utf8mb4_unicode_ci,
  `ignore_pricing_rule` int(1) NOT NULL DEFAULT '0',
  `territory` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_display` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `terms` longtext COLLATE utf8mb4_unicode_ci,
  `amended_from` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `base_rounded_total` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `customer_group` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `quotation_to` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Customer',
  `grand_total` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `base_discount_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `customer_address` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `base_total_taxes_and_charges` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `base_grand_total` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `discount_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `customer` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_lost_reason` text COLLATE utf8mb4_unicode_ci,
  `base_net_total` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `language` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rounded_total` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `shipping_address_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT '{customer_name}',
  `letter_head` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `plc_conversion_rate` decimal(21,9) NOT NULL DEFAULT '0.000000000',
  `net_total` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `status` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Draft',
  `shipping_address` text COLLATE utf8mb4_unicode_ci,
  `apply_discount_on` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Grand Total',
  `contact_person` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `in_words` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_taxes_and_charges` decimal(18,6) NOT NULL DEFAULT '0.000000',
  PRIMARY KEY (`name`),
  KEY `transaction_date` (`transaction_date`),
  KEY `customer` (`customer`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabQuotation Item`
--

DROP TABLE IF EXISTS `tabQuotation Item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabQuotation Item` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `base_price_list_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `base_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `item_tax_rate` longtext COLLATE utf8mb4_unicode_ci,
  `rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `actual_qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `page_break` int(1) NOT NULL DEFAULT '0',
  `base_net_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `discount_percentage` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `item_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `base_net_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `net_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `stock_uom` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `warehouse` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` text COLLATE utf8mb4_unicode_ci,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `prevdoc_docname` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `brand` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `base_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `item_code` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `projected_qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `margin_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pricing_rule` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price_list_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `margin_rate_or_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `item_group` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `customer_item_code` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `net_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `total_margin` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `prevdoc_doctype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `item_name` (`item_name`),
  KEY `brand` (`brand`),
  KEY `item_code` (`item_code`),
  KEY `item_group` (`item_group`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabQuotation Lost Reason`
--

DROP TABLE IF EXISTS `tabQuotation Lost Reason`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabQuotation Lost Reason` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `order_lost_reason` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabReport`
--

DROP TABLE IF EXISTS `tabReport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabReport` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `apply_user_permissions` int(1) NOT NULL DEFAULT '1',
  `ref_doctype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `report_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `javascript` longtext COLLATE utf8mb4_unicode_ci,
  `letter_head` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `module` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `report_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `disabled` int(1) NOT NULL DEFAULT '0',
  `json` longtext COLLATE utf8mb4_unicode_ci,
  `is_standard` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `add_total_row` int(1) NOT NULL DEFAULT '0',
  `query` longtext COLLATE utf8mb4_unicode_ci,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabRequest for Quotation`
--

DROP TABLE IF EXISTS `tabRequest for Quotation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabRequest for Quotation` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `standard_reply` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `naming_series` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fiscal_year` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `letter_head` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `terms` longtext COLLATE utf8mb4_unicode_ci,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `tc_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amended_from` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transaction_date` date DEFAULT NULL,
  `status` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `vendor` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `select_print_heading` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message_for_supplier` longtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `fiscal_year` (`fiscal_year`),
  KEY `transaction_date` (`transaction_date`),
  KEY `status` (`status`),
  KEY `company` (`company`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabRequest for Quotation Item`
--

DROP TABLE IF EXISTS `tabRequest for Quotation Item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabRequest for Quotation Item` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `image` text COLLATE utf8mb4_unicode_ci,
  `qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `page_break` int(1) NOT NULL DEFAULT '0',
  `item_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `warehouse` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `supplier_part_no` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `uom` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `project_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `brand` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `item_code` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `material_request` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `schedule_date` date DEFAULT NULL,
  `item_group` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `material_request_item` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `item_name` (`item_name`),
  KEY `item_code` (`item_code`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabRequest for Quotation Supplier`
--

DROP TABLE IF EXISTS `tabRequest for Quotation Supplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabRequest for Quotation Supplier` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `email_id` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `send_email` int(1) NOT NULL DEFAULT '1',
  `supplier_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `supplier` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabRole`
--

DROP TABLE IF EXISTS `tabRole`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabRole` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `desk_access` int(1) NOT NULL DEFAULT '1',
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `disabled` int(1) NOT NULL DEFAULT '0',
  `role_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabRoom`
--

DROP TABLE IF EXISTS `tabRoom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabRoom` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `room_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `seating_capacity` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `room_number` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabSMS Log`
--

DROP TABLE IF EXISTS `tabSMS Log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabSMS Log` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `requested_numbers` longtext COLLATE utf8mb4_unicode_ci,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `sender_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `sent_on` date DEFAULT NULL,
  `no_of_sent_sms` int(11) NOT NULL DEFAULT '0',
  `message` text COLLATE utf8mb4_unicode_ci,
  `no_of_requested_sms` int(11) NOT NULL DEFAULT '0',
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `sent_to` longtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabSMS Parameter`
--

DROP TABLE IF EXISTS `tabSMS Parameter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabSMS Parameter` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `parameter` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabSalary Component`
--

DROP TABLE IF EXISTS `tabSalary Component`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabSalary Component` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `description` text COLLATE utf8mb4_unicode_ci,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `salary_component_abbr` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `salary_component` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabSalary Component Account`
--

DROP TABLE IF EXISTS `tabSalary Component Account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabSalary Component Account` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `company` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `default_account` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabSalary Detail`
--

DROP TABLE IF EXISTS `tabSalary Detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabSalary Detail` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `default_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `amount_based_on_formula` int(1) NOT NULL DEFAULT '1',
  `depends_on_lwp` int(1) NOT NULL DEFAULT '0',
  `amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `abbr` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `salary_component` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `formula` longtext COLLATE utf8mb4_unicode_ci,
  `condition` longtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabSalary Slip`
--

DROP TABLE IF EXISTS `tabSalary Slip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabSalary Slip` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `payment_days` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `salary_structure` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `journal_entry` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_in_words` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `letter_head` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `payroll_frequency` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `salary_slip_based_on_timesheet` int(1) NOT NULL DEFAULT '0',
  `leave_encashment_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `amended_from` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `branch` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `department` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `leave_without_pay` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `status` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `total_deduction` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `end_date` date DEFAULT NULL,
  `company` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `employee` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_working_days` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `employee_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `bank_account_no` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `designation` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `net_pay` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `rounded_total` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `hour_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `total_working_hours` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `posting_date` date DEFAULT NULL,
  `gross_pay` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `arrear_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  PRIMARY KEY (`name`),
  KEY `employee` (`employee`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabSalary Slip Timesheet`
--

DROP TABLE IF EXISTS `tabSalary Slip Timesheet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabSalary Slip Timesheet` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `working_hours` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `time_sheet` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabSalary Structure`
--

DROP TABLE IF EXISTS `tabSalary Structure`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabSalary Structure` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `mode_of_payment` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `letter_head` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `to_date` date DEFAULT NULL,
  `total_earning` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `from_date` date DEFAULT NULL,
  `salary_component` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `total_deduction` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `company` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `is_active` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Yes',
  `is_default` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'No',
  `net_pay` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `payment_account` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hour_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `salary_slip_based_on_timesheet` int(1) NOT NULL DEFAULT '0',
  `payroll_frequency` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Monthly',
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabSalary Structure Employee`
--

DROP TABLE IF EXISTS `tabSalary Structure Employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabSalary Structure Employee` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `employee` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `variable` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `base` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `employee_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabSales Invoice`
--

DROP TABLE IF EXISTS `tabSales Invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabSales Invoice` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `cash_bank_account` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `base_write_off_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `title` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT '{customer_name}',
  `selling_price_list` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `return_against` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tc_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `submit_on_creation` int(1) NOT NULL DEFAULT '0',
  `base_in_words` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  `write_off_cost_center` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `base_discount_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `base_total_taxes_and_charges` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `discount_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `is_return` int(1) NOT NULL DEFAULT '0',
  `write_off_outstanding_amount_automatically` int(1) NOT NULL DEFAULT '0',
  `select_print_heading` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `source` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `against_income_account` text COLLATE utf8mb4_unicode_ci,
  `write_off_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `party_account_currency` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `net_total` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `price_list_currency` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_display` text COLLATE utf8mb4_unicode_ci,
  `next_date` date DEFAULT NULL,
  `terms` longtext COLLATE utf8mb4_unicode_ci,
  `is_opening` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'No',
  `customer_address` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_commission` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `contact_mobile` text COLLATE utf8mb4_unicode_ci,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `c_form_applicable` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `base_net_total` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `shipping_address_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `apply_discount_on` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Grand Total',
  `offline_pos_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `repeat_on_day_of_month` int(11) NOT NULL DEFAULT '0',
  `contact_person` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `in_words` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipping_address` text COLLATE utf8mb4_unicode_ci,
  `recurring_print_format` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `additional_discount_percentage` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `campaign` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `base_paid_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `remarks` text COLLATE utf8mb4_unicode_ci,
  `conversion_rate` decimal(21,9) NOT NULL DEFAULT '0.000000000',
  `to_date` date DEFAULT NULL,
  `total_advance` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `posting_time` time(6) DEFAULT NULL,
  `total` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `customer_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `commission_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `update_stock` int(1) NOT NULL DEFAULT '0',
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `base_total` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `from_date` date DEFAULT NULL,
  `account_for_change_amount` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `territory` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sales_partner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `company` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `base_rounded_total` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `is_pos` int(1) NOT NULL DEFAULT '0',
  `customer` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `grand_total` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `notify_by_email` int(1) NOT NULL DEFAULT '0',
  `is_recurring` int(1) NOT NULL DEFAULT '0',
  `language` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `project` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rounded_total` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `posting_date` date DEFAULT NULL,
  `customer_group` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_display` text COLLATE utf8mb4_unicode_ci,
  `naming_series` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `currency` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `letter_head` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `recurring_id` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipping_rule` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ignore_pricing_rule` int(1) NOT NULL DEFAULT '0',
  `paid_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `debit_to` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `base_change_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `amended_from` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `base_grand_total` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `recurring_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Draft',
  `total_billing_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `taxes_and_charges` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `outstanding_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `change_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `write_off_account` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notification_email_address` longtext COLLATE utf8mb4_unicode_ci,
  `c_form_no` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `plc_conversion_rate` decimal(21,9) NOT NULL DEFAULT '0.000000000',
  `total_taxes_and_charges` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `contact_email` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `customer` (`customer`),
  KEY `posting_date` (`posting_date`),
  KEY `debit_to` (`debit_to`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabSales Invoice Advance`
--

DROP TABLE IF EXISTS `tabSales Invoice Advance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabSales Invoice Advance` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `reference_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `advance_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `reference_row` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reference_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remarks` text COLLATE utf8mb4_unicode_ci,
  `allocated_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabSales Invoice Item`
--

DROP TABLE IF EXISTS `tabSales Invoice Item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabSales Invoice Item` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `item_group` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `base_price_list_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `actual_batch_qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `serial_no` text COLLATE utf8mb4_unicode_ci,
  `base_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `expense_account` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `item_tax_rate` text COLLATE utf8mb4_unicode_ci,
  `delivery_note` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cost_center` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target_warehouse` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dn_detail` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `actual_qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `quality_inspection` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `so_detail` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `base_net_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `discount_percentage` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `item_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `base_net_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `margin_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `net_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `stock_uom` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `asset` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `warehouse` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` text COLLATE utf8mb4_unicode_ci,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `brand` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `barcode` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `base_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `item_code` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `page_break` int(1) NOT NULL DEFAULT '0',
  `pricing_rule` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `delivered_qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `net_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `price_list_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `sales_order` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `margin_rate_or_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `income_account` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `customer_item_code` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `batch_no` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `delivered_by_supplier` int(1) NOT NULL DEFAULT '0',
  `is_fixed_asset` int(1) NOT NULL DEFAULT '0',
  `total_margin` decimal(18,6) NOT NULL DEFAULT '0.000000',
  PRIMARY KEY (`name`),
  KEY `delivery_note` (`delivery_note`),
  KEY `dn_detail` (`dn_detail`),
  KEY `so_detail` (`so_detail`),
  KEY `item_code` (`item_code`),
  KEY `sales_order` (`sales_order`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabSales Invoice Payment`
--

DROP TABLE IF EXISTS `tabSales Invoice Payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabSales Invoice Payment` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `account` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mode_of_payment` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `base_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabSales Invoice Timesheet`
--

DROP TABLE IF EXISTS `tabSales Invoice Timesheet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabSales Invoice Timesheet` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `timesheet_detail` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `billing_hours` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `time_sheet` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `billing_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabSales Order`
--

DROP TABLE IF EXISTS `tabSales Order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabSales Order` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `billing_status` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT '{customer_name}',
  `selling_price_list` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tc_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `source` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `submit_on_creation` int(1) NOT NULL DEFAULT '0',
  `base_in_words` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ignore_pricing_rule` int(1) NOT NULL DEFAULT '0',
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `base_discount_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `notify_by_email` int(1) NOT NULL DEFAULT '0',
  `base_total_taxes_and_charges` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `discount_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `base_grand_total` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `select_print_heading` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `delivery_date` date DEFAULT NULL,
  `total_taxes_and_charges` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `party_account_currency` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `po_date` date DEFAULT NULL,
  `price_list_currency` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_display` text COLLATE utf8mb4_unicode_ci,
  `next_date` date DEFAULT NULL,
  `terms` longtext COLLATE utf8mb4_unicode_ci,
  `advance_paid` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `customer_address` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_commission` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `contact_mobile` text COLLATE utf8mb4_unicode_ci,
  `delivery_status` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `base_net_total` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `language` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rounded_total` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `shipping_address_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `apply_discount_on` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Grand Total',
  `po_no` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `repeat_on_day_of_month` int(11) NOT NULL DEFAULT '0',
  `contact_person` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `in_words` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `recurring_print_format` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `additional_discount_percentage` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `campaign` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `conversion_rate` decimal(21,9) NOT NULL DEFAULT '0.000000000',
  `to_date` date DEFAULT NULL,
  `total` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `customer_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `commission_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `base_total` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `from_date` date DEFAULT NULL,
  `territory` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sales_partner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `company` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_email` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `grand_total` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `notification_email_address` longtext COLLATE utf8mb4_unicode_ci,
  `is_recurring` int(1) NOT NULL DEFAULT '0',
  `project` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipping_address` text COLLATE utf8mb4_unicode_ci,
  `customer_group` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_display` text COLLATE utf8mb4_unicode_ci,
  `naming_series` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `currency` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `letter_head` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `recurring_id` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipping_rule` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Sales',
  `amended_from` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transaction_date` date DEFAULT NULL,
  `recurring_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `per_delivered` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `status` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Draft',
  `group_same_items` int(1) NOT NULL DEFAULT '0',
  `taxes_and_charges` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `per_billed` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `plc_conversion_rate` decimal(21,9) NOT NULL DEFAULT '0.000000000',
  `net_total` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `base_rounded_total` decimal(18,6) NOT NULL DEFAULT '0.000000',
  PRIMARY KEY (`name`),
  KEY `delivery_date` (`delivery_date`),
  KEY `territory` (`territory`),
  KEY `sales_partner` (`sales_partner`),
  KEY `company` (`company`),
  KEY `customer` (`customer`),
  KEY `project` (`project`),
  KEY `customer_group` (`customer_group`),
  KEY `transaction_date` (`transaction_date`),
  KEY `status` (`status`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabSales Order Item`
--

DROP TABLE IF EXISTS `tabSales Order Item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabSales Order Item` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `image` text COLLATE utf8mb4_unicode_ci,
  `base_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `margin_rate_or_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `target_warehouse` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `actual_qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `stock_uom` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `page_break` int(1) NOT NULL DEFAULT '0',
  `base_net_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `discount_percentage` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `item_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `base_net_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `margin_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `net_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `transaction_date` date DEFAULT NULL,
  `ordered_qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `base_price_list_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `supplier` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `prevdoc_docname` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `returned_qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `brand` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `base_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `item_code` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `produced_qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `projected_qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `warehouse` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `billed_amt` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `pricing_rule` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `delivered_qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `net_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `price_list_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `item_tax_rate` longtext COLLATE utf8mb4_unicode_ci,
  `item_group` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `planned_qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `gross_profit` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `customer_item_code` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `valuation_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `delivered_by_supplier` int(1) NOT NULL DEFAULT '0',
  `total_margin` decimal(18,6) NOT NULL DEFAULT '0.000000',
  PRIMARY KEY (`name`),
  KEY `prevdoc_docname` (`prevdoc_docname`),
  KEY `brand` (`brand`),
  KEY `item_group` (`item_group`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabSales Partner`
--

DROP TABLE IF EXISTS `tabSales Partner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabSales Partner` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `partner_website` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logo` text COLLATE utf8mb4_unicode_ci,
  `commission_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `partner_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `distribution_id` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `territory` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `partner_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `show_in_website` int(1) NOT NULL DEFAULT '0',
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `route` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `introduction` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  UNIQUE KEY `route` (`route`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabSales Person`
--

DROP TABLE IF EXISTS `tabSales Person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabSales Person` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `old_parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `rgt` int(11) NOT NULL DEFAULT '0',
  `lft` int(11) NOT NULL DEFAULT '0',
  `is_group` int(1) NOT NULL DEFAULT '0',
  `sales_person_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `enabled` int(1) NOT NULL DEFAULT '1',
  `distribution_id` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `employee` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_sales_person` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `rgt` (`rgt`),
  KEY `lft` (`lft`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabSales Taxes and Charges`
--

DROP TABLE IF EXISTS `tabSales Taxes and Charges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabSales Taxes and Charges` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `charge_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `base_tax_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `tax_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `item_wise_tax_detail` longtext COLLATE utf8mb4_unicode_ci,
  `base_tax_amount_after_discount_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `base_total` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `included_in_print_rate` int(1) NOT NULL DEFAULT '0',
  `rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `account_head` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cost_center` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tax_amount_after_discount_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `row_id` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total` decimal(18,6) NOT NULL DEFAULT '0.000000',
  PRIMARY KEY (`name`),
  KEY `parenttype` (`parenttype`),
  KEY `account_head` (`account_head`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabSales Taxes and Charges Template`
--

DROP TABLE IF EXISTS `tabSales Taxes and Charges Template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabSales Taxes and Charges Template` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `disabled` int(1) NOT NULL DEFAULT '0',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `title` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `company` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `is_default` int(1) NOT NULL DEFAULT '0',
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabSales Team`
--

DROP TABLE IF EXISTS `tabSales Team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabSales Team` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `contact_no` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `incentives` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `allocated_percentage` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `sales_person` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `allocated_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  PRIMARY KEY (`name`),
  KEY `sales_person` (`sales_person`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabSerial No`
--

DROP TABLE IF EXISTS `tabSerial No`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabSerial No` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `purchase_time` time(6) DEFAULT NULL,
  `delivery_document_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `serial_no` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `purchase_document_no` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `supplier` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amc_expiry_date` date DEFAULT NULL,
  `purchase_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `item_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `purchase_document_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `brand` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `description` text COLLATE utf8mb4_unicode_ci,
  `purchase_date` date DEFAULT NULL,
  `company` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `item_code` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `warehouse` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `supplier_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_cancelled` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `maintenance_status` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `delivery_time` time(6) DEFAULT NULL,
  `delivery_document_no` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `item_group` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `warranty_period` int(11) NOT NULL DEFAULT '0',
  `serial_no_details` longtext COLLATE utf8mb4_unicode_ci,
  `warranty_expiry_date` date DEFAULT NULL,
  `delivery_date` date DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `serial_no` (`serial_no`),
  KEY `company` (`company`),
  KEY `warehouse` (`warehouse`),
  KEY `maintenance_status` (`maintenance_status`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabSeries`
--

DROP TABLE IF EXISTS `tabSeries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabSeries` (
  `name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `current` int(10) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabSessions`
--

DROP TABLE IF EXISTS `tabSessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabSessions` (
  `user` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sessiondata` longtext COLLATE utf8mb4_unicode_ci,
  `ipaddress` varchar(16) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lastupdate` datetime(6) DEFAULT NULL,
  `device` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'desktop',
  `status` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  KEY `sid` (`sid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabShipping Rule`
--

DROP TABLE IF EXISTS `tabShipping Rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabShipping Rule` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `calculate_based_on` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Net Total',
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `worldwide_shipping` int(1) NOT NULL DEFAULT '0',
  `company` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `account` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `label` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `disabled` int(1) NOT NULL DEFAULT '0',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `cost_center` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabShipping Rule Condition`
--

DROP TABLE IF EXISTS `tabShipping Rule Condition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabShipping Rule Condition` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `to_value` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `from_value` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `shipping_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabShipping Rule Country`
--

DROP TABLE IF EXISTS `tabShipping Rule Country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabShipping Rule Country` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `country` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabSingles`
--

DROP TABLE IF EXISTS `tabSingles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabSingles` (
  `doctype` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` text COLLATE utf8mb4_unicode_ci,
  KEY `singles_doctype_field_index` (`doctype`,`field`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabStandard Reply`
--

DROP TABLE IF EXISTS `tabStandard Reply`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabStandard Reply` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `response` longtext COLLATE utf8mb4_unicode_ci,
  `subject` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabStock Entry`
--

DROP TABLE IF EXISTS `tabStock Entry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabStock Entry` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `use_multi_level_bom` int(1) NOT NULL DEFAULT '1',
  `delivery_note_no` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `supplier_address` text COLLATE utf8mb4_unicode_ci,
  `naming_series` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fg_completed_qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `letter_head` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `purchase_receipt_no` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `posting_time` time(6) DEFAULT NULL,
  `customer_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT '{purpose}',
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `from_warehouse` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amended_from` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `purchase_order` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `from_bom` int(1) NOT NULL DEFAULT '0',
  `to_warehouse` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `supplier` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value_difference` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `credit_note` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sales_invoice_no` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bom_no` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_address` text COLLATE utf8mb4_unicode_ci,
  `purpose` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Material Issue',
  `supplier_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remarks` text COLLATE utf8mb4_unicode_ci,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `total_additional_costs` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `customer` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `total_incoming_value` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `project` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `select_print_heading` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `posting_date` date DEFAULT NULL,
  `production_order` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_outgoing_value` decimal(18,6) NOT NULL DEFAULT '0.000000',
  PRIMARY KEY (`name`),
  KEY `delivery_note_no` (`delivery_note_no`),
  KEY `purchase_receipt_no` (`purchase_receipt_no`),
  KEY `posting_date` (`posting_date`),
  KEY `production_order` (`production_order`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabStock Entry Detail`
--

DROP TABLE IF EXISTS `tabStock Entry Detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabStock Entry Detail` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `t_warehouse` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transfer_qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `basic_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `image` text COLLATE utf8mb4_unicode_ci,
  `serial_no` text COLLATE utf8mb4_unicode_ci,
  `expense_account` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cost_center` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `actual_qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `s_warehouse` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stock_uom` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `item_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `additional_cost` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `conversion_factor` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `uom` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `basic_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `barcode` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `item_code` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `bom_no` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `material_request_item` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `batch_no` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `valuation_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `material_request` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `actual_qty` (`actual_qty`),
  KEY `item_code` (`item_code`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabStock Ledger Entry`
--

DROP TABLE IF EXISTS `tabStock Ledger Entry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabStock Ledger Entry` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `serial_no` text COLLATE utf8mb4_unicode_ci,
  `fiscal_year` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `voucher_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `posting_time` time(6) DEFAULT NULL,
  `voucher_no` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `qty_after_transaction` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `incoming_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `voucher_detail_no` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `actual_qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `stock_uom` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `warehouse` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `company` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `item_code` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stock_queue` text COLLATE utf8mb4_unicode_ci,
  `valuation_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `outgoing_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `is_cancelled` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stock_value` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `project` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `batch_no` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stock_value_difference` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `posting_date` date DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `warehouse` (`warehouse`),
  KEY `item_code` (`item_code`),
  KEY `posting_date` (`posting_date`),
  KEY `parent` (`parent`),
  KEY `posting_sort_index` (`posting_date`,`posting_time`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabStock Reconciliation`
--

DROP TABLE IF EXISTS `tabStock Reconciliation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabStock Reconciliation` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `difference_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `company` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `amended_from` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reconciliation_json` longtext COLLATE utf8mb4_unicode_ci,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `naming_series` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `expense_account` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `posting_date` date DEFAULT NULL,
  `cost_center` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `posting_time` time(6) DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabStock Reconciliation Item`
--

DROP TABLE IF EXISTS `tabStock Reconciliation Item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabStock Reconciliation Item` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `barcode` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount_difference` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `current_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `item_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `current_qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `quantity_difference` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `item_code` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `warehouse` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `valuation_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `current_valuation_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabStudent`
--

DROP TABLE IF EXISTS `tabStudent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabStudent` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `last_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `blood_group` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `naming_series` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` text COLLATE utf8mb4_unicode_ci,
  `pincode` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `student_mobile_number` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `student_email_id` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `first_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `middle_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `state` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `student_applicant` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `nationality` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `joining_date` date DEFAULT NULL,
  `gender` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_line_2` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_line_1` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  UNIQUE KEY `student_email_id` (`student_email_id`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabStudent Admission`
--

DROP TABLE IF EXISTS `tabStudent Admission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabStudent Admission` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `academic_year` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `application_fee` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `title` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `introduction` longtext COLLATE utf8mb4_unicode_ci,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `route` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `admission_start_date` date DEFAULT NULL,
  `admission_end_date` date DEFAULT NULL,
  `currency` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `program` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `naming_series_for_student_applicant` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `publish` int(1) NOT NULL DEFAULT '0',
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `eligibility` longtext COLLATE utf8mb4_unicode_ci,
  `application_form_route` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  UNIQUE KEY `route` (`route`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabStudent Applicant`
--

DROP TABLE IF EXISTS `tabStudent Applicant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabStudent Applicant` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `program` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `academic_year` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `blood_group` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `naming_series` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` text COLLATE utf8mb4_unicode_ci,
  `pincode` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `student_mobile_number` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `student_email_id` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `first_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `middle_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `amended_from` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `application_status` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `paid` int(1) NOT NULL DEFAULT '0',
  `student_admission` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nationality` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `application_date` date DEFAULT NULL,
  `gender` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_line_2` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_line_1` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  UNIQUE KEY `student_email_id` (`student_email_id`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabStudent Attendance`
--

DROP TABLE IF EXISTS `tabStudent Attendance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabStudent Attendance` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `status` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Present',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `course_schedule` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `student_batch` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `amended_from` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `student` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date` date DEFAULT NULL,
  `student_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabStudent Batch`
--

DROP TABLE IF EXISTS `tabStudent Batch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabStudent Batch` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `academic_year` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `enabled` int(1) NOT NULL DEFAULT '1',
  `academic_term` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `program` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `student_batch_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabStudent Batch Instructor`
--

DROP TABLE IF EXISTS `tabStudent Batch Instructor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabStudent Batch Instructor` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `instructor_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `instructor` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabStudent Batch Name`
--

DROP TABLE IF EXISTS `tabStudent Batch Name`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabStudent Batch Name` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `batch_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabStudent Batch Student`
--

DROP TABLE IF EXISTS `tabStudent Batch Student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabStudent Batch Student` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `active` int(1) NOT NULL DEFAULT '1',
  `student_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `student` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabStudent Category`
--

DROP TABLE IF EXISTS `tabStudent Category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabStudent Category` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `category` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabStudent Group`
--

DROP TABLE IF EXISTS `tabStudent Group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabStudent Group` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `academic_year` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `student_batch` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `max_strength` int(11) NOT NULL DEFAULT '0',
  `academic_term` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amended_from` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `program` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `course` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabStudent Group Creation Tool Course`
--

DROP TABLE IF EXISTS `tabStudent Group Creation Tool Course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabStudent Group Creation Tool Course` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `course` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `student_group_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `course_code` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `max_strength` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabStudent Group Student`
--

DROP TABLE IF EXISTS `tabStudent Group Student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabStudent Group Student` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `active` int(1) NOT NULL DEFAULT '1',
  `student_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `student` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabStudent Guardian`
--

DROP TABLE IF EXISTS `tabStudent Guardian`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabStudent Guardian` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `guardian` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `relation` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabStudent Leave Application`
--

DROP TABLE IF EXISTS `tabStudent Leave Application`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabStudent Leave Application` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `amended_from` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `from_date` date DEFAULT NULL,
  `mark_as_present` int(1) NOT NULL DEFAULT '0',
  `reason` text COLLATE utf8mb4_unicode_ci,
  `to_date` date DEFAULT NULL,
  `student` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `student_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabStudent Log`
--

DROP TABLE IF EXISTS `tabStudent Log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabStudent Log` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `log` longtext COLLATE utf8mb4_unicode_ci,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `_seen` text COLLATE utf8mb4_unicode_ci,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `student` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date` date DEFAULT NULL,
  `student_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabStudent Sibling`
--

DROP TABLE IF EXISTS `tabStudent Sibling`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabStudent Sibling` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `gender` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `program` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `full_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `institution` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabStudent Siblings`
--

DROP TABLE IF EXISTS `tabStudent Siblings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabStudent Siblings` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `gender` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `name1` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabSupplier`
--

DROP TABLE IF EXISTS `tabSupplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabSupplier` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `website` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `naming_series` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` text COLLATE utf8mb4_unicode_ci,
  `disabled` int(1) NOT NULL DEFAULT '0',
  `default_currency` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `credit_days` int(11) NOT NULL DEFAULT '0',
  `status` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `credit_days_based_on` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `supplier_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `supplier_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `language` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `default_price_list` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_frozen` int(1) NOT NULL DEFAULT '0',
  `supplier_details` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabSupplier Quotation`
--

DROP TABLE IF EXISTS `tabSupplier Quotation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabSupplier Quotation` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `additional_discount_percentage` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `naming_series` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_mobile` text COLLATE utf8mb4_unicode_ci,
  `net_total` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `currency` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `conversion_rate` decimal(21,9) NOT NULL DEFAULT '0.000000000',
  `base_taxes_and_charges_deducted` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `total` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `select_print_heading` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_subcontracted` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'No',
  `title` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT '{supplier_name}',
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `base_total` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `transaction_date` date DEFAULT NULL,
  `base_taxes_and_charges_added` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `tc_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amended_from` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `base_grand_total` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `supplier_address` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `supplier` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_display` text COLLATE utf8mb4_unicode_ci,
  `buying_price_list` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `terms` longtext COLLATE utf8mb4_unicode_ci,
  `ignore_pricing_rule` int(1) NOT NULL DEFAULT '0',
  `base_rounded_total` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `taxes_and_charges` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `grand_total` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `base_discount_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `base_total_taxes_and_charges` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `supplier_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `base_in_words` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `opportunity` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `taxes_and_charges_added` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `base_net_total` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `in_words` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `taxes_and_charges_deducted` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `language` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_display` text COLLATE utf8mb4_unicode_ci,
  `discount_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `apply_discount_on` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Grand Total',
  `letter_head` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `plc_conversion_rate` decimal(21,9) NOT NULL DEFAULT '0.000000000',
  `total_taxes_and_charges` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `price_list_currency` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_email` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_person` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `transaction_date` (`transaction_date`),
  KEY `supplier` (`supplier`),
  KEY `company` (`company`),
  KEY `status` (`status`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabSupplier Quotation Item`
--

DROP TABLE IF EXISTS `tabSupplier Quotation Item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabSupplier Quotation Item` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `stock_qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `image` text COLLATE utf8mb4_unicode_ci,
  `base_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `item_tax_rate` longtext COLLATE utf8mb4_unicode_ci,
  `rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `stock_uom` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `project` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `page_break` int(1) NOT NULL DEFAULT '0',
  `base_net_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `discount_percentage` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `item_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `base_net_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `net_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `conversion_factor` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `base_price_list_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `warehouse` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `supplier_part_no` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `uom` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `brand` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `base_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `item_code` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `material_request` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pricing_rule` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price_list_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `request_for_quotation` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `item_group` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `material_request_item` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `request_for_quotation_item` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `net_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `prevdoc_doctype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `item_name` (`item_name`),
  KEY `item_code` (`item_code`),
  KEY `material_request` (`material_request`),
  KEY `material_request_item` (`material_request_item`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabSupplier Type`
--

DROP TABLE IF EXISTS `tabSupplier Type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabSupplier Type` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `credit_days_based_on` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `credit_days` int(11) NOT NULL DEFAULT '0',
  `supplier_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabTag`
--

DROP TABLE IF EXISTS `tabTag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabTag` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `tag_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabTag Category`
--

DROP TABLE IF EXISTS `tabTag Category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabTag Category` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `category_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabTag Doc Category`
--

DROP TABLE IF EXISTS `tabTag Doc Category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabTag Doc Category` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `tagdoc` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabTarget Detail`
--

DROP TABLE IF EXISTS `tabTarget Detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabTarget Detail` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `item_group` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target_qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `fiscal_year` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  PRIMARY KEY (`name`),
  KEY `item_group` (`item_group`),
  KEY `fiscal_year` (`fiscal_year`),
  KEY `target_amount` (`target_amount`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabTask`
--

DROP TABLE IF EXISTS `tabTask`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabTask` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `status` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `exp_end_date` date DEFAULT NULL,
  `review_date` date DEFAULT NULL,
  `total_expense_claim` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `expected_time` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `subject` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `act_end_date` date DEFAULT NULL,
  `task_weight` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `depends_on_tasks` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_costing_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `priority` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `progress` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `total_billing_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `company` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `_seen` text COLLATE utf8mb4_unicode_ci,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `act_start_date` date DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `closing_date` date DEFAULT NULL,
  `project` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `exp_start_date` date DEFAULT NULL,
  `actual_time` decimal(18,6) NOT NULL DEFAULT '0.000000',
  PRIMARY KEY (`name`),
  KEY `exp_end_date` (`exp_end_date`),
  KEY `priority` (`priority`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabTask Depends On`
--

DROP TABLE IF EXISTS `tabTask Depends On`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabTask Depends On` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `task` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subject` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabTax Rule`
--

DROP TABLE IF EXISTS `tabTax Rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabTax Rule` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `sales_tax_template` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `to_date` date DEFAULT NULL,
  `billing_country` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `use_for_shopping_cart` int(1) NOT NULL DEFAULT '0',
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `tax_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Sales',
  `priority` int(11) NOT NULL DEFAULT '1',
  `from_date` date DEFAULT NULL,
  `supplier` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `billing_county` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `shipping_city` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `purchase_tax_template` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `shipping_state` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipping_county` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `supplier_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `customer` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `billing_city` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_group` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipping_country` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `billing_state` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabTerms and Conditions`
--

DROP TABLE IF EXISTS `tabTerms and Conditions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabTerms and Conditions` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `terms` longtext COLLATE utf8mb4_unicode_ci,
  `title` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `disabled` int(1) NOT NULL DEFAULT '0',
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabTerritory`
--

DROP TABLE IF EXISTS `tabTerritory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabTerritory` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `rgt` int(11) NOT NULL DEFAULT '0',
  `distribution_id` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `is_group` int(1) NOT NULL DEFAULT '0',
  `territory_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `old_parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lft` int(11) NOT NULL DEFAULT '0',
  `parent_territory` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `territory_manager` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `rgt` (`rgt`),
  KEY `lft` (`lft`),
  KEY `territory_manager` (`territory_manager`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabTimesheet`
--

DROP TABLE IF EXISTS `tabTimesheet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabTimesheet` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `naming_series` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `total_billable_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `total_costing_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `note` longtext COLLATE utf8mb4_unicode_ci,
  `amended_from` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `employee` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_billable_hours` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `start_date` date DEFAULT NULL,
  `status` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Draft',
  `total_billed_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `end_date` date DEFAULT NULL,
  `company` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `per_billed` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `salary_slip` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_billed_hours` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `user` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `employee_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `sales_invoice` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_hours` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `production_order` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabTimesheet Detail`
--

DROP TABLE IF EXISTS `tabTimesheet Detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabTimesheet Detail` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `billing_hours` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `costing_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `billing_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `operation` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `costing_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `completed_qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `billable` int(1) NOT NULL DEFAULT '0',
  `to_time` datetime(6) DEFAULT NULL,
  `from_time` datetime(6) DEFAULT NULL,
  `hours` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `workstation` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `task` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sales_invoice` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `billing_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `project` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `operation_id` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `activity_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabToDo`
--

DROP TABLE IF EXISTS `tabToDo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabToDo` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `status` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Open',
  `sender` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `assigned_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_seen` text COLLATE utf8mb4_unicode_ci,
  `reference_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reference_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `priority` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Medium',
  `date` date DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `role` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `assigned_by_full_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`),
  KEY `reference_type_reference_name_index` (`reference_type`,`reference_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabTop Bar Item`
--

DROP TABLE IF EXISTS `tabTop Bar Item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabTop Bar Item` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `url` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_label` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `right` int(1) NOT NULL DEFAULT '1',
  `target` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `label` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabTopic`
--

DROP TABLE IF EXISTS `tabTopic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabTopic` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `introduction` text COLLATE utf8mb4_unicode_ci,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `topic_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` longtext COLLATE utf8mb4_unicode_ci,
  `course` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `course` (`course`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabTraining Event`
--

DROP TABLE IF EXISTS `tabTraining Event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabTraining Event` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `trainer_email` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `course` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `event_status` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_number` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `introduction` longtext COLLATE utf8mb4_unicode_ci,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `amended_from` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `location` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `supplier` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `event_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `start_time` datetime(6) DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `send_email` int(1) NOT NULL DEFAULT '0',
  `trainer_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `end_time` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabTraining Event Employee`
--

DROP TABLE IF EXISTS `tabTraining Event Employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabTraining Event Employee` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `status` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Open',
  `employee` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `employee_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabTraining Feedback`
--

DROP TABLE IF EXISTS `tabTraining Feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabTraining Feedback` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `feedback` text COLLATE utf8mb4_unicode_ci,
  `amended_from` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `event_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `course` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `trainer_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `employee_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `employee` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `training_event` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabTraining Result`
--

DROP TABLE IF EXISTS `tabTraining Result`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabTraining Result` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `training_event` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `amended_from` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  UNIQUE KEY `training_event` (`training_event`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabTraining Result Employee`
--

DROP TABLE IF EXISTS `tabTraining Result Employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabTraining Result Employee` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `grade` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `comments` text COLLATE utf8mb4_unicode_ci,
  `hours` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `employee_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `employee` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabTranslation`
--

DROP TABLE IF EXISTS `tabTranslation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabTranslation` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `source_name` longtext COLLATE utf8mb4_unicode_ci,
  `language` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target_name` longtext COLLATE utf8mb4_unicode_ci,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `language` (`language`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabUOM`
--

DROP TABLE IF EXISTS `tabUOM`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabUOM` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `uom_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `must_be_whole_number` int(1) NOT NULL DEFAULT '0',
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabUOM Conversion Detail`
--

DROP TABLE IF EXISTS `tabUOM Conversion Detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabUOM Conversion Detail` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `conversion_factor` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `uom` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabUnhandled Email`
--

DROP TABLE IF EXISTS `tabUnhandled Email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabUnhandled Email` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `uid` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `raw` longtext COLLATE utf8mb4_unicode_ci,
  `reason` longtext COLLATE utf8mb4_unicode_ci,
  `email_account` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `message_id` longtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabUser`
--

DROP TABLE IF EXISTS `tabUser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabUser` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `user_image` text COLLATE utf8mb4_unicode_ci,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `full_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `frappe_userid` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `simultaneous_sessions` int(11) NOT NULL DEFAULT '1',
  `google_userid` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'System User',
  `time_zone` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mute_sounds` int(1) NOT NULL DEFAULT '0',
  `last_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `github_username` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_known_versions` text COLLATE utf8mb4_unicode_ci,
  `thread_notify` int(1) NOT NULL DEFAULT '1',
  `background_image` text COLLATE utf8mb4_unicode_ci,
  `last_active` datetime(6) DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `new_password` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_login` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `github_userid` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `login_after` int(11) NOT NULL DEFAULT '0',
  `email` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `restrict_ip` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `username` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bio` text COLLATE utf8mb4_unicode_ci,
  `last_ip` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fb_userid` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `background_style` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `first_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `send_password_update_notification` int(1) NOT NULL DEFAULT '0',
  `phone` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `middle_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `send_welcome_email` int(1) NOT NULL DEFAULT '1',
  `email_signature` text COLLATE utf8mb4_unicode_ci,
  `language` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reset_password_key` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gender` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `login_before` int(11) NOT NULL DEFAULT '0',
  `enabled` int(1) NOT NULL DEFAULT '1',
  `location` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fb_username` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `redirect_url` text COLLATE utf8mb4_unicode_ci,
  `birth_date` date DEFAULT NULL,
  `unsubscribed` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`name`),
  UNIQUE KEY `username` (`username`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabUser Email`
--

DROP TABLE IF EXISTS `tabUser Email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabUser Email` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `email_id` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_account` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `awaiting_password` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabUserRole`
--

DROP TABLE IF EXISTS `tabUserRole`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabUserRole` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `role` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabVehicle`
--

DROP TABLE IF EXISTS `tabVehicle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabVehicle` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `color` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `acquisition_date` date DEFAULT NULL,
  `license_plate` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `carbon_check_date` date DEFAULT NULL,
  `last_odometer` int(11) NOT NULL DEFAULT '0',
  `policy_no` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amended_from` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `make` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `vehicle_value` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `location` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `doors` int(11) NOT NULL DEFAULT '0',
  `employee` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `uom` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Litre',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `end_date` date DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `insurance_company` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `wheels` int(11) NOT NULL DEFAULT '0',
  `chassis_no` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `model` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fuel_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  UNIQUE KEY `license_plate` (`license_plate`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabVehicle Log`
--

DROP TABLE IF EXISTS `tabVehicle Log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabVehicle Log` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `naming_series` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `license_plate` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `invoice` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fuel_qty` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `make` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `odometer` int(11) NOT NULL DEFAULT '0',
  `amended_from` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `supplier` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `price` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `employee` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date` date DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `model` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabVehicle Service`
--

DROP TABLE IF EXISTS `tabVehicle Service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabVehicle Service` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `expense_amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `frequency` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `service_item` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabVersion`
--

DROP TABLE IF EXISTS `tabVersion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabVersion` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `ref_doctype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `docname` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data` longtext COLLATE utf8mb4_unicode_ci,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabWarehouse`
--

DROP TABLE IF EXISTS `tabWarehouse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabWarehouse` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `pin` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_id` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `disabled` int(1) NOT NULL DEFAULT '0',
  `lft` int(11) NOT NULL DEFAULT '0',
  `parent_warehouse` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mobile_no` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rgt` int(11) NOT NULL DEFAULT '0',
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `state` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_account_under` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `company` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `is_group` int(1) NOT NULL DEFAULT '0',
  `warehouse_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `old_parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone_no` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_line_2` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_line_1` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent_warehouse` (`parent_warehouse`),
  KEY `company` (`company`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabWarranty Claim`
--

DROP TABLE IF EXISTS `tabWarranty Claim`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabWarranty Claim` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `status` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Open',
  `contact_email` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `naming_series` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `serial_no` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `resolved_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `warranty_amc_status` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amc_expiry_date` date DEFAULT NULL,
  `complaint_date` date DEFAULT NULL,
  `item_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `from_company` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amended_from` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_display` text COLLATE utf8mb4_unicode_ci,
  `territory` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_display` text COLLATE utf8mb4_unicode_ci,
  `complaint` longtext COLLATE utf8mb4_unicode_ci,
  `service_address` text COLLATE utf8mb4_unicode_ci,
  `description` text COLLATE utf8mb4_unicode_ci,
  `complaint_raised_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `item_code` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_address` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_mobile` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `resolution_date` datetime(6) DEFAULT NULL,
  `customer` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `resolution_details` text COLLATE utf8mb4_unicode_ci,
  `customer_group` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `warranty_expiry_date` date DEFAULT NULL,
  `contact_person` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `status` (`status`),
  KEY `resolved_by` (`resolved_by`),
  KEY `complaint_date` (`complaint_date`),
  KEY `territory` (`territory`),
  KEY `company` (`company`),
  KEY `item_code` (`item_code`),
  KEY `resolution_date` (`resolution_date`),
  KEY `customer` (`customer`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabWeb Form`
--

DROP TABLE IF EXISTS `tabWeb Form`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabWeb Form` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `allow_edit` int(1) NOT NULL DEFAULT '0',
  `amount_based_on_field` int(1) NOT NULL DEFAULT '0',
  `amount_field` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `currency` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `accept_payment` int(1) NOT NULL DEFAULT '0',
  `payment_button_help` text COLLATE utf8mb4_unicode_ci,
  `title` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `breadcrumbs` longtext COLLATE utf8mb4_unicode_ci,
  `login_required` int(1) NOT NULL DEFAULT '0',
  `allow_delete` int(1) NOT NULL DEFAULT '0',
  `max_attachment_size` int(11) NOT NULL DEFAULT '0',
  `show_sidebar` int(1) NOT NULL DEFAULT '1',
  `payment_button_label` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Buy Now',
  `success_message` text COLLATE utf8mb4_unicode_ci,
  `introduction_text` text COLLATE utf8mb4_unicode_ci,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `allow_multiple` int(1) NOT NULL DEFAULT '0',
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `allow_print` int(1) NOT NULL DEFAULT '0',
  `allow_incomplete` int(1) NOT NULL DEFAULT '0',
  `is_standard` int(1) NOT NULL DEFAULT '0',
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `module` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `doc_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `allow_comments` int(1) NOT NULL DEFAULT '0',
  `print_format` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `route` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `success_url` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `published` int(1) NOT NULL DEFAULT '0',
  `web_page_link_text` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_gateway` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  UNIQUE KEY `route` (`route`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabWeb Form Field`
--

DROP TABLE IF EXISTS `tabWeb Form Field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabWeb Form Field` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `read_only` int(1) NOT NULL DEFAULT '0',
  `description` text COLLATE utf8mb4_unicode_ci,
  `default` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `max_value` int(11) NOT NULL DEFAULT '0',
  `label` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `max_length` int(11) NOT NULL DEFAULT '0',
  `fieldname` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fieldtype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reqd` int(1) NOT NULL DEFAULT '0',
  `hidden` int(1) NOT NULL DEFAULT '0',
  `options` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabWeb Page`
--

DROP TABLE IF EXISTS `tabWeb Page`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabWeb Page` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `insert_style` int(1) NOT NULL DEFAULT '0',
  `header` text COLLATE utf8mb4_unicode_ci,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `title` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `text_align` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `show_sidebar` int(1) NOT NULL DEFAULT '0',
  `enable_comments` int(1) NOT NULL DEFAULT '0',
  `css` longtext COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `description` text COLLATE utf8mb4_unicode_ci,
  `insert_code` int(1) NOT NULL DEFAULT '0',
  `javascript` longtext COLLATE utf8mb4_unicode_ci,
  `slideshow` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `show_title` int(1) NOT NULL DEFAULT '1',
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `main_section` longtext COLLATE utf8mb4_unicode_ci,
  `route` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `published` int(1) NOT NULL DEFAULT '0',
  `website_sidebar` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  UNIQUE KEY `route` (`route`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabWebsite Item Group`
--

DROP TABLE IF EXISTS `tabWebsite Item Group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabWebsite Item Group` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `item_group` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabWebsite Sidebar`
--

DROP TABLE IF EXISTS `tabWebsite Sidebar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabWebsite Sidebar` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `title` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabWebsite Sidebar Item`
--

DROP TABLE IF EXISTS `tabWebsite Sidebar Item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabWebsite Sidebar Item` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `route` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `group` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabWebsite Slideshow`
--

DROP TABLE IF EXISTS `tabWebsite Slideshow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabWebsite Slideshow` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `slideshow_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `header` longtext COLLATE utf8mb4_unicode_ci,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabWebsite Slideshow Item`
--

DROP TABLE IF EXISTS `tabWebsite Slideshow Item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabWebsite Slideshow Item` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `image` text COLLATE utf8mb4_unicode_ci,
  `description` text COLLATE utf8mb4_unicode_ci,
  `heading` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabWebsite Theme`
--

DROP TABLE IF EXISTS `tabWebsite Theme`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabWebsite Theme` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `heading_style` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link_color` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `module` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'Website',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `footer_text_color` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `heading_webfont` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `background_color` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `apply_style` int(1) NOT NULL DEFAULT '1',
  `background_image` text COLLATE utf8mb4_unicode_ci,
  `top_bar_text_color` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `apply_text_styles` int(1) NOT NULL DEFAULT '0',
  `custom` int(1) NOT NULL DEFAULT '1',
  `theme` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `footer_color` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `css` longtext COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `text_webfont` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `text_color` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `js` longtext COLLATE utf8mb4_unicode_ci,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `font_size` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `top_bar_color` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bootstrap` longtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `theme` (`theme`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabWorkflow`
--

DROP TABLE IF EXISTS `tabWorkflow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabWorkflow` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `override_status` int(1) NOT NULL DEFAULT '0',
  `workflow_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `is_active` int(1) NOT NULL DEFAULT '0',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `workflow_state_field` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT 'workflow_state',
  `document_type` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabWorkflow Action`
--

DROP TABLE IF EXISTS `tabWorkflow Action`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabWorkflow Action` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `workflow_action_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabWorkflow Document State`
--

DROP TABLE IF EXISTS `tabWorkflow Document State`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabWorkflow Document State` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `allow_edit` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `update_field` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `doc_status` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message` text COLLATE utf8mb4_unicode_ci,
  `update_value` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabWorkflow State`
--

DROP TABLE IF EXISTS `tabWorkflow State`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabWorkflow State` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `style` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `workflow_state_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `icon` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabWorkflow Transition`
--

DROP TABLE IF EXISTS `tabWorkflow Transition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabWorkflow Transition` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `action` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `next_state` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `allowed` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabWorkstation`
--

DROP TABLE IF EXISTS `tabWorkstation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabWorkstation` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `hour_rate_rent` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `_liked_by` text COLLATE utf8mb4_unicode_ci,
  `description` text COLLATE utf8mb4_unicode_ci,
  `hour_rate_electricity` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `_user_tags` text COLLATE utf8mb4_unicode_ci,
  `_assign` text COLLATE utf8mb4_unicode_ci,
  `hour_rate_labour` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `hour_rate` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `holiday_list` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `_comments` text COLLATE utf8mb4_unicode_ci,
  `hour_rate_consumable` decimal(18,6) NOT NULL DEFAULT '0.000000',
  `workstation_name` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tabWorkstation Working Hour`
--

DROP TABLE IF EXISTS `tabWorkstation Working Hour`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabWorkstation Working Hour` (
  `name` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creation` datetime(6) DEFAULT NULL,
  `modified` datetime(6) DEFAULT NULL,
  `modified_by` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docstatus` int(1) NOT NULL DEFAULT '0',
  `parent` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parentfield` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parenttype` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idx` int(8) NOT NULL DEFAULT '0',
  `start_time` time(6) DEFAULT NULL,
  `enabled` int(1) NOT NULL DEFAULT '1',
  `end_time` time(6) DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
