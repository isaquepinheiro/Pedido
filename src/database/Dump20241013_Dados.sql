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
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES (1,'Cliente 1','São Paulo','SP'),(2,'Cliente 2','Rio de Janeiro','RJ'),(3,'Cliente 3','Belo Horizonte','MG'),(4,'Cliente 4','Curitiba','PR'),(5,'Cliente 5','Porto Alegre','RS'),(6,'Cliente 6','Brasília','DF'),(7,'Cliente 7','Salvador','BA'),(8,'Cliente 8','Fortaleza','CE'),(9,'Cliente 9','Recife','PE'),(10,'Cliente 10','Belém','PA'),(11,'Cliente 11','Goiânia','GO'),(12,'Cliente 12','Manaus','AM'),(13,'Cliente 13','Vitória','ES'),(14,'Cliente 14','Florianópolis','SC'),(15,'Cliente 15','Maceió','AL'),(16,'Cliente 16','Aracaju','SE'),(17,'Cliente 17','Natal','RN'),(18,'Cliente 18','Campo Grande','MS'),(19,'Cliente 19','João Pessoa','PB'),(20,'Cliente 20','Cuiabá','MT'),(21,'Cliente 21','São Luís','MA'),(22,'Cliente 22','Teresina','PI'),(23,'Cliente 23','Macapá','AP'),(24,'Cliente 24','Palmas','TO'),(25,'Cliente 25','Boa Vista','RR'),(26,'Cliente 26','Rio Branco','AC'),(27,'Cliente 27','Porto Velho','RO'),(28,'Cliente 28','Campinas','SP'),(29,'Cliente 29','Santos','SP'),(30,'Cliente 30','Sorocaba','SP'),(31,'Cliente 31','Uberlândia','MG'),(32,'Cliente 32','Ribeirão Preto','SP'),(33,'Cliente 33','São José dos Campos','SP'),(34,'Cliente 34','Joinville','SC'),(35,'Cliente 35','Blumenau','SC'),(36,'Cliente 36','Londrina','PR'),(37,'Cliente 37','Maringá','PR'),(38,'Cliente 38','Cascavel','PR'),(39,'Cliente 39','Caxias do Sul','RS'),(40,'Cliente 40','Pelotas','RS'),(41,'Cliente 41','Santa Maria','RS'),(42,'Cliente 42','Passo Fundo','RS'),(43,'Cliente 43','Anápolis','GO'),(44,'Cliente 44','Itabuna','BA'),(45,'Cliente 45','Ilhéus','BA'),(46,'Cliente 46','Teixeira de Freitas','BA'),(47,'Cliente 47','Feira de Santana','BA'),(48,'Cliente 48','Caruaru','PE'),(49,'Cliente 49','Petrolina','PE'),(50,'Cliente 50','Araripina','PE');
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `pedidos`
--

LOCK TABLES `pedidos` WRITE;
/*!40000 ALTER TABLE `pedidos` DISABLE KEYS */;
INSERT INTO `pedidos` VALUES (9,'2024-10-13 00:00:00',75.75,18),(10,'2024-10-13 00:00:00',123.90,23);
/*!40000 ALTER TABLE `pedidos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `pedidos_itens`
--

LOCK TABLES `pedidos_itens` WRITE;
/*!40000 ALTER TABLE `pedidos_itens` DISABLE KEYS */;
INSERT INTO `pedidos_itens` VALUES (0,9,20,1.00,20.00,20.00),(5,9,21,1.00,55.75,55.75),(1,10,15,1.00,33.50,33.50),(2,10,16,2.00,45.20,90.40);
/*!40000 ALTER TABLE `pedidos_itens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `produtos`
--

LOCK TABLES `produtos` WRITE;
/*!40000 ALTER TABLE `produtos` DISABLE KEYS */;
INSERT INTO `produtos` VALUES (1,'Produto 1',10.99),(2,'Produto 2',15.49),(3,'Produto 3',20.00),(4,'Produto 4',5.75),(5,'Produto 5',12.30),(6,'Produto 6',50.00),(7,'Produto 7',7.99),(8,'Produto 8',8.50),(9,'Produto 9',13.99),(10,'Produto 10',25.00),(11,'Produto 11',19.99),(12,'Produto 12',17.75),(13,'Produto 13',9.49),(14,'Produto 14',29.99),(15,'Produto 15',33.50),(16,'Produto 16',45.20),(17,'Produto 17',22.10),(18,'Produto 18',14.89),(19,'Produto 19',18.00),(20,'Produto 20',32.00),(21,'Produto 21',55.75),(22,'Produto 22',60.00),(23,'Produto 23',5.99),(24,'Produto 24',49.90),(25,'Produto 25',100.00),(26,'Produto 26',12.99),(27,'Produto 27',15.20),(28,'Produto 28',22.45),(29,'Produto 29',40.50),(30,'Produto 30',8.99),(31,'Produto 31',75.00),(32,'Produto 32',19.20),(33,'Produto 33',85.00),(34,'Produto 34',95.99),(35,'Produto 35',105.50),(36,'Produto 36',18.49),(37,'Produto 37',12.50),(38,'Produto 38',3.99),(39,'Produto 39',23.75),(40,'Produto 40',27.99),(41,'Produto 41',7.49),(42,'Produto 42',55.00),(43,'Produto 43',64.30),(44,'Produto 44',29.49),(45,'Produto 45',99.99),(46,'Produto 46',115.75),(47,'Produto 47',130.99),(48,'Produto 48',150.00),(49,'Produto 49',175.20),(50,'Produto 50',200.00);
/*!40000 ALTER TABLE `produtos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `sequence`
--

LOCK TABLES `sequence` WRITE;
/*!40000 ALTER TABLE `sequence` DISABLE KEYS */;
INSERT INTO `sequence` VALUES ('pedido',13),('pedido_itens',5);
/*!40000 ALTER TABLE `sequence` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-10-13 11:24:28
