-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: localhost    Database: espocrm
-- ------------------------------------------------------
-- Server version	5.7.17-log

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
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account` (
  `id` varchar(24) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `website` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `type` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `industry` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `sic_code` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `billing_address_street` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `billing_address_city` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `billing_address_state` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `billing_address_country` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `billing_address_postal_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `shipping_address_street` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `shipping_address_city` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `shipping_address_state` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `shipping_address_country` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `shipping_address_postal_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` longtext COLLATE utf8_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `campaign_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `assigned_user_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_7D3656A4F639F774` (`campaign_id`),
  KEY `IDX_7D3656A4B03A8386` (`created_by_id`),
  KEY `IDX_7D3656A499049ECE` (`modified_by_id`),
  KEY `IDX_7D3656A4ADF66B1A` (`assigned_user_id`),
  KEY `IDX_ACCOUNT_NAME` (`name`,`deleted`),
  KEY `IDX_ACCOUNT_ASSIGNED_USER` (`assigned_user_id`,`deleted`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `account_contact`
--

DROP TABLE IF EXISTS `account_contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_contact` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contact_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `role` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_8549F2709B6B5FBAE7A1254A` (`account_id`,`contact_id`),
  KEY `IDX_8549F2709B6B5FBA` (`account_id`),
  KEY `IDX_8549F270E7A1254A` (`contact_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `account_document`
--

DROP TABLE IF EXISTS `account_document`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_document` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `document_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_A0A768C09B6B5FBAC33F7837` (`account_id`,`document_id`),
  KEY `IDX_A0A768C09B6B5FBA` (`account_id`),
  KEY `IDX_A0A768C0C33F7837` (`document_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `account_portal_user`
--

DROP TABLE IF EXISTS `account_portal_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_portal_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `account_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_D622EDE7A76ED3959B6B5FBA` (`user_id`,`account_id`),
  KEY `IDX_D622EDE7A76ED395` (`user_id`),
  KEY `IDX_D622EDE79B6B5FBA` (`account_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `account_target_list`
--

DROP TABLE IF EXISTS `account_target_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_target_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `target_list_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `opted_out` tinyint(1) DEFAULT '0',
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_589712AA9B6B5FBAF6C6AFE0` (`account_id`,`target_list_id`),
  KEY `IDX_589712AA9B6B5FBA` (`account_id`),
  KEY `IDX_589712AAF6C6AFE0` (`target_list_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `attachment`
--

DROP TABLE IF EXISTS `attachment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attachment` (
  `id` varchar(24) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `type` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `size` int(11) DEFAULT NULL,
  `source_id` varchar(36) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `role` varchar(36) COLLATE utf8_unicode_ci DEFAULT NULL,
  `storage` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `global` tinyint(1) NOT NULL DEFAULT '0',
  `parent_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `parent_type` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `related_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `related_type` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `parent` (`parent_id`,`parent_type`),
  KEY `related` (`related_id`,`related_type`),
  KEY `IDX_795FD9BBB03A8386` (`created_by_id`),
  KEY `IDX_ATTACHMENT_PARENT` (`parent_type`,`parent_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `auth_token`
--

DROP TABLE IF EXISTS `auth_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_token` (
  `id` varchar(24) COLLATE utf8_unicode_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `token` varchar(36) COLLATE utf8_unicode_ci DEFAULT NULL,
  `hash` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_id` varchar(36) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ip_address` varchar(36) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_access` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `portal_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_9315F04E5F37A13B` (`token`),
  KEY `IDX_9315F04ED1B862B8` (`hash`),
  KEY `IDX_9315F04EA76ED395` (`user_id`),
  KEY `IDX_9315F04EB887E1DD` (`portal_id`),
  KEY `IDX_AUTH_TOKEN_TOKEN` (`token`,`deleted`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `autofollow`
--

DROP TABLE IF EXISTS `autofollow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `autofollow` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entity_type` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `entityType` (`entity_type`),
  KEY `IDX_EB89C717A76ED395` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `call`
--

DROP TABLE IF EXISTS `call`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `call` (
  `id` varchar(24) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `status` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'Planned',
  `date_start` datetime DEFAULT NULL,
  `date_end` datetime DEFAULT NULL,
  `direction` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'Outbound',
  `description` longtext COLLATE utf8_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `parent_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `parent_type` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `account_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `assigned_user_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `parent` (`parent_id`,`parent_type`),
  KEY `IDX_CC8E2F3E9B6B5FBA` (`account_id`),
  KEY `IDX_CC8E2F3EB03A8386` (`created_by_id`),
  KEY `IDX_CC8E2F3E99049ECE` (`modified_by_id`),
  KEY `IDX_CC8E2F3EADF66B1A` (`assigned_user_id`),
  KEY `IDX_CALL_DATE_START_STATUS` (`date_start`,`status`),
  KEY `IDX_CALL_DATE_START` (`date_start`,`deleted`),
  KEY `IDX_CALL_STATUS` (`status`,`deleted`),
  KEY `IDX_CALL_ASSIGNED_USER` (`assigned_user_id`,`deleted`),
  KEY `IDX_CALL_ASSIGNED_USER_STATUS` (`assigned_user_id`,`status`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `call_contact`
--

DROP TABLE IF EXISTS `call_contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `call_contact` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `call_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contact_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` varchar(36) COLLATE utf8_unicode_ci DEFAULT 'None',
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_99C77F0D50A89B2CE7A1254A` (`call_id`,`contact_id`),
  KEY `IDX_99C77F0D50A89B2C` (`call_id`),
  KEY `IDX_99C77F0DE7A1254A` (`contact_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `call_lead`
--

DROP TABLE IF EXISTS `call_lead`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `call_lead` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `call_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lead_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` varchar(36) COLLATE utf8_unicode_ci DEFAULT 'None',
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_1F10069750A89B2C55458D` (`call_id`,`lead_id`),
  KEY `IDX_1F10069750A89B2C` (`call_id`),
  KEY `IDX_1F10069755458D` (`lead_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `call_user`
--

DROP TABLE IF EXISTS `call_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `call_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `call_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` varchar(36) COLLATE utf8_unicode_ci DEFAULT 'None',
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_BA12B115A76ED39550A89B2C` (`user_id`,`call_id`),
  KEY `IDX_BA12B115A76ED395` (`user_id`),
  KEY `IDX_BA12B11550A89B2C` (`call_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `campaign`
--

DROP TABLE IF EXISTS `campaign`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `campaign` (
  `id` varchar(24) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `status` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'Planning',
  `type` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'Email',
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `description` longtext COLLATE utf8_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `budget` double DEFAULT NULL,
  `budget_currency` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `assigned_user_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_1F1512DDB03A8386` (`created_by_id`),
  KEY `IDX_1F1512DD99049ECE` (`modified_by_id`),
  KEY `IDX_1F1512DDADF66B1A` (`assigned_user_id`),
  KEY `IDX_CAMPAIGN_CREATED_AT` (`created_at`,`deleted`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `campaign_log_record`
--

DROP TABLE IF EXISTS `campaign_log_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `campaign_log_record` (
  `id` varchar(24) COLLATE utf8_unicode_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `action` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `action_date` datetime DEFAULT NULL,
  `data` longtext COLLATE utf8_unicode_ci,
  `string_data` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `string_additional_data` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `application` varchar(36) COLLATE utf8_unicode_ci DEFAULT 'Espo',
  `created_at` datetime DEFAULT NULL,
  `is_test` tinyint(1) NOT NULL DEFAULT '0',
  `created_by_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `campaign_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `parent_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `parent_type` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `object_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `object_type` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `queue_item_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_49D9EC9BB03A8386` (`created_by_id`),
  KEY `IDX_49D9EC9BF639F774` (`campaign_id`),
  KEY `parent` (`parent_id`,`parent_type`),
  KEY `object` (`object_id`,`object_type`),
  KEY `IDX_49D9EC9BF0EDC960` (`queue_item_id`),
  KEY `IDX_CAMPAIGN_LOG_RECORD_ACTION_DATE` (`action_date`,`deleted`),
  KEY `IDX_CAMPAIGN_LOG_RECORD_ACTION` (`action`,`deleted`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `campaign_target_list`
--

DROP TABLE IF EXISTS `campaign_target_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `campaign_target_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `campaign_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `target_list_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_511AD253F639F774F6C6AFE0` (`campaign_id`,`target_list_id`),
  KEY `IDX_511AD253F639F774` (`campaign_id`),
  KEY `IDX_511AD253F6C6AFE0` (`target_list_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `campaign_target_list_excluding`
--

DROP TABLE IF EXISTS `campaign_target_list_excluding`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `campaign_target_list_excluding` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `campaign_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `target_list_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_ED6FB4A6F639F774F6C6AFE0` (`campaign_id`,`target_list_id`),
  KEY `IDX_ED6FB4A6F639F774` (`campaign_id`),
  KEY `IDX_ED6FB4A6F6C6AFE0` (`target_list_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `campaign_tracking_url`
--

DROP TABLE IF EXISTS `campaign_tracking_url`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `campaign_tracking_url` (
  `id` varchar(24) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `campaign_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_EEB66723F639F774` (`campaign_id`),
  KEY `IDX_EEB6672399049ECE` (`modified_by_id`),
  KEY `IDX_EEB66723B03A8386` (`created_by_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `case`
--

DROP TABLE IF EXISTS `case`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `case` (
  `id` varchar(24) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `number` int(11) NOT NULL AUTO_INCREMENT,
  `status` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'New',
  `priority` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'Normal',
  `type` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `description` longtext COLLATE utf8_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `account_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lead_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contact_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `inbound_email_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `assigned_user_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  UNIQUE KEY `UNIQ_7808990496901F54` (`number`),
  KEY `IDX_780899049B6B5FBA` (`account_id`),
  KEY `IDX_7808990455458D` (`lead_id`),
  KEY `IDX_78089904E7A1254A` (`contact_id`),
  KEY `IDX_78089904E540AEA2` (`inbound_email_id`),
  KEY `IDX_78089904B03A8386` (`created_by_id`),
  KEY `IDX_7808990499049ECE` (`modified_by_id`),
  KEY `IDX_78089904ADF66B1A` (`assigned_user_id`),
  KEY `IDX_CASE_STATUS` (`status`,`deleted`),
  KEY `IDX_CASE_ASSIGNED_USER` (`assigned_user_id`,`deleted`),
  KEY `IDX_CASE_ASSIGNED_USER_STATUS` (`assigned_user_id`,`status`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `case_contact`
--

DROP TABLE IF EXISTS `case_contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `case_contact` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `case_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contact_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_E3C11333CF10D4F5E7A1254A` (`case_id`,`contact_id`),
  KEY `IDX_E3C11333CF10D4F5` (`case_id`),
  KEY `IDX_E3C11333E7A1254A` (`contact_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `case_knowledge_base_article`
--

DROP TABLE IF EXISTS `case_knowledge_base_article`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `case_knowledge_base_article` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `case_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `knowledge_base_article_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_FE20B41CF10D4F59D68CDED` (`case_id`,`knowledge_base_article_id`),
  KEY `IDX_FE20B41CF10D4F5` (`case_id`),
  KEY `IDX_FE20B419D68CDED` (`knowledge_base_article_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `contact`
--

DROP TABLE IF EXISTS `contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contact` (
  `id` varchar(24) COLLATE utf8_unicode_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `salutation_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `first_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `last_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `account_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` longtext COLLATE utf8_unicode_ci,
  `do_not_call` tinyint(1) NOT NULL DEFAULT '0',
  `address_street` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address_city` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address_state` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address_country` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address_postal_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `campaign_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `assigned_user_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_4C62E6389B6B5FBA` (`account_id`),
  KEY `IDX_4C62E638F639F774` (`campaign_id`),
  KEY `IDX_4C62E638B03A8386` (`created_by_id`),
  KEY `IDX_4C62E63899049ECE` (`modified_by_id`),
  KEY `IDX_4C62E638ADF66B1A` (`assigned_user_id`),
  KEY `IDX_CONTACT_FIRST_NAME` (`first_name`,`deleted`),
  KEY `IDX_CONTACT_NAME` (`first_name`,`last_name`),
  KEY `IDX_CONTACT_ASSIGNED_USER` (`assigned_user_id`,`deleted`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `contact_document`
--

DROP TABLE IF EXISTS `contact_document`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contact_document` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `contact_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `document_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_424C16E1E7A1254AC33F7837` (`contact_id`,`document_id`),
  KEY `IDX_424C16E1E7A1254A` (`contact_id`),
  KEY `IDX_424C16E1C33F7837` (`document_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `contact_meeting`
--

DROP TABLE IF EXISTS `contact_meeting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contact_meeting` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `contact_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `meeting_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` varchar(36) COLLATE utf8_unicode_ci DEFAULT 'None',
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_6F3AC0B8E7A1254A67433D9C` (`contact_id`,`meeting_id`),
  KEY `IDX_6F3AC0B8E7A1254A` (`contact_id`),
  KEY `IDX_6F3AC0B867433D9C` (`meeting_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `contact_opportunity`
--

DROP TABLE IF EXISTS `contact_opportunity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contact_opportunity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `contact_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `opportunity_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `role` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_ED257C69E7A1254A9A34590F` (`contact_id`,`opportunity_id`),
  KEY `IDX_ED257C69E7A1254A` (`contact_id`),
  KEY `IDX_ED257C699A34590F` (`opportunity_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `contact_target_list`
--

DROP TABLE IF EXISTS `contact_target_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contact_target_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `contact_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `target_list_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `opted_out` tinyint(1) DEFAULT '0',
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_E77C5117E7A1254AF6C6AFE0` (`contact_id`,`target_list_id`),
  KEY `IDX_E77C5117E7A1254A` (`contact_id`),
  KEY `IDX_E77C5117F6C6AFE0` (`target_list_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `currency`
--

DROP TABLE IF EXISTS `currency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `currency` (
  `id` varchar(24) COLLATE utf8_unicode_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `rate` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `document`
--

DROP TABLE IF EXISTS `document`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `document` (
  `id` varchar(24) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `status` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `source` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'Espo',
  `type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `publish_date` date DEFAULT NULL,
  `expiration_date` date DEFAULT NULL,
  `description` longtext COLLATE utf8_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `created_by_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `assigned_user_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `folder_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `file_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_D8698A76B03A8386` (`created_by_id`),
  KEY `IDX_D8698A7699049ECE` (`modified_by_id`),
  KEY `IDX_D8698A76ADF66B1A` (`assigned_user_id`),
  KEY `IDX_D8698A76162CB942` (`folder_id`),
  KEY `IDX_D8698A7693CB796C` (`file_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `document_folder`
--

DROP TABLE IF EXISTS `document_folder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `document_folder` (
  `id` varchar(24) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `description` longtext COLLATE utf8_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `created_by_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `parent_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_52C0B8ABB03A8386` (`created_by_id`),
  KEY `IDX_52C0B8AB99049ECE` (`modified_by_id`),
  KEY `IDX_52C0B8AB727ACA70` (`parent_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `document_folder_path`
--

DROP TABLE IF EXISTS `document_folder_path`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `document_folder_path` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ascendor_id` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `descendor_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `IDX_90629A7011FE3B6C` (`ascendor_id`),
  KEY `IDX_90629A709A21681A` (`descendor_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `document_lead`
--

DROP TABLE IF EXISTS `document_lead`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `document_lead` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `document_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lead_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_8F25ED58C33F783755458D` (`document_id`,`lead_id`),
  KEY `IDX_8F25ED58C33F7837` (`document_id`),
  KEY `IDX_8F25ED5855458D` (`lead_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `document_opportunity`
--

DROP TABLE IF EXISTS `document_opportunity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `document_opportunity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `document_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `opportunity_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_120F4BDC33F78379A34590F` (`document_id`,`opportunity_id`),
  KEY `IDX_120F4BDC33F7837` (`document_id`),
  KEY `IDX_120F4BD9A34590F` (`opportunity_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `email`
--

DROP TABLE IF EXISTS `email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `email` (
  `id` varchar(24) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `from_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `from_string` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `reply_to_string` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_replied` tinyint(1) NOT NULL DEFAULT '0',
  `message_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `message_id_internal` varchar(300) COLLATE utf8_unicode_ci DEFAULT NULL,
  `body_plain` longtext COLLATE utf8_unicode_ci,
  `body` longtext COLLATE utf8_unicode_ci,
  `is_html` tinyint(1) NOT NULL DEFAULT '1',
  `status` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'Archived',
  `has_attachment` tinyint(1) NOT NULL DEFAULT '0',
  `date_sent` datetime DEFAULT NULL,
  `delivery_date` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `is_system` tinyint(1) NOT NULL DEFAULT '0',
  `from_email_address_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `parent_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `parent_type` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sent_by_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `assigned_user_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `replied_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `account_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_E7927C74D445573A` (`from_email_address_id`),
  KEY `parent` (`parent_id`,`parent_type`),
  KEY `IDX_E7927C74B03A8386` (`created_by_id`),
  KEY `IDX_E7927C74A45BB98C` (`sent_by_id`),
  KEY `IDX_E7927C7499049ECE` (`modified_by_id`),
  KEY `IDX_E7927C74ADF66B1A` (`assigned_user_id`),
  KEY `IDX_E7927C74B4E994E0` (`replied_id`),
  KEY `IDX_E7927C749B6B5FBA` (`account_id`),
  KEY `IDX_EMAIL_DATE_SENT_ASSIGNED_USER` (`date_sent`,`assigned_user_id`),
  KEY `IDX_EMAIL_DATE_SENT` (`date_sent`,`deleted`),
  KEY `IDX_EMAIL_DATE_SENT_STATUS` (`date_sent`,`status`,`deleted`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `email_account`
--

DROP TABLE IF EXISTS `email_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `email_account` (
  `id` varchar(24) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `email_address` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `host` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `port` varchar(255) COLLATE utf8_unicode_ci DEFAULT '143',
  `ssl` tinyint(1) NOT NULL DEFAULT '0',
  `username` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `monitored_folders` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'INBOX',
  `sent_folder` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `store_sent_emails` tinyint(1) NOT NULL DEFAULT '0',
  `keep_fetched_emails_unread` tinyint(1) NOT NULL DEFAULT '0',
  `fetch_since` date DEFAULT NULL,
  `fetch_data` longtext COLLATE utf8_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `use_smtp` tinyint(1) NOT NULL DEFAULT '0',
  `smtp_host` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `smtp_port` int(11) DEFAULT '25',
  `smtp_auth` tinyint(1) NOT NULL DEFAULT '0',
  `smtp_security` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `smtp_username` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `smtp_password` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email_folder_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `assigned_user_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_C0F63E6B19272669` (`email_folder_id`),
  KEY `IDX_C0F63E6BADF66B1A` (`assigned_user_id`),
  KEY `IDX_C0F63E6BB03A8386` (`created_by_id`),
  KEY `IDX_C0F63E6B99049ECE` (`modified_by_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `email_address`
--

DROP TABLE IF EXISTS `email_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `email_address` (
  `id` varchar(24) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `lower` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `invalid` tinyint(1) NOT NULL DEFAULT '0',
  `opt_out` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `IDX_B08E074EE9A7B23` (`lower`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `email_email_account`
--

DROP TABLE IF EXISTS `email_email_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `email_email_account` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email_account_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_32C12DC3A832C1C937D8AD65` (`email_id`,`email_account_id`),
  KEY `IDX_32C12DC3A832C1C9` (`email_id`),
  KEY `IDX_32C12DC337D8AD65` (`email_account_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `email_email_address`
--

DROP TABLE IF EXISTS `email_email_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `email_email_address` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email_address_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address_type` varchar(4) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_42B914E6A832C1C959045DAAF19287C2` (`email_id`,`email_address_id`,`address_type`),
  KEY `IDX_42B914E6A832C1C9` (`email_id`),
  KEY `IDX_42B914E659045DAA` (`email_address_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `email_filter`
--

DROP TABLE IF EXISTS `email_filter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `email_filter` (
  `id` varchar(24) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `from` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `to` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `subject` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `body_contains` longtext COLLATE utf8_unicode_ci,
  `is_global` tinyint(1) NOT NULL DEFAULT '0',
  `action` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'Skip',
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `parent_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `parent_type` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email_folder_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `parent` (`parent_id`,`parent_type`),
  KEY `IDX_25E8CED19272669` (`email_folder_id`),
  KEY `IDX_25E8CEDB03A8386` (`created_by_id`),
  KEY `IDX_25E8CED99049ECE` (`modified_by_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `email_folder`
--

DROP TABLE IF EXISTS `email_folder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `email_folder` (
  `id` varchar(24) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `order` int(11) DEFAULT NULL,
  `skip_notifications` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `assigned_user_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_9138DA3DADF66B1A` (`assigned_user_id`),
  KEY `IDX_9138DA3DB03A8386` (`created_by_id`),
  KEY `IDX_9138DA3D99049ECE` (`modified_by_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `email_inbound_email`
--

DROP TABLE IF EXISTS `email_inbound_email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `email_inbound_email` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `inbound_email_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_41D62720A832C1C9E540AEA2` (`email_id`,`inbound_email_id`),
  KEY `IDX_41D62720A832C1C9` (`email_id`),
  KEY `IDX_41D62720E540AEA2` (`inbound_email_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `email_queue_item`
--

DROP TABLE IF EXISTS `email_queue_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `email_queue_item` (
  `id` varchar(24) COLLATE utf8_unicode_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `status` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `attempt_count` int(11) DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `sent_at` datetime DEFAULT NULL,
  `email_address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_test` tinyint(1) NOT NULL DEFAULT '0',
  `mass_email_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `target_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `target_type` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_16F89F37EF1946AB` (`mass_email_id`),
  KEY `target` (`target_id`,`target_type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `email_template`
--

DROP TABLE IF EXISTS `email_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `email_template` (
  `id` varchar(24) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `subject` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `body` longtext COLLATE utf8_unicode_ci,
  `is_html` tinyint(1) NOT NULL DEFAULT '1',
  `one_off` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `assigned_user_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_9C0600CAADF66B1A` (`assigned_user_id`),
  KEY `IDX_9C0600CAB03A8386` (`created_by_id`),
  KEY `IDX_9C0600CA99049ECE` (`modified_by_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `email_user`
--

DROP TABLE IF EXISTS `email_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `email_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_read` tinyint(1) DEFAULT '0',
  `is_important` tinyint(1) DEFAULT '0',
  `in_trash` tinyint(1) DEFAULT '0',
  `folder_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_12A5F6CCA832C1C9A76ED395` (`email_id`,`user_id`),
  KEY `IDX_12A5F6CCA832C1C9` (`email_id`),
  KEY `IDX_12A5F6CCA76ED395` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `entity_email_address`
--

DROP TABLE IF EXISTS `entity_email_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entity_email_address` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entity_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email_address_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `entity_type` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `primary` tinyint(1) DEFAULT '0',
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_9125AB4281257D5D59045DAAC412EE02` (`entity_id`,`email_address_id`,`entity_type`),
  KEY `IDX_9125AB4281257D5D` (`entity_id`),
  KEY `IDX_9125AB4259045DAA` (`email_address_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `entity_phone_number`
--

DROP TABLE IF EXISTS `entity_phone_number`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entity_phone_number` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entity_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone_number_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `entity_type` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `primary` tinyint(1) DEFAULT '0',
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_7459056F81257D5D39DFD528C412EE02` (`entity_id`,`phone_number_id`,`entity_type`),
  KEY `IDX_7459056F81257D5D` (`entity_id`),
  KEY `IDX_7459056F39DFD528` (`phone_number_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `entity_team`
--

DROP TABLE IF EXISTS `entity_team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entity_team` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entity_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `team_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `entity_type` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_8C2C1F3481257D5D296CD8AEC412EE02` (`entity_id`,`team_id`,`entity_type`),
  KEY `IDX_8C2C1F3481257D5D` (`entity_id`),
  KEY `IDX_8C2C1F34296CD8AE` (`team_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `entity_user`
--

DROP TABLE IF EXISTS `entity_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entity_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entity_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `entity_type` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_C55F6F6281257D5DA76ED395C412EE02` (`entity_id`,`user_id`,`entity_type`),
  KEY `IDX_C55F6F6281257D5D` (`entity_id`),
  KEY `IDX_C55F6F62A76ED395` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `extension`
--

DROP TABLE IF EXISTS `extension`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `extension` (
  `id` varchar(24) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `version` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `file_list` longtext COLLATE utf8_unicode_ci,
  `description` longtext COLLATE utf8_unicode_ci,
  `is_installed` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `created_by_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_9FB73D77B03A8386` (`created_by_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `external_account`
--

DROP TABLE IF EXISTS `external_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `external_account` (
  `id` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `data` longtext COLLATE utf8_unicode_ci,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `import`
--

DROP TABLE IF EXISTS `import`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `import` (
  `id` varchar(24) COLLATE utf8_unicode_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `entity_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `file_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_9D4ECE1DB03A8386` (`created_by_id`),
  KEY `IDX_9D4ECE1D93CB796C` (`file_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `import_entity`
--

DROP TABLE IF EXISTS `import_entity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `import_entity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entity_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `entity_type` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `import_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_imported` tinyint(1) DEFAULT '0',
  `is_updated` tinyint(1) DEFAULT '0',
  `is_duplicate` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `entity` (`entity_id`,`entity_type`),
  KEY `IDX_7219FE70B6A263D9` (`import_id`),
  KEY `IDX_IMPORT_ENTITY_ENTITY_IMPORT` (`import_id`,`entity_type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `inbound_email`
--

DROP TABLE IF EXISTS `inbound_email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inbound_email` (
  `id` varchar(24) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `email_address` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `host` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `port` varchar(255) COLLATE utf8_unicode_ci DEFAULT '143',
  `ssl` tinyint(1) NOT NULL DEFAULT '0',
  `username` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `monitored_folders` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'INBOX',
  `fetch_since` date DEFAULT NULL,
  `fetch_data` longtext COLLATE utf8_unicode_ci,
  `add_all_team_users` tinyint(1) NOT NULL DEFAULT '0',
  `create_case` tinyint(1) NOT NULL DEFAULT '0',
  `case_distribution` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'Direct-Assignment',
  `target_user_position` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `reply` tinyint(1) NOT NULL DEFAULT '0',
  `reply_from_address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `reply_to_address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `reply_from_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `assign_to_user_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `team_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `reply_email_template_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_B3E134886D716643` (`assign_to_user_id`),
  KEY `IDX_B3E13488296CD8AE` (`team_id`),
  KEY `IDX_B3E134885AE5A3F7` (`reply_email_template_id`),
  KEY `IDX_B3E13488B03A8386` (`created_by_id`),
  KEY `IDX_B3E1348899049ECE` (`modified_by_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `integration`
--

DROP TABLE IF EXISTS `integration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `integration` (
  `id` varchar(24) COLLATE utf8_unicode_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `data` longtext COLLATE utf8_unicode_ci,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `job`
--

DROP TABLE IF EXISTS `job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `job` (
  `id` varchar(24) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `status` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'Pending',
  `execute_time` datetime DEFAULT NULL,
  `service_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `method` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `data` longtext COLLATE utf8_unicode_ci,
  `attempts` int(11) DEFAULT NULL,
  `target_id` varchar(48) COLLATE utf8_unicode_ci DEFAULT NULL,
  `target_type` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `failed_attempts` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `scheduled_job_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_FBD8E0F8A71ECAB0` (`scheduled_job_id`),
  KEY `IDX_JOB_EXECUTE_TIME` (`status`,`execute_time`),
  KEY `IDX_JOB_STATUS` (`status`,`deleted`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `knowledge_base_article`
--

DROP TABLE IF EXISTS `knowledge_base_article`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `knowledge_base_article` (
  `id` varchar(24) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `status` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'Draft',
  `language` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `publish_date` date DEFAULT NULL,
  `expiration_date` date DEFAULT NULL,
  `order` int(11) DEFAULT NULL,
  `description` longtext COLLATE utf8_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `body` longtext COLLATE utf8_unicode_ci,
  `created_by_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `assigned_user_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_9815B630B03A8386` (`created_by_id`),
  KEY `IDX_9815B63099049ECE` (`modified_by_id`),
  KEY `IDX_9815B630ADF66B1A` (`assigned_user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `knowledge_base_article_knowledge_base_category`
--

DROP TABLE IF EXISTS `knowledge_base_article_knowledge_base_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `knowledge_base_article_knowledge_base_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `knowledge_base_article_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `knowledge_base_category_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_35B2D2AC9D68CDED35AB2003` (`knowledge_base_article_id`,`knowledge_base_category_id`),
  KEY `IDX_35B2D2AC9D68CDED` (`knowledge_base_article_id`),
  KEY `IDX_35B2D2AC35AB2003` (`knowledge_base_category_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `knowledge_base_article_portal`
--

DROP TABLE IF EXISTS `knowledge_base_article_portal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `knowledge_base_article_portal` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `portal_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `knowledge_base_article_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_4699F0F0B887E1DD9D68CDED` (`portal_id`,`knowledge_base_article_id`),
  KEY `IDX_4699F0F0B887E1DD` (`portal_id`),
  KEY `IDX_4699F0F09D68CDED` (`knowledge_base_article_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `knowledge_base_category`
--

DROP TABLE IF EXISTS `knowledge_base_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `knowledge_base_category` (
  `id` varchar(24) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `description` longtext COLLATE utf8_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `order` int(11) DEFAULT NULL,
  `created_by_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `parent_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_84DEC2B8B03A8386` (`created_by_id`),
  KEY `IDX_84DEC2B899049ECE` (`modified_by_id`),
  KEY `IDX_84DEC2B8727ACA70` (`parent_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `knowledge_base_category_path`
--

DROP TABLE IF EXISTS `knowledge_base_category_path`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `knowledge_base_category_path` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ascendor_id` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `descendor_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `IDX_727ADB3911FE3B6C` (`ascendor_id`),
  KEY `IDX_727ADB399A21681A` (`descendor_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lead`
--

DROP TABLE IF EXISTS `lead`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lead` (
  `id` varchar(24) COLLATE utf8_unicode_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `salutation_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `first_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `last_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `title` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'New',
  `source` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `industry` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `opportunity_amount` double DEFAULT NULL,
  `website` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address_street` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address_city` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address_state` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address_country` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address_postal_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `do_not_call` tinyint(1) NOT NULL DEFAULT '0',
  `description` longtext COLLATE utf8_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `account_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `opportunity_amount_currency` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `assigned_user_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `campaign_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_account_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_contact_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_opportunity_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_289161CBB03A8386` (`created_by_id`),
  KEY `IDX_289161CB99049ECE` (`modified_by_id`),
  KEY `IDX_289161CBADF66B1A` (`assigned_user_id`),
  KEY `IDX_289161CBF639F774` (`campaign_id`),
  KEY `IDX_289161CB3AEF561B` (`created_account_id`),
  KEY `IDX_289161CB46252CEB` (`created_contact_id`),
  KEY `IDX_289161CB9E0CD2D1` (`created_opportunity_id`),
  KEY `IDX_LEAD_FIRST_NAME` (`first_name`,`deleted`),
  KEY `IDX_LEAD_NAME` (`first_name`,`last_name`),
  KEY `IDX_LEAD_STATUS` (`status`,`deleted`),
  KEY `IDX_LEAD_CREATED_AT` (`created_at`,`deleted`),
  KEY `IDX_LEAD_CREATED_AT_STATUS` (`created_at`,`status`),
  KEY `IDX_LEAD_ASSIGNED_USER` (`assigned_user_id`,`deleted`),
  KEY `IDX_LEAD_ASSIGNED_USER_STATUS` (`assigned_user_id`,`status`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lead_meeting`
--

DROP TABLE IF EXISTS `lead_meeting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lead_meeting` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lead_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `meeting_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` varchar(36) COLLATE utf8_unicode_ci DEFAULT 'None',
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_ACDBBD5755458D67433D9C` (`lead_id`,`meeting_id`),
  KEY `IDX_ACDBBD5755458D` (`lead_id`),
  KEY `IDX_ACDBBD5767433D9C` (`meeting_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lead_target_list`
--

DROP TABLE IF EXISTS `lead_target_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lead_target_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lead_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `target_list_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `opted_out` tinyint(1) DEFAULT '0',
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_7041AADD55458DF6C6AFE0` (`lead_id`,`target_list_id`),
  KEY `IDX_7041AADD55458D` (`lead_id`),
  KEY `IDX_7041AADDF6C6AFE0` (`target_list_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mass_email`
--

DROP TABLE IF EXISTS `mass_email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mass_email` (
  `id` varchar(24) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `status` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'Pending',
  `store_sent_emails` tinyint(1) NOT NULL DEFAULT '0',
  `opt_out_entirely` tinyint(1) NOT NULL DEFAULT '0',
  `from_address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `from_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `reply_to_address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `reply_to_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `start_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `email_template_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `campaign_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `inbound_email_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_AFBC1FDF131A730F` (`email_template_id`),
  KEY `IDX_AFBC1FDFF639F774` (`campaign_id`),
  KEY `IDX_AFBC1FDFE540AEA2` (`inbound_email_id`),
  KEY `IDX_AFBC1FDFB03A8386` (`created_by_id`),
  KEY `IDX_AFBC1FDF99049ECE` (`modified_by_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mass_email_target_list`
--

DROP TABLE IF EXISTS `mass_email_target_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mass_email_target_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mass_email_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `target_list_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_6B9CE04DEF1946ABF6C6AFE0` (`mass_email_id`,`target_list_id`),
  KEY `IDX_6B9CE04DEF1946AB` (`mass_email_id`),
  KEY `IDX_6B9CE04DF6C6AFE0` (`target_list_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mass_email_target_list_excluding`
--

DROP TABLE IF EXISTS `mass_email_target_list_excluding`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mass_email_target_list_excluding` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mass_email_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `target_list_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_4D889BE8EF1946ABF6C6AFE0` (`mass_email_id`,`target_list_id`),
  KEY `IDX_4D889BE8EF1946AB` (`mass_email_id`),
  KEY `IDX_4D889BE8F6C6AFE0` (`target_list_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `meeting`
--

DROP TABLE IF EXISTS `meeting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `meeting` (
  `id` varchar(24) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `status` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'Planned',
  `date_start` datetime DEFAULT NULL,
  `date_end` datetime DEFAULT NULL,
  `description` longtext COLLATE utf8_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `parent_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `parent_type` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `account_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `assigned_user_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `parent` (`parent_id`,`parent_type`),
  KEY `IDX_F515E1399B6B5FBA` (`account_id`),
  KEY `IDX_F515E139B03A8386` (`created_by_id`),
  KEY `IDX_F515E13999049ECE` (`modified_by_id`),
  KEY `IDX_F515E139ADF66B1A` (`assigned_user_id`),
  KEY `IDX_MEETING_DATE_START_STATUS` (`date_start`,`status`),
  KEY `IDX_MEETING_DATE_START` (`date_start`,`deleted`),
  KEY `IDX_MEETING_STATUS` (`status`,`deleted`),
  KEY `IDX_MEETING_ASSIGNED_USER` (`assigned_user_id`,`deleted`),
  KEY `IDX_MEETING_ASSIGNED_USER_STATUS` (`assigned_user_id`,`status`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `meeting_user`
--

DROP TABLE IF EXISTS `meeting_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `meeting_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `meeting_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` varchar(36) COLLATE utf8_unicode_ci DEFAULT 'None',
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_61622E9BA76ED39567433D9C` (`user_id`,`meeting_id`),
  KEY `IDX_61622E9BA76ED395` (`user_id`),
  KEY `IDX_61622E9B67433D9C` (`meeting_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `next_number`
--

DROP TABLE IF EXISTS `next_number`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `next_number` (
  `id` varchar(24) COLLATE utf8_unicode_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `entity_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `value` int(11) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `IDX_CF451AE8C412EE02` (`entity_type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `note`
--

DROP TABLE IF EXISTS `note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `note` (
  `id` varchar(24) COLLATE utf8_unicode_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `post` longtext COLLATE utf8_unicode_ci,
  `data` longtext COLLATE utf8_unicode_ci,
  `type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `target_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `number` int(11) NOT NULL AUTO_INCREMENT,
  `is_global` tinyint(1) NOT NULL DEFAULT '0',
  `is_internal` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `parent_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `parent_type` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `related_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `related_type` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `super_parent_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `super_parent_type` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  UNIQUE KEY `UNIQ_CFBDFA1496901F54` (`number`),
  KEY `parent` (`parent_id`,`parent_type`),
  KEY `related` (`related_id`,`related_type`),
  KEY `IDX_CFBDFA14B03A8386` (`created_by_id`),
  KEY `IDX_CFBDFA1499049ECE` (`modified_by_id`),
  KEY `superParent` (`super_parent_id`,`super_parent_type`),
  KEY `IDX_NOTE_CREATED_AT` (`created_at`),
  KEY `IDX_NOTE_PARENT_AND_SUPER_PARENT` (`parent_id`,`parent_type`,`super_parent_id`,`super_parent_type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `note_portal`
--

DROP TABLE IF EXISTS `note_portal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `note_portal` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `note_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `portal_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_137CC42426ED0855B887E1DD` (`note_id`,`portal_id`),
  KEY `IDX_137CC42426ED0855` (`note_id`),
  KEY `IDX_137CC424B887E1DD` (`portal_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `note_team`
--

DROP TABLE IF EXISTS `note_team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `note_team` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `note_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `team_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_649AB74726ED0855296CD8AE` (`note_id`,`team_id`),
  KEY `IDX_649AB74726ED0855` (`note_id`),
  KEY `IDX_649AB747296CD8AE` (`team_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `note_user`
--

DROP TABLE IF EXISTS `note_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `note_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `note_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_2DE9C71126ED0855A76ED395` (`note_id`,`user_id`),
  KEY `IDX_2DE9C71126ED0855` (`note_id`),
  KEY `IDX_2DE9C711A76ED395` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `notification`
--

DROP TABLE IF EXISTS `notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notification` (
  `id` varchar(24) COLLATE utf8_unicode_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `number` int(11) NOT NULL AUTO_INCREMENT,
  `data` longtext COLLATE utf8_unicode_ci,
  `type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `read` tinyint(1) NOT NULL DEFAULT '0',
  `email_is_processed` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `message` longtext COLLATE utf8_unicode_ci,
  `user_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `related_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `related_type` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `related_parent_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `related_parent_type` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  UNIQUE KEY `UNIQ_BF5476CA96901F54` (`number`),
  KEY `IDX_BF5476CAA76ED395` (`user_id`),
  KEY `related` (`related_id`,`related_type`),
  KEY `relatedParent` (`related_parent_id`,`related_parent_type`),
  KEY `IDX_NOTIFICATION_CREATED_AT` (`created_at`),
  KEY `IDX_NOTIFICATION_USER` (`user_id`,`created_at`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `opportunity`
--

DROP TABLE IF EXISTS `opportunity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opportunity` (
  `id` varchar(24) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `amount` double DEFAULT NULL,
  `stage` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'Prospecting',
  `probability` int(11) DEFAULT NULL,
  `lead_source` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `close_date` date DEFAULT NULL,
  `description` longtext COLLATE utf8_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `amount_currency` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `account_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `campaign_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `assigned_user_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_8389C3D79B6B5FBA` (`account_id`),
  KEY `IDX_8389C3D7F639F774` (`campaign_id`),
  KEY `IDX_8389C3D7B03A8386` (`created_by_id`),
  KEY `IDX_8389C3D799049ECE` (`modified_by_id`),
  KEY `IDX_8389C3D7ADF66B1A` (`assigned_user_id`),
  KEY `IDX_OPPORTUNITY_STAGE` (`stage`,`deleted`),
  KEY `IDX_OPPORTUNITY_ASSIGNED_USER` (`assigned_user_id`,`deleted`),
  KEY `IDX_OPPORTUNITY_CREATED_AT` (`created_at`,`deleted`),
  KEY `IDX_OPPORTUNITY_CREATED_AT_STAGE` (`created_at`,`stage`),
  KEY `IDX_OPPORTUNITY_ASSIGNED_USER_STAGE` (`assigned_user_id`,`stage`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `password_change_request`
--

DROP TABLE IF EXISTS `password_change_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `password_change_request` (
  `id` varchar(24) COLLATE utf8_unicode_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `request_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `user_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_AC3A261F427EB8A5` (`request_id`),
  KEY `IDX_AC3A261FA76ED395` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `phone_number`
--

DROP TABLE IF EXISTS `phone_number`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phone_number` (
  `id` varchar(24) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(36) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_6B01BC5B5E237E06` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `portal`
--

DROP TABLE IF EXISTS `portal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `portal` (
  `id` varchar(24) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `custom_id` varchar(36) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `tab_list` longtext COLLATE utf8_unicode_ci,
  `quick_create_list` longtext COLLATE utf8_unicode_ci,
  `theme` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `language` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `time_zone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_format` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `time_format` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `week_start` int(11) DEFAULT '-1',
  `default_currency` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `dashboard_layout` longtext COLLATE utf8_unicode_ci,
  `dashlets_options` longtext COLLATE utf8_unicode_ci,
  `custom_url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `modified_by_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `logo_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `company_logo_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_BAE93F0614A603A` (`custom_id`),
  KEY `IDX_BAE93F099049ECE` (`modified_by_id`),
  KEY `IDX_BAE93F0B03A8386` (`created_by_id`),
  KEY `IDX_BAE93F0F98F144A` (`logo_id`),
  KEY `IDX_BAE93F0D9DD0E9D` (`company_logo_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `portal_portal_role`
--

DROP TABLE IF EXISTS `portal_portal_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `portal_portal_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `portal_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `portal_role_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_B29E22C7B887E1DDD7C6FAB5` (`portal_id`,`portal_role_id`),
  KEY `IDX_B29E22C7B887E1DD` (`portal_id`),
  KEY `IDX_B29E22C7D7C6FAB5` (`portal_role_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `portal_role`
--

DROP TABLE IF EXISTS `portal_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `portal_role` (
  `id` varchar(24) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `data` longtext COLLATE utf8_unicode_ci,
  `field_data` longtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `portal_role_user`
--

DROP TABLE IF EXISTS `portal_role_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `portal_role_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `portal_role_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_202456E6D7C6FAB5A76ED395` (`portal_role_id`,`user_id`),
  KEY `IDX_202456E6D7C6FAB5` (`portal_role_id`),
  KEY `IDX_202456E6A76ED395` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `portal_user`
--

DROP TABLE IF EXISTS `portal_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `portal_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `portal_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_76511E4B887E1DDA76ED395` (`portal_id`,`user_id`),
  KEY `IDX_76511E4B887E1DD` (`portal_id`),
  KEY `IDX_76511E4A76ED395` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `preferences`
--

DROP TABLE IF EXISTS `preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `preferences` (
  `id` varchar(24) COLLATE utf8_unicode_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `time_zone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_format` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `time_format` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `week_start` int(11) DEFAULT '-1',
  `default_currency` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `thousand_separator` varchar(1) COLLATE utf8_unicode_ci DEFAULT ',',
  `decimal_mark` varchar(1) COLLATE utf8_unicode_ci DEFAULT '.',
  `dashboard_layout` longtext COLLATE utf8_unicode_ci,
  `dashlets_options` longtext COLLATE utf8_unicode_ci,
  `shared_calendar_user_list` longtext COLLATE utf8_unicode_ci,
  `preset_filters` longtext COLLATE utf8_unicode_ci,
  `smtp_server` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `smtp_port` int(11) DEFAULT '25',
  `smtp_auth` tinyint(1) NOT NULL DEFAULT '0',
  `smtp_security` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `smtp_username` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `smtp_password` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `language` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `export_delimiter` varchar(1) COLLATE utf8_unicode_ci DEFAULT ',',
  `receive_assignment_email_notifications` tinyint(1) NOT NULL DEFAULT '1',
  `receive_mention_email_notifications` tinyint(1) NOT NULL DEFAULT '1',
  `receive_stream_email_notifications` tinyint(1) NOT NULL DEFAULT '1',
  `signature` longtext COLLATE utf8_unicode_ci,
  `default_reminders` longtext COLLATE utf8_unicode_ci,
  `theme` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `use_custom_tab_list` tinyint(1) NOT NULL DEFAULT '0',
  `tab_list` longtext COLLATE utf8_unicode_ci,
  `email_reply_to_all_by_default` tinyint(1) NOT NULL DEFAULT '1',
  `email_reply_force_html` tinyint(1) NOT NULL DEFAULT '0',
  `do_not_fill_assigned_user_if_not_required` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reminder`
--

DROP TABLE IF EXISTS `reminder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reminder` (
  `id` varchar(24) COLLATE utf8_unicode_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `remind_at` datetime DEFAULT NULL,
  `start_at` datetime DEFAULT NULL,
  `type` varchar(36) COLLATE utf8_unicode_ci DEFAULT 'Popup',
  `seconds` int(11) DEFAULT '0',
  `entity_type` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `entity_id` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_id` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_40374F40BBE50DA3` (`remind_at`),
  KEY `IDX_40374F40B75363F7` (`start_at`),
  KEY `IDX_40374F408CDE5729` (`type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role` (
  `id` varchar(24) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `assignment_permission` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'not-set',
  `user_permission` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'not-set',
  `portal_permission` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'not-set',
  `data` longtext COLLATE utf8_unicode_ci,
  `field_data` longtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `role_team`
--

DROP TABLE IF EXISTS `role_team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role_team` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `team_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_7A5FD48BD60322AC296CD8AE` (`role_id`,`team_id`),
  KEY `IDX_7A5FD48BD60322AC` (`role_id`),
  KEY `IDX_7A5FD48B296CD8AE` (`team_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `role_user`
--

DROP TABLE IF EXISTS `role_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_332CA4DDD60322ACA76ED395` (`role_id`,`user_id`),
  KEY `IDX_332CA4DDD60322AC` (`role_id`),
  KEY `IDX_332CA4DDA76ED395` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `scheduled_job`
--

DROP TABLE IF EXISTS `scheduled_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scheduled_job` (
  `id` varchar(24) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `job` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `scheduling` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_run` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `created_by_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_800A50CEB03A8386` (`created_by_id`),
  KEY `IDX_800A50CE99049ECE` (`modified_by_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `scheduled_job_log_record`
--

DROP TABLE IF EXISTS `scheduled_job_log_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scheduled_job_log_record` (
  `id` varchar(24) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `status` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `execution_time` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `scheduled_job_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `target_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `target_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_615BB231A71ECAB0` (`scheduled_job_id`),
  KEY `target` (`target_id`,`target_type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `subscription`
--

DROP TABLE IF EXISTS `subscription`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subscription` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entity_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `entity_type` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `entity` (`entity_id`,`entity_type`),
  KEY `IDX_A3C664D3A76ED395` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `target`
--

DROP TABLE IF EXISTS `target`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `target` (
  `id` varchar(24) COLLATE utf8_unicode_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `salutation_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `first_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `last_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `title` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `account_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `website` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address_street` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address_city` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address_state` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address_country` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address_postal_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `do_not_call` tinyint(1) NOT NULL DEFAULT '0',
  `description` longtext COLLATE utf8_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `created_by_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `assigned_user_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_466F2FFCB03A8386` (`created_by_id`),
  KEY `IDX_466F2FFC99049ECE` (`modified_by_id`),
  KEY `IDX_466F2FFCADF66B1A` (`assigned_user_id`),
  KEY `IDX_TARGET_FIRST_NAME` (`first_name`,`deleted`),
  KEY `IDX_TARGET_NAME` (`first_name`,`last_name`),
  KEY `IDX_TARGET_ASSIGNED_USER` (`assigned_user_id`,`deleted`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `target_list`
--

DROP TABLE IF EXISTS `target_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `target_list` (
  `id` varchar(24) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `description` longtext COLLATE utf8_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `created_by_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `assigned_user_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `campaigns_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_89D0EEA9B03A8386` (`created_by_id`),
  KEY `IDX_89D0EEA999049ECE` (`modified_by_id`),
  KEY `IDX_89D0EEA9ADF66B1A` (`assigned_user_id`),
  KEY `campaigns` (`campaigns_id`),
  KEY `IDX_TARGET_LIST_CREATED_AT` (`created_at`,`deleted`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `target_list_user`
--

DROP TABLE IF EXISTS `target_list_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `target_list_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `target_list_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `opted_out` tinyint(1) DEFAULT '0',
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_FCE97B8CA76ED395F6C6AFE0` (`user_id`,`target_list_id`),
  KEY `IDX_FCE97B8CA76ED395` (`user_id`),
  KEY `IDX_FCE97B8CF6C6AFE0` (`target_list_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `task`
--

DROP TABLE IF EXISTS `task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task` (
  `id` varchar(24) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `status` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'Not Started',
  `priority` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'Normal',
  `date_start` datetime DEFAULT NULL,
  `date_end` datetime DEFAULT NULL,
  `date_start_date` date DEFAULT NULL,
  `date_end_date` date DEFAULT NULL,
  `date_completed` datetime DEFAULT NULL,
  `description` longtext COLLATE utf8_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `parent_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `parent_type` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `account_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `assigned_user_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `parent` (`parent_id`,`parent_type`),
  KEY `IDX_527EDB259B6B5FBA` (`account_id`),
  KEY `IDX_527EDB25B03A8386` (`created_by_id`),
  KEY `IDX_527EDB2599049ECE` (`modified_by_id`),
  KEY `IDX_527EDB25ADF66B1A` (`assigned_user_id`),
  KEY `IDX_TASK_DATE_START_STATUS` (`date_start`,`status`),
  KEY `IDX_TASK_DATE_END_STATUS` (`date_end`,`status`),
  KEY `IDX_TASK_DATE_START` (`date_start`,`deleted`),
  KEY `IDX_TASK_STATUS` (`status`,`deleted`),
  KEY `IDX_TASK_ASSIGNED_USER` (`assigned_user_id`,`deleted`),
  KEY `IDX_TASK_ASSIGNED_USER_STATUS` (`assigned_user_id`,`status`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `team`
--

DROP TABLE IF EXISTS `team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `team` (
  `id` varchar(24) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `position_list` longtext COLLATE utf8_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `team_user`
--

DROP TABLE IF EXISTS `team_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `team_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `team_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `role` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_5C722232296CD8AEA76ED395` (`team_id`,`user_id`),
  KEY `IDX_5C722232296CD8AE` (`team_id`),
  KEY `IDX_5C722232A76ED395` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `template`
--

DROP TABLE IF EXISTS `template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `template` (
  `id` varchar(24) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `body` longtext COLLATE utf8_unicode_ci,
  `header` longtext COLLATE utf8_unicode_ci,
  `footer` longtext COLLATE utf8_unicode_ci,
  `entity_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `left_margin` double DEFAULT '10',
  `right_margin` double DEFAULT '10',
  `top_margin` double DEFAULT '10',
  `bottom_margin` double DEFAULT '25',
  `print_footer` tinyint(1) NOT NULL DEFAULT '0',
  `footer_position` double DEFAULT '15',
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `created_by_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_97601F83B03A8386` (`created_by_id`),
  KEY `IDX_97601F8399049ECE` (`modified_by_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `unique_id`
--

DROP TABLE IF EXISTS `unique_id`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unique_id` (
  `id` varchar(24) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `data` longtext COLLATE utf8_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `created_by_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_E3C683435E237E06` (`name`),
  KEY `IDX_E3C68343B03A8386` (`created_by_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` varchar(24) COLLATE utf8_unicode_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `is_admin` tinyint(1) NOT NULL DEFAULT '0',
  `user_name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `password` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `salutation_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `first_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `last_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `is_portal_user` tinyint(1) NOT NULL DEFAULT '0',
  `is_super_admin` tinyint(1) NOT NULL DEFAULT '0',
  `title` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `gender` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `created_at` datetime DEFAULT NULL,
  `default_team_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contact_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `avatar_id` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_8D93D649DBE989EB` (`default_team_id`),
  KEY `IDX_8D93D649E7A1254A` (`contact_id`),
  KEY `IDX_8D93D64986383B10` (`avatar_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
