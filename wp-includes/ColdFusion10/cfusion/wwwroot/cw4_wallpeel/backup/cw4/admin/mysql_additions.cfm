-- ----------------------------
-- Table structure for `vinyl_color_options`
-- ----------------------------
DROP TABLE IF EXISTS `vinyl_color_options`;
CREATE TABLE `vinyl_color_options` (
  `vinyl_color_option_ID` int(11) NOT NULL AUTO_INCREMENT,
  `vinyl_color_hex` varchar(50) DEFAULT NULL,
  `vinyl_color_texture` varchar(50) DEFAULT NULL,
  `vinyl_color_variation_ID` int(11) DEFAULT '0',
  `is_active` int(11) DEFAULT '1',
  `vinyl_color_name` varchar(50) DEFAULT NULL

  PRIMARY KEY (`vinyl_color_option_ID`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


-- ----------------------------
-- Records of cw_admin_users
-- ----------------------------
INSERT INTO `vinyl_color_options` VALUES ('1', '#000080', 'NULL', '1', '1','Navy');
INSERT INTO `vinyl_color_options` VALUES ('2', '#FFA500', 'NULL', '1', '1','Orange');
INSERT INTO `vinyl_color_options` VALUES ('3', '#40E0D0', 'NULL', '1', '1','Turquoise');
INSERT INTO `vinyl_color_options` VALUES ('4', '#FF6347', 'NULL', '1', '1','Tomato');
INSERT INTO `vinyl_color_options` VALUES ('5', '#A0522D', 'NULL', '1', '1','Sienna');
INSERT INTO `vinyl_color_options` VALUES ('6', '#dedede', 'NULL', '1', '1','Grey');
INSERT INTO `vinyl_color_options` VALUES ('7', '#000080', 'NULL', '1', '1','Black');
INSERT INTO `vinyl_color_options` VALUES ('8', '#666666', 'NULL', '1', '1','Dark Grey');


-- ----------------------------
-- Table structure for `vinyl_color_options`
-- ----------------------------
DROP TABLE IF EXISTS `vinyl_color_variations`;
CREATE TABLE `vinyl_color_options` (
  `vinyl_color_variation_ID` int(11) NOT NULL AUTO_INCREMENT,
  `vinyl_color_variation` varchar(50) DEFAULT NULL

  PRIMARY KEY (`vinyl_color_variation_ID`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


INSERT INTO `vinyl_color_variations` VALUES ('1', 'Color Variation One');
INSERT INTO `vinyl_color_variations` VALUES ('2', 'Color Variation Two');