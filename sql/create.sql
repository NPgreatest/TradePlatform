-- MySQL dump 10.13  Distrib 8.0.30, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: mall
-- ------------------------------------------------------
-- Server version	8.0.30

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

create database mall;
use mall;

DROP TABLE IF EXISTS `oneforallmall_admin_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oneforallmall_admin_user` (
  `admin_user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '管理员id',
  `login_user_name` varchar(50) NOT NULL COMMENT '管理员登陆名称',
  `login_password` varchar(50) NOT NULL COMMENT '管理员登陆密码',
  `nick_name` varchar(50) NOT NULL COMMENT '管理员显示昵称',
  `locked` tinyint DEFAULT '0' COMMENT '是否锁定 0未锁定 1已锁定无法登陆',
  PRIMARY KEY (`admin_user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oneforallmall_admin_user`
--

LOCK TABLES `oneforallmall_admin_user` WRITE;
/*!40000 ALTER TABLE `oneforallmall_admin_user` DISABLE KEYS */;
INSERT INTO `oneforallmall_admin_user` VALUES (1,'admin','e10adc3949ba59abbe56e057f20f883e','NP_123',0);
/*!40000 ALTER TABLE `oneforallmall_admin_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oneforallmall_admin_user_token`
--

DROP TABLE IF EXISTS `oneforallmall_admin_user_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oneforallmall_admin_user_token` (
  `admin_user_id` bigint NOT NULL COMMENT '用户主键id',
  `token` varchar(32) NOT NULL COMMENT 'token值(32位字符串)',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `expire_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'token过期时间',
  PRIMARY KEY (`admin_user_id`),
  UNIQUE KEY `uq_token` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oneforallmall_admin_user_token`
--

LOCK TABLES `oneforallmall_admin_user_token` WRITE;
/*!40000 ALTER TABLE `oneforallmall_admin_user_token` DISABLE KEYS */;
INSERT INTO `oneforallmall_admin_user_token` VALUES (1,'8bcd943aa319f81218b085fc0ca08a6e','2023-07-04 18:50:29','2023-07-06 18:50:29');
/*!40000 ALTER TABLE `oneforallmall_admin_user_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oneforallmall_carousel`
--

DROP TABLE IF EXISTS `oneforallmall_carousel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oneforallmall_carousel` (
  `carousel_id` int NOT NULL AUTO_INCREMENT COMMENT '首页轮播图主键id',
  `carousel_url` varchar(100) NOT NULL DEFAULT '' COMMENT '轮播图',
  `redirect_url` varchar(100) NOT NULL DEFAULT '''##''' COMMENT '点击后的跳转地址(默认不跳转)',
  `carousel_rank` int NOT NULL DEFAULT '0' COMMENT '排序值(字段越大越靠前)',
  `is_deleted` tinyint NOT NULL DEFAULT '0' COMMENT '删除标识字段(0-未删除 1-已删除)',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_user` int NOT NULL DEFAULT '0' COMMENT '创建者id',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `update_user` int NOT NULL DEFAULT '0' COMMENT '修改者id',
  PRIMARY KEY (`carousel_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oneforallmall_carousel`
--

LOCK TABLES `oneforallmall_carousel` WRITE;
/*!40000 ALTER TABLE `oneforallmall_carousel` DISABLE KEYS */;
INSERT INTO `oneforallmall_carousel` VALUES (8,'http://20.89.130.136:8888/static/b53151d40d5d880440db934e25e49a82_20230629234708.jpg','baidu.com',1,0,'2023-06-29 23:47:16',0,'2023-06-29 23:47:16',0),(9,'http://20.89.130.136:8888/static/77e23e610477c460a49623a26cb86491_20230629234719.jpg','baidu.com',2,0,'2023-06-29 23:47:23',0,'2023-06-29 23:47:23',0),(10,'http://20.89.130.136:8888/static/301bafd899b22b16536faf844357e9aa_20230629234727.jpg','baidu.com',3,0,'2023-06-29 23:47:32',0,'2023-06-29 23:47:32',0);
/*!40000 ALTER TABLE `oneforallmall_carousel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oneforallmall_goods_category`
--

DROP TABLE IF EXISTS `oneforallmall_goods_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oneforallmall_goods_category` (
  `category_id` bigint NOT NULL AUTO_INCREMENT COMMENT '分类id',
  `category_level` tinyint NOT NULL DEFAULT '0' COMMENT '分类级别(1-一级分类 2-二级分类 3-三级分类)',
  `parent_id` bigint NOT NULL DEFAULT '0' COMMENT '父分类id',
  `category_name` varchar(50) NOT NULL DEFAULT '' COMMENT '分类名称',
  `category_rank` int NOT NULL DEFAULT '0' COMMENT '排序值(字段越大越靠前)',
  `is_deleted` tinyint NOT NULL DEFAULT '0' COMMENT '删除标识字段(0-未删除 1-已删除)',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_user` int NOT NULL DEFAULT '0' COMMENT '创建者id',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `update_user` int DEFAULT '0' COMMENT '修改者id',
  PRIMARY KEY (`category_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=144 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oneforallmall_goods_category`
--

LOCK TABLES `oneforallmall_goods_category` WRITE;
/*!40000 ALTER TABLE `oneforallmall_goods_category` DISABLE KEYS */;
INSERT INTO `oneforallmall_goods_category` VALUES (118,1,0,'3C数码',3,0,'2023-06-30 01:15:54',0,'2023-06-30 01:15:54',0),(119,1,0,'日用品',2,0,'2023-06-30 01:16:06',0,'2023-06-30 01:16:06',0),(120,2,118,'手机',1,0,'2023-06-30 01:16:51',0,'2023-06-30 01:16:51',0),(121,2,118,'电脑',1,0,'2023-06-30 01:16:55',0,'2023-06-30 01:16:55',0),(122,2,118,'耳机',1,0,'2023-06-30 01:16:59',0,'2023-06-30 01:16:59',0),(123,3,120,'华为手机',1,0,'2023-06-30 01:18:24',0,'2023-06-30 01:18:24',0),(124,3,120,'苹果手机',1,0,'2023-06-30 01:18:29',0,'2023-06-30 01:18:29',0),(125,3,120,'三星手机',1,0,'2023-06-30 01:18:36',0,'2023-06-30 01:18:36',0),(127,3,121,'苹果电脑',1,0,'2023-06-30 01:19:25',0,'2023-06-30 01:19:25',0),(128,3,121,'华为电脑',1,0,'2023-06-30 01:19:29',0,'2023-06-30 01:19:29',0),(129,3,121,'戴尔电脑',1,0,'2023-06-30 01:19:34',0,'2023-06-30 01:19:34',0),(130,3,122,'苹果耳机',1,0,'2023-06-30 01:19:54',0,'2023-06-30 01:19:54',0),(131,3,122,'森海塞尔',1,0,'2023-06-30 01:20:00',0,'2023-06-30 01:20:00',0),(132,1,0,'图书',1,0,'2023-06-30 01:20:56',0,'2023-06-30 01:21:53',0),(133,2,119,'饮料',2,0,'2023-06-30 01:21:03',0,'2023-06-30 01:21:25',0),(134,2,119,'零食',2,0,'2023-06-30 01:21:15',0,'2023-06-30 01:21:15',0),(135,3,133,'汽水',2,0,'2023-06-30 01:22:22',0,'2023-06-30 01:22:22',0),(136,3,133,'茶饮料',2,0,'2023-06-30 01:22:29',0,'2023-06-30 01:22:29',0),(137,3,134,'薯片',2,0,'2023-06-30 01:22:37',0,'2023-06-30 01:22:37',0),(138,3,134,'冰淇淋',2,0,'2023-06-30 01:22:44',0,'2023-06-30 01:22:44',0),(139,2,132,'纸质书',1,0,'2023-07-04 09:52:28',0,'2023-07-04 09:52:28',0),(140,2,132,'电子书',1,0,'2023-07-04 09:52:33',0,'2023-07-04 09:52:33',0),(141,3,139,'金融书籍',1,0,'2023-07-04 09:52:39',0,'2023-07-04 09:52:39',0),(142,3,139,'计算机书籍',1,0,'2023-07-04 09:52:44',0,'2023-07-04 09:52:44',0),(143,3,140,'PDF图书',1,0,'2023-07-04 09:54:01',0,'2023-07-04 09:54:01',0);
/*!40000 ALTER TABLE `oneforallmall_goods_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oneforallmall_goods_info`
--

DROP TABLE IF EXISTS `oneforallmall_goods_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oneforallmall_goods_info` (
  `goods_id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '商品表主键id',
  `goods_name` varchar(200) NOT NULL DEFAULT '' COMMENT '商品名',
  `goods_intro` varchar(200) NOT NULL DEFAULT '' COMMENT '商品简介',
  `goods_category_id` bigint NOT NULL DEFAULT '0' COMMENT '关联分类id',
  `goods_cover_img` varchar(200) NOT NULL DEFAULT '/admin/dist/img/no-img.png' COMMENT '商品主图',
  `goods_carousel` varchar(500) NOT NULL DEFAULT '/admin/dist/img/no-img.png' COMMENT '商品轮播图',
  `goods_detail_content` text NOT NULL COMMENT '商品详情',
  `original_price` int NOT NULL DEFAULT '1' COMMENT '商品价格',
  `selling_price` int NOT NULL DEFAULT '1' COMMENT '商品实际售价',
  `stock_num` int unsigned NOT NULL DEFAULT '0' COMMENT '商品库存数量',
  `tag` varchar(20) NOT NULL DEFAULT '' COMMENT '商品标签',
  `goods_sell_status` tinyint NOT NULL DEFAULT '0' COMMENT '商品上架状态 1-下架 0-上架',
  `create_user` int NOT NULL DEFAULT '0' COMMENT '添加者主键id',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '商品添加时间',
  `update_user` int NOT NULL DEFAULT '0' COMMENT '修改者主键id',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '商品修改时间',
  PRIMARY KEY (`goods_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10916 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oneforallmall_goods_info`
--

LOCK TABLES `oneforallmall_goods_info` WRITE;
/*!40000 ALTER TABLE `oneforallmall_goods_info` DISABLE KEYS */;
INSERT INTO `oneforallmall_goods_info` VALUES (100,'HUAWEI P50','非常先进的4G手机，引领时代！！！',123,'http://20.89.130.136:8888/static/e0e09951f61fed537fba9bd4673c6673_20230630012525.jpg','','<p>华为P50是华为公司于2023年发布的一款智能4G手机!!!!!!!!!!作为华为P系列的最新一代产品，P50在摄影、性能和设计等方面都有所升级和改进。以下是对华为P50的详细介绍：</p><p>外观设计：\n华为P50采用了精致的外观设计，拥有光滑的曲面玻璃背板和金属边框。它具有紧凑的尺寸和舒适的握持感。前面板采用了一块6.5英寸至6.7英寸的显示屏，屏幕上部有一个小型的刘海或挖孔设计用于容纳前置摄像头。背面设计相对简洁，有一个摄像头模块，采用了华为独特的圆形设计，摄像头之间有一个环形闪光灯。</p><p>显示屏：\n华为P50采用了一块高质量的OLED显示屏，具有高分辨率和鲜艳的色彩表现。屏幕支持高刷新率（通常为90Hz或120Hz），能够提供更流畅的滚动和动画效果。同时，该屏幕还支持HDR10+，能够呈现更广阔的动态范围和更高的对比度。</p><p>摄影能力：\n作为华为P系列的一大亮点，P50在摄影能力方面具有出色的表现。它采用了一套卓越的后置摄像头系统，由Leica合作开发。具体的配置可能因地区而异，但预计会包括主摄像头、超广角摄像头和长焦摄像头等多个镜头。这些摄像头的分辨率可能高达5000万像素以上，能够拍摄出清晰、细腻的照片。此外，华为P50还配备了先进的图像处理技术，包括AI场景识别、夜景模式和超级防抖等功能，能够在各种拍摄条件下获得出色的成像效果。</p><p>性能和软件：\n华为P50采用了高性能的处理器，可能是华为自家研发的麒麟系列芯片。这款芯片具有强大的计算能力和出色的能效比，能够提供流畅的手机体验。此外，P50还可能搭载大容量的内存和存储空间，以满足用户对多任务处理和大型应用程序的需求。操作系统方面，华为P50预装了最新的鸿蒙（HarmonyOS）操作系统，该系统具有优化的性能和智能化的功能，为用户提供更好的使用体验。</p><p>其他功能：\n华为P50可能支持5G网络连接，以提供更快的下载和流媒体体验。它还可能配备大容量电池和快速充电技术，以满足日常使用的需求。此外，P50还可能具备防水防尘功能、指纹识别、面部解锁等常见的智能手机功能。</p><p>需要注意的是，以上介绍是基于目前的信息和推测，实际的华为P50的规格和功能可能会因地区和版本而有所不同。最准确和详细的信息应以华为官方发布的信息为准。</p>',4999,6999,1,'爱国',0,0,'2023-06-30 01:26:52',0,'2023-06-30 01:26:52'),(10904,'iPhone14','苹果的新牙膏',124,'http://20.89.130.136:8888/static/694e31eb1200eb2908d5fa05761e033c_20230630105104.jpg','','<p>Apple｜iPhone14系列详细介绍<br/>2022年苹果的秋季发布会提前带来的iPhone14全系列，一起来看看～<br/>-<br/>电池：<br/>iPhone14 3279mAh<br/>iPhone14 Plus 4325mAh<br/>iPhone14 Pro 3200mAh<br/>iPhone14 Pro Max 4323mAh<br/>均支持20w有线快充 &amp; 15W Magsafe 无线充电<br/>最高充电功率实测：<br/>14系列依然是20w, Pro系列支持27w<br/>尺寸&amp;重量：<br/>iPhone14 6.1吋 （172克）<br/>iPhone14 Plus 6.7吋（203克）<br/>iPhone14 Pro 6.1吋 （206克）<br/>iPhone14 Pro Max 6.7吋 （240克）<br/>-<br/>外观颜色：<br/>iPhone 14 &amp; iPhone 14 Plus<br/>红色、星光色、午夜色、蓝色、紫色<br/>iPhone 14 Pro &amp; iPhone 14 Pro Max<br/>金色、银色、深空灰色、暗紫色<br/>-<br/>性能：<br/>iPhone 14 &amp; iPhone 14 Plus<br/>A15满血版（6GB运行内存）<br/>iPhone 14 Pro &amp; iPhone 14 Pro Max<br/>A16仿生<br/>这一次iPhone 14系列依然沿用13 Pro系列上的满血版处理器，而14 Pro系列则用上了最新的台积电4nm A16处理器。<br/>-<br/>屏幕：<br/>14 Pro系列用上了“药丸”屏，并且独享了灵动岛功能～<br/>14系列则依旧为上一代短刘海设计～<br/>这一次iPhone 14 Pro系列依旧支持ProMotion 自适应刷新率最高120hz，但最低能达1hz还新增了全天候显示。iPhone 14 &amp; 14 Plus 依然仅支持60hz<br/>14系列 屏幕最大典型亮度为800尼特，1200峰值亮度～<br/>14 Pro系列屏幕最大典型亮度为1000尼特，2000尼特峰值亮度（户外）<br/>-<br/>摄影：<br/>iPhone 14 &amp; 14 Plus 后置主摄维持12MP，升级到了光圈f/1.5<br/>14 Pro系列主摄升级到了48MP，闪光灯再度升级为自适应原彩闪光灯<br/>14全系列支持运动拍摄模式，拍视频更稳<br/></p>',6999,6999,1999,'厨子',0,0,'2023-06-30 10:52:31',0,'2023-06-30 10:52:31'),(10905,'iPhone SE','牙膏被挤爆了',124,'http://20.89.130.136:8888/static/2da5b8dfa5ec2f11c1363bdb45c51e5f_20230703225823.jpg','','<p><em>iPhone</em>&nbsp;<em>SE</em>&nbsp;有一颗强劲的心, 那就是iPhone 13 的同款芯片,性能超强的A15 仿生。&nbsp;</p><p>A15 仿生为你带来的提升无所不在,app 瞬间就能载入,体验非常流畅。&nbsp;<br/></p>',3299,3299,999,'苹果',0,0,'2023-07-03 23:01:37',0,'2023-07-03 23:01:37'),(10906,'Samsung Galaxy Note 20 Ultra','三星手机，屏幕很棒',125,'http://20.89.130.136:8888/static/4636920bbc1fcd432d60ee775019f947_20230703230257.jpg','','<p><em>Samsung</em>&nbsp;Galaxy&nbsp;<em>Note 20 Ultra</em>是<em>三星</em>电子公司于2020年8月5日发布的一款手机。</p><p><em>Samsung</em>&nbsp;Galaxy&nbsp;<em>Note 20 Ultra</em>采用了6.9英寸第二代动态AMOLED屏设计，高度164.8毫米，宽度77.2毫米，</p><p>厚度8.1毫米，重量约208克，配有迷雾、初露白、曜岩黑三款颜色。<br/></p>',5999,5999,100,'三星',0,0,'2023-07-03 23:03:09',0,'2023-07-03 23:03:09'),(10907,'HUAWEI Mate 40 Pro','采用“瀑布屏”设计',123,'http://20.89.130.136:8888/static/fe2eda800ce80e89b6a8543061af65cb_20230703230742.jpg','','<p>HUAWEI&nbsp;<em>Mate 40 Pro</em>是<em>华为</em>公司于2020年10月22日发布的一款智能手机。HUAWEI&nbsp;<em>Mate 40 Pro</em>共有秘银、亮黑、釉白、夏日胡杨（素皮）、</p><p>秋日胡杨（素皮）5种配色版本；采用“瀑布屏”设计，88°超曲环幕屏在视觉上消除了左右边框<br/></p>',8999,12999,5,'爱国！',0,0,'2023-07-03 23:07:54',0,'2023-07-03 23:07:54'),(10908,'Airpods Pro','降噪耳机，很厉害哦',130,'http://20.89.130.136:8888/static/596a39bbf03bf414e4d611c783497932_20230703231012.jpg','','<p><em>AirPods</em>&nbsp;<em>Pro</em>&nbsp;和 MagSafe 充电盒都具备IPX4 级别抗汗抗水性能7。 精妙的体验 简单, 再简单不过。</p><p>&nbsp;从瞬间完成配对设置,到便捷的 Siri 指令,AirPods Pro 集 AirPods 家族妙不可言的优点于一身。<br/></p>',1999,1999,999,'苹果',0,0,'2023-07-03 23:10:36',0,'2023-07-03 23:10:36'),(10909,'HE1 大奥','HIFI',131,'http://20.89.130.136:8888/static/725596bc50e235948db09cb326525c7a_20230703231143.jpg','','<p>听了保证流泪！！！</p><p>买了这个耳机，这辈子值了</p>',249999,239999,5,'HIFI',0,0,'2023-07-03 23:11:58',0,'2023-07-03 23:11:58'),(10910,'Matebook','不买不是中国人',128,'http://20.89.130.136:8888/static/5ffcbcbbe7b549a8e6cc7b296e5e5a5b_20230703231308.jpg','','<p><u style=\"background-color: rgb(70, 172, 200);\"><font face=\"标楷体\" style=\"\" size=\"6\" color=\"#c24f4a\"><i style=\"\">不觉得这很酷吗?作为一名理工男我觉得这太酷了，</i></font></u></p><p><u style=\"background-color: rgb(70, 172, 200);\"><font face=\"标楷体\" style=\"\" size=\"6\" color=\"#c24f4a\"><i style=\"\">很符合我对未来生活的想象，科技并带着趣味</i></font></u></p><p><em>HUAWEI MateBook</em>是华为2016年推出的二合一笔记本电脑。作为华为旗下首款笔记本电脑，作为一款彰显新商务风尚的高端生产力工具，<em>HUAWEI MateBook</em>秉承了华为品牌一贯的精品战略，延续华为旗舰产品简洁、人性化和浑然天成的设计哲学，以此诠释“时尚新商务”。<br/></p>',9999,9999,2,'爱国',0,0,'2023-07-03 23:15:03',0,'2023-07-03 23:15:03'),(10911,'可口可乐','太好喝力（喜)',135,'http://20.89.130.136:8888/static/a1e05ee2564dbf16b04f09a23d482d06_20230703234631.jpg','','<p>不用过多解释了</p><p>1886年5月8日，可口可乐在美国<a target=\"_blank\" href=\"https://baike.baidu.com/item/%E4%B9%94%E6%B2%BB%E4%BA%9A%E5%B7%9E/2414335?fromModule=lemma_inlink\">乔治亚州</a><a target=\"_blank\" href=\"https://baike.baidu.com/item/%E4%BA%9A%E7%89%B9%E5%85%B0%E5%A4%A7/11926?fromModule=lemma_inlink\">亚特兰大</a>市诞生，自此便与<a target=\"_blank\" href=\"https://baike.baidu.com/item/%E7%A4%BE%E4%BC%9A%E5%8F%91%E5%B1%95/28519?fromModule=lemma_inlink\">社会发展</a>相互交融，激发创新灵感，也曾协办著名的<a target=\"_blank\" href=\"https://baike.baidu.com/item/%E5%9F%83%E9%BB%98%E9%87%8C%E5%A4%A7%E5%AD%A6/5588401?fromModule=lemma_inlink\">埃默里大学</a><sup>&nbsp;[32-34]</sup><a>&nbsp;</a><a>&nbsp;</a><a>&nbsp;</a>。</p><p>进入到21世纪后，全球每天有17亿人次的消费者在畅饮可口可乐公司的产品，大约每秒钟售出19,400瓶饮料，在2016年10月，<a target=\"_blank\" href=\"https://baike.baidu.com/item/%E5%8F%AF%E5%8F%A3%E5%8F%AF%E4%B9%90%E5%85%AC%E5%8F%B8/1612740?fromModule=lemma_inlink\">可口可乐公司</a>排2016年全球100大最有价值品牌第三名<sup>&nbsp;[1]</sup><a>&nbsp;</a>&nbsp;；可口可乐为中国消费者提供超过15个品牌50多种饮料选择，其系列产品在华的每天享用量达到1.5亿杯，可口可乐自1979年重返中国市场至2014年底，已累计投资超过90亿美元，截止到2020年底在华建有43家工厂，系统员工约45,000人，其中99%为本地员工，可口可乐及其装瓶厂在中国长期以来不遗余力地支持教育及<a target=\"_blank\" href=\"https://baike.baidu.com/item/%E5%85%AC%E7%9B%8A%E4%BA%8B%E4%B8%9A/6542989?fromModule=lemma_inlink\">公益事业</a>，推广<a target=\"_blank\" href=\"https://baike.baidu.com/item/%E7%8E%AF%E5%A2%83%E4%BF%9D%E6%8A%A4/247307?fromModule=lemma_inlink\">环境保护</a>以及帮助<a target=\"_blank\" href=\"https://baike.baidu.com/item/%E5%BD%93%E5%9C%B0%E7%A4%BE%E5%8C%BA/53969143?fromModule=lemma_inlink\">当地社区</a>的发展，捐资总额超过2.7亿元人民币，另外，可口可乐亦是一个全方位赞助在<a target=\"_blank\" href=\"https://baike.baidu.com/item/%E4%B8%AD%E5%9B%BD/22516505?fromModule=lemma_inlink\">中国</a>举办的特奥会、<a target=\"_blank\" href=\"https://baike.baidu.com/item/%E5%A5%A5%E8%BF%90%E4%BC%9A/106463?fromModule=lemma_inlink\">奥运会</a>、<a target=\"_blank\" href=\"https://baike.baidu.com/item/%E6%AE%8B%E5%A5%A5%E4%BC%9A/11168942?fromModule=lemma_inlink\">残奥会</a>、<a target=\"_blank\" href=\"https://baike.baidu.com/item/%E4%B8%96%E5%8D%9A%E4%BC%9A/171154?fromModule=lemma_inlink\">世博会</a>、大运会及<a target=\"_blank\" href=\"https://baike.baidu.com/item/%E9%9D%92%E5%A5%A5%E4%BC%9A/11222276?fromModule=lemma_inlink\">青奥会</a>的企业。</p><p>2018年8月31日，可口可乐宣布将以39亿英镑（51亿美元）全资收购Costa咖啡，预计2019年上半年完成交易。<sup>&nbsp;[2]</sup><a>&nbsp;</a>&nbsp;2018年12月18日，<a target=\"_blank\" href=\"https://baike.baidu.com/item/%E4%B8%96%E7%95%8C%E5%93%81%E7%89%8C%E5%AE%9E%E9%AA%8C%E5%AE%A4/4040038?fromModule=lemma_inlink\">世界品牌实验室</a>编制的《<a target=\"_blank\" href=\"https://baike.baidu.com/item/2018%E4%B8%96%E7%95%8C%E5%93%81%E7%89%8C500%E5%BC%BA/23215459?fromModule=lemma_inlink\">2018世界品牌500强</a>》揭晓，可口可乐排名第7位。<sup>&nbsp;[3]</sup><a>&nbsp;</a>&nbsp;2019年10月，<a target=\"_blank\" href=\"https://baike.baidu.com/item/Interbrand/6131019?fromModule=lemma_inlink\">Interbrand</a>发布的<a target=\"_blank\" href=\"https://baike.baidu.com/item/%E5%85%A8%E7%90%83%E5%93%81%E7%89%8C/1536841?fromModule=lemma_inlink\">全球品牌</a>百强排名第五位。<sup>&nbsp;[4]</sup><a>&nbsp;</a></p><p>2020年1月22日，名列2020年《<a target=\"_blank\" href=\"https://baike.baidu.com/item/%E8%B4%A2%E5%AF%8C/1944587?fromModule=lemma_inlink\">财富</a>》全球最受赞赏公司榜单第12位。<sup>&nbsp;[5]</sup><a>&nbsp;</a></p><p>当地时间2021年11月1日，可口可乐宣布，已获取了<a target=\"_blank\" href=\"https://baike.baidu.com/item/%E8%BF%90%E5%8A%A8%E9%A5%AE%E6%96%99/947406?fromModule=lemma_inlink\">运动饮料</a>制造商<a target=\"_blank\" href=\"https://baike.baidu.com/item/BodyArmor/59182427?fromModule=lemma_inlink\">BodyArmor</a>的全部股权，这也成为该公司成立129年以来的最大规模的品牌收购。</p>',3,3,9993,'肥宅快乐水',0,0,'2023-07-03 23:46:00',0,'2023-07-03 23:47:32'),(10912,'东方树叶','乌龙茶',136,'http://20.89.130.136:8888/static/9a47c41e0726f2924a8f85190ceddae6_20230703234841.jpg','','<p><em>东方树叶</em>是农夫山泉公司最新出品的一款茶饮料，用农夫山泉泡制，主打0卡路里。1610年中国茶叶乘着商船漂洋过海，饮茶之风迅速传遍欧洲大陆。因一时不知如何命名，且其来自神秘的东方，故被称为“神奇的<em>东方树叶</em>”。<br/></p>',5,5,999,'好喝',0,0,'2023-07-03 23:48:53',0,'2023-07-03 23:48:53'),(10913,'乐事薯片','可乐做的不行，薯片倒还好',137,'http://20.89.130.136:8888/static/6fddf7247daa6dc68eca1377dd4c7e4c_20230703235003.jpg','','<p><em>薯片</em>是指由马铃薯（土豆）制成的零食，是很多国家零食市场重要一部分。<em>薯片</em>中含有大量丙烯酰胺。制作<em>薯片</em>时，先把马铃薯去皮后切为薄片，然后炸或烤至脆口并加以调味即可。<br/></p>',6,6,994,'乐事',0,0,'2023-07-03 23:50:53',0,'2023-07-03 23:50:53'),(10914,'金融计量学','大数据',141,'http://20.89.130.136:8888/static/e3b56a299bfab49b5e64c8a01fe3aca9_20230704095554.jpg','','<p>结合金融计算课程知识和机器学习模型，围绕如下主题：资产定价、资产配置、交易执行、风险管理，完成一篇研究报告。\n\n \n\n1. 课程论文内容：标题、摘要、绪论、文献综述、建模求解、结果讨论、结论、参考文献、附录。\n\n2. 课程论文格式：与实验报告一致。\n\n3. 课程论文内容不得与课程案例和课程实验重合。\n\n4. 课程论文计算必须用Python处理数据、执行计算、给出结果。\n\n5. 课程论文正文不得少于3333字（不含参考文献），课程评价不得少于666字。\n\n6. 参考文献不得少于10篇（5篇中文，5篇英文），所引论文必须来自商学院期刊目录中文二类（含二类）以上和英文B类（含B类）以上的期刊。\n\n7. 报告、代码和数据一起打包提交至学习通网站，截止时间6月15日15时15分15秒。\n\n8. 报告做成长图片上传至学习通，报告不需要打印。</p>',59,69,999,'蒋',0,0,'2023-07-04 09:56:13',0,'2023-07-04 18:51:09'),(10915,'计算机网络','计网',142,'http://20.89.130.136:8888/static/e08bad2e99a79366e25b2c162c9baba8_20230704095810.jpg','','<p><br/>分组交换比电路交换（&nbsp;&nbsp;&nbsp; ）。</p><p>（4.0分）</p><ul><form><li><i>A、</i><p><a href=\"javascript:void(0);\"></a></p><p><a href=\"javascript:void(0);\">实时性好、线路利用率高</a></p></li><li><i>B、</i><p><a href=\"javascript:void(0);\"></a></p><p><a href=\"javascript:void(0);\">实时性好但线路利用率低</a></p></li><li><i>C、</i><p><a href=\"javascript:void(0);\"></a></p><p><a href=\"javascript:void(0);\">实时性和线路利用率都低</a></p></li><li><i>D、</i><p><a href=\"javascript:void(0);\"></a></p><p><a href=\"javascript:void(0);\">实时性差但线路利用率高</a></p></li></form></ul><p>我的答案：D</p><p><i>2</i></p><p>以太网的拓扑结构是（&nbsp;&nbsp;&nbsp;&nbsp;）。</p><p>（4.0分）</p><ul><form><li><i>A、</i><p><a href=\"javascript:void(0);\"></a></p><p><a href=\"javascript:void(0);\">星型</a></p></li><li><i>B、</i><p><a href=\"javascript:void(0);\"></a></p><p><a href=\"javascript:void(0);\">树型</a></p></li><li><i>C、</i><p><a href=\"javascript:void(0);\"></a></p><p><a href=\"javascript:void(0);\">环型</a></p></li><li><i>D、</i><p><a href=\"javascript:void(0);\"></a></p><p><a href=\"javascript:void(0);\">总线型</a></p></li></form></ul><p>我的答案：D</p><p><i>3</i></p><p>使用拥塞控制机制的协议是</p><p>（4.0分）</p><ul><form><li><i>A、</i><p><a href=\"javascript:void(0);\"></a></p><p><a href=\"javascript:void(0);\">TCP</a></p></li><li><i>B、</i><p><a href=\"javascript:void(0);\"></a></p><p><a href=\"javascript:void(0);\">CSMA/CA</a></p></li><li><i>C、</i><p><a href=\"javascript:void(0);\"></a></p><p><a href=\"javascript:void(0);\">CSMA/CD</a></p></li><li><i>D、</i><p><a href=\"javascript:void(0);\"></a></p><p><a href=\"javascript:void(0);\">UDP</a></p></li></form></ul><p>我的答案：A</p>',79,99,88,'好难',0,0,'2023-07-04 09:58:28',0,'2023-07-04 09:58:28');
/*!40000 ALTER TABLE `oneforallmall_goods_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oneforallmall_index_config`
--

DROP TABLE IF EXISTS `oneforallmall_index_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oneforallmall_index_config` (
  `config_id` bigint NOT NULL AUTO_INCREMENT COMMENT '首页配置项主键id',
  `config_name` varchar(50) NOT NULL DEFAULT '' COMMENT '显示字符(配置搜索时不可为空，其他可为空)',
  `config_type` tinyint NOT NULL DEFAULT '0' COMMENT '1-搜索框热搜 2-搜索下拉框热搜 3-(首页)热销商品 4-(首页)新品上线 5-(首页)为你推荐',
  `goods_id` bigint NOT NULL DEFAULT '0' COMMENT '商品id 默认为0',
  `redirect_url` varchar(100) NOT NULL DEFAULT '##' COMMENT '点击后的跳转地址(默认不跳转)',
  `config_rank` int NOT NULL DEFAULT '0' COMMENT '排序值(字段越大越靠前)',
  `is_deleted` tinyint NOT NULL DEFAULT '0' COMMENT '删除标识字段(0-未删除 1-已删除)',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_user` int NOT NULL DEFAULT '0' COMMENT '创建者id',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最新修改时间',
  `update_user` int DEFAULT '0' COMMENT '修改者id',
  PRIMARY KEY (`config_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oneforallmall_index_config`
--

LOCK TABLES `oneforallmall_index_config` WRITE;
/*!40000 ALTER TABLE `oneforallmall_index_config` DISABLE KEYS */;
INSERT INTO `oneforallmall_index_config` VALUES (1,'HUAWEI P50',4,100,'huawei.com',1,0,'2023-06-30 01:33:02',0,'2023-06-30 01:33:02',0),(2,'HE1 大奥',4,10909,'apple.com',1,0,'2023-06-30 01:33:02',0,'2023-06-30 01:33:02',0),(3,'Airpods Pro',5,10908,'apple.com',1,0,'2023-06-30 01:33:02',0,'2023-06-30 01:33:02',0),(4,'iPhone SE',5,10905,'apple.com',1,0,'2023-06-30 01:33:02',0,'2023-06-30 01:33:02',0),(5,'Matebook',3,10910,'huawei.com',1,0,'2023-06-30 01:33:02',0,'2023-06-30 01:33:02',0),(6,'东方树叶',3,10912,'baidu.com',1,0,'2023-06-30 01:33:02',0,'2023-06-30 01:33:02',0);
/*!40000 ALTER TABLE `oneforallmall_index_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oneforallmall_order`
--

DROP TABLE IF EXISTS `oneforallmall_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oneforallmall_order` (
  `order_id` bigint NOT NULL AUTO_INCREMENT COMMENT '订单表主键id',
  `order_no` varchar(20) NOT NULL DEFAULT '' COMMENT '订单号',
  `user_id` bigint NOT NULL DEFAULT '0' COMMENT '用户主键id',
  `total_price` int NOT NULL DEFAULT '1' COMMENT '订单总价',
  `pay_status` tinyint NOT NULL DEFAULT '0' COMMENT '支付状态:0.未支付,1.支付成功,-1:支付失败',
  `pay_type` tinyint NOT NULL DEFAULT '0' COMMENT '0.无 1.支付宝支付 2.微信支付',
  `pay_time` datetime DEFAULT NULL COMMENT '支付时间',
  `order_status` tinyint NOT NULL DEFAULT '0' COMMENT '订单状态:0.待支付 1.已支付 2.配货完成 3:出库成功 4.交易成功 -1.手动关闭 -2.超时关闭 -3.商家关闭',
  `extra_info` varchar(100) NOT NULL DEFAULT '' COMMENT '订单body',
  `is_deleted` tinyint NOT NULL DEFAULT '0' COMMENT '删除标识字段(0-未删除 1-已删除)',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最新修改时间',
  PRIMARY KEY (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oneforallmall_order`
--

LOCK TABLES `oneforallmall_order` WRITE;
/*!40000 ALTER TABLE `oneforallmall_order` DISABLE KEYS */;
INSERT INTO `oneforallmall_order` VALUES (1,'16880229712816221',1,12999,1,1,'2023-06-29 15:16:12',3,'',0,'2023-06-29 15:16:11','2023-06-30 01:14:18'),(2,'16880601563711954',1,6999,1,2,'2023-06-30 01:35:57',1,'',0,'2023-06-30 01:35:56','2023-06-30 01:35:57'),(3,'16883994636785838',1,38040,1,2,'2023-07-03 23:51:05',2,'',0,'2023-07-03 23:51:04','2023-07-04 09:49:14'),(4,'16884353016055869',1,3,1,1,'2023-07-04 09:48:22',3,'',0,'2023-07-04 09:48:22','2023-07-04 09:49:19');
/*!40000 ALTER TABLE `oneforallmall_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oneforallmall_order_address`
--

DROP TABLE IF EXISTS `oneforallmall_order_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oneforallmall_order_address` (
  `order_id` bigint NOT NULL,
  `user_name` varchar(30) NOT NULL DEFAULT '' COMMENT '收货人姓名',
  `user_phone` varchar(11) NOT NULL DEFAULT '' COMMENT '收货人手机号',
  `province_name` varchar(32) NOT NULL DEFAULT '' COMMENT '省',
  `city_name` varchar(32) NOT NULL DEFAULT '' COMMENT '城',
  `region_name` varchar(32) NOT NULL DEFAULT '' COMMENT '区',
  `detail_address` varchar(64) NOT NULL DEFAULT '' COMMENT '收件详细地址(街道/楼宇/单元)',
  PRIMARY KEY (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='订单收货地址关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oneforallmall_order_address`
--

LOCK TABLES `oneforallmall_order_address` WRITE;
/*!40000 ALTER TABLE `oneforallmall_order_address` DISABLE KEYS */;
/*!40000 ALTER TABLE `oneforallmall_order_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oneforallmall_order_item`
--

DROP TABLE IF EXISTS `oneforallmall_order_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oneforallmall_order_item` (
  `order_item_id` bigint NOT NULL AUTO_INCREMENT COMMENT '订单关联购物项主键id',
  `order_id` bigint NOT NULL DEFAULT '0' COMMENT '订单主键id',
  `goods_id` bigint NOT NULL DEFAULT '0' COMMENT '关联商品id',
  `goods_name` varchar(200) NOT NULL DEFAULT '' COMMENT '下单时商品的名称(订单快照)',
  `goods_cover_img` varchar(200) NOT NULL DEFAULT '' COMMENT '下单时商品的主图(订单快照)',
  `selling_price` int NOT NULL DEFAULT '1' COMMENT '下单时商品的价格(订单快照)',
  `goods_count` int NOT NULL DEFAULT '1' COMMENT '数量(订单快照)',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`order_item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oneforallmall_order_item`
--

LOCK TABLES `oneforallmall_order_item` WRITE;
/*!40000 ALTER TABLE `oneforallmall_order_item` DISABLE KEYS */;
INSERT INTO `oneforallmall_order_item` VALUES (1,1,10269,'Apple 2019新品 Macbook Pro 13...','http://20.89.130.136:8888/static/694e31eb1200eb2908d5fa05761e033c_20230630105104.jpg',12999,1,'2023-06-29 15:16:11'),(2,2,100,'HUAWEI P50','http://20.89.130.136:8888/static/e0e09951f61fed537fba9bd4673c6673_20230630012525.jpg',6999,1,'2023-06-30 01:35:56'),(3,3,100,'HUAWEI P50','http://20.89.130.136:8888/static/e0e09951f61fed537fba9bd4673c6673_20230630012525.jpg',6999,3,'2023-07-03 23:51:04'),(4,3,10904,'iPhone14','http://20.89.130.136:8888/static/694e31eb1200eb2908d5fa05761e033c_20230630105104.jpg',6999,1,'2023-07-03 23:51:04'),(5,3,10910,'Matebook','http://20.89.130.136:8888/static/5ffcbcbbe7b549a8e6cc7b296e5e5a5b_20230703231308.jpg',9999,1,'2023-07-03 23:51:04'),(6,3,10911,'可口可乐','http://20.89.130.136:8888/static/a1e05ee2564dbf16b04f09a23d482d06_20230703234631.jpg',3,5,'2023-07-03 23:51:04'),(7,3,10913,'乐事薯片','http://20.89.130.136:8888/static/6fddf7247daa6dc68eca1377dd4c7e4c_20230703235003.jpg',6,5,'2023-07-03 23:51:04'),(8,4,10911,'可口可乐','http://20.89.130.136:8888/static/a1e05ee2564dbf16b04f09a23d482d06_20230703234631.jpg',3,1,'2023-07-04 09:48:22');
/*!40000 ALTER TABLE `oneforallmall_order_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oneforallmall_shopping_cart_item`
--

DROP TABLE IF EXISTS `oneforallmall_shopping_cart_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oneforallmall_shopping_cart_item` (
  `cart_item_id` bigint NOT NULL AUTO_INCREMENT COMMENT '购物项主键id',
  `user_id` bigint NOT NULL COMMENT '用户主键id',
  `goods_id` bigint NOT NULL DEFAULT '0' COMMENT '关联商品id',
  `goods_count` int NOT NULL DEFAULT '1' COMMENT '数量(最大为5)',
  `is_deleted` tinyint NOT NULL DEFAULT '0' COMMENT '删除标识字段(0-未删除 1-已删除)',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最新修改时间',
  PRIMARY KEY (`cart_item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oneforallmall_shopping_cart_item`
--

LOCK TABLES `oneforallmall_shopping_cart_item` WRITE;
/*!40000 ALTER TABLE `oneforallmall_shopping_cart_item` DISABLE KEYS */;
INSERT INTO `oneforallmall_shopping_cart_item` VALUES (1,1,10269,1,1,'2023-06-29 15:16:07','2023-06-29 15:16:07'),(2,1,10903,1,1,'2023-06-30 01:27:15','2023-06-30 01:27:15'),(3,1,100,1,1,'2023-06-30 01:35:35','2023-06-30 01:35:35'),(4,1,100,1,1,'2023-06-30 01:35:35','2023-06-30 01:35:35'),(5,1,100,1,1,'2023-06-30 01:35:52','2023-06-30 01:35:52'),(6,1,100,3,1,'2023-06-30 10:38:01','2023-06-30 10:38:06'),(7,1,100,1,1,'2023-06-30 10:38:02','2023-06-30 10:38:02'),(8,1,10904,1,1,'2023-06-30 10:52:52','2023-06-30 10:52:52'),(9,1,10910,1,1,'2023-07-03 23:43:12','2023-07-03 23:43:12'),(10,1,10911,1,1,'2023-07-03 23:47:41','2023-07-03 23:47:41'),(11,1,10911,1,1,'2023-07-03 23:47:42','2023-07-03 23:47:42'),(12,1,10911,5,1,'2023-07-03 23:47:42','2023-07-03 23:47:48'),(13,1,10913,5,1,'2023-07-03 23:50:58','2023-07-03 23:51:00'),(14,1,10911,1,1,'2023-07-03 23:55:19','2023-07-03 23:55:19'),(15,1,10909,1,0,'2023-07-04 09:50:07','2023-07-04 09:50:07');
/*!40000 ALTER TABLE `oneforallmall_shopping_cart_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oneforallmall_user`
--

DROP TABLE IF EXISTS `oneforallmall_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oneforallmall_user` (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户主键id',
  `nick_name` varchar(50) NOT NULL DEFAULT '' COMMENT '用户昵称',
  `login_name` varchar(11) NOT NULL DEFAULT '' COMMENT '登陆名称(默认为手机号)',
  `password_md5` varchar(32) NOT NULL DEFAULT '' COMMENT 'MD5加密后的密码',
  `introduce_sign` varchar(100) NOT NULL DEFAULT '' COMMENT '个性签名',
  `is_deleted` tinyint NOT NULL DEFAULT '0' COMMENT '注销标识字段(0-正常 1-已注销)',
  `locked_flag` tinyint NOT NULL DEFAULT '0' COMMENT '锁定标识字段(0-未锁定 1-已锁定)',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oneforallmall_user`
--

LOCK TABLES `oneforallmall_user` WRITE;
/*!40000 ALTER TABLE `oneforallmall_user` DISABLE KEYS */;
INSERT INTO `oneforallmall_user` VALUES (1,'NP_123','13260198885','e10adc3949ba59abbe56e057f20f883e','oh my god！！！',0,0,'2020-05-22 08:44:57'),(2,'Jack','13261111111','e10adc3949ba59abbe56e057f20f883e','testing user Jack',0,0,'2020-05-22 08:44:57');
/*!40000 ALTER TABLE `oneforallmall_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oneforallmall_user_address`
--

DROP TABLE IF EXISTS `oneforallmall_user_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oneforallmall_user_address` (
  `address_id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL DEFAULT '0' COMMENT '用户主键id',
  `user_name` varchar(30) NOT NULL DEFAULT '' COMMENT '收货人姓名',
  `user_phone` varchar(11) NOT NULL DEFAULT '' COMMENT '收货人手机号',
  `default_flag` tinyint NOT NULL DEFAULT '0' COMMENT '是否为默认 0-非默认 1-是默认',
  `province_name` varchar(32) NOT NULL DEFAULT '' COMMENT '省',
  `city_name` varchar(32) NOT NULL DEFAULT '' COMMENT '城',
  `region_name` varchar(32) NOT NULL DEFAULT '' COMMENT '区',
  `detail_address` varchar(64) NOT NULL DEFAULT '' COMMENT '收件详细地址(街道/楼宇/单元)',
  `is_deleted` tinyint NOT NULL DEFAULT '0' COMMENT '删除标识字段(0-未删除 1-已删除)',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`address_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COMMENT='收货地址表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oneforallmall_user_address`
--

LOCK TABLES `oneforallmall_user_address` WRITE;
/*!40000 ALTER TABLE `oneforallmall_user_address` DISABLE KEYS */;
INSERT INTO `oneforallmall_user_address` VALUES (1,1,'YUCHEN LIU','13260198885',1,'上海','上海市','奉贤区','999 Haisi Rd\nFengxian District',0,'2023-06-29 15:15:52','2023-07-04 09:46:08'),(2,1,'123 np','13269945678',0,'北京','北京市','东城区','AAA\nFengxian DistrictA',0,'2023-07-04 09:47:04','2023-07-04 09:47:04');
/*!40000 ALTER TABLE `oneforallmall_user_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oneforallmall_user_token`
--

DROP TABLE IF EXISTS `oneforallmall_user_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oneforallmall_user_token` (
  `user_id` bigint NOT NULL COMMENT '用户主键id',
  `token` varchar(32) NOT NULL COMMENT 'token值(32位字符串)',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `expire_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'token过期时间',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `uq_token` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oneforallmall_user_token`
--

LOCK TABLES `oneforallmall_user_token` WRITE;
/*!40000 ALTER TABLE `oneforallmall_user_token` DISABLE KEYS */;
INSERT INTO `oneforallmall_user_token` VALUES (1,'a315a5f9bfad72dd69ddfde63915c55e','2023-07-04 09:43:56','2023-07-06 09:43:56');
/*!40000 ALTER TABLE `oneforallmall_user_token` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-07-05 11:34:41
