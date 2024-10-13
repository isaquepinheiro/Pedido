--
-- Current Database: `database`
--



USE `database`;

-- MySQL dump 10.13  Distrib 5.7.30, for Win32 (AMD64)
--
-- Host: 127.0.0.1    Database: database
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.13-MariaDB

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
-- Table structure for table `clientes`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clientes` (
  `cli_codigo` bigint(20) NOT NULL AUTO_INCREMENT,
  `cli_nome` varchar(100) NOT NULL,
  `cli_cidade` varchar(100) NOT NULL,
  `cli_uf` varchar(2) NOT NULL,
  UNIQUE KEY `codigo` (`cli_codigo`) USING BTREE,
  KEY `clientes_nome` (`cli_nome`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pedidos`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pedidos` (
  `pd_id` bigint(20) NOT NULL DEFAULT 0,
  `pd_data_emissao` datetime NOT NULL,
  `pd_Itens_total` decimal(12,2) NOT NULL DEFAULT 0.00,
  `cli_codigo` bigint(20) NOT NULL,
  PRIMARY KEY (`pd_id`) USING BTREE,
  KEY `pedidos_data_emissao` (`pd_data_emissao`) USING BTREE,
  KEY `pedidos_cli_codigo` (`cli_codigo`) USING BTREE,
  CONSTRAINT `pedidos_cli_codigo` FOREIGN KEY (`cli_codigo`) REFERENCES `clientes` (`cli_codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pedidos_itens`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pedidos_itens` (
  `item_id` bigint(20) NOT NULL,
  `pd_id` bigint(20) NOT NULL DEFAULT 0,
  `pro_codigo` bigint(20) NOT NULL,
  `item_quantidade` decimal(10,2) NOT NULL DEFAULT 0.00,
  `item_preco_venda` decimal(10,2) NOT NULL DEFAULT 0.00,
  `item_total` decimal(10,2) NOT NULL DEFAULT 0.00,
  UNIQUE KEY `tmp_ems_index_130` (`pd_id`,`item_id`) USING BTREE,
  KEY `pedidos_itens_pd_id` (`pd_id`) USING BTREE,
  KEY `pedidos_itens_pro_codigo` (`pro_codigo`),
  CONSTRAINT `pedidos_itens_pd_id` FOREIGN KEY (`pd_id`) REFERENCES `pedidos` (`pd_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pedidos_itens_pro_codigo` FOREIGN KEY (`pro_codigo`) REFERENCES `produtos` (`pro_codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `produtos`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `produtos` (
  `pro_codigo` bigint(20) NOT NULL AUTO_INCREMENT,
  `pro_descricao` varchar(150) NOT NULL,
  `pro_preco_venda` decimal(10,2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`pro_codigo`) USING BTREE,
  KEY `produtos_descricao` (`pro_descricao`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sequence`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sequence` (
  `table` varchar(100) NOT NULL,
  `auto_inc` bigint(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`table`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-10-13 11:24:11
