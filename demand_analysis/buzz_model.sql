CREATE TABLE `topic_content` (
`cid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '评论ID',
`uid` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '用户id',
`ttid` int(11) UNSIGNED NOT NULL COMMENT '音乐id',
`content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '评论内容',
`likes` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '点赞数',
`feeling` double NULL DEFAULT 0 COMMENT '情感：积极为正，消极为负',
`ctime` datetime NULL DEFAULT NULL,
PRIMARY KEY (`cid`) 
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
AUTO_INCREMENT=1;

