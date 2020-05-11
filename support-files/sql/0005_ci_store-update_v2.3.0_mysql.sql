USE devops_ci_store;
SET NAMES utf8mb4;

CREATE TABLE IF NOT EXISTS `T_STORE_MEDIA_INFO` (
  `ID` VARCHAR(32) COMMENT '主键',
  `STORE_CODE` VARCHAR(64)  NOT NULL  COMMENT 'store组件标识',
  `MEDIA_URL` VARCHAR(256)  NOT NULL  COMMENT '媒体资源链接',
  `MEDIA_TYPE` VARCHAR(32)  NOT NULL  COMMENT '媒体资源类型 PICTURE:图片 VIDEO:视频',
  `STORE_TYPE` TINYINT(4) NOT NULL DEFAULT 0 COMMENT 'store组件类型 0：插件 1：模板 2：镜像 3：IDE插件 4：扩展服务',
  `CREATOR` VARCHAR(50) NOT NULL DEFAULT 'system'  COMMENT '创建人',
  `MODIFIER` VARCHAR(50)  NOT NULL DEFAULT 'system'  COMMENT '最近修改人',
  `CREATE_TIME` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '创建时间',
  `UPDATE_TIME` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '更新时间',
  PRIMARY KEY (`ID`),
  KEY `inx_tsmi_store_code` (`STORE_CODE`)
  )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COMMENT = '媒体信息表';

CREATE TABLE IF NOT EXISTS `T_STORE_BUILD_INFO` (
  `ID` varchar(32) NOT NULL DEFAULT '' COMMENT '主键',
  `LANGUAGE` varchar(64) DEFAULT NULL COMMENT '开发语言',
  `SCRIPT` text NOT NULL COMMENT '打包脚本',
  `CREATOR` varchar(50) NOT NULL DEFAULT 'system' COMMENT '创建人',
  `MODIFIER` varchar(50) NOT NULL DEFAULT 'system' COMMENT '最近修改人',
  `CREATE_TIME` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `UPDATE_TIME` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `REPOSITORY_PATH` varchar(500) DEFAULT NULL COMMENT '代码存放路径',
  `ENABLE` bit(1) NOT NULL DEFAULT b'1' COMMENT '是否启用  1 启用  0 禁用',
  `SAMPLE_PROJECT_PATH` varchar(500) NOT NULL DEFAULT '' COMMENT '样例工程路径',
  `STORE_TYPE` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'store组件类型 0：插件 1：模板 2：镜像 3：IDE插件 4：扩展服务',
  PRIMARY KEY (`ID`) USING BTREE,
  UNIQUE KEY `inx_tsbi_language_type` (`LANGUAGE`,`STORE_TYPE`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='store组件构建信息表';

CREATE TABLE IF NOT EXISTS `T_STORE_BUILD_APP_REL` (
  `ID` varchar(32) NOT NULL DEFAULT '' COMMENT '主键',
  `BUILD_INFO_ID` varchar(32) NOT NULL COMMENT '构建信息Id(对应T_STORE_BUILD_INFO主键)',
  `APP_VERSION_ID` int(11) DEFAULT NULL COMMENT '编译环境版本Id(对应T_APP_VERSION主键)',
  `CREATOR` varchar(50) NOT NULL DEFAULT 'system' COMMENT '创建人',
  `MODIFIER` varchar(50) NOT NULL DEFAULT 'system' COMMENT '最近修改人',
  `CREATE_TIME` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `UPDATE_TIME` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`ID`) USING BTREE,
  KEY `inx_tabar_build_info_id` (`BUILD_INFO_ID`) USING BTREE,
  KEY `inx_tabar_app_version_id` (`APP_VERSION_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='store构建与编译环境关联关系表';