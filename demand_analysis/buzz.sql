/*
Navicat MySQL Data Transfer

Source Server         : mysql_3306
Source Server Version : 50718
Source Host           : localhost:3306
Source Database       : buzz

Target Server Type    : MYSQL
Target Server Version : 50718
File Encoding         : 65001

Date: 2018-03-29 21:30:32
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for advertise
-- ----------------------------
DROP TABLE IF EXISTS `advertise`;
CREATE TABLE `advertise` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sid` int(11) unsigned DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  `ctime` datetime DEFAULT NULL,
  `stime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ad_sid` (`sid`),
  CONSTRAINT `ad_sid` FOREIGN KEY (`sid`) REFERENCES `ad_source` (`sid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for ad_source
-- ----------------------------
DROP TABLE IF EXISTS `ad_source`;
CREATE TABLE `ad_source` (
  `sid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`sid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for carousel
-- ----------------------------
DROP TABLE IF EXISTS `carousel`;
CREATE TABLE `carousel` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tid` int(11) unsigned DEFAULT NULL,
  `pic` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `carousel_tid` (`tid`),
  CONSTRAINT `carousel_tid` FOREIGN KEY (`tid`) REFERENCES `carousel_type` (`tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for carousel_type
-- ----------------------------
DROP TABLE IF EXISTS `carousel_type`;
CREATE TABLE `carousel_type` (
  `tid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for comments
-- ----------------------------
DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments` (
  `cid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '评论ID',
  `uid` int(11) unsigned DEFAULT NULL COMMENT '用户id',
  `mid` int(11) unsigned DEFAULT NULL COMMENT '音乐id',
  `content` varchar(255) DEFAULT NULL COMMENT '评论内容',
  `likes` int(11) DEFAULT '0' COMMENT '点赞数',
  `feeling` double DEFAULT '0' COMMENT '情感：积极为正，消极为负',
  `ctime` datetime DEFAULT NULL,
  PRIMARY KEY (`cid`),
  KEY `uid` (`uid`),
  KEY `mid` (`mid`),
  CONSTRAINT `mid` FOREIGN KEY (`mid`) REFERENCES `music` (`mid`),
  CONSTRAINT `uid` FOREIGN KEY (`uid`) REFERENCES `user` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for events
-- ----------------------------
DROP TABLE IF EXISTS `events`;
CREATE TABLE `events` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  `ctime` datetime DEFAULT NULL,
  `stime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for feature
-- ----------------------------
DROP TABLE IF EXISTS `feature`;
CREATE TABLE `feature` (
  `fid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `ctime` datetime DEFAULT NULL,
  PRIMARY KEY (`fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for friends
-- ----------------------------
DROP TABLE IF EXISTS `friends`;
CREATE TABLE `friends` (
  `suid` int(11) unsigned NOT NULL COMMENT '关注发起人',
  `duid` int(11) unsigned NOT NULL COMMENT '被关注人',
  `ctime` datetime DEFAULT NULL,
  PRIMARY KEY (`suid`,`duid`),
  KEY `friend_duid` (`duid`),
  CONSTRAINT `friend_duid` FOREIGN KEY (`duid`) REFERENCES `user` (`uid`),
  CONSTRAINT `friend_suid` FOREIGN KEY (`suid`) REFERENCES `user` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for message
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message` (
  `mid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `suid` int(11) unsigned NOT NULL,
  `ruid` int(11) unsigned NOT NULL,
  `content` varchar(255) NOT NULL,
  `ctime` datetime DEFAULT NULL,
  PRIMARY KEY (`mid`),
  KEY `message_suid` (`suid`),
  KEY `message_ruid` (`ruid`),
  CONSTRAINT `message_ruid` FOREIGN KEY (`ruid`) REFERENCES `user` (`uid`),
  CONSTRAINT `message_suid` FOREIGN KEY (`suid`) REFERENCES `user` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for music
-- ----------------------------
DROP TABLE IF EXISTS `music`;
CREATE TABLE `music` (
  `mid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sid` int(11) unsigned DEFAULT NULL,
  `rid` int(11) unsigned DEFAULT NULL COMMENT 'root id',
  `name` varchar(255) DEFAULT NULL,
  `album` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`mid`),
  KEY `music_sid` (`sid`),
  KEY `music_rid` (`rid`),
  CONSTRAINT `music_rid` FOREIGN KEY (`rid`) REFERENCES `source` (`rid`),
  CONSTRAINT `music_sid` FOREIGN KEY (`sid`) REFERENCES `singer` (`sid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for music_share
-- ----------------------------
DROP TABLE IF EXISTS `music_share`;
CREATE TABLE `music_share` (
  `oid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '操作ID',
  `mid` int(11) unsigned DEFAULT NULL,
  `uid` int(11) unsigned DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  `likes` int(11) unsigned DEFAULT '0',
  `ctime` datetime DEFAULT NULL,
  PRIMARY KEY (`oid`),
  KEY `share_mid` (`mid`),
  KEY `share_uid` (`uid`),
  CONSTRAINT `share_mid` FOREIGN KEY (`mid`) REFERENCES `music` (`mid`),
  CONSTRAINT `share_uid` FOREIGN KEY (`uid`) REFERENCES `user` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for permission
-- ----------------------------
DROP TABLE IF EXISTS `permission`;
CREATE TABLE `permission` (
  `uid` int(10) unsigned NOT NULL DEFAULT '0',
  `rid` int(11) unsigned DEFAULT NULL,
  `ctime` datetime DEFAULT NULL,
  PRIMARY KEY (`uid`),
  KEY `permision_rid` (`rid`),
  CONSTRAINT `permision_rid` FOREIGN KEY (`rid`) REFERENCES `roles` (`rid`),
  CONSTRAINT `role_uid` FOREIGN KEY (`uid`) REFERENCES `user` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `rid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`rid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for setting
-- ----------------------------
DROP TABLE IF EXISTS `setting`;
CREATE TABLE `setting` (
  `sid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '设置ID',
  `uid` int(11) unsigned DEFAULT NULL,
  `comment` int(1) unsigned DEFAULT NULL,
  `friend` int(1) unsigned DEFAULT NULL,
  `note` tinyint(1) unsigned DEFAULT NULL,
  `nearby` tinyint(1) unsigned DEFAULT NULL,
  PRIMARY KEY (`sid`),
  KEY `seting_uid` (`uid`),
  KEY `comment_state` (`comment`),
  KEY `friend_state` (`friend`),
  CONSTRAINT `comment_state` FOREIGN KEY (`comment`) REFERENCES `set_state` (`ssid`),
  CONSTRAINT `friend_state` FOREIGN KEY (`friend`) REFERENCES `set_state` (`ssid`),
  CONSTRAINT `seting_uid` FOREIGN KEY (`uid`) REFERENCES `user` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for set_state
-- ----------------------------
DROP TABLE IF EXISTS `set_state`;
CREATE TABLE `set_state` (
  `ssid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `state` varchar(10) DEFAULT NULL COMMENT '设置状态',
  PRIMARY KEY (`ssid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for singer
-- ----------------------------
DROP TABLE IF EXISTS `singer`;
CREATE TABLE `singer` (
  `sid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '歌手id',
  `name` varchar(40) DEFAULT NULL,
  `brief` varchar(255) DEFAULT NULL COMMENT '个人简介',
  PRIMARY KEY (`sid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for source
-- ----------------------------
DROP TABLE IF EXISTS `source`;
CREATE TABLE `source` (
  `rid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`rid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='歌曲来源';

-- ----------------------------
-- Table structure for state
-- ----------------------------
DROP TABLE IF EXISTS `state`;
CREATE TABLE `state` (
  `sid` int(1) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`sid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for topics
-- ----------------------------
DROP TABLE IF EXISTS `topics`;
CREATE TABLE `topics` (
  `tid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `topic` varchar(20) DEFAULT NULL,
  `ctime` datetime DEFAULT NULL,
  PRIMARY KEY (`tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for topic_talk
-- ----------------------------
DROP TABLE IF EXISTS `topic_talk`;
CREATE TABLE `topic_talk` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tid` int(11) unsigned NOT NULL,
  `uid` int(11) unsigned NOT NULL,
  `content` varchar(255) DEFAULT NULL,
  `ctime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `topic_tid` (`tid`),
  KEY `topic_uid` (`uid`),
  CONSTRAINT `topic_tid` FOREIGN KEY (`tid`) REFERENCES `topics` (`tid`),
  CONSTRAINT `topic_uid` FOREIGN KEY (`uid`) REFERENCES `user` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `uid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nickname` varchar(20) DEFAULT NULL,
  `icons` varchar(255) DEFAULT NULL COMMENT '头像链接',
  `email` varchar(40) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `sex` char(2) DEFAULT NULL,
  `birth` date DEFAULT NULL COMMENT '出生日期',
  `city` varchar(20) DEFAULT NULL,
  `state` int(1) unsigned zerofill DEFAULT NULL COMMENT '状态',
  `ctime` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`uid`),
  KEY `user_state` (`state`),
  CONSTRAINT `user_state` FOREIGN KEY (`state`) REFERENCES `state` (`sid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for user_feature
-- ----------------------------
DROP TABLE IF EXISTS `user_feature`;
CREATE TABLE `user_feature` (
  `id` int(11) NOT NULL,
  `uid` int(11) unsigned DEFAULT NULL,
  `fid` int(11) unsigned DEFAULT NULL,
  `counts` int(11) unsigned DEFAULT NULL,
  `ctime` datetime DEFAULT NULL,
  `atime` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  KEY `feature_uid` (`uid`),
  KEY `feature_fid` (`fid`),
  CONSTRAINT `feature_fid` FOREIGN KEY (`fid`) REFERENCES `feature` (`fid`),
  CONSTRAINT `feature_uid` FOREIGN KEY (`uid`) REFERENCES `user` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
