/*
 Navicat Premium Data Transfer

 Source Server         : 本地
 Source Server Type    : MySQL
 Source Server Version : 50727
 Source Host           : localhost:3306
 Source Schema         : houses_lease_db

 Target Server Type    : MySQL
 Target Server Version : 50727
 File Encoding         : 65001

 Date: 10/02/2026 15:07:56
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for announcement
-- ----------------------------
DROP TABLE IF EXISTS `announcement`;
CREATE TABLE `announcement`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '公告标题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '公告内容',
  `admin_id` bigint(20) NOT NULL COMMENT '发布管理员ID',
  `status` tinyint(4) NULL DEFAULT 1 COMMENT '状态(0:下架,1:发布)',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '公告表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of announcement
-- ----------------------------
INSERT INTO `announcement` VALUES (2, '五月租房优惠活动', '五月租房优惠活动开始啦！新用户首次租房可享受9折优惠，活动时间：2025年5月15日-2025年5月31日。', 1, 1, '2025-11-15 09:30:00', '2025-11-15 09:30:00');
INSERT INTO `announcement` VALUES (3, '优惠好房', '优惠好房', 1, 1, '2026-02-06 21:47:27', '2026-02-06 21:47:27');

-- ----------------------------
-- Table structure for carousel
-- ----------------------------
DROP TABLE IF EXISTS `carousel`;
CREATE TABLE `carousel`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '轮播图ID',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '轮播图标题',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '轮播图描述',
  `image_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '图片URL',
  `link_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '链接URL',
  `status` tinyint(4) NULL DEFAULT 1 COMMENT '状态(0:禁用,1:启用)',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '轮播图表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of carousel
-- ----------------------------
INSERT INTO `carousel` VALUES (1, '寻找理想住所，开启美好生活', '我们提供各类优质房源，满足您的不同需求', '/img/1747466278007.jpeg', '/houses', 1, '2025-11-15 09:00:00', '2025-11-15 09:00:00');
INSERT INTO `carousel` VALUES (2, '安心租房，品质保障', '全部房源实名认证，真实可靠', '/img/1747466271575.jpeg', '/houses', 1, '2025-11-15 09:01:00', '2025-11-15 09:01:00');
INSERT INTO `carousel` VALUES (3, '便捷的租房流程', '在线预约看房，足不出户轻松租房', '/img/1747466264612.jpeg', '/houses', 1, '2025-11-15 09:02:00', '2025-11-15 09:02:00');

-- ----------------------------
-- Table structure for house
-- ----------------------------
DROP TABLE IF EXISTS `house`;
CREATE TABLE `house`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '房屋ID',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '房屋标题',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '房屋描述',
  `area` decimal(10, 2) NOT NULL COMMENT '面积(平方米)',
  `price` decimal(10, 2) NOT NULL COMMENT '价格(元/月)',
  `address` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '地址',
  `type_id` bigint(20) NOT NULL COMMENT '房屋类型ID',
  `landlord_id` bigint(20) NOT NULL COMMENT '房东ID',
  `status` tinyint(4) NULL DEFAULT 1 COMMENT '状态(0:下架,1:待出租,2:已出租)',
  `images` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '房屋图片(JSON格式)',
  `facilities` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '配套设施(JSON格式)',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_landlord`(`landlord_id`) USING BTREE,
  INDEX `idx_type`(`type_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 56 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '房屋信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of house
-- ----------------------------
INSERT INTO `house` VALUES (1, '市中心精装两室一厅', '位于市中心的精装两室一厅，交通便利，周边配套齐全，拎包入住。', 85.50, 3500.00, '北京市朝阳区建国路88号', 1, 2, 2, '[\"/img/1747462284644.jpg\",\"/img/1747462286822.jpg\",\"/img/1747462294409.jpg\"]', '{\"wifi\":true,\"elevator\":true,\"airConditioner\":true,\"washer\":true,\"refrigerator\":true,\"television\":true,\"waterHeater\":true}', '2025-11-15 10:20:00', '2025-11-17 14:11:36');
INSERT INTO `house` VALUES (2, '地铁口温馨单间', '紧邻地铁口的温馨单间，家具齐全，适合单身人士居住。', 30.00, 1800.00, '北京市海淀区中关村大街1号', 2, 2, 2, '[\"/img/1747462267665.jpg\",\"/img/1747462268824.jpg\"]', '{\"wifi\":true,\"elevator\":true,\"airConditioner\":true,\"washer\":true,\"refrigerator\":true,\"television\":false,\"waterHeater\":true}', '2025-11-15 10:21:00', '2025-11-17 14:11:10');
INSERT INTO `house` VALUES (3, '花园小区三室两厅', '位于花园小区的三室两厅，环境优美，适合家庭居住。', 120.00, 5000.00, '北京市丰台区丰台路66号', 1, 3, 2, '[\"/img/1747462229576.jpg\",\"/img/1747462233802.jpg\"]', '{\"wifi\":true,\"elevator\":true,\"airConditioner\":true,\"washer\":true,\"refrigerator\":true,\"television\":true,\"waterHeater\":true}', '2025-11-15 10:22:00', '2025-11-17 14:10:38');
INSERT INTO `house` VALUES (4, '大学旁合租单间', '位于大学旁的合租单间，安静舒适，适合学生。', 15.00, 1200.00, '北京市海淀区清华东路16号', 2, 3, 1, '[\"/img/1747462213715.jpg\",\"/img/1747462215787.jpg\"]', '{\"wifi\":true,\"elevator\":false,\"airConditioner\":true,\"washer\":true,\"refrigerator\":true,\"television\":false,\"waterHeater\":true}', '2025-11-15 10:23:00', '2025-11-17 14:10:17');
INSERT INTO `house` VALUES (5, '商圈精装一居室', '位于繁华商圈的精装一居室，生活便利，拎包入住。', 55.00, 2800.00, '北京市朝阳区三里屯路10号', 1, 2, 2, '[\"/img/1747462198453.jpg\",\"/img/1747462201040.jpg\",\"/img/1747462203472.jpg\"]', '{\"wifi\":true,\"elevator\":true,\"airConditioner\":true,\"washer\":false,\"refrigerator\":true,\"television\":true,\"waterHeater\":true}', '2025-11-15 10:24:00', '2025-11-17 14:10:05');
INSERT INTO `house` VALUES (6, '温馨小户型', '适合单身或情侣，生活便利。', 35.00, 2000.00, '北京市朝阳区幸福路1号', 2, 2, 2, '[\"/img/1.jpg\"]', '{\"wifi\":true,\"elevator\":true,\"airConditioner\":true,\"washer\":true,\"refrigerator\":true,\"television\":false,\"waterHeater\":true}', '2025-11-17 12:35:42', '2026-01-29 21:02:47');
INSERT INTO `house` VALUES (7, '精装三居室', '宽敞明亮，适合家庭居住。', 110.00, 4800.00, '北京市海淀区知春路8号', 1, 3, 2, '[\"/img/2.jpg\"]', '{\"wifi\":true,\"elevator\":true,\"airConditioner\":true,\"washer\":true,\"refrigerator\":true,\"television\":true,\"waterHeater\":true}', '2025-11-17 12:35:42', '2026-01-29 21:02:57');
INSERT INTO `house` VALUES (8, '地铁旁一居', '交通便利，拎包入住。', 45.00, 2600.00, '北京市丰台区南苑路12号', 1, 2, 2, '[\"/img/3.jpg\"]', '{\"wifi\":true,\"elevator\":false,\"airConditioner\":true,\"washer\":true,\"refrigerator\":true,\"television\":false,\"waterHeater\":true}', '2025-11-17 12:35:42', '2026-01-29 21:03:04');
INSERT INTO `house` VALUES (9, '阳光两室一厅', '南北通透，采光好。', 80.00, 3500.00, '北京市朝阳区望京西路20号', 1, 3, 2, '[\"/img/4.jpg\"]', '{\"wifi\":true,\"elevator\":true,\"airConditioner\":true,\"washer\":true,\"refrigerator\":true,\"television\":true,\"waterHeater\":true}', '2025-11-17 12:35:42', '2026-01-29 21:11:53');
INSERT INTO `house` VALUES (10, '经济合租房', '价格实惠，适合上班族。', 20.00, 1200.00, '北京市昌平区回龙观东大街5号', 2, 2, 1, '[\"/img/5.jpg\"]', '{\"wifi\":true,\"elevator\":false,\"airConditioner\":true,\"washer\":true,\"refrigerator\":false,\"television\":false,\"waterHeater\":true}', '2025-11-17 12:35:42', '2026-01-29 21:12:04');
INSERT INTO `house` VALUES (11, '高层景观房', '视野开阔，环境优美。', 90.00, 4000.00, '北京市石景山区八角北路3号', 1, 3, 2, '[\"/img/6.jpg\"]', '{\"wifi\":true,\"elevator\":true,\"airConditioner\":true,\"washer\":true,\"refrigerator\":true,\"television\":true,\"waterHeater\":true}', '2025-11-17 12:35:42', '2026-01-29 21:12:15');
INSERT INTO `house` VALUES (12, '温馨合租单间', '合租单间，安静舒适。', 18.00, 1100.00, '北京市通州区梨园路9号', 2, 2, 1, '[\"/img/7.jpg\"]', '{\"wifi\":true,\"elevator\":false,\"airConditioner\":true,\"washer\":true,\"refrigerator\":true,\"television\":false,\"waterHeater\":true}', '2025-11-17 12:35:42', '2026-01-29 21:12:24');
INSERT INTO `house` VALUES (13, '精致一居', '精致装修，拎包入住。', 40.00, 2300.00, '北京市朝阳区建国门外大街6号', 1, 3, 2, '[\"/img/8.jpg\"]', '{\"wifi\":true,\"elevator\":true,\"airConditioner\":true,\"washer\":true,\"refrigerator\":true,\"television\":true,\"waterHeater\":true}', '2025-11-17 12:35:42', '2026-02-06 21:45:06');
INSERT INTO `house` VALUES (14, '地铁口合租', '交通便利，生活方便。', 22.00, 1300.00, '北京市海淀区西二旗大街7号', 2, 2, 2, '[\"/img/9.jpg\"]', '{\"wifi\":true,\"elevator\":false,\"airConditioner\":true,\"washer\":true,\"refrigerator\":false,\"television\":false,\"waterHeater\":true}', '2025-11-17 12:35:42', '2026-01-29 21:12:54');
INSERT INTO `house` VALUES (15, '舒适两居', '适合小家庭，环境安静。', 70.00, 3200.00, '北京市丰台区南三环西路15号', 1, 3, 1, '[\"/img/1.jpg\"]', '{\"wifi\":true,\"elevator\":true,\"airConditioner\":true,\"washer\":true,\"refrigerator\":true,\"television\":true,\"waterHeater\":true}', '2025-11-17 12:35:42', '2026-01-29 21:18:25');
INSERT INTO `house` VALUES (16, '大学城单间', '适合学生，安静舒适。', 16.00, 1000.00, '北京市海淀区学院路30号', 2, 2, 1, '[\"/img/2.jpg\"]', '{\"wifi\":true,\"elevator\":false,\"airConditioner\":true,\"washer\":true,\"refrigerator\":false,\"television\":false,\"waterHeater\":true}', '2025-11-17 12:35:42', '2026-01-29 21:18:25');
INSERT INTO `house` VALUES (17, '豪华四居室', '高档小区，适合大家庭。', 150.00, 6500.00, '北京市朝阳区东三环中路18号', 1, 3, 2, '[\"/img/3.jpg\"]', '{\"wifi\":true,\"elevator\":true,\"airConditioner\":true,\"washer\":true,\"refrigerator\":true,\"television\":true,\"waterHeater\":true}', '2025-11-17 12:35:42', '2026-01-29 21:18:25');
INSERT INTO `house` VALUES (18, '便捷单身公寓', '地铁沿线，上班方便。', 28.00, 1800.00, '北京市大兴区亦庄经济开发区12号', 1, 2, 1, '[\"/img/4.jpg\"]', '{\"wifi\":true,\"elevator\":true,\"airConditioner\":true,\"washer\":true,\"refrigerator\":true,\"television\":false,\"waterHeater\":true}', '2025-11-17 12:35:42', '2026-01-29 21:18:25');
INSERT INTO `house` VALUES (19, '阳光三居室', '南北通透，采光极好。', 120.00, 5200.00, '北京市海淀区中关村南大街25号', 1, 3, 1, '[\"/img/5.jpg\"]', '{\"wifi\":true,\"elevator\":true,\"airConditioner\":true,\"washer\":true,\"refrigerator\":true,\"television\":true,\"waterHeater\":true}', '2025-11-17 12:35:42', '2026-01-29 21:18:25');
INSERT INTO `house` VALUES (20, '经济合租间', '价格实惠，适合打工族。', 15.00, 900.00, '北京市通州区运河西大街11号', 2, 2, 2, '[\"/img/6.jpg\"]', '{\"wifi\":true,\"elevator\":false,\"airConditioner\":false,\"washer\":true,\"refrigerator\":true,\"television\":false,\"waterHeater\":true}', '2025-11-17 12:35:42', '2026-01-29 21:18:25');
INSERT INTO `house` VALUES (21, '商圈精装两居', '商业区中心，生活便利。', 85.00, 3800.00, '北京市朝阳区国贸桥东22号', 1, 3, 1, '[\"/img/7.jpg\"]', '{\"wifi\":true,\"elevator\":true,\"airConditioner\":true,\"washer\":true,\"refrigerator\":true,\"television\":true,\"waterHeater\":true}', '2025-11-17 12:35:42', '2026-01-29 21:18:25');
INSERT INTO `house` VALUES (22, '花园小区单间', '环境优美，安静舒适。', 20.00, 1300.00, '北京市丰台区花园路8号', 2, 2, 1, '[\"/img/8.jpg\"]', '{\"wifi\":true,\"elevator\":false,\"airConditioner\":true,\"washer\":true,\"refrigerator\":false,\"television\":false,\"waterHeater\":true}', '2025-11-17 12:35:42', '2026-01-29 21:18:25');
INSERT INTO `house` VALUES (23, '高档一居室', '精装修，拎包入住。', 50.00, 2800.00, '北京市西城区西直门外大街9号', 1, 3, 2, '[\"/img/9.jpg\"]', '{\"wifi\":true,\"elevator\":true,\"airConditioner\":true,\"washer\":true,\"refrigerator\":true,\"television\":true,\"waterHeater\":true}', '2025-11-17 12:35:42', '2026-01-29 21:18:25');
INSERT INTO `house` VALUES (24, '地铁口两居', '交通便利，适合上班族。', 75.00, 3300.00, '北京市朝阳区东四环北路16号', 1, 2, 1, '[\"/img/1.jpg\"]', '{\"wifi\":true,\"elevator\":true,\"airConditioner\":true,\"washer\":true,\"refrigerator\":true,\"television\":true,\"waterHeater\":true}', '2025-11-17 12:35:42', '2026-01-29 21:18:32');
INSERT INTO `house` VALUES (25, '经济单间', '价格实惠，基础设施齐全。', 18.00, 1100.00, '北京市昌平区天通苑北一区5号', 2, 3, 1, '[\"/img/2.jpg\"]', '{\"wifi\":true,\"elevator\":false,\"airConditioner\":false,\"washer\":true,\"refrigerator\":true,\"television\":false,\"waterHeater\":true}', '2025-11-17 12:35:42', '2026-01-29 21:18:32');
INSERT INTO `house` VALUES (26, '大学旁两居室', '适合教职工或研究生，环境安静。', 80.00, 3500.00, '北京市海淀区清华东路16号', 1, 2, 2, '[\"/img/3.jpg\"]', '{\"wifi\":true,\"elevator\":true,\"airConditioner\":true,\"washer\":true,\"refrigerator\":true,\"television\":true,\"waterHeater\":true}', '2025-11-17 12:35:42', '2026-01-29 21:18:32');
INSERT INTO `house` VALUES (27, '商务区单身公寓', '商务区中心，适合商务人士。', 45.00, 2600.00, '北京市朝阳区建国门外大街1号', 1, 3, 1, '[\"/img/4.jpg\"]', '{\"wifi\":true,\"elevator\":true,\"airConditioner\":true,\"washer\":true,\"refrigerator\":true,\"television\":true,\"waterHeater\":true}', '2025-11-17 12:35:42', '2026-01-29 21:18:32');
INSERT INTO `house` VALUES (28, '经济合租房间', '价格实惠，适合年轻人。', 16.00, 950.00, '北京市丰台区丰台南路7号', 2, 2, 1, '[\"/img/5.jpg\"]', '{\"wifi\":true,\"elevator\":false,\"airConditioner\":false,\"washer\":true,\"refrigerator\":true,\"television\":false,\"waterHeater\":true}', '2025-11-17 12:35:42', '2026-01-29 21:18:32');
INSERT INTO `house` VALUES (29, '豪华三居室', '高档小区，环境优美。', 130.00, 5800.00, '北京市西城区德胜门外大街15号', 1, 3, 2, '[\"/img/6.jpg\"]', '{\"wifi\":true,\"elevator\":true,\"airConditioner\":true,\"washer\":true,\"refrigerator\":true,\"television\":true,\"waterHeater\":true}', '2025-11-17 12:35:42', '2026-01-29 21:18:32');
INSERT INTO `house` VALUES (30, '地铁旁单间', '交通便利，上班方便。', 20.00, 1200.00, '北京市通州区通州北苑10号', 2, 2, 1, '[\"/img/7.jpg\"]', '{\"wifi\":true,\"elevator\":false,\"airConditioner\":true,\"washer\":true,\"refrigerator\":false,\"television\":false,\"waterHeater\":true}', '2025-11-17 12:35:42', '2026-01-29 21:18:32');
INSERT INTO `house` VALUES (31, '精装修两居', '精致装修，拎包入住。', 85.00, 3800.00, '北京市朝阳区双井桥东3号', 1, 3, 1, '[\"/img/8.jpg\"]', '{\"wifi\":true,\"elevator\":true,\"airConditioner\":true,\"washer\":true,\"refrigerator\":true,\"television\":true,\"waterHeater\":true}', '2025-11-17 12:35:42', '2026-01-29 21:18:32');
INSERT INTO `house` VALUES (32, '大学城合租', '适合学生，价格实惠。', 18.00, 1000.00, '北京市海淀区北四环西路68号', 2, 2, 2, '[\"/img/9.jpg\"]', '{\"wifi\":true,\"elevator\":false,\"airConditioner\":true,\"washer\":true,\"refrigerator\":true,\"television\":false,\"waterHeater\":true}', '2025-11-17 12:35:42', '2026-01-29 21:18:32');
INSERT INTO `house` VALUES (33, '阳光一居室', '采光好，温馨舒适。', 48.00, 2500.00, '北京市石景山区鲁谷路15号', 1, 3, 1, '[\"/img/default.jpeg\"]', '{\"wifi\":true,\"elevator\":true,\"airConditioner\":true,\"washer\":true,\"refrigerator\":true,\"television\":true,\"waterHeater\":true}', '2025-11-17 12:35:42', '2025-11-17 12:35:42');
INSERT INTO `house` VALUES (34, '经济型单间', '价格实惠，基础设施齐全。', 15.00, 900.00, '北京市大兴区黄村西大街8号', 2, 2, 1, '[\"/img/default.jpeg\"]', '{\"wifi\":true,\"elevator\":false,\"airConditioner\":false,\"washer\":true,\"refrigerator\":false,\"television\":false,\"waterHeater\":true}', '2025-11-17 12:35:42', '2025-11-17 12:35:42');
INSERT INTO `house` VALUES (35, '舒适三居室', '适合家庭，环境安静。', 110.00, 4600.00, '北京市海淀区上地十街1号', 1, 3, 2, '[\"/img/default.jpeg\"]', '{\"wifi\":true,\"elevator\":true,\"airConditioner\":true,\"washer\":true,\"refrigerator\":true,\"television\":true,\"waterHeater\":true}', '2025-11-17 12:35:42', '2025-11-17 12:35:42');
INSERT INTO `house` VALUES (36, '市中心单身公寓', '市中心地段，生活便利。', 40.00, 2400.00, '北京市东城区东直门内大街8号', 1, 2, 1, '[\"/img/default.jpeg\"]', '{\"wifi\":true,\"elevator\":true,\"airConditioner\":true,\"washer\":true,\"refrigerator\":true,\"television\":true,\"waterHeater\":true}', '2025-11-17 12:35:42', '2025-11-17 12:35:42');
INSERT INTO `house` VALUES (37, '花园小区合租', '环境优美，安静舒适。', 22.00, 1300.00, '北京市朝阳区望京花园5号', 2, 3, 2, '[\"/img/default.jpeg\"]', '{\"wifi\":true,\"elevator\":true,\"airConditioner\":true,\"washer\":true,\"refrigerator\":true,\"television\":false,\"waterHeater\":true}', '2025-11-17 12:35:42', '2025-11-17 12:35:42');
INSERT INTO `house` VALUES (38, '精装两室一厅', '精致装修，拎包入住。', 75.00, 3400.00, '北京市海淀区中关村南路12号', 1, 2, 1, '[\"/img/default.jpeg\"]', '{\"wifi\":true,\"elevator\":true,\"airConditioner\":true,\"washer\":true,\"refrigerator\":true,\"television\":true,\"waterHeater\":true}', '2025-11-17 12:35:42', '2025-11-17 12:35:42');
INSERT INTO `house` VALUES (39, '经济型合租房', '价格实惠，适合打工族。', 16.00, 950.00, '北京市丰台区花乡四里3号', 2, 3, 1, '[\"/img/default.jpeg\"]', '{\"wifi\":true,\"elevator\":false,\"airConditioner\":false,\"washer\":true,\"refrigerator\":true,\"television\":false,\"waterHeater\":true}', '2025-11-17 12:35:42', '2025-11-17 12:35:42');
INSERT INTO `house` VALUES (40, '豪华四室两厅', '高档小区，适合大家庭。', 160.00, 6800.00, '北京市西城区金融街7号', 1, 2, 2, '[\"/img/default.jpeg\"]', '{\"wifi\":true,\"elevator\":true,\"airConditioner\":true,\"washer\":true,\"refrigerator\":true,\"television\":true,\"waterHeater\":true}', '2025-11-17 12:35:42', '2025-11-17 12:35:42');
INSERT INTO `house` VALUES (41, '地铁旁小户型', '交通便利，上班方便。', 35.00, 2100.00, '北京市朝阳区大望路20号', 1, 3, 1, '[\"/img/default.jpeg\"]', '{\"wifi\":true,\"elevator\":true,\"airConditioner\":true,\"washer\":true,\"refrigerator\":true,\"television\":false,\"waterHeater\":true}', '2025-11-17 12:35:42', '2025-11-17 12:35:42');
INSERT INTO `house` VALUES (42, '大学城单人间', '适合学生，价格实惠。', 12.00, 800.00, '北京市海淀区学院南路15号', 2, 2, 1, '[\"/img/default.jpeg\"]', '{\"wifi\":true,\"elevator\":false,\"airConditioner\":false,\"washer\":true,\"refrigerator\":false,\"television\":false,\"waterHeater\":true}', '2025-11-17 12:35:42', '2025-11-17 12:35:42');
INSERT INTO `house` VALUES (43, '阳光三室两厅', '南北通透，采光极好。', 130.00, 5500.00, '北京市朝阳区亮马桥路8号', 1, 3, 2, '[\"/img/default.jpeg\"]', '{\"wifi\":true,\"elevator\":true,\"airConditioner\":true,\"washer\":true,\"refrigerator\":true,\"television\":true,\"waterHeater\":true}', '2025-11-17 12:35:42', '2025-11-17 12:35:42');
INSERT INTO `house` VALUES (44, '经济型小户型', '价格实惠，基础设施齐全。', 30.00, 1800.00, '北京市通州区通州北苑路18号', 1, 2, 1, '[\"/img/default.jpeg\"]', '{\"wifi\":true,\"elevator\":false,\"airConditioner\":true,\"washer\":true,\"refrigerator\":true,\"television\":false,\"waterHeater\":true}', '2025-11-17 12:35:42', '2025-11-17 12:35:42');
INSERT INTO `house` VALUES (45, '舒适两室一厅', '适合小家庭，环境安静。', 80.00, 3600.00, '北京市昌平区回龙观西大街9号', 1, 3, 1, '[\"/img/default.jpeg\"]', '{\"wifi\":true,\"elevator\":true,\"airConditioner\":true,\"washer\":true,\"refrigerator\":true,\"television\":true,\"waterHeater\":true}', '2025-11-17 12:35:42', '2025-11-17 12:35:42');
INSERT INTO `house` VALUES (46, '高层景观两居', '视野开阔，环境优美。', 85.00, 3900.00, '北京市石景山区古城大街5号', 1, 2, 2, '[\"/img/default.jpeg\"]', '{\"wifi\":true,\"elevator\":true,\"airConditioner\":true,\"washer\":true,\"refrigerator\":true,\"television\":true,\"waterHeater\":true}', '2025-11-17 12:35:42', '2025-11-17 12:35:42');
INSERT INTO `house` VALUES (47, '商务区精装单间', '商务区中心，适合商务人士。', 25.00, 1600.00, '北京市朝阳区建国门外大街8号', 2, 3, 1, '[\"/img/default.jpeg\"]', '{\"wifi\":true,\"elevator\":true,\"airConditioner\":true,\"washer\":true,\"refrigerator\":true,\"television\":false,\"waterHeater\":true}', '2025-11-17 12:35:42', '2025-11-17 12:35:42');
INSERT INTO `house` VALUES (48, '温馨一室一厅', '温馨舒适，拎包入住。', 50.00, 2700.00, '北京市海淀区中关村东路16号', 1, 2, 1, '[\"/img/default.jpeg\"]', '{\"wifi\":true,\"elevator\":true,\"airConditioner\":true,\"washer\":true,\"refrigerator\":true,\"television\":true,\"waterHeater\":true}', '2025-11-17 12:35:42', '2025-11-17 12:35:42');
INSERT INTO `house` VALUES (49, '经济合租单间', '价格实惠，适合年轻人。', 18.00, 1100.00, '北京市丰台区丰台北路12号', 2, 3, 2, '[\"/img/default.jpeg\"]', '{\"wifi\":true,\"elevator\":false,\"airConditioner\":true,\"washer\":true,\"refrigerator\":false,\"television\":false,\"waterHeater\":true}', '2025-11-17 12:35:42', '2025-11-17 12:35:42');
INSERT INTO `house` VALUES (50, '豪华复式公寓', '复式结构，空间宽敞。', 120.00, 5800.00, '北京市西城区西单北大街3号', 1, 2, 1, '[\"/img/default.jpeg\"]', '{\"wifi\":true,\"elevator\":true,\"airConditioner\":true,\"washer\":true,\"refrigerator\":true,\"television\":true,\"waterHeater\":true}', '2025-11-17 12:35:42', '2025-11-17 12:35:42');
INSERT INTO `house` VALUES (51, '地铁口小户型', '交通便利，上班方便。', 40.00, 2300.00, '北京市朝阳区广渠门外大街15号', 1, 3, 1, '[\"/img/default.jpeg\"]', '{\"wifi\":true,\"elevator\":true,\"airConditioner\":true,\"washer\":true,\"refrigerator\":true,\"television\":false,\"waterHeater\":true}', '2025-11-17 12:35:42', '2025-11-17 12:35:42');
INSERT INTO `house` VALUES (52, '大学附近合租', '适合学生，安静舒适。', 20.00, 1200.00, '北京市海淀区学院路25号', 2, 2, 2, '[\"/img/default.jpeg\"]', '{\"wifi\":true,\"elevator\":false,\"airConditioner\":true,\"washer\":true,\"refrigerator\":true,\"television\":false,\"waterHeater\":true}', '2025-11-17 12:35:42', '2025-11-17 12:35:42');
INSERT INTO `house` VALUES (53, '阳光四居室', '南北通透，适合大家庭。', 150.00, 6200.00, '北京市朝阳区东三环北路10号', 1, 3, 1, '[\"/img/default.jpeg\"]', '{\"wifi\":true,\"elevator\":true,\"airConditioner\":true,\"washer\":true,\"refrigerator\":true,\"television\":true,\"waterHeater\":true}', '2025-11-17 12:35:42', '2025-11-17 12:35:42');
INSERT INTO `house` VALUES (54, '经济型两居', '价格实惠，基础设施齐全。', 70.00, 3000.00, '北京市大兴区旧宫镇12号', 1, 2, 1, '[\"/img/default.jpeg\"]', '{\"wifi\":true,\"elevator\":true,\"airConditioner\":true,\"washer\":true,\"refrigerator\":true,\"television\":true,\"waterHeater\":true}', '2025-11-17 12:35:42', '2025-11-17 12:35:42');
INSERT INTO `house` VALUES (55, '舒适三室一厅', '适合家庭，环境安静。', 100.00, 4200.00, '北京市顺义区后沙峪镇8号', 1, 3, 2, '[\"/img/default.jpeg\"]', '{\"wifi\":true,\"elevator\":true,\"airConditioner\":true,\"washer\":true,\"refrigerator\":true,\"television\":true,\"waterHeater\":true}', '2025-11-17 12:35:42', '2025-11-17 12:35:42');

-- ----------------------------
-- Table structure for house_type
-- ----------------------------
DROP TABLE IF EXISTS `house_type`;
CREATE TABLE `house_type`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '类型ID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '类型名称(合租/整租)',
  `description` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '类型描述',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '房屋类型表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of house_type
-- ----------------------------
INSERT INTO `house_type` VALUES (1, '整租', '整套房屋出租，独立使用所有空间', '2025-11-15 10:10:00', '2025-11-15 10:10:00');
INSERT INTO `house_type` VALUES (2, '合租', '与他人合租房屋，共享部分公共空间', '2025-11-15 10:11:00', '2025-11-15 10:11:00');

-- ----------------------------
-- Table structure for lease_record
-- ----------------------------
DROP TABLE IF EXISTS `lease_record`;
CREATE TABLE `lease_record`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  `order_id` bigint(20) NOT NULL COMMENT '订单ID',
  `house_id` bigint(20) NOT NULL COMMENT '房屋ID',
  `tenant_id` bigint(20) NOT NULL COMMENT '租客ID',
  `landlord_id` bigint(20) NOT NULL COMMENT '房东ID',
  `start_date` date NOT NULL COMMENT '租期开始日期',
  `end_date` date NOT NULL COMMENT '租期结束日期',
  `rent_amount` decimal(10, 2) NOT NULL COMMENT '租金金额',
  `payment_cycle` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'MONTHLY' COMMENT '支付周期(MONTHLY/QUARTERLY/YEARLY)',
  `status` tinyint(4) NULL DEFAULT 1 COMMENT '状态(0:已取消,1:租赁中,2:已结束,3:已退租)',
  `actual_end_date` date NULL DEFAULT NULL COMMENT '实际结束日期',
  `contract_url` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '合同文件URL',
  `evaluation_score` int(11) NULL DEFAULT NULL COMMENT '评价分数(1-5)',
  `evaluation_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '评价内容',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_order`(`order_id`) USING BTREE,
  INDEX `idx_house`(`house_id`) USING BTREE,
  INDEX `idx_tenant`(`tenant_id`) USING BTREE,
  INDEX `idx_landlord`(`landlord_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '租赁记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of lease_record
-- ----------------------------
INSERT INTO `lease_record` VALUES (1, 1, 5, 4, 2, '2025-11-01', '2026-05-31', 2800.00, 'MONTHLY', 1, NULL, '/contract/contract_36d5224f84f048acbb4adb29a8e5fd7f.pdf', 5, '不错！', '2025-11-15 11:35:00', '2025-11-15 11:35:00');
INSERT INTO `lease_record` VALUES (2, 2, 2, 5, 2, '2025-11-17', '2026-05-17', 1800.00, 'MONTHLY', 1, NULL, '/contract/contract_f8eefa59a1a04619b4d7d22cb59de5b0.pdf', NULL, NULL, '2025-11-17 15:25:31', '2025-11-17 15:25:31');
INSERT INTO `lease_record` VALUES (3, 6, 3, 8, 3, '2025-11-17', '2026-06-17', 5000.00, 'MONTHLY', 1, NULL, '/contract/contract_068ed8717618413b8740717b4f026831.pdf', NULL, NULL, '2025-11-17 12:02:25', '2025-11-17 12:02:25');
INSERT INTO `lease_record` VALUES (4, 7, 9, 4, 3, '2025-10-07', '2026-10-07', 3500.00, 'MONTHLY', 1, NULL, '/contract/contract_53e278208d0e454eac066d5f504bca52.pdf', NULL, NULL, '2025-10-07 15:59:48', '2025-10-07 15:59:48');
INSERT INTO `lease_record` VALUES (5, 8, 6, 8, 2, '2025-12-17', '2026-12-17', 2000.00, 'MONTHLY', 1, NULL, '/contract/contract_46a0027b8f164f6fa2123a8f515bfd66.pdf', NULL, NULL, '2025-12-17 11:51:12', '2025-12-17 11:51:12');
INSERT INTO `lease_record` VALUES (6, 9, 7, 10, 3, '2026-01-30', '2027-01-30', 4800.00, 'MONTHLY', 1, NULL, '/contract/contract_99c71d279cc04be4b70ddfaef1889f3f.pdf', 5, '真不错', '2026-01-30 16:59:00', '2026-01-30 16:59:00');
INSERT INTO `lease_record` VALUES (7, 11, 13, 10, 3, '2026-02-06', '2027-02-06', 2300.00, 'MONTHLY', 1, NULL, '/contract/contract_e33404f7a996455c92fdec5e38576f13.pdf', NULL, NULL, '2026-02-06 21:45:47', '2026-02-06 21:45:47');

-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '订单ID',
  `order_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '订单编号',
  `house_id` bigint(20) NOT NULL COMMENT '房屋ID',
  `tenant_id` bigint(20) NOT NULL COMMENT '租客ID',
  `landlord_id` bigint(20) NOT NULL COMMENT '房东ID',
  `amount` decimal(10, 2) NOT NULL COMMENT '订单金额',
  `deposit` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '押金金额',
  `status` tinyint(4) NULL DEFAULT 0 COMMENT '状态(0:待支付,1:已支付待确认,2:已确认,3:已取消,4:已退款)',
  `payment_time` datetime NULL DEFAULT NULL COMMENT '支付时间',
  `payment_method` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '支付方式',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_order_no`(`order_no`) USING BTREE,
  INDEX `idx_house`(`house_id`) USING BTREE,
  INDEX `idx_tenant`(`tenant_id`) USING BTREE,
  INDEX `idx_landlord`(`landlord_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '订单表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of order
-- ----------------------------
INSERT INTO `order` VALUES (1, 'ORD202505150001', 5, 4, 2, 33600.00, 2800.00, 2, '2025-11-15 11:30:00', '支付宝', '2025-11-15 11:00:00', '2025-11-15 11:35:00');
INSERT INTO `order` VALUES (2, 'ORD202505150002', 2, 5, 2, 1800.00, 1800.00, 2, '2025-11-15 14:30:00', '微信支付', '2025-11-15 14:00:00', '2025-11-17 15:25:31');
INSERT INTO `order` VALUES (3, 'ORD202505150003', 1, 4, 2, 3500.00, 3500.00, 2, '2025-11-17 00:34:37', '支付宝', '2025-11-15 16:00:00', '2025-11-17 00:37:11');
INSERT INTO `order` VALUES (4, 'ORD174741285103394f1', 4, 4, 3, 1200.00, 1200.00, 4, '2025-11-17 00:34:30', '支付宝', '2025-11-17 00:27:31', '2025-11-17 00:34:34');
INSERT INTO `order` VALUES (5, 'ORD1747466667711aecd', 4, 4, 3, 1200.00, 1200.00, 1, '2025-11-17 15:24:37', '支付宝', '2025-11-17 15:24:28', '2025-11-17 15:24:37');
INSERT INTO `order` VALUES (6, 'ORD17501328914781657', 3, 8, 3, 5000.00, 5000.00, 2, '2025-11-17 12:01:36', '微信支付', '2025-11-17 12:01:31', '2025-11-17 12:02:24');
INSERT INTO `order` VALUES (7, 'ORD1759823919332eaf4', 9, 4, 3, 10500.00, 3500.00, 2, '2025-10-07 15:58:44', '微信支付', '2025-10-07 15:58:39', '2025-10-07 15:59:49');
INSERT INTO `order` VALUES (8, 'ORD1765943427856c225', 6, 8, 2, 2000.00, 2000.00, 2, '2025-12-17 11:50:40', '支付宝', '2025-12-17 11:50:28', '2025-12-17 11:51:10');
INSERT INTO `order` VALUES (9, 'ORD17697629870818dc4', 7, 10, 3, 4800.00, 4800.00, 2, '2026-01-30 16:49:59', '支付宝', '2026-01-30 16:49:47', '2026-01-30 16:59:00');
INSERT INTO `order` VALUES (10, 'ORD1770383820395829e', 10, 10, 2, 1200.00, 1200.00, 0, NULL, NULL, '2026-02-06 21:17:00', '2026-02-06 21:17:00');
INSERT INTO `order` VALUES (11, 'ORD17703854217776e0c', 13, 10, 3, 6900.00, 2300.00, 2, '2026-02-06 21:43:54', '微信支付', '2026-02-06 21:43:42', '2026-02-06 21:45:43');

-- ----------------------------
-- Table structure for transaction
-- ----------------------------
DROP TABLE IF EXISTS `transaction`;
CREATE TABLE `transaction`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '交易ID',
  `order_id` bigint(20) NOT NULL COMMENT '订单ID',
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `type` tinyint(4) NOT NULL COMMENT '类型(1:收入,2:支出)',
  `amount` decimal(10, 2) NOT NULL COMMENT '金额',
  `description` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '交易描述',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_order`(`order_id`) USING BTREE,
  INDEX `idx_user`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '交易记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of transaction
-- ----------------------------
INSERT INTO `transaction` VALUES (1, 1, 4, 2, 33600.00, '租金支付-商圈精装一居室-年付', '2025-11-15 11:30:00');
INSERT INTO `transaction` VALUES (2, 1, 2, 1, 33600.00, '租金收入-商圈精装一居室-年付', '2025-11-15 11:30:00');
INSERT INTO `transaction` VALUES (3, 2, 5, 2, 1800.00, '租金支付-地铁口温馨单间-月付', '2025-11-15 14:30:00');
INSERT INTO `transaction` VALUES (4, 2, 2, 1, 1800.00, '租金收入-地铁口温馨单间-月付', '2025-11-15 14:30:00');
INSERT INTO `transaction` VALUES (5, 4, 4, 2, 1200.00, '租金支付-订单号:ORD174741285103394f1', '2025-11-17 00:34:30');
INSERT INTO `transaction` VALUES (6, 4, 3, 1, 1200.00, '租金收入-订单号:ORD174741285103394f1', '2025-11-17 00:34:30');
INSERT INTO `transaction` VALUES (7, 4, 4, 1, 1200.00, '退款收入-订单号:ORD174741285103394f1', '2025-11-17 00:34:34');
INSERT INTO `transaction` VALUES (8, 4, 3, 2, 1200.00, '退款支出-订单号:ORD174741285103394f1', '2025-11-17 00:34:34');
INSERT INTO `transaction` VALUES (9, 3, 4, 2, 3500.00, '租金支付-订单号:ORD202505150003', '2025-11-17 00:34:37');
INSERT INTO `transaction` VALUES (10, 3, 2, 1, 3500.00, '租金收入-订单号:ORD202505150003', '2025-11-17 00:34:37');
INSERT INTO `transaction` VALUES (11, 5, 4, 2, 1200.00, '租金支付-订单号:ORD1747466667711aecd', '2025-11-17 15:24:37');
INSERT INTO `transaction` VALUES (12, 5, 3, 1, 1200.00, '租金收入-订单号:ORD1747466667711aecd', '2025-11-17 15:24:37');
INSERT INTO `transaction` VALUES (13, 6, 8, 2, 5000.00, '租金支付-订单号:ORD17501328914781657', '2025-11-17 12:01:36');
INSERT INTO `transaction` VALUES (14, 6, 3, 1, 5000.00, '租金收入-订单号:ORD17501328914781657', '2025-11-17 12:01:36');
INSERT INTO `transaction` VALUES (15, 7, 4, 2, 10500.00, '租金支付-订单号:ORD1759823919332eaf4', '2025-10-07 15:58:44');
INSERT INTO `transaction` VALUES (16, 7, 3, 1, 10500.00, '租金收入-订单号:ORD1759823919332eaf4', '2025-10-07 15:58:44');
INSERT INTO `transaction` VALUES (17, 8, 8, 2, 2000.00, '租金支付-订单号:ORD1765943427856c225', '2025-12-17 11:50:40');
INSERT INTO `transaction` VALUES (18, 8, 2, 1, 2000.00, '租金收入-订单号:ORD1765943427856c225', '2025-12-17 11:50:40');
INSERT INTO `transaction` VALUES (19, 9, 10, 2, 4800.00, '租金支付-订单号:ORD17697629870818dc4', '2026-01-30 16:49:59');
INSERT INTO `transaction` VALUES (20, 9, 3, 1, 4800.00, '租金收入-订单号:ORD17697629870818dc4', '2026-01-30 16:49:59');
INSERT INTO `transaction` VALUES (21, 11, 10, 2, 6900.00, '租金支付-订单号:ORD17703854217776e0c', '2026-02-06 21:43:54');
INSERT INTO `transaction` VALUES (22, 11, 3, 1, 6900.00, '租金收入-订单号:ORD17703854217776e0c', '2026-02-06 21:43:54');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户名',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '密码(加密存储)',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '邮箱',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '手机号',
  `role_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '角色code(ADMIN/LANDLORD/TENANT)',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '姓名',
  `avatar` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '头像',
  `status` tinyint(4) NULL DEFAULT 1 COMMENT '状态(0:禁用,1:正常)',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `sex` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '性别',
  `id_card` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '身份证号码',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_username`(`username`) USING BTREE,
  UNIQUE INDEX `uk_email`(`email`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'admin', '$2a$10$Yi3mVyRC7TrBaX5fg9Jz0uV68yitASYZKUJsfFw4ooXqohF.VqutO', 'admin@example.com', '13800138000', 'ADMIN', '管理员', '/img/1747460779427.png', 1, '2025-11-15 10:00:00', '2026-01-29 21:09:55', '男', '320851200504063951');
INSERT INTO `user` VALUES (2, 'landlord1', '$2a$10$iul6jocLsH.A4gN1QUpgDexDq6KO89syHjUkRD3NbA1L6CTVrNRMO', 'landlord1@example.com', '13800138001', 'LANDLORD', '张房东', '/img/1747463391377.jpg', 1, '2025-11-15 10:01:00', '2025-11-15 10:01:00', '男', '420851200504063952');
INSERT INTO `user` VALUES (3, 'landlord2', '$2a$10$Ymtik3WTqfTKhg/pQByF0.r0.rJ/LmgOXLwpnA7d8jcvvGx0LRubG', 'landlord2@example.com', '13800138888', 'LANDLORD', '李房东', '/img/1747463396621.jpg', 1, '2025-11-15 10:02:00', '2026-02-06 21:49:30', '女', '322851200001010101');
INSERT INTO `user` VALUES (4, 'tenant1', '$2a$10$iul6jocLsH.A4gN1QUpgDexDq6KO89syHjUkRD3NbA1L6CTVrNRMO', 'tenant1@example.com', '13800138003', 'TENANT', '王租客', '/img/1747463366220.jpg', 1, '2025-11-15 10:03:00', '2025-11-17 14:29:26', '男', '320850200104063551');
INSERT INTO `user` VALUES (5, 'tenant2', '$2a$10$iul6jocLsH.A4gN1QUpgDexDq6KO89syHjUkRD3NbA1L6CTVrNRMO', 'tenant2@example.com', '13800138004', 'TENANT', '赵租客', '/img/1747463406478.jpg', 1, '2025-11-15 10:04:00', '2025-11-15 10:04:00', '女', '320851199704063951');
INSERT INTO `user` VALUES (7, 'test', '$2a$10$85eQCoElUepP2aj4IBU4YePjB9WvfX3C16O1JPJzknuu6K5BFd0ZC', '123456789@qq.com', '13456789987', 'TENANT', 'test', NULL, 1, '2025-11-11 09:53:22', '2025-11-11 09:53:22', NULL, NULL);
INSERT INTO `user` VALUES (8, 'user1', '$2a$10$z/7iYO6YsUZRLSNvcYvwsuAeinCJW3SBhtTRti78v7eQrgVYVourm', '115151@qq.com', '13123456789', 'TENANT', 'test', NULL, 1, '2025-11-17 11:52:19', '2025-11-17 11:52:19', NULL, NULL);
INSERT INTO `user` VALUES (9, 'test000', '$2a$10$sthL52kleYzziLe6k2EK7OXuVe465pnQXTmG66Ui2Pju/Gkf1qese', '156165156@qq.com', '13123456789', 'TENANT', '111', NULL, 1, '2025-11-11 14:11:54', '2025-11-11 14:11:54', NULL, NULL);
INSERT INTO `user` VALUES (10, 'zhangsan', '$2a$10$Yi3mVyRC7TrBaX5fg9Jz0uV68yitASYZKUJsfFw4ooXqohF.VqutO', '9317@qq.com', '15755581410', 'TENANT', '张三', '/img/1770383903050.jpg', 1, '2026-01-29 21:09:29', '2026-02-06 21:18:25', '男', '');

SET FOREIGN_KEY_CHECKS = 1;
