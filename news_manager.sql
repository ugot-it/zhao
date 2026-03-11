/*
 Navicat Premium Data Transfer

 Source Server         : 21
 Source Server Type    : MySQL
 Source Server Version : 50703 (5.7.3-m13)
 Source Host           : localhost:3306
 Source Schema         : news_manager

 Target Server Type    : MySQL
 Target Server Version : 50703 (5.7.3-m13)
 File Encoding         : 65001

 Date: 22/06/2025 00:19:05
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户地址',
  `user_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户电话号码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 22223 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (1, '123', '123123', NULL, NULL, '');
INSERT INTO `admin` VALUES (2, 'Zhao', '123123', NULL, '广州市', '');
INSERT INTO `admin` VALUES (11111, 'MJ', '123123', 'sssloveArzu@.com', '上海', '123123123');
INSERT INTO `admin` VALUES (22222, 'Arzu', '123123', 'sssloveMj@example.com', '上海市浦东新区', '13612225678');

-- ----------------------------
-- Table structure for cart
-- ----------------------------
DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `product_id` bigint(20) NOT NULL COMMENT '商品ID',
  `quantity` int(11) NOT NULL DEFAULT 1 COMMENT '数量',
  `created_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_user_product`(`user_id`, `product_id`) USING BTREE COMMENT '用户商品唯一'
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '购物车' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of cart
-- ----------------------------
INSERT INTO `cart` VALUES (2, 22222, 14001, 1, '2025-06-15 23:42:44');
INSERT INTO `cart` VALUES (3, 22222, 12223, 1, '2025-06-19 16:08:13');

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '分类名称',
  `parent_id` bigint(20) NULL DEFAULT NULL COMMENT '父分类ID',
  `level` int(11) NULL DEFAULT 1 COMMENT '分类层级',
  `sort_order` int(11) NULL DEFAULT 0 COMMENT '排序权重',
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '分类图标',
  `is_nav` tinyint(1) NULL DEFAULT 0 COMMENT '是否在导航栏显示',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_parent_id`(`parent_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12202 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '商品分类表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES (12200, '杀戮系列', NULL, 1, 0, NULL, 1, '2025-06-13 10:52:07', '2025-06-13 10:52:07');
INSERT INTO `category` VALUES (12201, '', NULL, 1, 0, NULL, 0, '2025-06-13 13:11:48', '2025-06-13 13:11:48');

-- ----------------------------
-- Table structure for favorite
-- ----------------------------
DROP TABLE IF EXISTS `favorite`;
CREATE TABLE `favorite`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `product_id` bigint(20) NOT NULL,
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_user_product`(`user_id`, `product_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of favorite
-- ----------------------------
INSERT INTO `favorite` VALUES (4, 11111, 11006, '2025-05-27 00:25:02');

-- ----------------------------
-- Table structure for hot_news
-- ----------------------------
DROP TABLE IF EXISTS `hot_news`;
CREATE TABLE `hot_news`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '资讯标题',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '资讯描述',
  `image_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '图片URL',
  `link` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '跳转链接',
  `is_active` tinyint(1) NULL DEFAULT 1 COMMENT '是否激活',
  `sort_order` int(11) NULL DEFAULT 0 COMMENT '排序权重',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '热点资讯表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of hot_news
-- ----------------------------
INSERT INTO `hot_news` VALUES (1, '更大更强的贝姬夫人！', NULL, 'image/BJFR.jpg', 'http://localhost:5173/adthr', 1, 1, '2025-06-06 21:54:02', '2025-06-21 22:05:05');
INSERT INTO `hot_news` VALUES (2, '蛊惑人心组合！！', NULL, 'image/gongxi.jpg', 'https://example.com/news2', 1, 1, '2025-06-06 22:21:38', '2025-06-07 00:37:25');
INSERT INTO `hot_news` VALUES (3, '马衔？为什么会在你的嘴里！?', NULL, 'image/N1.JPG', 'http://localhost:5173/adone', 1, 1, '2025-06-06 22:10:48', '2025-06-21 22:04:43');
INSERT INTO `hot_news` VALUES (4, '吾王啊，我为您带来了…荆棘戒指！', NULL, 'image/JJJZ.jpg', 'http://localhost:5173/adtwo', 1, 0, '2025-06-07 12:36:40', '2025-06-21 22:04:57');

-- ----------------------------
-- Table structure for order_detail
-- ----------------------------
DROP TABLE IF EXISTS `order_detail`;
CREATE TABLE `order_detail`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `total_amount` decimal(10, 2) NOT NULL,
  `status` tinyint(4) NULL DEFAULT 0 COMMENT '0-待支付 1-已支付 2-已发货 3-已完成 4-已取消',
  `address` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `receiver_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '收件人姓名',
  `receiver_phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '收件人联系方式',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of order_detail
-- ----------------------------
INSERT INTO `order_detail` VALUES ('1927019450098434049', 22222, 160.00, 1, '', '2025-05-26 23:10:14', '2025-05-27 01:11:13', '', '');
INSERT INTO `order_detail` VALUES ('1927284648977825794', 22222, 120.00, 1, '', '2025-05-27 16:44:02', '2025-05-27 18:34:31', '', '');
INSERT INTO `order_detail` VALUES ('1927381209023963137', 22222, 80.00, 0, '上海市浦东新区', '2025-05-27 23:07:44', '2025-05-27 23:07:44', '', '');
INSERT INTO `order_detail` VALUES ('1927914880042684417', 22222, 320.00, 1, '上海市浦东新区', '2025-05-29 10:28:21', '2025-05-29 10:28:24', '', '');
INSERT INTO `order_detail` VALUES ('1927920452230074370', 22222, 80.00, 0, '上海市浦东新区', '2025-05-29 10:50:30', '2025-05-29 10:50:30', '', '');
INSERT INTO `order_detail` VALUES ('1927921630485565442', 22222, 80.00, 1, '上海市浦东新区', '2025-05-29 10:55:10', '2025-05-29 10:55:12', '', '');
INSERT INTO `order_detail` VALUES ('1928102712061349889', 22222, 240.00, 1, '上海市浦东新区', '2025-05-29 22:54:44', '2025-05-29 22:54:46', '', '');
INSERT INTO `order_detail` VALUES ('1931986986451746818', 22222, 800.00, 1, '上海市浦东新区', '2025-06-09 16:09:27', '2025-06-09 16:09:29', '', '');
INSERT INTO `order_detail` VALUES ('1934942469122899970', 22222, 800.00, 0, '北京市朝阳区某某路100号', '2025-06-17 19:53:29', '2025-06-17 19:53:29', '', '');
INSERT INTO `order_detail` VALUES ('1934985529139531778', 22222, 1600.00, 0, '北京市朝阳区某某路100号', '2025-06-17 22:44:35', '2025-06-17 22:44:35', '奈费勒', '13800138000');
INSERT INTO `order_detail` VALUES ('1936108233490055169', 22222, 2400.00, 0, '北京市朝阳区某某路100号', '2025-06-21 01:05:49', '2025-06-21 01:05:49', '奈费勒', '13800138000');
INSERT INTO `order_detail` VALUES ('1936112136508104705', 22222, 4800.00, 0, 'aaa', '2025-06-21 01:21:19', '2025-06-21 01:21:19', '奈费勒', '184388');

-- ----------------------------
-- Table structure for order_item
-- ----------------------------
DROP TABLE IF EXISTS `order_item`;
CREATE TABLE `order_item`  (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `order_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` decimal(10, 2) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of order_item
-- ----------------------------
INSERT INTO `order_item` VALUES ('1927921630485565443', '1927921630485565442', 11006, 1, 80.00);
INSERT INTO `order_item` VALUES ('1928102712128458753', '1928102712061349889', 11006, 3, 80.00);
INSERT INTO `order_item` VALUES ('1931986986518855681', '1931986986451746818', 11006, 1, 800.00);
INSERT INTO `order_item` VALUES ('1934942469122899971', '1934942469122899970', 13222, 1, 800.00);
INSERT INTO `order_item` VALUES ('1934985529177280513', '1934985529139531778', 12222, 2, 800.00);
INSERT INTO `order_item` VALUES ('1936108233540386817', '1936108233490055169', 12222, 2, 800.00);
INSERT INTO `order_item` VALUES ('1936108233624272898', '1936108233490055169', 11006, 1, 800.00);
INSERT INTO `order_item` VALUES ('1936112136575213569', '1936112136508104705', 12223, 1, 1200.00);
INSERT INTO `order_item` VALUES ('1936112136709431297', '1936112136508104705', 14001, 2, 1800.00);

-- ----------------------------
-- Table structure for product
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `price` decimal(10, 2) NOT NULL,
  `stock` int(11) NOT NULL DEFAULT 0,
  `category_id` int(11) NULL DEFAULT NULL,
  `image_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `status` tinyint(4) NULL DEFAULT 1 COMMENT '1-上架 0-下架',
  `create_time` datetime NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14002 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of product
-- ----------------------------
INSERT INTO `product` VALUES (10032, '夹在书中的字条', '石品级 上面写着一处颇为偏僻的可疑地址……', 50.00, 11, 4, 'image/ZT.png', 1, '2025-06-22 00:09:10', NULL);
INSERT INTO `product` VALUES (11006, '幸福感', '铜品级 你知道的，幸福感不应该是商品，对吧', 800.00, 9, 3, 'image/XFG.png', 1, '2025-05-27 00:24:18', NULL);
INSERT INTO `product` VALUES (11007, '一大捧花束', '在这里，盛放的新鲜花朵本身就是金钱和权势的代名词。', 150.00, 5, 3, 'image/YDPHS.png', 1, NULL, NULL);
INSERT INTO `product` VALUES (12222, '银杀戮', '银品级', 800.00, 10, 2, 'image/Ysl.png', 1, '2025-05-22 16:00:23', NULL);
INSERT INTO `product` VALUES (12223, '金杀戮', '金品级', 1200.00, 9, 1, 'image/Jsl.png', 1, '2025-05-24 15:11:58', NULL);
INSERT INTO `product` VALUES (13222, '银纵欲', '银品级', 800.00, 10, 2, 'image/Yzy.png', 1, '2025-05-24 15:13:38', NULL);
INSERT INTO `product` VALUES (14001, '弑君的计划', '金品级', 1800.00, 9, 1, 'image/SJDJH.png', 1, '2025-05-26 23:55:03', NULL);

SET FOREIGN_KEY_CHECKS = 1;
