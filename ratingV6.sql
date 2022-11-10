/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

DROP DATABASE IF EXISTS `rating`;
CREATE DATABASE IF NOT EXISTS `rating` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_croatian_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `rating`;

DROP TABLE IF EXISTS `a_competition`;
CREATE TABLE IF NOT EXISTS `a_competition` (
  `id` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci NOT NULL,
  `create_by` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci DEFAULT NULL,
  `create_time` datetime(6) DEFAULT NULL,
  `del_flag` int NOT NULL,
  `update_by` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci DEFAULT NULL,
  `update_time` datetime(6) DEFAULT NULL,
  `evaluate_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci DEFAULT NULL,
  `level` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci DEFAULT NULL,
  `value` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_croatian_ci;

DELETE FROM `a_competition`;
INSERT INTO `a_competition` (`id`, `create_by`, `create_time`, `del_flag`, `update_by`, `update_time`, `evaluate_id`, `level`, `title`, `value`) VALUES
	('1505029680808464384', 'admin', '2022-03-19 11:53:32.665000', 0, NULL, NULL, '1504979707307888640', '国家级', '中国高数竞赛', '二等奖'),
	('1505132957847916544', 'stu', '2022-03-19 18:43:55.841000', 0, NULL, NULL, '1505007492093054976', '国家级', '国家级翻译比赛', '三等奖');

DROP TABLE IF EXISTS `a_department`;
CREATE TABLE IF NOT EXISTS `a_department` (
  `id` bigint unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` int DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `parent_id` bigint unsigned DEFAULT NULL,
  `sort_order` decimal(10,2) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `is_parent` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

DELETE FROM `a_department`;
INSERT INTO `a_department` (`id`, `create_by`, `create_time`, `del_flag`, `update_by`, `update_time`, `parent_id`, `sort_order`, `status`, `title`, `is_parent`) VALUES
	(1464487288363945985, 'admin', '2022-03-19 11:53:33', 0, 'admin', '2022-03-19 11:53:33', 0, 1.00, 0, '计算机科学与技术', b'1'),
	(1464487332064399361, 'admin', '2022-03-19 11:53:33', 0, 'admin', '2022-03-19 11:53:33', 0, 2.00, 0, '电子信息工程', b'1'),
	(1464487379074158593, 'admin', '2022-03-19 11:53:33', 0, 'admin', '2022-03-19 11:53:33', 0, 3.00, 0, '网络工程', b'1'),
	(1464487524662644737, 'admin', '2022-03-19 11:53:33', 0, 'admin', '2022-03-20 12:55:35', 1464487288363945985, 1.00, 0, '计算机1801', b'0'),
	(1464487559647334401, 'admin', '2022-03-19 11:53:33', 0, 'admin', '2022-03-20 13:23:06', 1464487288363945985, 2.00, 0, '计算机1802', b'0'),
	(1464487623933431809, 'admin', '2022-03-19 11:53:33', 0, 'admin', '2022-03-19 11:53:33', 1464487332064399361, 1.00, 0, '电子信息工程1801', b'0'),
	(1464487656678363137, 'admin', '2022-03-19 11:53:33', 0, 'admin', '2022-03-19 11:53:33', 1464487332064399361, 2.00, 0, '电子信息工程1802', b'0'),
	(1464487691780493313, 'admin', '2022-03-19 11:53:33', 0, 'admin', '2022-03-19 11:53:33', 1464487332064399361, 3.00, 0, '电子信息工程1803', b'0'),
	(1464487733895499777, 'admin', '2022-03-19 11:53:33', 0, 'admin', '2022-03-19 11:53:33', 1464487379074158593, 1.00, 0, '网络工程1801', b'0'),
	(1464487807572643841, 'admin', '2022-03-19 11:53:33', 0, 'admin', '2022-03-19 11:53:33', 1464487379074158593, 2.00, 0, '网络工程1802', b'0'),
	(1505188058469896192, 'admin', '2022-03-19 22:22:53', 0, NULL, NULL, 0, 4.00, 0, '教师组', b'0');

DROP TABLE IF EXISTS `a_department_header`;
CREATE TABLE IF NOT EXISTS `a_department_header` (
  `id` bigint unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `department_id` bigint unsigned DEFAULT NULL,
  `type` tinyint(1) DEFAULT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

DELETE FROM `a_department_header`;
INSERT INTO `a_department_header` (`id`, `create_by`, `create_time`, `del_flag`, `update_by`, `update_time`, `department_id`, `type`, `user_id`) VALUES
	(1505407679902912512, 'admin', '2022-03-20 12:55:35', 0, NULL, NULL, 1464487524662644737, 0, 1464772465946398721),
	(1505414604791091200, 'admin', '2022-03-20 13:23:06', 0, NULL, NULL, 1464487559647334401, 0, 1505414568497778688);

DROP TABLE IF EXISTS `a_dict`;
CREATE TABLE IF NOT EXISTS `a_dict` (
  `id` bigint unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `sort_order` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

DELETE FROM `a_dict`;
INSERT INTO `a_dict` (`id`, `create_by`, `create_time`, `del_flag`, `update_by`, `update_time`, `description`, `title`, `type`, `sort_order`) VALUES
	(75135930788220928, 'admin', '2022-03-19 11:53:33', 0, 'admin', '2022-03-19 11:53:33', '', '性别', 'sex', 0.00),
	(75383353938808832, 'admin', '2022-03-19 11:53:33', 0, 'admin', '2022-03-19 11:53:33', '', '消息类型', 'message_type', 1.00),
	(75388696739713024, 'admin', '2022-03-19 11:53:33', 0, 'admin', '2022-03-19 11:53:33', '', '分权限', 'permission_type', 2.00),
	(81843858882695168, 'admin', '2022-03-19 11:53:33', 0, 'admin', '2022-03-19 11:53:33', '', '优先级', 'priority', 5.00);

DROP TABLE IF EXISTS `a_dict_data`;
CREATE TABLE IF NOT EXISTS `a_dict_data` (
  `id` bigint unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `dict_id` bigint unsigned DEFAULT NULL,
  `sort_order` decimal(10,2) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sort_order` (`sort_order`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

DELETE FROM `a_dict_data`;
INSERT INTO `a_dict_data` (`id`, `create_by`, `create_time`, `del_flag`, `update_by`, `update_time`, `description`, `dict_id`, `sort_order`, `status`, `title`, `value`) VALUES
	(75158227712479232, 'admin', '2022-03-19 11:53:33', 0, 'admin', '2022-03-19 11:53:33', '', 75135930788220928, 0.00, 0, '男', '男'),
	(75159254272577536, 'admin', '2022-03-19 11:53:33', 0, 'admin', '2022-03-19 11:53:33', '', 75135930788220928, 1.00, 0, '女', '女'),
	(75159898425397248, 'admin', '2022-03-19 11:53:33', 0, 'admin', '2022-03-19 11:53:33', '', 75135930788220928, 2.00, -1, '保密', '保密'),
	(75385648017575936, 'admin', '2022-03-19 11:53:33', 0, 'admin', '2022-03-19 11:53:33', '', 75383353938808832, 0.00, 0, '系统公告', '系统公告'),
	(75385706913992704, 'admin', '2022-03-19 11:53:33', 0, 'admin', '2022-03-19 11:53:33', '', 75383353938808832, 1.00, 0, '提醒', '提醒'),
	(75385774274514944, 'admin', '2022-03-19 11:53:33', 0, 'admin', '2022-03-19 11:53:33', '', 75383353938808832, 2.00, 0, '私信', '私信'),
	(75390787835138048, 'admin', '2022-03-19 11:53:33', 0, 'admin', '2022-03-19 11:53:33', '', 75388696739713024, 0.00, 0, '查看操作(view)', 'view'),
	(75390886501945344, 'admin', '2022-03-19 11:53:33', 0, 'admin', '2022-03-19 11:53:33', '', 75388696739713024, 1.00, 0, '添加操作(add)', 'add'),
	(75390993939042304, 'admin', '2022-03-19 11:53:33', 0, 'admin', '2022-03-19 11:53:33', '', 75388696739713024, 2.00, 0, '编辑操作(edit)', 'edit'),
	(75391067532300288, 'admin', '2022-03-19 11:53:33', 0, 'admin', '2022-03-19 11:53:33', '', 75388696739713024, 3.00, 0, '删除操作(delete)', 'delete'),
	(75391126902673408, 'admin', '2022-03-19 11:53:33', 0, 'admin', '2022-03-19 11:53:33', '', 75388696739713024, 4.00, 0, '清空操作(clear)', 'clear'),
	(75391192883269632, 'admin', '2022-03-19 11:53:33', 0, 'admin', '2022-03-19 11:53:33', '', 75388696739713024, 5.00, 0, '启用操作(enable)', 'enable'),
	(75391251024711680, 'admin', '2022-03-19 11:53:33', 0, 'admin', '2022-03-19 11:53:33', '', 75388696739713024, 6.00, 0, '禁用操作(disable)', 'disable'),
	(75391297124306944, 'admin', '2022-03-19 11:53:33', 0, 'admin', '2022-03-19 11:53:33', '', 75388696739713024, 7.00, 0, '搜索操作(search)', 'search'),
	(75391343379091456, 'admin', '2022-03-19 11:53:33', 0, 'admin', '2022-03-19 11:53:33', '', 75388696739713024, 8.00, 0, '上传文件(upload)', 'upload'),
	(75391407526776832, 'admin', '2022-03-19 11:53:33', 0, 'admin', '2022-03-19 11:53:33', '', 75388696739713024, 9.00, 0, '导出操作(output)', 'output'),
	(75391475042488320, 'admin', '2022-03-19 11:53:33', 0, 'admin', '2022-03-19 11:53:33', '', 75388696739713024, 10.00, 0, '导入操作(input)', 'input'),
	(75391522182270976, 'admin', '2022-03-19 11:53:33', 0, 'admin', '2022-03-19 11:53:33', '', 75388696739713024, 11.00, 0, '分配权限(editPerm)', 'editPerm'),
	(75391576364290048, 'admin', '2022-03-19 11:53:33', 0, 'admin', '2022-03-19 11:53:33', '', 75388696739713024, 12.00, 0, '设为默认(setDefault)', 'setDefault'),
	(75391798033256448, 'admin', '2022-03-19 11:53:33', 0, 'admin', '2022-03-19 11:53:33', '', 75388696739713024, 13.00, 0, '其他操作(other)', 'other'),
	(81843987719131136, 'admin', '2022-03-19 11:53:33', 0, 'admin', '2022-03-19 11:53:33', '', 81843858882695168, 0.00, 0, '普通', '0'),
	(81844044015079424, 'admin', '2022-03-19 11:53:33', 0, 'admin', '2022-03-19 11:53:33', '', 81843858882695168, 1.00, 0, '重要', '1'),
	(81844100705292288, 'admin', '2022-03-19 11:53:33', 0, 'admin', '2022-03-19 11:53:33', '', 81843858882695168, 2.00, 0, '紧急', '2');

DROP TABLE IF EXISTS `a_file`;
CREATE TABLE IF NOT EXISTS `a_file` (
  `id` bigint unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `size` bigint unsigned DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `f_key` varchar(255) DEFAULT NULL,
  `location` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

DELETE FROM `a_file`;
INSERT INTO `a_file` (`id`, `create_by`, `create_time`, `del_flag`, `update_by`, `update_time`, `name`, `size`, `type`, `url`, `f_key`, `location`) VALUES
	(1464483838750232576, 'admin', '2022-03-19 11:53:33', 0, 'admin', '2022-03-19 11:53:33', '微信截图_20211127143841.png', 21552, 'image/png', 'C:\\oa-file/20211127/1b74e525e0544a788045f69426d6b093.png', '1b74e525e0544a788045f69426d6b093.png', 0);

DROP TABLE IF EXISTS `a_log`;
CREATE TABLE IF NOT EXISTS `a_log` (
  `id` bigint unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `cost_time` int unsigned DEFAULT NULL,
  `ip` varchar(255) DEFAULT NULL,
  `ip_info` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `request_param` longtext,
  `request_type` varchar(255) DEFAULT NULL,
  `request_url` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `log_type` tinyint(1) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `device` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

DELETE FROM `a_log`;
INSERT INTO `a_log` (`id`, `create_by`, `create_time`, `del_flag`, `update_by`, `update_time`, `cost_time`, `ip`, `ip_info`, `name`, `request_param`, `request_type`, `request_url`, `username`, `log_type`, `code`, `device`) VALUES
	(1503892408331538432, NULL, '2022-03-19 11:53:33', 0, NULL, '2022-03-19 11:53:33', 84, '127.0.0.1', '本地测试', '登录系统', '{"password":"密码隐藏","code":"8645","saveLogin":"true","captchaId":"edca1ed54a754059b4ae63c60a45e124","username":"admin"}', 'POST', '/zwz/login', 'admin', 0, NULL, NULL),
	(1504979137973063680, NULL, '2022-03-19 11:53:33', 0, NULL, '2022-03-19 11:53:33', 35, '127.0.0.1', '本地测试', '登录系统', '{"password":"密码隐藏","code":"5863","saveLogin":"true","captchaId":"93ad38c1cbb6469e91e71383c191e8c6","username":"admin"}', 'POST', '/zwz/login', 'admin', 0, NULL, NULL),
	(1504979188975800320, NULL, '2022-03-19 11:53:33', 0, NULL, '2022-03-19 11:53:33', 54, '127.0.0.1', '本地测试', '登录系统', '{"password":"密码隐藏","code":"6261","saveLogin":"true","captchaId":"8a90dd1909f4438a913b079ff5702660","username":"admin"}', 'POST', '/zwz/login', 'admin', 0, NULL, NULL),
	(1504979340365008896, NULL, '2022-03-19 11:53:33', 0, NULL, '2022-03-19 11:53:33', 53, '127.0.0.1', '本地测试', '登录系统', '{"password":"密码隐藏","code":"7734","saveLogin":"true","captchaId":"81e209b8c18745e98da410417b15f445","username":"admin"}', 'POST', '/zwz/login', 'admin', 0, NULL, NULL),
	(1505029416265322496, NULL, '2022-03-19 11:53:33', 0, NULL, '2022-03-19 11:53:33', 123, '127.0.0.1', '本地测试', '登录系统', '{"password":"密码隐藏","code":"9587","saveLogin":"true","captchaId":"2f3f9971676f4c0b933b141055c87d7a","username":"admin"}', 'POST', '/zwz/login', 'admin', 0, NULL, NULL),
	(1505099084619452416, NULL, '2022-03-19 16:29:20', 0, NULL, '2022-03-19 16:29:20', 252, '127.0.0.1', '本地测试', '登录系统', '{"password":"密码隐藏","code":"7911","saveLogin":"true","captchaId":"b7970acf988246a6a3eff866b9e621c2","username":"admin"}', 'POST', '/zwz/login', 'admin', 0, NULL, NULL),
	(1505107584464588800, NULL, '2022-03-19 17:03:06', 0, NULL, '2022-03-19 17:03:06', 79, '127.0.0.1', '本地测试', '登录系统', '{"password":"密码隐藏","code":"7189","saveLogin":"true","captchaId":"0f7c959d86dc4a439347decb49651b8e","username":"admin"}', 'POST', '/zwz/login', 'admin', 0, NULL, NULL),
	(1505111212432691200, NULL, '2022-03-19 17:17:31', 0, NULL, '2022-03-19 17:17:31', 78, '127.0.0.1', '本地测试', '登录系统', '{"password":"密码隐藏","code":"1312","saveLogin":"true","captchaId":"74178141c28840a899983d2269b764aa","username":"stu"}', 'POST', '/zwz/login', 'stu', 0, NULL, NULL),
	(1505132099357773824, NULL, '2022-03-19 18:40:32', 0, NULL, '2022-03-19 18:40:32', 753, '127.0.0.1', '本地测试', '登录系统', '{"password":"密码隐藏","code":"7727","saveLogin":"true","captchaId":"28155da871bc4b339749874fa1139832","username":"admin"}', 'POST', '/zwz/login', 'admin', 0, NULL, NULL),
	(1505132746824093696, NULL, '2022-03-19 18:43:06', 0, NULL, '2022-03-19 18:43:06', 86, '127.0.0.1', '本地测试', '登录系统', '{"password":"密码隐藏","code":"7381","saveLogin":"true","captchaId":"6d84238029554267a63b5bd935f23502","username":"admin"}', 'POST', '/zwz/login', 'admin', 0, NULL, NULL),
	(1505132835600732160, NULL, '2022-03-19 18:43:27', 0, NULL, '2022-03-19 18:43:27', 96, '127.0.0.1', '本地测试', '登录系统', '{"password":"密码隐藏","code":"6597","saveLogin":"true","captchaId":"5a0460f3647e49ab8fc052f531c2060f","username":"stu"}', 'POST', '/zwz/login', 'stu', 0, NULL, NULL),
	(1505133072708931584, NULL, '2022-03-19 18:44:23', 0, NULL, '2022-03-19 18:44:23', 90, '127.0.0.1', '本地测试', '登录系统', '{"password":"密码隐藏","code":"3244","saveLogin":"true","captchaId":"6e1ac3601b374fd1b8916dd9277369b5","username":"tea"}', 'POST', '/zwz/login', 'tea', 0, NULL, NULL),
	(1505133229789810688, NULL, '2022-03-19 18:45:01', 0, NULL, '2022-03-19 18:45:01', 99, '127.0.0.1', '本地测试', '登录系统', '{"password":"密码隐藏","code":"3955","saveLogin":"true","captchaId":"3f185250e79f47e7a5a1ae991fa636a0","username":"stu"}', 'POST', '/zwz/login', 'stu', 0, NULL, NULL),
	(1505133284529672192, NULL, '2022-03-19 18:45:14', 0, NULL, '2022-03-19 18:45:14', 84, '127.0.0.1', '本地测试', '登录系统', '{"password":"密码隐藏","code":"7571","saveLogin":"true","captchaId":"8c69d3ee499840c4a21f89d4847847e6","username":"tea"}', 'POST', '/zwz/login', 'tea', 0, NULL, NULL),
	(1505134949177626624, NULL, '2022-03-19 18:51:51', 0, NULL, '2022-03-19 18:51:51', 132, '127.0.0.1', '本地测试', '登录系统', '{"password":"密码隐藏","code":"4312","saveLogin":"true","captchaId":"98a0c85f25544e91858a93dcd495f9cb","username":"admin"}', 'POST', '/zwz/login', 'admin', 0, NULL, NULL),
	(1505136398334824448, NULL, '2022-03-19 18:57:36', 0, NULL, '2022-03-19 18:57:36', 154, '127.0.0.1', '本地测试', '登录系统', '{"password":"密码隐藏","code":"1645","saveLogin":"true","captchaId":"b4ffda6cc5cb4e1e880b6f3988694493","username":"stu"}', 'POST', '/zwz/login', 'stu', 0, NULL, NULL),
	(1505136520707837952, NULL, '2022-03-19 18:58:05', 0, NULL, '2022-03-19 18:58:05', 86, '127.0.0.1', '本地测试', '登录系统', '{"password":"密码隐藏","code":"3593","saveLogin":"true","captchaId":"eeb8609335ca4e50af8f782960834a4e","username":"admin"}', 'POST', '/zwz/login', 'admin', 0, NULL, NULL),
	(1505136792473571328, NULL, '2022-03-19 18:59:10', 0, NULL, '2022-03-19 18:59:10', 101, '127.0.0.1', '本地测试', '登录系统', '{"password":"密码隐藏","code":"4211","saveLogin":"true","captchaId":"6de7168427d0401397d1f7054f16f990","username":"stu"}', 'POST', '/zwz/login', 'stu', 0, NULL, NULL),
	(1505136928528404480, NULL, '2022-03-19 18:59:43', 0, NULL, '2022-03-19 18:59:43', 105, '127.0.0.1', '本地测试', '登录系统', '{"password":"密码隐藏","code":"2746","saveLogin":"true","captchaId":"888eb7667ce14f778903f52f5954c82d","username":"tea"}', 'POST', '/zwz/login', 'tea', 0, NULL, NULL),
	(1505137114696781824, NULL, '2022-03-19 19:00:27', 0, NULL, '2022-03-19 19:00:27', 84, '127.0.0.1', '本地测试', '登录系统', '{"password":"密码隐藏","code":"3854","saveLogin":"true","captchaId":"0b0eebe2f23b4224aa7e4f3af04525c5","username":"jwc"}', 'POST', '/zwz/login', 'jwc', 0, NULL, NULL),
	(1505137292921147392, NULL, '2022-03-19 19:01:09', 0, NULL, '2022-03-19 19:01:09', 74, '127.0.0.1', '本地测试', '登录系统', '{"password":"密码隐藏","code":"4239","saveLogin":"true","captchaId":"70390eb193fd40cfb89e2b1fa000b510","username":"admin"}', 'POST', '/zwz/login', 'admin', 0, NULL, NULL),
	(1505180859974684672, NULL, '2022-03-19 21:54:17', 0, NULL, '2022-03-19 21:54:17', 538, '127.0.0.1', '本地测试', '登录系统', '{"password":"密码隐藏","code":"6815","saveLogin":"true","captchaId":"5d03bbdc95124158afa5269f58a5a90f","username":"admin"}', 'POST', '/zwz/login', 'admin', 0, NULL, NULL),
	(1505331733774602240, NULL, '2022-03-20 07:53:48', 0, NULL, '2022-03-20 07:53:48', 169, '127.0.0.1', '本地测试', '登录系统', '{"password":"密码隐藏","code":"9124","saveLogin":"true","captchaId":"ed4af00c954f424680be90cb229f0a85","username":"admin"}', 'POST', '/zwz/login', 'admin', 0, NULL, NULL),
	(1505397212086145024, NULL, '2022-03-20 12:13:59', 0, NULL, '2022-03-20 12:13:59', 54, '127.0.0.1', '本地测试', '登录系统', '{"password":"密码隐藏","code":"7996","saveLogin":"true","captchaId":"f5719380b3494954a762c1e9ffa78f67","username":"admin"}', 'POST', '/zwz/login', 'admin', 0, NULL, NULL),
	(1505407538596810752, NULL, '2022-03-20 12:55:01', 0, NULL, '2022-03-20 12:55:01', 102, '127.0.0.1', '本地测试', '登录系统', '{"password":"密码隐藏","code":"6993","saveLogin":"true","captchaId":"e401111f8e824ad3834989a508f37f08","username":"tea"}', 'POST', '/zwz/login', 'tea', 0, NULL, NULL),
	(1505407606913634304, NULL, '2022-03-20 12:55:17', 0, NULL, '2022-03-20 12:55:17', 94, '127.0.0.1', '本地测试', '登录系统', '{"password":"密码隐藏","code":"9126","saveLogin":"true","captchaId":"7e9ca889d3e340fdb9d9b740839e5e94","username":"admin"}', 'POST', '/zwz/login', 'admin', 0, NULL, NULL),
	(1505407894655471616, NULL, '2022-03-20 12:56:26', 0, NULL, '2022-03-20 12:56:26', 334, '127.0.0.1', '本地测试', '登录系统', '{"password":"密码隐藏","code":"6771","saveLogin":"true","captchaId":"8bb7de38af0e4ce3aa4e4e394d789aec","username":"tea"}', 'POST', '/zwz/login', 'tea', 0, NULL, NULL),
	(1505411425198280704, NULL, '2022-03-20 13:10:28', 0, NULL, '2022-03-20 13:10:28', 304, '127.0.0.1', '本地测试', '登录系统', '{"password":"密码隐藏","code":"3729","saveLogin":"true","captchaId":"3aeb495d56314582ade9887a36bc06fd","username":"admin"}', 'POST', '/zwz/login', 'admin', 0, NULL, NULL),
	(1505414980034498560, NULL, '2022-03-20 13:24:35', 0, NULL, '2022-03-20 13:24:35', 140, '127.0.0.1', '本地测试', '登录系统', '{"password":"密码隐藏","code":"4424","saveLogin":"true","captchaId":"1140decf42b7433f85f9c094652a9775","username":"admin"}', 'POST', '/zwz/login', 'admin', 0, NULL, NULL),
	(1505415233659867136, NULL, '2022-03-20 13:25:36', 0, NULL, '2022-03-20 13:25:36', 80, '127.0.0.1', '本地测试', '登录系统', '{"password":"密码隐藏","code":"3668","saveLogin":"true","captchaId":"e1398a142c774b619021de8d3469dc45","username":"tea2"}', 'POST', '/zwz/login', 'tea2', 0, NULL, NULL),
	(1505448033398165504, NULL, '2022-03-20 15:35:56', 0, NULL, '2022-03-20 15:35:56', 352, '127.0.0.1', '本地测试', '登录系统', '{"password":"密码隐藏","code":"9256","saveLogin":"true","captchaId":"e02155a2c523483ca5449f394996fce1","username":"admin"}', 'POST', '/zwz/login', 'admin', 0, NULL, NULL),
	(1590510356319571968, NULL, '2022-11-10 09:03:14', 0, NULL, '2022-11-10 09:03:14', 128, '127.0.0.1', '本地测试', '登录系统', '{"username":"admin","password":"","code":"3712","captchaId":"e27e8c7f9a604acd8cc2fe9a2149a397","saveLogin":"true"}', 'POST', '/zwz/login', 'admin', 1, '', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590510356353126400, NULL, '2022-11-10 09:03:14', 0, NULL, '2022-11-10 09:03:14', 151, '127.0.0.1', '本地测试', '获取当前登录用户', '{}', 'GET', '/zwz/user/info', 'admin', 2, 'USER-02', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590510357401702400, NULL, '2022-11-10 09:03:14', 0, NULL, '2022-11-10 09:03:14', 31, '127.0.0.1', '本地测试', '查询个人门户菜单B', '{}', 'POST', '/zwz/myDoor/getMyDoorList6', 'admin', 2, 'MY-DOOR-02', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590510357607223296, NULL, '2022-11-10 09:03:14', 0, NULL, '2022-11-10 09:03:14', 166, '127.0.0.1', '本地测试', '查询菜单', '{}', 'GET', '/zwz/permission/getMenuList', 'admin', 2, 'PERMISSION-02', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590510416193261568, NULL, '2022-11-10 09:03:28', 0, NULL, '2022-11-10 09:03:28', 61, '127.0.0.1', '本地测试', '查询个人门户菜单B', '{}', 'POST', '/zwz/myDoor/getMyDoorList6', 'admin', 2, 'MY-DOOR-02', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590510418558849024, NULL, '2022-11-10 09:03:29', 0, NULL, '2022-11-10 09:03:29', 48, '127.0.0.1', '本地测试', '查询子部门', '{}', 'GET', '/zwz/department/getByParentId', 'admin', 2, 'DEP-01', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590510419796168704, NULL, '2022-11-10 09:03:29', 0, NULL, '2022-11-10 09:03:29', 28, '127.0.0.1', '本地测试', '查询全部角色', '{}', 'GET', '/zwz/role/getAllList', 'admin', 2, 'ROLE-01', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590510419829723136, NULL, '2022-11-10 09:03:29', 0, NULL, '2022-11-10 09:03:29', 37, '127.0.0.1', '本地测试', '查询单个数据字典的值', '{}', 'GET', '/zwz/dictData/getByType/sex', 'admin', 2, 'DICT_DATA-01', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590510419871666176, NULL, '2022-11-10 09:03:29', 0, NULL, '2022-11-10 09:03:29', 74, '127.0.0.1', '本地测试', '查询用户', '{"nickname":"","departmentId":"","pageNumber":"1","pageSize":"20","sort":"createTime","order":"desc"}', 'GET', '/zwz/user/getUserList', 'admin', 2, 'USER-07', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590510420010078208, NULL, '2022-11-10 09:03:29', 0, NULL, '2022-11-10 09:03:29', 33, '127.0.0.1', '本地测试', '查询子部门', '{}', 'GET', '/zwz/department/getByParentId', 'admin', 2, 'DEP-01', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590510431028514816, NULL, '2022-11-10 09:03:32', 0, NULL, '2022-11-10 09:03:32', 25, '127.0.0.1', '本地测试', '查询子部门', '{}', 'GET', '/zwz/department/getByParentId', 'admin', 2, 'DEP-01', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590510431036903424, NULL, '2022-11-10 09:03:32', 0, NULL, '2022-11-10 09:03:32', 27, '127.0.0.1', '本地测试', '查询用户', '{"pageNumber":"1","pageSize":"10","sort":"createTime","order":"desc","departmentId":""}', 'GET', '/zwz/myUser/getByPage', 'admin', 2, 'USER-01', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590510432169365504, NULL, '2022-11-10 09:03:32', 0, NULL, '2022-11-10 09:03:32', 29, '127.0.0.1', '本地测试', '查询子部门', '{}', 'GET', '/zwz/department/getByParentId', 'admin', 2, 'DEP-01', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590511333659512832, NULL, '2022-11-10 09:07:07', 0, NULL, '2022-11-10 09:07:07', 58, '127.0.0.1', '本地测试', '登录系统', '{"username":"admin","password":"","code":"7386","captchaId":"c95625ec50e54fd099a3207e316e4442","saveLogin":"true"}', 'POST', '/zwz/login', 'admin', 1, '', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590511333722427392, NULL, '2022-11-10 09:07:07', 0, NULL, '2022-11-10 09:07:07', 60, '127.0.0.1', '本地测试', '获取当前登录用户', '{}', 'GET', '/zwz/user/info', 'admin', 2, 'USER-02', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590511334318018560, NULL, '2022-11-10 09:07:07', 0, NULL, '2022-11-10 09:07:07', 24, '127.0.0.1', '本地测试', '查询个人门户菜单B', '{}', 'POST', '/zwz/myDoor/getMyDoorList6', 'admin', 2, 'MY-DOOR-02', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590511334318018561, NULL, '2022-11-10 09:07:07', 0, NULL, '2022-11-10 09:07:07', 96, '127.0.0.1', '本地测试', '查询菜单', '{}', 'GET', '/zwz/permission/getMenuList', 'admin', 2, 'PERMISSION-02', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590511346548609024, NULL, '2022-11-10 09:07:10', 0, NULL, '2022-11-10 09:07:10', 36, '127.0.0.1', '本地测试', '查询角色', '{"pageNumber":"1","pageSize":"15","sort":"createTime","order":"desc"}', 'GET', '/zwz/role/getAllByPage', 'admin', 2, 'ROLE-02', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590511348108890112, NULL, '2022-11-10 09:07:10', 0, NULL, '2022-11-10 09:07:10', 93, '127.0.0.1', '本地测试', '查询全部菜单', '{}', 'GET', '/zwz/permission/getAllList', 'admin', 2, 'PERMISSION-04', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590511353494376448, NULL, '2022-11-10 09:07:12', 0, NULL, '2022-11-10 09:07:12', 26, '127.0.0.1', '本地测试', '查询单个数据字典的值', '{}', 'GET', '/zwz/dictData/getByType/permission_type', 'admin', 2, 'DICT_DATA-01', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590511361740378112, NULL, '2022-11-10 09:07:14', 0, NULL, '2022-11-10 09:07:14', 24, '127.0.0.1', '本地测试', '查询菜单权限拥有者', '{"permissionId":"125909152017944576"}', 'GET', '/zwz/permission/getUserByPermission', 'admin', 2, 'PERMISSION-01', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590511372821729280, NULL, '2022-11-10 09:07:16', 0, NULL, '2022-11-10 09:07:16', 33, '127.0.0.1', '本地测试', '查询菜单权限拥有者', '{"permissionId":"15701400130424832"}', 'GET', '/zwz/permission/getUserByPermission', 'admin', 2, 'PERMISSION-01', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590511379578753024, NULL, '2022-11-10 09:07:18', 0, NULL, '2022-11-10 09:07:18', 31, '127.0.0.1', '本地测试', '查询角色', '{"pageNumber":"1","pageSize":"15","sort":"createTime","order":"desc"}', 'GET', '/zwz/role/getAllByPage', 'admin', 2, 'ROLE-02', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590511406560710656, NULL, '2022-11-10 09:07:24', 0, NULL, '2022-11-10 09:07:24', 90, '127.0.0.1', '本地测试', '修改菜单权限', '{"roleId":"496138616573952","permIds":"125909152017944576,1464484663442673664,5129710648430593,1464485105081913345,40238597734928384,45235621697949696,45235787867885568,45235939278065664,56309618086776832,57212882168844288,61560041605435392,61560275261722624,61560480518377472,75002207560273920,76215889006956544,76216071333351424,76216264070008832,76216459709124608,76216594207870976,76216702639017984,1464486736955576321,1464514283202285568,5129710648430592,5129710648430594,16687383932047360,16689632049631232,16689745006432256,16689883993083904,16690313745666048,5129710648430595,16694861252005888,16695107491205120,16695243126607872,41363147411427328,41363537456533504,41364927394353152,121426317022334976,1255336077691064320,1255336361339260928,1255336455472025601,1255336553971060737,1504979451061080064,1504979514625757184,1504979657576026112,1504982921558233088,1504995781688561664,1504999438307954688,1505014337784385536,1505002139590725632,1505002287876149248,1505009144820797440,1505017592660758528,1505109130346631168,1505018607032209408,1505018691115421696,1505110284296130560"}', 'POST', '/zwz/role/editRolePerm', 'admin', 2, 'ROLE-04', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590511407693172736, NULL, '2022-11-10 09:07:25', 0, NULL, '2022-11-10 09:07:25', 64, '127.0.0.1', '本地测试', '查询菜单', '{}', 'GET', '/zwz/permission/getMenuList', 'admin', 2, 'PERMISSION-02', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590511408230043651, NULL, '2022-11-10 09:07:25', 0, NULL, '2022-11-10 09:07:25', 31, '127.0.0.1', '本地测试', '查询角色', '{"pageNumber":"1","pageSize":"15","sort":"createTime","order":"desc"}', 'GET', '/zwz/role/getAllByPage', 'admin', 2, 'ROLE-02', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590511411153473536, NULL, '2022-11-10 09:07:25', 0, NULL, '2022-11-10 09:07:25', 41, '127.0.0.1', '本地测试', '查询子部门', '{}', 'GET', '/zwz/department/getByParentId', 'admin', 2, 'DEP-01', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590511412420153344, NULL, '2022-11-10 09:07:26', 0, NULL, '2022-11-10 09:07:26', 25, '127.0.0.1', '本地测试', '查询全部角色', '{}', 'GET', '/zwz/role/getAllList', 'admin', 2, 'ROLE-01', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590511412445319168, NULL, '2022-11-10 09:07:26', 0, NULL, '2022-11-10 09:07:26', 73, '127.0.0.1', '本地测试', '查询单个数据字典的值', '{}', 'GET', '/zwz/dictData/getByType/sex', 'admin', 2, 'DICT_DATA-01', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590511412512428032, NULL, '2022-11-10 09:07:26', 0, NULL, '2022-11-10 09:07:26', 69, '127.0.0.1', '本地测试', '查询用户', '{"nickname":"","departmentId":"","pageNumber":"1","pageSize":"20","sort":"createTime","order":"desc"}', 'GET', '/zwz/user/getUserList', 'admin', 2, 'USER-07', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590511412634062850, NULL, '2022-11-10 09:07:26', 0, NULL, '2022-11-10 09:07:26', 31, '127.0.0.1', '本地测试', '查询子部门', '{}', 'GET', '/zwz/department/getByParentId', 'admin', 2, 'DEP-01', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590511433286815744, NULL, '2022-11-10 09:07:31', 0, NULL, '2022-11-10 09:07:31', 48, '127.0.0.1', '本地测试', '查询角色', '{"pageNumber":"1","pageSize":"15","sort":"createTime","order":"desc"}', 'GET', '/zwz/role/getAllByPage', 'admin', 2, 'ROLE-02', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590511550475669504, NULL, '2022-11-10 09:07:59', 0, NULL, '2022-11-10 09:07:59', 87, '127.0.0.1', '本地测试', '修改菜单权限', '{"roleId":"496138616573952","permIds":"125909152017944576,1464484663442673664,5129710648430593,1464485105081913345,40238597734928384,1464485485316542465,56309618086776832,75002207560273920,1464514283202285568,5129710648430592,5129710648430594,5129710648430595,39915540965232640,41363147411427328,1504979451061080064,1504979514625757184,1504979657576026112,1504982921558233088,1504995781688561664,1504999438307954688,1505014337784385536,1505002139590725632,1505002287876149248,1505009144820797440,1505017592660758528,1505109130346631168,1505018607032209408,1505018691115421696,1505110284296130560"}', 'POST', '/zwz/role/editRolePerm', 'admin', 2, 'ROLE-04', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590511552128225280, NULL, '2022-11-10 09:07:59', 0, NULL, '2022-11-10 09:07:59', 28, '127.0.0.1', '本地测试', '查询角色', '{"pageNumber":"1","pageSize":"15","sort":"createTime","order":"desc"}', 'GET', '/zwz/role/getAllByPage', 'admin', 2, 'ROLE-02', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590511552191139840, NULL, '2022-11-10 09:07:59', 0, NULL, '2022-11-10 09:07:59', 89, '127.0.0.1', '本地测试', '查询菜单', '{}', 'GET', '/zwz/permission/getMenuList', 'admin', 2, 'PERMISSION-02', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590511555160707073, NULL, '2022-11-10 09:08:00', 0, NULL, '2022-11-10 09:08:00', 25, '127.0.0.1', '本地测试', '查询子部门', '{}', 'GET', '/zwz/department/getByParentId', 'admin', 2, 'DEP-01', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590511556427386880, NULL, '2022-11-10 09:08:00', 0, NULL, '2022-11-10 09:08:00', 22, '127.0.0.1', '本地测试', '查询全部角色', '{}', 'GET', '/zwz/role/getAllList', 'admin', 2, 'ROLE-01', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590511556431581184, NULL, '2022-11-10 09:08:00', 0, NULL, '2022-11-10 09:08:00', 23, '127.0.0.1', '本地测试', '查询单个数据字典的值', '{}', 'GET', '/zwz/dictData/getByType/sex', 'admin', 2, 'DICT_DATA-01', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590511556469329920, NULL, '2022-11-10 09:08:00', 0, NULL, '2022-11-10 09:08:00', 69, '127.0.0.1', '本地测试', '查询用户', '{"nickname":"","departmentId":"","pageNumber":"1","pageSize":"20","sort":"createTime","order":"desc"}', 'GET', '/zwz/user/getUserList', 'admin', 2, 'USER-07', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590511556574187520, NULL, '2022-11-10 09:08:00', 0, NULL, '2022-11-10 09:08:00', 29, '127.0.0.1', '本地测试', '查询子部门', '{}', 'GET', '/zwz/department/getByParentId', 'admin', 2, 'DEP-01', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590511563859693568, NULL, '2022-11-10 09:08:02', 0, NULL, '2022-11-10 09:08:02', 38, '127.0.0.1', '本地测试', '查询子部门', '{}', 'GET', '/zwz/department/getByParentId', 'admin', 2, 'DEP-01', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590511563859693569, NULL, '2022-11-10 09:08:02', 0, NULL, '2022-11-10 09:08:02', 37, '127.0.0.1', '本地测试', '查询用户', '{"pageNumber":"1","pageSize":"10","sort":"createTime","order":"desc","departmentId":""}', 'GET', '/zwz/myUser/getByPage', 'admin', 2, 'USER-01', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590511564895686656, NULL, '2022-11-10 09:08:02', 0, NULL, '2022-11-10 09:08:02', 35, '127.0.0.1', '本地测试', '查询子部门', '{}', 'GET', '/zwz/department/getByParentId', 'admin', 2, 'DEP-01', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590511568720891904, NULL, '2022-11-10 09:08:03', 0, NULL, '2022-11-10 09:08:03', 29, '127.0.0.1', '本地测试', '查询角色', '{"pageNumber":"1","pageSize":"15","sort":"createTime","order":"desc"}', 'GET', '/zwz/role/getAllByPage', 'admin', 2, 'ROLE-02', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590511574542585857, NULL, '2022-11-10 09:08:04', 0, NULL, '2022-11-10 09:08:04', 26, '127.0.0.1', '本地测试', '查询单个数据字典的值', '{}', 'GET', '/zwz/dictData/getByType/permission_type', 'admin', 2, 'DICT_DATA-01', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590511583241572352, NULL, '2022-11-10 09:08:06', 0, NULL, '2022-11-10 09:08:06', 78, '127.0.0.1', '本地测试', '查看单个配置', '{"id":"FILE_PATH"}', 'GET', '/zwz/setting/getOne', 'admin', 2, 'SETTING-01', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590511583241572353, NULL, '2022-11-10 09:08:06', 0, NULL, '2022-11-10 09:08:06', 31, '127.0.0.1', '本地测试', '查看单个配置', '{"id":"FILE_VIEW"}', 'GET', '/zwz/setting/getOne', 'admin', 2, 'SETTING-01', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590511583241572354, NULL, '2022-11-10 09:08:06', 0, NULL, '2022-11-10 09:08:06', 30, '127.0.0.1', '本地测试', '查看单个配置', '{"id":"FILE_HTTP"}', 'GET', '/zwz/setting/getOne', 'admin', 2, 'SETTING-01', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590511592594870272, NULL, '2022-11-10 09:08:09', 0, NULL, '2022-11-10 09:08:09', 38, '127.0.0.1', '本地测试', '查询所有数据字典', '{}', 'GET', '/zwz/dict/getAll', 'admin', 2, 'DICT-01', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590511592712310784, NULL, '2022-11-10 09:08:09', 0, NULL, '2022-11-10 09:08:09', 53, '127.0.0.1', '本地测试', '查询数据字典值', '{"name":"","status":"","pageNumber":"1","pageSize":"10","sort":"sortOrder","order":"asc"}', 'GET', '/zwz/dictData/getByCondition', 'admin', 2, 'DICT_DATA-02', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590511673863704578, NULL, '2022-11-10 09:08:28', 0, NULL, '2022-11-10 09:08:28', 82, '127.0.0.1', '本地测试', '查询日志', '{"logType":"1","pageNumber":"1","pageSize":"15","startDate":"","endDate":"","sort":"createTime","order":"desc","ipInfo":"","key":""}', 'GET', '/zwz/log/getAllByPage', 'admin', 2, 'LOG-01', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590511689760116736, NULL, '2022-11-10 09:08:32', 0, NULL, '2022-11-10 09:08:32', 23, '127.0.0.1', '本地测试', '查询单个数据字典的值', '{}', 'GET', '/zwz/dictData/getByType/permission_type', 'admin', 2, 'DICT_DATA-01', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590512238307971072, NULL, '2022-11-10 09:10:43', 0, NULL, '2022-11-10 09:10:43', 89, '127.0.0.1', '本地测试', '删除菜单', '{"ids":"15701400130424832,16678126574637056,15701915807518720,15708892205944832,16678447719911424,25014528525733888,56898976661639168,156365156580855808"}', 'POST', '/zwz/permission/delByIds', 'admin', 2, 'PERMISSION-05', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590512239419461632, NULL, '2022-11-10 09:10:43', 0, NULL, '2022-11-10 09:10:43', 57, '127.0.0.1', '本地测试', '查询菜单', '{}', 'GET', '/zwz/permission/getMenuList', 'admin', 2, 'PERMISSION-02', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590512240040218624, NULL, '2022-11-10 09:10:43', 0, NULL, '2022-11-10 09:10:43', 47, '127.0.0.1', '本地测试', '查询单个数据字典的值', '{}', 'GET', '/zwz/dictData/getByType/permission_type', 'admin', 2, 'DICT_DATA-01', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590512240207990784, NULL, '2022-11-10 09:10:43', 0, NULL, '2022-11-10 09:10:43', 76, '127.0.0.1', '本地测试', '查询全部菜单', '{}', 'GET', '/zwz/permission/getAllList', 'admin', 2, 'PERMISSION-04', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590512285774909440, NULL, '2022-11-10 09:10:54', 0, NULL, '2022-11-10 09:10:54', 94, '127.0.0.1', '本地测试', '删除菜单', '{"ids":"45235621697949696,45235787867885568,45235939278065664,57212882168844288,61560041605435392,61560275261722624,61560480518377472,76215889006956544,76216071333351424,76216264070008832,76216459709124608,76216594207870976,76216702639017984,1464486736955576321"}', 'POST', '/zwz/permission/delByIds', 'admin', 2, 'PERMISSION-05', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590512287578460160, NULL, '2022-11-10 09:10:54', 0, NULL, '2022-11-10 09:10:54', 41, '127.0.0.1', '本地测试', '查询单个数据字典的值', '{}', 'GET', '/zwz/dictData/getByType/permission_type', 'admin', 2, 'DICT_DATA-01', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590512287582654464, NULL, '2022-11-10 09:10:54', 0, NULL, '2022-11-10 09:10:54', 78, '127.0.0.1', '本地测试', '查询菜单', '{}', 'GET', '/zwz/permission/getMenuList', 'admin', 2, 'PERMISSION-02', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590512287817535488, NULL, '2022-11-10 09:10:54', 0, NULL, '2022-11-10 09:10:54', 100, '127.0.0.1', '本地测试', '查询全部菜单', '{}', 'GET', '/zwz/permission/getAllList', 'admin', 2, 'PERMISSION-04', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590512319014768640, NULL, '2022-11-10 09:11:02', 0, NULL, '2022-11-10 09:11:02', 83, '127.0.0.1', '本地测试', '删除菜单', '{"ids":"16687383932047360,16689632049631232,16689745006432256,16689883993083904,16690313745666048,16694861252005888,16695107491205120,16695243126607872"}', 'POST', '/zwz/permission/delByIds', 'admin', 2, 'PERMISSION-05', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590512320767987712, NULL, '2022-11-10 09:11:02', 0, NULL, '2022-11-10 09:11:02', 37, '127.0.0.1', '本地测试', '查询单个数据字典的值', '{}', 'GET', '/zwz/dictData/getByType/permission_type', 'admin', 2, 'DICT_DATA-01', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590512320772182017, NULL, '2022-11-10 09:11:02', 0, NULL, '2022-11-10 09:11:02', 67, '127.0.0.1', '本地测试', '查询菜单', '{}', 'GET', '/zwz/permission/getMenuList', 'admin', 2, 'PERMISSION-02', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590512320981897216, NULL, '2022-11-10 09:11:02', 0, NULL, '2022-11-10 09:11:02', 90, '127.0.0.1', '本地测试', '查询全部菜单', '{}', 'GET', '/zwz/permission/getAllList', 'admin', 2, 'PERMISSION-04', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590512342725169152, NULL, '2022-11-10 09:11:08', 0, NULL, '2022-11-10 09:11:08', 76, '127.0.0.1', '本地测试', '删除菜单', '{"ids":"41363537456533504,41364927394353152,121426317022334976,1255336077691064320,1255336361339260928,1255336455472025601,1255336553971060737"}', 'POST', '/zwz/permission/delByIds', 'admin', 2, 'PERMISSION-05', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590512344444833793, NULL, '2022-11-10 09:11:08', 0, NULL, '2022-11-10 09:11:08', 35, '127.0.0.1', '本地测试', '查询单个数据字典的值', '{}', 'GET', '/zwz/dictData/getByType/permission_type', 'admin', 2, 'DICT_DATA-01', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590512344449028096, NULL, '2022-11-10 09:11:08', 0, NULL, '2022-11-10 09:11:08', 66, '127.0.0.1', '本地测试', '查询菜单', '{}', 'GET', '/zwz/permission/getMenuList', 'admin', 2, 'PERMISSION-02', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590512344570662912, NULL, '2022-11-10 09:11:08', 0, NULL, '2022-11-10 09:11:08', 63, '127.0.0.1', '本地测试', '查询全部菜单', '{}', 'GET', '/zwz/permission/getAllList', 'admin', 2, 'PERMISSION-04', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590512359896649728, NULL, '2022-11-10 09:11:12', 0, NULL, '2022-11-10 09:11:12', 38, '127.0.0.1', '本地测试', '查询角色', '{"pageNumber":"1","pageSize":"15","sort":"createTime","order":"desc"}', 'GET', '/zwz/role/getAllByPage', 'admin', 2, 'ROLE-02', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590512385364463616, NULL, '2022-11-10 09:11:18', 0, NULL, '2022-11-10 09:11:18', 87, '127.0.0.1', '本地测试', '查询全部角色', '{}', 'GET', '/zwz/role/getAllList', 'admin', 2, 'ROLE-01', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590512385385435136, NULL, '2022-11-10 09:11:18', 0, NULL, '2022-11-10 09:11:18', 81, '127.0.0.1', '本地测试', '查询单个数据字典的值', '{}', 'GET', '/zwz/dictData/getByType/sex', 'admin', 2, 'DICT_DATA-01', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590512385402212352, NULL, '2022-11-10 09:11:18', 0, NULL, '2022-11-10 09:11:18', 88, '127.0.0.1', '本地测试', '查询子部门', '{}', 'GET', '/zwz/department/getByParentId', 'admin', 2, 'DEP-01', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590512385486098432, NULL, '2022-11-10 09:11:18', 0, NULL, '2022-11-10 09:11:18', 98, '127.0.0.1', '本地测试', '查询用户', '{"nickname":"","departmentId":"","pageNumber":"1","pageSize":"20","sort":"createTime","order":"desc"}', 'GET', '/zwz/user/getUserList', 'admin', 2, 'USER-07', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590512386383679492, NULL, '2022-11-10 09:11:18', 0, NULL, '2022-11-10 09:11:18', 26, '127.0.0.1', '本地测试', '查询子部门', '{}', 'GET', '/zwz/department/getByParentId', 'admin', 2, 'DEP-01', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590512460689969152, NULL, '2022-11-10 09:11:36', 0, NULL, '2022-11-10 09:11:36', 68, '127.0.0.1', '本地测试', '查询子部门', '{}', 'GET', '/zwz/department/getByParentId', 'admin', 2, 'DEP-01', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590512462040535040, NULL, '2022-11-10 09:11:36', 0, NULL, '2022-11-10 09:11:36', 25, '127.0.0.1', '本地测试', '查询全部角色', '{}', 'GET', '/zwz/role/getAllList', 'admin', 2, 'ROLE-01', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590512462048923648, NULL, '2022-11-10 09:11:36', 0, NULL, '2022-11-10 09:11:36', 72, '127.0.0.1', '本地测试', '查询单个数据字典的值', '{}', 'GET', '/zwz/dictData/getByType/sex', 'admin', 2, 'DICT_DATA-01', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590512462137004032, NULL, '2022-11-10 09:11:36', 0, NULL, '2022-11-10 09:11:36', 48, '127.0.0.1', '本地测试', '查询用户', '{"nickname":"","departmentId":"","pageNumber":"1","pageSize":"20","sort":"createTime","order":"desc"}', 'GET', '/zwz/user/getUserList', 'admin', 2, 'USER-07', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590512462292193282, NULL, '2022-11-10 09:11:36', 0, NULL, '2022-11-10 09:11:36', 31, '127.0.0.1', '本地测试', '查询子部门', '{}', 'GET', '/zwz/department/getByParentId', 'admin', 2, 'DEP-01', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590512624116830208, NULL, '2022-11-10 09:12:15', 0, NULL, '2022-11-10 09:12:15', 68, '127.0.0.1', '本地测试', '登录系统', '{"username":"stu","password":"","code":"2257","captchaId":"93eec5b1e7264a58aabea3f11a4ae103","saveLogin":"true"}', 'POST', '/zwz/login', 'stu', 1, '', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590512624154578944, NULL, '2022-11-10 09:12:15', 0, NULL, '2022-11-10 09:12:15', 120, '127.0.0.1', '本地测试', '获取当前登录用户', '{}', 'GET', '/zwz/user/info', 'stu', 2, 'USER-02', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590512624917942272, NULL, '2022-11-10 09:12:15', 0, NULL, '2022-11-10 09:12:15', 51, '127.0.0.1', '本地测试', '查询菜单', '{}', 'GET', '/zwz/permission/getMenuList', 'stu', 2, 'PERMISSION-02', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590512625173794816, NULL, '2022-11-10 09:12:15', 0, NULL, '2022-11-10 09:12:15', 27, '127.0.0.1', '本地测试', '查询个人门户菜单B', '{}', 'POST', '/zwz/myDoor/getMyDoorList6', 'stu', 2, 'MY-DOOR-02', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590512663669116928, NULL, '2022-11-10 09:12:24', 0, NULL, '2022-11-10 09:12:24', 51, '127.0.0.1', '本地测试', '登录系统', '{"username":"tea","password":"","code":"4082","captchaId":"ed29b3d0108e4fd5a5c803108b0f12f3","saveLogin":"true"}', 'POST', '/zwz/login', 'tea', 1, '', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590512663706865664, NULL, '2022-11-10 09:12:24', 0, NULL, '2022-11-10 09:12:24', 61, '127.0.0.1', '本地测试', '获取当前登录用户', '{}', 'GET', '/zwz/user/info', 'tea', 2, 'USER-02', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590512664113713152, NULL, '2022-11-10 09:12:24', 0, NULL, '2022-11-10 09:12:24', 46, '127.0.0.1', '本地测试', '查询菜单', '{}', 'GET', '/zwz/permission/getMenuList', 'tea', 2, 'PERMISSION-02', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590512664445063169, NULL, '2022-11-10 09:12:24', 0, NULL, '2022-11-10 09:12:24', 30, '127.0.0.1', '本地测试', '查询个人门户菜单B', '{}', 'POST', '/zwz/myDoor/getMyDoorList6', 'tea', 2, 'MY-DOOR-02', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590513061591126016, NULL, '2022-11-10 09:13:59', 0, NULL, '2022-11-10 09:13:59', 71, '127.0.0.1', '本地测试', '登录系统', '{"username":"admin","password":"","code":"7582","captchaId":"5211aeb927b24a9883b78c98ce79e869","saveLogin":"true"}', 'POST', '/zwz/login', 'admin', 1, '', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590513061628874752, NULL, '2022-11-10 09:13:59', 0, NULL, '2022-11-10 09:13:59', 53, '127.0.0.1', '本地测试', '获取当前登录用户', '{}', 'GET', '/zwz/user/info', 'admin', 2, 'USER-02', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590513061981196288, NULL, '2022-11-10 09:13:59', 0, NULL, '2022-11-10 09:13:59', 31, '127.0.0.1', '本地测试', '查询菜单', '{}', 'GET', '/zwz/permission/getMenuList', 'admin', 2, 'PERMISSION-02', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590513062354489344, NULL, '2022-11-10 09:13:59', 0, NULL, '2022-11-10 09:13:59', 24, '127.0.0.1', '本地测试', '查询个人门户菜单B', '{}', 'POST', '/zwz/myDoor/getMyDoorList6', 'admin', 2, 'MY-DOOR-02', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590513355892854784, NULL, '2022-11-10 09:15:09', 0, NULL, '2022-11-10 09:15:09', 81, '127.0.0.1', '本地测试', '查询菜单', '{}', 'GET', '/zwz/permission/getMenuList', 'admin', 2, 'PERMISSION-02', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590513356178067456, NULL, '2022-11-10 09:15:09', 0, NULL, '2022-11-10 09:15:09', 57, '127.0.0.1', '本地测试', '查询个人门户菜单B', '{}', 'POST', '/zwz/myDoor/getMyDoorList6', 'admin', 2, 'MY-DOOR-02', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590513380618276866, NULL, '2022-11-10 09:15:15', 0, NULL, '2022-11-10 09:15:15', 63, '127.0.0.1', '本地测试', '查询单个数据字典的值', '{}', 'GET', '/zwz/dictData/getByType/sex', 'admin', 2, 'DICT_DATA-01', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590513448557613056, NULL, '2022-11-10 09:15:31', 0, NULL, '2022-11-10 09:15:31', 82, '127.0.0.1', '本地测试', '修改个人门户菜单', '{"str":"user-adminZWZ666department-adminZWZ666log-pageZWZ666wenJuanOneZWZ666competitionZWZ666pinDeWenJuan"}', 'POST', '/zwz/myDoor/setMyDoorList', 'admin', 2, 'MY-DOOR-03', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590513454853263361, NULL, '2022-11-10 09:15:33', 0, NULL, '2022-11-10 09:15:33', 65, '127.0.0.1', '本地测试', '查询个人门户菜单B', '{}', 'POST', '/zwz/myDoor/getMyDoorList6', 'admin', 2, 'MY-DOOR-02', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590513461601898496, NULL, '2022-11-10 09:15:34', 0, NULL, '2022-11-10 09:15:34', 33, '127.0.0.1', '本地测试', '查询子部门', '{}', 'GET', '/zwz/department/getByParentId', 'admin', 2, 'DEP-01', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590513462885355523, NULL, '2022-11-10 09:15:35', 0, NULL, '2022-11-10 09:15:35', 30, '127.0.0.1', '本地测试', '查询全部角色', '{}', 'GET', '/zwz/role/getAllList', 'admin', 2, 'ROLE-01', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590513462889549824, NULL, '2022-11-10 09:15:35', 0, NULL, '2022-11-10 09:15:35', 33, '127.0.0.1', '本地测试', '查询单个数据字典的值', '{}', 'GET', '/zwz/dictData/getByType/sex', 'admin', 2, 'DICT_DATA-01', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590513462939881472, NULL, '2022-11-10 09:15:35', 0, NULL, '2022-11-10 09:15:35', 82, '127.0.0.1', '本地测试', '查询用户', '{"nickname":"","departmentId":"","pageNumber":"1","pageSize":"20","sort":"createTime","order":"desc"}', 'GET', '/zwz/user/getUserList', 'admin', 2, 'USER-07', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590513463057321984, NULL, '2022-11-10 09:15:35', 0, NULL, '2022-11-10 09:15:35', 37, '127.0.0.1', '本地测试', '查询子部门', '{}', 'GET', '/zwz/department/getByParentId', 'admin', 2, 'DEP-01', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016'),
	(1590513467549421568, NULL, '2022-11-10 09:15:36', 0, NULL, '2022-11-10 09:15:36', 38, '127.0.0.1', '本地测试', '查询个人门户菜单B', '{}', 'POST', '/zwz/myDoor/getMyDoorList6', 'admin', 2, 'MY-DOOR-02', 'PC端 | Chrome 106.0.0.0 | Windows Windows 10 or Windows Server 2016');

DROP TABLE IF EXISTS `a_permission`;
CREATE TABLE IF NOT EXISTS `a_permission` (
  `id` bigint unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `parent_id` bigint unsigned DEFAULT NULL,
  `type` tinyint(1) DEFAULT NULL,
  `sort_order` decimal(10,2) DEFAULT NULL,
  `component` varchar(255) DEFAULT NULL,
  `path` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `level` int unsigned DEFAULT NULL,
  `button_type` varchar(255) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `show_always` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

DELETE FROM `a_permission`;
INSERT INTO `a_permission` (`id`, `create_by`, `create_time`, `del_flag`, `update_by`, `update_time`, `description`, `name`, `parent_id`, `type`, `sort_order`, `component`, `path`, `title`, `icon`, `level`, `button_type`, `status`, `url`, `show_always`) VALUES
	(5129710648430592, '', '2022-03-19 11:53:33', 0, 'admin', '2022-03-19 11:53:33', '', 'sys', 125909152017944576, 0, 4.00, 'Main', '/sys', '权限管理', 'ios-settings', 1, '', 0, '', b'1'),
	(5129710648430593, '', '2022-03-19 11:53:33', 0, 'admin', '2022-03-19 11:53:33', '', 'user-admin', 1464484663442673664, 0, 1.10, 'roster/user/user', 'user-admin', '学生档案', 'md-person', 2, '', 0, '', b'1'),
	(5129710648430594, '', '2022-03-19 11:53:33', 0, '', '2022-03-19 11:53:33', '', 'role-menu', 5129710648430592, 0, 1.60, 'role/role/index', 'role-menu', '角色权限管理', 'md-contacts', 2, '', 0, '', b'1'),
	(5129710648430595, '', '2022-03-19 11:53:33', 0, 'admin', '2022-03-19 11:53:33', '', 'menu-page', 5129710648430592, 0, 1.70, 'menu/menu/index', 'menu-page', '菜单权限管理', 'md-menu', 2, '', 0, '', b'1'),
	(39915540965232640, '', '2022-03-19 11:53:33', 0, 'admin', '2022-03-19 11:53:33', '', 'monitor', 125909152017944576, 0, 10.00, 'Main', '/monitor', '日志管理', 'ios-analytics', 1, '', 0, '', b'1'),
	(40238597734928384, '', '2022-03-19 11:53:33', 0, 'admin', '2022-03-19 11:53:33', '', 'department-admin', 1464485105081913345, 0, 1.20, 'roster/department/department', 'department-admin', '班级档案', 'md-git-branch', 2, '', 0, '', b'1'),
	(41363147411427328, '', '2022-03-19 11:53:33', 0, 'admin', '2022-03-19 11:53:33', '', 'log-page', 39915540965232640, 0, 2.20, 'log/log/index', 'log-page', '日志管理', 'md-list-box', 2, '', 0, '', b'1'),
	(56309618086776832, '', '2022-03-19 11:53:33', 0, 'admin', '2022-03-19 11:53:33', '', 'file-page', 1464485485316542465, 0, 1.00, 'file/file/index', 'file-page', '文件对象存储', 'ios-folder', 2, '', 0, '', b'1'),
	(75002207560273920, 'admin', '2022-03-19 11:53:33', 0, 'admin', '2022-03-19 11:53:33', '', 'dict-page', 1464485485316542465, 0, 2.00, 'dict/dict/index', 'dict-page', '数据字典管理', 'md-bookmarks', 2, '', 0, '', b'1'),
	(125909152017944576, 'admin', '2022-03-19 11:53:33', 0, 'admin', '2022-03-19 11:53:33', '', 'zwz', 0, -1, 1.00, '', '', '数据中心', 'md-home', 0, '', 0, '', b'1'),
	(1464484663442673664, 'admin', '2022-03-19 11:53:33', 0, 'admin', '2022-03-19 11:53:33', '', 'userTwoMenu', 125909152017944576, 0, 1.00, 'Main', '/userTwoMenu', '学生管理', 'md-analytics', 1, '', 0, '', b'1'),
	(1464485105081913345, 'admin', '2022-03-19 11:53:33', 0, 'admin', '2022-03-19 11:53:33', '', 'depTwoMenu', 125909152017944576, 0, 2.00, 'Main', '/depTwoMenu', '班级管理', 'ios-apps', 1, '', 0, '', b'1'),
	(1464485485316542465, 'admin', '2022-03-19 11:53:33', 0, 'admin', '2022-03-19 11:53:33', '', 'fileAdmin', 125909152017944576, 0, 3.00, 'Main', '/fileAdmin', '资源管理', 'md-basketball', 1, '', 0, '', b'1'),
	(1464514283202285568, 'admin', '2022-03-19 11:53:33', 0, 'admin', '2022-03-19 11:53:33', NULL, 'vue-code', 1464485485316542465, 0, 4.00, 'code/vue/index', 'vue-code', 'Vue', 'md-analytics', 2, '', 0, NULL, b'1'),
	(1504979451061080064, 'admin', '2022-03-19 11:53:33', 0, NULL, '2022-03-19 11:53:33', NULL, 'zhpj', 0, -1, 2.00, NULL, NULL, '综合评价', 'md-aperture', 0, NULL, 0, NULL, b'1'),
	(1504979514625757184, 'admin', '2022-03-19 11:53:33', 0, NULL, '2022-03-19 11:53:33', NULL, 'student', 1504979451061080064, 0, 1.00, 'Main', '/student', '学生模块', 'md-apps', 1, '', 0, NULL, b'1'),
	(1504979657576026112, 'admin', '2022-03-19 11:53:33', 0, 'admin', '2022-03-19 11:53:33', '', 'yuShuWaiLook', 1504979514625757184, 0, 1.00, 'stu/yuShuWaiLook/index', 'yuShuWaiLook', '查询成绩', 'md-aperture', 2, '', 0, '', b'1'),
	(1504982921558233088, 'admin', '2022-03-19 11:53:33', 0, 'admin', '2022-03-19 11:53:33', '', 'wenJuanOne', 1504979514625757184, 0, 2.00, 'stu/xueYeWenJuan/index', 'wenJuanOne', '学业自评问卷', 'md-aperture', 2, '', 0, '', b'1'),
	(1504995781688561664, 'admin', '2022-03-19 11:53:33', 0, NULL, '2022-03-19 11:53:33', NULL, 'competition', 1504979514625757184, 0, 3.00, 'stu/competition/index', 'competition', '我的竞赛', 'md-aperture', 2, '', 0, NULL, b'1'),
	(1504999438307954688, 'admin', '2022-03-19 11:53:33', 0, NULL, '2022-03-19 11:53:33', NULL, 'pinDeWenJuan', 1504979514625757184, 0, 4.00, 'stu/pinDeWenJuan/index', 'pinDeWenJuan', '品德自评问卷', 'ios-aperture', 2, '', 0, NULL, b'1'),
	(1505002139590725632, 'admin', '2022-03-19 11:53:33', 0, NULL, '2022-03-19 11:53:33', NULL, 'teacher', 1504979451061080064, 0, 2.00, 'Main', '/teacher', '教师模块', 'md-basketball', 1, '', 0, NULL, b'1'),
	(1505002287876149248, 'admin', '2022-03-19 11:53:33', 0, NULL, '2022-03-19 11:53:33', NULL, 'yuShuWaiEdit', 1505002139590725632, 0, 1.00, 'stu/yuShuWaiEdit/index', 'yuShuWaiEdit', '语数外打分', 'ios-clipboard', 2, '', 0, NULL, b'1'),
	(1505009144820797440, 'admin', '2022-03-19 11:53:33', 0, NULL, '2022-03-19 11:53:33', NULL, 'pinDeWenJuanTeacher', 1505002139590725632, 0, 2.00, 'stu/pinDeWenJuanTeacher/index', 'pinDeWenJuanTeacher', '教师品德问卷', 'md-barcode', 2, '', 0, NULL, b'1'),
	(1505014337784385536, 'admin', '2022-03-19 11:53:33', 0, NULL, '2022-03-19 11:53:33', NULL, 'shenXinWenJuan', 1504979514625757184, 0, 5.00, 'stu/shenXinWenJuan/index', 'shenXinWenJuan', '身心自评问卷', 'md-analytics', 2, '', 0, NULL, b'1'),
	(1505017592660758528, 'admin', '2022-03-19 11:53:33', 0, NULL, '2022-03-19 11:53:33', NULL, 'shenXinWenJuanTeacher', 1505002139590725632, 0, 3.00, 'stu/shenXinWenJuanTeacher/index', 'shenXinWenJuanTeacher', '教师身心问卷', 'md-build', 2, '', 0, NULL, b'1'),
	(1505018607032209408, 'admin', '2022-03-19 11:53:33', 0, NULL, '2022-03-19 11:53:33', NULL, 'jiaoWuChu', 1504979451061080064, 0, 3.00, 'Main', '/jiaoWuChu', '教务处模块', 'md-bulb', 1, '', 0, NULL, b'1'),
	(1505018691115421696, 'admin', '2022-03-19 11:53:33', 0, NULL, '2022-03-19 11:53:33', NULL, 'sports', 1505018607032209408, 0, 1.00, 'stu/sports/index', 'sports', '体育打分', 'md-bug', 2, '', 0, NULL, b'1'),
	(1505109130346631168, 'admin', '2022-03-19 17:09:15', 0, NULL, NULL, NULL, 'yuShuWaiLookTea', 1505002139590725632, 0, 4.00, 'stu/yuShuWaiLookTea/index', 'yuShuWaiLookTea', '查看学生成绩', 'md-at', 2, '', 0, NULL, b'1'),
	(1505110284296130560, 'admin', '2022-03-19 17:13:50', 0, 'admin', '2022-03-19 17:16:43', '', 'yuShuWaiLookJwc', 1505018607032209408, 0, 1.00, 'stu/yuShuWaiLookJwc/index', 'yuShuWaiLookJwc', '查看学生成绩', 'md-archive', 2, '', 0, '', b'1');

DROP TABLE IF EXISTS `a_questionnaire`;
CREATE TABLE IF NOT EXISTS `a_questionnaire` (
  `id` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci NOT NULL,
  `create_by` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci DEFAULT NULL,
  `create_time` datetime(6) DEFAULT NULL,
  `del_flag` int NOT NULL,
  `update_by` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci DEFAULT NULL,
  `update_time` datetime(6) DEFAULT NULL,
  `evaluate_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci DEFAULT NULL,
  `type` int NOT NULL,
  `value` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci DEFAULT NULL,
  `status` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_croatian_ci;

DELETE FROM `a_questionnaire`;
INSERT INTO `a_questionnaire` (`id`, `create_by`, `create_time`, `del_flag`, `update_by`, `update_time`, `evaluate_id`, `type`, `value`, `status`) VALUES
	('1505029615649951747', 'admin', '2022-03-19 11:53:17.128000', 0, NULL, NULL, '1504979707307888640', 1, '10,10,10,20,20,15,10', 1),
	('1505029728162156544', 'admin', '2022-03-19 11:53:43.952000', 0, NULL, NULL, '1504979707307888640', 2, '20,20,20,20,10', 1),
	('1505029852259028993', 'admin', '2022-03-19 11:54:13.540000', 0, NULL, NULL, '1504979707307888640', 3, '20,20,15,15,15', 1),
	('1505029912631840768', 'admin', '2022-03-19 11:54:27.933000', 0, NULL, NULL, '1504979707307888640', 5, '10,10,20,20,20,20', 1),
	('1505029978876678144', 'admin', '2022-03-19 11:54:43.728000', 0, NULL, NULL, '1504979707307888640', 4, '10,10,15,20,20,20', 1),
	('1505132905591083009', 'stu', '2022-03-19 18:43:43.382000', 0, NULL, NULL, '1505007492093054976', 1, '10,10,10,20,20,20,10', 1),
	('1505132991666589697', 'stu', '2022-03-19 18:44:03.889000', 0, NULL, NULL, '1505007492093054976', 2, '20,20,20,20,20', 1),
	('1505133020129136640', 'stu', '2022-03-19 18:44:10.675000', 0, NULL, NULL, '1505007492093054976', 4, '10,10,20,20,20,20', 1),
	('1505133345997197312', 'tea', '2022-03-19 18:45:28.371000', 0, NULL, NULL, '1505007492181135360', 3, '20,20,20,20,20', 1),
	('1505133385155219456', 'tea', '2022-03-19 18:45:37.706000', 0, NULL, NULL, '1505007492181135360', 5, '10,10,20,20,15,15', 1);

DROP TABLE IF EXISTS `a_role`;
CREATE TABLE IF NOT EXISTS `a_role` (
  `id` bigint unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `default_role` bit(1) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `data_type` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

DELETE FROM `a_role`;
INSERT INTO `a_role` (`id`, `create_by`, `create_time`, `update_by`, `update_time`, `name`, `del_flag`, `default_role`, `description`, `data_type`) VALUES
	(496138616573952, '', '2022-03-19 11:53:33', 'admin', '2022-03-19 11:53:33', 'ROLE_ADMIN', 0, NULL, '超级管理员', 0),
	(496138616573953, '', '2022-03-19 11:53:33', 'admin', '2022-03-19 11:53:33', 'ROLE_USER', 0, b'1', '学生', 0),
	(1505046193472933888, 'admin', '2022-03-19 11:53:33', 'admin', '2022-03-19 11:53:33', 'ROLE_TEACHER', 0, b'0', '教师', 0),
	(1505046318576439296, 'admin', '2022-03-19 11:53:33', 'admin', '2022-03-19 11:53:33', 'ROLE_JIAOWU', 0, b'0', '教务处', 0);

DROP TABLE IF EXISTS `a_role_permission`;
CREATE TABLE IF NOT EXISTS `a_role_permission` (
  `id` bigint unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `permission_id` bigint unsigned DEFAULT NULL,
  `role_id` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

DELETE FROM `a_role_permission`;
INSERT INTO `a_role_permission` (`id`, `create_by`, `create_time`, `del_flag`, `update_by`, `update_time`, `permission_id`, `role_id`) VALUES
	(1464514325862551552, 'admin', '2022-03-19 11:53:33', 0, 'admin', '2022-03-19 11:53:33', 125909152017944576, 496138616573952),
	(1464514325862551553, 'admin', '2022-03-19 11:53:33', 0, 'admin', '2022-03-19 11:53:33', 1464484663442673664, 496138616573952),
	(1464514325862551554, 'admin', '2022-03-19 11:53:33', 0, 'admin', '2022-03-19 11:53:33', 5129710648430593, 496138616573952),
	(1464514325862551563, 'admin', '2022-03-19 11:53:33', 0, 'admin', '2022-03-19 11:53:33', 1464485105081913345, 496138616573952),
	(1464514325862551564, 'admin', '2022-03-19 11:53:33', 0, 'admin', '2022-03-19 11:53:33', 40238597734928384, 496138616573952),
	(1464514325862551569, 'admin', '2022-03-19 11:53:33', 0, 'admin', '2022-03-19 11:53:33', 56309618086776832, 496138616573952),
	(1464514325862551574, 'admin', '2022-03-19 11:53:33', 0, 'admin', '2022-03-19 11:53:33', 75002207560273920, 496138616573952),
	(1464514325862551582, 'admin', '2022-03-19 11:53:33', 0, 'admin', '2022-03-19 11:53:33', 1464514283202285568, 496138616573952),
	(1464514325862551583, 'admin', '2022-03-19 11:53:33', 0, 'admin', '2022-03-19 11:53:33', 5129710648430592, 496138616573952),
	(1464514325862551584, 'admin', '2022-03-19 11:53:33', 0, 'admin', '2022-03-19 11:53:33', 5129710648430594, 496138616573952),
	(1464514325862551590, 'admin', '2022-03-19 11:53:33', 0, 'admin', '2022-03-19 11:53:33', 5129710648430595, 496138616573952),
	(1464514325862551595, 'admin', '2022-03-19 11:53:33', 0, 'admin', '2022-03-19 11:53:33', 41363147411427328, 496138616573952),
	(1504979694284574722, 'admin', '2022-03-19 11:53:33', 0, NULL, '2022-03-19 11:53:33', 1504979451061080064, 496138616573952),
	(1504979694309740544, 'admin', '2022-03-19 11:53:33', 0, NULL, '2022-03-19 11:53:33', 1504979514625757184, 496138616573952),
	(1504979694322323456, 'admin', '2022-03-19 11:53:33', 0, NULL, '2022-03-19 11:53:33', 1504979657576026112, 496138616573952),
	(1504982942030630916, 'admin', '2022-03-19 11:53:33', 0, NULL, '2022-03-19 11:53:33', 1504982921558233088, 496138616573952),
	(1504995803150815232, 'admin', '2022-03-19 11:53:33', 0, NULL, '2022-03-19 11:53:33', 1504995781688561664, 496138616573952),
	(1504999461229826050, 'admin', '2022-03-19 11:53:33', 0, NULL, '2022-03-19 11:53:33', 1504999438307954688, 496138616573952),
	(1505002310810603522, 'admin', '2022-03-19 11:53:33', 0, NULL, '2022-03-19 11:53:33', 1505002139590725632, 496138616573952),
	(1505002310839963648, 'admin', '2022-03-19 11:53:33', 0, NULL, '2022-03-19 11:53:33', 1505002287876149248, 496138616573952),
	(1505009163384786946, 'admin', '2022-03-19 11:53:33', 0, NULL, '2022-03-19 11:53:33', 1505009144820797440, 496138616573952),
	(1505014373490495488, 'admin', '2022-03-19 11:53:33', 0, NULL, '2022-03-19 11:53:33', 1505014337784385536, 496138616573952),
	(1505017608888520710, 'admin', '2022-03-19 11:53:33', 0, NULL, '2022-03-19 11:53:33', 1505017592660758528, 496138616573952),
	(1505018872942694400, 'admin', '2022-03-19 11:53:33', 0, NULL, '2022-03-19 11:53:33', 1505018607032209408, 496138616573952),
	(1505018872959471616, 'admin', '2022-03-19 11:53:33', 0, NULL, '2022-03-19 11:53:33', 1505018691115421696, 496138616573952),
	(1505046224376565760, 'admin', '2022-03-19 11:53:33', 0, NULL, '2022-03-19 11:53:33', 1504979451061080064, 1505046193472933888),
	(1505046224389148672, 'admin', '2022-03-19 11:53:33', 0, NULL, '2022-03-19 11:53:33', 1505002139590725632, 1505046193472933888),
	(1505046224397537280, 'admin', '2022-03-19 11:53:33', 0, NULL, '2022-03-19 11:53:33', 1505002287876149248, 1505046193472933888),
	(1505046224405925888, 'admin', '2022-03-19 11:53:33', 0, NULL, '2022-03-19 11:53:33', 1505009144820797440, 1505046193472933888),
	(1505046224410120192, 'admin', '2022-03-19 11:53:33', 0, NULL, '2022-03-19 11:53:33', 1505017592660758528, 1505046193472933888),
	(1505046282727723008, 'admin', '2022-03-19 11:53:33', 0, NULL, '2022-03-19 11:53:33', 1504979451061080064, 496138616573953),
	(1505046282736111616, 'admin', '2022-03-19 11:53:33', 0, NULL, '2022-03-19 11:53:33', 1504979514625757184, 496138616573953),
	(1505046282744500224, 'admin', '2022-03-19 11:53:33', 0, NULL, '2022-03-19 11:53:33', 1504979657576026112, 496138616573953),
	(1505046282752888832, 'admin', '2022-03-19 11:53:33', 0, NULL, '2022-03-19 11:53:33', 1504982921558233088, 496138616573953),
	(1505046282761277440, 'admin', '2022-03-19 11:53:33', 0, NULL, '2022-03-19 11:53:33', 1504995781688561664, 496138616573953),
	(1505046282765471744, 'admin', '2022-03-19 11:53:33', 0, NULL, '2022-03-19 11:53:33', 1504999438307954688, 496138616573953),
	(1505046282773860352, 'admin', '2022-03-19 11:53:33', 0, NULL, '2022-03-19 11:53:33', 1505014337784385536, 496138616573953),
	(1505046348251140096, 'admin', '2022-03-19 11:53:33', 0, NULL, '2022-03-19 11:53:33', 1504979451061080064, 1505046318576439296),
	(1505046348263723008, 'admin', '2022-03-19 11:53:33', 0, NULL, '2022-03-19 11:53:33', 1505018607032209408, 1505046318576439296),
	(1505046348272111616, 'admin', '2022-03-19 11:53:33', 0, NULL, '2022-03-19 11:53:33', 1505018691115421696, 1505046318576439296),
	(1505109169798254593, 'admin', '2022-03-19 17:09:24', 0, NULL, NULL, 1505109130346631168, 496138616573952),
	(1505109187443691526, 'admin', '2022-03-19 17:09:29', 0, NULL, NULL, 1505109130346631168, 1505046193472933888),
	(1505110667139616768, 'admin', '2022-03-19 17:15:21', 0, NULL, NULL, 1505110284296130560, 496138616573952),
	(1505110682692096003, 'admin', '2022-03-19 17:15:25', 0, NULL, NULL, 1505110284296130560, 1505046318576439296),
	(1590511550400172048, 'admin', '2022-11-10 09:07:59', 0, NULL, NULL, 1464485485316542465, 496138616573952),
	(1590511550416949248, 'admin', '2022-11-10 09:07:59', 0, NULL, NULL, 39915540965232640, 496138616573952);

DROP TABLE IF EXISTS `a_setting`;
CREATE TABLE IF NOT EXISTS `a_setting` (
  `id` varchar(255) NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `value` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

DELETE FROM `a_setting`;
INSERT INTO `a_setting` (`id`, `create_by`, `create_time`, `del_flag`, `update_by`, `update_time`, `value`) VALUES
	('LOCAL_OSS', 'admin', '2022-03-19 11:53:33', 0, 'admin', '2022-03-19 11:53:33', '{"serviceName":"LOCAL_OSS","accessKey":"","secretKey":"**********","endpoint":"127.0.0.1:9999/zwz/file/view","bucket":"","http":"http://","bucketRegion":"","filePath":"C:\\\\oa-file"}'),
	('OSS_USED', 'admin', '2022-03-19 11:53:33', 0, 'admin', '2022-03-19 11:53:33', 'LOCAL_OSS');

DROP TABLE IF EXISTS `a_student`;
CREATE TABLE IF NOT EXISTS `a_student` (
  `id` varchar(255) COLLATE utf8_croatian_ci NOT NULL,
  `create_by` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `create_time` datetime(6) DEFAULT NULL,
  `del_flag` int NOT NULL,
  `update_by` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `update_time` datetime(6) DEFAULT NULL,
  `age` decimal(19,2) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `number` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `school` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `sex` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_croatian_ci;

DELETE FROM `a_student`;

DROP TABLE IF EXISTS `a_student_evaluate`;
CREATE TABLE IF NOT EXISTS `a_student_evaluate` (
  `id` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci NOT NULL,
  `create_by` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci DEFAULT NULL,
  `create_time` datetime(6) DEFAULT NULL,
  `del_flag` int NOT NULL,
  `update_by` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci DEFAULT NULL,
  `update_time` datetime(6) DEFAULT NULL,
  `achievement_one` decimal(19,2) DEFAULT NULL,
  `achievement_sum` decimal(19,2) DEFAULT NULL,
  `achievement_three` decimal(19,2) DEFAULT NULL,
  `achievement_two` decimal(19,2) DEFAULT NULL,
  `ans_one` decimal(19,2) DEFAULT NULL,
  `ans_sum` decimal(19,2) DEFAULT NULL,
  `ans_three` decimal(19,2) DEFAULT NULL,
  `ans_two` decimal(19,2) DEFAULT NULL,
  `competition_mine` decimal(19,2) DEFAULT NULL,
  `questionnaire_four` decimal(19,2) DEFAULT NULL,
  `questionnaire_one` decimal(19,2) DEFAULT NULL,
  `questionnaire_seven` decimal(19,2) DEFAULT NULL,
  `questionnaire_six` decimal(19,2) DEFAULT NULL,
  `questionnaire_three` decimal(19,2) DEFAULT NULL,
  `questionnaire_two` decimal(19,2) DEFAULT NULL,
  `user_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_croatian_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_croatian_ci;

DELETE FROM `a_student_evaluate`;
INSERT INTO `a_student_evaluate` (`id`, `create_by`, `create_time`, `del_flag`, `update_by`, `update_time`, `achievement_one`, `achievement_sum`, `achievement_three`, `achievement_two`, `ans_one`, `ans_sum`, `ans_three`, `ans_two`, `competition_mine`, `questionnaire_four`, `questionnaire_one`, `questionnaire_seven`, `questionnaire_six`, `questionnaire_three`, `questionnaire_two`, `user_id`) VALUES
	('1504979707307888640', 'admin', '2022-03-19 08:34:58.056000', 0, 'admin', '2022-03-19 11:54:54.147000', 60.00, 70.00, 80.00, 70.00, 92.50, 90.56, 91.67, 87.50, 10.00, 95.00, 95.00, 80.00, 100.00, 85.00, 90.00, '682265633886208'),
	('1505007492093054976', 'admin', '2022-03-19 10:25:22.475000', 0, 'tea', '2022-03-19 18:45:38.014000', 60.00, 70.00, 70.00, 80.00, 95.00, 86.11, 63.33, 100.00, 10.00, 100.00, 100.00, 0.00, 90.00, 100.00, 100.00, '1464764315201572865'),
	('1505007492181135360', 'admin', '2022-03-19 10:25:22.481000', 0, 'jwc', '2022-03-19 19:00:47.857000', 0.00, 0.00, 0.00, 0.00, 0.00, 8.89, 26.67, 0.00, 0.00, 0.00, 0.00, 80.00, 0.00, 0.00, 0.00, '1464772465946398721'),
	('1505108784769536000', 'admin', '2022-03-19 17:07:52.518000', 0, NULL, NULL, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '1464772465946398722'),
	('1505415242535014400', 'tea2', '2022-03-20 13:25:37.744000', 0, NULL, NULL, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '1505182864919105536'),
	('1505415242572763136', 'tea2', '2022-03-20 13:25:37.752000', 0, NULL, NULL, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '1505183049753694208');

DROP TABLE IF EXISTS `a_teacher_demo`;
CREATE TABLE IF NOT EXISTS `a_teacher_demo` (
  `id` varchar(255) COLLATE utf8_croatian_ci NOT NULL,
  `create_by` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `create_time` datetime(6) DEFAULT NULL,
  `del_flag` int NOT NULL,
  `update_by` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `update_time` datetime(6) DEFAULT NULL,
  `age` decimal(19,2) DEFAULT NULL,
  `autograph` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `education` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `graduated` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `remark` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `resume` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `status` varchar(255) COLLATE utf8_croatian_ci DEFAULT NULL,
  `wages` decimal(19,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_croatian_ci;

DELETE FROM `a_teacher_demo`;

DROP TABLE IF EXISTS `a_user`;
CREATE TABLE IF NOT EXISTS `a_user` (
  `id` bigint unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `mobile` varchar(255) DEFAULT NULL,
  `nickname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `sex` varchar(255) DEFAULT NULL,
  `status` int DEFAULT NULL,
  `type` int DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `department_id` bigint unsigned DEFAULT NULL,
  `street` varchar(255) DEFAULT NULL,
  `pass_strength` varchar(2) DEFAULT NULL,
  `department_title` varchar(255) DEFAULT NULL,
  `birth` datetime(6) DEFAULT NULL,
  `my_door` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`) USING BTREE,
  UNIQUE KEY `email` (`email`) USING BTREE,
  UNIQUE KEY `mobile` (`mobile`) USING BTREE,
  KEY `create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

DELETE FROM `a_user`;
INSERT INTO `a_user` (`id`, `create_by`, `create_time`, `update_by`, `update_time`, `address`, `avatar`, `description`, `email`, `mobile`, `nickname`, `password`, `sex`, `status`, `type`, `username`, `del_flag`, `department_id`, `street`, `pass_strength`, `department_title`, `birth`, `my_door`) VALUES
	(682265633886208, '', '2022-03-19 11:53:33', 'admin', '2022-11-10 09:15:31', '["330000","330600","330602"]', 'https://wx.qlogo.cn/mmhead/PiajxSqBRaEKjc639z2lRF4DqweNw2aDRLbAL7yLlSgrdZeKBCwLHDQ/0', '绍兴文理学院元培学院', '916077357@qq.com', '17857054385', '管理员', '$2a$10$PS04ecXfknNd3V8d.ymLTObQciapMU4xU8.GADBZZsuTZr7ymnagy', '男', 0, 1, 'admin', 0, 1505188058469896192, '东浦街道', '弱', '教师组', '2000-01-08 00:00:00.000000', 'user-adminZWZ666department-adminZWZ666log-pageZWZ666wenJuanOneZWZ666competitionZWZ666pinDeWenJuan'),
	(1464764315201572865, '', '2022-03-19 11:53:33', 'admin', '2022-03-19 11:53:33', '', 'https://wx.qlogo.cn/mmhead/PiajxSqBRaEKjc639z2lRF4DqweNw2aDRLbAL7yLlSgrdZeKBCwLHDQ/0', '', '17859654125@qq.com', '17859654125', '测试学生', '$2a$10$E59nactOiILAzQvfcs0JFOYuZp06d4bLhugEadyQuygpmiLc0W.ha', '女', 0, 0, 'stu', 0, 1464487524662644737, '', '', '计算机1801', NULL, NULL),
	(1464772465946398721, '', '2022-03-19 11:53:33', 'admin', '2022-03-20 12:54:35', '', 'https://wx.qlogo.cn/mmhead/PiajxSqBRaEKjc639z2lRF4DqweNw2aDRLbAL7yLlSgrdZeKBCwLHDQ/0', '', '17859654121@qq.com', '17859654121', '测试老师', '$2a$10$vJyLo1RhFORH/SAu3sc9aeb37I5JRy5UugaN7fIt/e2vvsz6JWJCm', '男', 0, 0, 'tea', 0, 1464487524662644737, '', '', '计算机1801', NULL, NULL),
	(1464772465946398722, '', '2022-03-19 11:53:33', 'admin', '2022-03-19 22:23:02', '', 'https://wx.qlogo.cn/mmhead/PiajxSqBRaEKjc639z2lRF4DqweNw2aDRLbAL7yLlSgrdZeKBCwLHDQ/0', '', '12859654121@qq.com', '17859654122', '教务处', '$2a$10$vJyLo1RhFORH/SAu3sc9aeb37I5JRy5UugaN7fIt/e2vvsz6JWJCm', '男', 0, 0, 'jwc', 0, 1505188058469896192, '', '', '教师组', NULL, NULL),
	(1505182864919105536, 'admin', '2022-03-19 22:02:15', NULL, NULL, NULL, 'https://wx.qlogo.cn/mmhead/PiajxSqBRaEKjc639z2lRF4DqweNw2aDRLbAL7yLlSgrdZeKBCwLHDQ/0', NULL, '123@qq.com', '17859652430', '学生2', '$2a$10$DpQjeEhI0Vy4vDWcsHyoHO.3O0GUpX8Sfj6JTF4/XdxqxdiYdaY1y', '男', 0, 0, 'stu02', 0, 1464487559647334401, NULL, '弱', '计算机1802', NULL, NULL),
	(1505183049753694208, 'admin', '2022-03-19 22:02:59', NULL, NULL, NULL, 'https://wx.qlogo.cn/mmhead/PiajxSqBRaEKjc639z2lRF4DqweNw2aDRLbAL7yLlSgrdZeKBCwLHDQ/0', NULL, '11111@qq.com', '17859654231', '学生3', '$2a$10$cix36h8B.sm7adhha0koeuZ4dpnhtWK/mE/1/Ozyccs5hSCDcam7y', '女', 0, 0, 'stu03', 0, 1464487559647334401, NULL, '弱', '计算机1802', NULL, NULL),
	(1505414568497778688, 'admin', '2022-03-20 13:22:57', NULL, NULL, NULL, 'https://wx.qlogo.cn/mmhead/PiajxSqBRaEKjc639z2lRF4DqweNw2aDRLbAL7yLlSgrdZeKBCwLHDQ/0', NULL, '123654@qq.cin', '13645874521', '王老师', '$2a$10$PS04ecXfknNd3V8d.ymLTObQciapMU4xU8.GADBZZsuTZr7ymnagy', '男', 0, 0, 'tea2', 0, 1464487559647334401, NULL, '弱', '计算机1802', NULL, NULL);

DROP TABLE IF EXISTS `a_user_role`;
CREATE TABLE IF NOT EXISTS `a_user_role` (
  `id` bigint unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `role_id` bigint unsigned DEFAULT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

DELETE FROM `a_user_role`;
INSERT INTO `a_user_role` (`id`, `create_by`, `create_time`, `del_flag`, `update_by`, `update_time`, `role_id`, `user_id`) VALUES
	(1505002962764828672, 'admin', '2022-03-19 11:53:33', 0, NULL, '2022-03-19 11:53:33', 496138616573953, 1464764315201572865),
	(1505182865606971392, 'admin', '2022-03-19 22:02:15', 0, NULL, NULL, 496138616573953, 1505182864919105536),
	(1505183050168930304, 'admin', '2022-03-19 22:02:59', 0, NULL, NULL, 496138616573953, 1505183049753694208),
	(1505188098064125952, 'admin', '2022-03-19 22:23:02', 0, NULL, NULL, 1505046318576439296, 1464772465946398722),
	(1505188149385629696, 'admin', '2022-03-19 22:23:15', 0, NULL, NULL, 496138616573952, 682265633886208),
	(1505407430207606784, 'admin', '2022-03-20 12:54:35', 0, NULL, NULL, 1505046193472933888, 1464772465946398721),
	(1505414568900431872, 'admin', '2022-03-20 13:22:57', 0, NULL, NULL, 1505046193472933888, 1505414568497778688);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
