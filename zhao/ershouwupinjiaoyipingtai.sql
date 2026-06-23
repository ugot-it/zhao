/*
 Navicat Premium Data Transfer

 Source Server         : keshe
 Source Server Type    : MySQL
 Source Server Version : 80400 (8.4.0)
 Source Host           : localhost:3306
 Source Schema         : ershouwupinjiaoyipingtai

 Target Server Type    : MySQL
 Target Server Version : 80400 (8.4.0)
 File Encoding         : 65001

 Date: 20/06/2026 17:40:32
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for address
-- ----------------------------
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键 ',
  `yonghu_id` int NOT NULL COMMENT '创建用户',
  `address_name` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '收货人 ',
  `address_phone` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '电话 ',
  `address_dizhi` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '地址 ',
  `isdefault_types` int NOT NULL COMMENT '是否默认地址 ',
  `insert_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间 show3',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '收货地址' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of address
-- ----------------------------
INSERT INTO `address` VALUES (1, 1, '收货人1', '17703786901', '地址1', 1, '2023-03-23 16:07:36', '2023-03-23 16:07:36', '2023-03-23 16:07:36');
INSERT INTO `address` VALUES (3, 3, '收货人3', '17703786903', '地址3', 1, '2023-03-23 16:07:36', '2023-03-23 16:07:36', '2023-03-23 16:07:36');
INSERT INTO `address` VALUES (5, 3, '收货人5', '17703786905', '地址5', 1, '2023-03-23 16:07:36', '2023-03-23 16:07:36', '2023-03-23 16:07:36');
INSERT INTO `address` VALUES (7, 3, '收货人7', '17703786907', '地址7', 1, '2023-03-23 16:07:36', '2023-03-23 16:07:36', '2023-03-23 16:07:36');
INSERT INTO `address` VALUES (9, 3, '收货人9', '17703786909', '地址9', 1, '2023-03-23 16:07:36', '2023-03-23 16:07:36', '2023-03-23 16:07:36');
INSERT INTO `address` VALUES (11, 3, '收货人11', '17703786911', '地址11', 1, '2023-03-23 16:07:36', '2023-03-23 16:07:36', '2023-03-23 16:07:36');
INSERT INTO `address` VALUES (12, 2, '收货人12', '17703786912', '地址12', 1, '2023-03-23 16:07:36', '2023-03-23 16:07:36', '2023-03-23 16:07:36');
INSERT INTO `address` VALUES (14, 3, '收货人14', '17703786914', '地址14', 1, '2023-03-23 16:07:36', '2023-03-23 16:07:36', '2023-03-23 16:07:36');
INSERT INTO `address` VALUES (15, 1, '小黄', '15260525428', '广软', 2, '2026-06-14 21:18:30', '2026-06-14 21:18:29', '2026-06-14 21:18:30');

-- ----------------------------
-- Table structure for cart
-- ----------------------------
DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `yonghu_id` int NULL DEFAULT NULL COMMENT '所属用户',
  `shangpin_id` int NULL DEFAULT NULL COMMENT '商品',
  `buy_number` int NULL DEFAULT NULL COMMENT '购买数量',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '添加时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `insert_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '购物车' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cart
-- ----------------------------
INSERT INTO `cart` VALUES (3, 1, 3, 1, '2026-06-14 20:10:54', '2026-06-14 20:11:04', '2026-06-14 20:10:54');

-- ----------------------------
-- Table structure for config
-- ----------------------------
DROP TABLE IF EXISTS `config`;
CREATE TABLE `config`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '配置参数名称',
  `value` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '配置参数值',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '配置文件' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of config
-- ----------------------------
INSERT INTO `config` VALUES (1, '轮播图1', 'upload/lunbo1.jpg');
INSERT INTO `config` VALUES (2, '轮播图2', 'upload/lunbo2.jpg');
INSERT INTO `config` VALUES (3, '轮播图3', 'upload/lunbo3.jpg');

-- ----------------------------
-- Table structure for dictionary
-- ----------------------------
DROP TABLE IF EXISTS `dictionary`;
CREATE TABLE `dictionary`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `dic_code` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '字段',
  `dic_name` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '字段名',
  `code_index` int NULL DEFAULT NULL COMMENT '编码',
  `index_name` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '编码名字  Search111 ',
  `super_id` int NULL DEFAULT NULL COMMENT '父字段id',
  `beizhu` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '字典' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of dictionary
-- ----------------------------
INSERT INTO `dictionary` VALUES (1, 'sex_types', '性别类型', 1, '男', NULL, NULL, '2023-03-23 16:06:57');
INSERT INTO `dictionary` VALUES (2, 'sex_types', '性别类型', 2, '女', NULL, NULL, '2023-03-23 16:06:57');
INSERT INTO `dictionary` VALUES (3, 'gonggao_types', '公告类型', 1, '公告类型1', NULL, NULL, '2023-03-23 16:06:57');
INSERT INTO `dictionary` VALUES (4, 'gonggao_types', '公告类型', 2, '公告类型2', NULL, NULL, '2023-03-23 16:06:57');
INSERT INTO `dictionary` VALUES (5, 'shangjia_xingji_types', '商家信用类型', 1, '一级', NULL, NULL, '2023-03-23 16:06:57');
INSERT INTO `dictionary` VALUES (6, 'shangjia_xingji_types', '商家信用类型', 2, '二级', NULL, NULL, '2023-03-23 16:06:57');
INSERT INTO `dictionary` VALUES (7, 'shangjia_xingji_types', '商家信用类型', 3, '三级', NULL, NULL, '2023-03-23 16:06:57');
INSERT INTO `dictionary` VALUES (8, 'shangpin_types', '商品类型', 1, '商品类型1', NULL, NULL, '2023-03-23 16:06:57');
INSERT INTO `dictionary` VALUES (9, 'shangpin_types', '商品类型', 2, '商品类型2', NULL, NULL, '2023-03-23 16:06:57');
INSERT INTO `dictionary` VALUES (10, 'shangpin_types', '商品类型', 3, '商品类型3', NULL, NULL, '2023-03-23 16:06:57');
INSERT INTO `dictionary` VALUES (11, 'shangpin_types', '商品类型', 4, '商品类型4', NULL, NULL, '2023-03-23 16:06:57');
INSERT INTO `dictionary` VALUES (12, 'isdefault_types', '是否默认地址', 1, '否', NULL, NULL, '2023-03-23 16:06:57');
INSERT INTO `dictionary` VALUES (13, 'isdefault_types', '是否默认地址', 2, '是', NULL, NULL, '2023-03-23 16:06:57');
INSERT INTO `dictionary` VALUES (14, 'shangpin_chat_types', '数据类型', 1, '问题', NULL, NULL, '2023-03-23 16:06:57');
INSERT INTO `dictionary` VALUES (15, 'shangpin_chat_types', '数据类型', 2, '回复', NULL, NULL, '2023-03-23 16:06:57');
INSERT INTO `dictionary` VALUES (16, 'zhuangtai_types', '状态', 1, '未回复', NULL, NULL, '2023-03-23 16:06:57');
INSERT INTO `dictionary` VALUES (17, 'zhuangtai_types', '状态', 2, '已回复', NULL, NULL, '2023-03-23 16:06:57');
INSERT INTO `dictionary` VALUES (18, 'shangpin_collection_types', '收藏表类型', 1, '收藏', NULL, NULL, '2023-03-23 16:06:57');
INSERT INTO `dictionary` VALUES (19, 'shangpin_order_types', '订单类型', 101, '已支付', NULL, NULL, '2023-03-23 16:06:57');
INSERT INTO `dictionary` VALUES (20, 'shangpin_order_types', '订单类型', 102, '已退款', NULL, NULL, '2023-03-23 16:06:57');
INSERT INTO `dictionary` VALUES (21, 'shangpin_order_types', '订单类型', 103, '已发货', NULL, NULL, '2023-03-23 16:06:57');
INSERT INTO `dictionary` VALUES (22, 'shangpin_order_types', '订单类型', 104, '已收货', NULL, NULL, '2023-03-23 16:06:57');
INSERT INTO `dictionary` VALUES (23, 'shangpin_order_types', '订单类型', 105, '已评价', NULL, NULL, '2023-03-23 16:06:57');

-- ----------------------------
-- Table structure for gonggao
-- ----------------------------
DROP TABLE IF EXISTS `gonggao`;
CREATE TABLE `gonggao`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键 ',
  `gonggao_name` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '公告名称 Search111  ',
  `gonggao_photo` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '公告图片 ',
  `gonggao_types` int NOT NULL COMMENT '公告类型 Search111 ',
  `insert_time` timestamp NULL DEFAULT NULL COMMENT '公告发布时间 ',
  `gonggao_content` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '公告详情 ',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间 show1 show2 nameShow',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '公告' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of gonggao
-- ----------------------------
INSERT INTO `gonggao` VALUES (1, '公告1', 'upload/gg1.jpg', 1, '2026-06-19 16:36:28', '快递', '2026-06-19 16:36:33');
INSERT INTO `gonggao` VALUES (2, '公告2', 'upload/gg2.jpg', 1, '2026-06-19 16:37:53', '降价', '2026-06-19 16:37:57');
INSERT INTO `gonggao` VALUES (3, '公告3', 'upload/gg3.jpg', 1, '2026-06-19 16:41:57', '公告', '2026-06-19 16:42:16');
INSERT INTO `gonggao` VALUES (4, '公告4', 'upload/gg4.jpg', 1, '2026-06-19 16:42:00', '闲置轻松卖，二手放心买', '2026-06-19 16:42:20');
INSERT INTO `gonggao` VALUES (5, '公告5', 'upload/gg5.jpg', 2, '2026-06-19 16:42:02', '卖的省心，买的放心', '2026-06-19 16:42:23');
INSERT INTO `gonggao` VALUES (6, '公告6', 'upload/gg6.jpg', 1, '2026-06-19 16:42:05', '二手交易平台', '2026-06-19 16:42:26');
INSERT INTO `gonggao` VALUES (7, '公告7', 'upload/gg7.jpg', 1, '2026-06-19 16:42:08', '闲鱼平台', '2026-06-19 16:42:29');

-- ----------------------------
-- Table structure for shangjia
-- ----------------------------
DROP TABLE IF EXISTS `shangjia`;
CREATE TABLE `shangjia`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键 ',
  `username` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '账户 ',
  `password` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '密码 ',
  `shangjia_name` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '商家名称 Search111 ',
  `shangjia_phone` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '联系方式',
  `shangjia_email` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `shangjia_photo` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '营业执照展示 ',
  `shangjia_xingji_types` int NULL DEFAULT NULL COMMENT '商家信用类型',
  `new_money` decimal(10, 2) NULL DEFAULT NULL COMMENT '现有余额',
  `shangjia_content` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '商家介绍 ',
  `shangjia_delete` int NULL DEFAULT NULL COMMENT '逻辑删除',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间 show1 show2 photoShow ',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '商家' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of shangjia
-- ----------------------------
INSERT INTO `shangjia` VALUES (1, '123', '123456', 'c', '13562481265', '54654@qq.com', 'upload/A.jpg', 1, 463.12, 'A商家', 1, '2026-06-19 17:01:14');
INSERT INTO `shangjia` VALUES (2, 'a', '123456', 'a', '586387387', '45687@qq.com', 'upload/B.jpg', 1, 74385.00, 'B商家', 1, '2026-06-19 17:03:20');
INSERT INTO `shangjia` VALUES (3, 'b', '123456', 'b', '8767387383', '546553@qq.com', 'upload/C.jpg', 2, 48573.00, 'C商家', 1, '2026-06-19 17:03:22');

-- ----------------------------
-- Table structure for shangpin
-- ----------------------------
DROP TABLE IF EXISTS `shangpin`;
CREATE TABLE `shangpin`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键 ',
  `shangjia_id` int NULL DEFAULT NULL COMMENT '商家',
  `shangpin_name` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '商品名称  Search111 ',
  `shangpin_uuid_number` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '商品编号',
  `shangpin_photo` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '商品照片',
  `shangpin_types` int NULL DEFAULT NULL COMMENT '商品类型 Search111',
  `shangpin_kucun_number` int NULL DEFAULT NULL COMMENT '商品库存',
  `shangpin_new_money` decimal(10, 2) NULL DEFAULT NULL COMMENT '金额 ',
  `shangpin_clicknum` int NULL DEFAULT NULL COMMENT '商品热度',
  `shangpin_content` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '商品介绍 ',
  `shangpin_delete` int NULL DEFAULT NULL COMMENT '逻辑删除',
  `insert_time` timestamp NULL DEFAULT NULL COMMENT '录入时间',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间  show1 show2 photoShow',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '商品' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of shangpin
-- ----------------------------
INSERT INTO `shangpin` VALUES (1, 2, '商品名称1', '1679558856753', 'upload/sp1.jpg', 1, 101, 475.63, 104, '商品介绍1', 1, '2023-03-23 16:07:36', '2023-03-23 16:07:36');
INSERT INTO `shangpin` VALUES (2, 2, '商品名称2', '1679558856727', 'upload/sp2.jpg', 1, 102, 321.34, 181, '商品介绍2', 1, '2023-03-23 16:07:36', '2023-03-23 16:07:36');
INSERT INTO `shangpin` VALUES (3, 3, '商品名称3', '1679558856799', 'upload/sp3.jpg', 4, 103, 36.08, 405, '商品介绍3', 1, '2023-03-23 16:07:36', '2023-03-23 16:07:36');
INSERT INTO `shangpin` VALUES (4, 3, '商品名称4', '1679558856784', 'upload/sp4.jpg', 2, 104, 136.40, 482, '商品介绍4', 1, '2023-03-23 16:07:36', '2023-03-23 16:07:36');
INSERT INTO `shangpin` VALUES (5, 3, '商品名称5', '1679558856762', 'upload/sp5.jpg', 3, 105, 357.65, 361, '商品介绍5', 1, '2023-03-23 16:07:36', '2023-03-23 16:07:36');
INSERT INTO `shangpin` VALUES (6, 3, '商品名称6', '1679558856787', 'upload/sp6.jpg', 4, 106, 191.31, 281, '商品介绍6', 1, '2023-03-23 16:07:36', '2023-03-23 16:07:36');
INSERT INTO `shangpin` VALUES (7, 1, '商品名称7', '1679558856775', 'upload/sp7.jpg', 3, 107, 434.11, 271, '商品介绍7', 1, '2023-03-23 16:07:36', '2023-03-23 16:07:36');
INSERT INTO `shangpin` VALUES (8, 2, '商品名称8', '1679558856806', 'upload/sp8.jpg', 4, 107, 145.20, 405, '商品介绍8', 1, '2023-03-23 16:07:36', '2023-03-23 16:07:36');
INSERT INTO `shangpin` VALUES (9, 1, '商品名称9', '1679558856769', 'upload/sp9.jpg', 3, 107, 87.04, 264, '商品介绍9', 1, '2023-03-23 16:07:36', '2023-03-23 16:07:36');
INSERT INTO `shangpin` VALUES (10, 2, '商品名称10', '1679558856756', 'upload/sp10.jpg', 2, 1010, 257.70, 53, '商品介绍10', 1, '2023-03-23 16:07:36', '2023-03-23 16:07:36');
INSERT INTO `shangpin` VALUES (11, 2, '商品名称11', '1679558856797', 'upload/sp11.jpg', 4, 1011, 52.89, 177, '商品介绍11', 1, '2023-03-23 16:07:36', '2023-03-23 16:07:36');
INSERT INTO `shangpin` VALUES (12, 2, '商品名称12', '1679558856773', 'upload/sp12.jpg', 2, 1012, 71.55, 318, '商品介绍12', 1, '2023-03-23 16:07:36', '2023-03-23 16:07:36');
INSERT INTO `shangpin` VALUES (13, 3, '商品名称13', '1679558856730', 'upload/sp13.jpg', 3, 1013, 473.88, 279, '商品介绍13', 1, '2023-03-23 16:07:36', '2023-03-23 16:07:36');
INSERT INTO `shangpin` VALUES (14, 1, '商品名称14', '1679558856783', 'upload/sp14.jpg', 3, 1014, 338.87, 103, '商品介绍14', 1, '2023-03-23 16:07:36', '2023-03-23 16:07:36');

-- ----------------------------
-- Table structure for shangpin_chat
-- ----------------------------
DROP TABLE IF EXISTS `shangpin_chat`;
CREATE TABLE `shangpin_chat`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `yonghu_id` int NULL DEFAULT NULL COMMENT '提问人',
  `shangjia_id` int NULL DEFAULT NULL COMMENT '回答人',
  `shangpin_chat_issue_text` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '问题',
  `shangpin_chat_issue_photo` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '问题图片 ',
  `issue_time` timestamp NULL DEFAULT NULL COMMENT '问题时间',
  `shangpin_chat_reply_text` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '回复',
  `shangpin_chat_reply_photo` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '回复图片 ',
  `reply_time` timestamp NULL DEFAULT NULL COMMENT '回复时间',
  `zhuangtai_types` int NULL DEFAULT NULL COMMENT '状态',
  `shangpin_chat_types` int NULL DEFAULT NULL COMMENT '数据类型',
  `insert_time` timestamp NULL DEFAULT NULL COMMENT '提问时间',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '用户咨询' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of shangpin_chat
-- ----------------------------
INSERT INTO `shangpin_chat` VALUES (1, 2, 3, '问题1', 'upload/shangpin_chat_issue1.jpg', '2023-03-23 16:07:36', '回复1', 'upload/shangpin_chat_reply1.jpg', '2023-03-23 16:07:36', 2, 2, '2023-03-23 16:07:36', '2023-03-23 16:07:36');
INSERT INTO `shangpin_chat` VALUES (2, 1, 1, '问题2', 'upload/shangpin_chat_issue2.jpg', '2023-03-23 16:07:36', '回复2', 'upload/shangpin_chat_reply2.jpg', '2023-03-23 16:07:36', 2, 1, '2023-03-23 16:07:36', '2023-03-23 16:07:36');
INSERT INTO `shangpin_chat` VALUES (3, 3, 2, '问题3', 'upload/shangpin_chat_issue3.jpg', '2023-03-23 16:07:36', '回复3', 'upload/shangpin_chat_reply3.jpg', '2023-03-23 16:07:36', 2, 1, '2023-03-23 16:07:36', '2023-03-23 16:07:36');
INSERT INTO `shangpin_chat` VALUES (4, 1, 2, '问题4', 'upload/shangpin_chat_issue4.jpg', '2023-03-23 16:07:36', '回复4', 'upload/shangpin_chat_reply4.jpg', '2023-03-23 16:07:36', 1, 2, '2023-03-23 16:07:36', '2023-03-23 16:07:36');
INSERT INTO `shangpin_chat` VALUES (5, 1, 1, '问题5', 'upload/shangpin_chat_issue5.jpg', '2023-03-23 16:07:36', '回复5', 'upload/shangpin_chat_reply5.jpg', '2023-03-23 16:07:36', 2, 1, '2023-03-23 16:07:36', '2023-03-23 16:07:36');
INSERT INTO `shangpin_chat` VALUES (6, 1, 1, '问题6', 'upload/shangpin_chat_issue6.jpg', '2023-03-23 16:07:36', '回复6', 'upload/shangpin_chat_reply6.jpg', '2023-03-23 16:07:36', 1, 2, '2023-03-23 16:07:36', '2023-03-23 16:07:36');
INSERT INTO `shangpin_chat` VALUES (7, 2, 1, '问题7', 'upload/shangpin_chat_issue7.jpg', '2023-03-23 16:07:36', '回复7', 'upload/shangpin_chat_reply7.jpg', '2023-03-23 16:07:36', 1, 2, '2023-03-23 16:07:36', '2023-03-23 16:07:36');
INSERT INTO `shangpin_chat` VALUES (8, 3, 3, '问题8', 'upload/shangpin_chat_issue8.jpg', '2023-03-23 16:07:36', '回复8', 'upload/shangpin_chat_reply8.jpg', '2023-03-23 16:07:36', 1, 2, '2023-03-23 16:07:36', '2023-03-23 16:07:36');
INSERT INTO `shangpin_chat` VALUES (9, 2, 3, '问题9', 'upload/shangpin_chat_issue9.jpg', '2023-03-23 16:07:36', '回复9', 'upload/shangpin_chat_reply9.jpg', '2023-03-23 16:07:36', 1, 2, '2023-03-23 16:07:36', '2023-03-23 16:07:36');
INSERT INTO `shangpin_chat` VALUES (10, 2, 1, '问题10', 'upload/shangpin_chat_issue10.jpg', '2023-03-23 16:07:36', '回复10', 'upload/shangpin_chat_reply10.jpg', '2023-03-23 16:07:36', 2, 2, '2023-03-23 16:07:36', '2023-03-23 16:07:36');
INSERT INTO `shangpin_chat` VALUES (11, 2, 1, '问题11', 'upload/shangpin_chat_issue11.jpg', '2023-03-23 16:07:36', '回复11', 'upload/shangpin_chat_reply11.jpg', '2023-03-23 16:07:36', 1, 1, '2023-03-23 16:07:36', '2023-03-23 16:07:36');
INSERT INTO `shangpin_chat` VALUES (12, 3, 1, '问题12', 'upload/shangpin_chat_issue12.jpg', '2023-03-23 16:07:36', '回复12', 'upload/shangpin_chat_reply12.jpg', '2023-03-23 16:07:36', 1, 2, '2023-03-23 16:07:36', '2023-03-23 16:07:36');
INSERT INTO `shangpin_chat` VALUES (13, 1, 2, '问题13', 'upload/shangpin_chat_issue13.jpg', '2023-03-23 16:07:36', '回复13', 'upload/shangpin_chat_reply13.jpg', '2023-03-23 16:07:36', 1, 2, '2023-03-23 16:07:36', '2023-03-23 16:07:36');
INSERT INTO `shangpin_chat` VALUES (14, 2, 2, '问题14', 'upload/shangpin_chat_issue14.jpg', '2023-03-23 16:07:36', '回复14', 'upload/shangpin_chat_reply14.jpg', '2023-03-23 16:07:36', 2, 1, '2023-03-23 16:07:36', '2023-03-23 16:07:36');
INSERT INTO `shangpin_chat` VALUES (15, 1, 1, '126156', NULL, '2023-03-23 16:17:12', NULL, NULL, NULL, 2, 1, '2023-03-23 16:17:13', '2023-03-23 16:17:13');
INSERT INTO `shangpin_chat` VALUES (16, 1, 1, NULL, NULL, NULL, '666', NULL, '2023-03-23 16:17:24', NULL, 2, '2023-03-23 16:17:24', '2023-03-23 16:17:24');
INSERT INTO `shangpin_chat` VALUES (17, 1, 1, '亚压实度', NULL, '2023-03-24 10:12:16', NULL, NULL, NULL, 2, 1, '2023-03-24 10:12:17', '2023-03-24 10:12:17');
INSERT INTO `shangpin_chat` VALUES (18, 1, 1, NULL, NULL, NULL, '不算大大', NULL, '2023-03-24 10:14:27', NULL, 2, '2023-03-24 10:14:27', '2023-03-24 10:14:27');
INSERT INTO `shangpin_chat` VALUES (19, 2, NULL, NULL, NULL, NULL, '已按时发货', NULL, '2026-06-20 16:30:23', NULL, 2, '2026-06-20 16:30:23', '2026-06-20 16:30:23');

-- ----------------------------
-- Table structure for shangpin_collection
-- ----------------------------
DROP TABLE IF EXISTS `shangpin_collection`;
CREATE TABLE `shangpin_collection`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `shangpin_id` int NULL DEFAULT NULL COMMENT '商品',
  `yonghu_id` int NULL DEFAULT NULL COMMENT '用户',
  `shangpin_collection_types` int NULL DEFAULT NULL COMMENT '类型',
  `insert_time` timestamp NULL DEFAULT NULL COMMENT '收藏时间',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间 show3 photoShow',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '商品收藏' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of shangpin_collection
-- ----------------------------
INSERT INTO `shangpin_collection` VALUES (1, 1, 2, 1, '2023-03-23 16:07:36', '2023-03-23 16:07:36');
INSERT INTO `shangpin_collection` VALUES (2, 2, 1, 1, '2023-03-23 16:07:36', '2023-03-23 16:07:36');
INSERT INTO `shangpin_collection` VALUES (4, 4, 1, 1, '2023-03-23 16:07:36', '2023-03-23 16:07:36');
INSERT INTO `shangpin_collection` VALUES (5, 5, 1, 1, '2023-03-23 16:07:36', '2023-03-23 16:07:36');
INSERT INTO `shangpin_collection` VALUES (6, 6, 3, 1, '2023-03-23 16:07:36', '2023-03-23 16:07:36');
INSERT INTO `shangpin_collection` VALUES (7, 7, 1, 1, '2023-03-23 16:07:36', '2023-03-23 16:07:36');
INSERT INTO `shangpin_collection` VALUES (8, 8, 2, 1, '2023-03-23 16:07:36', '2023-03-23 16:07:36');
INSERT INTO `shangpin_collection` VALUES (9, 9, 2, 1, '2023-03-23 16:07:36', '2023-03-23 16:07:36');
INSERT INTO `shangpin_collection` VALUES (10, 10, 1, 1, '2023-03-23 16:07:36', '2023-03-23 16:07:36');
INSERT INTO `shangpin_collection` VALUES (11, 11, 1, 1, '2023-03-23 16:07:36', '2023-03-23 16:07:36');
INSERT INTO `shangpin_collection` VALUES (12, 12, 1, 1, '2023-03-23 16:07:36', '2023-03-23 16:07:36');
INSERT INTO `shangpin_collection` VALUES (13, 13, 3, 1, '2023-03-23 16:07:36', '2023-03-23 16:07:36');
INSERT INTO `shangpin_collection` VALUES (14, 14, 1, 1, '2023-03-23 16:07:36', '2023-03-23 16:07:36');
INSERT INTO `shangpin_collection` VALUES (15, 9, 1, 1, '2023-03-24 10:11:56', '2023-03-24 10:11:56');
INSERT INTO `shangpin_collection` VALUES (16, 3, 1, 1, '2026-06-14 20:59:38', '2026-06-14 20:59:38');

-- ----------------------------
-- Table structure for shangpin_commentback
-- ----------------------------
DROP TABLE IF EXISTS `shangpin_commentback`;
CREATE TABLE `shangpin_commentback`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `shangpin_id` int NULL DEFAULT NULL COMMENT '商品',
  `yonghu_id` int NULL DEFAULT NULL COMMENT '用户',
  `shangpin_commentback_text` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '评价内容',
  `insert_time` timestamp NULL DEFAULT NULL COMMENT '评价时间',
  `reply_text` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '回复内容',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '回复时间',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '商品评价' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of shangpin_commentback
-- ----------------------------
INSERT INTO `shangpin_commentback` VALUES (1, 1, 1, '评价内容1', '2023-03-23 16:07:36', '回复信息1', '2023-03-23 16:07:36', '2023-03-23 16:07:36');
INSERT INTO `shangpin_commentback` VALUES (2, 2, 1, '评价内容2', '2023-03-23 16:07:36', '回复信息2', '2023-03-23 16:07:36', '2023-03-23 16:07:36');
INSERT INTO `shangpin_commentback` VALUES (3, 3, 3, '评价内容3', '2023-03-23 16:07:36', '回复信息3', '2023-03-23 16:07:36', '2023-03-23 16:07:36');
INSERT INTO `shangpin_commentback` VALUES (4, 4, 1, '评价内容4', '2023-03-23 16:07:36', '回复信息4', '2023-03-23 16:07:36', '2023-03-23 16:07:36');
INSERT INTO `shangpin_commentback` VALUES (5, 5, 3, '评价内容5', '2023-03-23 16:07:36', '回复信息5', '2023-03-23 16:07:36', '2023-03-23 16:07:36');
INSERT INTO `shangpin_commentback` VALUES (6, 6, 1, '评价内容6', '2023-03-23 16:07:36', '回复信息6', '2023-03-23 16:07:36', '2023-03-23 16:07:36');
INSERT INTO `shangpin_commentback` VALUES (7, 7, 1, '评价内容7', '2023-03-23 16:07:36', '回复信息7', '2023-03-23 16:07:36', '2023-03-23 16:07:36');
INSERT INTO `shangpin_commentback` VALUES (8, 8, 3, '评价内容8', '2023-03-23 16:07:36', '回复信息8', '2023-03-23 16:07:36', '2023-03-23 16:07:36');
INSERT INTO `shangpin_commentback` VALUES (9, 9, 2, '评价内容9', '2023-03-23 16:07:36', '回复信息9', '2023-03-23 16:07:36', '2023-03-23 16:07:36');
INSERT INTO `shangpin_commentback` VALUES (10, 10, 2, '评价内容10', '2023-03-23 16:07:36', '回复信息10', '2023-03-23 16:07:36', '2023-03-23 16:07:36');
INSERT INTO `shangpin_commentback` VALUES (11, 11, 3, '评价内容11', '2023-03-23 16:07:36', '回复信息11', '2023-03-23 16:07:36', '2023-03-23 16:07:36');
INSERT INTO `shangpin_commentback` VALUES (12, 12, 3, '评价内容12', '2023-03-23 16:07:36', '回复信息12', '2023-03-23 16:07:36', '2023-03-23 16:07:36');
INSERT INTO `shangpin_commentback` VALUES (13, 13, 2, '评价内容13', '2023-03-23 16:07:36', '回复信息13', '2023-03-23 16:07:36', '2023-03-23 16:07:36');
INSERT INTO `shangpin_commentback` VALUES (14, 14, 3, '评价内容14', '2023-03-23 16:07:36', '回复信息14', '2023-03-23 16:07:36', '2023-03-23 16:07:36');
INSERT INTO `shangpin_commentback` VALUES (15, 9, 1, '不是', '2023-03-24 10:14:09', '好的', '2023-03-24 10:14:17', '2023-03-24 10:14:09');
INSERT INTO `shangpin_commentback` VALUES (16, 8, 1, '很好用', '2026-06-14 21:36:07', NULL, NULL, '2026-06-14 21:36:07');

-- ----------------------------
-- Table structure for shangpin_order
-- ----------------------------
DROP TABLE IF EXISTS `shangpin_order`;
CREATE TABLE `shangpin_order`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `shangpin_order_uuid_number` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '订单编号 Search111 ',
  `address_id` int NULL DEFAULT NULL COMMENT '收货地址 ',
  `shangpin_id` int NULL DEFAULT NULL COMMENT '商品',
  `yonghu_id` int NULL DEFAULT NULL COMMENT '用户',
  `buy_number` int NULL DEFAULT NULL COMMENT '购买数量',
  `shangpin_order_true_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '实付价格',
  `shangpin_order_courier_name` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '快递公司',
  `shangpin_order_courier_number` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '快递单号',
  `shangpin_order_types` int NULL DEFAULT NULL COMMENT '订单类型 Search111 ',
  `insert_time` timestamp NULL DEFAULT NULL COMMENT '订单创建时间',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间 show3 listShow',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '商品订单' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of shangpin_order
-- ----------------------------
INSERT INTO `shangpin_order` VALUES (1, '1679623947195', 1, 9, 1, 1, 87.04, NULL, NULL, 102, '2023-03-24 10:12:27', '2023-03-24 10:12:27');
INSERT INTO `shangpin_order` VALUES (2, '1679623970357', 1, 9, 1, 2, 174.08, '321', '1032132231', 105, '2023-03-24 10:12:50', '2023-03-24 10:12:50');
INSERT INTO `shangpin_order` VALUES (3, '1781443005551', 1, 8, 1, 1, 145.20, '圆通', '1234', 105, '2026-06-14 21:16:46', '2026-06-14 21:16:46');
INSERT INTO `shangpin_order` VALUES (4, '1781443238071', 15, 7, 1, 1, 434.11, NULL, NULL, 102, '2026-06-14 21:20:38', '2026-06-14 21:20:38');

-- ----------------------------
-- Table structure for token
-- ----------------------------
DROP TABLE IF EXISTS `token`;
CREATE TABLE `token`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `userid` bigint NOT NULL COMMENT '儿童id',
  `username` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '儿童名',
  `tablename` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '表名',
  `role` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '角色',
  `token` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '密码',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `expiratedtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '过期时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = 'token表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of token
-- ----------------------------
INSERT INTO `token` VALUES (1, 1, 'a1', 'yonghu', '用户', 'fls6t3siobmhgidrbal8ggzt9lv0le75', '2023-03-23 16:10:14', '2026-06-19 17:34:31');
INSERT INTO `token` VALUES (2, 1, 'admin', 'users', '管理员', 'ujhxxtf4645cgsbp4v6r1278a9gnfvkr', '2023-03-23 16:14:10', '2026-06-20 17:26:09');
INSERT INTO `token` VALUES (3, 1, 'a1', 'shangjia', '商家', 'ccigiqedxmb6gquof08t5nzosjilgr81', '2023-03-23 16:16:34', '2026-06-18 16:28:09');
INSERT INTO `token` VALUES (4, 2, 'a2', 'shangjia', '商家', '1ig4wnpgo8rc6jkt3sls5fj96045k9nu', '2026-06-14 21:25:00', '2026-06-14 22:37:12');
INSERT INTO `token` VALUES (5, 3, 'a3', 'shangjia', '商家', 'hgfoc2ukw57tiza8vgdqfg0u704fb90n', '2026-06-14 21:25:38', '2026-06-14 22:25:39');
INSERT INTO `token` VALUES (6, 4, '111111', 'yonghu', '用户', 'wf2ju6nlcv3hq1uv3vlohs7pryicr08s', '2026-06-19 20:25:26', '2026-06-19 21:25:27');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `username` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '儿童名',
  `password` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '密码',
  `role` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '管理员' COMMENT '角色',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '管理员' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'admin', '21232f297a57a5a743894a0e4a801fc3', '管理员', '2023-03-23 16:06:57');

-- ----------------------------
-- Table structure for yonghu
-- ----------------------------
DROP TABLE IF EXISTS `yonghu`;
CREATE TABLE `yonghu`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `username` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '账户',
  `password` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '密码',
  `yonghu_name` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '用户姓名 Search111 ',
  `yonghu_phone` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '用户手机号',
  `yonghu_id_number` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '用户身份证号',
  `yonghu_photo` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '用户头像',
  `sex_types` int NULL DEFAULT NULL COMMENT '性别',
  `new_money` decimal(10, 2) NULL DEFAULT NULL COMMENT '余额 ',
  `yonghu_email` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '用户邮箱',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '用户' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of yonghu
-- ----------------------------
INSERT INTO `yonghu` VALUES (1, 'a1', 'e10adc3949ba59abbe56e057f20f883e', '用户姓名1', '17703786901', '410224199010102001', 'upload/yonghu1.jpg', 1, 587.94, '1@qq.com', '2023-03-23 16:07:36');
INSERT INTO `yonghu` VALUES (2, 'a2', 'e10adc3949ba59abbe56e057f20f883e', '用户姓名2', '17703786902', '410224199010102002', 'upload/yonghu2.jpg', 2, 219.76, '2@qq.com', '2023-03-23 16:07:36');
INSERT INTO `yonghu` VALUES (3, 'a3', 'e10adc3949ba59abbe56e057f20f883e', '用户姓名3', '17703786903', '410224199010102003', 'upload/yonghu3.jpg', 2, 761.45, '3@qq.com', '2023-03-23 16:07:36');
INSERT INTO `yonghu` VALUES (4, '111111', '96e79218965eb72c92a549dd5a330112', '040406', '13560476841', '442775522789531572', NULL, 2, 0.00, '28932014197@qq.com', '2026-06-19 20:25:22');

SET FOREIGN_KEY_CHECKS = 1;
