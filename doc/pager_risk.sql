/*
 Navicat Premium Data Transfer

 Source Server         : dev
 Source Server Type    : MySQL
 Source Server Version : 50724
 Source Host           : localhost
 Source Database       : pager_risk

 Target Server Type    : MySQL
 Target Server Version : 50724
 File Encoding         : utf-8

 Date: 05/31/2019 14:19:58 PM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `t_black_list`
-- ----------------------------
DROP TABLE IF EXISTS `t_black_list`;
CREATE TABLE `t_black_list` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `phone` varchar(11) DEFAULT NULL COMMENT '手机号',
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `delete_status` bit(1) DEFAULT NULL,
  `create_user` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='黑名单';

-- ----------------------------
--  Records of `t_black_list`
-- ----------------------------
BEGIN;
INSERT INTO `t_black_list` VALUES ('1', '13818578899', '2019-04-19 14:57:18', '2019-04-19 14:57:21', b'1', 'admin'), ('2', '3242423424', '2019-04-19 15:19:33', '2019-04-19 15:19:32', b'0', null), ('3', 'yghjhbjh', '2019-04-19 15:20:35', '2019-04-19 15:20:34', b'1', null), ('4', 'fdfsfsdfdsf', '2019-04-19 15:22:31', '2019-04-19 15:22:30', b'0', null), ('5', '3242343', '2019-04-19 15:26:11', '2019-04-19 15:26:10', b'0', 'admin'), ('6', null, '2019-04-19 15:28:25', '2019-04-19 15:28:25', b'0', 'admin'), ('7', null, '2019-04-19 15:29:21', '2019-04-19 15:29:21', b'0', 'admin'), ('8', null, '2019-04-19 15:29:53', '2019-04-19 15:29:52', b'0', 'admin'), ('9', null, '2019-04-19 15:30:32', '2019-04-19 15:30:31', b'0', 'admin');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
