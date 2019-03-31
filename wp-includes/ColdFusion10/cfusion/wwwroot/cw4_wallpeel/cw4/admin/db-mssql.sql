/*
Cartweaver Microsoft SQL Server Database
==========================================================
Application: Cartweaver 4 ColdFusion
Copyright 2002 - 2012, All Rights Reserved
Developer: Application Dynamics, Inc. | Cartweaver.com
Licensing: http://www.cartweaver.com/eula
Support: http://www.cartweaver.com/support
==========================================================
File: db-mssql.sql
File Date: 2014-07-01

Description: Creates Cartweaver database with default data
Contents may be replaced with a sql dump of any Cartweaver db

Notes: MS SQL queries are delimited with a semicolon
Edit and use at your own risk! All operations are permanent!

==========================================================
*/

-- ----------------------------
-- Table structure for [dbo].[cw_admin_users]
-- ----------------------------
IF OBJECT_ID('[dbo].[cw_admin_users]') IS NOT NULL DROP TABLE [dbo].[cw_admin_users]
;
CREATE TABLE [dbo].[cw_admin_users] (
[admin_user_id] int NOT NULL IDENTITY(1,1) ,
[admin_user_alias] nvarchar(255) NULL ,
[admin_username] nvarchar(255) NULL ,
[admin_password] nvarchar(255) NULL ,
[admin_access_level] nvarchar(255) NULL ,
[admin_login_date] datetime NULL ,
[admin_last_login] datetime NULL ,
[admin_user_email] nvarchar(255) NULL 
)


;
DBCC CHECKIDENT(N'[dbo].[cw_admin_users]', RESEED, 4)
;

-- ----------------------------
-- Records of cw_admin_users
-- ----------------------------
SET IDENTITY_INSERT [dbo].[cw_admin_users] ON
;
INSERT INTO [dbo].[cw_admin_users] ([admin_user_id], [admin_user_alias], [admin_username], [admin_password], [admin_access_level], [admin_login_date], [admin_last_login], [admin_user_email]) VALUES (N'1', N'Developer', N'developer', N'admin', N'developer', N'2011-12-16 17:23:05.000', N'2011-12-16 16:43:12.000', N'developer@cartweaver.com');
;
INSERT INTO [dbo].[cw_admin_users] ([admin_user_id], [admin_user_alias], [admin_username], [admin_password], [admin_access_level], [admin_login_date], [admin_last_login], [admin_user_email]) VALUES (N'2', N'Customer Service', N'service', N'admin', N'service', N'2011-04-26 16:09:46.000', N'2010-10-11 13:33:34.000', N'service@cartweaver.com');
;
INSERT INTO [dbo].[cw_admin_users] ([admin_user_id], [admin_user_alias], [admin_username], [admin_password], [admin_access_level], [admin_login_date], [admin_last_login], [admin_user_email]) VALUES (N'3', N'Manager', N'manager', N'admin', N'manager', N'2011-07-18 10:50:59.000', N'2011-04-26 16:10:06.000', N'manager@cartweaver.com');
;
INSERT INTO [dbo].[cw_admin_users] ([admin_user_id], [admin_user_alias], [admin_username], [admin_password], [admin_access_level], [admin_login_date], [admin_last_login], [admin_user_email]) VALUES (N'4', N'Merchant', N'merchant', N'admin', N'merchant', N'2010-10-11 13:23:11.000', N'2010-04-23 07:43:30.000', N'merchant@cartweaver.com');
;
SET IDENTITY_INSERT [dbo].[cw_admin_users] OFF
;

-- ----------------------------
-- Table structure for [dbo].[cw_cart]
-- ----------------------------
IF OBJECT_ID('[dbo].[cw_cart]') IS NOT NULL DROP TABLE [dbo].[cw_cart]
;
CREATE TABLE [dbo].[cw_cart] (
[cart_line_id] int NOT NULL IDENTITY(1,1) ,
[cart_custcart_id] nvarchar(255) NULL ,
[cart_sku_id] int NULL ,
[cart_sku_unique_id] nvarchar(255) NULL ,
[cart_sku_qty] int NULL ,
[cart_dateadded] datetime NULL 
)


;
DBCC CHECKIDENT(N'[dbo].[cw_cart]', RESEED, 9)
;

-- ----------------------------
-- Records of cw_cart
-- ----------------------------
SET IDENTITY_INSERT [dbo].[cw_cart] ON
;
SET IDENTITY_INSERT [dbo].[cw_cart] OFF
;

-- ----------------------------
-- Table structure for [dbo].[cw_categories_primary]
-- ----------------------------
IF OBJECT_ID('[dbo].[cw_categories_primary]') IS NOT NULL DROP TABLE [dbo].[cw_categories_primary]
;
CREATE TABLE [dbo].[cw_categories_primary] (
[category_id] int NOT NULL IDENTITY(1,1) ,
[category_name] nvarchar(225) NULL ,
[category_archive] int NULL DEFAULT '0',
[category_sort] float(53) NULL  DEFAULT '1.000',
[category_description] nvarchar(MAX) NULL, 
[category_nav] int NULL DEFAULT '1'
)

;
DBCC CHECKIDENT(N'[dbo].[cw_categories_primary]', RESEED, 59)
;

-- ----------------------------
-- Records of cw_categories_primary
-- ----------------------------
SET IDENTITY_INSERT [dbo].[cw_categories_primary] ON
;
INSERT INTO [dbo].[cw_categories_primary] ([category_id], [category_name], [category_archive], [category_sort], [category_description], [category_nav]) VALUES (N'54', N'Clothing', N'0', N'0', N'<p>Category Description: text inserted here for each category</p>', '1');
;
INSERT INTO [dbo].[cw_categories_primary] ([category_id], [category_name], [category_archive], [category_sort], [category_description], [category_nav]) VALUES (N'55', N'Electronics', N'0', N'0', N'<p>Category Description: text inserted here for each category</p>', '1');
;
INSERT INTO [dbo].[cw_categories_primary] ([category_id], [category_name], [category_archive], [category_sort], [category_description], [category_nav]) VALUES (N'56', N'Housewares', N'0', N'0', N'<p>Category Description: text inserted here for each category</p>', '1');
;
INSERT INTO [dbo].[cw_categories_primary] ([category_id], [category_name], [category_archive], [category_sort], [category_description], [category_nav]) VALUES (N'57', N'Lawn & Garden', N'0', N'0', N'<p>Category Description: text inserted here for each category</p>', '1');
;
INSERT INTO [dbo].[cw_categories_primary] ([category_id], [category_name], [category_archive], [category_sort], [category_description], [category_nav]) VALUES (N'58', N'Collectibles', N'0', N'0', N'<p>Category Description: text inserted here for each category</p>', '1');
;
SET IDENTITY_INSERT [dbo].[cw_categories_primary] OFF
;

-- ----------------------------
-- Table structure for [dbo].[cw_categories_secondary]
-- ----------------------------
IF OBJECT_ID('[dbo].[cw_categories_secondary]') IS NOT NULL DROP TABLE [dbo].[cw_categories_secondary]
;
CREATE TABLE [dbo].[cw_categories_secondary] (
[secondary_id] int NOT NULL IDENTITY(1,1) ,
[secondary_name] nvarchar(255) NULL,
[secondary_archive] int NULL DEFAULT '0',
[secondary_sort] float(53) NULL DEFAULT '1.00',
[secondary_description] nvarchar(MAX) NULL, 
[secondary_nav] int NULL DEFAULT '1' 
)

;
DBCC CHECKIDENT(N'[dbo].[cw_categories_secondary]', RESEED, 80)
;

-- ----------------------------
-- Records of cw_categories_secondary
-- ----------------------------
SET IDENTITY_INSERT [dbo].[cw_categories_secondary] ON
;
INSERT INTO [dbo].[cw_categories_secondary] ([secondary_id], [secondary_name], [secondary_archive], [secondary_sort], [secondary_description], [secondary_nav]) VALUES (N'70', N'Shirts', N'0', N'0', N'<p>Secondary Category Description: insert any content here for each secondary category</p>', '1');
;
INSERT INTO [dbo].[cw_categories_secondary] ([secondary_id], [secondary_name], [secondary_archive], [secondary_sort], [secondary_description], [secondary_nav]) VALUES (N'71', N'Pants & Shorts', N'0', N'0', N'<p>Secondary Category Description: insert any content here for each secondary category</p>', '1');
;
INSERT INTO [dbo].[cw_categories_secondary] ([secondary_id], [secondary_name], [secondary_archive], [secondary_sort], [secondary_description], [secondary_nav]) VALUES (N'72', N'Cameras', N'0', N'0', N'<p>Secondary Category Description: insert any content here for each secondary category</p>', '1');
;
INSERT INTO [dbo].[cw_categories_secondary] ([secondary_id], [secondary_name], [secondary_archive], [secondary_sort], [secondary_description], [secondary_nav]) VALUES (N'73', N'Televisions', N'0', N'0', N'<p>Secondary Category Description: insert any content here for each secondary category</p>', '1');
;
INSERT INTO [dbo].[cw_categories_secondary] ([secondary_id], [secondary_name], [secondary_archive], [secondary_sort], [secondary_description], [secondary_nav]) VALUES (N'74', N'Desktop Computers', N'0', N'0', N'<p>Secondary Category Description: insert any content here for each secondary category</p>', '1');
;
INSERT INTO [dbo].[cw_categories_secondary] ([secondary_id], [secondary_name], [secondary_archive], [secondary_sort], [secondary_description], [secondary_nav]) VALUES (N'75', N'Laptop Computers', N'0', N'0', N'<p>Secondary Category Description: insert any content here for each secondary category</p>', '1');
;
INSERT INTO [dbo].[cw_categories_secondary] ([secondary_id], [secondary_name], [secondary_archive], [secondary_sort], [secondary_description], [secondary_nav]) VALUES (N'76', N'Video Cameras', N'0', N'0', N'<p>Secondary Category Description: insert any content here for each secondary category</p>', '1');
;
INSERT INTO [dbo].[cw_categories_secondary] ([secondary_id], [secondary_name], [secondary_archive], [secondary_sort], [secondary_description], [secondary_nav]) VALUES (N'77', N'Bed & Bath', N'0', N'0', N'<p>Secondary Category Description: insert any content here for each secondary category</p>', '1');
;
INSERT INTO [dbo].[cw_categories_secondary] ([secondary_id], [secondary_name], [secondary_archive], [secondary_sort], [secondary_description], [secondary_nav]) VALUES (N'78', N'Kitchen', N'0', N'0', N'<p>Secondary Category Description: insert any content here for each secondary category</p>', '1');
;
INSERT INTO [dbo].[cw_categories_secondary] ([secondary_id], [secondary_name], [secondary_archive], [secondary_sort], [secondary_description], [secondary_nav]) VALUES (N'79', N'Lawn Mowers', N'0', N'1', N'<p>Secondary Category Description: insert any content here for each secondary category</p>', '1');
;
INSERT INTO [dbo].[cw_categories_secondary] ([secondary_id], [secondary_name], [secondary_archive], [secondary_sort], [secondary_description], [secondary_nav]) VALUES (N'80', N'Weed Trimmers', N'0', N'0', N'<p>Secondary Category Description: insert any content here for each secondary category</p>', '1');
;
SET IDENTITY_INSERT [dbo].[cw_categories_secondary] OFF
;

-- ----------------------------
-- Table structure for [dbo].[cw_config_groups]
-- ----------------------------
IF OBJECT_ID('[dbo].[cw_config_groups]') IS NOT NULL DROP TABLE [dbo].[cw_config_groups]
;
CREATE TABLE [dbo].[cw_config_groups] (
[config_group_id] int NOT NULL IDENTITY(1,1) ,
[config_group_name] nvarchar(150) NULL ,
[config_group_sort] float(53) NULL DEFAULT '1.00',
[config_group_show_merchant] int NULL DEFAULT '0',
[config_group_protected] int NULL DEFAULT '1',
[config_group_description] nvarchar(MAX) NULL 
)


;
DBCC CHECKIDENT(N'[dbo].[cw_config_groups]', RESEED, 31)
;

-- ----------------------------
-- Records of cw_config_groups
-- ----------------------------
SET IDENTITY_INSERT [dbo].[cw_config_groups] ON
;
INSERT INTO [dbo].[cw_config_groups] ([config_group_id], [config_group_name], [config_group_sort], [config_group_show_merchant], [config_group_protected], [config_group_description]) VALUES (N'3', N'Company Info.', N'1', N'1', N'1', N'Enter global settings for company information.');
;
INSERT INTO [dbo].[cw_config_groups] ([config_group_id], [config_group_name], [config_group_sort], [config_group_show_merchant], [config_group_protected], [config_group_description]) VALUES (N'5', N'Tax Settings', N'1', N'1', N'1', N'Manage global tax system settings.');
;
INSERT INTO [dbo].[cw_config_groups] ([config_group_id], [config_group_name], [config_group_sort], [config_group_show_merchant], [config_group_protected], [config_group_description]) VALUES (N'6', N'Shipping Settings', N'1', N'1', N'1', N'Manage global shipping system settings.');
;
INSERT INTO [dbo].[cw_config_groups] ([config_group_id], [config_group_name], [config_group_sort], [config_group_show_merchant], [config_group_protected], [config_group_description]) VALUES (N'7', N'Admin Controls', N'1', N'0', N'1', N'Manage global settings for the admin interface.');
;
INSERT INTO [dbo].[cw_config_groups] ([config_group_id], [config_group_name], [config_group_sort], [config_group_show_merchant], [config_group_protected], [config_group_description]) VALUES (N'8', N'Product Display', N'1', N'0', N'1', N'Manage global settings for front end display.');
;
INSERT INTO [dbo].[cw_config_groups] ([config_group_id], [config_group_name], [config_group_sort], [config_group_show_merchant], [config_group_protected], [config_group_description]) VALUES (N'9', N'Payment Settings', N'1', N'0', N'1', N'Manage payment settings and options');
;
INSERT INTO [dbo].[cw_config_groups] ([config_group_id], [config_group_name], [config_group_sort], [config_group_show_merchant], [config_group_protected], [config_group_description]) VALUES (N'10', N'Debug Settings', N'1', N'0', N'1', N'Select the variable scopes to be shown as part of the debugging output. <br> Warning: Enabling all scopes may cause timeout errors, depending on your server settings.');
;
INSERT INTO [dbo].[cw_config_groups] ([config_group_id], [config_group_name], [config_group_sort], [config_group_show_merchant], [config_group_protected], [config_group_description]) VALUES (N'11', N'Discount Settings', N'1', N'1', N'1', N'Manage global settings for discount system.');
;
INSERT INTO [dbo].[cw_config_groups] ([config_group_id], [config_group_name], [config_group_sort], [config_group_show_merchant], [config_group_protected], [config_group_description]) VALUES (N'12', N'Cart Pages', N'1', N'0', N'1', N'Manage default pages for Cartweaver functions');
;
INSERT INTO [dbo].[cw_config_groups] ([config_group_id], [config_group_name], [config_group_sort], [config_group_show_merchant], [config_group_protected], [config_group_description]) VALUES (N'13', N'Cart Display Settings', N'1', N'0', N'1', N'Manage display settings for general cart functions');
;
INSERT INTO [dbo].[cw_config_groups] ([config_group_id], [config_group_name], [config_group_sort], [config_group_show_merchant], [config_group_protected], [config_group_description]) VALUES (N'14', N'Image Settings', N'1', N'0', N'1', N'Manage global options for product images');
;
INSERT INTO [dbo].[cw_config_groups] ([config_group_id], [config_group_name], [config_group_sort], [config_group_show_merchant], [config_group_protected], [config_group_description]) VALUES (N'15', N'Admin Home', N'1', N'0', N'1', N'Manage content on admin landing page');
;
INSERT INTO [dbo].[cw_config_groups] ([config_group_id], [config_group_name], [config_group_sort], [config_group_show_merchant], [config_group_protected], [config_group_description]) VALUES (N'24', N'Product Admin Settings', N'1', N'0', N'1', N'Manage global settings related to product administration.');
;
INSERT INTO [dbo].[cw_config_groups] ([config_group_id], [config_group_name], [config_group_sort], [config_group_show_merchant], [config_group_protected], [config_group_description]) VALUES (N'25', N'Global Settings', N'1', N'0', N'1', N'Manage application global settings');
;
INSERT INTO [dbo].[cw_config_groups] ([config_group_id], [config_group_name], [config_group_sort], [config_group_show_merchant], [config_group_protected], [config_group_description]) VALUES (N'27', N'Email Settings', N'1', N'0', N'1', N'Sitewide email options and message content    (<a href="email-sample.cfm" target="_blank">View sample email format</a>)');
;
INSERT INTO [dbo].[cw_config_groups] ([config_group_id], [config_group_name], [config_group_sort], [config_group_show_merchant], [config_group_protected], [config_group_description]) VALUES (N'29', N'Customer Settings', N'1', N'0', N'1', N'Manage options related to customer accounts');
;
INSERT INTO [dbo].[cw_config_groups] ([config_group_id], [config_group_name], [config_group_sort], [config_group_show_merchant], [config_group_protected], [config_group_description]) VALUES (N'30', N'Developer Settings', N'1', N'0', N'1', N'Manage developer-only options');
;
INSERT INTO [dbo].[cw_config_groups] ([config_group_id], [config_group_name], [config_group_sort], [config_group_show_merchant], [config_group_protected], [config_group_description]) VALUES (N'31', N'Download Settings', N'1', N'0', N'1', N'Manage global options for file downloads');
;
SET IDENTITY_INSERT [dbo].[cw_config_groups] OFF
;

-- ----------------------------
-- Table structure for [dbo].[cw_config_items]
-- ----------------------------
IF OBJECT_ID('[dbo].[cw_config_items]') IS NOT NULL DROP TABLE [dbo].[cw_config_items]
;
CREATE TABLE [dbo].[cw_config_items] (
[config_id] int NOT NULL IDENTITY(1,1) ,
[config_group_id] int NULL DEFAULT '0',
[config_variable] nvarchar(150) NULL ,
[config_name] nvarchar(150) NULL ,
[config_value] nvarchar(MAX) NULL ,
[config_type] nvarchar(150) NULL ,
[config_description] nvarchar(MAX) NULL ,
[config_possibles] nvarchar(MAX) NULL ,
[config_show_merchant] int NULL  DEFAULT '0',
[config_sort] float(53) NULL DEFAULT '1.00',
[config_size] int NULL  DEFAULT '35',
[config_rows] int NULL  DEFAULT '5',
[config_protected] int NULL DEFAULT '0',
[config_required] int NULL DEFAULT '0',
[config_directory] nvarchar(255) NULL 
)

;
DBCC CHECKIDENT(N'[dbo].[cw_config_items]', RESEED, 243)
;

-- ----------------------------
-- Records of cw_config_items
-- ----------------------------
SET IDENTITY_INSERT [dbo].[cw_config_items] ON
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'8', N'3', N'companyName', N'Company Name', N'Our Company', N'text', N'This is the name of the store, used on invoices and in email confirmations', N'', N'0', N'4', N'35', N'0', N'1', N'1', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'9', N'3', N'companyAddress1', N'Address 1', N'123 Our Street', N'text', N'The first line of the company address', N'', N'0', N'5', N'35', N'0', N'1', N'1', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'10', N'3', N'companyAddress2', N'Address 2', N'', N'text', N'The second line of the company address (if necessary)', N'', N'0', N'6', N'35', N'0', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'11', N'3', N'companyCity', N'City', N'Our Town', N'text', N'The company''s city', N'', N'0', N'7', N'35', N'0', N'1', N'1', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'12', N'3', N'companyState', N'State/Prov', N'Washington', N'text', N'The state or province where the company is located', N'', N'0', N'8', N'35', N'0', N'1', N'1', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'13', N'3', N'companyZip', N'Postal Code', N'11111', N'text', N'The company''s postal or zip code', N'', N'0', N'9', N'20', N'0', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'14', N'3', N'companyCountry', N'Country', N'USA', N'text', N'The company''s country', N'', N'0', N'10', N'12', N'0', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'15', N'3', N'companyPhone', N'Phone', N'555-555-1234', N'text', N'The company phone number', N'', N'0', N'12', N'20', N'0', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'16', N'3', N'companyFax', N'Fax', N'', N'text', N'The company fax number', N'', N'0', N'13', N'20', N'0', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'17', N'3', N'companyEmail', N'Company Email', N'company@cartweaver.com', N'text', N'This is the company email - all automated emails are sent from this address, and order confirmations are sent to this address', N'', N'0', N'3', N'35', N'0', N'1', N'1', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'18', N'5', N'taxChargeOnShipping', N'Charge Tax on Shipping', N'0', N'boolean', N'Determines whether tax is charged on the shipping total for an order', N'', N'0', N'6', N'0', N'0', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'19', N'5', N'taxDisplayLineItem', N'Display Tax on Each Line Item', N'true', N'boolean', N'Determines whether line item taxes are displayed in the customer''s shopping cart', N'', N'0', N'7', N'0', N'0', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'20', N'5', N'taxDisplayOnProduct', N'Display Product Price Incl. and Excl. Tax', N'false', N'boolean', N'Determines whether prices including taxes are displayed on the product detail pages', N'', N'0', N'8', N'0', N'0', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'21', N'5', N'taxIDNumber', N'Tax ID Number', N'', N'text', N'Tax ID Number, or VAT number (may be displayed on customer invoices)', N'', N'0', N'9', N'20', N'0', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'22', N'5', N'taxDisplayID', N'Display TAX ID Number on Invoice', N'true', N'boolean', N'Determines whether the Tax ID Number is displayed on the customer''s invoice', N'', N'0', N'10', N'0', N'0', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'25', N'6', N'shipEnabled', N'Enable Shipping', N'true', N'boolean', N'Determines if shipping calculations are performed during checkout', N'', N'0', N'1', N'0', N'0', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'26', N'6', N'shipChargeBase', N'Charge Base', N'true', N'boolean', N'Include the shipping method base rate when calculation shipping rates using this method (y/n)', N'', N'0', N'4', N'0', N'0', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'28', N'6', N'shipChargeExtension', N'Charge Location Extension', N'true', N'boolean', N'Include Local Extension percentages when calculating shipping costs (y/n)', N'', N'0', N'5', N'0', N'0', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'29', N'8', N'appEnableBackOrders', N'Allow Backorders', N'0', N'boolean', N'Determines if backorders are allowed in the application - if this option is disabled, all products must have a positive stock quantity to be available for purchase', N'', N'0', N'8', N'0', N'0', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'30', N'8', N'appDisplayUpsell', N'Show Related Items', N'true', N'boolean', N'Determines whether related ''upsell'' products are displayed on the product details pages', N'', N'0', N'14', N'0', N'0', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'32', N'8', N'appDisplayColumns', N'Number of Product Columns', N'3', N'text', N'The number of columns to be displayed on the product results page', N'', N'0', N'1', N'0', N'0', N'1', N'1', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'33', N'8', N'appDisplayPerPage', N'Results per Page', N'6', N'text', N'This value should be evenly divisible by the Number of Columns in order to ensure correct display for multi-column results', N'', N'0', N'2', N'0', N'0', N'1', N'1', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'34', N'8', N'appDisplayOptionView', N'Product Option Selection Type', N'select', N'select', N'Determines how product option details are displayed', N'Select Dropdowns|select
Tables|table', N'0', N'10', N'0', N'0', N'1', N'1', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'36', N'10', N'debugApplication', N'Show Application Variables', N'0', N'boolean', N'Show application variables when debugging is turned on', N'NULL', N'0', N'6', N'0', N'0', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'37', N'10', N'debugSession', N'Show Session Variables', N'true', N'boolean', N'Show session variables when debugging is turned on', N'NULL', N'0', N'13', N'0', N'0', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'38', N'10', N'debugRequest', N'Show Request Variables', N'true', N'boolean', N'Show request variables when debugging is turned on', N'NULL', N'0', N'11', N'0', N'0', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'39', N'10', N'debugServer', N'Show Server Variables', N'0', N'boolean', N'Show server variables when debugging is turned on', N'NULL', N'0', N'12', N'0', N'0', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'40', N'10', N'debugUrl', N'Show URL Variables', N'true', N'boolean', N'Show URL variables when debugging is turned on', N'NULL', N'0', N'14', N'0', N'0', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'41', N'10', N'debugLocal', N'Show Local Variables', N'0', N'boolean', N'Show local variables when debugging is turned on', N'NULL', N'0', N'10', N'0', N'0', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'42', N'10', N'debugForm', N'Show Form Variables', N'0', N'boolean', N'Show form variables when debugging is turned on', N'NULL', N'0', N'9', N'0', N'0', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'43', N'10', N'debugCookies', N'Show Cookie Variables', N'true', N'boolean', N'Show cookie variables when debugging is turned on', N'NULL', N'0', N'8', N'0', N'0', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'44', N'10', N'debugCGI', N'Show CGI Variables', N'0', N'boolean', N'Show CGI variables when debugging is turned on', N'NULL', N'0', N'7', N'0', N'0', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'45', N'10', N'debugDisplayLink', N'Show Debug Link', N'true', N'boolean', N'If debugging is enabled, show a link in the store', N'', N'0', N'5', N'0', N'0', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'46', N'10', N'debugEnabled', N'Enable Debugging', N'true', N'boolean', N'Enable debugging output for displaying system information', N'NULL', N'0', N'2', N'0', N'0', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'47', N'11', N'discountDisplayLineItem', N'Display Line Item Discount', N'true', N'boolean', N'Displays a line item discount in the shopping cart if checked and if the product is discounted', N'NULL', N'0', N'2', N'0', N'0', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'48', N'11', N'discountsEnabled', N'Enable Discounts', N'true', N'boolean', N'Enables the discount feature in the store. If unchecked, discounts are disabled', N'NULL', N'0', N'1', N'0', N'0', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'50', N'11', N'discountDisplayNotes', N'Display Discount Notes on Cart', N'true', N'boolean', N'Show an asterisk in the cart line item and tie it to a discount description below', N'NULL', N'0', N'3', N'0', N'0', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'51', N'13', N'appDisplayCartImage', N'Show Small Image in Cart', N'true', N'boolean', N'Determines whether the extra small images are displayed in the cart', N'NULL', N'0', N'2', N'0', N'0', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'52', N'6', N'shipChargeBasedOn', N'Charge Range Based On', N'weight', N'select', N'Determines how shipping ranges are calculated - this value is either ignored (if set to none), or figured by cart subtotal or weight totals.', N'None|none
Cart Subtotal|subtotal
Cart Weight|weight', N'0', N'6', N'0', N'0', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'53', N'8', N'appEnableCatsRelated', N'Relate Categories/Secondaries', N'true', N'boolean', N'Check the box if your categories and secondary categories are related - relationships are handled at the product level', N'NULL', N'0', N'18', N'0', N'0', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'54', N'8', N'appEnableImageZoom', N'Show Expanded Image Popup', N'true', N'boolean', N'Determines whether a popup image is shown on the details page', N'NULL', N'0', N'13', N'0', N'0', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'55', N'25', N'appVersionNumber', N'Cartweaver Version Number', N'4.03.01', N'text', N'The current Cartweaver version number is stored here for reference when installing or upgrading', N'NULL', N'0', N'12', N'0', N'0', N'1', N'1', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'56', N'30', N'developerEmail', N'Developer Email', N'', N'text', N'Debugging and error emails will go to this address - if not defined, emails will go to the CompanyEmail', N'NULL', N'0', N'1', N'35', N'0', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'57', N'10', N'debugHandleErrors', N'Enable Error Handling', N'false', N'boolean', N'Determines whether error handling will be enabled on the site', N'NULL', N'0', N'1', N'0', N'0', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'59', N'5', N'taxSystem', N'Tax System', N'Groups', N'radio', N'Determine which tax system to use - tax groups or general tax', N'Groups|Groups
General|General', N'0', N'2', N'0', N'0', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'60', N'5', N'taxChargeBasedOn', N'Charge Tax Based On', N'shipping', N'radio', N'Taxes can be charged based on billing or shipping address, depending on state/country laws', N'Shipping Address|shipping
Billing Address|billing', N'0', N'4', N'0', N'0', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'61', N'13', N'appActionContinueShopping', N'Continue Shopping', N'Results', N'select', N'Used for the Continue Shopping and Return to Store links.', N'Product Details|Details
Product Listings|Results
Home Page|Home', N'0', N'7', N'0', N'0', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'62', N'6', N'shipDisplayInfo', N'Show Customer Shipping Info', N'true', N'boolean', N'Show shipping form fields on the order form, and shipping totals in order confirmation (y/n)', N'', N'0', N'3', N'0', N'0', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'85', N'7', N'adminProductPaging', N'Enable Product Paging', N'true', N'boolean', N'Break products list into multiple pages', null, N'0', N'4', N'0', N'0', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'86', N'7', N'adminOrderPaging', N'Enable Order Paging', N'true', N'boolean', N'Break orders list into multiple pages', N'NULL', N'0', N'3', N'0', N'0', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'87', N'7', N'adminCustomerPaging', N'Enable Customer Paging', N'true', N'boolean', N'Break customer list into multiple pages', N'NULL', N'0', N'2', N'0', N'0', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'88', N'24', N'adminProductLinksEnabled', N'Show Links to View & Edit Product', N'true', N'boolean', N'Show links in admin lists to view products and categories on the site, and links on site to edit product (if logged in).', N'NULL', N'0', N'19', N'0', N'0', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'90', N'24', N'adminLabelCategories', N'Categories Label', N'Main Categories', N'text', N'The text label assigned to multiple top level categories (i.e. ''categories, galleries, departments'')', N'NULL', N'0', N'2', N'35', N'0', N'1', N'1', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'91', N'24', N'adminLabelCategory', N'Category Label', N'Main Category', N'text', N'The text label for a singular top level category (i.e. ''category, gallery, department'')', N'', N'0', N'3', N'35', N'0', N'1', N'1', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'92', N'24', N'adminLabelSecondary', N'Secondary Category Label', N'Secondary Category', N'text', N'The text label for a singular secondary category (i.e. ''category, gallery, department'')', null, N'0', N'7', N'35', N'0', N'1', N'1', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'93', N'24', N'adminLabelSecondaries', N'Secondary Categories Label', N'Secondary Categories', N'text', N'The text label assigned to multiple secondary categories (i.e. ''categories, galleries, departments'')', null, N'0', N'4', N'35', N'0', N'1', N'1', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'94', N'24', N'adminProductAltPriceEnabled', N'Use Alternate (Suggested) Price', N'true', N'boolean', N'Use alternate ''MSRP'' pricing to show full suggested retail price', null, N'0', N'9', N'0', N'0', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'95', N'24', N'adminLabelProductAltPrice', N'Alternate Price Label', N'MSRP', N'text', N'The text label for the alternate pricing field (default = ''MSRP'')', null, N'0', N'10', N'35', N'0', N'1', N'1', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'96', N'24', N'adminProductSpecsEnabled', N'Use Product Additional Info', N'true', N'boolean', N'Show product specs or additional info field on product form', null, N'0', N'11', N'0', N'0', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'97', N'24', N'adminLabelProductSpecs', N'Addtional Info Label', N'Additional Information', N'text', N'The text label for the additional info field', null, N'0', N'12', N'35', N'0', N'1', N'1', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'98', N'24', N'adminProductKeywordsEnabled', N'Use Product Keywords', N'true', N'boolean', N'Show product keywords field on product form - used for enhanced product search', N'', N'0', N'13', N'0', N'0', N'1', N'0', N'');
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'99', N'24', N'adminLabelProductKeywords', N'Product Keywords Label', N'Additional Search Terms', N'text', N'The text label for product keywords field', null, N'0', N'14', N'35', N'0', N'1', N'1', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'100', N'7', N'adminEditorEnabled', N'Use Text Editor (global)', N'true', N'boolean', N'Use the rich text (wysiwyg) editor where specified', null, N'0', N'6', N'0', N'0', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'101', N'24', N'adminProductImageMaxKB', N'Maximum Image File Size', N'2000', N'number', N'The maximum filesize allowed for image uploads', null, N'0', N'17', N'5', N'0', N'1', N'1', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'102', N'24', N'adminProductImageSelectorThumbsEnabled', N'Enable Image Selector Thumbnails', N'true', N'boolean', N'Enable thumbnail view when selecting from existing images', null, N'0', N'18', N'0', N'0', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'103', N'24', N'adminProductCustomInfoEnabled', N'Use Product Custom Info', N'true', N'boolean', N'Use ''custom info'' personalization field for products', null, N'0', N'15', N'0', N'0', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'104', N'24', N'adminProductUpsellByCatEnabled', N'Show Related Products by Category', N'true', N'boolean', N'Filter Related Products selection by category (recommended for large product catalogs for faster performance)', null, N'0', N'20', N'0', N'0', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'105', N'24', N'adminProductDefaultBackOrderText', N'Out of Stock Message Default', N'', N'text', N'Default message to show in ''out of stock message'' field in product form (overridden per product)', null, N'0', N'1', N'35', N'0', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'106', N'24', N'adminProductDefaultCustomInfo', N'Custom Info Label Default', N'', N'text', N'Default message to show in ''custom info label'' field in product form', null, N'0', N'16', N'35', N'0', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'109', N'15', N'adminWidgetOrders', N'Admin Home: Recent Orders', N'5', N'number', N'Number of recent orders to show in the admin home page preview (0 hides this widget)', N'', N'0', N'4', N'3', N'5', N'1', N'1', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'110', N'15', N'adminWidgetProductsBestselling', N'Admin Home: Top Selling Products', N'5', N'number', N'Number of top selling products to show in the admin home page preview (0 hides this widget)', N'', N'0', N'7', N'3', N'5', N'1', N'1', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'111', N'15', N'adminWidgetProductsRecent', N'Admin Home: Recent Products', N'5', N'number', N'Number of top selling products to show in the admin home page preview (0 hides this widget)', N'', N'0', N'5', N'3', N'5', N'1', N'1', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'112', N'15', N'adminWidgetCustomers', N'Admin Home: Top Customers', N'5', N'number', N'Number of top customers to show in the admin home page preview (0 hides this widget)', N'', N'0', N'6', N'3', N'5', N'1', N'1', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'113', N'15', N'adminWidgetSearchProducts', N'Admin Home: Search Products', N'true', N'boolean', N'Show product search on Admin Home page y/n', N'', N'0', N'3', N'35', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'114', N'15', N'adminWidgetSearchOrders', N'Admin Home: Search Orders', N'true', N'boolean', N'Show order search on Admin Home page y/n', N'', N'0', N'2', N'35', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'115', N'15', N'adminWidgetSearchCustomers', N'Admin Home: Search Customers', N'true', N'boolean', N'Show customer search on Admin Home page y/n', null, N'0', N'1', N'35', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'116', N'10', N'debugDisplayExpanded', N'Show Debug Expanded', N'0', N'boolean', N'Show debug cfdump output expanded by default', N'', N'0', N'4', N'35', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'117', N'25', N'globalTimeOffset', N'Server Time Offset (+/-)(hh:mm)', N'0', N'number', N'The global time offset, in hours or fractional hours, from server time to displayed store time (if your server is at 1pm, and your site is at 3pm, the value would be +2)', N'', N'0', N'7', N'5', N'5', N'1', N'1', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'118', N'25', N'globalDateMask', N'Date Format', N'yyyy-mm-dd', N'select', N'A global format to be applied to all displayed dates sitewide', N'''mm/dd/yyyy'' (07/28/2011)|mm/dd/yyyy
''m/d/yy'' (7/28/11)|m/d/yy
''dd/mm/yyyy'' (28/7/2011)|dd/mm/yyyy
''d/m/yy'' (28/7/11)|d/m/yy
''yyyy-mm-dd'' (2011-07-28)|yyyy-mm-dd', N'0', N'5', N'35', N'5', N'1', N'1', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'119', N'7', N'adminEditorCategoryDescrip', N'Categories: Text Editor', N'true', N'boolean', N'Show rich text editor for category and secondary category descriptions (if no, simple text input shown)', N'', N'0', N'7', N'35', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'120', N'7', N'adminEditorProductDescrip', N'Products: Text Editor', N'true', N'boolean', N'Show rich text editor for product descriptions (if no, simple textarea shown)', N'', N'0', N'9', N'35', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'121', N'7', N'adminEditorOptionDescrip', N'Options: Text Editor', N'true', N'boolean', N'Show rich text editor for option descriptions (if no, simple textarea shown)', N'', N'0', N'8', N'45', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'122', N'7', N'adminThemeDirectory', N'Theme Directory', N'neutral', N'select', N'The directory for Cartweaver admin theme stylesheet and graphics', N'', N'0', N'11', N'35', N'5', N'1', N'1', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'124', N'14', N'appImageDefault', N'Default Image Filename', N'noimgupload.jpg', N'text', N'To activate the default placeholder image, enter the filename of any image that has been uploaded via the product form.', N'', N'0', N'2', N'35', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'125', N'30', N'appTestModeEnabled', N'TEST MODE ON', N'0', N'boolean', N'For development purposes only, bypasses some global warnings and functions to allow for easier setup.', N'', N'0', N'1', N'35', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'126', N'25', N'appSiteUrlHttp', N'Site URL', N'', N'text', N'The website root directory url, starting with http://, no trailing slash (e.g. http://www.cartweaver.com )', N'', N'0', N'1', N'45', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'127', N'25', N'appSiteUrlHttps', N'Site Secure URL', N'', N'text', N'The URL for your secure root directory (usually same as Site URL, with https:// prefix). If no SSL is used for the site, use the http prefix here, or leave this blank.', N'', N'0', N'2', N'45', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'129', N'10', N'debugPassword', N'Debugging Password', N'cwdebug', N'text', N'Add this password to the url to turn on debugging from any page (&debug=[debugpw])', N'', N'0', N'3', N'35', N'5', N'1', N'1', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'130', N'13', N'appActionAddToCart', N'Add to Cart Action', N'goto', N'select', N'The response after adding an item to the cart (confirm|goto)', N'Product Details Page|confirm
Go To Cart|goto', N'0', N'1', N'35', N'5', N'1', N'1', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'131', N'12', N'appPageResults', N'Results Page (filename)', N'productlist.cfm', N'text', N'The page displaying product listings', null, N'0', N'1', N'35', N'5', N'1', N'1', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'132', N'12', N'appPageDetails', N'Details Page (filename)', N'product.cfm', N'text', N'The page displaying product details', null, N'0', N'2', N'35', N'5', N'1', N'1', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'133', N'12', N'appPageShowCart', N'Cart Page (filename)', N'cart.cfm', N'text', N'The page displaying cart details', null, N'0', N'3', N'35', N'5', N'1', N'1', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'134', N'12', N'appPageCheckout', N'Checkout Page (filename)', N'checkout.cfm', N'text', N'The page displaying checkout forms (log in / customer info)', null, N'0', N'4', N'35', N'5', N'1', N'1', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'135', N'12', N'appPageConfirmOrder', N'Order Confirmation Page (filename)', N'confirm.cfm', N'text', N'The page displaying order confirmation', null, N'0', N'5', N'35', N'5', N'1', N'1', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'136', N'7', N'adminEditorCSS', N'Text Editor CSS File (file path and name)', N'css/cw-styles.css', N'text', N'The css file used to define text styles in scripted text editors (product descriptions), relative to /cw/ directory', null, N'0', N'10', N'35', N'5', N'1', N'1', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'137', N'14', N'appImagesDir', N'Images Directory (folder name)', N'images', N'text', N'The folder for CW product images (created automatically if it does not already exist)', null, N'0', N'1', N'35', N'5', N'1', N'1', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'138', N'27', N'mailSmtpServer', N'SMTP Email Server', N'', N'text', N'The mail server host name (usually ''localhost'' or left blank)', null, N'0', N'1', N'35', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'139', N'27', N'mailSmtpUsername', N'SMTP Username', N'', N'text', N'The SMTP username (may be left blank)', null, N'0', N'2', N'35', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'140', N'27', N'mailSmtpPassword', N'SMTP Password', N'', N'text', N'The SMTP password (may be left blank)', null, N'0', N'3', N'35', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'142', N'9', N'paymentMethods', N'Payment Collection Method', N'cw-auth-account.cfm', N'checkboxgroup', N'The checkout methods, and corresponding connection files, to use for your processing or payment gateway', N'In-Store Account|cw-auth-account.cfm
Authorize.net|cw-auth-authorizenet.cfm
PayPal|cw-auth-paypal.cfm
SagePay UK|cw-auth-sagepay.cfm
WorldPay|cw-auth-worldpay.cfm', N'0', N'1', N'35', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'143', N'25', N'globalLocale', N'Default Locale (nationality)', N'English (US)', N'select', N'The default nationality or locale for your site, used to automatically set other location-specific settings', N'Chinese(China)|Chinese (China)
Chinese(Hong Kong)|Chinese (Hong Kong)
Chinese(Taiwan)|Chinese (Taiwan)
English(Australian)|English (Australian)
English(Canadian)|English (Canadian)
English(New Zealand)|English (New Zealand)
English(UK)|English (UK)
English(US)|English (US)
French(Belgian)|French (Belgian)
French(Canadian)|French (Canadian)
French(Standard)|French (Standard)
French(Swiss)|French (Swiss)
German(Austrian)|German (Austrian)
German(Standard)|German (Standard)
German(Swiss)|German (Swiss)
Italian(Standard)|Italian (Standard)
Italian(Swiss)|Italian (Swiss)
Japanese|Japanese
Korean|Korean
Norwegian(Bokmal)|Norwegian (Bokmal)
Norwegian(Nynorsk)|Norwegian (Nynorsk)
Portuguese(Brazilian)|Portuguese (Brazilian)
Portuguese(Standard)|Portuguese (Standard)
Spanish(Standard)|Spanish (Standard)
Spanish(Modern)|Spanish (Modern)
Swedish|Swedish', N'0', N'6', N'35', N'5', N'1', N'1', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'144', N'25', N'appDbType', N'Database Type', N'MSSQLServer', N'select', N'The database type for the application', N'mySQL|mySQL
MS SQL|MSSQLServer', N'0', N'4', N'35', N'5', N'1', N'1', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'145', N'14', N'adminImagesMerchantDeleteOrig', N'Original Images: Merchant Delete', N'true', N'boolean', N'Allow the ''Merchant'' user level to see the ''delete all originals'' button on the Product Images page', N'', N'0', N'3', N'35', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'146', N'24', N'adminSkuEditMode', N'SKU display format', N'standard', N'select', N'Select the format for sku display on the product details SKU tab.', N'Standard|standard
List View|list', N'0', N'5', N'35', N'5', N'1', N'1', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'147', N'24', N'adminSkuEditModeLink', N'SKU Mode Link: Show Merchant?', N'true', N'boolean', N'Allow the merchant to change SKU view mode?', N'', N'0', N'6', N'35', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'148', N'24', N'adminProductUpsellThumbsEnabled', N'Enable Related Product Thumbnails', N'true', N'boolean', N'Enable thumbnails in related product tab of product details page', N'', N'0', N'21', N'35', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'149', N'5', N'taxSystemLabel', N'Tax / VAT Text Label', N'Tax', N'select', N'The name of the tax system in use, Tax(es) or VAT.', N'Tax|Tax
VAT|VAT
GST|GST', N'0', N'1', N'35', N'5', N'1', N'1', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'150', N'27', N'mailHeadText', N'Email Heading (Text)', N'Our Cartweaver Site : cartweaver.com', N'textarea', N'Text inserted into all emails sent from the site, at the beginning of the message body.', N'', N'0', N'5', N'45', N'4', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'151', N'27', N'mailHeadHtml', N'Email Heading (HTML)', N'<h2><strong>Our Cartweaver Site : cartweaver.com</strong></h2>', N'texteditor', N'Formatted text inserted into all HTML-version emails sent from the site, at the beginning of the message body.', N'', N'0', N'6', N'45', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'152', N'27', N'mailFootText', N'Email Signature (Text)', N'Thank you for choosing Our Site for your online purchase!', N'textarea', N'Text inserted into all emails sent from the site, at the end of the message body.', N'', N'0', N'7', N'45', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'153', N'27', N'mailFootHtml', N'Email Signature (HTML)', N'<p><em><strong>Thank you for choosing <a href="http://www.cartweaver.com">Our Site</a> for your online purchase!</strong></em></p>', N'texteditor', N'Text inserted into all emails sent from the site, at the end of the message body.', N'', N'0', N'8', N'45', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'154', N'27', N'mailMultipart', N'Mail Format', N'1', N'select', N'If Multi-Part is selected, mail will be sent in both html and text format, allowing the recipient''s email reader to display the preferred format. The Text Only setting will allow for only plain text email to be sent from this site.', N'Multi-Part (html + text)|1,
Text Only|0', N'0', N'4', N'35', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'155', N'7', N'adminErrorHandling', N'Use Admin Error Handling', N'false', N'boolean', N'db', N'', N'0', N'1', N'35', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'156', N'27', N'mailDefaultOrderShippedIntro', N'Order Shipped Intro', N'Your order has been shipped.', N'textarea', N'Intro text for order shipping status email to customers', N'', N'0', N'13', N'45', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'157', N'27', N'mailDefaultOrderShippedEnd', N'Order Shipped Footer', N'We appreciate your business, and welcome any questions or requests you may have.', N'textarea', N'Footer text for order shipping status email to customers', N'', N'0', N'14', N'45', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'158', N'24', N'adminProductDefaultPrice', N'Default Price', N'0', N'text', N'The value shown by default in the ''new sku'' form. Can be left blank to force user input via form validation, or set to any numeric value.', N'', N'0', N'8', N'5', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'160', N'8', N'appDisplayProductQtyType', N'Quantity Selection Type', N'text', N'radio', N'Use a select box or a text input for the quantity.', N'select|select
text|text', N'0', N'9', N'35', N'5', N'1', N'1', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'161', N'8', N'appDisplayProductSort', N'Show Product Sort Links', N'true', N'boolean', N'Show links to sort product listings (results sortable)', N'', N'0', N'4', N'35', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'162', N'8', N'appDisplayProductViews', N'Number of Recently Viewed Items', N'5', N'number', N'The number of recently viewed products - set to 0 to turn off recent products view.', N'', N'0', N'16', N'2', N'5', N'1', N'1', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'163', N'13', N'appDisplayCartSku', N'Show SKU Name in Cart', N'true', N'boolean', N'Determines whether the sku name displayed in the cart', N'', N'0', N'3', N'35', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'164', N'13', N'appDisplayCartOrder', N'Order of Products in Cart', N'timeAdded', N'select', N'Show items in the cart in order they are added, or by product sort order and name', N'Added to Cart|timeAdded
Product Name|productName', N'0', N'6', N'35', N'5', N'1', N'1', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'165', N'8', N'appDisplayListingAddToCart', N'Add to Cart from Product Listings', N'true', N'boolean', N'Show ''Add to Cart'' button on product listing page (y/n)', N'', N'0', N'7', N'35', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'166', N'13', N'appDisplayCartCustom', N'Show Custom Values in Cart', N'true', N'boolean', N'Show the custom values for product personalizations in the cart (y/n)', N'', N'0', N'4', N'35', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'167', N'8', N'appDisplayProductSortType', N'Product Sort Links Type', N'select', N'select', N'The type of sorting display to show on the product listings page.', N'Select List (dropdown)|select
Standard Links|links', N'0', N'5', N'35', N'5', N'1', N'1', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'168', N'8', N'appDisplayProductCategories', N'Lookup Product Categories', N'true', N'boolean', N'Get category and secondary for page titles, navigation and other functions based on product ID in url if category IDs are not provided (y/n)', N'', N'0', N'20', N'35', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'173', N'8', N'appDisplayPageLinksMax', N'Max. Paging Links', N'5', N'number', N'The maximum number of product paging links to show at once on the product listings page.', N'', N'0', N'6', N'35', N'5', N'1', N'1', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'174', N'8', N'appDisplayEmptyCategories', N'Show Empty Categories', N'0', N'boolean', N'Show categories with no active products in navigation menus and search options (y/n)', N'', N'0', N'19', N'35', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'175', N'29', N'customerAccountEnabled', N'Enable Customer Account', N'true', N'boolean', N'Enable customer account functions including order and product history, and access to saved information.', N'', N'0', N'1', N'35', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'176', N'12', N'appPageAccount', N'Account Page (filename)', N'account.cfm', N'text', N'The page displaying customer account', N'', N'0', N'6', N'35', N'5', N'1', N'1', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'177', N'13', N'appDisplayCartCustomEdit', N'Edit Custom Values in Cart', N'true', N'boolean', N'Allow customer to edit custom values in the cart view (y/n)', N'', N'0', N'5', N'35', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'179', N'12', N'appPageSearch', N'Search Page (filename)', N'index.cfm', N'text', N'The page used for product search system. Leave blank if none exists. Optional  (unlike other page variables).', N'', N'0', N'7', N'35', N'5', N'1', N'0', N'');
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'180', N'27', N'mailDefaultPasswordSentIntro', N'Password Reminder Intro', N'Account Information Request', N'textarea', N'Intro text for password reminder email to customers', N'', N'0', N'15', N'45', N'5', N'1', N'1', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'181', N'27', N'mailDefaultPasswordSendEnd', N'Password Reminder Footer', N'For further assistance with your account, please contact our customer service department.', N'textarea', N'Footer text for password reminder email to customers', N'', N'0', N'16', N'45', N'5', N'1', N'1', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'182', N'3', N'companyURL', N'Company Url', N'http://www.cartweaver.com', N'text', N'The web address as shown in email messages, does not have to be the same as the site home page or other global URL settings.', N'', N'0', N'2', N'35', N'5', N'1', N'1', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'185', N'27', N'mailDefaultOrderReceivedIntro', N'Order Received Intro', N'Your order has been received, and is being held pending payment. 
We will notify you again when any payments have been processed, and when your order is shipped.', N'textarea', N'Intro text for order confirmation email to customers', N'', N'0', N'9', N'45', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'186', N'27', N'mailDefaultOrderReceivedEnd', N'Order Received Footer', N'Please save this email for future reference.
We appreciate your business, and welcome any questions or requests you may have.', N'textarea', N'Footer text for order confirmation notice to customers', N'', N'0', N'10', N'45', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'187', N'27', N'mailDefaultOrderPaidIntro', N'Order Paid Intro', N'Your payment has been approved. 
You will receive another notice when your order is shipped.', N'textarea', N'Intro text for order paid in full notice to customers', null, N'0', N'11', N'45', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'188', N'27', N'mailDefaultOrderPaidEnd', N'Order Paid Footer', N'We appreciate your business, and welcome any questions or requests you may have.', N'textarea', N'Footer text for order paid in full notice to customers', null, N'0', N'12', N'45', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'189', N'29', N'customerAccountRequired', N'Require Customer Account', N'0', N'boolean', N'If accounts are enabled, require customer account (unchecked = allow guest checkout)', N'', N'0', N'2', N'35', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'190', N'8', N'appDisplayFreeShipMessage', N'Show Free Shipping Message', N'true', N'boolean', N'Show a message along with pricing when the item is set to shipping = no', N'', N'0', N'11', N'35', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'191', N'8', N'appFreeShipMessage', N'Free Shipping Message Text', N'FREE SHIPPING on this item', N'text', N'The message to show if an item is set to shipping = no, and message is enabled', N'', N'0', N'12', N'35', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'192', N'6', N'upsAccessLicense', N'UPS Shipping Access License', N'', N'text', N'The UPS shipping API Access License Key for live UPS rate lookup', N'', N'0', N'8', N'35', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'193', N'3', N'companyShipCountry', N'Country Ship Code', N'US', N'text', N'Shipping code for country', N'', N'0', N'11', N'35', N'5', N'1', N'1', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'194', N'5', N'taxCalctype', N'Tax Calculation Method', N'localtax', N'select', N'The calculation method to use for retrieving product tax values (localtax = CW extensions). NOTE: some related settings are automatically set and/or disabled when selecting an option other than Local.', N'Local Database|localtax
AvaTax|avatax', N'0', N'3', N'35', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'195', N'8', N'appSearchMatchType', N'Keyword Search Matching Rule', N'any', N'select', N'Determines default search match to use - can be overridden wherever the search box is displayed, by passing in arguments.match_type.', N'Any Word|any
Exact Phrase|phrase
All Words|all', N'0', N'17', N'35', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'196', N'25', N'appCookieTerm', N'Cookie Expiration Term', N'240', N'text', N'Length of time to expire cookies. Options are 0 (no cookies), blank (never expire), or number of hours.', N'', N'0', N'8', N'7', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'197', N'29', N'customerRememberMe', N'Show Remember Me Checkbox', N'true', N'boolean', N'If checked, the ''remember me'' checkbox is shown on the login form, and a cookie is saved with the customer''s username.', N'', N'0', N'3', N'35', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'198', N'25', N'appCWContentDir', N'CW Content Directory: CAUTION!', N'cw4/', N'text', N'File path from server web root to Cartweaver''s content directory. This is for a file path only, not used for URLs. Value is usually ''cw4'' NOTE: should include trailing slash', N'', N'0', N'2.1', N'35', N'5', N'1', N'1', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'199', N'25', N'appCWAdminDir', N'CW Admin Directory: CAUTION!', N'cw4/admin/', N'text', N'Path from site root to Cartweaver''s admin directory, used for admin URLs. Value is usually ''cw4/admin/'' NOTE: should include trailing slash', N'', N'0', N'2.4', N'35', N'5', N'1', N'1', N'');
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'200', N'7', N'adminRecordsPerPage', N'Records per Page', N'20', N'select', N'Number of products, orders and customers to show per page (if paging for that item is enabled)', N'10|10
20|20
30|30
40|40
50|50
100|100', N'0', N'5', N'0', N'0', N'1', N'0', N'');
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'201', N'25', N'appCWStoreRoot', N'CW Store Root: CAUTION!', N'', N'text', N'Path from site root to Cartweaver file contents, added to prefix of nav urls and form actions. Value is usually empty ('''')', N'', N'0', N'2.2', N'35', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'202', N'5', N'taxUseDefaultCountry', N'Use Default Country for Tax', N'false', N'boolean', N'If checked, the default country will be used to calculate and show tax totals in the cart, when customer''s country is not available.', N'', N'1', N'5', N'35', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'203', N'6', N'shipDisplaySingleMethod', N'Show Single Shipping Option', N'true', N'boolean', N'If enabled, the shipping information step of the checkout process will still be shown when only one shipping method is available. If unchecked, it will be skipped automatically.', N'', N'1', N'2', N'35', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'204', N'11', N'adminDiscountThumbsEnabled', N'Show Associated Thumbnails', N'true', N'boolean', N'If enabled, thumbnails will be available in discount associated items.', N'', N'1', N'4', N'35', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'205', N'13', N'appOrderForceConfirm', N'Force Confirmation of All Orders', N'true', N'boolean', N'Force all persisted orders to show confirmation page on return to site. Useful for paypal and other off-site processors, where customer may not always view the confirmation page manually but may return to site with order info saved in a cookie or session variable.', N'', N'1', N'8', N'35', N'5', N'1', N'0', N'');
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'206', N'5', N'avalaraID', N'Avalara - AvaTax Account ID', N'', N'text', N'If using the Avalara AvaTax service, this is the API ID provided for your website location.', N'', N'1', N'11', N'35', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'207', N'5', N'avalaraKey', N'Avalara - AvaTax Access Key', N'', N'text', N'If using the Avalara AvaTax service, this is the API Key provided for your website location.', N'', N'1', N'12', N'45', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'208', N'25', N'appInstallationDate', N'Installation Date', N'', N'text', N'Blank by default, this is set on the first page request from a newly-installed application. Useful for tracking core application updates. Simply delete the value and save to reset the timestamp on next login.', N'', N'1', N'13', N'35', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'209', N'25', N'appHttpRedirectEnabled', N'Force Http & Https Redirection', N'false', N'boolean', N'(Optional) If an HTTPS address is provided for the site, forces redirection between the http and https prefixes, requiring cart and account pages to be https only, while others are http only. See cw-func-init for processing code or to make adjustments.', N'', N'1', N'3', N'35', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'210', N'30', N'appDataDeleteEnabled', N'Delete Test Data Enabled', N'true', N'boolean', N'If enabled, the developer will see a menu option to Delete Test Data, and the cleanup script will be enabled.', N'', N'1', N'2', N'35', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'211', N'8', N'appDisplayUpsellColumns', N'Number of Related Item Columns', N'4', N'number', N'The number of related items to show per row in the default product details output.', N'', N'1', N'15', N'2', N'5', N'1', N'1', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'212', N'8', N'productPerPageOptions', N'Products Per Page List Options', N'6,12,24,48', N'text', N'A list of numeric values to be used for the per page selector - only used if sort type is select list/dropdown', N'', N'1', N'3', N'35', N'5', N'1', N'0', N'');
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'213', N'5', N'avalaraUrl', N'Avalara Tax URL', N'https://development.avalara.net/1.0/', N'text', N'The API url for your Avalara tax account, including the version number and trailing slash (e.g. https://development.avalara.net/1.0/, https://rest.avalara.net/1.0/)', N'', N'0', N'13', N'35', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'214', N'5', N'avalaraDefaultCode', N'Avalara Tax Default Item Code', N'O9999999', N'text', N'The code to use for items where a tax group code is unavailable.', N'', N'1', N'14', N'35', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'215', N'5', N'avalaraDefaultShipCode', N'Avalara Tax Default Shipping Code', N'FR020100', N'text', N'The shipping tax code to use for tax charged on shipping, if applicable.', N'', N'1', N'15', N'35', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'216', N'6', N'upsUserID', N'UPS Shipping User ID', N'', N'text', N'The Account User ID for the UPS shipping rates API', N'', N'1', N'9', N'35', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'217', N'6', N'upsPassword', N'UPS Shipping Password', N'', N'text', N'The Account Password for the UPS shipping rates API', N'', N'1', N'10', N'35', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'218', N'6', N'upsUrl', N'UPS Shipping URL', N'https://onlinetools.ups.com/ups.app/xml/Rate', N'text', N'The URL for UPS API Transactions', N'The URL for UPS API Transactions', N'1', N'11', N'35', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'219', N'6', N'shipWeightUOM', N'Shipping Weight Unit of Measure', N'lbs', N'select', N'The Unit of Measure for shipping weight values, used for shipping rate API transactions', N'lbs|lbs
kgs|kgs', N'1', N'7', N'35', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'220', N'5', N'taxErrorEmail', N'Tax Transaction Error Email', N'', N'text', N'The email address for remote tax system errors. Leave blank to disable. Not used for Local Database calculations.', N'', N'1', N'16', N'35', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'221', N'5', N'taxSendLookupErrors', N'Tax Error Email on Basic Lookup', N'true', N'boolean', N'If enabled, and a tax error email address is provided, error alerts will be sent for general view cart tax errors. If not checked, error alerts are only sent for actual checkout transactions.', N'', N'0', N'17', N'35', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'222', N'31', N'appDownloadsDir', N'Downloads Directory (folder name)', N'../../downloads', N'text', N'The folder for CW download files, relative to the site root (created automatically if it does not already exist). Tip: use ../ prefix to put your files above your site root for security (if using this method, directory must already exist).', N'', N'0', N'4', N'35', N'5', N'1', N'1', N'');
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'223', N'31', N'appDownloadsEnabled', N'Downloads Enabled', N'true', N'boolean', N'If unchecked, all file download functionality is disabled', N'', N'0', N'1', N'35', N'5', N'1', N'0', N'');
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'224', N'31', N'appDownloadsFileTypes', N'Allowed File Types', N'application/zip,application/x-zip,application/x-zip-compressed,application/pdf,audio/mpeg3', N'textarea', N'Comma-separated list of allowed', null, N'0', N'8', N'35', N'3', N'1', N'0', N'');
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'225', N'31', N'appDownloadsFileExtDirs', N'Divide Files by Extension', N'true', N'boolean', N'If checked, files will be separated into subdirectories named for the file type', N'', N'0', N'3', N'35', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'226', N'31', N'appDownloadsMaxKb', N'Max. File Size (kb)', N'5000', N'number', N'The maximum filesize allowed for files uploaded through the product admin.', N'', N'0', N'9', N'7', N'5', N'1', N'1', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'227', N'31', N'appDownloadsLimitDefault', N'Download Limit Default', N'3', N'number', N'The default number shown in the download limit on the sku file upload form.', N'', N'0', N'10', N'5', N'1', N'1', N'1', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'228', N'31', N'appPageDownload', N'Download Page', N'download.cfm', N'text', N'The name of your site''s download page, in the site root.', N'', N'0', N'6', N'35', N'5', N'1', N'1', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'229', N'31', N'appDownloadStatusCodes', N'Order Status Codes', N'3,4', N'text', N'List of order status codes allowed to download files (default=3,4/paid,shipped). If blank, no downloads will be available.', N'', N'0', N'7', N'35', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'230', N'31', N'appDownloadsMaskFilenames', N'Mask Filenames', N'true', N'boolean', N'If checked, files are saved with a unique filename on the server. (The original filename is restored when downloaded by the customer).', N'', N'0', N'2', N'35', N'5', N'1', N'0', N'');
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'231', N'31', N'appDownloadsPath', N'Downloads Path (full path)', N'', N'text', N'If provided, overrides appDownloadsDir, forcing downloads to and from an absolute path on the server. Leave blank to use appDownloadsDir instead.', N'', N'0', N'5', N'35', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'232', N'27', N'mailSendOrderCustomer', N'Send Customer Order Notification', N'true', N'boolean', N'If checked, email notification will be sent to the customer upon submission of the order, regardless of payment status', N'', N'0', N'4.1', N'35', N'5', N'1', N'0', N'');
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'233', N'27', N'mailSendOrderMerchant', N'Send Merchant Order Notification', N'true', N'boolean', N'If checked, email notification will be sent to the merchant upon submission of the order, regardless of payment status', N'', N'0', N'4.2', N'35', N'5', N'1', N'0', N'');
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'234', N'27', N'mailSendPaymentCustomer', N'Send Customer Payment Notification', N'true', N'boolean', N'If checked, email notification will be sent to the customer upon receipt of payment', N'', N'0', N'4.3', N'35', N'5', N'1', N'0', N'');
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'235', N'27', N'mailSendPaymentMerchant', N'Send Merchant Payment Notification', N'true', N'boolean', N'If checked, email notification will be sent to the merchant upon receipt of payment', N'', N'0', N'4.4', N'35', N'5', N'1', N'0', N'');
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'236', N'27', N'mailSendShipCustomer', N'Send Customer Ship Notification', N'true', N'boolean', N'If checked, email notification will be sent to the customer when the order status is changed to Shipped in the admin', N'', N'0', N'4.5', N'35', N'5', N'1', N'0', N'');
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'237', N'13', N'appDisplayCountryType', N'State/Country Selection Type', N'split', N'select', N'Show countries and states/regions in a single list (best for sites with only one or two countries) or as separate selections (for sites with many active countries)', N'Single List|single
Separate Selections|split', N'0', N'9', N'0', N'0', N'1', N'1', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'238', N'5', N'avalaraCompanyCode', N'Avalara - AvaTax Company Code', N'', N'text', N'If using the Avalara AvaTax service, this is the company code for your store location.', N'', N'1', N'13.5', N'35', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'239', N'6', N'fedexAccessKey', N'FedEx Access Key', N'', N'text', N'The Access Key for the FedEx shipping rates API', N'', N'1', N'12.000', N'35', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'240', N'6', N'fedexPassword', N'FedEx Password', N'', N'text', N'The Password for the FedEx shipping rates API', N'', N'1', N'13.000', N'35', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'241', N'6', N'fedexAccountNumber', N'FedEx Account Number', N'', N'text', N'The Account Number for the FedEx shipping rates API', N'', N'1', N'14.000', N'35', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'242', N'6', N'fedexMeterNumber', N'FedEx Meter Number', N'', N'text', N'The Meter Number for the FedEx shipping rates API', N'', N'1', N'15.000', N'35', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'243', N'6', N'fedexUrl', N'FedEx Shipping URL', N'https://wsbeta.fedex.com:443/web-services', N'text', N'The URL for FedEx API Transactions', N'', N'1', N'16.000', N'35', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'244', N'3', N'companyShipState', N'State/Prov Ship Code', N'WA', N'text', N'Tax/shipping code for the company state', N'', N'0', N'8.5', N'5', N'0', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'245', N'8', N'appThumbsPerRow', N'Thumbnails Per Row', N'5', N'number', N'Number of thumbnail images shown in each row on the product details page', N'', N'0', N'13.5', N'2', N'0', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'246', N'8', N'appThumbsPosition', N'Thumbnails Position', N'below', N'select', N'Position of thumbnails area on product details page', N'Top of Page|first\r\nAbove Main Image|above\r\nBelow Main Image|below', N'0', N'13.6', N'0', N'0', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'247', N'25', N'appCWAssetsDir', N'CW Assets Directory: CAUTION!', N'cw4/', N'text', N'Path from site root to the cw4 folder, added to prefix of css and javascript src attributes. Value is usually ''cw4/'' NOTE: should include trailing slash', N'', N'0', N'2.300', N'35', N'5', N'1', N'1', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'248', N'6', N'uspsUserID', N'U.S. Postal Service User ID', N'', N'text', N'The Account User ID for the USPS shipping rates API', N'', N'1', N'17', N'35', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'249', N'6', N'uspsPassword', N'U.S. Postal Service User ID', N'', N'text', N'The Account Password for the USPS shipping rates API', N'', N'1', N'18', N'35', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'250', N'6', N'uspsUrl', N'U.S. Postal Service User ID URL', N'http://production.shippingapis.com/ShippingAPI.dll', N'text', N'The URL for USPS API Transactions. Note: your USPS account must be in Production mode, contact USPS support for details.', N'', N'1', N'19', N'35', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'251', N'8', N'productShowAll', N'Enable Show All Products', N'false', N'boolean', N'If checked, per page options will include a link to show all products', N'', N'1', N'3.500', N'35', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'252', N'25', N'adminHttpsRedirectEnabled', N'Admin Https Only', N'false', N'boolean', N'If selected, force admin area to use https', N'', N'1', N'3.600', N'35', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_config_items] ([config_id], [config_group_id], [config_variable], [config_name], [config_value], [config_type], [config_description], [config_possibles], [config_show_merchant], [config_sort], [config_size], [config_rows], [config_protected], [config_required], [config_directory]) VALUES (N'253', N'15', N'adminWidgetCustomersDays', N'Admin Home: Top Customer Days', N'60', N'number', N'Number of days for top customer data (longer report ranges can result in slow queries)', N'', N'0', N'6', N'3', N'5', N'1', N'1', null);
;
SET IDENTITY_INSERT [dbo].[cw_config_items] OFF
;

-- ----------------------------
-- Table structure for [dbo].[cw_countries]
-- ----------------------------
IF OBJECT_ID('[dbo].[cw_countries]') IS NOT NULL DROP TABLE [dbo].[cw_countries]
;
CREATE TABLE [dbo].[cw_countries] (
[country_id] int NOT NULL IDENTITY(1,1) ,
[country_name] nvarchar(150) NULL ,
[country_code] nvarchar(150) NULL ,
[country_sort] float(53) NULL DEFAULT '1.00',
[country_archive] int NULL DEFAULT '0',
[country_default_country] int NULL DEFAULT '0'
)


;
DBCC CHECKIDENT(N'[dbo].[cw_countries]', RESEED, 198)
;

-- ----------------------------
-- Records of cw_countries
-- ----------------------------
SET IDENTITY_INSERT [dbo].[cw_countries] ON
;
INSERT INTO [dbo].[cw_countries] ([country_id], [country_name], [country_code], [country_sort], [country_archive], [country_default_country]) VALUES (N'1', N'United States', N'US', N'1', N'0', N'1');
;
INSERT INTO [dbo].[cw_countries] ([country_id], [country_name], [country_code], [country_sort], [country_archive], [country_default_country]) VALUES (N'7', N'Belgium', N'BEL', N'9', N'1', N'0');
;
INSERT INTO [dbo].[cw_countries] ([country_id], [country_name], [country_code], [country_sort], [country_archive], [country_default_country]) VALUES (N'21', N'Argentina', N'AR', N'9', N'1', N'0');
;
INSERT INTO [dbo].[cw_countries] ([country_id], [country_name], [country_code], [country_sort], [country_archive], [country_default_country]) VALUES (N'23', N'Australia', N'AU', N'1', N'1', N'0');
;
INSERT INTO [dbo].[cw_countries] ([country_id], [country_name], [country_code], [country_sort], [country_archive], [country_default_country]) VALUES (N'38', N'Brazil', N'BR', N'9', N'1', N'0');
;
INSERT INTO [dbo].[cw_countries] ([country_id], [country_name], [country_code], [country_sort], [country_archive], [country_default_country]) VALUES (N'45', N'Canada', N'CA', N'1', N'0', N'0');
;
INSERT INTO [dbo].[cw_countries] ([country_id], [country_name], [country_code], [country_sort], [country_archive], [country_default_country]) VALUES (N'51', N'China', N'CN', N'9', N'1', N'0');
;
INSERT INTO [dbo].[cw_countries] ([country_id], [country_name], [country_code], [country_sort], [country_archive], [country_default_country]) VALUES (N'75', N'France', N'FR', N'1', N'1', N'0');
;
INSERT INTO [dbo].[cw_countries] ([country_id], [country_name], [country_code], [country_sort], [country_archive], [country_default_country]) VALUES (N'80', N'Germany', N'DE', N'9', N'1', N'0');
;
INSERT INTO [dbo].[cw_countries] ([country_id], [country_name], [country_code], [country_sort], [country_archive], [country_default_country]) VALUES (N'96', N'Ireland', N'IE', N'9', N'1', N'0');
;
INSERT INTO [dbo].[cw_countries] ([country_id], [country_name], [country_code], [country_sort], [country_archive], [country_default_country]) VALUES (N'97', N'Israel', N'IL', N'9', N'1', N'0');
;
INSERT INTO [dbo].[cw_countries] ([country_id], [country_name], [country_code], [country_sort], [country_archive], [country_default_country]) VALUES (N'98', N'Italy', N'IT', N'9', N'1', N'0');
;
INSERT INTO [dbo].[cw_countries] ([country_id], [country_name], [country_code], [country_sort], [country_archive], [country_default_country]) VALUES (N'100', N'Japan', N'JP', N'1', N'1', N'0');
;
INSERT INTO [dbo].[cw_countries] ([country_id], [country_name], [country_code], [country_sort], [country_archive], [country_default_country]) VALUES (N'127', N'Mexico', N'MX', N'1', N'1', N'0');
;
INSERT INTO [dbo].[cw_countries] ([country_id], [country_name], [country_code], [country_sort], [country_archive], [country_default_country]) VALUES (N'139', N'New Zealand', N'NZ', N'1', N'1', N'0');
;
INSERT INTO [dbo].[cw_countries] ([country_id], [country_name], [country_code], [country_sort], [country_archive], [country_default_country]) VALUES (N'175', N'Spain', N'ES', N'9', N'1', N'0');
;
INSERT INTO [dbo].[cw_countries] ([country_id], [country_name], [country_code], [country_sort], [country_archive], [country_default_country]) VALUES (N'198', N'United Kingdom', N'GB', N'1', N'1', N'0');
;
SET IDENTITY_INSERT [dbo].[cw_countries] OFF
;

-- ----------------------------
-- Table structure for [dbo].[cw_credit_cards]
-- ----------------------------
IF OBJECT_ID('[dbo].[cw_credit_cards]') IS NOT NULL DROP TABLE [dbo].[cw_credit_cards]
;
CREATE TABLE [dbo].[cw_credit_cards] (
[creditcard_id] int NOT NULL IDENTITY(1,1) ,
[creditcard_name] nvarchar(150) NULL ,
[creditcard_code] nvarchar(150) NULL ,
[creditcard_archive] int NULL DEFAULT '0' 
)


;
DBCC CHECKIDENT(N'[dbo].[cw_credit_cards]', RESEED, 24)
;

-- ----------------------------
-- Records of cw_credit_cards
-- ----------------------------
SET IDENTITY_INSERT [dbo].[cw_credit_cards] ON
;
INSERT INTO [dbo].[cw_credit_cards] ([creditcard_id], [creditcard_name], [creditcard_code], [creditcard_archive]) VALUES (N'2', N'MasterCard', N'mc', N'0');
;
INSERT INTO [dbo].[cw_credit_cards] ([creditcard_id], [creditcard_name], [creditcard_code], [creditcard_archive]) VALUES (N'3', N'American Express', N'amex', N'0');
;
INSERT INTO [dbo].[cw_credit_cards] ([creditcard_id], [creditcard_name], [creditcard_code], [creditcard_archive]) VALUES (N'4', N'Discover', N'disc', N'0');
;
INSERT INTO [dbo].[cw_credit_cards] ([creditcard_id], [creditcard_name], [creditcard_code], [creditcard_archive]) VALUES (N'18', N'Visa', N'visa', N'0');
;
INSERT INTO [dbo].[cw_credit_cards] ([creditcard_id], [creditcard_name], [creditcard_code], [creditcard_archive]) VALUES (N'21', N'Diners Club', N'diners', N'0');
;
INSERT INTO [dbo].[cw_credit_cards] ([creditcard_id], [creditcard_name], [creditcard_code], [creditcard_archive]) VALUES (N'24', N'Maestro', N'maestro', N'0');
;
SET IDENTITY_INSERT [dbo].[cw_credit_cards] OFF
;

-- ----------------------------
-- Table structure for [dbo].[cw_customer_stateprov]
-- ----------------------------
IF OBJECT_ID('[dbo].[cw_customer_stateprov]') IS NOT NULL DROP TABLE [dbo].[cw_customer_stateprov]
;
CREATE TABLE [dbo].[cw_customer_stateprov] (
[customer_state_id] int NOT NULL IDENTITY(1,1) ,
[customer_state_customer_id] nvarchar(150) NULL ,
[customer_state_stateprov_id] int NULL ,
[customer_state_destination] nvarchar(150) NULL 
)


;
DBCC CHECKIDENT(N'[dbo].[cw_customer_stateprov]', RESEED, 209)
;

-- ----------------------------
-- Records of cw_customer_stateprov
-- ----------------------------
SET IDENTITY_INSERT [dbo].[cw_customer_stateprov] ON
;
INSERT INTO [dbo].[cw_customer_stateprov] ([customer_state_id], [customer_state_customer_id], [customer_state_stateprov_id], [customer_state_destination]) VALUES (N'117', N'1', N'44', N'BillTo');
;
INSERT INTO [dbo].[cw_customer_stateprov] ([customer_state_id], [customer_state_customer_id], [customer_state_stateprov_id], [customer_state_destination]) VALUES (N'118', N'1', N'44', N'ShipTo');
;
INSERT INTO [dbo].[cw_customer_stateprov] ([customer_state_id], [customer_state_customer_id], [customer_state_stateprov_id], [customer_state_destination]) VALUES (N'126', N'D3970516-11-10-06', N'9', N'BillTo');
;
INSERT INTO [dbo].[cw_customer_stateprov] ([customer_state_id], [customer_state_customer_id], [customer_state_stateprov_id], [customer_state_destination]) VALUES (N'127', N'D3970516-11-10-06', N'9', N'ShipTo');
;
INSERT INTO [dbo].[cw_customer_stateprov] ([customer_state_id], [customer_state_customer_id], [customer_state_stateprov_id], [customer_state_destination]) VALUES (N'148', N'F45A2F10-25-09', N'3', N'BillTo');
;
INSERT INTO [dbo].[cw_customer_stateprov] ([customer_state_id], [customer_state_customer_id], [customer_state_stateprov_id], [customer_state_destination]) VALUES (N'149', N'F45A2F10-25-09', N'3', N'ShipTo');
;
INSERT INTO [dbo].[cw_customer_stateprov] ([customer_state_id], [customer_state_customer_id], [customer_state_stateprov_id], [customer_state_destination]) VALUES (N'150', N'F52B2C10-25-09', N'7', N'BillTo');
;
INSERT INTO [dbo].[cw_customer_stateprov] ([customer_state_id], [customer_state_customer_id], [customer_state_stateprov_id], [customer_state_destination]) VALUES (N'151', N'F52B2C10-25-09', N'7', N'ShipTo');
;
INSERT INTO [dbo].[cw_customer_stateprov] ([customer_state_id], [customer_state_customer_id], [customer_state_stateprov_id], [customer_state_destination]) VALUES (N'152', N'F5393110-25-09', N'7', N'BillTo');
;
INSERT INTO [dbo].[cw_customer_stateprov] ([customer_state_id], [customer_state_customer_id], [customer_state_stateprov_id], [customer_state_destination]) VALUES (N'153', N'F5393110-25-09', N'7', N'ShipTo');
;
INSERT INTO [dbo].[cw_customer_stateprov] ([customer_state_id], [customer_state_customer_id], [customer_state_stateprov_id], [customer_state_destination]) VALUES (N'154', N'F540EA10-25-09', N'7', N'BillTo');
;
INSERT INTO [dbo].[cw_customer_stateprov] ([customer_state_id], [customer_state_customer_id], [customer_state_stateprov_id], [customer_state_destination]) VALUES (N'155', N'F540EA10-25-09', N'7', N'ShipTo');
;
INSERT INTO [dbo].[cw_customer_stateprov] ([customer_state_id], [customer_state_customer_id], [customer_state_stateprov_id], [customer_state_destination]) VALUES (N'156', N'F55A7310-25-09', N'7', N'BillTo');
;
INSERT INTO [dbo].[cw_customer_stateprov] ([customer_state_id], [customer_state_customer_id], [customer_state_stateprov_id], [customer_state_destination]) VALUES (N'157', N'F55A7310-25-09', N'7', N'ShipTo');
;
INSERT INTO [dbo].[cw_customer_stateprov] ([customer_state_id], [customer_state_customer_id], [customer_state_stateprov_id], [customer_state_destination]) VALUES (N'158', N'F5606110-25-09', N'7', N'BillTo');
;
INSERT INTO [dbo].[cw_customer_stateprov] ([customer_state_id], [customer_state_customer_id], [customer_state_stateprov_id], [customer_state_destination]) VALUES (N'159', N'F5606110-25-09', N'7', N'ShipTo');
;
INSERT INTO [dbo].[cw_customer_stateprov] ([customer_state_id], [customer_state_customer_id], [customer_state_stateprov_id], [customer_state_destination]) VALUES (N'160', N'F5825210-25-09', N'7', N'BillTo');
;
INSERT INTO [dbo].[cw_customer_stateprov] ([customer_state_id], [customer_state_customer_id], [customer_state_stateprov_id], [customer_state_destination]) VALUES (N'161', N'F5825210-25-09', N'7', N'ShipTo');
;
INSERT INTO [dbo].[cw_customer_stateprov] ([customer_state_id], [customer_state_customer_id], [customer_state_stateprov_id], [customer_state_destination]) VALUES (N'162', N'FB64CA10-25-09', N'3', N'BillTo');
;
INSERT INTO [dbo].[cw_customer_stateprov] ([customer_state_id], [customer_state_customer_id], [customer_state_stateprov_id], [customer_state_destination]) VALUES (N'163', N'FB64CA10-25-09', N'3', N'ShipTo');
;
INSERT INTO [dbo].[cw_customer_stateprov] ([customer_state_id], [customer_state_customer_id], [customer_state_stateprov_id], [customer_state_destination]) VALUES (N'164', N'127B8710-26-09', N'9', N'BillTo');
;
INSERT INTO [dbo].[cw_customer_stateprov] ([customer_state_id], [customer_state_customer_id], [customer_state_stateprov_id], [customer_state_destination]) VALUES (N'165', N'127B8710-26-09', N'38', N'ShipTo');
;
INSERT INTO [dbo].[cw_customer_stateprov] ([customer_state_id], [customer_state_customer_id], [customer_state_stateprov_id], [customer_state_destination]) VALUES (N'166', N'139AAD10-26-09', N'23', N'BillTo');
;
INSERT INTO [dbo].[cw_customer_stateprov] ([customer_state_id], [customer_state_customer_id], [customer_state_stateprov_id], [customer_state_destination]) VALUES (N'167', N'139AAD10-26-09', N'23', N'ShipTo');
;
INSERT INTO [dbo].[cw_customer_stateprov] ([customer_state_id], [customer_state_customer_id], [customer_state_stateprov_id], [customer_state_destination]) VALUES (N'168', N'17D14A10-26-09', N'13', N'BillTo');
;
INSERT INTO [dbo].[cw_customer_stateprov] ([customer_state_id], [customer_state_customer_id], [customer_state_stateprov_id], [customer_state_destination]) VALUES (N'169', N'17D14A10-26-09', N'13', N'ShipTo');
;
INSERT INTO [dbo].[cw_customer_stateprov] ([customer_state_id], [customer_state_customer_id], [customer_state_stateprov_id], [customer_state_destination]) VALUES (N'170', N'56F28C10-01-11', N'1', N'BillTo');
;
INSERT INTO [dbo].[cw_customer_stateprov] ([customer_state_id], [customer_state_customer_id], [customer_state_stateprov_id], [customer_state_destination]) VALUES (N'171', N'56F28C10-01-11', N'1', N'ShipTo');
;
INSERT INTO [dbo].[cw_customer_stateprov] ([customer_state_id], [customer_state_customer_id], [customer_state_stateprov_id], [customer_state_destination]) VALUES (N'172', N'5A8B1C10-01-11', N'1', N'BillTo');
;
INSERT INTO [dbo].[cw_customer_stateprov] ([customer_state_id], [customer_state_customer_id], [customer_state_stateprov_id], [customer_state_destination]) VALUES (N'173', N'5A8B1C10-01-11', N'1', N'ShipTo');
;
INSERT INTO [dbo].[cw_customer_stateprov] ([customer_state_id], [customer_state_customer_id], [customer_state_stateprov_id], [customer_state_destination]) VALUES (N'174', N'F2DCF310-09-11', N'79', N'BillTo');
;
INSERT INTO [dbo].[cw_customer_stateprov] ([customer_state_id], [customer_state_customer_id], [customer_state_stateprov_id], [customer_state_destination]) VALUES (N'175', N'F2DCF310-09-11', N'79', N'ShipTo');
;
INSERT INTO [dbo].[cw_customer_stateprov] ([customer_state_id], [customer_state_customer_id], [customer_state_stateprov_id], [customer_state_destination]) VALUES (N'176', N'1ED3DF10-10-11', N'14', N'BillTo');
;
INSERT INTO [dbo].[cw_customer_stateprov] ([customer_state_id], [customer_state_customer_id], [customer_state_stateprov_id], [customer_state_destination]) VALUES (N'177', N'1ED3DF10-10-11', N'14', N'ShipTo');
;
INSERT INTO [dbo].[cw_customer_stateprov] ([customer_state_id], [customer_state_customer_id], [customer_state_stateprov_id], [customer_state_destination]) VALUES (N'178', N'FCFC9810-29-11', N'7', N'BillTo');
;
INSERT INTO [dbo].[cw_customer_stateprov] ([customer_state_id], [customer_state_customer_id], [customer_state_stateprov_id], [customer_state_destination]) VALUES (N'179', N'FCFC9810-29-11', N'7', N'ShipTo');
;
INSERT INTO [dbo].[cw_customer_stateprov] ([customer_state_id], [customer_state_customer_id], [customer_state_stateprov_id], [customer_state_destination]) VALUES (N'180', N'4EBDBF10-21-12', N'1', N'BillTo');
;
INSERT INTO [dbo].[cw_customer_stateprov] ([customer_state_id], [customer_state_customer_id], [customer_state_stateprov_id], [customer_state_destination]) VALUES (N'181', N'4EBDBF10-21-12', N'1', N'ShipTo');
;
INSERT INTO [dbo].[cw_customer_stateprov] ([customer_state_id], [customer_state_customer_id], [customer_state_stateprov_id], [customer_state_destination]) VALUES (N'182', N'67A0F910-21-12', N'3', N'BillTo');
;
INSERT INTO [dbo].[cw_customer_stateprov] ([customer_state_id], [customer_state_customer_id], [customer_state_stateprov_id], [customer_state_destination]) VALUES (N'183', N'67A0F910-21-12', N'3', N'ShipTo');
;
INSERT INTO [dbo].[cw_customer_stateprov] ([customer_state_id], [customer_state_customer_id], [customer_state_stateprov_id], [customer_state_destination]) VALUES (N'184', N'69E8BF10-21-12', N'28', N'BillTo');
;
INSERT INTO [dbo].[cw_customer_stateprov] ([customer_state_id], [customer_state_customer_id], [customer_state_stateprov_id], [customer_state_destination]) VALUES (N'185', N'69E8BF10-21-12', N'28', N'ShipTo');
;
INSERT INTO [dbo].[cw_customer_stateprov] ([customer_state_id], [customer_state_customer_id], [customer_state_stateprov_id], [customer_state_destination]) VALUES (N'186', N'149B4611-28-01', N'1', N'BillTo');
;
INSERT INTO [dbo].[cw_customer_stateprov] ([customer_state_id], [customer_state_customer_id], [customer_state_stateprov_id], [customer_state_destination]) VALUES (N'187', N'149B4611-28-01', N'1', N'ShipTo');
;
INSERT INTO [dbo].[cw_customer_stateprov] ([customer_state_id], [customer_state_customer_id], [customer_state_stateprov_id], [customer_state_destination]) VALUES (N'188', N'0BE78A11-02-02', N'10', N'BillTo');
;
INSERT INTO [dbo].[cw_customer_stateprov] ([customer_state_id], [customer_state_customer_id], [customer_state_stateprov_id], [customer_state_destination]) VALUES (N'189', N'0BE78A11-02-02', N'10', N'ShipTo');
;
INSERT INTO [dbo].[cw_customer_stateprov] ([customer_state_id], [customer_state_customer_id], [customer_state_stateprov_id], [customer_state_destination]) VALUES (N'190', N'26C95811-07-02', N'78', N'BillTo');
;
INSERT INTO [dbo].[cw_customer_stateprov] ([customer_state_id], [customer_state_customer_id], [customer_state_stateprov_id], [customer_state_destination]) VALUES (N'191', N'26C95811-07-02', N'78', N'ShipTo');
;
INSERT INTO [dbo].[cw_customer_stateprov] ([customer_state_id], [customer_state_customer_id], [customer_state_stateprov_id], [customer_state_destination]) VALUES (N'194', N'96C46711-18-08', N'48', N'BillTo');
;
INSERT INTO [dbo].[cw_customer_stateprov] ([customer_state_id], [customer_state_customer_id], [customer_state_stateprov_id], [customer_state_destination]) VALUES (N'195', N'96C46711-18-08', N'48', N'ShipTo');
;
INSERT INTO [dbo].[cw_customer_stateprov] ([customer_state_id], [customer_state_customer_id], [customer_state_stateprov_id], [customer_state_destination]) VALUES (N'206', N'FC4E0311-07-11', N'1', N'BillTo');
;
INSERT INTO [dbo].[cw_customer_stateprov] ([customer_state_id], [customer_state_customer_id], [customer_state_stateprov_id], [customer_state_destination]) VALUES (N'207', N'FC4E0311-07-11', N'1', N'ShipTo');
;
SET IDENTITY_INSERT [dbo].[cw_customer_stateprov] OFF
;

-- ----------------------------
-- Table structure for [dbo].[cw_customer_types]
-- ----------------------------
IF OBJECT_ID('[dbo].[cw_customer_types]') IS NOT NULL DROP TABLE [dbo].[cw_customer_types]
;
CREATE TABLE [dbo].[cw_customer_types] (
[customer_type_id] int NOT NULL IDENTITY(1,1) ,
[customer_type_name] nvarchar(150) NULL 
)


;
DBCC CHECKIDENT(N'[dbo].[cw_customer_types]', RESEED, 2)
;

-- ----------------------------
-- Records of cw_customer_types
-- ----------------------------
SET IDENTITY_INSERT [dbo].[cw_customer_types] ON
;
INSERT INTO [dbo].[cw_customer_types] ([customer_type_id], [customer_type_name]) VALUES (N'1', N'Retail');
;
INSERT INTO [dbo].[cw_customer_types] ([customer_type_id], [customer_type_name]) VALUES (N'2', N'Wholesale');
;
SET IDENTITY_INSERT [dbo].[cw_customer_types] OFF
;

-- ----------------------------
-- Table structure for [dbo].[cw_customers]
-- ----------------------------
IF OBJECT_ID('[dbo].[cw_customers]') IS NOT NULL DROP TABLE [dbo].[cw_customers]
;
CREATE TABLE [dbo].[cw_customers] (
[customer_id] nvarchar(150) NOT NULL ,
[customer_type_id] int NULL ,
[customer_date_added] datetime NULL ,
[customer_date_modified] datetime NULL ,
[customer_first_name] nvarchar(255) NULL ,
[customer_last_name] nvarchar(255) NULL ,
[customer_company] nvarchar(255) NULL ,
[customer_address1] nvarchar(255) NULL ,
[customer_address2] nvarchar(255) NULL ,
[customer_city] nvarchar(255) NULL ,
[customer_zip] nvarchar(255) NULL ,
[customer_ship_name] nvarchar(255) NULL ,
[customer_ship_company] nvarchar(255) NULL ,
[customer_ship_country] nvarchar(255) NULL ,
[customer_ship_address1] nvarchar(255) NULL ,
[customer_ship_address2] nvarchar(255) NULL ,
[customer_ship_city] nvarchar(255) NULL ,
[customer_ship_zip] nvarchar(255) NULL ,
[customer_phone] nvarchar(255) NULL ,
[customer_phone_mobile] nvarchar(255) NULL ,
[customer_email] nvarchar(255) NULL ,
[customer_username] nvarchar(255) NULL ,
[customer_password] nvarchar(255) NULL ,
[customer_guest] int NULL DEFAULT '0'
)


;

-- ----------------------------
-- Records of cw_customers
-- ----------------------------
INSERT INTO [dbo].[cw_customers] ([customer_id], [customer_type_id], [customer_date_added], [customer_date_modified], [customer_first_name], [customer_last_name], [customer_company], [customer_address1], [customer_address2], [customer_city], [customer_zip], [customer_ship_name], [customer_ship_company], [customer_ship_country], [customer_ship_address1], [customer_ship_address2], [customer_ship_city], [customer_ship_zip], [customer_phone], [customer_phone_mobile], [customer_email], [customer_username], [customer_password], [customer_guest]) VALUES (N'96C46711-18-08', N'1', N'2011-08-18 01:52:20.000', N'2011-11-08 15:04:55.000', N'Suzie', N'Shopper', N'9876', N'56789 Soma Street', null, N'Littletown', N'99999', N'Suzie Shopper', N'9876', null, N'56789 Somea Street', null, N'Littletown', N'99999', N'555-555-0965', N'555-555-0965', N'suzshopper@bogusmail.com', N'test12', N'test12', null);
;
INSERT INTO [dbo].[cw_customers] ([customer_id], [customer_type_id], [customer_date_added], [customer_date_modified], [customer_first_name], [customer_last_name], [customer_company], [customer_address1], [customer_address2], [customer_city], [customer_zip], [customer_ship_name], [customer_ship_company], [customer_ship_country], [customer_ship_address1], [customer_ship_address2], [customer_ship_city], [customer_ship_zip], [customer_phone], [customer_phone_mobile], [customer_email], [customer_username], [customer_password], [customer_guest]) VALUES (N'F45A2F10-25-09', N'1', N'2010-09-25 19:22:50.000', N'2011-12-08 23:39:06.000', N'Bob', N'Buyer', N'Some Company', N'4444 My St.', null, N'Sunny City', N'30322', N'Bob Buyer', N'Some Company', null, N'4444 My St.', null, N'Sunny City', N'30322', N'555-555-5555', null, N'bobbuyer@somebogusemail.com', N'test123', N'test123', null);
;
INSERT INTO [dbo].[cw_customers] ([customer_id], [customer_type_id], [customer_date_added], [customer_date_modified], [customer_first_name], [customer_last_name], [customer_company], [customer_address1], [customer_address2], [customer_city], [customer_zip], [customer_ship_name], [customer_ship_company], [customer_ship_country], [customer_ship_address1], [customer_ship_address2], [customer_ship_city], [customer_ship_zip], [customer_phone], [customer_phone_mobile], [customer_email], [customer_username], [customer_password], [customer_guest]) VALUES (N'FC4E0311-07-11', N'1', N'2011-11-07 13:03:55.000', N'2011-11-16 11:22:13.000', N'Wanda', N'Buymore', null, N'1234 st', null, N'some town', N'99999', N'Wanda Buymore', null, null, N'1234 st', null, N'some town', N'99999', N'555-555-1234', N'555-555-9999', N'buymore@bogusenmail.com', N'test1234', N'test1234', N'0');
;

-- ----------------------------
-- Table structure for [dbo].[cw_discount_amounts]
-- ----------------------------
IF OBJECT_ID('[dbo].[cw_discount_amounts]') IS NOT NULL DROP TABLE [dbo].[cw_discount_amounts]
;
CREATE TABLE [dbo].[cw_discount_amounts] (
[discount_amount_id] int NOT NULL IDENTITY(1,1) ,
[discount_amount_discount_id] int NULL DEFAULT '0',
[discount_amount_discount] float(53) NULL DEFAULT '0.00',
[discount_amount_minimum_qty] int NULL ,
[discount_amount_minimum_amount] float(53) NULL ,
[discount_amount_rate_type] nvarchar(150) NULL 
)


;
DBCC CHECKIDENT(N'[dbo].[cw_discount_amounts]', RESEED, 37)
;

-- ----------------------------
-- Records of cw_discount_amounts
-- ----------------------------
SET IDENTITY_INSERT [dbo].[cw_discount_amounts] ON
;
INSERT INTO [dbo].[cw_discount_amounts] ([discount_amount_id], [discount_amount_discount_id], [discount_amount_discount], [discount_amount_minimum_qty], [discount_amount_minimum_amount], [discount_amount_rate_type]) VALUES (N'35', N'64', N'10', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_discount_amounts] ([discount_amount_id], [discount_amount_discount_id], [discount_amount_discount], [discount_amount_minimum_qty], [discount_amount_minimum_amount], [discount_amount_rate_type]) VALUES (N'36', N'65', N'15', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_discount_amounts] ([discount_amount_id], [discount_amount_discount_id], [discount_amount_discount], [discount_amount_minimum_qty], [discount_amount_minimum_amount], [discount_amount_rate_type]) VALUES (N'37', N'66', N'10', N'0', N'0', N'0');
;
SET IDENTITY_INSERT [dbo].[cw_discount_amounts] OFF
;

-- ----------------------------
-- Table structure for [dbo].[cw_discount_apply_types]
-- ----------------------------
IF OBJECT_ID('[dbo].[cw_discount_apply_types]') IS NOT NULL DROP TABLE [dbo].[cw_discount_apply_types]
;
CREATE TABLE [dbo].[cw_discount_apply_types] (
[discount_apply_type_id] int NOT NULL IDENTITY(1,1) ,
[discount_apply_type_description] nvarchar(255) NULL ,
[discount_apply_type_archive] int NULL DEFAULT '0'
)


;

-- ----------------------------
-- Records of cw_discount_apply_types
-- ----------------------------
SET IDENTITY_INSERT [dbo].[cw_discount_apply_types] ON
;
INSERT INTO [dbo].[cw_discount_apply_types] ([discount_apply_type_id], [discount_apply_type_description], [discount_apply_type_archive]) VALUES (N'1', N'Purchase', N'0');
;
SET IDENTITY_INSERT [dbo].[cw_discount_apply_types] OFF
;

-- ----------------------------
-- Table structure for [dbo].[cw_discount_categories]
-- ----------------------------
IF OBJECT_ID('[dbo].[cw_discount_categories]') IS NOT NULL DROP TABLE [dbo].[cw_discount_categories]
;
CREATE TABLE [dbo].[cw_discount_categories] (
[discount_category_id] int NOT NULL IDENTITY(1,1) ,
[discount2category_discount_id] int NULL DEFAULT '0',
[discount2category_category_id] int NULL DEFAULT '0',
[discount_category_type] int NULL DEFAULT '1'
)


;
DBCC CHECKIDENT(N'[dbo].[cw_discount_categories]', RESEED, 127)
;

-- ----------------------------
-- Records of cw_discount_categories
-- ----------------------------
SET IDENTITY_INSERT [dbo].[cw_discount_categories] ON
;
INSERT INTO [dbo].[cw_discount_categories] ([discount_category_id], [discount2category_discount_id], [discount2category_category_id], [discount_category_type]) VALUES (N'111', N'70', N'56', N'1');
;
INSERT INTO [dbo].[cw_discount_categories] ([discount_category_id], [discount2category_discount_id], [discount2category_category_id], [discount_category_type]) VALUES (N'112', N'70', N'80', N'2');
;
INSERT INTO [dbo].[cw_discount_categories] ([discount_category_id], [discount2category_discount_id], [discount2category_category_id], [discount_category_type]) VALUES (N'113', N'70', N'55', N'1');
;
INSERT INTO [dbo].[cw_discount_categories] ([discount_category_id], [discount2category_discount_id], [discount2category_category_id], [discount_category_type]) VALUES (N'114', N'70', N'57', N'1');
;
INSERT INTO [dbo].[cw_discount_categories] ([discount_category_id], [discount2category_discount_id], [discount2category_category_id], [discount_category_type]) VALUES (N'115', N'70', N'70', N'2');
;
INSERT INTO [dbo].[cw_discount_categories] ([discount_category_id], [discount2category_discount_id], [discount2category_category_id], [discount_category_type]) VALUES (N'116', N'70', N'73', N'2');
;
INSERT INTO [dbo].[cw_discount_categories] ([discount_category_id], [discount2category_discount_id], [discount2category_category_id], [discount_category_type]) VALUES (N'120', N'65', N'70', N'2');
;
INSERT INTO [dbo].[cw_discount_categories] ([discount_category_id], [discount2category_discount_id], [discount2category_category_id], [discount_category_type]) VALUES (N'121', N'65', N'73', N'2');
;
INSERT INTO [dbo].[cw_discount_categories] ([discount_category_id], [discount2category_discount_id], [discount2category_category_id], [discount_category_type]) VALUES (N'124', N'72', N'57', N'1');
;
INSERT INTO [dbo].[cw_discount_categories] ([discount_category_id], [discount2category_discount_id], [discount2category_category_id], [discount_category_type]) VALUES (N'125', N'72', N'79', N'2');
;
INSERT INTO [dbo].[cw_discount_categories] ([discount_category_id], [discount2category_discount_id], [discount2category_category_id], [discount_category_type]) VALUES (N'126', N'73', N'55', N'1');
;
INSERT INTO [dbo].[cw_discount_categories] ([discount_category_id], [discount2category_discount_id], [discount2category_category_id], [discount_category_type]) VALUES (N'127', N'78', N'57', N'1');
;
SET IDENTITY_INSERT [dbo].[cw_discount_categories] OFF
;

-- ----------------------------
-- Table structure for [dbo].[cw_discount_products]
-- ----------------------------
IF OBJECT_ID('[dbo].[cw_discount_products]') IS NOT NULL DROP TABLE [dbo].[cw_discount_products]
;
CREATE TABLE [dbo].[cw_discount_products] (
[discount_product_id] int NOT NULL IDENTITY(1,1) ,
[discount2product_discount_id] int NULL DEFAULT '0',
[discount2product_product_id] int NULL DEFAULT '0',
[discount_product_active] int NULL DEFAULT '1'
)


;
DBCC CHECKIDENT(N'[dbo].[cw_discount_products]', RESEED, 75)
;

-- ----------------------------
-- Records of cw_discount_products
-- ----------------------------
SET IDENTITY_INSERT [dbo].[cw_discount_products] ON
;
INSERT INTO [dbo].[cw_discount_products] ([discount_product_id], [discount2product_discount_id], [discount2product_product_id], [discount_product_active]) VALUES (N'34', N'70', N'112', N'1');
;
INSERT INTO [dbo].[cw_discount_products] ([discount_product_id], [discount2product_discount_id], [discount2product_product_id], [discount_product_active]) VALUES (N'38', N'70', N'107', N'1');
;
INSERT INTO [dbo].[cw_discount_products] ([discount_product_id], [discount2product_discount_id], [discount2product_product_id], [discount_product_active]) VALUES (N'39', N'70', N'111', N'1');
;
INSERT INTO [dbo].[cw_discount_products] ([discount_product_id], [discount2product_discount_id], [discount2product_product_id], [discount_product_active]) VALUES (N'40', N'70', N'102', N'1');
;
INSERT INTO [dbo].[cw_discount_products] ([discount_product_id], [discount2product_discount_id], [discount2product_product_id], [discount_product_active]) VALUES (N'41', N'70', N'96', N'1');
;
INSERT INTO [dbo].[cw_discount_products] ([discount_product_id], [discount2product_discount_id], [discount2product_product_id], [discount_product_active]) VALUES (N'42', N'70', N'103', N'1');
;
INSERT INTO [dbo].[cw_discount_products] ([discount_product_id], [discount2product_discount_id], [discount2product_product_id], [discount_product_active]) VALUES (N'43', N'70', N'106', N'1');
;
INSERT INTO [dbo].[cw_discount_products] ([discount_product_id], [discount2product_discount_id], [discount2product_product_id], [discount_product_active]) VALUES (N'44', N'73', N'99', N'1');
;
INSERT INTO [dbo].[cw_discount_products] ([discount_product_id], [discount2product_discount_id], [discount2product_product_id], [discount_product_active]) VALUES (N'45', N'73', N'105', N'1');
;
INSERT INTO [dbo].[cw_discount_products] ([discount_product_id], [discount2product_discount_id], [discount2product_product_id], [discount_product_active]) VALUES (N'46', N'73', N'109', N'1');
;
INSERT INTO [dbo].[cw_discount_products] ([discount_product_id], [discount2product_discount_id], [discount2product_product_id], [discount_product_active]) VALUES (N'47', N'73', N'95', N'1');
;
INSERT INTO [dbo].[cw_discount_products] ([discount_product_id], [discount2product_discount_id], [discount2product_product_id], [discount_product_active]) VALUES (N'48', N'73', N'104', N'1');
;
INSERT INTO [dbo].[cw_discount_products] ([discount_product_id], [discount2product_discount_id], [discount2product_product_id], [discount_product_active]) VALUES (N'49', N'73', N'103', N'1');
;
INSERT INTO [dbo].[cw_discount_products] ([discount_product_id], [discount2product_discount_id], [discount2product_product_id], [discount_product_active]) VALUES (N'50', N'73', N'94', N'1');
;
INSERT INTO [dbo].[cw_discount_products] ([discount_product_id], [discount2product_discount_id], [discount2product_product_id], [discount_product_active]) VALUES (N'51', N'73', N'100', N'1');
;
INSERT INTO [dbo].[cw_discount_products] ([discount_product_id], [discount2product_discount_id], [discount2product_product_id], [discount_product_active]) VALUES (N'53', N'73', N'96', N'1');
;
INSERT INTO [dbo].[cw_discount_products] ([discount_product_id], [discount2product_discount_id], [discount2product_product_id], [discount_product_active]) VALUES (N'54', N'73', N'101', N'1');
;
INSERT INTO [dbo].[cw_discount_products] ([discount_product_id], [discount2product_discount_id], [discount2product_product_id], [discount_product_active]) VALUES (N'56', N'73', N'108', N'1');
;
INSERT INTO [dbo].[cw_discount_products] ([discount_product_id], [discount2product_discount_id], [discount2product_product_id], [discount_product_active]) VALUES (N'57', N'73', N'93', N'1');
;
INSERT INTO [dbo].[cw_discount_products] ([discount_product_id], [discount2product_discount_id], [discount2product_product_id], [discount_product_active]) VALUES (N'58', N'73', N'112', N'1');
;
INSERT INTO [dbo].[cw_discount_products] ([discount_product_id], [discount2product_discount_id], [discount2product_product_id], [discount_product_active]) VALUES (N'59', N'70', N'109', N'1');
;
INSERT INTO [dbo].[cw_discount_products] ([discount_product_id], [discount2product_discount_id], [discount2product_product_id], [discount_product_active]) VALUES (N'60', N'70', N'94', N'1');
;
INSERT INTO [dbo].[cw_discount_products] ([discount_product_id], [discount2product_discount_id], [discount2product_product_id], [discount_product_active]) VALUES (N'61', N'70', N'110', N'1');
;
INSERT INTO [dbo].[cw_discount_products] ([discount_product_id], [discount2product_discount_id], [discount2product_product_id], [discount_product_active]) VALUES (N'62', N'70', N'93', N'1');
;
INSERT INTO [dbo].[cw_discount_products] ([discount_product_id], [discount2product_discount_id], [discount2product_product_id], [discount_product_active]) VALUES (N'63', N'70', N'95', N'1');
;
INSERT INTO [dbo].[cw_discount_products] ([discount_product_id], [discount2product_discount_id], [discount2product_product_id], [discount_product_active]) VALUES (N'65', N'70', N'104', N'1');
;
INSERT INTO [dbo].[cw_discount_products] ([discount_product_id], [discount2product_discount_id], [discount2product_product_id], [discount_product_active]) VALUES (N'70', N'78', N'109', N'1');
;
INSERT INTO [dbo].[cw_discount_products] ([discount_product_id], [discount2product_discount_id], [discount2product_product_id], [discount_product_active]) VALUES (N'71', N'78', N'111', N'1');
;
INSERT INTO [dbo].[cw_discount_products] ([discount_product_id], [discount2product_discount_id], [discount2product_product_id], [discount_product_active]) VALUES (N'72', N'78', N'110', N'1');
;
INSERT INTO [dbo].[cw_discount_products] ([discount_product_id], [discount2product_discount_id], [discount2product_product_id], [discount_product_active]) VALUES (N'73', N'78', N'112', N'1');
;
INSERT INTO [dbo].[cw_discount_products] ([discount_product_id], [discount2product_discount_id], [discount2product_product_id], [discount_product_active]) VALUES (N'74', N'78', N'103', N'1');
;
INSERT INTO [dbo].[cw_discount_products] ([discount_product_id], [discount2product_discount_id], [discount2product_product_id], [discount_product_active]) VALUES (N'75', N'82', N'103', N'1');
;
SET IDENTITY_INSERT [dbo].[cw_discount_products] OFF
;

-- ----------------------------
-- Table structure for [dbo].[cw_discount_skus]
-- ----------------------------
IF OBJECT_ID('[dbo].[cw_discount_skus]') IS NOT NULL DROP TABLE [dbo].[cw_discount_skus]
;
CREATE TABLE [dbo].[cw_discount_skus] (
[discount_sku_id] int NOT NULL IDENTITY(1,1) ,
[discount2sku_discount_id] int NULL DEFAULT '0',
[discount2sku_sku_id] int NULL DEFAULT '0'
)


;
DBCC CHECKIDENT(N'[dbo].[cw_discount_skus]', RESEED, 142)
;

-- ----------------------------
-- Records of cw_discount_skus
-- ----------------------------
SET IDENTITY_INSERT [dbo].[cw_discount_skus] ON
;
INSERT INTO [dbo].[cw_discount_skus] ([discount_sku_id], [discount2sku_discount_id], [discount2sku_sku_id]) VALUES (N'135', N'70', N'232');
;
INSERT INTO [dbo].[cw_discount_skus] ([discount_sku_id], [discount2sku_discount_id], [discount2sku_sku_id]) VALUES (N'137', N'70', N'233');
;
INSERT INTO [dbo].[cw_discount_skus] ([discount_sku_id], [discount2sku_discount_id], [discount2sku_sku_id]) VALUES (N'138', N'70', N'218');
;
INSERT INTO [dbo].[cw_discount_skus] ([discount_sku_id], [discount2sku_discount_id], [discount2sku_sku_id]) VALUES (N'139', N'70', N'176');
;
INSERT INTO [dbo].[cw_discount_skus] ([discount_sku_id], [discount2sku_discount_id], [discount2sku_sku_id]) VALUES (N'141', N'70', N'244');
;
INSERT INTO [dbo].[cw_discount_skus] ([discount_sku_id], [discount2sku_discount_id], [discount2sku_sku_id]) VALUES (N'142', N'70', N'245');
;
SET IDENTITY_INSERT [dbo].[cw_discount_skus] OFF
;

-- ----------------------------
-- Table structure for [dbo].[cw_discount_types]
-- ----------------------------
IF OBJECT_ID('[dbo].[cw_discount_types]') IS NOT NULL DROP TABLE [dbo].[cw_discount_types]
;
CREATE TABLE [dbo].[cw_discount_types] (
[discount_type_id] int NOT NULL IDENTITY(1,1) ,
[discount_type] nvarchar(255) NULL ,
[discount_type_description] nvarchar(255) NULL ,
[discount_type_archive] int NULL DEFAULT '0',
[discount_type_order] int NULL 
)


;
DBCC CHECKIDENT(N'[dbo].[cw_discount_types]', RESEED, 4)
;

-- ----------------------------
-- Records of cw_discount_types
-- ----------------------------
SET IDENTITY_INSERT [dbo].[cw_discount_types] ON
;
INSERT INTO [dbo].[cw_discount_types] ([discount_type_id], [discount_type], [discount_type_description], [discount_type_archive], [discount_type_order]) VALUES (N'1', N'sku_cost', N'Product/SKU Price', N'0', N'10');
;
INSERT INTO [dbo].[cw_discount_types] ([discount_type_id], [discount_type], [discount_type_description], [discount_type_archive], [discount_type_order]) VALUES (N'2', N'sku_ship', N'Product/SKU Shipping', N'0', N'20');
;
INSERT INTO [dbo].[cw_discount_types] ([discount_type_id], [discount_type], [discount_type_description], [discount_type_archive], [discount_type_order]) VALUES (N'3', N'order_total', N'Order Total', N'0', N'30');
;
INSERT INTO [dbo].[cw_discount_types] ([discount_type_id], [discount_type], [discount_type_description], [discount_type_archive], [discount_type_order]) VALUES (N'4', N'ship_total', N'Shipping Total', N'0', N'40');
;
SET IDENTITY_INSERT [dbo].[cw_discount_types] OFF
;

-- ----------------------------
-- Table structure for [dbo].[cw_discount_usage]
-- ----------------------------
IF OBJECT_ID('[dbo].[cw_discount_usage]') IS NOT NULL DROP TABLE [dbo].[cw_discount_usage]
;
CREATE TABLE [dbo].[cw_discount_usage] (
[discount_usage_id] int NOT NULL IDENTITY(1,1) ,
[discount_usage_customer_id] nvarchar(150) NULL ,
[discount_usage_datetime] datetime NULL ,
[discount_usage_order_id] nvarchar(150) NULL ,
[discount_usage_discount_name] nvarchar(255) NULL ,
[discount_usage_discount_description] nvarchar(MAX) NULL ,
[discount_usage_promocode] nvarchar(255) NULL ,
[discount_usage_discount_id] int NULL DEFAULT '0'
)


;
DBCC CHECKIDENT(N'[dbo].[cw_discount_usage]', RESEED, 96)
;

-- ----------------------------
-- Records of cw_discount_usage
-- ----------------------------
SET IDENTITY_INSERT [dbo].[cw_discount_usage] ON
;
INSERT INTO [dbo].[cw_discount_usage] ([discount_usage_id], [discount_usage_customer_id], [discount_usage_datetime], [discount_usage_order_id], [discount_usage_discount_name], [discount_usage_discount_description], [discount_usage_promocode], [discount_usage_discount_id]) VALUES (N'94', N'F45A2F10-25-09', N'2011-12-08 23:39:19.000', N'1112082339-F45A', N'', N'', N'', N'84');
;
INSERT INTO [dbo].[cw_discount_usage] ([discount_usage_id], [discount_usage_customer_id], [discount_usage_datetime], [discount_usage_order_id], [discount_usage_discount_name], [discount_usage_discount_description], [discount_usage_promocode], [discount_usage_discount_id]) VALUES (N'95', N'F45A2F10-25-09', N'2011-12-08 23:39:19.000', N'1112082339-F45A', N'10% Off over $100', N'Save 10 percent when you spend $100 or more', N'', N'71');
;
INSERT INTO [dbo].[cw_discount_usage] ([discount_usage_id], [discount_usage_customer_id], [discount_usage_datetime], [discount_usage_order_id], [discount_usage_discount_name], [discount_usage_discount_description], [discount_usage_promocode], [discount_usage_discount_id]) VALUES (N'96', N'F45A2F10-25-09', N'2011-12-08 23:39:19.000', N'1112082339-F45A', N'Free Shipping', N'Free shipping on all items for the first 100 customers, when you spend $75 or more', N'FREESHIP', N'70');
;
SET IDENTITY_INSERT [dbo].[cw_discount_usage] OFF
;

-- ----------------------------
-- Table structure for [dbo].[cw_discounts]
-- ----------------------------
IF OBJECT_ID('[dbo].[cw_discounts]') IS NOT NULL DROP TABLE [dbo].[cw_discounts]
;
CREATE TABLE [dbo].[cw_discounts] (
[discount_id] int NOT NULL IDENTITY(1,1) ,
[discount_merchant_id] nvarchar(150) NULL ,
[discount_name] nvarchar(255) NULL ,
[discount_amount] float(53) NULL ,
[discount_calc] nvarchar(255) NULL ,
[discount_description] nvarchar(MAX) NULL ,
[discount_show_description] int NULL DEFAULT '1',
[discount_type] nvarchar(165) NULL ,
[discount_promotional_code] nvarchar(255) NULL ,
[discount_start_date] datetime NULL ,
[discount_end_date] datetime NULL ,
[discount_limit] int NULL DEFAULT '0',
[discount_customer_limit] int NULL DEFAULT '0',
[discount_global] int NULL DEFAULT '0',
[discount_exclusive] int NULL DEFAULT '0',
[discount_priority] int NULL DEFAULT '0',
[discount_archive] int NULL DEFAULT '0',
[discount_filter_customer_type] int NULL DEFAULT '0',
[discount_customer_type] nvarchar(255) NULL ,
[discount_filter_customer_id] int NULL DEFAULT '0',
[discount_customer_id] nvarchar(MAX) NULL ,
[discount_filter_cart_total] int NULL DEFAULT '0',
[discount_cart_total_max] float(53) NULL DEFAULT '0.00',
[discount_cart_total_min] float(53) NULL DEFAULT '0.00',
[discount_filter_item_qty] int NULL DEFAULT '0',
[discount_item_qty_min] int NULL DEFAULT '0',
[discount_item_qty_max] int NULL DEFAULT '0',
[discount_filter_cart_qty] int NULL DEFAULT '0',
[discount_cart_qty_min] int NULL DEFAULT '0',
[discount_cart_qty_max] int NULL DEFAULT '0',
[discount_association_method] nvarchar(150) NULL 
)


;
DBCC CHECKIDENT(N'[dbo].[cw_discounts]', RESEED, 83)
;

-- ----------------------------
-- Records of cw_discounts
-- ----------------------------
SET IDENTITY_INSERT [dbo].[cw_discounts] ON
;
INSERT INTO [dbo].[cw_discounts] ([discount_id], [discount_merchant_id], [discount_name], [discount_amount], [discount_calc], [discount_description], [discount_show_description], [discount_type], [discount_promotional_code], [discount_start_date], [discount_end_date], [discount_limit], [discount_customer_limit], [discount_global], [discount_exclusive], [discount_priority], [discount_archive], [discount_filter_customer_type], [discount_customer_type], [discount_filter_customer_id], [discount_customer_id], [discount_filter_cart_total], [discount_cart_total_max], [discount_cart_total_min], [discount_filter_item_qty], [discount_item_qty_min], [discount_item_qty_max], [discount_filter_cart_qty], [discount_cart_qty_min], [discount_cart_qty_max], [discount_association_method]) VALUES (N'64', N'save10-spring sale', N'Save $10 when you spend $100 or more', N'22.34', N'fixed', N'This is a great discount. Don''t miss out!', N'1', N'sku_cost', N'SAVE10', N'2011-06-02 00:00:00.000', N'2011-06-16 00:00:00.000', N'0', N'1', N'1', null, null, N'1', N'0', null, N'0', null, N'0', N'0', N'0', N'0', null, null, N'0', N'0', N'0', N'products');
;
INSERT INTO [dbo].[cw_discounts] ([discount_id], [discount_merchant_id], [discount_name], [discount_amount], [discount_calc], [discount_description], [discount_show_description], [discount_type], [discount_promotional_code], [discount_start_date], [discount_end_date], [discount_limit], [discount_customer_limit], [discount_global], [discount_exclusive], [discount_priority], [discount_archive], [discount_filter_customer_type], [discount_customer_type], [discount_filter_customer_id], [discount_customer_id], [discount_filter_cart_total], [discount_cart_total_max], [discount_cart_total_min], [discount_filter_item_qty], [discount_item_qty_min], [discount_item_qty_max], [discount_filter_cart_qty], [discount_cart_qty_min], [discount_cart_qty_max], [discount_association_method]) VALUES (N'66', N'GlobalDiscount001', N'Global Discount', N'10', N'percent', N'10% OFF everything!', N'1', N'sku_cost', N'1010', N'2006-11-03 00:00:00.000', null, N'0', N'0', N'1', N'0', N'1', N'1', N'0', N'0', N'0', null, N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'products');
;
INSERT INTO [dbo].[cw_discounts] ([discount_id], [discount_merchant_id], [discount_name], [discount_amount], [discount_calc], [discount_description], [discount_show_description], [discount_type], [discount_promotional_code], [discount_start_date], [discount_end_date], [discount_limit], [discount_customer_limit], [discount_global], [discount_exclusive], [discount_priority], [discount_archive], [discount_filter_customer_type], [discount_customer_type], [discount_filter_customer_id], [discount_customer_id], [discount_filter_cart_total], [discount_cart_total_max], [discount_cart_total_min], [discount_filter_item_qty], [discount_item_qty_min], [discount_item_qty_max], [discount_filter_cart_qty], [discount_cart_qty_min], [discount_cart_qty_max], [discount_association_method]) VALUES (N'70', N'fallfreeship', N'Free Shipping', N'100', N'percent', N'Free shipping on all items for the first 100 customers, when you spend $75 or more', N'1', N'ship_total', N'FREESHIP', N'2011-06-19 00:00:00.000', null, N'100', N'1', N'0', N'0', N'0', N'0', N'0', N'0', N'0', null, N'1', N'0', N'75', N'0', N'0', N'0', N'0', N'0', N'0', N'products');
;
INSERT INTO [dbo].[cw_discounts] ([discount_id], [discount_merchant_id], [discount_name], [discount_amount], [discount_calc], [discount_description], [discount_show_description], [discount_type], [discount_promotional_code], [discount_start_date], [discount_end_date], [discount_limit], [discount_customer_limit], [discount_global], [discount_exclusive], [discount_priority], [discount_archive], [discount_filter_customer_type], [discount_customer_type], [discount_filter_customer_id], [discount_customer_id], [discount_filter_cart_total], [discount_cart_total_max], [discount_cart_total_min], [discount_filter_item_qty], [discount_item_qty_min], [discount_item_qty_max], [discount_filter_cart_qty], [discount_cart_qty_min], [discount_cart_qty_max], [discount_association_method]) VALUES (N'71', N'Save10', N'10% Off over $100', N'10', N'percent', N'Save 10 percent when you spend $100 or more', N'1', N'order_total', null, N'2011-06-02 00:00:00.000', null, N'0', N'0', N'1', N'1', N'5', N'0', N'0', N'0', N'0', null, N'1', N'1000', N'100', N'0', N'0', N'0', N'0', N'0', N'0', N'products');
;
INSERT INTO [dbo].[cw_discounts] ([discount_id], [discount_merchant_id], [discount_name], [discount_amount], [discount_calc], [discount_description], [discount_show_description], [discount_type], [discount_promotional_code], [discount_start_date], [discount_end_date], [discount_limit], [discount_customer_limit], [discount_global], [discount_exclusive], [discount_priority], [discount_archive], [discount_filter_customer_type], [discount_customer_type], [discount_filter_customer_id], [discount_customer_id], [discount_filter_cart_total], [discount_cart_total_max], [discount_cart_total_min], [discount_filter_item_qty], [discount_item_qty_min], [discount_item_qty_max], [discount_filter_cart_qty], [discount_cart_qty_min], [discount_cart_qty_max], [discount_association_method]) VALUES (N'73', N'summerFreeShipCategories', N'Free Shipping on all Clothing and Electronics', N'100', N'percent', N'Get Free Shipping on all Clothing and Electronics items for a limited time!', N'1', N'sku_ship', null, N'2011-06-03 00:00:00.000', null, N'0', N'0', N'0', N'1', N'10', N'1', N'0', N'0', N'0', null, N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'categories');
;
INSERT INTO [dbo].[cw_discounts] ([discount_id], [discount_merchant_id], [discount_name], [discount_amount], [discount_calc], [discount_description], [discount_show_description], [discount_type], [discount_promotional_code], [discount_start_date], [discount_end_date], [discount_limit], [discount_customer_limit], [discount_global], [discount_exclusive], [discount_priority], [discount_archive], [discount_filter_customer_type], [discount_customer_type], [discount_filter_customer_id], [discount_customer_id], [discount_filter_cart_total], [discount_cart_total_max], [discount_cart_total_min], [discount_filter_item_qty], [discount_item_qty_min], [discount_item_qty_max], [discount_filter_cart_qty], [discount_cart_qty_min], [discount_cart_qty_max], [discount_association_method]) VALUES (N'77', N'GlobalDiscount002', N'Global Ship Discount', N'100', N'percent', N'Free shipping', N'1', N'sku_ship', null, N'2011-07-18 00:00:00.000', null, N'0', N'0', N'1', N'0', N'0', N'1', N'0', N'0', N'0', null, N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'products');
;
INSERT INTO [dbo].[cw_discounts] ([discount_id], [discount_merchant_id], [discount_name], [discount_amount], [discount_calc], [discount_description], [discount_show_description], [discount_type], [discount_promotional_code], [discount_start_date], [discount_end_date], [discount_limit], [discount_customer_limit], [discount_global], [discount_exclusive], [discount_priority], [discount_archive], [discount_filter_customer_type], [discount_customer_type], [discount_filter_customer_id], [discount_customer_id], [discount_filter_cart_total], [discount_cart_total_max], [discount_cart_total_min], [discount_filter_item_qty], [discount_item_qty_min], [discount_item_qty_max], [discount_filter_cart_qty], [discount_cart_qty_min], [discount_cart_qty_max], [discount_association_method]) VALUES (N'78', N'50off', N'$50 OFF', N'50', N'fixed', N'save $50 on any order', N'1', N'order_total', N'5050', N'2011-03-01 00:00:00.000', N'2011-03-30 00:00:00.000', N'0', N'0', N'1', N'0', N'0', N'1', N'0', N'0', N'0', null, N'0', N'0', N'860', N'0', N'0', N'0', N'0', N'0', N'0', N'products');
;
INSERT INTO [dbo].[cw_discounts] ([discount_id], [discount_merchant_id], [discount_name], [discount_amount], [discount_calc], [discount_description], [discount_show_description], [discount_type], [discount_promotional_code], [discount_start_date], [discount_end_date], [discount_limit], [discount_customer_limit], [discount_global], [discount_exclusive], [discount_priority], [discount_archive], [discount_filter_customer_type], [discount_customer_type], [discount_filter_customer_id], [discount_customer_id], [discount_filter_cart_total], [discount_cart_total_max], [discount_cart_total_min], [discount_filter_item_qty], [discount_item_qty_min], [discount_item_qty_max], [discount_filter_cart_qty], [discount_cart_qty_min], [discount_cart_qty_max], [discount_association_method]) VALUES (N'79', N'GlobalDiscount003', N'Global Discount 25% all orders', N'25', N'percent', N'25% off all orders', N'1', N'sku_cost', null, N'2011-07-19 00:00:00.000', null, N'0', N'0', N'1', N'0', N'0', N'1', N'0', N'0', N'0', null, N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'products');
;
INSERT INTO [dbo].[cw_discounts] ([discount_id], [discount_merchant_id], [discount_name], [discount_amount], [discount_calc], [discount_description], [discount_show_description], [discount_type], [discount_promotional_code], [discount_start_date], [discount_end_date], [discount_limit], [discount_customer_limit], [discount_global], [discount_exclusive], [discount_priority], [discount_archive], [discount_filter_customer_type], [discount_customer_type], [discount_filter_customer_id], [discount_customer_id], [discount_filter_cart_total], [discount_cart_total_max], [discount_cart_total_min], [discount_filter_item_qty], [discount_item_qty_min], [discount_item_qty_max], [discount_filter_cart_qty], [discount_cart_qty_min], [discount_cart_qty_max], [discount_association_method]) VALUES (N'80', N'20OFFShipping', N'$20 off shipping', N'20', N'fixed', N'Save up to $20 on shipping', N'1', N'ship_total', N'ship20', N'2011-07-21 00:00:00.000', null, N'0', N'0', N'1', N'0', N'0', N'1', N'0', N'0', N'0', null, N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'products');
;
INSERT INTO [dbo].[cw_discounts] ([discount_id], [discount_merchant_id], [discount_name], [discount_amount], [discount_calc], [discount_description], [discount_show_description], [discount_type], [discount_promotional_code], [discount_start_date], [discount_end_date], [discount_limit], [discount_customer_limit], [discount_global], [discount_exclusive], [discount_priority], [discount_archive], [discount_filter_customer_type], [discount_customer_type], [discount_filter_customer_id], [discount_customer_id], [discount_filter_cart_total], [discount_cart_total_max], [discount_cart_total_min], [discount_filter_item_qty], [discount_item_qty_min], [discount_item_qty_max], [discount_filter_cart_qty], [discount_cart_qty_min], [discount_cart_qty_max], [discount_association_method]) VALUES (N'82', N'QuantityDiscount', N'Quantity Discount', N'10', N'percent', N'Get discount if you buy 2 or more.', N'1', N'sku_cost', null, N'2011-08-16 00:00:00.000', null, N'0', N'0', N'0', N'0', N'0', N'1', N'0', N'0', N'0', null, N'0', N'0', N'0', N'1', N'2', N'0', N'0', N'0', N'0', N'products');
;
INSERT INTO [dbo].[cw_discounts] ([discount_id], [discount_merchant_id], [discount_name], [discount_amount], [discount_calc], [discount_description], [discount_show_description], [discount_type], [discount_promotional_code], [discount_start_date], [discount_end_date], [discount_limit], [discount_customer_limit], [discount_global], [discount_exclusive], [discount_priority], [discount_archive], [discount_filter_customer_type], [discount_customer_type], [discount_filter_customer_id], [discount_customer_id], [discount_filter_cart_total], [discount_cart_total_max], [discount_cart_total_min], [discount_filter_item_qty], [discount_item_qty_min], [discount_item_qty_max], [discount_filter_cart_qty], [discount_cart_qty_min], [discount_cart_qty_max], [discount_association_method]) VALUES (N'83', N'CustTypeDiscount', N'Wholesale Discount', N'10', N'percent', N'Discount placed on products for Wholesale Customers', N'0', N'sku_cost', null, N'2011-09-12 00:00:00.000', null, N'0', N'0', N'1', N'0', N'0', N'1', N'0', N'2', N'0', null, N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'0', N'products');
;
SET IDENTITY_INSERT [dbo].[cw_discounts] OFF
;

-- ----------------------------
-- Table structure for [dbo].[cw_downloads]
-- ----------------------------
IF OBJECT_ID('[dbo].[cw_downloads]') IS NOT NULL DROP TABLE [dbo].[cw_downloads]
;
CREATE TABLE [dbo].[cw_downloads] (
[dl_id] int NOT NULL IDENTITY(1,1) ,
[dl_sku_id] int NULL ,
[dl_customer_id] varchar(255) NULL ,
[dl_timestamp] datetime NULL ,
[dl_file] varchar(255) NULL ,
[dl_version] varchar(255) NULL ,
[dl_remote_addr] varchar(255) NULL 
)
;

-- ----------------------------
-- Records of cw_downloads
-- ----------------------------
SET IDENTITY_INSERT [dbo].[cw_downloads] ON
;
SET IDENTITY_INSERT [dbo].[cw_downloads] OFF
;

-- ----------------------------
-- Table structure for [dbo].[cw_image_types]
-- ----------------------------
IF OBJECT_ID('[dbo].[cw_image_types]') IS NOT NULL DROP TABLE [dbo].[cw_image_types]
;
CREATE TABLE [dbo].[cw_image_types] (
[imagetype_id] int NOT NULL IDENTITY(1,1) ,
[imagetype_name] nvarchar(255) NULL ,
[imagetype_sortorder] float(53) NULL DEFAULT '1.000',
[imagetype_folder] nvarchar(150) NULL ,
[imagetype_max_width] int NULL DEFAULT '0',
[imagetype_max_height] int NULL DEFAULT '0',
[imagetype_crop_width] int NULL DEFAULT '0',
[imagetype_crop_height] int NULL DEFAULT '0',
[imagetype_upload_group] int NULL DEFAULT '1',
[imagetype_user_edit] int NULL DEFAULT '1'
)


;
DBCC CHECKIDENT(N'[dbo].[cw_image_types]', RESEED, 5)
;

-- ----------------------------
-- Records of cw_image_types
-- ----------------------------
SET IDENTITY_INSERT [dbo].[cw_image_types] ON
;
INSERT INTO [dbo].[cw_image_types] ([imagetype_id], [imagetype_name], [imagetype_sortorder], [imagetype_folder], [imagetype_max_width], [imagetype_max_height], [imagetype_crop_width], [imagetype_crop_height], [imagetype_upload_group], [imagetype_user_edit]) VALUES (N'1', N'Listings Thumbnail', N'1', N'product_thumb', N'160', N'160', N'0', N'0', N'1', N'1');
;
INSERT INTO [dbo].[cw_image_types] ([imagetype_id], [imagetype_name], [imagetype_sortorder], [imagetype_folder], [imagetype_max_width], [imagetype_max_height], [imagetype_crop_width], [imagetype_crop_height], [imagetype_upload_group], [imagetype_user_edit]) VALUES (N'2', N'Details Main Image', N'2', N'product_full', N'420', N'420', N'0', N'0', N'1', N'1');
;
INSERT INTO [dbo].[cw_image_types] ([imagetype_id], [imagetype_name], [imagetype_sortorder], [imagetype_folder], [imagetype_max_width], [imagetype_max_height], [imagetype_crop_width], [imagetype_crop_height], [imagetype_upload_group], [imagetype_user_edit]) VALUES (N'3', N'Details Zoom Image', N'3', N'product_expanded', N'680', N'680', N'0', N'0', N'1', N'1');
;
INSERT INTO [dbo].[cw_image_types] ([imagetype_id], [imagetype_name], [imagetype_sortorder], [imagetype_folder], [imagetype_max_width], [imagetype_max_height], [imagetype_crop_width], [imagetype_crop_height], [imagetype_upload_group], [imagetype_user_edit]) VALUES (N'4', N'Cart Thumbnail', N'4', N'product_small', N'60', N'60', N'0', N'0', N'1', N'1');
;
INSERT INTO [dbo].[cw_image_types] ([imagetype_id], [imagetype_name], [imagetype_sortorder], [imagetype_folder], [imagetype_max_width], [imagetype_max_height], [imagetype_crop_width], [imagetype_crop_height], [imagetype_upload_group], [imagetype_user_edit]) VALUES (N'5', N'SquareThumb', N'5', N'product_thumb_square', N'160', N'160', N'50', N'50', N'1', N'0');
;
INSERT INTO [dbo].[cw_image_types] ([imagetype_id], [imagetype_name], [imagetype_sortorder], [imagetype_folder], [imagetype_max_width], [imagetype_max_height], [imagetype_crop_width], [imagetype_crop_height], [imagetype_upload_group], [imagetype_user_edit]) VALUES (N'6', N'Details Thumbnails', N'6', N'product_thumb_details', N'80', N'80', N'0', N'0', N'1', N'1');
;
SET IDENTITY_INSERT [dbo].[cw_image_types] OFF
;

-- ----------------------------
-- Table structure for [dbo].[cw_option_types]
-- ----------------------------
IF OBJECT_ID('[dbo].[cw_option_types]') IS NOT NULL DROP TABLE [dbo].[cw_option_types]
;
CREATE TABLE [dbo].[cw_option_types] (
[optiontype_id] int NOT NULL IDENTITY(1,1) ,
[optiontype_required] int NULL DEFAULT '1',
[optiontype_name] nvarchar(225) NULL ,
[optiontype_archive] int NULL DEFAULT '0',
[optiontype_deleted] int NULL DEFAULT '0',
[optiontype_sort] float(53) NULL DEFAULT '1.00',
[optiontype_text] nvarchar(MAX) NULL 
)


;
DBCC CHECKIDENT(N'[dbo].[cw_option_types]', RESEED, 44)
;

-- ----------------------------
-- Records of cw_option_types
-- ----------------------------
SET IDENTITY_INSERT [dbo].[cw_option_types] ON
;
INSERT INTO [dbo].[cw_option_types] ([optiontype_id], [optiontype_required], [optiontype_name], [optiontype_archive], [optiontype_deleted], [optiontype_sort], [optiontype_text]) VALUES (N'29', N'1', N'Size', N'0', N'0', N'55', N'Choose the size that suits you best. Note: inseam sizes may vary by brand.');
;
INSERT INTO [dbo].[cw_option_types] ([optiontype_id], [optiontype_required], [optiontype_name], [optiontype_archive], [optiontype_deleted], [optiontype_sort], [optiontype_text]) VALUES (N'30', N'1', N'Color', N'0', N'0', N'99', N'This item comes in a variety of eye-pleasing shades. Choose the one that you like best!');
;
INSERT INTO [dbo].[cw_option_types] ([optiontype_id], [optiontype_required], [optiontype_name], [optiontype_archive], [optiontype_deleted], [optiontype_sort], [optiontype_text]) VALUES (N'33', N'1', N'CPU', N'0', N'0', N'5', N'Central Processing Unit');
;
INSERT INTO [dbo].[cw_option_types] ([optiontype_id], [optiontype_required], [optiontype_name], [optiontype_archive], [optiontype_deleted], [optiontype_sort], [optiontype_text]) VALUES (N'34', N'1', N'RAM', N'0', N'0', N'25', N'Random Access Memory');
;
INSERT INTO [dbo].[cw_option_types] ([optiontype_id], [optiontype_required], [optiontype_name], [optiontype_archive], [optiontype_deleted], [optiontype_sort], [optiontype_text]) VALUES (N'35', N'1', N'Primary Storage', N'0', N'0', N'35', N'Hard Drive Speed and Capacity');
;
INSERT INTO [dbo].[cw_option_types] ([optiontype_id], [optiontype_required], [optiontype_name], [optiontype_archive], [optiontype_deleted], [optiontype_sort], [optiontype_text]) VALUES (N'36', N'1', N'Optical Drives', N'0', N'0', N'40', N'CD/DVD disk drives');
;
INSERT INTO [dbo].[cw_option_types] ([optiontype_id], [optiontype_required], [optiontype_name], [optiontype_archive], [optiontype_deleted], [optiontype_sort], [optiontype_text]) VALUES (N'37', N'1', N'Graphics', N'0', N'0', N'92', N'Video Graphics Card');
;
INSERT INTO [dbo].[cw_option_types] ([optiontype_id], [optiontype_required], [optiontype_name], [optiontype_archive], [optiontype_deleted], [optiontype_sort], [optiontype_text]) VALUES (N'38', N'1', N'Connectivity', N'0', N'0', N'98', N'Get Wired!');
;
INSERT INTO [dbo].[cw_option_types] ([optiontype_id], [optiontype_required], [optiontype_name], [optiontype_archive], [optiontype_deleted], [optiontype_sort], [optiontype_text]) VALUES (N'39', N'1', N'Dimensions', N'0', N'0', N'3', N'Choose the size that will work best');
;
INSERT INTO [dbo].[cw_option_types] ([optiontype_id], [optiontype_required], [optiontype_name], [optiontype_archive], [optiontype_deleted], [optiontype_sort], [optiontype_text]) VALUES (N'40', N'1', N'HP', N'0', N'0', N'1', N'Product rated horsepower');
;
INSERT INTO [dbo].[cw_option_types] ([optiontype_id], [optiontype_required], [optiontype_name], [optiontype_archive], [optiontype_deleted], [optiontype_sort], [optiontype_text]) VALUES (N'43', N'1', N'Gender', N'0', N'0', N'0', N'What Gender is best for this product');
;
SET IDENTITY_INSERT [dbo].[cw_option_types] OFF
;

-- ----------------------------
-- Table structure for [dbo].[cw_options]
-- ----------------------------
IF OBJECT_ID('[dbo].[cw_options]') IS NOT NULL DROP TABLE [dbo].[cw_options]
;
CREATE TABLE [dbo].[cw_options] (
[option_id] int NOT NULL IDENTITY(1,1) ,
[option_type_id] int NULL DEFAULT '0',
[option_name] nvarchar(150) NULL ,
[option_sort] float(53) NULL DEFAULT '1.00',
[option_archive] int NULL DEFAULT '0',
[option_text] nvarchar(MAX) NULL 
)


;
DBCC CHECKIDENT(N'[dbo].[cw_options]', RESEED, 170)
;

-- ----------------------------
-- Records of cw_options
-- ----------------------------
SET IDENTITY_INSERT [dbo].[cw_options] ON
;
INSERT INTO [dbo].[cw_options] ([option_id], [option_type_id], [option_name], [option_sort], [option_archive], [option_text]) VALUES (N'108', N'29', N'Small', N'2.1', N'0', N'Men''s small');
;
INSERT INTO [dbo].[cw_options] ([option_id], [option_type_id], [option_name], [option_sort], [option_archive], [option_text]) VALUES (N'109', N'29', N'Medium', N'2.2', N'0', N'Men''s medium');
;
INSERT INTO [dbo].[cw_options] ([option_id], [option_type_id], [option_name], [option_sort], [option_archive], [option_text]) VALUES (N'110', N'29', N'Large', N'2.3', N'0', N'Men''s large');
;
INSERT INTO [dbo].[cw_options] ([option_id], [option_type_id], [option_name], [option_sort], [option_archive], [option_text]) VALUES (N'111', N'29', N'X-Large', N'2.4', N'0', N'Men''s extra large');
;
INSERT INTO [dbo].[cw_options] ([option_id], [option_type_id], [option_name], [option_sort], [option_archive], [option_text]) VALUES (N'112', N'30', N'Green', N'1.2', N'0', N'Green like the grass in spring.');
;
INSERT INTO [dbo].[cw_options] ([option_id], [option_type_id], [option_name], [option_sort], [option_archive], [option_text]) VALUES (N'113', N'30', N'Blue', N'1.1', N'0', N'Our classic blue.');
;
INSERT INTO [dbo].[cw_options] ([option_id], [option_type_id], [option_name], [option_sort], [option_archive], [option_text]) VALUES (N'114', N'30', N'Yellow', N'1.4', N'0', N'Mellow yellow is a constant best seller.');
;
INSERT INTO [dbo].[cw_options] ([option_id], [option_type_id], [option_name], [option_sort], [option_archive], [option_text]) VALUES (N'115', N'30', N'Red', N'1.3', N'0', N'Red means stop - and fun!');
;
INSERT INTO [dbo].[cw_options] ([option_id], [option_type_id], [option_name], [option_sort], [option_archive], [option_text]) VALUES (N'116', N'30', N'Medium Blue', N'2.2', N'0', N'A little lighter than the classic blue.');
;
INSERT INTO [dbo].[cw_options] ([option_id], [option_type_id], [option_name], [option_sort], [option_archive], [option_text]) VALUES (N'117', N'30', N'Indigo', N'2.1', N'0', N'Get deep with our unique shade of indigo blue.');
;
INSERT INTO [dbo].[cw_options] ([option_id], [option_type_id], [option_name], [option_sort], [option_archive], [option_text]) VALUES (N'118', N'30', N'Stone Washed Light Blue', N'2.3', N'0', N'Classic stone wash.');
;
INSERT INTO [dbo].[cw_options] ([option_id], [option_type_id], [option_name], [option_sort], [option_archive], [option_text]) VALUES (N'119', N'29', N'34x30', N'1.1', N'0', N'34 inch waist with 30 inch inseam.');
;
INSERT INTO [dbo].[cw_options] ([option_id], [option_type_id], [option_name], [option_sort], [option_archive], [option_text]) VALUES (N'120', N'29', N'36x30', N'1.3', N'0', N'36 inch waist with 30 inch inseam.');
;
INSERT INTO [dbo].[cw_options] ([option_id], [option_type_id], [option_name], [option_sort], [option_archive], [option_text]) VALUES (N'121', N'29', N'38x30', N'1.5', N'0', N'38 inch waist with 30 inch inseam.');
;
INSERT INTO [dbo].[cw_options] ([option_id], [option_type_id], [option_name], [option_sort], [option_archive], [option_text]) VALUES (N'127', N'33', N'Core Duo E7500', N'1', N'0', N'IntelÂ®  CoreTM 2 Duo E7500 Processor');
;
INSERT INTO [dbo].[cw_options] ([option_id], [option_type_id], [option_name], [option_sort], [option_archive], [option_text]) VALUES (N'128', N'33', N'Core 2 Duo E7500', N'1', N'0', N'IntelÂ®  CoreTM 2 Duo E7500 with VT (2.93GHz, 3M, 1066MHz FSB)');
;
INSERT INTO [dbo].[cw_options] ([option_id], [option_type_id], [option_name], [option_sort], [option_archive], [option_text]) VALUES (N'129', N'33', N'Core  i5-750', N'1', N'0', N'IntelÂ®  CoreTM  i5-750 w/VT Processor');
;
INSERT INTO [dbo].[cw_options] ([option_id], [option_type_id], [option_name], [option_sort], [option_archive], [option_text]) VALUES (N'130', N'34', N'4GB', N'1', N'0', N'4GB Memory (2DIMMs)');
;
INSERT INTO [dbo].[cw_options] ([option_id], [option_type_id], [option_name], [option_sort], [option_archive], [option_text]) VALUES (N'131', N'34', N'6GB', N'1', N'0', N'6GB Memory (2DIMMs)');
;
INSERT INTO [dbo].[cw_options] ([option_id], [option_type_id], [option_name], [option_sort], [option_archive], [option_text]) VALUES (N'132', N'34', N'8GB', N'1', N'0', N'8GB Memory (2DIMMs)');
;
INSERT INTO [dbo].[cw_options] ([option_id], [option_type_id], [option_name], [option_sort], [option_archive], [option_text]) VALUES (N'133', N'35', N'250 GB', N'1', N'0', N'250 GB 7200RPM SATA Hard Drive');
;
INSERT INTO [dbo].[cw_options] ([option_id], [option_type_id], [option_name], [option_sort], [option_archive], [option_text]) VALUES (N'134', N'35', N'500 GB', N'1', N'0', N'500 GB 7200RPM SATA Hard Drive');
;
INSERT INTO [dbo].[cw_options] ([option_id], [option_type_id], [option_name], [option_sort], [option_archive], [option_text]) VALUES (N'135', N'35', N'1 TB', N'1', N'0', N'1 TB 7200RPM SATA Hard Drive');
;
INSERT INTO [dbo].[cw_options] ([option_id], [option_type_id], [option_name], [option_sort], [option_archive], [option_text]) VALUES (N'136', N'36', N'16X DVD', N'1', N'0', N'<p>16X DVD-ROM Drive</p>');
;
INSERT INTO [dbo].[cw_options] ([option_id], [option_type_id], [option_name], [option_sort], [option_archive], [option_text]) VALUES (N'137', N'36', N'16X CD/DVD burner', N'15', N'0', N'<p>16X CD/DVD burner (DVD+/-RW) with double layer write capability</p>');
;
INSERT INTO [dbo].[cw_options] ([option_id], [option_type_id], [option_name], [option_sort], [option_archive], [option_text]) VALUES (N'138', N'36', N'16X CD/DVD/BlueRay', N'99', N'0', N'<p>16X CD/DVD/BlueRay burner</p>');
;
INSERT INTO [dbo].[cw_options] ([option_id], [option_type_id], [option_name], [option_sort], [option_archive], [option_text]) VALUES (N'139', N'37', N'IntelÂ®  GMA X4500', N'1', N'0', N'Integrated IntelÂ®  GMA X4500');
;
INSERT INTO [dbo].[cw_options] ([option_id], [option_type_id], [option_name], [option_sort], [option_archive], [option_text]) VALUES (N'140', N'37', N'512MB NVIDIAÂ®', N'1', N'0', N'512MB NVIDIAÂ®  GeForceÂ®  G310* (DVI, HDMI, VGA)');
;
INSERT INTO [dbo].[cw_options] ([option_id], [option_type_id], [option_name], [option_sort], [option_archive], [option_text]) VALUES (N'141', N'38', N'Ethernet', N'1', N'0', N'10/100/1000 Ethernet LAN on system board');
;
INSERT INTO [dbo].[cw_options] ([option_id], [option_type_id], [option_name], [option_sort], [option_archive], [option_text]) VALUES (N'142', N'38', N'Wireless', N'1', N'0', N'Wireless WLAN 11n PCIe Card');
;
INSERT INTO [dbo].[cw_options] ([option_id], [option_type_id], [option_name], [option_sort], [option_archive], [option_text]) VALUES (N'143', N'30', N'Hot Pink', N'1', N'0', N'');
;
INSERT INTO [dbo].[cw_options] ([option_id], [option_type_id], [option_name], [option_sort], [option_archive], [option_text]) VALUES (N'144', N'30', N'Mint Green', N'1', N'0', N'');
;
INSERT INTO [dbo].[cw_options] ([option_id], [option_type_id], [option_name], [option_sort], [option_archive], [option_text]) VALUES (N'145', N'30', N'Orange', N'1', N'0', N'');
;
INSERT INTO [dbo].[cw_options] ([option_id], [option_type_id], [option_name], [option_sort], [option_archive], [option_text]) VALUES (N'146', N'39', N'24X36', N'1', N'0', N'');
;
INSERT INTO [dbo].[cw_options] ([option_id], [option_type_id], [option_name], [option_sort], [option_archive], [option_text]) VALUES (N'147', N'39', N'36X48', N'1', N'0', N'');
;
INSERT INTO [dbo].[cw_options] ([option_id], [option_type_id], [option_name], [option_sort], [option_archive], [option_text]) VALUES (N'148', N'29', N'Twin', N'1', N'0', N'For Twin Sized Beds');
;
INSERT INTO [dbo].[cw_options] ([option_id], [option_type_id], [option_name], [option_sort], [option_archive], [option_text]) VALUES (N'149', N'29', N'Full', N'2', N'0', N'For Full Sized Beds');
;
INSERT INTO [dbo].[cw_options] ([option_id], [option_type_id], [option_name], [option_sort], [option_archive], [option_text]) VALUES (N'150', N'29', N'Queen', N'3', N'0', N'For Queen Sized Beds');
;
INSERT INTO [dbo].[cw_options] ([option_id], [option_type_id], [option_name], [option_sort], [option_archive], [option_text]) VALUES (N'151', N'29', N'King', N'4', N'0', N'For King Sized Beds');
;
INSERT INTO [dbo].[cw_options] ([option_id], [option_type_id], [option_name], [option_sort], [option_archive], [option_text]) VALUES (N'152', N'30', N'Purple', N'1', N'0', N'');
;
INSERT INTO [dbo].[cw_options] ([option_id], [option_type_id], [option_name], [option_sort], [option_archive], [option_text]) VALUES (N'153', N'29', N'34X32', N'1.2', N'0', N'');
;
INSERT INTO [dbo].[cw_options] ([option_id], [option_type_id], [option_name], [option_sort], [option_archive], [option_text]) VALUES (N'154', N'29', N'36X32', N'1.4', N'0', N'');
;
INSERT INTO [dbo].[cw_options] ([option_id], [option_type_id], [option_name], [option_sort], [option_archive], [option_text]) VALUES (N'155', N'29', N'38X32', N'1.6', N'0', N'');
;
INSERT INTO [dbo].[cw_options] ([option_id], [option_type_id], [option_name], [option_sort], [option_archive], [option_text]) VALUES (N'156', N'40', N'.24 HP', N'1', N'0', N'<p>One Quarter Horse Power</p>');
;
INSERT INTO [dbo].[cw_options] ([option_id], [option_type_id], [option_name], [option_sort], [option_archive], [option_text]) VALUES (N'157', N'40', N'.5 HP', N'2', N'0', N'<p>One Half Horsepower</p>');
;
INSERT INTO [dbo].[cw_options] ([option_id], [option_type_id], [option_name], [option_sort], [option_archive], [option_text]) VALUES (N'158', N'40', N'3.5 HP', N'3', N'0', N'<p>3 and a half horsepower</p>');
;
INSERT INTO [dbo].[cw_options] ([option_id], [option_type_id], [option_name], [option_sort], [option_archive], [option_text]) VALUES (N'159', N'40', N'6 HP', N'4', N'0', N'<p>6 horsepower</p>');
;
INSERT INTO [dbo].[cw_options] ([option_id], [option_type_id], [option_name], [option_sort], [option_archive], [option_text]) VALUES (N'160', N'40', N'12 HP', N'5', N'0', N'<p>12 horsepower</p>');
;
INSERT INTO [dbo].[cw_options] ([option_id], [option_type_id], [option_name], [option_sort], [option_archive], [option_text]) VALUES (N'166', N'39', N'33X38', N'1', N'0', N'');
;
INSERT INTO [dbo].[cw_options] ([option_id], [option_type_id], [option_name], [option_sort], [option_archive], [option_text]) VALUES (N'168', N'43', N'Men''s', N'1', N'0', N'');
;
INSERT INTO [dbo].[cw_options] ([option_id], [option_type_id], [option_name], [option_sort], [option_archive], [option_text]) VALUES (N'169', N'43', N'Women''s', N'1', N'0', N'');
;
SET IDENTITY_INSERT [dbo].[cw_options] OFF
;

-- ----------------------------
-- Table structure for [dbo].[cw_order_payments]
-- ----------------------------
IF OBJECT_ID('[dbo].[cw_order_payments]') IS NOT NULL DROP TABLE [dbo].[cw_order_payments]
;
CREATE TABLE [dbo].[cw_order_payments] (
[payment_id] int NOT NULL IDENTITY(1,1) ,
[order_id] nvarchar(150) NULL ,
[payment_method] nvarchar(255) NULL ,
[payment_type] nvarchar(255) NULL ,
[payment_amount] float(53) NULL ,
[payment_status] nvarchar(255) NULL ,
[payment_trans_id] nvarchar(255) NULL ,
[payment_trans_response] nvarchar(MAX) NULL ,
[payment_timestamp] datetime NULL 
)


;
DBCC CHECKIDENT(N'[dbo].[cw_order_payments]', RESEED, 3)
;

-- ----------------------------
-- Records of cw_order_payments
-- ----------------------------
SET IDENTITY_INSERT [dbo].[cw_order_payments] ON
;
INSERT INTO [dbo].[cw_order_payments] ([payment_id], [order_id], [payment_method], [payment_type], [payment_amount], [payment_status], [payment_trans_id], [payment_trans_response], [payment_timestamp]) VALUES (N'1', N'1111161120-F45A', N'In-Store Account', N'account', N'2027.5', N'approved', N'ACCT:F45A2F10-25-09', N'Order charged to account', N'2011-11-16 11:20:40.000');
;
INSERT INTO [dbo].[cw_order_payments] ([payment_id], [order_id], [payment_method], [payment_type], [payment_amount], [payment_status], [payment_trans_id], [payment_trans_response], [payment_timestamp]) VALUES (N'2', N'1111161122-FC4E', N'In-Store Account', N'account', N'1041.21', N'approved', N'ACCT:FC4E0311-07-11', N'Order charged to account', N'2011-11-16 11:22:23.000');
;
INSERT INTO [dbo].[cw_order_payments] ([payment_id], [order_id], [payment_method], [payment_type], [payment_amount], [payment_status], [payment_trans_id], [payment_trans_response], [payment_timestamp]) VALUES (N'3', N'1112082339-F45A', N'In-Store Account', N'account', N'433.5', N'approved', N'ACCT:F45A2F10-25-09', N'Order charged to account', N'2011-12-08 23:39:19.000');
;
SET IDENTITY_INSERT [dbo].[cw_order_payments] OFF
;

-- ----------------------------
-- Table structure for [dbo].[cw_order_sku_data]
-- ----------------------------
IF OBJECT_ID('[dbo].[cw_order_sku_data]') IS NOT NULL DROP TABLE [dbo].[cw_order_sku_data]
;
CREATE TABLE [dbo].[cw_order_sku_data] (
[data_id] int NOT NULL IDENTITY(1,1) ,
[data_sku_id] int NULL ,
[data_cart_id] nvarchar(255) NULL ,
[data_content] nvarchar(MAX) NULL ,
[data_date_added] datetime NULL 
)
;

-- ----------------------------
-- Records of cw_order_sku_data
-- ----------------------------
SET IDENTITY_INSERT [dbo].[cw_order_sku_data] ON
;
SET IDENTITY_INSERT [dbo].[cw_order_sku_data] OFF
;

-- ----------------------------
-- Table structure for [dbo].[cw_order_skus]
-- ----------------------------
IF OBJECT_ID('[dbo].[cw_order_skus]') IS NOT NULL DROP TABLE [dbo].[cw_order_skus]
;
CREATE TABLE [dbo].[cw_order_skus] (
[ordersku_id] int NOT NULL IDENTITY(1,1) ,
[ordersku_order_id] nvarchar(255) NULL ,
[ordersku_sku] int NULL DEFAULT '0',
[ordersku_quantity] int NULL ,
[ordersku_unit_price] float(53) NULL ,
[ordersku_sku_total] float(53) NULL DEFAULT '0',
[ordersku_tax_rate] float(53) NULL DEFAULT '0',
[ordersku_taxrate_id] int NULL ,
[ordersku_unique_id] nvarchar(255) NULL ,
[ordersku_customval] nvarchar(255) NULL ,
[ordersku_discount_amount] float(53) NULL 
)


;
DBCC CHECKIDENT(N'[dbo].[cw_order_skus]', RESEED, 4)
;

-- ----------------------------
-- Records of cw_order_skus
-- ----------------------------
SET IDENTITY_INSERT [dbo].[cw_order_skus] ON
;
INSERT INTO [dbo].[cw_order_skus] ([ordersku_id], [ordersku_order_id], [ordersku_sku], [ordersku_quantity], [ordersku_unit_price], [ordersku_sku_total], [ordersku_tax_rate], [ordersku_taxrate_id], [ordersku_unique_id], [ordersku_customval], [ordersku_discount_amount]) VALUES (N'1', N'1111161120-F45A', N'188', N'1', N'1999', N'1999', N'0', null, N'188', N'', N'0');
;
INSERT INTO [dbo].[cw_order_skus] ([ordersku_id], [ordersku_order_id], [ordersku_sku], [ordersku_quantity], [ordersku_unit_price], [ordersku_sku_total], [ordersku_tax_rate], [ordersku_taxrate_id], [ordersku_unique_id], [ordersku_customval], [ordersku_discount_amount]) VALUES (N'2', N'1111161122-FC4E', N'240', N'1', N'899', N'899', N'0', null, N'240', N'', N'0');
;
INSERT INTO [dbo].[cw_order_skus] ([ordersku_id], [ordersku_order_id], [ordersku_sku], [ordersku_quantity], [ordersku_unit_price], [ordersku_sku_total], [ordersku_tax_rate], [ordersku_taxrate_id], [ordersku_unique_id], [ordersku_customval], [ordersku_discount_amount]) VALUES (N'3', N'1111161122-FC4E', N'232', N'1', N'125', N'125', N'0', null, N'232', N'', N'0');
;
INSERT INTO [dbo].[cw_order_skus] ([ordersku_id], [ordersku_order_id], [ordersku_sku], [ordersku_quantity], [ordersku_unit_price], [ordersku_sku_total], [ordersku_tax_rate], [ordersku_taxrate_id], [ordersku_unique_id], [ordersku_customval], [ordersku_discount_amount]) VALUES (N'4', N'1112082339-F45A', N'230', N'1', N'500', N'450', N'0', null, N'230', N'', N'50');
;
SET IDENTITY_INSERT [dbo].[cw_order_skus] OFF
;

-- ----------------------------
-- Table structure for [dbo].[cw_order_status]
-- ----------------------------
IF OBJECT_ID('[dbo].[cw_order_status]') IS NOT NULL DROP TABLE [dbo].[cw_order_status]
;
CREATE TABLE [dbo].[cw_order_status] (
[shipstatus_id] int NOT NULL IDENTITY(1,1) ,
[shipstatus_name] nvarchar(210) NULL ,
[shipstatus_sort] float(53) NULL DEFAULT '1.00'
)


;
DBCC CHECKIDENT(N'[dbo].[cw_order_status]', RESEED, 6)
;

-- ----------------------------
-- Records of cw_order_status
-- ----------------------------
SET IDENTITY_INSERT [dbo].[cw_order_status] ON
;
INSERT INTO [dbo].[cw_order_status] ([shipstatus_id], [shipstatus_name], [shipstatus_sort]) VALUES (N'1', N'Pending', N'1');
;
INSERT INTO [dbo].[cw_order_status] ([shipstatus_id], [shipstatus_name], [shipstatus_sort]) VALUES (N'2', N'Balance Due', N'2');
;
INSERT INTO [dbo].[cw_order_status] ([shipstatus_id], [shipstatus_name], [shipstatus_sort]) VALUES (N'3', N'Paid in Full', N'3');
;
INSERT INTO [dbo].[cw_order_status] ([shipstatus_id], [shipstatus_name], [shipstatus_sort]) VALUES (N'4', N'Shipped', N'4');
;
INSERT INTO [dbo].[cw_order_status] ([shipstatus_id], [shipstatus_name], [shipstatus_sort]) VALUES (N'5', N'Cancelled', N'5');
;
INSERT INTO [dbo].[cw_order_status] ([shipstatus_id], [shipstatus_name], [shipstatus_sort]) VALUES (N'6', N'Returned', N'6');
;
SET IDENTITY_INSERT [dbo].[cw_order_status] OFF
;

-- ----------------------------
-- Table structure for [dbo].[cw_orders]
-- ----------------------------
IF OBJECT_ID('[dbo].[cw_orders]') IS NOT NULL DROP TABLE [dbo].[cw_orders]
;
CREATE TABLE [dbo].[cw_orders] (
[order_id] nvarchar(225) NOT NULL ,
[order_date] datetime NULL ,
[order_status] int NULL DEFAULT '0',
[order_customer_id] nvarchar(150) NULL ,
[order_checkout_type] nvarchar(60) NULL ,
[order_tax] float(53) NULL DEFAULT '0',
[order_shipping] float(53) NULL DEFAULT '0',
[order_shipping_tax] float(53) NULL DEFAULT '0',
[order_total] float(53) NULL DEFAULT '0',
[order_ship_method_id] int NULL DEFAULT '0',
[order_ship_date] datetime NULL ,
[order_ship_tracking_id] nvarchar(255) NULL ,
[order_ship_name] nvarchar(MAX) NULL ,
[order_company] nvarchar(255) NULL ,
[order_address1] nvarchar(255) NULL ,
[order_address2] nvarchar(255) NULL ,
[order_city] nvarchar(255) NULL ,
[order_state] nvarchar(150) NULL ,
[order_zip] nvarchar(150) NULL ,
[order_country] nvarchar(225) NULL ,
[order_notes] nvarchar(MAX) NULL ,
[order_actual_ship_charge] float(53) NULL DEFAULT '0',
[order_comments] nvarchar(255) NULL ,
[order_discount_total] float(53) NULL DEFAULT '0',
[order_ship_discount_total] float(53) NULL ,
[order_return_date] datetime NULL ,
[order_return_amount] float(53) NULL 
)


;

-- ----------------------------
-- Records of cw_orders
-- ----------------------------
INSERT INTO [dbo].[cw_orders] ([order_id], [order_date], [order_status], [order_customer_id], [order_checkout_type], [order_tax], [order_shipping], [order_shipping_tax], [order_total], [order_ship_method_id], [order_ship_date], [order_ship_tracking_id], [order_ship_name], [order_company], [order_address1], [order_address2], [order_city], [order_state], [order_zip], [order_country], [order_notes], [order_actual_ship_charge], [order_comments], [order_discount_total], [order_ship_discount_total], [order_return_date], [order_return_amount]) VALUES (N'1111161120-F45A', N'2011-11-16 11:20:40.000', N'3', N'F45A2F10-25-09', N'account', N'0', N'28.5', N'0', N'2027.5', N'101', null, null, N'Bob Buyer', N'Some Company', N'4444 My St.', N'', N'Sunny City', N'Arizona', N'30322', N'United States', null, N'0', N'', N'0', N'0', null, null);
;
INSERT INTO [dbo].[cw_orders] ([order_id], [order_date], [order_status], [order_customer_id], [order_checkout_type], [order_tax], [order_shipping], [order_shipping_tax], [order_total], [order_ship_method_id], [order_ship_date], [order_ship_tracking_id], [order_ship_name], [order_company], [order_address1], [order_address2], [order_city], [order_state], [order_zip], [order_country], [order_notes], [order_actual_ship_charge], [order_comments], [order_discount_total], [order_ship_discount_total], [order_return_date], [order_return_amount]) VALUES (N'1111161122-FC4E', N'2011-11-16 11:22:23.000', N'3', N'FC4E0311-07-11', N'account', N'0', N'17.21', N'0', N'1041.21', N'79', null, null, N'Wanda Buymore', N'', N'1234 st', N'', N'some town', N'Alabama', N'99999', N'United States', null, N'0', N'', N'0', N'0', null, null);
;
INSERT INTO [dbo].[cw_orders] ([order_id], [order_date], [order_status], [order_customer_id], [order_checkout_type], [order_tax], [order_shipping], [order_shipping_tax], [order_total], [order_ship_method_id], [order_ship_date], [order_ship_tracking_id], [order_ship_name], [order_company], [order_address1], [order_address2], [order_city], [order_state], [order_zip], [order_country], [order_notes], [order_actual_ship_charge], [order_comments], [order_discount_total], [order_ship_discount_total], [order_return_date], [order_return_amount]) VALUES (N'1112082339-F45A', N'2011-12-08 23:39:19.000', N'3', N'F45A2F10-25-09', N'account', N'0', N'28.5', N'0', N'433.5', N'101', null, null, N'Bob Buyer', N'Some Company', N'4444 My St.', N'', N'Sunny City', N'Arizona', N'30322', N'United States', null, N'0', N'', N'95', N'0', null, null);
;

-- ----------------------------
-- Table structure for [dbo].[cw_product_categories_primary]
-- ----------------------------
IF OBJECT_ID('[dbo].[cw_product_categories_primary]') IS NOT NULL DROP TABLE [dbo].[cw_product_categories_primary]
;
CREATE TABLE [dbo].[cw_product_categories_primary] (
[product2category_id] int NOT NULL IDENTITY(1,1) ,
[product2category_product_id] int NULL DEFAULT '0',
[product2category_category_id] int NULL DEFAULT '0' 
)


;
DBCC CHECKIDENT(N'[dbo].[cw_product_categories_primary]', RESEED, 535)
;

-- ----------------------------
-- Records of cw_product_categories_primary
-- ----------------------------
SET IDENTITY_INSERT [dbo].[cw_product_categories_primary] ON
;
INSERT INTO [dbo].[cw_product_categories_primary] ([product2category_id], [product2category_product_id], [product2category_category_id]) VALUES (N'380', N'96', N'55');
;
INSERT INTO [dbo].[cw_product_categories_primary] ([product2category_id], [product2category_product_id], [product2category_category_id]) VALUES (N'384', N'95', N'55');
;
INSERT INTO [dbo].[cw_product_categories_primary] ([product2category_id], [product2category_product_id], [product2category_category_id]) VALUES (N'419', N'107', N'54');
;
INSERT INTO [dbo].[cw_product_categories_primary] ([product2category_id], [product2category_product_id], [product2category_category_id]) VALUES (N'438', N'111', N'57');
;
INSERT INTO [dbo].[cw_product_categories_primary] ([product2category_id], [product2category_product_id], [product2category_category_id]) VALUES (N'439', N'112', N'57');
;
INSERT INTO [dbo].[cw_product_categories_primary] ([product2category_id], [product2category_product_id], [product2category_category_id]) VALUES (N'443', N'101', N'56');
;
INSERT INTO [dbo].[cw_product_categories_primary] ([product2category_id], [product2category_product_id], [product2category_category_id]) VALUES (N'462', N'102', N'56');
;
INSERT INTO [dbo].[cw_product_categories_primary] ([product2category_id], [product2category_product_id], [product2category_category_id]) VALUES (N'485', N'103', N'56');
;
INSERT INTO [dbo].[cw_product_categories_primary] ([product2category_id], [product2category_product_id], [product2category_category_id]) VALUES (N'488', N'108', N'55');
;
INSERT INTO [dbo].[cw_product_categories_primary] ([product2category_id], [product2category_product_id], [product2category_category_id]) VALUES (N'498', N'104', N'56');
;
INSERT INTO [dbo].[cw_product_categories_primary] ([product2category_id], [product2category_product_id], [product2category_category_id]) VALUES (N'511', N'110', N'57');
;
INSERT INTO [dbo].[cw_product_categories_primary] ([product2category_id], [product2category_product_id], [product2category_category_id]) VALUES (N'521', N'105', N'55');
;
INSERT INTO [dbo].[cw_product_categories_primary] ([product2category_id], [product2category_product_id], [product2category_category_id]) VALUES (N'524', N'100', N'55');
;
INSERT INTO [dbo].[cw_product_categories_primary] ([product2category_id], [product2category_product_id], [product2category_category_id]) VALUES (N'525', N'94', N'54');
;
INSERT INTO [dbo].[cw_product_categories_primary] ([product2category_id], [product2category_product_id], [product2category_category_id]) VALUES (N'528', N'99', N'55');
;
INSERT INTO [dbo].[cw_product_categories_primary] ([product2category_id], [product2category_product_id], [product2category_category_id]) VALUES (N'530', N'109', N'55');
;
INSERT INTO [dbo].[cw_product_categories_primary] ([product2category_id], [product2category_product_id], [product2category_category_id]) VALUES (N'531', N'106', N'54');
;
INSERT INTO [dbo].[cw_product_categories_primary] ([product2category_id], [product2category_product_id], [product2category_category_id]) VALUES (N'532', N'93', N'54');
;
SET IDENTITY_INSERT [dbo].[cw_product_categories_primary] OFF
;

-- ----------------------------
-- Table structure for [dbo].[cw_product_categories_secondary]
-- ----------------------------
IF OBJECT_ID('[dbo].[cw_product_categories_secondary]') IS NOT NULL DROP TABLE [dbo].[cw_product_categories_secondary]
;
CREATE TABLE [dbo].[cw_product_categories_secondary] (
[product2secondary_id] int NOT NULL IDENTITY(1,1) ,
[product2secondary_product_id] int NULL DEFAULT '0',
[product2secondary_secondary_id] int NULL DEFAULT '0' 
)


;
DBCC CHECKIDENT(N'[dbo].[cw_product_categories_secondary]', RESEED, 991)
;

-- ----------------------------
-- Records of cw_product_categories_secondary
-- ----------------------------
SET IDENTITY_INSERT [dbo].[cw_product_categories_secondary] ON
;
INSERT INTO [dbo].[cw_product_categories_secondary] ([product2secondary_id], [product2secondary_product_id], [product2secondary_secondary_id]) VALUES (N'940', N'103', N'78');
;
INSERT INTO [dbo].[cw_product_categories_secondary] ([product2secondary_id], [product2secondary_product_id], [product2secondary_secondary_id]) VALUES (N'984', N'94', N'71');
;
INSERT INTO [dbo].[cw_product_categories_secondary] ([product2secondary_id], [product2secondary_product_id], [product2secondary_secondary_id]) VALUES (N'828', N'95', N'72');
;
INSERT INTO [dbo].[cw_product_categories_secondary] ([product2secondary_id], [product2secondary_product_id], [product2secondary_secondary_id]) VALUES (N'823', N'96', N'73');
;
INSERT INTO [dbo].[cw_product_categories_secondary] ([product2secondary_id], [product2secondary_product_id], [product2secondary_secondary_id]) VALUES (N'913', N'102', N'77');
;
INSERT INTO [dbo].[cw_product_categories_secondary] ([product2secondary_id], [product2secondary_product_id], [product2secondary_secondary_id]) VALUES (N'991', N'93', N'70');
;
INSERT INTO [dbo].[cw_product_categories_secondary] ([product2secondary_id], [product2secondary_product_id], [product2secondary_secondary_id]) VALUES (N'956', N'104', N'77');
;
INSERT INTO [dbo].[cw_product_categories_secondary] ([product2secondary_id], [product2secondary_product_id], [product2secondary_secondary_id]) VALUES (N'987', N'99', N'74');
;
INSERT INTO [dbo].[cw_product_categories_secondary] ([product2secondary_id], [product2secondary_product_id], [product2secondary_secondary_id]) VALUES (N'892', N'101', N'77');
;
INSERT INTO [dbo].[cw_product_categories_secondary] ([product2secondary_id], [product2secondary_product_id], [product2secondary_secondary_id]) VALUES (N'983', N'100', N'75');
;
INSERT INTO [dbo].[cw_product_categories_secondary] ([product2secondary_id], [product2secondary_product_id], [product2secondary_secondary_id]) VALUES (N'980', N'105', N'76');
;
INSERT INTO [dbo].[cw_product_categories_secondary] ([product2secondary_id], [product2secondary_product_id], [product2secondary_secondary_id]) VALUES (N'990', N'106', N'70');
;
INSERT INTO [dbo].[cw_product_categories_secondary] ([product2secondary_id], [product2secondary_product_id], [product2secondary_secondary_id]) VALUES (N'868', N'107', N'71');
;
INSERT INTO [dbo].[cw_product_categories_secondary] ([product2secondary_id], [product2secondary_product_id], [product2secondary_secondary_id]) VALUES (N'943', N'108', N'73');
;
INSERT INTO [dbo].[cw_product_categories_secondary] ([product2secondary_id], [product2secondary_product_id], [product2secondary_secondary_id]) VALUES (N'970', N'110', N'79');
;
INSERT INTO [dbo].[cw_product_categories_secondary] ([product2secondary_id], [product2secondary_product_id], [product2secondary_secondary_id]) VALUES (N'887', N'111', N'79');
;
INSERT INTO [dbo].[cw_product_categories_secondary] ([product2secondary_id], [product2secondary_product_id], [product2secondary_secondary_id]) VALUES (N'888', N'112', N'80');
;
INSERT INTO [dbo].[cw_product_categories_secondary] ([product2secondary_id], [product2secondary_product_id], [product2secondary_secondary_id]) VALUES (N'989', N'109', N'72');
;
SET IDENTITY_INSERT [dbo].[cw_product_categories_secondary] OFF
;

-- ----------------------------
-- Table structure for [dbo].[cw_product_images]
-- ----------------------------
IF OBJECT_ID('[dbo].[cw_product_images]') IS NOT NULL DROP TABLE [dbo].[cw_product_images]
;
CREATE TABLE [dbo].[cw_product_images] (
[product_image_id] int NOT NULL IDENTITY(1,1) ,
[product_image_product_id] int NULL DEFAULT '0',
[product_image_imagetype_id] int NULL DEFAULT '0',
[product_image_filename] nvarchar(255) NULL ,
[product_image_sortorder] float(53) NULL DEFAULT '1.000',
[product_image_caption] nvarchar(255) NULL 
)


;
DBCC CHECKIDENT(N'[dbo].[cw_product_images]', RESEED, 503)
;

-- ----------------------------
-- Records of cw_product_images
-- ----------------------------
SET IDENTITY_INSERT [dbo].[cw_product_images] ON
;
INSERT INTO [dbo].[cw_product_images] ([product_image_id], [product_image_product_id], [product_image_imagetype_id], [product_image_filename], [product_image_sortorder], [product_image_caption]) VALUES (N'414', N'93', N'1', N'Sample-Image-1.jpg', N'1', null);
;
INSERT INTO [dbo].[cw_product_images] ([product_image_id], [product_image_product_id], [product_image_imagetype_id], [product_image_filename], [product_image_sortorder], [product_image_caption]) VALUES (N'415', N'93', N'2', N'Sample-Image-1.jpg', N'2', null);
;
INSERT INTO [dbo].[cw_product_images] ([product_image_id], [product_image_product_id], [product_image_imagetype_id], [product_image_filename], [product_image_sortorder], [product_image_caption]) VALUES (N'416', N'93', N'3', N'Sample-Image-1.jpg', N'3', null);
;
INSERT INTO [dbo].[cw_product_images] ([product_image_id], [product_image_product_id], [product_image_imagetype_id], [product_image_filename], [product_image_sortorder], [product_image_caption]) VALUES (N'417', N'93', N'4', N'Sample-Image-1.jpg', N'4', null);
;
INSERT INTO [dbo].[cw_product_images] ([product_image_id], [product_image_product_id], [product_image_imagetype_id], [product_image_filename], [product_image_sortorder], [product_image_caption]) VALUES (N'418', N'94', N'1', N'Sample-Image-2.jpg', N'1', null);
;
INSERT INTO [dbo].[cw_product_images] ([product_image_id], [product_image_product_id], [product_image_imagetype_id], [product_image_filename], [product_image_sortorder], [product_image_caption]) VALUES (N'419', N'94', N'2', N'Sample-Image-2.jpg', N'2', null);
;
INSERT INTO [dbo].[cw_product_images] ([product_image_id], [product_image_product_id], [product_image_imagetype_id], [product_image_filename], [product_image_sortorder], [product_image_caption]) VALUES (N'420', N'94', N'3', N'Sample-Image-2.jpg', N'3', null);
;
INSERT INTO [dbo].[cw_product_images] ([product_image_id], [product_image_product_id], [product_image_imagetype_id], [product_image_filename], [product_image_sortorder], [product_image_caption]) VALUES (N'421', N'94', N'4', N'Sample-Image-2.jpg', N'4', null);
;
INSERT INTO [dbo].[cw_product_images] ([product_image_id], [product_image_product_id], [product_image_imagetype_id], [product_image_filename], [product_image_sortorder], [product_image_caption]) VALUES (N'422', N'95', N'1', N'Sample-Image-3.jpg', N'1', null);
;
INSERT INTO [dbo].[cw_product_images] ([product_image_id], [product_image_product_id], [product_image_imagetype_id], [product_image_filename], [product_image_sortorder], [product_image_caption]) VALUES (N'423', N'95', N'2', N'Sample-Image-3.jpg', N'2', null);
;
INSERT INTO [dbo].[cw_product_images] ([product_image_id], [product_image_product_id], [product_image_imagetype_id], [product_image_filename], [product_image_sortorder], [product_image_caption]) VALUES (N'424', N'95', N'3', N'Sample-Image-3.jpg', N'3', null);
;
INSERT INTO [dbo].[cw_product_images] ([product_image_id], [product_image_product_id], [product_image_imagetype_id], [product_image_filename], [product_image_sortorder], [product_image_caption]) VALUES (N'425', N'95', N'4', N'Sample-Image-3.jpg', N'4', null);
;
INSERT INTO [dbo].[cw_product_images] ([product_image_id], [product_image_product_id], [product_image_imagetype_id], [product_image_filename], [product_image_sortorder], [product_image_caption]) VALUES (N'426', N'96', N'1', N'Sample-Image-4.jpg', N'1', null);
;
INSERT INTO [dbo].[cw_product_images] ([product_image_id], [product_image_product_id], [product_image_imagetype_id], [product_image_filename], [product_image_sortorder], [product_image_caption]) VALUES (N'427', N'96', N'2', N'Sample-Image-4.jpg', N'2', null);
;
INSERT INTO [dbo].[cw_product_images] ([product_image_id], [product_image_product_id], [product_image_imagetype_id], [product_image_filename], [product_image_sortorder], [product_image_caption]) VALUES (N'428', N'96', N'3', N'Sample-Image-4.jpg', N'3', null);
;
INSERT INTO [dbo].[cw_product_images] ([product_image_id], [product_image_product_id], [product_image_imagetype_id], [product_image_filename], [product_image_sortorder], [product_image_caption]) VALUES (N'429', N'96', N'4', N'Sample-Image-4.jpg', N'4', null);
;
INSERT INTO [dbo].[cw_product_images] ([product_image_id], [product_image_product_id], [product_image_imagetype_id], [product_image_filename], [product_image_sortorder], [product_image_caption]) VALUES (N'438', N'99', N'1', N'Sample-Image-7.jpg', N'1', null);
;
INSERT INTO [dbo].[cw_product_images] ([product_image_id], [product_image_product_id], [product_image_imagetype_id], [product_image_filename], [product_image_sortorder], [product_image_caption]) VALUES (N'439', N'99', N'2', N'Sample-Image-7.jpg', N'2', null);
;
INSERT INTO [dbo].[cw_product_images] ([product_image_id], [product_image_product_id], [product_image_imagetype_id], [product_image_filename], [product_image_sortorder], [product_image_caption]) VALUES (N'440', N'99', N'3', N'Sample-Image-7.jpg', N'3', null);
;
INSERT INTO [dbo].[cw_product_images] ([product_image_id], [product_image_product_id], [product_image_imagetype_id], [product_image_filename], [product_image_sortorder], [product_image_caption]) VALUES (N'441', N'99', N'4', N'Sample-Image-7.jpg', N'4', null);
;
INSERT INTO [dbo].[cw_product_images] ([product_image_id], [product_image_product_id], [product_image_imagetype_id], [product_image_filename], [product_image_sortorder], [product_image_caption]) VALUES (N'442', N'100', N'1', N'noimage.jpg', N'1', null);
;
INSERT INTO [dbo].[cw_product_images] ([product_image_id], [product_image_product_id], [product_image_imagetype_id], [product_image_filename], [product_image_sortorder], [product_image_caption]) VALUES (N'443', N'100', N'2', N'noimage.jpg', N'2', null);
;
INSERT INTO [dbo].[cw_product_images] ([product_image_id], [product_image_product_id], [product_image_imagetype_id], [product_image_filename], [product_image_sortorder], [product_image_caption]) VALUES (N'444', N'100', N'3', N'noimage.jpg', N'3', null);
;
INSERT INTO [dbo].[cw_product_images] ([product_image_id], [product_image_product_id], [product_image_imagetype_id], [product_image_filename], [product_image_sortorder], [product_image_caption]) VALUES (N'445', N'100', N'4', N'noimage.jpg', N'4', null);
;
INSERT INTO [dbo].[cw_product_images] ([product_image_id], [product_image_product_id], [product_image_imagetype_id], [product_image_filename], [product_image_sortorder], [product_image_caption]) VALUES (N'446', N'101', N'1', N'Sample-Image-8.jpg', N'1', null);
;
INSERT INTO [dbo].[cw_product_images] ([product_image_id], [product_image_product_id], [product_image_imagetype_id], [product_image_filename], [product_image_sortorder], [product_image_caption]) VALUES (N'447', N'101', N'2', N'Sample-Image-8.jpg', N'2', null);
;
INSERT INTO [dbo].[cw_product_images] ([product_image_id], [product_image_product_id], [product_image_imagetype_id], [product_image_filename], [product_image_sortorder], [product_image_caption]) VALUES (N'448', N'101', N'3', N'Sample-Image-8.jpg', N'3', null);
;
INSERT INTO [dbo].[cw_product_images] ([product_image_id], [product_image_product_id], [product_image_imagetype_id], [product_image_filename], [product_image_sortorder], [product_image_caption]) VALUES (N'449', N'101', N'4', N'Sample-Image-8.jpg', N'4', null);
;
INSERT INTO [dbo].[cw_product_images] ([product_image_id], [product_image_product_id], [product_image_imagetype_id], [product_image_filename], [product_image_sortorder], [product_image_caption]) VALUES (N'450', N'102', N'1', N'Sample-Image-6.jpg', N'1', null);
;
INSERT INTO [dbo].[cw_product_images] ([product_image_id], [product_image_product_id], [product_image_imagetype_id], [product_image_filename], [product_image_sortorder], [product_image_caption]) VALUES (N'451', N'102', N'2', N'Sample-Image-6.jpg', N'2', null);
;
INSERT INTO [dbo].[cw_product_images] ([product_image_id], [product_image_product_id], [product_image_imagetype_id], [product_image_filename], [product_image_sortorder], [product_image_caption]) VALUES (N'452', N'102', N'3', N'Sample-Image-6.jpg', N'3', null);
;
INSERT INTO [dbo].[cw_product_images] ([product_image_id], [product_image_product_id], [product_image_imagetype_id], [product_image_filename], [product_image_sortorder], [product_image_caption]) VALUES (N'453', N'102', N'4', N'Sample-Image-6.jpg', N'4', null);
;
INSERT INTO [dbo].[cw_product_images] ([product_image_id], [product_image_product_id], [product_image_imagetype_id], [product_image_filename], [product_image_sortorder], [product_image_caption]) VALUES (N'454', N'103', N'1', N'Sample-Image-5.jpg', N'1', null);
;
INSERT INTO [dbo].[cw_product_images] ([product_image_id], [product_image_product_id], [product_image_imagetype_id], [product_image_filename], [product_image_sortorder], [product_image_caption]) VALUES (N'455', N'103', N'2', N'Sample-Image-5.jpg', N'2', null);
;
INSERT INTO [dbo].[cw_product_images] ([product_image_id], [product_image_product_id], [product_image_imagetype_id], [product_image_filename], [product_image_sortorder], [product_image_caption]) VALUES (N'456', N'103', N'3', N'Sample-Image-5.jpg', N'3', null);
;
INSERT INTO [dbo].[cw_product_images] ([product_image_id], [product_image_product_id], [product_image_imagetype_id], [product_image_filename], [product_image_sortorder], [product_image_caption]) VALUES (N'457', N'103', N'4', N'Sample-Image-5.jpg', N'4', null);
;
INSERT INTO [dbo].[cw_product_images] ([product_image_id], [product_image_product_id], [product_image_imagetype_id], [product_image_filename], [product_image_sortorder], [product_image_caption]) VALUES (N'458', N'104', N'1', N'Sample-Image-9.jpg', N'1', null);
;
INSERT INTO [dbo].[cw_product_images] ([product_image_id], [product_image_product_id], [product_image_imagetype_id], [product_image_filename], [product_image_sortorder], [product_image_caption]) VALUES (N'459', N'104', N'2', N'Sample-Image-9.jpg', N'2', null);
;
INSERT INTO [dbo].[cw_product_images] ([product_image_id], [product_image_product_id], [product_image_imagetype_id], [product_image_filename], [product_image_sortorder], [product_image_caption]) VALUES (N'460', N'104', N'3', N'Sample-Image-9.jpg', N'3', null);
;
INSERT INTO [dbo].[cw_product_images] ([product_image_id], [product_image_product_id], [product_image_imagetype_id], [product_image_filename], [product_image_sortorder], [product_image_caption]) VALUES (N'461', N'104', N'4', N'Sample-Image-9.jpg', N'4', null);
;
INSERT INTO [dbo].[cw_product_images] ([product_image_id], [product_image_product_id], [product_image_imagetype_id], [product_image_filename], [product_image_sortorder], [product_image_caption]) VALUES (N'462', N'105', N'1', N'Sample-Image-10.jpg', N'1', null);
;
INSERT INTO [dbo].[cw_product_images] ([product_image_id], [product_image_product_id], [product_image_imagetype_id], [product_image_filename], [product_image_sortorder], [product_image_caption]) VALUES (N'463', N'105', N'2', N'Sample-Image-10.jpg', N'2', null);
;
INSERT INTO [dbo].[cw_product_images] ([product_image_id], [product_image_product_id], [product_image_imagetype_id], [product_image_filename], [product_image_sortorder], [product_image_caption]) VALUES (N'464', N'105', N'3', N'Sample-Image-10.jpg', N'3', null);
;
INSERT INTO [dbo].[cw_product_images] ([product_image_id], [product_image_product_id], [product_image_imagetype_id], [product_image_filename], [product_image_sortorder], [product_image_caption]) VALUES (N'465', N'105', N'4', N'Sample-Image-10.jpg', N'4', null);
;
INSERT INTO [dbo].[cw_product_images] ([product_image_id], [product_image_product_id], [product_image_imagetype_id], [product_image_filename], [product_image_sortorder], [product_image_caption]) VALUES (N'466', N'106', N'1', N'Sample-Image-11.jpg', N'1', null);
;
INSERT INTO [dbo].[cw_product_images] ([product_image_id], [product_image_product_id], [product_image_imagetype_id], [product_image_filename], [product_image_sortorder], [product_image_caption]) VALUES (N'467', N'106', N'2', N'Sample-Image-11.jpg', N'2', null);
;
INSERT INTO [dbo].[cw_product_images] ([product_image_id], [product_image_product_id], [product_image_imagetype_id], [product_image_filename], [product_image_sortorder], [product_image_caption]) VALUES (N'468', N'106', N'3', N'Sample-Image-11.jpg', N'3', null);
;
INSERT INTO [dbo].[cw_product_images] ([product_image_id], [product_image_product_id], [product_image_imagetype_id], [product_image_filename], [product_image_sortorder], [product_image_caption]) VALUES (N'469', N'106', N'4', N'Sample-Image-11.jpg', N'4', null);
;
INSERT INTO [dbo].[cw_product_images] ([product_image_id], [product_image_product_id], [product_image_imagetype_id], [product_image_filename], [product_image_sortorder], [product_image_caption]) VALUES (N'470', N'107', N'1', N'Sample-Image-12.jpg', N'1', null);
;
INSERT INTO [dbo].[cw_product_images] ([product_image_id], [product_image_product_id], [product_image_imagetype_id], [product_image_filename], [product_image_sortorder], [product_image_caption]) VALUES (N'471', N'107', N'2', N'Sample-Image-12.jpg', N'2', null);
;
INSERT INTO [dbo].[cw_product_images] ([product_image_id], [product_image_product_id], [product_image_imagetype_id], [product_image_filename], [product_image_sortorder], [product_image_caption]) VALUES (N'472', N'107', N'3', N'Sample-Image-12.jpg', N'3', null);
;
INSERT INTO [dbo].[cw_product_images] ([product_image_id], [product_image_product_id], [product_image_imagetype_id], [product_image_filename], [product_image_sortorder], [product_image_caption]) VALUES (N'473', N'107', N'4', N'Sample-Image-12.jpg', N'4', null);
;
INSERT INTO [dbo].[cw_product_images] ([product_image_id], [product_image_product_id], [product_image_imagetype_id], [product_image_filename], [product_image_sortorder], [product_image_caption]) VALUES (N'474', N'108', N'1', N'Sample-Image-13.jpg', N'1', null);
;
INSERT INTO [dbo].[cw_product_images] ([product_image_id], [product_image_product_id], [product_image_imagetype_id], [product_image_filename], [product_image_sortorder], [product_image_caption]) VALUES (N'475', N'108', N'2', N'Sample-Image-13.jpg', N'2', null);
;
INSERT INTO [dbo].[cw_product_images] ([product_image_id], [product_image_product_id], [product_image_imagetype_id], [product_image_filename], [product_image_sortorder], [product_image_caption]) VALUES (N'476', N'108', N'3', N'Sample-Image-13.jpg', N'3', null);
;
INSERT INTO [dbo].[cw_product_images] ([product_image_id], [product_image_product_id], [product_image_imagetype_id], [product_image_filename], [product_image_sortorder], [product_image_caption]) VALUES (N'477', N'108', N'4', N'Sample-Image-13.jpg', N'4', null);
;
INSERT INTO [dbo].[cw_product_images] ([product_image_id], [product_image_product_id], [product_image_imagetype_id], [product_image_filename], [product_image_sortorder], [product_image_caption]) VALUES (N'478', N'109', N'1', N'Sample-Image-14.jpg', N'1', null);
;
INSERT INTO [dbo].[cw_product_images] ([product_image_id], [product_image_product_id], [product_image_imagetype_id], [product_image_filename], [product_image_sortorder], [product_image_caption]) VALUES (N'479', N'109', N'2', N'Sample-Image-14.jpg', N'2', null);
;
INSERT INTO [dbo].[cw_product_images] ([product_image_id], [product_image_product_id], [product_image_imagetype_id], [product_image_filename], [product_image_sortorder], [product_image_caption]) VALUES (N'480', N'109', N'3', N'Sample-Image-14.jpg', N'3', null);
;
INSERT INTO [dbo].[cw_product_images] ([product_image_id], [product_image_product_id], [product_image_imagetype_id], [product_image_filename], [product_image_sortorder], [product_image_caption]) VALUES (N'481', N'109', N'4', N'Sample-Image-14.jpg', N'4', null);
;
INSERT INTO [dbo].[cw_product_images] ([product_image_id], [product_image_product_id], [product_image_imagetype_id], [product_image_filename], [product_image_sortorder], [product_image_caption]) VALUES (N'482', N'110', N'1', N'Sample-Image-15.jpg', N'1', null);
;
INSERT INTO [dbo].[cw_product_images] ([product_image_id], [product_image_product_id], [product_image_imagetype_id], [product_image_filename], [product_image_sortorder], [product_image_caption]) VALUES (N'483', N'110', N'2', N'Sample-Image-15.jpg', N'2', null);
;
INSERT INTO [dbo].[cw_product_images] ([product_image_id], [product_image_product_id], [product_image_imagetype_id], [product_image_filename], [product_image_sortorder], [product_image_caption]) VALUES (N'484', N'110', N'3', N'Sample-Image-15.jpg', N'3', null);
;
INSERT INTO [dbo].[cw_product_images] ([product_image_id], [product_image_product_id], [product_image_imagetype_id], [product_image_filename], [product_image_sortorder], [product_image_caption]) VALUES (N'485', N'110', N'4', N'Sample-Image-15.jpg', N'4', null);
;
INSERT INTO [dbo].[cw_product_images] ([product_image_id], [product_image_product_id], [product_image_imagetype_id], [product_image_filename], [product_image_sortorder], [product_image_caption]) VALUES (N'486', N'111', N'1', N'Sample-Image-16.jpg', N'1', null);
;
INSERT INTO [dbo].[cw_product_images] ([product_image_id], [product_image_product_id], [product_image_imagetype_id], [product_image_filename], [product_image_sortorder], [product_image_caption]) VALUES (N'487', N'111', N'2', N'Sample-Image-16.jpg', N'2', null);
;
INSERT INTO [dbo].[cw_product_images] ([product_image_id], [product_image_product_id], [product_image_imagetype_id], [product_image_filename], [product_image_sortorder], [product_image_caption]) VALUES (N'488', N'111', N'3', N'Sample-Image-16.jpg', N'3', null);
;
INSERT INTO [dbo].[cw_product_images] ([product_image_id], [product_image_product_id], [product_image_imagetype_id], [product_image_filename], [product_image_sortorder], [product_image_caption]) VALUES (N'489', N'111', N'4', N'Sample-Image-16.jpg', N'4', null);
;
INSERT INTO [dbo].[cw_product_images] ([product_image_id], [product_image_product_id], [product_image_imagetype_id], [product_image_filename], [product_image_sortorder], [product_image_caption]) VALUES (N'490', N'112', N'1', N'Sample-Image-17.jpg', N'1', null);
;
INSERT INTO [dbo].[cw_product_images] ([product_image_id], [product_image_product_id], [product_image_imagetype_id], [product_image_filename], [product_image_sortorder], [product_image_caption]) VALUES (N'491', N'112', N'2', N'Sample-Image-17.jpg', N'2', null);
;
INSERT INTO [dbo].[cw_product_images] ([product_image_id], [product_image_product_id], [product_image_imagetype_id], [product_image_filename], [product_image_sortorder], [product_image_caption]) VALUES (N'492', N'112', N'3', N'Sample-Image-17.jpg', N'3', null);
;
INSERT INTO [dbo].[cw_product_images] ([product_image_id], [product_image_product_id], [product_image_imagetype_id], [product_image_filename], [product_image_sortorder], [product_image_caption]) VALUES (N'493', N'112', N'4', N'Sample-Image-17.jpg', N'4', null);
;
SET IDENTITY_INSERT [dbo].[cw_product_images] OFF
;

-- ----------------------------
-- Table structure for [dbo].[cw_product_options]
-- ----------------------------
IF OBJECT_ID('[dbo].[cw_product_options]') IS NOT NULL DROP TABLE [dbo].[cw_product_options]
;
CREATE TABLE [dbo].[cw_product_options] (
[product_options_id] int NOT NULL IDENTITY(1,1) ,
[product_options2prod_id] int NULL DEFAULT '0',
[product_options2optiontype_id] int NULL DEFAULT '0'
)


;
DBCC CHECKIDENT(N'[dbo].[cw_product_options]', RESEED, 722)
;

-- ----------------------------
-- Records of cw_product_options
-- ----------------------------
SET IDENTITY_INSERT [dbo].[cw_product_options] ON
;
INSERT INTO [dbo].[cw_product_options] ([product_options_id], [product_options2prod_id], [product_options2optiontype_id]) VALUES (N'550', N'107', N'29');
;
INSERT INTO [dbo].[cw_product_options] ([product_options_id], [product_options2prod_id], [product_options2optiontype_id]) VALUES (N'551', N'108', N'30');
;
INSERT INTO [dbo].[cw_product_options] ([product_options_id], [product_options2prod_id], [product_options2optiontype_id]) VALUES (N'580', N'111', N'30');
;
INSERT INTO [dbo].[cw_product_options] ([product_options_id], [product_options2prod_id], [product_options2optiontype_id]) VALUES (N'581', N'111', N'40');
;
INSERT INTO [dbo].[cw_product_options] ([product_options_id], [product_options2prod_id], [product_options2optiontype_id]) VALUES (N'582', N'112', N'40');
;
INSERT INTO [dbo].[cw_product_options] ([product_options_id], [product_options2prod_id], [product_options2optiontype_id]) VALUES (N'589', N'101', N'30');
;
INSERT INTO [dbo].[cw_product_options] ([product_options_id], [product_options2prod_id], [product_options2optiontype_id]) VALUES (N'590', N'101', N'39');
;
INSERT INTO [dbo].[cw_product_options] ([product_options_id], [product_options2prod_id], [product_options2optiontype_id]) VALUES (N'613', N'102', N'30');
;
INSERT INTO [dbo].[cw_product_options] ([product_options_id], [product_options2prod_id], [product_options2optiontype_id]) VALUES (N'614', N'102', N'29');
;
INSERT INTO [dbo].[cw_product_options] ([product_options_id], [product_options2prod_id], [product_options2optiontype_id]) VALUES (N'672', N'104', N'29');
;
INSERT INTO [dbo].[cw_product_options] ([product_options_id], [product_options2prod_id], [product_options2optiontype_id]) VALUES (N'677', N'110', N'30');
;
INSERT INTO [dbo].[cw_product_options] ([product_options_id], [product_options2prod_id], [product_options2optiontype_id]) VALUES (N'678', N'110', N'40');
;
INSERT INTO [dbo].[cw_product_options] ([product_options_id], [product_options2prod_id], [product_options2optiontype_id]) VALUES (N'680', N'109', N'30');
;
INSERT INTO [dbo].[cw_product_options] ([product_options_id], [product_options2prod_id], [product_options2optiontype_id]) VALUES (N'693', N'100', N'38');
;
INSERT INTO [dbo].[cw_product_options] ([product_options_id], [product_options2prod_id], [product_options2optiontype_id]) VALUES (N'694', N'100', N'33');
;
INSERT INTO [dbo].[cw_product_options] ([product_options_id], [product_options2prod_id], [product_options2optiontype_id]) VALUES (N'695', N'100', N'37');
;
INSERT INTO [dbo].[cw_product_options] ([product_options_id], [product_options2prod_id], [product_options2optiontype_id]) VALUES (N'696', N'100', N'36');
;
INSERT INTO [dbo].[cw_product_options] ([product_options_id], [product_options2prod_id], [product_options2optiontype_id]) VALUES (N'697', N'100', N'35');
;
INSERT INTO [dbo].[cw_product_options] ([product_options_id], [product_options2prod_id], [product_options2optiontype_id]) VALUES (N'698', N'100', N'34');
;
INSERT INTO [dbo].[cw_product_options] ([product_options_id], [product_options2prod_id], [product_options2optiontype_id]) VALUES (N'699', N'94', N'30');
;
INSERT INTO [dbo].[cw_product_options] ([product_options_id], [product_options2prod_id], [product_options2optiontype_id]) VALUES (N'700', N'94', N'43');
;
INSERT INTO [dbo].[cw_product_options] ([product_options_id], [product_options2prod_id], [product_options2optiontype_id]) VALUES (N'701', N'94', N'29');
;
INSERT INTO [dbo].[cw_product_options] ([product_options_id], [product_options2prod_id], [product_options2optiontype_id]) VALUES (N'714', N'99', N'38');
;
INSERT INTO [dbo].[cw_product_options] ([product_options_id], [product_options2prod_id], [product_options2optiontype_id]) VALUES (N'715', N'99', N'33');
;
INSERT INTO [dbo].[cw_product_options] ([product_options_id], [product_options2prod_id], [product_options2optiontype_id]) VALUES (N'716', N'99', N'37');
;
INSERT INTO [dbo].[cw_product_options] ([product_options_id], [product_options2prod_id], [product_options2optiontype_id]) VALUES (N'717', N'99', N'36');
;
INSERT INTO [dbo].[cw_product_options] ([product_options_id], [product_options2prod_id], [product_options2optiontype_id]) VALUES (N'718', N'99', N'35');
;
INSERT INTO [dbo].[cw_product_options] ([product_options_id], [product_options2prod_id], [product_options2optiontype_id]) VALUES (N'719', N'99', N'34');
;
INSERT INTO [dbo].[cw_product_options] ([product_options_id], [product_options2prod_id], [product_options2optiontype_id]) VALUES (N'720', N'106', N'29');
;
INSERT INTO [dbo].[cw_product_options] ([product_options_id], [product_options2prod_id], [product_options2optiontype_id]) VALUES (N'721', N'93', N'30');
;
INSERT INTO [dbo].[cw_product_options] ([product_options_id], [product_options2prod_id], [product_options2optiontype_id]) VALUES (N'722', N'93', N'29');
;
SET IDENTITY_INSERT [dbo].[cw_product_options] OFF
;

-- ----------------------------
-- Table structure for [dbo].[cw_product_upsell]
-- ----------------------------
IF OBJECT_ID('[dbo].[cw_product_upsell]') IS NOT NULL DROP TABLE [dbo].[cw_product_upsell]
;
CREATE TABLE [dbo].[cw_product_upsell] (
[upsell_id] int NOT NULL IDENTITY(1,1) ,
[upsell_product_id] int NULL DEFAULT '0',
[upsell_2product_id] int NULL DEFAULT '0' 
)


;
DBCC CHECKIDENT(N'[dbo].[cw_product_upsell]', RESEED, 303)
;

-- ----------------------------
-- Records of cw_product_upsell
-- ----------------------------
SET IDENTITY_INSERT [dbo].[cw_product_upsell] ON
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'181', N'93', N'95');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'182', N'93', N'94');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'183', N'95', N'93');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'184', N'93', N'96');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'186', N'95', N'94');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'187', N'94', N'95');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'188', N'97', N'95');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'190', N'98', N'95');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'194', N'106', N'93');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'195', N'107', N'106');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'196', N'108', N'96');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'197', N'109', N'105');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'198', N'109', N'95');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'199', N'101', N'104');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'200', N'101', N'94');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'201', N'101', N'107');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'202', N'101', N'102');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'203', N'104', N'101');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'204', N'102', N'101');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'205', N'115', N'100');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'206', N'115', N'111');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'207', N'115', N'110');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'208', N'115', N'102');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'213', N'105', N'93');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'214', N'105', N'99');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'216', N'105', N'109');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'217', N'105', N'95');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'218', N'105', N'104');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'219', N'105', N'103');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'220', N'105', N'94');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'221', N'105', N'107');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'222', N'105', N'100');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'223', N'105', N'111');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'224', N'105', N'110');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'225', N'105', N'102');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'226', N'105', N'96');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'229', N'105', N'106');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'230', N'105', N'101');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'231', N'105', N'108');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'232', N'105', N'112');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'234', N'99', N'105');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'235', N'113', N'105');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'236', N'95', N'105');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'237', N'104', N'105');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'238', N'103', N'105');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'239', N'94', N'105');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'240', N'107', N'105');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'241', N'100', N'105');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'242', N'111', N'105');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'243', N'110', N'105');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'244', N'102', N'105');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'245', N'96', N'105');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'246', N'115', N'105');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'247', N'114', N'105');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'248', N'106', N'105');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'249', N'101', N'105');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'250', N'108', N'105');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'251', N'112', N'105');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'252', N'110', N'93');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'253', N'110', N'99');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'255', N'110', N'109');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'256', N'110', N'95');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'257', N'110', N'104');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'258', N'110', N'103');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'259', N'110', N'94');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'260', N'110', N'107');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'261', N'110', N'100');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'262', N'110', N'111');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'263', N'110', N'102');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'264', N'110', N'96');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'266', N'110', N'106');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'267', N'110', N'101');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'268', N'110', N'108');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'269', N'110', N'112');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'270', N'93', N'110');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'271', N'99', N'110');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'272', N'113', N'110');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'273', N'109', N'110');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'274', N'95', N'110');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'275', N'104', N'110');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'276', N'103', N'110');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'277', N'94', N'110');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'278', N'107', N'110');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'279', N'100', N'110');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'280', N'111', N'110');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'281', N'102', N'110');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'282', N'96', N'110');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'283', N'114', N'110');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'284', N'106', N'110');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'285', N'101', N'110');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'286', N'108', N'110');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'287', N'112', N'110');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'289', N'116', N'107');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'290', N'116', N'102');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'294', N'99', N'93');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'295', N'118', N'103');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'296', N'118', N'94');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'297', N'118', N'111');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'298', N'118', N'108');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'300', N'93', N'103');
;
INSERT INTO [dbo].[cw_product_upsell] ([upsell_id], [upsell_product_id], [upsell_2product_id]) VALUES (N'301', N'93', N'101');
;
SET IDENTITY_INSERT [dbo].[cw_product_upsell] OFF
;

-- ----------------------------
-- Table structure for [dbo].[cw_products]
-- ----------------------------
IF OBJECT_ID('[dbo].[cw_products]') IS NOT NULL DROP TABLE [dbo].[cw_products]
;
CREATE TABLE [dbo].[cw_products] (
[product_id] int NOT NULL IDENTITY(1,1) ,
[product_merchant_product_id] nvarchar(150) NULL ,
[product_name] nvarchar(255) NULL ,
[product_description] nvarchar(MAX) NULL ,
[product_preview_description] nvarchar(MAX) NULL ,
[product_sort] float(53) NULL DEFAULT '1.00',
[product_on_web] int NULL DEFAULT '1',
[product_archive] int NULL DEFAULT '0',
[product_ship_charge] int NULL DEFAULT '0',
[product_tax_group_id] int NULL DEFAULT '0',
[product_date_modified] datetime NULL ,
[product_special_description] nvarchar(MAX) NULL ,
[product_keywords] nvarchar(MAX) NULL ,
[product_out_of_stock_message] nvarchar(255) NULL ,
[product_custom_info_label] nvarchar(255) NULL 
)


;
DBCC CHECKIDENT(N'[dbo].[cw_products]', RESEED, 115)
;

-- ----------------------------
-- Records of cw_products
-- ----------------------------
SET IDENTITY_INSERT [dbo].[cw_products] ON
;
INSERT INTO [dbo].[cw_products] ([product_id], [product_merchant_product_id], [product_name], [product_description], [product_preview_description], [product_sort], [product_on_web], [product_archive], [product_ship_charge], [product_tax_group_id], [product_date_modified], [product_special_description], [product_keywords], [product_out_of_stock_message], [product_custom_info_label]) VALUES (N'93', N'BriteTs-4U', N'Very Colourful T-Shirts', N'<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus molestie nisi vel orci ultricies volutpat. Nullam lacinia mi vel sapien tincidunt ornare. Aliquam tempus lectus eget turpis pulvinar tincidunt. Nullam sit amet consectetur risus.</p>
<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam pharetra, enim quis varius dignissim, erat magna suscipit ipsum, vel pulvinar sapien augue vel enim. Ut ac sagittis enim. Nulla massa odio, accumsan at consequat id, varius a dolor. Nam non nibh ut massa dictum congue.</p>
<p>Duis quis ligula in turpis facilisis ultrices. Morbi porta mi quis ligula malesuada eget posuere risus congue. Nullam cursus eleifend molestie. Mauris eleifend venenatis convallis.</p>
<p>Pellentesque dapibus, odio eu venenatis faucibus, mi justo venenatis metus, quis cursus odio dui id felis. Sed interdum nisi sit amet nisi fermentum volutpat. Ut eget nisl sapien, ut pellentesque turpis. Etiam magna velit, aliquam volutpat pellentesque vitae, varius vitae ipsum. Fusce elementum hendrerit nibh vel tempor.</p>
<p>Ut dignissim sapien vel lectus suscipit dignissim.</p>', N'<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus molestie nisi vel orci ultricies volutpat. Nullam lacinia mi vel sapien tincidunt ornare. Aliquam tempus lectus eget turpis pulvinar tincidunt. Nullam sit amet consectetur risus.</p>', N'0', N'1', N'0', N'0', N'14', N'2011-12-16 11:26:25.000', N'<p>In hac bhabitasse platea dictumst. Etiam faucibus interdum nisi sed imperdiet. Sed tempus risus risus. Pellentesque vitae arcu odio. Pellentesque purus magna, feugiat et sodales eget, pretium non metus.</p>', N'Bright Cotton T Shirts, Cotton T''s, Tee Shirt, Tshirt, Teeshirt, Albatross', N'Sorry, Out Of Stock', N'Write Your Message!');
;
INSERT INTO [dbo].[cw_products] ([product_id], [product_merchant_product_id], [product_name], [product_description], [product_preview_description], [product_sort], [product_on_web], [product_archive], [product_ship_charge], [product_tax_group_id], [product_date_modified], [product_special_description], [product_keywords], [product_out_of_stock_message], [product_custom_info_label]) VALUES (N'94', N'3DenimJeans', N'Gotsda Blues Jeans', N'<p>Pellentesque consectetur nisl et lacus tincidunt vel euismod turpis adipiscing. Maecenas molestie turpis et quam pulvinar eget ornare nisi consectetur.</p>
<p>Aliquam vehicula scelerisque dolor, in imperdiet nisi consequat eget. Mauris et felis semper quam feugiat ultricies in adipiscing risus.</p>', N'<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis a arcu magna, et egestas lorem. Vivamus porta arcu vel massa adipiscing egestas.</p>', N'0', N'1', N'0', N'1', N'14', N'2011-11-16 11:10:40.000', N'<p>&nbsp;Maecenas molestie turpis et quam pulvinar eget ornare nisi consectetur. Aliquam vehicula scelerisque dolor, in imperdiet nisi consequat eget.</p>', N'Blue Jeans, Denim Jeans', N'So popular we can hardly keep them in stock <br> Get more of these great jeans next week! ', N'');
;
INSERT INTO [dbo].[cw_products] ([product_id], [product_merchant_product_id], [product_name], [product_description], [product_preview_description], [product_sort], [product_on_web], [product_archive], [product_ship_charge], [product_tax_group_id], [product_date_modified], [product_special_description], [product_keywords], [product_out_of_stock_message], [product_custom_info_label]) VALUES (N'95', N'DigitalSLRCamera', N'Digital SLR Camera', N'<p>Pellentesque consectetur nisl et lacus tincidunt vel euismod turpis  adipiscing. Maecenas molestie turpis et quam pulvinar eget ornare nisi  consectetur.</p>
<p>Aliquam vehicula scelerisque dolor, in imperdiet nisi  consequat eget. Mauris et felis semper quam feugiat ultricies in  adipiscing risus. Proin feugiat arcu quis risus posuere dignissim. Etiam  lacinia justo ac risus pretium cursus.</p>
<ul>
<li>Vestibulum mattis condimentum  tincidunt. </li>
<li>Aliquam convallis, ante eu posuere molestie,</li>
<li>Rrisus ipsum  sollicitudin sem</li>
<li>Semper tempus diam nibh sed lacus. </li>
</ul>
<p>Morbi tincidunt  ullamcorper libero sed dapibus. Pellentesque habitant morbi tristique  senectus et netus et malesuada fames ac turpis egestas. Donec aliquet  odio nulla, eget vulputate purus. Nullam lobortis eleifend mauris, vel  dictum tortor tempus et. Pellentesque eu augue magna, ac gravida dolor.  Ut ipsum eros, mollis pulvinar interdum at, sodales eu tortor.</p>
<p>Aliquam  erat volutpat. Vestibulum et purus sed dui ornare fermentum vitae id  tortor. Ut elementum auctor turpis, ornare feugiat tortor ultricies  interdum.</p>', N'<p>Morbi at ipsum ut eros mattis tincidunt. Etiam id arcu sit amet est  mattis porttitor molestie vel mi. Cras ipsum dui, egestas id accumsan a,  consequat in nibh. Suspendisse potenti. Suspendisse non est eget lectus  tempus gravida elementum eu sapien.</p>', N'0', N'1', N'0', N'1', N'10', N'2010-06-20 14:45:32.000', N'<p>Quisque rutrum felis nulla, quis viverra sem. Nam nec lorem  leo. Nulla  lectus arcu, hendrerit id tempus nec, mollis non massa.</p>', N'Photography, Hobbies', N'Sorry, Out Of Stock', N'');
;
INSERT INTO [dbo].[cw_products] ([product_id], [product_merchant_product_id], [product_name], [product_description], [product_preview_description], [product_sort], [product_on_web], [product_archive], [product_ship_charge], [product_tax_group_id], [product_date_modified], [product_special_description], [product_keywords], [product_out_of_stock_message], [product_custom_info_label]) VALUES (N'96', N'PlasmaFlatScreen', N'Plasma 50" TV', N'<p>Nunc at varius lectus. Fusce ullamcorper, dui nec volutpat mollis, nulla quam lobortis magna, et fringilla leo diam id ante. Nunc ornare, nulla nec tempor adipiscing, ipsum turpis pulvinar mi, nec iaculis arcu dolor nec orci. Proin velit nisl, semper vitae vestibulum eget, adipiscing quis augue. Praesent gravida, magna vitae commodo elementum, neque ante eleifend urna, tempus luctus turpis quam a risus. Nam nec metus ac arcu tempor accumsan in sed neque. Phasellus posuere, nisi a rhoncus viverra, risus purus rutrum nisl, accumsan laoreet nisl est in purus. </p>
<p><strong>Duis vulputate placerat tellus a laoreet. </strong></p>
<ul>
<li>Aliquam rhoncus malesuada mollis. <br /></li>
<li>Maecenas facilisis consectetur eleifend. <br /></li>
<li>Vivamus magna lacus, dignissim id ornare sit amet, accumsan at tortor. </li>
</ul>
<p>Mauris quam tellus, pellentesque vel pretium et, convallis quis purus. Quisque at porta ipsum. Maecenas laoreet eros id dolor mollis porta.</p>', N'<p>Proin at velit urna. Cras molestie, ligula sit amet vestibulum tincidunt, nulla diam imperdiet justo, tincidunt hendrerit nisl massa id risus. Phasellus consequat dapibus blandit. Nam eu quam eget purus fringilla posuere. Cras tempus tempor quam</p>', N'0', N'1', N'0', N'1', N'10', N'2010-06-07 14:47:08.000', N'<p>Cras tempus tempor quam, nec posuere arcu malesuada sed.</p>', N'TV, Video, Big Screen', N'Sorry, Out Of Stock', N'');
;
INSERT INTO [dbo].[cw_products] ([product_id], [product_merchant_product_id], [product_name], [product_description], [product_preview_description], [product_sort], [product_on_web], [product_archive], [product_ship_charge], [product_tax_group_id], [product_date_modified], [product_special_description], [product_keywords], [product_out_of_stock_message], [product_custom_info_label]) VALUES (N'99', N'DeskTop-Basic5000', N'Desktop Basic 5000', N'<p style="text-align: left;">Maecenas a lobortis massa. Quisque viverra suscipit tellus, a dapibus enim pulvinar et. Morbi pharetra orci id odio ultrices scelerisque. Duis quis elit eu nisl blandit mollis. Praesent laoreet placerat ipsum at sagittis. Integer at turpis ut dui aliquam semper sed sit amet elit. Fusce non mi et enim aliquet luctus vitae vestibulum eros. </p>
<ul>
<li>
<div style="text-align: left;">Suspendisse vitae velit felis. </div>
</li>
<li>
<div style="text-align: left;">Pellentesque malesuada tincidunt lorem id varius. Morbi quis ante ipsum. </div>
</li>
<li>
<div style="text-align: left;">Duis facilisis ligula eget purus dictum sed faucibus enim venenatis. </div>
</li>
<li>
<div style="text-align: left;">Phasellus hendrerit rhoncus mi, at adipiscing velit laoreet quis. </div>
</li>
</ul>
<p style="text-align: left;">Sed sem arcu, consequat quis varius ac, dictum sit amet lorem. In odio metus, consequat vel condimentum sit amet, posuere condimentum arcu. Vivamus tellus nunc, sodales a fringilla at, pulvinar ut nisi. Nam nibh lectus, posuere quis convallis vel, luctus ut ipsum. Nam eget eros arcu. </p>
<p style="text-align: left;">Donec quis auctor nisl. Cras viverra, enim molestie lacinia gravida, risus dui laoreet mauris, quis ornare mi orci sed tellus.</p>', N'<p>Donec condimentum, turpis eu interdum venenatis, libero diam porttitor ipsum, et sodales dui libero at turpis. Nulla mollis, est non vulputate cursus, ipsum nibh sodales diam, ut elementum odio nibh et turpis. Maecenas imperdiet fringilla nisi non accumsan.&nbsp;</p>', N'1', N'1', N'0', N'1', N'3', N'2011-12-16 11:15:52.000', N'<p>Donec quis auctor nisl. Cras viverra, enim molestie lacinia gravida, risus dui laoreet mauris, quis ornare mi orci sed tellus.</p>
<p class="smallprint">This is some small print. This is some small print. This is some small print. This is some small print. This is some small print.&nbsp;</p>', N'', N'Sorry, Sold Out', N'');
;
INSERT INTO [dbo].[cw_products] ([product_id], [product_merchant_product_id], [product_name], [product_description], [product_preview_description], [product_sort], [product_on_web], [product_archive], [product_ship_charge], [product_tax_group_id], [product_date_modified], [product_special_description], [product_keywords], [product_out_of_stock_message], [product_custom_info_label]) VALUES (N'100', N'Laptop-Basic5000', N'Laptop Basic 5000', N'<p style="text-align: left;">Maecenas a lobortis massa. Quisque viverra suscipit tellus, a dapibus enim pulvinar et. Morbi pharetra orci id odio ultrices scelerisque. Duis quis elit eu nisl blandit mollis. Praesent laoreet placerat ipsum at sagittis. Integer at turpis ut dui aliquam semper sed sit amet elit. Fusce non mi et enim aliquet luctus vitae vestibulum eros. </p>
<ul>
<li>
<div style="text-align: left;">Suspendisse vitae velit felis. </div>
</li>
<li>
<div style="text-align: left;">Pellentesque malesuada tincidunt lorem id varius. Morbi quis ante ipsum. </div>
</li>
<li>
<div style="text-align: left;">Duis facilisis ligula eget purus dictum sed faucibus enim venenatis. </div>
</li>
<li>
<div style="text-align: left;">Phasellus hendrerit rhoncus mi, at adipiscing velit laoreet quis. </div>
</li>
</ul>
<p style="text-align: left;">Sed sem arcu, consequat quis varius ac, dictum sit amet lorem. In odio metus, consequat vel condimentum sit amet, posuere condimentum arcu. Vivamus tellus nunc, sodales a fringilla at, pulvinar ut nisi. Nam nibh lectus, posuere quis convallis vel, luctus ut ipsum. Nam eget eros arcu. </p>
<p style="text-align: left;">Donec quis auctor nisl. Cras viverra, enim molestie lacinia gravida, risus dui laoreet mauris, quis ornare mi orci sed tellus.</p>', N'<p>Donec condimentum, turpis eu interdum venenatis, libero diam porttitor ipsum, et sodales dui libero at turpis. Nulla mollis, est non vulputate cursus, ipsum nibh sodales diam, ut elementum odio nibh et turpis. Maecenas imperdiet fringilla nisi non accumsan.&nbsp;</p>', N'1', N'1', N'0', N'1', N'3', N'2011-11-09 18:17:45.000', N'<p>Donec quis auctor nisl. Cras viverra, enim molestie lacinia gravida, risus dui laoreet mauris, quis ornare mi orci sed tellus.</p>', N'', N'Sorry, Out Of Stock', N'');
;
INSERT INTO [dbo].[cw_products] ([product_id], [product_merchant_product_id], [product_name], [product_description], [product_preview_description], [product_sort], [product_on_web], [product_archive], [product_ship_charge], [product_tax_group_id], [product_date_modified], [product_special_description], [product_keywords], [product_out_of_stock_message], [product_custom_info_label]) VALUES (N'101', N'Terrycloth-Towels', N'Terrycloth Bath Towels', N'<p class="CWproductDescription" style="text-align: left;">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras ac nisl enim, sed ornare orci. Donec porta luctus velit vitae mattis. Pellentesque lacus risus, pellentesque et blandit non, mollis nec tellus. Quisque ac dignissim odio. Cras eros neque, cursus non vulputate ut, lobortis congue purus. Aenean in nisi id tellus ornare elementum. Duis neque purus, viverra id lacinia sed, aliquam eget enim. Ut ut lobortis leo. Mauris aliquam libero molestie orci feugiat porta. Praesent sodales tortor eu magna adipiscing sed ultrices sapien viverra. Cras ac enim ligula. Pellentesque velit massa, imperdiet eget consequat non, tincidunt ac purus. Pellentesque mollis justo id tellus tristique ultrices. Suspendisse pretium, nisi sit amet varius laoreet, mauris lacus egestas urna, placerat scelerisque quam odio a nisi.</p>', N'<p class="CWproduct" style="text-align: left;">Aenean in nisi id tellus ornare elementum. Duis neque purus, viverra id lacinia sed, aliquam eget enim. Ut ut lobortis leo. Mauris aliquam libero molestie orci feugiat porta.</p>', N'0', N'1', N'0', N'1', N'10', N'2010-07-15 13:19:33.000', N'<p>Super soft and long lasting.</p>', N'', N'Sorry, Out Of Stock', N'Custom Monogram');
;
INSERT INTO [dbo].[cw_products] ([product_id], [product_merchant_product_id], [product_name], [product_description], [product_preview_description], [product_sort], [product_on_web], [product_archive], [product_ship_charge], [product_tax_group_id], [product_date_modified], [product_special_description], [product_keywords], [product_out_of_stock_message], [product_custom_info_label]) VALUES (N'102', N'PastelComforters', N'Pastel Comforters', N'<p class="CWproductDescription" style="text-align: left;">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras ac nisl enim, sed ornare orci. Donec porta luctus velit vitae mattis. Pellentesque lacus risus, pellentesque et blandit non, mollis nec tellus.</p>
<p class="CWproductDescription" style="text-align: left;">Quisque ac dignissim odio. Cras eros neque, cursus non vulputate ut, lobortis congue purus. Aenean in nisi id tellus ornare elementum. Duis neque purus, viverra id lacinia sed, aliquam eget enim. Ut ut lobortis leo. Mauris aliquam libero molestie orci feugiat porta. Praesent sodales tortor eu magna adipiscing sed ultrices sapien viverra. Cras ac enim ligula. Pellentesque velit massa, imperdiet eget consequat non, tincidunt ac purus. Pellentesque mollis justo id tellus tristique ultrices. Suspendisse pretium, nisi sit amet varius laoreet, mauris lacus egestas urna, placerat scelerisque quam odio a nisi.</p>', N'<p class="CWproduct" style="text-align: left;">Aenean in nisi id tellus ornare elementum. Duis neque purus, viverra id lacinia sed, aliquam eget enim. Ut ut lobortis leo. Mauris aliquam libero molestie orci feugiat porta.</p>', N'0', N'1', N'0', N'0', N'10', N'2011-01-21 09:42:09.000', N'<p>Super soft and long lasting.</p>', N'', N'Sorry, Out Of Stock', N'');
;
INSERT INTO [dbo].[cw_products] ([product_id], [product_merchant_product_id], [product_name], [product_description], [product_preview_description], [product_sort], [product_on_web], [product_archive], [product_ship_charge], [product_tax_group_id], [product_date_modified], [product_special_description], [product_keywords], [product_out_of_stock_message], [product_custom_info_label]) VALUES (N'103', N'RainbowBroom', N'FloorBrite Rainbow Broom', N'<p style="text-align: left;">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras ac nisl enim, sed ornare orci. Donec porta luctus velit vitae mattis. Pellentesque lacus risus, pellentesque et blandit non, mollis nec tellus. Quisque ac dignissim odio. Cras eros neque, cursus non vulputate ut, lobortis congue purus. Aenean in nisi id tellus ornare elementum. Duis neque purus, viverra id lacinia sed, aliquam eget enim. Ut ut lobortis leo. Mauris aliquam libero molestie orci feugiat porta. Praesent sodales tortor eu magna adipiscing sed ultrices sapien viverra. Cras ac enim ligula. Pellentesque velit massa, imperdiet eget consequat non, tincidunt ac purus. Pellentesque mollis justo id tellus tristique ultrices. Suspendisse pretium, nisi sit amet varius laoreet, mauris lacus egestas urna, placerat scelerisque quam odio a nisi.</p>', N'<p class="CWproduct" style="text-align: left;">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras ac nisl enim, sed ornare orci. Donec porta luctus velit vitae mattis. Pellentesque lacus risus</p>', N'0', N'1', N'0', N'1', N'10', N'2011-02-16 10:44:16.000', N'', N'', N'Sorry, Out Of Stock', N'');
;
INSERT INTO [dbo].[cw_products] ([product_id], [product_merchant_product_id], [product_name], [product_description], [product_preview_description], [product_sort], [product_on_web], [product_archive], [product_ship_charge], [product_tax_group_id], [product_date_modified], [product_special_description], [product_keywords], [product_out_of_stock_message], [product_custom_info_label]) VALUES (N'104', N'DownPillows', N'Down Feather Pillows', N'<p class="CWproductDescription" style="text-align: left;">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras ac nisl enim, sed ornare orci.</p>
<p class="CWproductDescription" style="text-align: left;">&nbsp;</p>
<p class="CWproductDescription" style="text-align: left;">Donec porta luctus velit vitae mattis. Pellentesque lacus risus, pellentesque et blandit non, mollis nec tellus.</p>
<p class="CWproductDescription" style="text-align: left;">Quisque ac dignissim odio. Cras eros neque, cursus non vulputate ut, lobortis congue purus. Aenean in nisi id tellus ornare elementum. Duis neque purus, viverra id lacinia sed, aliquam eget enim. Ut ut lobortis leo. Mauris aliquam libero molestie orci feugiat porta. Praesent sodales tortor eu magna adipiscing sed ultrices sapien viverra. Cras ac enim ligula. Pellentesque velit massa, imperdiet eget consequat non, tincidunt ac purus. Pellentesque mollis justo id tellus tristique ultrices. Suspendisse pretium, nisi sit amet varius laoreet, mauris lacus egestas urna, placerat scelerisque quam odio a nisi.</p>', N'<p class="CWproduct" style="text-align: left;">Aenean in nisi id tellus ornare elementum. Duis neque purus, viverra id lacinia sed, aliquam eget enim. Ut ut lobortis leo. Mauris aliquam libero molestie orci feugiat porta.</p>', N'0', N'1', N'0', N'1', N'10', N'2011-05-15 17:26:45.000', N'<p>Super soft, supportive and so comfy.</p>', N'', N'Sorry, Out Of Stock', N'');
;
INSERT INTO [dbo].[cw_products] ([product_id], [product_merchant_product_id], [product_name], [product_description], [product_preview_description], [product_sort], [product_on_web], [product_archive], [product_ship_charge], [product_tax_group_id], [product_date_modified], [product_special_description], [product_keywords], [product_out_of_stock_message], [product_custom_info_label]) VALUES (N'105', N'DigitalVideoCamera', N'Digital HD Video Camera', N'<p style="text-align: left;">Pellentesque consectetur nisl et lacus tincidunt vel euismod turpis adipiscing. Maecenas molestie turpis et quam pulvinar eget ornare nisi consectetur.</p>
<p style="text-align: left;">Aliquam vehicula scelerisque dolor, in imperdiet nisi consequat eget. Mauris et felis semper quam feugiat ultricies in adipiscing risus. Proin feugiat arcu quis risus posuere dignissim. Etiam lacinia justo ac risus pretium cursus.</p>
<ul>
<li style="text-align: left;">Vestibulum mattis condimentum tincidunt.</li>
<li style="text-align: left;">Aliquam convallis, ante eu posuere molestie,</li>
<li style="text-align: left;">Rrisus ipsum sollicitudin sem</li>
<li style="text-align: left;">Semper tempus diam nibh sed lacus.</li>
</ul>
<p style="text-align: left;">Morbi tincidunt ullamcorper libero sed dapibus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Donec aliquet odio nulla, eget vulputate purus. Nullam lobortis eleifend mauris, vel dictum tortor tempus et. Pellentesque eu augue magna, ac gravida dolor. Ut ipsum eros, mollis pulvinar interdum at, sodales eu tortor.</p>', N'<p style="text-align: left;">Morbi at ipsum ut eros mattis tincidunt. Etiam id arcu sit amet est mattis porttitor molestie vel mi. Cras ipsum dui, egestas id accumsan a, consequat in nibh. Suspendisse potenti. Suspendisse non est eget lectus tempus gravida elementum eu sapien.</p>', N'0', N'1', N'0', N'1', N'10', N'2011-11-08 15:18:26.000', N'<p>Quisque rutrum felis nulla, quis viverra sem. Nam nec lorem leo. Nulla lectus arcu, hendrerit id tempus nec, mollis non massa.</p>', N'Photography, Hobbies, Video', N'Sorry, Out Of Stock', N'');
;
INSERT INTO [dbo].[cw_products] ([product_id], [product_merchant_product_id], [product_name], [product_description], [product_preview_description], [product_sort], [product_on_web], [product_archive], [product_ship_charge], [product_tax_group_id], [product_date_modified], [product_special_description], [product_keywords], [product_out_of_stock_message], [product_custom_info_label]) VALUES (N'106', N'RuggedRugby', N'Rugged Rugby', N'<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus molestie nisi vel orci ultricies volutpat. Nullam lacinia mi vel sapien tincidunt ornare. Aliquam tempus lectus eget turpis pulvinar tincidunt. Nullam sit amet consectetur risus.</p>
<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam pharetra, enim quis varius dignissim, erat magna suscipit ipsum, vel pulvinar sapien augue vel enim. Ut ac sagittis enim. Nulla massa odio, accumsan at consequat id, varius a dolor. Nam non nibh ut massa dictum congue.</p>
<p>Duis quis ligula in turpis facilisis ultrices. Morbi porta mi quis ligula malesuada eget posuere risus congue. Nullam cursus eleifend molestie. Mauris eleifend venenatis convallis.</p>
<p>Pellentesque dapibus, odio eu venenatis faucibus, mi justo venenatis metus, quis cursus odio dui id felis. Sed interdum nisi sit amet nisi fermentum volutpat. Ut eget nisl sapien, ut pellentesque turpis. Etiam magna velit, aliquam volutpat pellentesque vitae, varius vitae ipsum. Fusce elementum hendrerit nibh vel tempor.</p>
<p>Ut dignissim sapien vel lectus suscipit dignissim.</p>', N'<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus molestie nisi vel orci ultricies volutpat. Nullam lacinia mi vel sapien tincidunt ornare. Aliquam tempus lectus eget turpis pulvinar tincidunt. Nullam sit amet consectetur risus.</p>', N'0', N'1', N'0', N'1', N'14', N'2011-12-16 11:26:10.000', N'<p>In hac habitasse platea dictumst. Etiam faucibus interdum nisi sed imperdiet. Sed tempus risus risus. Pellentesque vitae arcu odio. Pellentesque purus magna, feugiat et sodales eget, pretium non metus.</p>', N'Cotton Rugby Shirts, Cotton Sport Shirts', N'Sorry, Out Of Stock', N'');
;
INSERT INTO [dbo].[cw_products] ([product_id], [product_merchant_product_id], [product_name], [product_description], [product_preview_description], [product_sort], [product_on_web], [product_archive], [product_ship_charge], [product_tax_group_id], [product_date_modified], [product_special_description], [product_keywords], [product_out_of_stock_message], [product_custom_info_label]) VALUES (N'107', N'KomfyKhakis', N'Komfy Khakis', N'<p style="text-align: left;">Pellentesque consectetur nisl et lacus tincidunt vel euismod turpis  adipiscing. Maecenas molestie turpis et quam pulvinar eget ornare nisi  consectetur.</p>
<p style="text-align: left;">Aliquam vehicula scelerisque dolor, in imperdiet nisi  consequat eget. Mauris et felis semper quam feugiat ultricies in  adipiscing risus.</p>', N'<p style="text-align: left;">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis a arcu  magna, et egestas lorem. Vivamus porta arcu vel massa adipiscing  egestas.</p>', N'0', N'1', N'0', N'1', N'14', N'2010-07-05 15:18:50.000', N'<p style="text-align: left;">&nbsp;Maecenas molestie turpis et quam pulvinar eget ornare nisi  consectetur. Aliquam vehicula scelerisque dolor, in imperdiet nisi  consequat eget.</p>', N'Komfy Khakis, Canvas Pants', N'Sorry, Out Of Stock', N'');
;
INSERT INTO [dbo].[cw_products] ([product_id], [product_merchant_product_id], [product_name], [product_description], [product_preview_description], [product_sort], [product_on_web], [product_archive], [product_ship_charge], [product_tax_group_id], [product_date_modified], [product_special_description], [product_keywords], [product_out_of_stock_message], [product_custom_info_label]) VALUES (N'108', N'RetroTV', N'Ultimate Retro TV', N'<p>Nunc at varius lectus. Fusce ullamcorper, dui nec volutpat mollis, nulla quam lobortis magna, et fringilla leo diam id ante. Nunc ornare, nulla nec tempor adipiscing, ipsum turpis pulvinar mi, nec iaculis arcu dolor nec orci. Proin velit nisl, semper vitae vestibulum eget, adipiscing quis augue. Praesent gravida, magna vitae commodo elementum, neque ante eleifend urna, tempus luctus turpis quam a risus. Nam nec metus ac arcu tempor accumsan in sed neque. Phasellus posuere, nisi a rhoncus viverra, risus purus rutrum nisl, accumsan laoreet nisl est in purus. </p>
<p><strong>Duis vulputate placerat tellus a laoreet. </strong></p>
<ul>
<li>Aliquam rhoncus malesuada mollis. <br /></li>
<li>Maecenas facilisis consectetur eleifend. <br /></li>
<li>Vivamus magna lacus, dignissim id ornare sit amet, accumsan at tortor. </li>
</ul>
<p>Mauris quam tellus, pellentesque vel pretium et, convallis quis purus. Quisque at porta ipsum. Maecenas laoreet eros id dolor mollis porta.</p>', N'<p>Proin at velit urna. Cras molestie, ligula sit amet vestibulum tincidunt, nulla diam imperdiet justo, tincidunt hendrerit nisl massa id risus. Phasellus consequat dapibus blandit. Nam eu quam eget purus fringilla posuere. Cras tempus tempor quam</p>', N'0', N'1', N'0', N'1', N'10', N'2011-03-09 23:01:38.000', N'<p>Cras tempus tempor quam, nec posuere arcu malesuada sed.</p>', N'TV, Video, Retro', N'Sorry, Out Of Stock', N'');
;
INSERT INTO [dbo].[cw_products] ([product_id], [product_merchant_product_id], [product_name], [product_description], [product_preview_description], [product_sort], [product_on_web], [product_archive], [product_ship_charge], [product_tax_group_id], [product_date_modified], [product_special_description], [product_keywords], [product_out_of_stock_message], [product_custom_info_label]) VALUES (N'109', N'DigitalPoint-n-ShootCamera', N'Digital Point & Shoot Camera', N'<p>Pellentesque consectetur nisl et lacus tincidunt vel euismod turpis adipiscing. Maecenas molestie turpis et quam pulvinar eget ornare nisi consectetur.</p>
<p>Aliquam vehicula scelerisque dolor, in imperdiet nisi consequat eget. Mauris et felis semper quam feugiat ultricies in adipiscing risus. Proin feugiat arcu quis risus posuere dignissim. Etiam lacinia justo ac risus pretium cursus.</p>
<ul>
<li>Vestibulum mattis condimentum tincidunt.</li>
<li>Aliquam convallis, ante eu posuere molestie,</li>
<li>Rrisus ipsum sollicitudin sem</li>
<li>Semper tempus diam nibh sed lacus.</li>
</ul>
<p>Morbi tincidunt ullamcorper libero sed dapibus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Donec aliquet odio nulla, eget vulputate purus. Nullam lobortis eleifend mauris, vel dictum tortor tempus et. Pellentesque eu augue magna, ac gravida dolor. Ut ipsum eros, mollis pulvinar interdum at, sodales eu tortor.</p>
<p>Aliquam erat volutpat. Vestibulum et purus sed dui ornare fermentum vitae id tortor. Ut elementum auctor turpis, ornare feugiat tortor ultricies interdum.</p>', N'<p>Morbi at ipsum ut eros mattis tincidunt. Etiam id arcu sit amet est mattis porttitor molestie vel mi. Cras ipsum dui, egestas id accumsan a, consequat in nibh. Suspendisse potenti. Suspendisse non est eget lectus tempus gravida elementum eu sapien.</p>', N'0', N'1', N'0', N'1', N'10', N'2011-12-16 11:22:27.000', N'<p>Quisque rutrum felis nulla, quis viverra sem. Nam nec lorem leo. Nulla lectus arcu, hendrerit id tempus nec, mollis non massa.</p>', N'Photography, Hobbies', N'Sorry, Out Of Stock', N'');
;
INSERT INTO [dbo].[cw_products] ([product_id], [product_merchant_product_id], [product_name], [product_description], [product_preview_description], [product_sort], [product_on_web], [product_archive], [product_ship_charge], [product_tax_group_id], [product_date_modified], [product_special_description], [product_keywords], [product_out_of_stock_message], [product_custom_info_label]) VALUES (N'110', N'LawnPower-Ride', N'LawnPower Ride Lawn Mower', N'<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut venenatis auctor pulvinar. Vivamus porta elit at tellus rhoncus ornare.</p>
<ul>
<li>Vivamus porttitor elit et mauris porttitor quis blandit sem viverra.</li>
<li>Vivamus ultricies velit vitae dui vestibulum ultrices. Aenean pretium velit in ipsum sodales fermentum. </li>
<li>Quisque nec justo lectus, sed varius eros. Morbi a erat a lectus semper molestie eget eu libero.&nbsp;</li>
</ul>
<p>Suspendisse metus nulla, aliquet eu sollicitudin non, condimentum quis tellus.</p>
<p><strong>Vivamus sit amet ligula in ligula ultricies pellentesque.</strong></p>
<p>Quisque porttitor mollis mauris, vitae porttitor sapien venenatis et. In eu diam purus. In hac habitasse platea dictumst.</p>', N'<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut venenatis auctor pulvinar.</p>', N'0', N'1', N'0', N'0', N'10', N'2011-07-20 10:08:02.000', N'<p>Vivamus porttitor elit et mauris porttitor quis blandit sem viverra. Vivamus ultricies velit vitae dui vestibulum ultrices. Aenean pretium velit in ipsum sodales fermentum.</p>
<p>Quisque nec justo lectus, sed varius eros.</p>', N'Yard Tools, Landscaping, power tools', N'Sorry, Out Of Stock', N'');
;
INSERT INTO [dbo].[cw_products] ([product_id], [product_merchant_product_id], [product_name], [product_description], [product_preview_description], [product_sort], [product_on_web], [product_archive], [product_ship_charge], [product_tax_group_id], [product_date_modified], [product_special_description], [product_keywords], [product_out_of_stock_message], [product_custom_info_label]) VALUES (N'111', N'LawnPower-Push', N'LawnPower Push Lawn Mower', N'<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut venenatis auctor pulvinar. Vivamus porta elit at tellus rhoncus ornare.</p>
<ul>
<li>Vivamus porttitor elit et mauris porttitor quis blandit sem viverra.</li>
<li>Vivamus ultricies velit vitae dui vestibulum ultrices. Aenean pretium velit in ipsum sodales fermentum. </li>
<li>Quisque nec justo lectus, sed varius eros. Morbi a erat a lectus semper molestie eget eu libero.&nbsp;</li>
</ul>
<p>Suspendisse metus nulla, aliquet eu sollicitudin non, condimentum quis tellus.</p>
<p><strong>Vivamus sit amet ligula in ligula ultricies pellentesque.</strong></p>
<p>Quisque porttitor mollis mauris, vitae porttitor sapien venenatis et. In eu diam purus. In hac habitasse platea dictumst.</p>', N'<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut venenatis auctor pulvinar.</p>', N'0', N'1', N'0', N'1', N'10', N'2010-07-06 15:48:16.000', N'<p>Vivamus porttitor elit et mauris porttitor quis blandit sem viverra. Vivamus ultricies velit vitae dui vestibulum ultrices. Aenean pretium velit in ipsum sodales fermentum.</p>
<p>Quisque nec justo lectus, sed varius eros.</p>', N'Yard Tools, Landscaping, power tools', N'Sorry, Out Of Stock', N'');
;
INSERT INTO [dbo].[cw_products] ([product_id], [product_merchant_product_id], [product_name], [product_description], [product_preview_description], [product_sort], [product_on_web], [product_archive], [product_ship_charge], [product_tax_group_id], [product_date_modified], [product_special_description], [product_keywords], [product_out_of_stock_message], [product_custom_info_label]) VALUES (N'112', N'WeedAWack', N'WeedAWack Weed Trimmer', N'<p>Aliquam tristique, enim ut elementum pulvinar, justo diam pharetra urna, non adipiscing mi tellus in sapien. Nulla a lectus id sem accumsan dictum id et lorem.</p>
<p><strong>Vestibulum metus orci,</strong></p>
<p>consequat eu viverra et, consequat vitae elit. Pellentesque luctus, est vel ullamcorper gravida, ante sem volutpat libero, et lacinia dolor ligula eleifend quam. Aenean hendrerit luctus consequat. Duis pulvinar lorem at nisi malesuada dignissim. Cras vel posuere metus. Proin ante ligula, pharetra non lobortis in, lobortis sed arcu. Phasellus ac dolor nec tellus dictum pharetra.</p>
<ol>
<li>Aliquam auctor convallis euismod. </li>
<li>Curabitur et leo at mi porta mattis a sed nunc.&nbsp;</li>
</ol>
<p>Nulla sed ligula libero. Nulla eu quam neque. Integer ultricies, lectus id condimentum ullamcorper, dui erat vestibulum mauris, eget ornare neque mi id tortor. Cras lobortis vehicula commodo. Morbi sodales ornare semper. In placerat gravida sem, sed pulvinar arcu cursus eget.</p>
<p><strong>Donec eget</strong></p>
<p>Donec eget risus ac sapien vestibulum euismod. Quisque quis eros urna, vel posuere lectus</p>', N'<p>Curabitur et leo at mi porta mattis a sed nunc. Nulla sed ligula libero. Nulla eu quam neque. Integer ultricies, lectus id condimentum ullamcorper, dui erat vestibulum mauris, eget ornare neque mi id tortor. Cras lobortis vehicula commodo. Morbi sodales ornare semper. In placerat gravida sem,</p>', N'0', N'1', N'0', N'1', N'10', N'2010-07-06 15:56:24.000', N'<p>Curabitur et leo at mi porta mattis a sed nunc. Nulla sed ligula libero. Nulla eu quam neque. Integer ultricies, lectus id condimentum ullamcorper,</p>', N'Weed Eater, Edge Trimmer, Fish-line Trimmer', N'Sorry, Out Of Stock', N'');
;
SET IDENTITY_INSERT [dbo].[cw_products] OFF
;

-- ----------------------------
-- Table structure for [dbo].[cw_ship_method_countries]
-- ----------------------------
IF OBJECT_ID('[dbo].[cw_ship_method_countries]') IS NOT NULL DROP TABLE [dbo].[cw_ship_method_countries]
;
CREATE TABLE [dbo].[cw_ship_method_countries] (
[ship_method_country_id] int NOT NULL IDENTITY(1,1) ,
[ship_method_country_method_id] int NULL DEFAULT '0',
[ship_method_country_country_id] int NULL DEFAULT '0' 
)


;
DBCC CHECKIDENT(N'[dbo].[cw_ship_method_countries]', RESEED, 36)
;

-- ----------------------------
-- Records of cw_ship_method_countries
-- ----------------------------
SET IDENTITY_INSERT [dbo].[cw_ship_method_countries] ON
;
INSERT INTO [dbo].[cw_ship_method_countries] ([ship_method_country_id], [ship_method_country_method_id], [ship_method_country_country_id]) VALUES (N'1', N'35', N'1');
;
INSERT INTO [dbo].[cw_ship_method_countries] ([ship_method_country_id], [ship_method_country_method_id], [ship_method_country_country_id]) VALUES (N'4', N'76', N'2');
;
INSERT INTO [dbo].[cw_ship_method_countries] ([ship_method_country_id], [ship_method_country_method_id], [ship_method_country_country_id]) VALUES (N'7', N'65', N'3');
;
INSERT INTO [dbo].[cw_ship_method_countries] ([ship_method_country_id], [ship_method_country_method_id], [ship_method_country_country_id]) VALUES (N'9', N'74', N'5');
;
INSERT INTO [dbo].[cw_ship_method_countries] ([ship_method_country_id], [ship_method_country_method_id], [ship_method_country_country_id]) VALUES (N'13', N'79', N'1');
;
INSERT INTO [dbo].[cw_ship_method_countries] ([ship_method_country_id], [ship_method_country_method_id], [ship_method_country_country_id]) VALUES (N'16', N'82', N'2');
;
INSERT INTO [dbo].[cw_ship_method_countries] ([ship_method_country_id], [ship_method_country_method_id], [ship_method_country_country_id]) VALUES (N'30', N'96', N'5');
;
INSERT INTO [dbo].[cw_ship_method_countries] ([ship_method_country_id], [ship_method_country_method_id], [ship_method_country_country_id]) VALUES (N'32', N'98', N'1');
;
INSERT INTO [dbo].[cw_ship_method_countries] ([ship_method_country_id], [ship_method_country_method_id], [ship_method_country_country_id]) VALUES (N'33', N'99', N'1');
;
INSERT INTO [dbo].[cw_ship_method_countries] ([ship_method_country_id], [ship_method_country_method_id], [ship_method_country_country_id]) VALUES (N'34', N'100', N'12');
;
INSERT INTO [dbo].[cw_ship_method_countries] ([ship_method_country_id], [ship_method_country_method_id], [ship_method_country_country_id]) VALUES (N'35', N'101', N'1');
;
INSERT INTO [dbo].[cw_ship_method_countries] ([ship_method_country_id], [ship_method_country_method_id], [ship_method_country_country_id]) VALUES (N'36', N'102', N'1');
;
INSERT INTO [dbo].[cw_ship_method_countries] ([ship_method_country_id], [ship_method_country_method_id], [ship_method_country_country_id]) VALUES (N'37', N'103', N'1');
;
INSERT INTO [dbo].[cw_ship_method_countries] ([ship_method_country_id], [ship_method_country_method_id], [ship_method_country_country_id]) VALUES (N'38', N'104', N'1');
;
INSERT INTO [dbo].[cw_ship_method_countries] ([ship_method_country_id], [ship_method_country_method_id], [ship_method_country_country_id]) VALUES (N'39', N'105', N'1');
;
SET IDENTITY_INSERT [dbo].[cw_ship_method_countries] OFF
;

-- ----------------------------
-- Table structure for [dbo].[cw_ship_methods]
-- ----------------------------
IF OBJECT_ID('[dbo].[cw_ship_methods]') IS NOT NULL DROP TABLE [dbo].[cw_ship_methods]
;
CREATE TABLE [dbo].[cw_ship_methods] (
[ship_method_id] int NOT NULL IDENTITY(1,1) ,
[ship_method_name] nvarchar(255) NULL ,
[ship_method_rate] float(53) NULL ,
[ship_method_sort] float(53) NULL DEFAULT '1.00',
[ship_method_archive] int NULL DEFAULT '0',
[ship_method_calctype] nvarchar(165) NULL 
)


;
DBCC CHECKIDENT(N'[dbo].[cw_ship_methods]', RESEED, 102)
;

-- ----------------------------
-- Records of cw_ship_methods
-- ----------------------------
SET IDENTITY_INSERT [dbo].[cw_ship_methods] ON
;
INSERT INTO [dbo].[cw_ship_methods] ([ship_method_id], [ship_method_name], [ship_method_rate], [ship_method_sort], [ship_method_archive], [ship_method_calctype]) VALUES (N'35', N'UPS Ground', N'0', N'1', N'1', N'upsgroundcalc');
;
INSERT INTO [dbo].[cw_ship_methods] ([ship_method_id], [ship_method_name], [ship_method_rate], [ship_method_sort], [ship_method_archive], [ship_method_calctype]) VALUES (N'65', N'Canadian UPS', N'5', N'4', N'0', null);
;
INSERT INTO [dbo].[cw_ship_methods] ([ship_method_id], [ship_method_name], [ship_method_rate], [ship_method_sort], [ship_method_archive], [ship_method_calctype]) VALUES (N'66', N'International UPS', N'28', N'5', N'0', null);
;
INSERT INTO [dbo].[cw_ship_methods] ([ship_method_id], [ship_method_name], [ship_method_rate], [ship_method_sort], [ship_method_archive], [ship_method_calctype]) VALUES (N'73', N'USPS', N'4', N'6', N'0', null);
;
INSERT INTO [dbo].[cw_ship_methods] ([ship_method_id], [ship_method_name], [ship_method_rate], [ship_method_sort], [ship_method_archive], [ship_method_calctype]) VALUES (N'74', N'Securicor', N'15', N'5', N'1', null);
;
INSERT INTO [dbo].[cw_ship_methods] ([ship_method_id], [ship_method_name], [ship_method_rate], [ship_method_sort], [ship_method_archive], [ship_method_calctype]) VALUES (N'76', N'USA Territories UPS', N'14.5', N'0', N'0', null);
;
INSERT INTO [dbo].[cw_ship_methods] ([ship_method_id], [ship_method_name], [ship_method_rate], [ship_method_sort], [ship_method_archive], [ship_method_calctype]) VALUES (N'79', N'UPS Ground', N'5', N'1', N'0', N'localcalc');
;
INSERT INTO [dbo].[cw_ship_methods] ([ship_method_id], [ship_method_name], [ship_method_rate], [ship_method_sort], [ship_method_archive], [ship_method_calctype]) VALUES (N'82', N'Mountain Bike', N'123.4', N'0', N'1', null);
;
INSERT INTO [dbo].[cw_ship_methods] ([ship_method_id], [ship_method_name], [ship_method_rate], [ship_method_sort], [ship_method_archive], [ship_method_calctype]) VALUES (N'96', N'DHL', N'5', N'1', N'0', null);
;
INSERT INTO [dbo].[cw_ship_methods] ([ship_method_id], [ship_method_name], [ship_method_rate], [ship_method_sort], [ship_method_archive], [ship_method_calctype]) VALUES (N'98', N'UPS 3-Day Select', N'0', N'1.5', N'1', N'ups3daycalc');
;
INSERT INTO [dbo].[cw_ship_methods] ([ship_method_id], [ship_method_name], [ship_method_rate], [ship_method_sort], [ship_method_archive], [ship_method_calctype]) VALUES (N'99', N'UPS Next Day Air', N'0', N'1.8', N'1', N'upsnextdaycalc');
;
INSERT INTO [dbo].[cw_ship_methods] ([ship_method_id], [ship_method_name], [ship_method_rate], [ship_method_sort], [ship_method_archive], [ship_method_calctype]) VALUES (N'100', N'Ireland Courier', N'0', N'0', N'0', N'localcalc');
;
INSERT INTO [dbo].[cw_ship_methods] ([ship_method_id], [ship_method_name], [ship_method_rate], [ship_method_sort], [ship_method_archive], [ship_method_calctype]) VALUES (N'101', N'UPS Two Day', N'6.5', N'2', N'1', N'localcalc');
;
INSERT INTO [dbo].[cw_ship_methods] ([ship_method_id], [ship_method_name], [ship_method_rate], [ship_method_sort], [ship_method_archive], [ship_method_calctype]) VALUES (N'102', N'UPS Next Day Air', N'8', N'3', N'0', N'localcalc');
;
INSERT INTO [dbo].[cw_ship_methods] ([ship_method_id], [ship_method_name], [ship_method_rate], [ship_method_sort], [ship_method_archive], [ship_method_calctype]) VALUES (N'103', N'FedEx Ground', N'0', N'4.000', N'1', N'fedexgroundcalc');
;
INSERT INTO [dbo].[cw_ship_methods] ([ship_method_id], [ship_method_name], [ship_method_rate], [ship_method_sort], [ship_method_archive], [ship_method_calctype]) VALUES (N'104', N'FedEx Standard Overnight', N'0', N'4.200', N'1', N'fedexstandardovernightcalc');
;
INSERT INTO [dbo].[cw_ship_methods] ([ship_method_id], [ship_method_name], [ship_method_rate], [ship_method_sort], [ship_method_archive], [ship_method_calctype]) VALUES (N'105', N'FedEx Two Day', N'0', N'4.4', N'1', N'fedex2daycalc');
;
SET IDENTITY_INSERT [dbo].[cw_ship_methods] OFF
;

-- ----------------------------
-- Table structure for [dbo].[cw_ship_ranges]
-- ----------------------------
IF OBJECT_ID('[dbo].[cw_ship_ranges]') IS NOT NULL DROP TABLE [dbo].[cw_ship_ranges]
;
CREATE TABLE [dbo].[cw_ship_ranges] (
[ship_range_id] int NOT NULL IDENTITY(1,1) ,
[ship_range_method_id] int NULL DEFAULT '0',
[ship_range_from] float(53) NULL DEFAULT '0',
[ship_range_to] float(53) NULL DEFAULT '0',
[ship_range_amount] float(53) NULL DEFAULT '0' 
)


;
DBCC CHECKIDENT(N'[dbo].[cw_ship_ranges]', RESEED, 87)
;

-- ----------------------------
-- Records of cw_ship_ranges
-- ----------------------------
SET IDENTITY_INSERT [dbo].[cw_ship_ranges] ON
;
INSERT INTO [dbo].[cw_ship_ranges] ([ship_range_id], [ship_range_method_id], [ship_range_from], [ship_range_to], [ship_range_amount]) VALUES (N'13', N'65', N'0', N'5', N'19');
;
INSERT INTO [dbo].[cw_ship_ranges] ([ship_range_id], [ship_range_method_id], [ship_range_from], [ship_range_to], [ship_range_amount]) VALUES (N'14', N'65', N'5.01', N'10', N'29');
;
INSERT INTO [dbo].[cw_ship_ranges] ([ship_range_id], [ship_range_method_id], [ship_range_from], [ship_range_to], [ship_range_amount]) VALUES (N'15', N'65', N'10.01', N'20', N'39');
;
INSERT INTO [dbo].[cw_ship_ranges] ([ship_range_id], [ship_range_method_id], [ship_range_from], [ship_range_to], [ship_range_amount]) VALUES (N'16', N'65', N'20.01', N'10000000', N'49');
;
INSERT INTO [dbo].[cw_ship_ranges] ([ship_range_id], [ship_range_method_id], [ship_range_from], [ship_range_to], [ship_range_amount]) VALUES (N'17', N'66', N'0', N'5', N'21');
;
INSERT INTO [dbo].[cw_ship_ranges] ([ship_range_id], [ship_range_method_id], [ship_range_from], [ship_range_to], [ship_range_amount]) VALUES (N'18', N'66', N'5.01', N'10', N'31');
;
INSERT INTO [dbo].[cw_ship_ranges] ([ship_range_id], [ship_range_method_id], [ship_range_from], [ship_range_to], [ship_range_amount]) VALUES (N'19', N'66', N'10.01', N'20', N'41');
;
INSERT INTO [dbo].[cw_ship_ranges] ([ship_range_id], [ship_range_method_id], [ship_range_from], [ship_range_to], [ship_range_amount]) VALUES (N'20', N'66', N'20.01', N'10000000', N'51');
;
INSERT INTO [dbo].[cw_ship_ranges] ([ship_range_id], [ship_range_method_id], [ship_range_from], [ship_range_to], [ship_range_amount]) VALUES (N'56', N'79', N'0', N'100', N'9.99');
;
INSERT INTO [dbo].[cw_ship_ranges] ([ship_range_id], [ship_range_method_id], [ship_range_from], [ship_range_to], [ship_range_amount]) VALUES (N'57', N'79', N'100.01', N'200', N'22.99');
;
INSERT INTO [dbo].[cw_ship_ranges] ([ship_range_id], [ship_range_method_id], [ship_range_from], [ship_range_to], [ship_range_amount]) VALUES (N'58', N'79', N'200.01', N'300', N'34.99');
;
INSERT INTO [dbo].[cw_ship_ranges] ([ship_range_id], [ship_range_method_id], [ship_range_from], [ship_range_to], [ship_range_amount]) VALUES (N'64', N'96', N'0', N'21', N'7.5');
;
INSERT INTO [dbo].[cw_ship_ranges] ([ship_range_id], [ship_range_method_id], [ship_range_from], [ship_range_to], [ship_range_amount]) VALUES (N'65', N'96', N'25.01', N'99', N'12.5');
;
INSERT INTO [dbo].[cw_ship_ranges] ([ship_range_id], [ship_range_method_id], [ship_range_from], [ship_range_to], [ship_range_amount]) VALUES (N'66', N'96', N'99.01', N'999999', N'17.5');
;
INSERT INTO [dbo].[cw_ship_ranges] ([ship_range_id], [ship_range_method_id], [ship_range_from], [ship_range_to], [ship_range_amount]) VALUES (N'68', N'35', N'0', N'20', N'5.99');
;
INSERT INTO [dbo].[cw_ship_ranges] ([ship_range_id], [ship_range_method_id], [ship_range_from], [ship_range_to], [ship_range_amount]) VALUES (N'69', N'35', N'20.01', N'30', N'15.99');
;
INSERT INTO [dbo].[cw_ship_ranges] ([ship_range_id], [ship_range_method_id], [ship_range_from], [ship_range_to], [ship_range_amount]) VALUES (N'70', N'35', N'30.01', N'50', N'18.99');
;
INSERT INTO [dbo].[cw_ship_ranges] ([ship_range_id], [ship_range_method_id], [ship_range_from], [ship_range_to], [ship_range_amount]) VALUES (N'71', N'35', N'50.01', N'9999999', N'20');
;
INSERT INTO [dbo].[cw_ship_ranges] ([ship_range_id], [ship_range_method_id], [ship_range_from], [ship_range_to], [ship_range_amount]) VALUES (N'72', N'35', N'200.01', N'500', N'55');
;
INSERT INTO [dbo].[cw_ship_ranges] ([ship_range_id], [ship_range_method_id], [ship_range_from], [ship_range_to], [ship_range_amount]) VALUES (N'73', N'79', N'300.01', N'420', N'50');
;
INSERT INTO [dbo].[cw_ship_ranges] ([ship_range_id], [ship_range_method_id], [ship_range_from], [ship_range_to], [ship_range_amount]) VALUES (N'74', N'79', N'420.01', N'100000000', N'99.99');
;
INSERT INTO [dbo].[cw_ship_ranges] ([ship_range_id], [ship_range_method_id], [ship_range_from], [ship_range_to], [ship_range_amount]) VALUES (N'77', N'100', N'0', N'99999', N'34');
;
INSERT INTO [dbo].[cw_ship_ranges] ([ship_range_id], [ship_range_method_id], [ship_range_from], [ship_range_to], [ship_range_amount]) VALUES (N'78', N'101', N'0', N'100', N'22');
;
INSERT INTO [dbo].[cw_ship_ranges] ([ship_range_id], [ship_range_method_id], [ship_range_from], [ship_range_to], [ship_range_amount]) VALUES (N'79', N'101', N'100.01', N'200', N'33');
;
INSERT INTO [dbo].[cw_ship_ranges] ([ship_range_id], [ship_range_method_id], [ship_range_from], [ship_range_to], [ship_range_amount]) VALUES (N'80', N'101', N'200.01', N'300', N'45');
;
INSERT INTO [dbo].[cw_ship_ranges] ([ship_range_id], [ship_range_method_id], [ship_range_from], [ship_range_to], [ship_range_amount]) VALUES (N'81', N'101', N'300.01', N'400', N'60');
;
INSERT INTO [dbo].[cw_ship_ranges] ([ship_range_id], [ship_range_method_id], [ship_range_from], [ship_range_to], [ship_range_amount]) VALUES (N'82', N'102', N'0', N'100', N'35');
;
INSERT INTO [dbo].[cw_ship_ranges] ([ship_range_id], [ship_range_method_id], [ship_range_from], [ship_range_to], [ship_range_amount]) VALUES (N'83', N'102', N'100.01', N'200', N'55');
;
INSERT INTO [dbo].[cw_ship_ranges] ([ship_range_id], [ship_range_method_id], [ship_range_from], [ship_range_to], [ship_range_amount]) VALUES (N'84', N'102', N'200.01', N'300', N'75');
;
INSERT INTO [dbo].[cw_ship_ranges] ([ship_range_id], [ship_range_method_id], [ship_range_from], [ship_range_to], [ship_range_amount]) VALUES (N'85', N'102', N'300.01', N'400', N'95');
;
INSERT INTO [dbo].[cw_ship_ranges] ([ship_range_id], [ship_range_method_id], [ship_range_from], [ship_range_to], [ship_range_amount]) VALUES (N'86', N'101', N'400.01', N'100000000', N'120');
;
INSERT INTO [dbo].[cw_ship_ranges] ([ship_range_id], [ship_range_method_id], [ship_range_from], [ship_range_to], [ship_range_amount]) VALUES (N'87', N'102', N'400.01', N'100000000', N'125');
;
SET IDENTITY_INSERT [dbo].[cw_ship_ranges] OFF
;

-- ----------------------------
-- Table structure for [dbo].[cw_sku_options]
-- ----------------------------
IF OBJECT_ID('[dbo].[cw_sku_options]') IS NOT NULL DROP TABLE [dbo].[cw_sku_options]
;
CREATE TABLE [dbo].[cw_sku_options] (
[sku_option_id] int NOT NULL IDENTITY(1,1) ,
[sku_option2sku_id] int NULL DEFAULT '0',
[sku_option2option_id] int NULL DEFAULT '0'
)


;
DBCC CHECKIDENT(N'[dbo].[cw_sku_options]', RESEED, 2615)
;

-- ----------------------------
-- Records of cw_sku_options
-- ----------------------------
SET IDENTITY_INSERT [dbo].[cw_sku_options] ON
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'1727', N'187', N'139');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'1728', N'187', N'130');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'1729', N'187', N'136');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'1730', N'187', N'127');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'1731', N'187', N'133');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'1732', N'187', N'142');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'1739', N'188', N'131');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'1740', N'188', N'134');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'1741', N'188', N'128');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'1742', N'188', N'140');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'1743', N'188', N'142');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'1744', N'188', N'137');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'1857', N'217', N'150');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'1858', N'216', N'151');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'1864', N'219', N'108');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'1865', N'220', N'109');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'1866', N'221', N'110');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'1868', N'222', N'111');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'1869', N'223', N'119');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'1871', N'224', N'153');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'1873', N'225', N'120');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'1874', N'226', N'154');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'1875', N'227', N'121');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'1876', N'228', N'155');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'1877', N'229', N'114');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'1878', N'230', N'115');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'1879', N'231', N'113');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'1902', N'239', N'115');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'1903', N'239', N'159');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'1904', N'240', N'159');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'1905', N'240', N'114');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'1906', N'241', N'160');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'1907', N'241', N'115');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'1908', N'242', N'160');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'1909', N'242', N'114');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'1914', N'244', N'113');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'1915', N'244', N'158');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'1916', N'243', N'158');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'1917', N'243', N'115');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'1918', N'245', N'159');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'1919', N'245', N'115');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'1922', N'246', N'159');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'1923', N'246', N'113');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'1924', N'247', N'156');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'1925', N'248', N'157');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2308', N'202', N'148');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2309', N'202', N'113');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2310', N'210', N'148');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2311', N'210', N'152');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2312', N'205', N'151');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2313', N'205', N'113');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2314', N'209', N'114');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2315', N'209', N'151');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2316', N'213', N'152');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2317', N'213', N'151');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2318', N'204', N'150');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2319', N'204', N'113');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2320', N'208', N'114');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2321', N'208', N'150');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2322', N'212', N'152');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2323', N'212', N'150');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2324', N'203', N'113');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2325', N'203', N'149');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2327', N'232', N'113');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2330', N'165', N'115');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2331', N'165', N'109');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2332', N'164', N'110');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2333', N'164', N'114');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2334', N'163', N'114');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2335', N'163', N'109');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2336', N'162', N'108');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2337', N'162', N'114');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2338', N'161', N'113');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2339', N'161', N'111');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2340', N'160', N'110');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2341', N'160', N'113');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2342', N'159', N'113');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2343', N'159', N'109');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2344', N'158', N'108');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2345', N'158', N'113');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2350', N'233', N'115');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2507', N'184', N'139');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2508', N'184', N'142');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2509', N'184', N'130');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2510', N'184', N'136');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2511', N'184', N'127');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2512', N'184', N'133');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2513', N'185', N'137');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2514', N'185', N'139');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2515', N'185', N'134');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2516', N'185', N'128');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2517', N'185', N'131');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2518', N'185', N'142');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2519', N'186', N'140');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2520', N'186', N'130');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2521', N'186', N'142');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2522', N'186', N'129');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2523', N'186', N'135');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2524', N'186', N'138');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2555', N'167', N'117');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2556', N'167', N'119');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2557', N'167', N'168');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2558', N'168', N'169');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2559', N'168', N'117');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2560', N'168', N'120');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2561', N'169', N'168');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2562', N'169', N'117');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2563', N'169', N'121');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2564', N'170', N'119');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2565', N'170', N'118');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2566', N'170', N'168');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2567', N'171', N'120');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2568', N'171', N'118');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2569', N'171', N'168');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2570', N'172', N'118');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2571', N'172', N'168');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2572', N'172', N'121');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2573', N'173', N'168');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2574', N'173', N'119');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2575', N'173', N'116');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2576', N'174', N'168');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2577', N'174', N'120');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2578', N'174', N'116');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2579', N'175', N'121');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2580', N'175', N'168');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2581', N'175', N'116');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2582', N'259', N'141');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2583', N'259', N'135');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2584', N'259', N'129');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2585', N'259', N'137');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2586', N'259', N'130');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2587', N'259', N'140');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2588', N'192', N'146');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2589', N'192', N'113');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2590', N'200', N'144');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2591', N'200', N'147');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2592', N'199', N'143');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2593', N'199', N'147');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2594', N'198', N'145');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2595', N'198', N'147');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2596', N'197', N'113');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2597', N'197', N'147');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2598', N'195', N'146');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2599', N'195', N'144');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2600', N'194', N'143');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2601', N'194', N'146');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2602', N'196', N'146');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2603', N'196', N'114');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2604', N'193', N'145');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2605', N'193', N'146');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2608', N'154', N'108');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2609', N'154', N'112');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2610', N'156', N'110');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2611', N'156', N'112');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2612', N'155', N'109');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2613', N'155', N'112');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2614', N'166', N'115');
;
INSERT INTO [dbo].[cw_sku_options] ([sku_option_id], [sku_option2sku_id], [sku_option2option_id]) VALUES (N'2615', N'166', N'110');
;
SET IDENTITY_INSERT [dbo].[cw_sku_options] OFF
;

-- ----------------------------
-- Table structure for [dbo].[cw_skus]
-- ----------------------------
IF OBJECT_ID('[dbo].[cw_skus]') IS NOT NULL DROP TABLE [dbo].[cw_skus]
;
CREATE TABLE [dbo].[cw_skus] (
[sku_id] int NOT NULL IDENTITY(1,1) ,
[sku_merchant_sku_id] nvarchar(150) NULL ,
[sku_product_id] int NULL DEFAULT '0',
[sku_price] float(53) NULL ,
[sku_weight] float(53) NULL DEFAULT '0',
[sku_stock] int NULL DEFAULT '0',
[sku_on_web] int NULL DEFAULT '1',
[sku_sort] float(53) NULL DEFAULT '1.00',
[sku_alt_price] float(53) NULL ,
[sku_ship_base] float(53) NULL ,
[sku_download_file] varchar(255) NULL ,
[sku_download_id] varchar(255) NULL ,
[sku_download_version] varchar(50) NULL ,
[sku_download_limit] int NULL DEFAULT '0' 
)


;
DBCC CHECKIDENT(N'[dbo].[cw_skus]', RESEED, 260)
;

-- ----------------------------
-- Records of cw_skus
-- ----------------------------
SET IDENTITY_INSERT [dbo].[cw_skus] ON
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'154', N'BriteT-Smll-Green', N'93', N'22.22', N'0.5', N'0', N'1', N'0', N'20.99', N'0', N'', N'', N'', N'0');
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'155', N'BriteT-mMedm-Green', N'93', N'22.5', N'0.5', N'70', N'1', N'0', N'25.99', N'0', N'', N'', N'', N'0');
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'156', N'BriteT-Lrg-Green', N'93', N'22.5', N'0.5', N'63', N'1', N'0', N'25.99', N'0', N'', N'', N'', N'0');
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'158', N'BriteT-Smll-Blue', N'93', N'22.5', N'0.5', N'0', N'1', N'0', N'25.99', N'0', N'', N'', N'', N'0');
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'159', N'BriteT-Medm-Blue', N'93', N'22.5', N'0.5', N'76', N'1', N'0', N'20.99', N'0', N'', N'', N'', N'0');
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'160', N'BriteT-Lrg-Blue', N'93', N'22.5', N'0.5', N'16', N'1', N'0', N'20.99', N'0', N'', N'', N'', N'0');
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'161', N'BriteT-XLrg-Blue', N'93', N'24.5', N'0.5', N'21', N'1', N'0', N'20.99', N'0', N'', N'', N'', N'0');
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'162', N'BriteT-Smll-Yellow', N'93', N'22.5', N'0.5', N'0', N'1', N'0', N'20.99', N'0', N'', N'', N'', N'0');
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'163', N'BriteT-Medm-Yellow', N'93', N'22.5', N'0.5', N'40', N'1', N'0', N'20.99', N'0', N'', N'', N'', N'0');
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'164', N'BriteT-Lrg-Yellow', N'93', N'22.5', N'0.5', N'58', N'1', N'0', N'20.99', N'0', N'', N'', N'', N'0');
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'165', N'BriteT-Medm-Red', N'93', N'22.5', N'0.5', N'0', N'1', N'0', N'20.99', N'0', N'', N'', N'', N'0');
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'166', N'BriteT-Lrg-Red', N'93', N'22.5', N'0.5', N'14', N'1', N'0', N'25.99', N'0', N'', N'', N'', N'0');
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'167', N'Jeans-Ind-Small', N'94', N'33.33', N'3.3', N'0', N'0', N'0', N'33.33', N'0', N'', N'', N'', N'0');
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'168', N'Jeans-Ind-Med', N'94', N'34', N'1.2', N'36', N'1', N'0', N'36', N'0', N'', N'', N'', N'0');
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'169', N'Jeans-Ind-Large', N'94', N'34', N'1.2', N'43', N'0', N'0', N'36', N'0', N'', N'', N'', N'0');
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'170', N'Jeans-Stone-Small', N'94', N'34', N'1.2', N'44', N'1', N'0', N'36', N'0', N'', N'', N'', N'0');
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'171', N'Jeans-Stone-Med', N'94', N'34', N'1.2', N'0', N'0', N'0', N'36', N'0', N'', N'', N'', N'0');
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'172', N'Jeans-Stone-Large', N'94', N'34', N'1.2', N'89', N'1', N'0', N'36', N'0', N'', N'', N'', N'0');
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'173', N'Jeans-MediumBlue-Small', N'94', N'34', N'1.2', N'59', N'1', N'0', N'36', N'0', N'', N'', N'', N'0');
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'174', N'Jeans-MediumBlue-Med', N'94', N'34', N'1.2', N'76', N'0', N'0', N'36', N'0', N'', N'', N'', N'0');
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'175', N'Jeans-MediumBlue-Large', N'94', N'34', N'1.2', N'62', N'1', N'0', N'36', N'0', N'', N'', N'', N'0');
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'176', N'SLR-Digital', N'95', N'869', N'4', N'492', N'1', N'0', N'926', N'0', N'', N'', N'', N'0');
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'177', N'BigScreenPlasma', N'96', N'1250', N'80', N'471', N'1', N'0', N'1450', N'55', N'', N'', N'', N'0');
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'184', N'Basic-Home-System', N'99', N'899.22', N'50', N'0', N'1', N'1', N'1045', N'0', N'', N'', N'', N'0');
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'185', N'Advanced-Home-System', N'99', N'999', N'45', N'0', N'1', N'2', N'1100', N'0', N'', N'', N'', N'0');
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'186', N'PowerUser-System', N'99', N'1155', N'45', N'0', N'1', N'3', N'1400', N'0', N'', N'', N'', N'0');
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'187', N'Basic-Home-User', N'100', N'990', N'5', N'971', N'1', N'1', N'1045', N'0', N'', N'', N'', N'0');
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'188', N'Advanced-System', N'100', N'1999', N'5', N'53', N'1', N'2', N'1400', N'0', N'', N'', N'', N'0');
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'192', N'BrightTerryTowels-Sml-blu', N'101', N'12', N'1', N'1000', N'1', N'1', N'14', N'0', N'', N'', N'', N'0');
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'193', N'BrightTerryTowels-Sml-orng', N'101', N'12', N'1', N'1000', N'1', N'1', N'14', N'0', N'', N'', N'', N'0');
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'194', N'BrightTerryTowels-Sml-pnk', N'101', N'12', N'1', N'1000', N'1', N'1', N'14', N'0', N'', N'', N'', N'0');
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'195', N'BrightTerryTowels-Sml-mint', N'101', N'12', N'1', N'1000', N'1', N'1', N'14', N'0', N'', N'', N'', N'0');
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'196', N'BrightTerryTowels-Sml-yellow', N'101', N'12', N'1', N'1000', N'1', N'1', N'14', N'0', N'', N'', N'', N'0');
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'197', N'BrightTerryTowels-Lrg-blu ', N'101', N'14', N'1', N'1000', N'1', N'1', N'16', N'0', N'', N'', N'', N'0');
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'198', N'BrightTerryTowels-Lrg-orng ', N'101', N'14', N'1', N'1000', N'1', N'1', N'16', N'0', N'', N'', N'', N'0');
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'199', N'BrightTerryTowels-Lrg-pnk ', N'101', N'14', N'1', N'1000', N'1', N'1', N'16', N'0', N'', N'', N'', N'0');
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'200', N'BrightTerryTowels-Lrg-mint ', N'101', N'14', N'1', N'1000', N'1', N'1', N'16', N'0', N'', N'', N'', N'0');
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'201', N'BrightTerryTowels-Lrg-yellow ', N'101', N'14', N'1', N'971', N'1', N'1', N'16', N'0', N'', N'', N'', N'0');
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'202', N'PastelComfort-blu-T', N'102', N'35', N'9999', N'463', N'1', N'1', N'42', N'7.77', N'', N'', N'', N'0');
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'203', N'PastelComfort-blu-F', N'102', N'38', N'7', N'467', N'1', N'1.2', N'48', N'0', N'', N'', N'', N'0');
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'204', N'PastelComfort-blu-Q', N'102', N'39', N'7.5', N'479', N'1', N'1.3', N'49', N'0', N'', N'', N'', N'0');
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'205', N'PastelComfort-blu-K', N'102', N'56', N'8', N'462', N'1', N'1.4', N'60', N'0', N'', N'', N'', N'0');
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'206', N'PastelComfort-Yellow-T', N'102', N'35', N'6', N'475', N'1', N'2', N'42', N'0', N'', N'', N'', N'0');
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'207', N'PastelComfort-Yellow-F ', N'102', N'38', N'7', N'486', N'1', N'2.2', N'48', N'0', N'', N'', N'', N'0');
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'208', N'PastelComfort-Yellow-Q ', N'102', N'39', N'7.5', N'500', N'1', N'2.3', N'49', N'0', N'', N'', N'', N'0');
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'209', N'PastelComfort-Yellow-K', N'102', N'56', N'8', N'480', N'1', N'2.4', N'60', N'0', N'', N'', N'', N'0');
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'210', N'PastelComfort-prpl-T ', N'102', N'35', N'878', N'489', N'1', N'3.1', N'42', N'7.77', N'', N'', N'', N'0');
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'211', N'PastelComfort-prpl-F ', N'102', N'38', N'7', N'467', N'1', N'3.2', N'48', N'0', N'', N'', N'', N'0');
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'212', N'PastelComfort-prpl-Q ', N'102', N'39', N'7.5', N'493', N'1', N'3.3', N'49', N'0', N'', N'', N'', N'0');
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'213', N'PastelComfort-prpl-K ', N'102', N'56', N'8', N'480', N'1', N'3.4', N'60', N'0', N'', N'', N'', N'0');
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'214', N'RBBroom', N'103', N'28', N'4', N'970', N'1', N'0', N'41', N'0', N'', N'', N'', N'0');
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'216', N'DownPillowQueen', N'104', N'29', N'3', N'986', N'1', N'2', N'36', N'0', N'', N'', N'', N'0');
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'217', N'DownPillowKing', N'104', N'28', N'3', N'961', N'1', N'1', N'32', N'0', N'', N'', N'', N'0');
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'218', N'DigitalVideoHD', N'105', N'425', N'2', N'822', N'1', N'0', N'478', N'9.12', N'', N'', N'', N'0');
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'219', N'Rugby-Small', N'106', N'22', N'1', N'477', N'1', N'1', N'24', N'0', N'', N'', N'', N'0');
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'220', N'Rugby-Med', N'106', N'24', N'1', N'456', N'1', N'2', N'26', N'0', N'', N'', N'', N'0');
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'221', N'Rugby-Large', N'106', N'24', N'1', N'489', N'1', N'3', N'26', N'0', N'', N'', N'', N'0');
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'222', N'Rugby-X-Large', N'106', N'25', N'1', N'488', N'1', N'4', N'28', N'0', N'', N'', N'', N'0');
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'223', N'KomfyKhakis-34X30', N'107', N'34', N'2', N'480', N'1', N'1', N'38', N'0', N'', N'', N'', N'0');
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'224', N'KomfyKhakis-34X32', N'107', N'34', N'2', N'466', N'1', N'2', N'38', N'0', N'', N'', N'', N'0');
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'225', N'KomfyKhakis-36X30', N'107', N'34', N'2', N'457', N'1', N'3', N'38', N'0', N'', N'', N'', N'0');
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'226', N'KomfyKhakis-36X32', N'107', N'34', N'2', N'488', N'1', N'4', N'38', N'0', N'', N'', N'', N'0');
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'227', N'KomfyKhakis-38X30', N'107', N'34', N'2', N'494', N'1', N'5', N'38', N'0', N'', N'', N'', N'0');
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'228', N'KomfyKhakis-38X32', N'107', N'34', N'2', N'489', N'1', N'6', N'38', N'0', N'', N'', N'', N'0');
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'229', N'RetroTV-Yellow', N'108', N'500', N'35', N'462', N'1', N'1', N'525', N'0', N'', N'', N'', N'0');
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'230', N'RetroTV-Red', N'108', N'500', N'35', N'478', N'1', N'2', N'525', N'0', N'', N'', N'', N'0');
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'231', N'RetroTV-Blue', N'108', N'500', N'35', N'491', N'1', N'3', N'525', N'0', N'', N'', N'', N'0');
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'232', N'DigitalPoint-n-Shoot-Blue', N'109', N'125', N'11', N'449', N'1', N'1', N'139.99', N'2.22', N'', N'', N'', N'0');
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'233', N'DigitalPoint-n-Shoot-Red', N'109', N'125', N'1', N'259', N'1', N'2', N'139.99', N'0', N'', N'', N'', N'0');
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'239', N'LawnPower Riding-6r', N'110', N'899', N'120', N'94', N'1', N'1', N'999', N'56', N'', N'', N'', N'0');
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'240', N'SKU: LawnPower Riding-6y', N'110', N'899', N'120', N'94', N'1', N'2', N'999', N'56', N'', N'', N'', N'0');
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'241', N'SKU: LawnPower Riding-12r', N'110', N'999', N'148', N'66', N'1', N'3', N'1200', N'66', N'', N'', N'', N'0');
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'242', N'SKU: LawnPower Riding-12y', N'110', N'999', N'148', N'92', N'1', N'3', N'1200', N'66', N'', N'', N'', N'0');
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'243', N'LawnPower-Push-3.5r', N'111', N'389', N'60', N'476', N'1', N'1', N'425', N'0', N'', N'', N'', N'0');
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'244', N'LawnPower-Push-3.5b', N'111', N'389', N'60', N'482', N'1', N'2', N'425', N'0', N'', N'', N'', N'0');
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'245', N'LawnPower-Push-6r', N'111', N'412', N'65', N'492', N'1', N'3', N'445', N'0', N'', N'', N'', N'0');
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'246', N'LawnPower-Push-6b', N'111', N'412', N'65', N'493', N'1', N'4', N'445', N'0', N'', N'', N'', N'0');
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'247', N'WeedAWack-.25', N'112', N'120', N'8', N'492', N'1', N'0', N'135', N'0', N'', N'', N'', N'0');
;
INSERT INTO [dbo].[cw_skus] ([sku_id], [sku_merchant_sku_id], [sku_product_id], [sku_price], [sku_weight], [sku_stock], [sku_on_web], [sku_sort], [sku_alt_price], [sku_ship_base], [sku_download_file], [sku_download_id], [sku_download_version], [sku_download_limit]) VALUES (N'248', N'WeedAWack-.5', N'112', N'130', N'9', N'465', N'1', N'0', N'155', N'0', N'', N'', N'', N'0');
;
SET IDENTITY_INSERT [dbo].[cw_skus] OFF
;

-- ----------------------------
-- Table structure for [dbo].[cw_stateprov]
-- ----------------------------
IF OBJECT_ID('[dbo].[cw_stateprov]') IS NOT NULL DROP TABLE [dbo].[cw_stateprov]
;
CREATE TABLE [dbo].[cw_stateprov] (
[stateprov_id] int NOT NULL IDENTITY(1,1) ,
[stateprov_code] nvarchar(150) NULL ,
[stateprov_name] nvarchar(255) NULL ,
[stateprov_country_id] int NULL DEFAULT '0',
[stateprov_tax] float(53) NULL DEFAULT '0',
[stateprov_ship_ext] float(53) NULL DEFAULT '0',
[stateprov_archive] int NULL DEFAULT '0',
[stateprov_nexus] int NULL DEFAULT '0'
)


;
DBCC CHECKIDENT(N'[dbo].[cw_stateprov]', RESEED, 4215)
;

-- ----------------------------
-- Records of cw_stateprov
-- ----------------------------
SET IDENTITY_INSERT [dbo].[cw_stateprov] ON
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1', N'AL', N'Alabama', N'1', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'2', N'AK', N'Alaska', N'1', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'3', N'AZ', N'Arizona', N'1', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4', N'AR', N'Arkansas', N'1', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'5', N'CA', N'California', N'1', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'6', N'CO', N'Colorado', N'1', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'7', N'CT', N'Connecticut', N'1', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'8', N'DE', N'Delaware', N'1', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'9', N'FL', N'Florida', N'1', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'10', N'GA', N'Georgia', N'1', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'11', N'HI', N'Hawaii', N'1', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'12', N'ID', N'Idaho', N'1', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'13', N'IL', N'Illinois', N'1', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'14', N'IN', N'Indiana', N'1', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'15', N'IA', N'Iowa', N'1', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'16', N'KS', N'Kansas', N'1', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'17', N'KY', N'Kentucky', N'1', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'18', N'LA', N'Louisiana', N'1', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'19', N'ME', N'Maine', N'1', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'20', N'MD', N'Maryland', N'1', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'21', N'MA', N'Massachusetts', N'1', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'22', N'MI', N'Michigan', N'1', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'23', N'MN', N'Minnesota', N'1', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'24', N'MS', N'Mississippi', N'1', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'25', N'MO', N'Missouri', N'1', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'26', N'MT', N'Montana', N'1', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'27', N'NE', N'Nebraska', N'1', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'28', N'NV', N'Nevada', N'1', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'29', N'NH', N'New Hampshire', N'1', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'30', N'NJ', N'New Jersey', N'1', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'31', N'NM', N'New Mexico', N'1', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'32', N'NY', N'New York', N'1', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'33', N'NC', N'North Carolina', N'1', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'34', N'ND', N'North Dakota', N'1', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'35', N'OH', N'Ohio', N'1', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'36', N'OK', N'Oklahoma', N'1', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'37', N'OR', N'Oregon', N'1', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'38', N'PA', N'Pennsylvania', N'1', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'39', N'RI', N'Rhode Island', N'1', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'40', N'SC', N'South Carolina', N'1', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'41', N'SD', N'South Dakota', N'1', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'42', N'TN', N'Tennessee', N'1', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'43', N'TX', N'Texas', N'1', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'44', N'UT', N'Utah', N'1', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'45', N'VT', N'Vermont', N'1', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'46', N'VA', N'Virginia', N'1', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'47', N'WA', N'Washington', N'1', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'48', N'WV', N'West Virginia', N'1', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'49', N'WI', N'Wisconsin', N'1', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'50', N'WY', N'Wyoming', N'1', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'70', N'None', N'None', N'4', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'72', N'None', N'None', N'6', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'73', N'None', N'None', N'7', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'75', N'DC', N'District of Columbia', N'1', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'78', N'AA', N'Armed Forces America', N'1', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'79', N'AE', N'Armed Forces Europe', N'1', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'80', N'AP', N'Armed Forces Pacific', N'1', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'81', N'None', N'None', N'9', N'0', N'0', N'1');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'83', N'AB', N'Alberta', N'9', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'84', N'BC', N'British Columbia', N'9', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'85', N'MB', N'Manitoba', N'9', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'86', N'NB', N'New Brunswick', N'9', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'88', N'NL', N'Newfoundland and Labrador', N'9', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'89', N'NS', N'Nova Scotia', N'9', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'90', N'ON', N'Ontario', N'9', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'91', N'PE', N'Prince Edward Island', N'9', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'92', N'QC', N'Quebec', N'9', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'93', N'SK', N'Saskatchewan', N'9', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'94', N'NT', N'Northwest Territories', N'9', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'95', N'NU', N'Nunavut', N'9', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'96', N'YT', N'Yukon', N'9', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'161', N'None', N'None', N'14', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'348', N'AU-ACT', N'Australian Capital Territory', N'23', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'349', N'AU-NSW', N'New South Wales', N'23', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'350', N'AU-NT', N'Northern Territory', N'23', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'351', N'AU-QLD', N'Queensland', N'23', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'352', N'AU-SA', N'South Australia', N'23', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'353', N'AU-TAS', N'Tasmania', N'23', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'354', N'AU-VIC', N'Victoria', N'23', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'355', N'AU-WA', N'Western Australia', N'23', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'773', N'CA-AB', N'Alberta', N'45', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'774', N'CA-BC', N'British Columbia', N'45', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'775', N'CA-MB', N'Manitoba', N'45', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'776', N'CA-NB', N'New Brunswick', N'45', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'777', N'CA-NL', N'Newfoundland and Labrador', N'45', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'778', N'CA-NT', N'Northwest Territories', N'45', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'779', N'CA-NS', N'Nova Scotia', N'45', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'780', N'CA-NU', N'Nunavut', N'45', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'781', N'CA-ON', N'Ontario', N'45', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'782', N'CA-PE', N'Prince Edward Island', N'45', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'783', N'CA-QC', N'Quebec', N'45', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'784', N'CA-SK', N'Saskatchewan', N'45', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'785', N'CA-YT', N'Yukon Territory', N'45', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'860', N'CN-34', N'Anhui', N'51', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'861', N'CN-92', N'Aomen (zh) ***', N'51', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'862', N'CN-11', N'Beijing', N'51', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'863', N'CN-50', N'Chongqing', N'51', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'864', N'CN-35', N'Fujian', N'51', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'865', N'CN-62', N'Gansu', N'51', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'866', N'CN-44', N'Guangdong', N'51', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'867', N'CN-45', N'Guangxi', N'51', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'868', N'CN-52', N'Guizhou', N'51', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'869', N'CN-46', N'Hainan', N'51', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'870', N'CN-13', N'Hebei', N'51', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'871', N'CN-23', N'Heilongjiang', N'51', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'872', N'CN-41', N'Henan', N'51', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'873', N'CN-42', N'Hubei', N'51', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'874', N'CN-43', N'Hunan', N'51', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'875', N'CN-32', N'Jiangsu', N'51', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'876', N'CN-36', N'Jiangxi', N'51', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'877', N'CN-22', N'Jilin', N'51', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'878', N'CN-21', N'Liaoning', N'51', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'879', N'CN-15', N'Nei Mongol (mn)', N'51', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'880', N'CN-64', N'Ningxia', N'51', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'881', N'CN-63', N'Qinghai', N'51', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'882', N'CN-61', N'Shaanxi', N'51', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'883', N'CN-37', N'Shandong', N'51', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'884', N'CN-31', N'Shanghai', N'51', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'885', N'CN-14', N'Shanxi', N'51', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'886', N'CN-51', N'Sichuan', N'51', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'887', N'CN-71', N'Taiwan *', N'51', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'888', N'CN-12', N'Tianjin', N'51', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'889', N'CN-91', N'Xianggang (zh) **', N'51', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'890', N'CN-65', N'Xinjiang', N'51', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'891', N'CN-54', N'Xizang', N'51', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'892', N'CN-53', N'Yunnan', N'51', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'893', N'CN-33', N'Zhejiang', N'51', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1219', N'FR-01', N'Ain', N'75', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1711', N'IE-CW', N'Carlow', N'96', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1712', N'IE-CN', N'Cavan', N'96', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1713', N'IE-CE', N'Clare', N'96', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1714', N'IE-C', N'Cork', N'96', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1715', N'IE-DL', N'Donegal', N'96', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1716', N'IE-D', N'Dublin', N'96', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1717', N'IE-G', N'Galway', N'96', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1718', N'IE-KY', N'Kerry', N'96', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1719', N'IE-KE', N'Kildare', N'96', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1720', N'IE-KK', N'Kilkenny', N'96', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1721', N'IE-LS', N'Laois', N'96', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1722', N'IE-LM', N'Leitrim', N'96', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1723', N'IE-LK', N'Limerick', N'96', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1724', N'IE-LD', N'Longford', N'96', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1725', N'IE-LH', N'Louth', N'96', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1726', N'IE-MO', N'Mayo', N'96', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1727', N'IE-MH', N'Meath', N'96', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1728', N'IE-MN', N'Monaghan', N'96', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1729', N'IE-OY', N'Offaly', N'96', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1730', N'IE-RN', N'Roscommon', N'96', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1731', N'IE-SO', N'Sligo', N'96', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1732', N'IE-TA', N'Tipperary', N'96', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1733', N'IE-WD', N'Waterford', N'96', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1734', N'IE-WH', N'Westmeath', N'96', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1735', N'IE-WX', N'Wexford', N'96', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1736', N'IE-WW', N'Wicklow', N'96', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1737', N'IL-D', N'HaDarom', N'97', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1738', N'IL-HA', N'Haifa', N'97', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1739', N'IL-M', N'HaMerkaz', N'97', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1740', N'IL-Z', N'HaZafon', N'97', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1741', N'IL-TA', N'Tel-Aviv', N'97', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1742', N'IL-JM', N'Yerushalayim', N'97', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1743', N'IT-AG', N'Agrigento', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1744', N'IT-AL', N'Alessandria', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1745', N'IT-AN', N'Ancona', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1746', N'IT-AO', N'Aosta', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1747', N'IT-AR', N'Arezzo', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1748', N'IT-AP', N'Ascoli Piceno', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1749', N'IT-AT', N'Asti', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1750', N'IT-AV', N'Avellino', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1751', N'IT-BA', N'Bari', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1752', N'IT-BT', N'Barletta-Andria-Trani', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1753', N'IT-BL', N'Belluno', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1754', N'IT-BN', N'Benevento', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1755', N'IT-BG', N'Bergamo', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1756', N'IT-BI', N'Biella', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1757', N'IT-BO', N'Bologna', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1758', N'IT-BZ', N'Bolzano', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1759', N'IT-BS', N'Brescia', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1760', N'IT-BR', N'Brindisi', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1761', N'IT-CA', N'Cagliari', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1762', N'IT-CL', N'Caltanissetta', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1763', N'IT-CB', N'Campobasso', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1764', N'IT-CI', N'Carbonia-Iglesias', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1765', N'IT-CE', N'Caserta', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1766', N'IT-CT', N'Catania', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1767', N'IT-CZ', N'Catanzaro', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1768', N'IT-CH', N'Chieti', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1769', N'IT-CO', N'Como', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1770', N'IT-CS', N'Cosenza', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1771', N'IT-CR', N'Cremona', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1772', N'IT-KR', N'Crotone', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1773', N'IT-CN', N'Cuneo', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1774', N'IT-EN', N'Enna', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1775', N'IT-FM', N'Fermo', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1776', N'IT-FE', N'Ferrara', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1777', N'IT-FI', N'Firenze', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1778', N'IT-FG', N'Foggia', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1779', N'IT-FC', N'Forli-Cesena', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1780', N'IT-FR', N'Frosinone', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1781', N'IT-GE', N'Genova', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1782', N'IT-GO', N'Gorizia', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1783', N'IT-GR', N'Grosseto', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1784', N'IT-IM', N'Imperia', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1785', N'IT-IS', N'Isernia', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1786', N'IT-AQ', N'L''Aquila', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1787', N'IT-SP', N'La Spezia', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1788', N'IT-LT', N'Latina', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1789', N'IT-LE', N'Lecce', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1790', N'IT-LC', N'Lecco', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1791', N'IT-LI', N'Livorno', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1792', N'IT-LO', N'Lodi', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1793', N'IT-LU', N'Lucca', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1794', N'IT-MC', N'Macerata', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1795', N'IT-MN', N'Mantova', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1796', N'IT-MS', N'Massa-Carrara', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1797', N'IT-MT', N'Matera', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1798', N'IT-MA', N'Medio Campidano', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1799', N'IT-ME', N'Messina', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1800', N'IT-MI', N'Milano', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1801', N'IT-MO', N'Modena', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1802', N'IT-MB', N'Monza e Brianza', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1803', N'IT-NA', N'Napoli', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1804', N'IT-NO', N'Novara', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1805', N'IT-NU', N'Nuoro', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1806', N'IT-OG', N'Ogliastra', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1807', N'IT-OL', N'Olbia-Tempio', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1808', N'IT-OR', N'Oristano', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1809', N'IT-PD', N'Padova', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1810', N'IT-PA', N'Palermo', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1811', N'IT-PR', N'Parma', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1812', N'IT-PV', N'Pavia', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1813', N'IT-PG', N'Perugia', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1814', N'IT-PS', N'Pesaro e Urbino', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1815', N'IT-PE', N'Pescara', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1816', N'IT-PC', N'Piacenza', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1817', N'IT-PI', N'Pisa', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1818', N'IT-PT', N'Pistoia', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1819', N'IT-PN', N'Pordenone', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1820', N'IT-PZ', N'Potenza', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1821', N'IT-PO', N'Prato', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1822', N'IT-RG', N'Ragusa', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1823', N'IT-RA', N'Ravenna', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1824', N'IT-RC', N'Reggio Calabria', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1825', N'IT-RE', N'Reggio Emilia', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1826', N'IT-RI', N'Rieti', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1827', N'IT-RN', N'Rimini', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1828', N'IT-RM', N'Roma', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1829', N'IT-RO', N'Rovigo', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1830', N'IT-SA', N'Salerno', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1831', N'IT-SS', N'Sassari', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1832', N'IT-SV', N'Savona', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1833', N'IT-SI', N'Siena', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1834', N'IT-SR', N'Siracusa', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1835', N'IT-SO', N'Sondrio', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1836', N'IT-TA', N'Taranto', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1837', N'IT-TE', N'Teramo', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1838', N'IT-TR', N'Terni', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1839', N'IT-TO', N'Torino', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1840', N'IT-TP', N'Trapani', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1841', N'IT-TN', N'Trento', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1842', N'IT-TV', N'Treviso', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1843', N'IT-TS', N'Trieste', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1844', N'IT-UD', N'Udine', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1845', N'IT-VA', N'Varese', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1846', N'IT-VE', N'Venezia', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1847', N'IT-VB', N'Verbano-Cusio-Ossola', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1848', N'IT-VC', N'Vercelli', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1849', N'IT-VR', N'Verona', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1850', N'IT-VV', N'Vibo Valentia', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1851', N'IT-VI', N'Vicenza', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'1852', N'IT-VT', N'Viterbo', N'98', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'2570', N'NZ-AUK', N'Auckland', N'139', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'2571', N'NZ-BOP', N'Bay of Plenty', N'139', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'2572', N'NZ-CAN', N'Canterbury', N'139', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'2573', N'NZ-X1~', N'Chatham Islands', N'139', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'2574', N'NZ-GIS', N'Gisborne', N'139', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'2575', N'NZ-HKB', N'Hawkes''s Bay', N'139', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'2576', N'NZ-MWT', N'Manawatu-Wanganui', N'139', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'2577', N'NZ-MBH', N'Marlborough', N'139', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'2578', N'NZ-NSN', N'Nelson', N'139', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'2579', N'NZ-NTL', N'Northland', N'139', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'2580', N'NZ-OTA', N'Otago', N'139', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'2581', N'NZ-STL', N'Southland', N'139', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'2582', N'NZ-TKI', N'Taranaki', N'139', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'2583', N'NZ-TAS', N'Tasman', N'139', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'2584', N'NZ-WKO', N'Waikato', N'139', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'2585', N'NZ-WGN', N'Wellington', N'139', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'2586', N'NZ-WTC', N'West Coast', N'139', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'3986', N'GB-ABE', N'Aberdeen City', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'3987', N'GB-ABD', N'Aberdeenshire', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'3988', N'GB-ANS', N'Angus', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'3989', N'GB-ANT', N'Antrim', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'3990', N'GB-ARD', N'Ards', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'3991', N'GB-AGB', N'Argyll and Bute', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'3992', N'GB-ARM', N'Armagh', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'3993', N'GB-BLA', N'Ballymena', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'3994', N'GB-BLY', N'Ballymoney', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'3995', N'GB-BNB', N'Banbridge', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'3996', N'GB-BDG', N'Barking and Dagenham', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'3997', N'GB-BNE', N'Barnet', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'3998', N'GB-BNS', N'Barnsley', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'3999', N'GB-BAS', N'Bath and North East Somerset', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4000', N'GB-BDF', N'Bedfordshire', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4001', N'GB-BFS', N'Belfast', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4002', N'GB-BEX', N'Bexley', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4003', N'GB-BIR', N'Birmingham', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4004', N'GB-BBD', N'Blackburn with Darwen', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4005', N'GB-BPL', N'Blackpool', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4006', N'GB-BGW', N'Blaenau Gwent', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4007', N'GB-BOL', N'Bolton', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4008', N'GB-BMH', N'Bournemouth', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4009', N'GB-BRC', N'Bracknell Forest', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4010', N'GB-BRD', N'Bradford', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4011', N'GB-BEN', N'Brent', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4012', N'GB-BGE', N'Bridgend [Pen-y-bont ar Ogwr GB-POG]', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4013', N'GB-BNH', N'Brighton and Hove', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4014', N'GB-BST', N'Bristol, City of', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4015', N'GB-BRY', N'Bromley', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4016', N'GB-BKM', N'Buckinghamshire', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4017', N'GB-BUR', N'Bury', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4018', N'GB-CAY', N'Caerphilly [Caerffili GB-CAF]', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4019', N'GB-CLD', N'Calderdale', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4020', N'GB-CAM', N'Cambridgeshire', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4021', N'GB-CMD', N'Camden', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4022', N'GB-CRF', N'Cardiff [Caerdydd GB-CRD]', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4023', N'GB-CMN', N'Carmarthenshire [Sir Gaerfyrddin GB-GFY]', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4024', N'GB-CKF', N'Carrickfergus', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4025', N'GB-CSR', N'Castlereagh', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4026', N'GB-CGN', N'Ceredigion [Sir Ceredigion]', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4027', N'GB-CHS', N'Cheshire', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4028', N'GB-CLK', N'Clackmannanshire', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4029', N'GB-CLR', N'Coleraine', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4030', N'GB-CWY', N'Conwy', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4031', N'GB-CKT', N'Cookstown', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4032', N'GB-CON', N'Cornwall', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4033', N'GB-COV', N'Coventry', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4034', N'GB-CGV', N'Craigavon', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4035', N'GB-CRY', N'Croydon', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4036', N'GB-CMA', N'Cumbria', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4037', N'GB-DAL', N'Darlington', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4038', N'GB-DEN', N'Denbighshire [Sir Ddinbych GB-DDB]', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4039', N'GB-DER', N'Derby', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4040', N'GB-DBY', N'Derbyshire', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4041', N'GB-DRY', N'Derry', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4042', N'GB-DEV', N'Devon', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4043', N'GB-DNC', N'Doncaster', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4044', N'GB-DOR', N'Dorset', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4045', N'GB-DOW', N'Down', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4046', N'GB-DUD', N'Dudley', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4047', N'GB-DGY', N'Dumfries and Galloway', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4048', N'GB-DND', N'Dundee City', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4049', N'GB-DGN', N'Dungannon', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4050', N'GB-DUR', N'Durham', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4051', N'GB-EAL', N'Ealing', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4052', N'GB-EAY', N'East Ayrshire', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4053', N'GB-EDU', N'East Dunbartonshire', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4054', N'GB-ELN', N'East Lothian', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4055', N'GB-ERW', N'East Renfrewshire', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4056', N'GB-ERY', N'East Riding of Yorkshire', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4057', N'GB-ESX', N'East Sussex', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4058', N'GB-EDH', N'Edinburgh, City of', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4059', N'GB-ELS', N'Eilean Siar', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4060', N'GB-ENF', N'Enfield', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4061', N'GB-ESS', N'Essex', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4062', N'GB-FAL', N'Falkirk', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4063', N'GB-FER', N'Fermanagh', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4064', N'GB-FIF', N'Fife', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4065', N'GB-FLN', N'Flintshire [Sir y Fflint GB-FFL]', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4066', N'GB-GAT', N'Gateshead', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4067', N'GB-GLG', N'Glasgow City', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4068', N'GB-GLS', N'Gloucestershire', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4069', N'GB-GRE', N'Greenwich', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4070', N'GB-GWN', N'Gwynedd', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4071', N'GB-HCK', N'Hackney', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4072', N'GB-HAL', N'Halton', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4073', N'GB-HMF', N'Hammersmith and Fulham', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4074', N'GB-HAM', N'Hampshire', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4075', N'GB-HRY', N'Haringey', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4076', N'GB-HRW', N'Harrow', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4077', N'GB-HPL', N'Hartlepool', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4078', N'GB-HAV', N'Havering', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4079', N'GB-HEF', N'Herefordshire, County of', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4080', N'GB-HRT', N'Hertfordshire', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4081', N'GB-HLD', N'Highland', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4082', N'GB-HIL', N'Hillingdon', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4083', N'GB-HNS', N'Hounslow', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4084', N'GB-IVC', N'Inverclyde', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4085', N'GB-AGY', N'Isle of Anglesey [Sir Ynys MÃƒÆ’Ã‚Â´n GB-YNM]', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4086', N'GB-IOW', N'Isle of Wight', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4087', N'GB-IOS', N'Isles of Scilly', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4088', N'GB-ISL', N'Islington', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4089', N'GB-KEC', N'Kensington and Chelsea', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4090', N'GB-KEN', N'Kent', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4091', N'GB-KHL', N'Kingston upon Hull, City of', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4092', N'GB-KTT', N'Kingston upon Thames', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4093', N'GB-KIR', N'Kirklees', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4094', N'GB-KWL', N'Knowsley', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4095', N'GB-LBH', N'Lambeth', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4096', N'GB-LAN', N'Lancashire', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4097', N'GB-LRN', N'Larne', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4098', N'GB-LDS', N'Leeds', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4099', N'GB-LCE', N'Leicester', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4100', N'GB-LEC', N'Leicestershire', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4101', N'GB-LEW', N'Lewisham', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4102', N'GB-LMV', N'Limavady', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4103', N'GB-LIN', N'Lincolnshire', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4104', N'GB-LSB', N'Lisburn', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4105', N'GB-LIV', N'Liverpool', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4106', N'GB-LND', N'London, City of', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4107', N'GB-LUT', N'Luton', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4108', N'GB-MFT', N'Magherafelt', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4109', N'GB-MAN', N'Manchester', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4110', N'GB-MDW', N'Medway', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4111', N'GB-MTY', N'Merthyr Tydfil [Merthyr Tudful GB-MTU]', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4112', N'GB-MRT', N'Merton', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4113', N'GB-MDB', N'Middlesbrough', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4114', N'GB-MLN', N'Midlothian', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4115', N'GB-MIK', N'Milton Keynes', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4116', N'GB-MON', N'Monmouthshire [Sir Fynwy GB-FYN]', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4117', N'GB-MRY', N'Moray', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4118', N'GB-MYL', N'Moyle', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4119', N'GB-NTL', N'Neath Port Talbot [Castell-nedd Port Talbot GB-CTL]', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4120', N'GB-NET', N'Newcastle upon Tyne', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4121', N'GB-NWM', N'Newham', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4122', N'GB-NWP', N'Newport [Casnewydd GB-CNW]', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4123', N'GB-NYM', N'Newry and Mourne', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4124', N'GB-NTA', N'Newtownabbey', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4125', N'GB-NFK', N'Norfolk', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4126', N'GB-NAY', N'North Ayrshire', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4127', N'GB-NDN', N'North Down', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4128', N'GB-NEL', N'North East Lincolnshire', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4129', N'GB-NLK', N'North Lanarkshire', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4130', N'GB-NLN', N'North Lincolnshire', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4131', N'GB-NSM', N'North Somerset', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4132', N'GB-NTY', N'North Tyneside', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4133', N'GB-NYK', N'North Yorkshire', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4134', N'GB-NTH', N'Northamptonshire', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4135', N'GB-NBL', N'Northumberland', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4136', N'GB-NGM', N'Nottingham', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4137', N'GB-NTT', N'Nottinghamshire', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4138', N'GB-OLD', N'Oldham', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4139', N'GB-OMH', N'Omagh', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4140', N'GB-ORK', N'Orkney Islands', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4141', N'GB-OXF', N'Oxfordshire', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4142', N'GB-PEM', N'Pembrokeshire [Sir Benfro GB-BNF]', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4143', N'GB-PKN', N'Perth and Kinross', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4144', N'GB-PTE', N'Peterborough', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4145', N'GB-PLY', N'Plymouth', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4146', N'GB-POL', N'Poole', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4147', N'GB-POR', N'Portsmouth', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4148', N'GB-POW', N'Powys', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4149', N'GB-RDG', N'Reading', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4150', N'GB-RDB', N'Redbridge', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4151', N'GB-RCC', N'Redcar and Cleveland', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4152', N'GB-RFW', N'Renfrewshire', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4153', N'GB-RCT', N'Rhondda, Cynon, Taff [Rhondda, Cynon,Taf]', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4154', N'GB-RIC', N'Richmond upon Thames', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4155', N'GB-RCH', N'Rochdale', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4156', N'GB-ROT', N'Rotherham', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4157', N'GB-RUT', N'Rutland', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4158', N'GB-SLF', N'Salford', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4159', N'GB-SAW', N'Sandwell', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4160', N'GB-SCB', N'Scottish Borders, The', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4161', N'GB-SFT', N'Sefton', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4162', N'GB-SHF', N'Sheffield', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4163', N'GB-ZET', N'Shetland Islands', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4164', N'GB-SHR', N'Shropshire', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4165', N'GB-SLG', N'Slough', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4166', N'GB-SOL', N'Solihull', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4167', N'GB-SOM', N'Somerset', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4168', N'GB-SAY', N'South Ayrshire', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4169', N'GB-SGC', N'South Gloucestershire', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4170', N'GB-SLK', N'South Lanarkshire', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4171', N'GB-STY', N'South Tyneside', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4172', N'GB-STH', N'Southampton', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4173', N'GB-SOS', N'Southend-on-Sea', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4174', N'GB-SWK', N'Southwark', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4175', N'GB-SHN', N'St. Helens', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4176', N'GB-STS', N'Staffordshire', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4177', N'GB-STG', N'Stirling', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4178', N'GB-SKP', N'Stockport', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4179', N'GB-STT', N'Stockton-on-Tees', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4180', N'GB-STE', N'Stoke-on-Trent', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4181', N'GB-STB', N'Strabane', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4182', N'GB-SFK', N'Suffolk', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4183', N'GB-SND', N'Sunderland', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4184', N'GB-SRY', N'Surrey', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4185', N'GB-STN', N'Sutton', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4186', N'GB-SWA', N'Swansea [Abertawe GB-ATA]', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4187', N'GB-SWD', N'Swindon', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4188', N'GB-TAM', N'Tameside', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4189', N'GB-TFW', N'Telford and Wrekin', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4190', N'GB-THR', N'Thurrock', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4191', N'GB-TOB', N'Torbay', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4192', N'GB-TOF', N'Torfaen [Tor-faen]', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4193', N'GB-TWH', N'Tower Hamlets', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4194', N'GB-TRF', N'Trafford', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4195', N'GB-VGL', N'Vale of Glamorgan, The [Bro Morgannwg GB-BMG]', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4196', N'GB-WKF', N'Wakefield', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4197', N'GB-WLL', N'Walsall', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4198', N'GB-WFT', N'Waltham Forest', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4199', N'GB-WND', N'Wandsworth', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4200', N'GB-WRT', N'Warrington', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4201', N'GB-WAR', N'Warwickshire', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4202', N'GB-WBK', N'West Berkshire', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4203', N'GB-WDU', N'West Dunbartonshire', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4204', N'GB-WLN', N'West Lothian', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4205', N'GB-WSX', N'West Sussex', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4206', N'GB-WSM', N'Westminster', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4207', N'GB-WGN', N'Wigan', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4208', N'GB-WIL', N'Wiltshire', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4209', N'GB-WNM', N'Windsor and Maidenhead', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4210', N'GB-WRL', N'Wirral', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4211', N'GB-WOK', N'Wokingham', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4212', N'GB-WLV', N'Wolverhampton', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4213', N'GB-WOR', N'Worcestershire', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4214', N'GB-WRX', N'Wrexham [Wrecsam GB-WRC]', N'198', N'0', N'0', N'0');
;
INSERT INTO [dbo].[cw_stateprov] ([stateprov_id], [stateprov_code], [stateprov_name], [stateprov_country_id], [stateprov_tax], [stateprov_ship_ext], [stateprov_archive]) VALUES (N'4215', N'GB-YOR', N'York', N'198', N'0', N'0', N'0');
;
SET IDENTITY_INSERT [dbo].[cw_stateprov] OFF
;

-- ----------------------------
-- Table structure for [dbo].[cw_tax_groups]
-- ----------------------------
IF OBJECT_ID('[dbo].[cw_tax_groups]') IS NOT NULL DROP TABLE [dbo].[cw_tax_groups]
;
CREATE TABLE [dbo].[cw_tax_groups] (
[tax_group_id] int NOT NULL IDENTITY(1,1) ,
[tax_group_name] nvarchar(255) NULL ,
[tax_group_archive] int NULL DEFAULT '0',
[tax_group_code] nvarchar(150) NULL 
)


;
DBCC CHECKIDENT(N'[dbo].[cw_tax_groups]', RESEED, 14)
;

-- ----------------------------
-- Records of cw_tax_groups
-- ----------------------------
SET IDENTITY_INSERT [dbo].[cw_tax_groups] ON
;
INSERT INTO [dbo].[cw_tax_groups] ([tax_group_id], [tax_group_name], [tax_group_archive], [tax_group_code]) VALUES (N'3', N'Computers', N'0', N'PC080100');
;
INSERT INTO [dbo].[cw_tax_groups] ([tax_group_id], [tax_group_name], [tax_group_archive], [tax_group_code]) VALUES (N'10', N'General Sales', N'0', N'O9999999');
;
INSERT INTO [dbo].[cw_tax_groups] ([tax_group_id], [tax_group_name], [tax_group_archive], [tax_group_code]) VALUES (N'14', N'Clothing', N'0', N'PC030100');
;
SET IDENTITY_INSERT [dbo].[cw_tax_groups] OFF
;

-- ----------------------------
-- Table structure for [dbo].[cw_tax_rates]
-- ----------------------------
IF OBJECT_ID('[dbo].[cw_tax_rates]') IS NOT NULL DROP TABLE [dbo].[cw_tax_rates]
;
CREATE TABLE [dbo].[cw_tax_rates] (
[tax_rate_id] int NOT NULL IDENTITY(1,1) ,
[tax_rate_region_id] int NULL DEFAULT '0',
[tax_rate_group_id] int NULL DEFAULT '0',
[tax_rate_percentage] float(53) NULL DEFAULT '0'
)


;
DBCC CHECKIDENT(N'[dbo].[cw_tax_rates]', RESEED, 35)
;

-- ----------------------------
-- Records of cw_tax_rates
-- ----------------------------
SET IDENTITY_INSERT [dbo].[cw_tax_rates] ON
;
INSERT INTO [dbo].[cw_tax_rates] ([tax_rate_id], [tax_rate_region_id], [tax_rate_group_id], [tax_rate_percentage]) VALUES (N'10', N'5', N'2', N'8');
;
INSERT INTO [dbo].[cw_tax_rates] ([tax_rate_id], [tax_rate_region_id], [tax_rate_group_id], [tax_rate_percentage]) VALUES (N'13', N'7', N'5', N'0');
;
INSERT INTO [dbo].[cw_tax_rates] ([tax_rate_id], [tax_rate_region_id], [tax_rate_group_id], [tax_rate_percentage]) VALUES (N'21', N'7', N'3', N'17.2');
;
INSERT INTO [dbo].[cw_tax_rates] ([tax_rate_id], [tax_rate_region_id], [tax_rate_group_id], [tax_rate_percentage]) VALUES (N'26', N'2', N'5', N'10');
;
INSERT INTO [dbo].[cw_tax_rates] ([tax_rate_id], [tax_rate_region_id], [tax_rate_group_id], [tax_rate_percentage]) VALUES (N'29', N'8', N'5', N'12.345');
;
INSERT INTO [dbo].[cw_tax_rates] ([tax_rate_id], [tax_rate_region_id], [tax_rate_group_id], [tax_rate_percentage]) VALUES (N'31', N'6', N'9', N'17.5');
;
INSERT INTO [dbo].[cw_tax_rates] ([tax_rate_id], [tax_rate_region_id], [tax_rate_group_id], [tax_rate_percentage]) VALUES (N'33', N'1', N'10', N'10');
;
INSERT INTO [dbo].[cw_tax_rates] ([tax_rate_id], [tax_rate_region_id], [tax_rate_group_id], [tax_rate_percentage]) VALUES (N'35', N'12', N'10', N'20');
;
SET IDENTITY_INSERT [dbo].[cw_tax_rates] OFF
;

-- ----------------------------
-- Table structure for [dbo].[cw_tax_regions]
-- ----------------------------
IF OBJECT_ID('[dbo].[cw_tax_regions]') IS NOT NULL DROP TABLE [dbo].[cw_tax_regions]
;
CREATE TABLE [dbo].[cw_tax_regions] (
[tax_region_id] int NOT NULL IDENTITY(1,1) ,
[tax_region_country_id] int NULL DEFAULT '0',
[tax_region_state_id] int NULL DEFAULT '0',
[tax_region_label] nvarchar(255) NULL ,
[tax_region_tax_id] nvarchar(150) NULL ,
[tax_region_show_id] int NULL ,
[tax_region_ship_tax_method] nvarchar(150) NULL ,
[tax_region_ship_tax_group_id] int NULL DEFAULT '0'
)

;
DBCC CHECKIDENT(N'[dbo].[cw_tax_regions]', RESEED, 12)
;

-- ----------------------------
-- Records of cw_tax_regions
-- ----------------------------
SET IDENTITY_INSERT [dbo].[cw_tax_regions] ON
;
INSERT INTO [dbo].[cw_tax_regions] ([tax_region_id], [tax_region_country_id], [tax_region_state_id], [tax_region_label], [tax_region_tax_id], [tax_region_show_id], [tax_region_ship_tax_method], [tax_region_ship_tax_group_id]) VALUES (N'1', N'1', N'0', N'US Tax', N'', N'0', N'Highest Item Taxed', N'0');
;
INSERT INTO [dbo].[cw_tax_regions] ([tax_region_id], [tax_region_country_id], [tax_region_state_id], [tax_region_label], [tax_region_tax_id], [tax_region_show_id], [tax_region_ship_tax_method], [tax_region_ship_tax_group_id]) VALUES (N'4', N'3', N'51', N'PST', N'', N'0', N'No Tax', N'0');
;
INSERT INTO [dbo].[cw_tax_regions] ([tax_region_id], [tax_region_country_id], [tax_region_state_id], [tax_region_label], [tax_region_tax_id], [tax_region_show_id], [tax_region_ship_tax_method], [tax_region_ship_tax_group_id]) VALUES (N'6', N'5', N'0', N'VAT', N'1', N'0', N'Highest Item Taxed', N'0');
;
INSERT INTO [dbo].[cw_tax_regions] ([tax_region_id], [tax_region_country_id], [tax_region_state_id], [tax_region_label], [tax_region_tax_id], [tax_region_show_id], [tax_region_ship_tax_method], [tax_region_ship_tax_group_id]) VALUES (N'7', N'3', N'56', N'No Tax', N'2', N'0', N'Highest Item Taxed', N'0');
;
INSERT INTO [dbo].[cw_tax_regions] ([tax_region_id], [tax_region_country_id], [tax_region_state_id], [tax_region_label], [tax_region_tax_id], [tax_region_show_id], [tax_region_ship_tax_method], [tax_region_ship_tax_group_id]) VALUES (N'9', N'6', N'0', N'Test123', N'12345', N'1', N'Highest Item Taxed', N'0');
;
INSERT INTO [dbo].[cw_tax_regions] ([tax_region_id], [tax_region_country_id], [tax_region_state_id], [tax_region_label], [tax_region_tax_id], [tax_region_show_id], [tax_region_ship_tax_method], [tax_region_ship_tax_group_id]) VALUES (N'12', N'198', N'0', N'standard vat', N'', N'0', N'Tax Group', N'5');
;
SET IDENTITY_INSERT [dbo].[cw_tax_regions] OFF
;

-- ----------------------------
-- Indexes structure for table cw_admin_users
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table [dbo].[cw_admin_users]
-- ----------------------------
ALTER TABLE [dbo].[cw_admin_users] ADD PRIMARY KEY ([admin_user_id])
;

-- ----------------------------
-- Indexes structure for table cw_cart
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table [dbo].[cw_cart]
-- ----------------------------
ALTER TABLE [dbo].[cw_cart] ADD PRIMARY KEY ([cart_line_id])
;

-- ----------------------------
-- Indexes structure for table cw_categories_primary
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table [dbo].[cw_categories_primary]
-- ----------------------------
ALTER TABLE [dbo].[cw_categories_primary] ADD PRIMARY KEY ([category_id])
;

-- ----------------------------
-- Indexes structure for table cw_categories_secondary
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table [dbo].[cw_categories_secondary]
-- ----------------------------
ALTER TABLE [dbo].[cw_categories_secondary] ADD PRIMARY KEY ([secondary_id])
;

-- ----------------------------
-- Indexes structure for table cw_config_groups
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table [dbo].[cw_config_groups]
-- ----------------------------
ALTER TABLE [dbo].[cw_config_groups] ADD PRIMARY KEY ([config_group_id])
;

-- ----------------------------
-- Indexes structure for table cw_config_items
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table [dbo].[cw_config_items]
-- ----------------------------
ALTER TABLE [dbo].[cw_config_items] ADD PRIMARY KEY ([config_id])
;

-- ----------------------------
-- Indexes structure for table cw_countries
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table [dbo].[cw_countries]
-- ----------------------------
ALTER TABLE [dbo].[cw_countries] ADD PRIMARY KEY ([country_id])
;

-- ----------------------------
-- Indexes structure for table cw_credit_cards
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table [dbo].[cw_credit_cards]
-- ----------------------------
ALTER TABLE [dbo].[cw_credit_cards] ADD PRIMARY KEY ([creditcard_id])
;

-- ----------------------------
-- Indexes structure for table cw_customer_stateprov
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table [dbo].[cw_customer_stateprov]
-- ----------------------------
ALTER TABLE [dbo].[cw_customer_stateprov] ADD PRIMARY KEY ([customer_state_id])
;

-- ----------------------------
-- Indexes structure for table cw_customer_types
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table [dbo].[cw_customer_types]
-- ----------------------------
ALTER TABLE [dbo].[cw_customer_types] ADD PRIMARY KEY ([customer_type_id])
;

-- ----------------------------
-- Indexes structure for table cw_customers
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table [dbo].[cw_customers]
-- ----------------------------
ALTER TABLE [dbo].[cw_customers] ADD PRIMARY KEY ([customer_id])
;

-- ----------------------------
-- Indexes structure for table cw_discount_amounts
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table [dbo].[cw_discount_amounts]
-- ----------------------------
ALTER TABLE [dbo].[cw_discount_amounts] ADD PRIMARY KEY ([discount_amount_id])
;

-- ----------------------------
-- Indexes structure for table cw_discount_apply_types
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table [dbo].[cw_discount_apply_types]
-- ----------------------------
ALTER TABLE [dbo].[cw_discount_apply_types] ADD PRIMARY KEY ([discount_apply_type_id])
;

-- ----------------------------
-- Indexes structure for table cw_discount_categories
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table [dbo].[cw_discount_categories]
-- ----------------------------
ALTER TABLE [dbo].[cw_discount_categories] ADD PRIMARY KEY ([discount_category_id])
;

-- ----------------------------
-- Indexes structure for table cw_discount_products
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table [dbo].[cw_discount_products]
-- ----------------------------
ALTER TABLE [dbo].[cw_discount_products] ADD PRIMARY KEY ([discount_product_id])
;

-- ----------------------------
-- Indexes structure for table cw_discount_skus
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table [dbo].[cw_discount_skus]
-- ----------------------------
ALTER TABLE [dbo].[cw_discount_skus] ADD PRIMARY KEY ([discount_sku_id])
;

-- ----------------------------
-- Indexes structure for table cw_discount_types
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table [dbo].[cw_discount_types]
-- ----------------------------
ALTER TABLE [dbo].[cw_discount_types] ADD PRIMARY KEY ([discount_type_id])
;

-- ----------------------------
-- Indexes structure for table cw_discount_usage
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table [dbo].[cw_discount_usage]
-- ----------------------------
ALTER TABLE [dbo].[cw_discount_usage] ADD PRIMARY KEY ([discount_usage_id])
;

-- ----------------------------
-- Indexes structure for table cw_discounts
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table [dbo].[cw_discounts]
-- ----------------------------
ALTER TABLE [dbo].[cw_discounts] ADD PRIMARY KEY ([discount_id])
;

-- ----------------------------
-- Indexes structure for table cw_downloads
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table [dbo].[cw_downloads]
-- ----------------------------
ALTER TABLE [dbo].[cw_downloads] ADD PRIMARY KEY ([dl_id])
;

-- ----------------------------
-- Indexes structure for table cw_image_types
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table [dbo].[cw_image_types]
-- ----------------------------
ALTER TABLE [dbo].[cw_image_types] ADD PRIMARY KEY ([imagetype_id])
;

-- ----------------------------
-- Indexes structure for table cw_option_types
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table [dbo].[cw_option_types]
-- ----------------------------
ALTER TABLE [dbo].[cw_option_types] ADD PRIMARY KEY ([optiontype_id])
;

-- ----------------------------
-- Indexes structure for table cw_options
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table [dbo].[cw_options]
-- ----------------------------
ALTER TABLE [dbo].[cw_options] ADD PRIMARY KEY ([option_id])
;

-- ----------------------------
-- Indexes structure for table cw_order_payments
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table [dbo].[cw_order_payments]
-- ----------------------------
ALTER TABLE [dbo].[cw_order_payments] ADD PRIMARY KEY ([payment_id])
;

-- ----------------------------
-- Indexes structure for table cw_order_sku_data
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table [dbo].[cw_order_sku_data]
-- ----------------------------
ALTER TABLE [dbo].[cw_order_sku_data] ADD PRIMARY KEY ([data_id])
;

-- ----------------------------
-- Indexes structure for table cw_order_skus
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table [dbo].[cw_order_skus]
-- ----------------------------
ALTER TABLE [dbo].[cw_order_skus] ADD PRIMARY KEY ([ordersku_id])
;

-- ----------------------------
-- Indexes structure for table cw_order_status
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table [dbo].[cw_order_status]
-- ----------------------------
ALTER TABLE [dbo].[cw_order_status] ADD PRIMARY KEY ([shipstatus_id])
;

-- ----------------------------
-- Indexes structure for table cw_orders
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table [dbo].[cw_orders]
-- ----------------------------
ALTER TABLE [dbo].[cw_orders] ADD PRIMARY KEY ([order_id])
;

-- ----------------------------
-- Indexes structure for table cw_product_categories_primary
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table [dbo].[cw_product_categories_primary]
-- ----------------------------
ALTER TABLE [dbo].[cw_product_categories_primary] ADD PRIMARY KEY ([product2category_id])
;

-- ----------------------------
-- Indexes structure for table cw_product_images
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table [dbo].[cw_product_images]
-- ----------------------------
ALTER TABLE [dbo].[cw_product_images] ADD PRIMARY KEY ([product_image_id])
;

-- ----------------------------
-- Indexes structure for table cw_product_options
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table [dbo].[cw_product_options]
-- ----------------------------
ALTER TABLE [dbo].[cw_product_options] ADD PRIMARY KEY ([product_options_id])
;

-- ----------------------------
-- Indexes structure for table cw_product_upsell
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table [dbo].[cw_product_upsell]
-- ----------------------------
ALTER TABLE [dbo].[cw_product_upsell] ADD PRIMARY KEY ([upsell_id])
;

-- ----------------------------
-- Indexes structure for table cw_products
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table [dbo].[cw_products]
-- ----------------------------
ALTER TABLE [dbo].[cw_products] ADD PRIMARY KEY ([product_id])
;

-- ----------------------------
-- Indexes structure for table cw_ship_method_countries
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table [dbo].[cw_ship_method_countries]
-- ----------------------------
ALTER TABLE [dbo].[cw_ship_method_countries] ADD PRIMARY KEY ([ship_method_country_id])
;

-- ----------------------------
-- Indexes structure for table cw_ship_methods
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table [dbo].[cw_ship_methods]
-- ----------------------------
ALTER TABLE [dbo].[cw_ship_methods] ADD PRIMARY KEY ([ship_method_id])
;

-- ----------------------------
-- Indexes structure for table cw_ship_ranges
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table [dbo].[cw_ship_ranges]
-- ----------------------------
ALTER TABLE [dbo].[cw_ship_ranges] ADD PRIMARY KEY ([ship_range_id])
;

-- ----------------------------
-- Indexes structure for table cw_sku_options
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table [dbo].[cw_sku_options]
-- ----------------------------
ALTER TABLE [dbo].[cw_sku_options] ADD PRIMARY KEY ([sku_option_id])
;

-- ----------------------------
-- Indexes structure for table cw_skus
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table [dbo].[cw_skus]
-- ----------------------------
ALTER TABLE [dbo].[cw_skus] ADD PRIMARY KEY ([sku_id])
;

-- ----------------------------
-- Indexes structure for table cw_stateprov
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table [dbo].[cw_stateprov]
-- ----------------------------
ALTER TABLE [dbo].[cw_stateprov] ADD PRIMARY KEY ([stateprov_id])
;

-- ----------------------------
-- Indexes structure for table cw_tax_groups
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table [dbo].[cw_tax_groups]
-- ----------------------------
ALTER TABLE [dbo].[cw_tax_groups] ADD PRIMARY KEY ([tax_group_id])
;

-- ----------------------------
-- Indexes structure for table cw_tax_rates
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table [dbo].[cw_tax_rates]
-- ----------------------------
ALTER TABLE [dbo].[cw_tax_rates] ADD PRIMARY KEY ([tax_rate_id])
;

-- ----------------------------
-- Indexes structure for table cw_tax_regions
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table [dbo].[cw_tax_regions]
-- ----------------------------
ALTER TABLE [dbo].[cw_tax_regions] ADD PRIMARY KEY ([tax_region_id])