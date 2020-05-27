/*
 Navicat Premium Data Transfer

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 50527
 Source Host           : localhost:3306
 Source Schema         : property

 Target Server Type    : MySQL
 Target Server Version : 50527
 File Encoding         : 65001

 Date: 21/04/2020 10:06:28
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for authority
-- ----------------------------
DROP TABLE IF EXISTS `authority`;
CREATE TABLE `authority`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `buttons` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `checked` int(11) DEFAULT NULL,
  `expanded` int(11) NOT NULL DEFAULT 0,
  `icon_cls` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `leaf` int(11) NOT NULL DEFAULT 0,
  `menu_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `menu_config` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `menu_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `parent_id` bigint(20) DEFAULT NULL,
  `sort_order` int(11) NOT NULL,
  `url` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 105 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of authority
-- ----------------------------
INSERT INTO `authority` VALUES (15, ' ', NULL, 1, ' ', 0, 'SystemManage', ' ', '系统管理', NULL, 400, ' ');
INSERT INTO `authority` VALUES (16, 'Add,Edit,Delete,View,Export,Query', NULL, 1, ' ', 1, 'UserManagement', ' ', '用户管理', 15, 4001, 'systemManage.UserManagement');
INSERT INTO `authority` VALUES (17, ' ', NULL, 1, ' ', 1, 'AuthorizationManagement', ' ', '权限管理', 15, 4002, 'systemManage.AuthorizationManagement');
INSERT INTO `authority` VALUES (19, 'Add,Edit,Delete,View', NULL, 1, ' ', 1, 'ResourceManagement', ' ', '资源管理', 15, 4004, 'systemManage.ResourceManagement');
INSERT INTO `authority` VALUES (70, ' ', NULL, 1, ' ', 0, 'HouseInfoManage', ' ', '通讯录管理', NULL, 600, ' ');
INSERT INTO `authority` VALUES (72, 'Add,Edit,Delete,View,Examine,Export', NULL, 1, ' ', 1, 'HouseTypeManage', ' ', '关系类型管理', 70, 6001, 'houseManage.HouseTypeManagement');
INSERT INTO `authority` VALUES (90, ' ', NULL, 1, ' ', 0, 'Report', ' ', '查询报表', NULL, 800, ' ');
INSERT INTO `authority` VALUES (91, 'Export,AllDeprtmentQuery', NULL, 1, ' ', 1, 'HouseManage', ' ', '通讯录查询', 90, 8002, 'houseManage.HouseQuery');
INSERT INTO `authority` VALUES (100, ' ', NULL, 1, ' ', 0, 'Report', ' ', '综合分析', NULL, 900, ' ');
INSERT INTO `authority` VALUES (102, '', NULL, 1, ' ', 1, 'HumidityReport', ' ', '图表量化分析', 100, 9002, 'report.HouseAreaZZReport');
INSERT INTO `authority` VALUES (104, 'Add,Edit,Delete,View,Export,Query', NULL, 1, ' ', 1, 'HouseManageInAllDepart', ' ', '通讯录管理', 70, 6003, 'houseManage.TelManagementInAll');

-- ----------------------------
-- Table structure for config
-- ----------------------------
DROP TABLE IF EXISTS `config`;
CREATE TABLE `config`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `config_type` smallint(6) NOT NULL,
  `config_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of config
-- ----------------------------
INSERT INTO `config` VALUES (2, 1, 6);

-- ----------------------------
-- Table structure for housetype
-- ----------------------------
DROP TABLE IF EXISTS `housetype`;
CREATE TABLE `housetype`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `houseTypeName` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '房屋类型',
  `houseTypeDesc` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '房屋描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of housetype
-- ----------------------------
INSERT INTO `housetype` VALUES (6, '家人', '我的家人');
INSERT INTO `housetype` VALUES (7, '小学同学', '小学同学');
INSERT INTO `housetype` VALUES (8, '初中同学', '初中同学');
INSERT INTO `housetype` VALUES (9, '高中同学', '高中同学');
INSERT INTO `housetype` VALUES (10, '大学同学', '大学同学');
INSERT INTO `housetype` VALUES (11, '其他', '其他');
INSERT INTO `housetype` VALUES (12, '同事', '同事');

-- ----------------------------
-- Table structure for role_authority
-- ----------------------------
DROP TABLE IF EXISTS `role_authority`;
CREATE TABLE `role_authority`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `authority_id` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `role` smallint(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3598 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of role_authority
-- ----------------------------
INSERT INTO `role_authority` VALUES (3499, '15', 1);
INSERT INTO `role_authority` VALUES (3500, '16', 1);
INSERT INTO `role_authority` VALUES (3501, '16Add', 1);
INSERT INTO `role_authority` VALUES (3502, '16Edit', 1);
INSERT INTO `role_authority` VALUES (3503, '16Delete', 1);
INSERT INTO `role_authority` VALUES (3504, '16View', 1);
INSERT INTO `role_authority` VALUES (3505, '16Export', 1);
INSERT INTO `role_authority` VALUES (3506, '16Query', 1);
INSERT INTO `role_authority` VALUES (3507, '17', 1);
INSERT INTO `role_authority` VALUES (3508, '19', 1);
INSERT INTO `role_authority` VALUES (3509, '19Add', 1);
INSERT INTO `role_authority` VALUES (3510, '19Edit', 1);
INSERT INTO `role_authority` VALUES (3511, '19Delete', 1);
INSERT INTO `role_authority` VALUES (3512, '19View', 1);
INSERT INTO `role_authority` VALUES (3513, '70', 1);
INSERT INTO `role_authority` VALUES (3514, '72', 1);
INSERT INTO `role_authority` VALUES (3515, '72Add', 1);
INSERT INTO `role_authority` VALUES (3516, '72Edit', 1);
INSERT INTO `role_authority` VALUES (3517, '72Delete', 1);
INSERT INTO `role_authority` VALUES (3518, '72View', 1);
INSERT INTO `role_authority` VALUES (3519, '72Examine', 1);
INSERT INTO `role_authority` VALUES (3520, '72Export', 1);
INSERT INTO `role_authority` VALUES (3529, '104', 1);
INSERT INTO `role_authority` VALUES (3530, '104Add', 1);
INSERT INTO `role_authority` VALUES (3531, '104Edit', 1);
INSERT INTO `role_authority` VALUES (3532, '104Delete', 1);
INSERT INTO `role_authority` VALUES (3533, '104View', 1);
INSERT INTO `role_authority` VALUES (3534, '104Examine', 1);
INSERT INTO `role_authority` VALUES (3535, '104Export', 1);
INSERT INTO `role_authority` VALUES (3536, '104Query', 1);
INSERT INTO `role_authority` VALUES (3537, '90', 1);
INSERT INTO `role_authority` VALUES (3538, '91', 1);
INSERT INTO `role_authority` VALUES (3539, '91Export', 1);
INSERT INTO `role_authority` VALUES (3540, '91AllDeprtmentQuery', 1);
INSERT INTO `role_authority` VALUES (3541, '100', 1);
INSERT INTO `role_authority` VALUES (3543, '102', 1);
INSERT INTO `role_authority` VALUES (3580, '70', 2);
INSERT INTO `role_authority` VALUES (3581, '72', 2);
INSERT INTO `role_authority` VALUES (3582, '72Add', 2);
INSERT INTO `role_authority` VALUES (3583, '72View', 2);
INSERT INTO `role_authority` VALUES (3584, '72Export', 2);
INSERT INTO `role_authority` VALUES (3585, '104', 2);
INSERT INTO `role_authority` VALUES (3586, '104Add', 2);
INSERT INTO `role_authority` VALUES (3587, '104Edit', 2);
INSERT INTO `role_authority` VALUES (3588, '104Delete', 2);
INSERT INTO `role_authority` VALUES (3589, '104View', 2);
INSERT INTO `role_authority` VALUES (3590, '104Export', 2);
INSERT INTO `role_authority` VALUES (3591, '104Query', 2);
INSERT INTO `role_authority` VALUES (3592, '90', 2);
INSERT INTO `role_authority` VALUES (3593, '91', 2);
INSERT INTO `role_authority` VALUES (3594, '91Export', 2);
INSERT INTO `role_authority` VALUES (3595, '91AllDeprtmentQuery', 2);
INSERT INTO `role_authority` VALUES (3596, '100', 2);
INSERT INTO `role_authority` VALUES (3597, '102', 2);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `last_logintime` datetime DEFAULT NULL,
  `password` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `real_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `role` smallint(6) NOT NULL,
  `tel` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `user_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `userGrade` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '2级' COMMENT '1级：数据可以跨部门，2级：数据仅限本部门',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `UK_cb0fsvip6qow952a07et2k9xv`(`user_name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 51 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, '888@qq.com', '2020-04-21 08:46:00', 'e10adc3949ba59abbe56e057f20f883e', '超级管理员', 1, '10086', 'admin', '1级');
INSERT INTO `sys_user` VALUES (50, '916077357@qq.com', '2020-04-11 21:12:30', 'e10adc3949ba59abbe56e057f20f883e', '郑为中', 2, '17857054385', 'zwz', '2级');

-- ----------------------------
-- Table structure for tel
-- ----------------------------
DROP TABLE IF EXISTS `tel`;
CREATE TABLE `tel`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `relationshipId` bigint(20) DEFAULT -1 COMMENT '关系类型ID',
  `relationshipName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '关系类型名',
  `tel` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '电话号码',
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '姓名',
  `qq` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT 'QQ号码',
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '家庭地址',
  `ownerId` bigint(20) DEFAULT -1 COMMENT '主人ID',
  `registDate` date DEFAULT NULL COMMENT '注册时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 131 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tel
-- ----------------------------
INSERT INTO `tel` VALUES (42, 10, '大学同学', '17857054444', '王五', '914563247', '浙江省海曙区', 50, '2020-04-09');
INSERT INTO `tel` VALUES (49, 10, '大学同学', '17857054301', '葛心壮', '916077001', '绍兴市越城区群贤中路1号\n', 1, '2020-04-11');
INSERT INTO `tel` VALUES (50, 6, '家人', '17857054302', '符生河', '916077002', '绍兴市越城区群贤中路2号\n', 1, '2020-04-11');
INSERT INTO `tel` VALUES (51, 6, '家人', '17857054303', '姬敬谦', '916077003', '绍兴市越城区群贤中路3号\n', 1, '2020-04-11');
INSERT INTO `tel` VALUES (52, 6, '家人', '17857054304', '徐贵民', '916077004', '绍兴市越城区群贤中路4号\n', 1, '2020-04-11');
INSERT INTO `tel` VALUES (53, 6, '家人', '17857054305', '殷绍昌', '916077005', '绍兴市越城区群贤中路5号\n', 1, '2020-04-11');
INSERT INTO `tel` VALUES (54, 7, '小学同学', '17857054306', '毕岩成', '916077006', '绍兴市越城区群贤中路6号\n', 1, '2020-04-11');
INSERT INTO `tel` VALUES (55, 7, '小学同学', '17857054307', '华涛龙', '916077007', '绍兴市越城区群贤中路7号\n', 1, '2020-04-11');
INSERT INTO `tel` VALUES (56, 8, '初中同学', '17857054308', '梁茂亮', '916077008', '绍兴市越城区群贤中路8号\n', 1, '2020-04-11');
INSERT INTO `tel` VALUES (57, 9, '高中同学', '17857054309', '雷江炎', '916077009', '绍兴市越城区群贤中路9号\n', 1, '2020-04-11');
INSERT INTO `tel` VALUES (58, 10, '大学同学', '17857054310', '朱昌元', '916077010', '绍兴市越城区群贤中路10号\n', 1, '2020-04-11');
INSERT INTO `tel` VALUES (59, 12, '同事', '17857054311', '郑心固', '916077011', '绍兴市越城区群贤中路11号\n', 1, '2020-04-11');
INSERT INTO `tel` VALUES (60, 11, '其他', '17857054312', '岑才超', '916077012', '绍兴市越城区群贤中路12号\n', 1, '2020-04-11');
INSERT INTO `tel` VALUES (61, 9, '高中同学', '17857054313', '廖元诚', '916077013', '绍兴市越城区群贤中路13号\n', 1, '2020-04-11');
INSERT INTO `tel` VALUES (62, 9, '高中同学', '17857054314', '庄哲彪', '916077014', '绍兴市越城区群贤中路14号\n', 1, '2020-04-11');
INSERT INTO `tel` VALUES (63, 10, '大学同学', '17857054315', '庄邦鹏', '916077015', '绍兴市越城区群贤中路15号\n', 1, '2020-04-11');
INSERT INTO `tel` VALUES (64, 10, '大学同学', '17857054316', '萧盛和', '916077016', '绍兴市越城区群贤中路16号\n', 1, '2020-04-11');
INSERT INTO `tel` VALUES (65, 8, '初中同学', '17857054317', '秦朋炎', '916077017', '绍兴市越城区群贤中路17号\n', 1, '2020-04-11');
INSERT INTO `tel` VALUES (66, 9, '高中同学', '17857054318', '潘才山', '916077018', '绍兴市越城区群贤中路18号\n', 1, '2020-04-11');
INSERT INTO `tel` VALUES (67, 11, '其他', '17857054319', '金东林', '916077019', '绍兴市越城区群贤中路19号\n', 1, '2020-04-11');
INSERT INTO `tel` VALUES (68, 12, '同事', '17857054320', '云冠之', '916077020', '绍兴市越城区群贤中路20号\n', 1, '2020-04-11');
INSERT INTO `tel` VALUES (69, 7, '小学同学', '17857054321', '刘翰国', '916077021', '绍兴市越城区群贤中路21号\n', 1, '2020-04-11');
INSERT INTO `tel` VALUES (70, 9, '高中同学', '17857054322', '岳政安', '916077022', '绍兴市越城区群贤中路22号\n', 1, '2020-04-11');
INSERT INTO `tel` VALUES (71, 7, '小学同学', '17857054323', '华鸣河', '916077023', '绍兴市越城区群贤中路23号\n', 1, '2020-04-11');
INSERT INTO `tel` VALUES (72, 8, '初中同学', '17857054324', '史力厚', '916077024', '绍兴市越城区群贤中路24号\n', 1, '2020-04-11');
INSERT INTO `tel` VALUES (73, 11, '其他', '17857054325', '庄泰壮', '916077025', '绍兴市越城区群贤中路25号\n', 1, '2020-04-11');
INSERT INTO `tel` VALUES (74, 9, '高中同学', '17857054326', '穆明裕', '916077026', '绍兴市越城区群贤中路26号\n', 1, '2020-04-11');
INSERT INTO `tel` VALUES (75, 6, '家人', '17857054327', '赖腾谦', '916077027', '绍兴市越城区群贤中路27号\n', 1, '2020-04-11');
INSERT INTO `tel` VALUES (76, 11, '其他', '17857054328', '褚武', '916077028', '绍兴市越城区群贤中路28号\n', 1, '2020-04-11');
INSERT INTO `tel` VALUES (77, 8, '初中同学', '17857054329', '巫航广', '916077029', '绍兴市越城区群贤中路29号\n', 1, '2020-04-11');
INSERT INTO `tel` VALUES (78, 12, '同事', '17857054330', '池固义', '916077030', '绍兴市越城区群贤中路30号\n', 1, '2020-04-11');
INSERT INTO `tel` VALUES (79, 7, '小学同学', '17857054331', '路德', '916077031', '绍兴市越城区群贤中路31号\n', 1, '2020-04-11');
INSERT INTO `tel` VALUES (80, 9, '高中同学', '17857054332', '周健朋', '916077032', '绍兴市越城区群贤中路32号\n', 1, '2020-04-11');
INSERT INTO `tel` VALUES (81, 11, '其他', '17857054333', '区明先', '916077033', '绍兴市越城区群贤中路33号\n', 1, '2020-04-11');
INSERT INTO `tel` VALUES (82, 11, '其他', '17857054334', '龚鹏思', '916077034', '绍兴市越城区群贤中路34号\n', 1, '2020-04-11');
INSERT INTO `tel` VALUES (83, 6, '家人', '17857054335', '龙平楠', '916077035', '绍兴市越城区群贤中路35号\n', 1, '2020-04-11');
INSERT INTO `tel` VALUES (84, 12, '同事', '17857054336', '母军壮', '916077036', '绍兴市越城区群贤中路36号\n', 1, '2020-04-11');
INSERT INTO `tel` VALUES (85, 10, '大学同学', '17857054337', '傅先山', '916077037', '绍兴市越城区群贤中路37号\n', 1, '2020-04-11');
INSERT INTO `tel` VALUES (86, 8, '初中同学', '17857054338', '卫宁梁', '916077038', '绍兴市越城区群贤中路38号\n', 1, '2020-04-11');
INSERT INTO `tel` VALUES (87, 10, '大学同学', '17857054339', '岳建星', '916077039', '绍兴市越城区群贤中路39号\n', 1, '2020-04-11');
INSERT INTO `tel` VALUES (88, 9, '高中同学', '17857054340', '曹成鹏', '916077040', '绍兴市越城区群贤中路40号\n', 1, '2020-04-11');
INSERT INTO `tel` VALUES (89, 7, '小学同学', '17857054341', '唐腾元', '916077041', '绍兴市越城区群贤中路41号\n', 1, '2020-04-11');
INSERT INTO `tel` VALUES (90, 10, '大学同学', '17857054342', '袁世楠', '916077042', '绍兴市越城区群贤中路42号\n', 1, '2020-04-11');
INSERT INTO `tel` VALUES (91, 6, '家人', '17857054343', '孔红瑾', '916077043', '绍兴市越城区群贤中路43号\n', 50, '2020-04-11');
INSERT INTO `tel` VALUES (92, 8, '初中同学', '17857054344', '吕荣融', '916077044', '绍兴市越城区群贤中路44号\n', 50, '2020-04-11');
INSERT INTO `tel` VALUES (93, 7, '小学同学', '17857054345', '戚慧真', '916077045', '绍兴市越城区群贤中路45号\n', 50, '2020-04-11');
INSERT INTO `tel` VALUES (94, 9, '高中同学', '17857054346', '陆蓓芸', '916077046', '绍兴市越城区群贤中路46号\n', 50, '2020-04-11');
INSERT INTO `tel` VALUES (95, 10, '大学同学', '17857054347', '姬佳璧', '916077047', '绍兴市越城区群贤中路47号\n', 50, '2020-04-11');
INSERT INTO `tel` VALUES (96, 11, '其他', '17857054348', '赵君英', '916077048', '绍兴市越城区群贤中路48号\n', 50, '2020-04-11');
INSERT INTO `tel` VALUES (97, 9, '高中同学', '17857054349', '梅瑶萍', '916077049', '绍兴市越城区群贤中路49号\n', 50, '2020-04-11');
INSERT INTO `tel` VALUES (98, 12, '同事', '17857054350', '葛姣秋', '916077050', '绍兴市越城区群贤中路50号\n', 50, '2020-04-11');
INSERT INTO `tel` VALUES (99, 6, '家人', '17857054351', '余颖菊', '916077051', '绍兴市越城区群贤中路51号\n', 50, '2020-04-11');
INSERT INTO `tel` VALUES (100, 11, '其他', '17857054352', '母菁霄', '916077052', '绍兴市越城区群贤中路52号\n', 50, '2020-04-11');
INSERT INTO `tel` VALUES (101, 10, '大学同学', '17857054353', '卫娣', '916077053', '绍兴市越城区群贤中路53号\n', 50, '2020-04-11');
INSERT INTO `tel` VALUES (102, 11, '其他', '17857054354', '殷美艳', '916077054', '绍兴市越城区群贤中路54号\n', 50, '2020-04-11');
INSERT INTO `tel` VALUES (103, 11, '其他', '17857054355', '蒲滢可', '916077055', '绍兴市越城区群贤中路55号\n', 50, '2020-04-11');
INSERT INTO `tel` VALUES (104, 11, '其他', '17857054356', '赖真璐', '916077056', '绍兴市越城区群贤中路56号\n', 50, '2020-04-11');
INSERT INTO `tel` VALUES (105, 12, '同事', '17857054357', '符美娜', '916077057', '绍兴市越城区群贤中路57号\n', 50, '2020-04-11');
INSERT INTO `tel` VALUES (106, 11, '其他', '17857054358', '涂莲柔', '916077058', '绍兴市越城区群贤中路58号\n', 50, '2020-04-11');
INSERT INTO `tel` VALUES (107, 9, '高中同学', '17857054359', '金静淑', '916077059', '绍兴市越城区群贤中路59号\n', 50, '2020-04-11');
INSERT INTO `tel` VALUES (108, 12, '同事', '17857054360', '严莉娥', '916077060', '绍兴市越城区群贤中路60号\n', 50, '2020-04-11');
INSERT INTO `tel` VALUES (109, 10, '大学同学', '17857054361', '夏雪枝', '916077061', '绍兴市越城区群贤中路61号\n', 50, '2020-04-11');
INSERT INTO `tel` VALUES (110, 10, '大学同学', '17857054362', '钟聪馨', '916077062', '绍兴市越城区群贤中路62号\n', 50, '2020-04-11');
INSERT INTO `tel` VALUES (111, 12, '同事', '17857054363', '林爱瑾', '916077063', '绍兴市越城区群贤中路63号\n', 50, '2020-04-11');
INSERT INTO `tel` VALUES (112, 7, '小学同学', '17857054364', '巫荔娴', '916077064', '绍兴市越城区群贤中路64号\n', 50, '2020-04-11');
INSERT INTO `tel` VALUES (113, 8, '初中同学', '17857054365', '曾春蓓', '916077065', '绍兴市越城区群贤中路65号\n', 50, '2020-04-11');
INSERT INTO `tel` VALUES (114, 8, '初中同学', '17857054366', '柳瑗鱼', '916077066', '绍兴市越城区群贤中路66号\n', 50, '2020-04-11');
INSERT INTO `tel` VALUES (115, 9, '高中同学', '17857054367', '古春桂', '916077067', '绍兴市越城区群贤中路67号\n', 50, '2020-04-11');
INSERT INTO `tel` VALUES (116, 7, '小学同学', '17857054368', '吴蓉青', '916077068', '绍兴市越城区群贤中路68号\n', 50, '2020-04-11');
INSERT INTO `tel` VALUES (117, 8, '初中同学', '17857054369', '姜纯', '916077069', '绍兴市越城区群贤中路69号\n', 50, '2020-04-11');
INSERT INTO `tel` VALUES (118, 9, '高中同学', '17857054370', '严凡惠', '916077070', '绍兴市越城区群贤中路70号\n', 50, '2020-04-11');
INSERT INTO `tel` VALUES (119, 9, '高中同学', '17857054371', '古蓓晓', '916077071', '绍兴市越城区群贤中路71号\n', 50, '2020-04-11');
INSERT INTO `tel` VALUES (120, 6, '家人', '17857054372', '胡露芬', '916077072', '绍兴市越城区群贤中路72号\n', 50, '2020-04-11');
INSERT INTO `tel` VALUES (121, 10, '大学同学', '17857054373', '余玲妹', '916077073', '绍兴市越城区群贤中路73号\n', 50, '2020-04-11');
INSERT INTO `tel` VALUES (122, 8, '初中同学', '17857054374', '刘秋竹', '916077074', '绍兴市越城区群贤中路74号\n', 50, '2020-04-11');
INSERT INTO `tel` VALUES (123, 9, '高中同学', '17857054375', '席慧青', '916077075', '绍兴市越城区群贤中路75号\n', 50, '2020-04-11');
INSERT INTO `tel` VALUES (124, 11, '其他', '17857054376', '姬茗美', '916077076', '绍兴市越城区群贤中路76号\n', 50, '2020-04-11');
INSERT INTO `tel` VALUES (125, 6, '家人', '17857054377', '乐娴', '916077077', '绍兴市越城区群贤中路77号\n', 50, '2020-04-11');
INSERT INTO `tel` VALUES (126, 8, '初中同学', '17857054378', '童珠纨', '916077078', '绍兴市越城区群贤中路78号\n', 50, '2020-04-11');
INSERT INTO `tel` VALUES (127, 8, '初中同学', '17857054379', '高蓉秋', '916077079', '绍兴市越城区群贤中路79号\n', 50, '2020-04-11');
INSERT INTO `tel` VALUES (128, 8, '初中同学', '17857054380', '霍环凡', '916077080', '绍兴市越城区群贤中路80号\n', 50, '2020-04-11');
INSERT INTO `tel` VALUES (129, 7, '小学同学', '', 'dgh', '56357468', '467468', 53, '2020-04-15');
INSERT INTO `tel` VALUES (130, 8, '初中同学', 'asd', 'asdas', 'asd', 'as', 53, '2020-04-15');

SET FOREIGN_KEY_CHECKS = 1;
