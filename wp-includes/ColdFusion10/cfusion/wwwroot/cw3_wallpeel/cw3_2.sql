-- phpMyAdmin SQL Dump
-- version 4.4.15.9
-- https://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jan 08, 2019 at 12:07 PM
-- Server version: 5.6.37
-- PHP Version: 5.6.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cw3_2`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbl_adminusers`
--

CREATE TABLE IF NOT EXISTS `tbl_adminusers` (
  `admin_UserID` int(11) NOT NULL,
  `admin_User` varchar(75) DEFAULT NULL,
  `admin_UserName` varchar(75) DEFAULT NULL,
  `admin_Password` varchar(75) DEFAULT NULL,
  `admin_AccessLevel` varchar(75) DEFAULT NULL,
  `admin_LoginDate` datetime DEFAULT NULL,
  `admin_LastLogin` datetime DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_adminusers`
--

INSERT INTO `tbl_adminusers` (`admin_UserID`, `admin_User`, `admin_UserName`, `admin_Password`, `admin_AccessLevel`, `admin_LoginDate`, `admin_LastLogin`) VALUES
(1, 'General Admin', 'admin', 'admin', 'admin', '2019-01-01 17:46:32', '2006-11-26 07:05:53'),
(2, 'Super Admin', 'sa', 'admin', 'superadmin', '2006-11-26 07:05:53', '2006-11-19 09:49:42');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_cart`
--

CREATE TABLE IF NOT EXISTS `tbl_cart` (
  `cart_Line_ID` int(11) NOT NULL,
  `cart_custcart_ID` varchar(50) DEFAULT NULL,
  `cart_sku_ID` int(11) DEFAULT NULL,
  `cart_sku_qty` int(11) DEFAULT NULL,
  `cart_dateadded` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_config`
--

CREATE TABLE IF NOT EXISTS `tbl_config` (
  `config_id` int(11) NOT NULL,
  `config_groupid` int(11) DEFAULT '0',
  `config_variable` varchar(50) DEFAULT NULL,
  `config_name` varchar(50) DEFAULT NULL,
  `config_value` varchar(50) DEFAULT NULL,
  `config_type` varchar(50) DEFAULT NULL,
  `config_description` text,
  `config_possibles` text,
  `config_showmerchant` tinyint(4) DEFAULT '0',
  `config_sort` int(11) DEFAULT '0',
  `config_protected` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_config`
--

INSERT INTO `tbl_config` (`config_id`, `config_groupid`, `config_variable`, `config_name`, `config_value`, `config_type`, `config_description`, `config_possibles`, `config_showmerchant`, `config_sort`, `config_protected`) VALUES
(8, 3, 'CompanyName', 'Company Name', 'Cartweaver Demo Store', 'text', 'This is the name of the store, used on invoices and in email confirmations.', '', 1, 0, 1),
(9, 3, 'CompanyAddress1', 'Address 1', '123 Any St.', 'text', 'The first line of the company address', '', 1, 2, 1),
(10, 3, 'CompanyAddress2', 'Address 2', '', 'text', 'The second line of the company address (if necessary).', '', 1, 3, 1),
(11, 3, 'CompanyCity', 'City', 'Sometown', 'text', 'The company''s city.', '', 1, 4, 1),
(12, 3, 'CompanyState', 'State / Prov', 'WA', 'text', 'The state or province the company is located in.', '', 1, 5, 1),
(13, 3, 'CompanyZip', 'Postal Code', '98765', 'text', 'The company''s postal or zip code.', '', 1, 6, 1),
(14, 3, 'CompanyCountry', 'Country', 'USA', 'text', 'The company''s country.', '', 1, 7, 1),
(15, 3, 'CompanyPhone', 'Phone', '555-555-1236', 'text', 'The company phone number.', '', 1, 8, 1),
(16, 3, 'CompanyFax', 'Fax', '', 'text', 'The company fax number.', '', 1, 9, 1),
(17, 3, 'CompanyEmail', 'Email', 'support@cartweaver.com', 'text', 'This is the company email. All automated emails are sent from this address, and order confirmations are sent to this address.', '', 1, 10, 1),
(18, 5, 'ChargeTaxonShipping', 'Charge Tax on Shipping', 'True', 'boolean', 'Determines whether tax is charged on the shipping total for an order.', '', 1, 0, 1),
(19, 5, 'DisplayLineItemTaxes', 'Display Line Item Taxes', 'True', 'boolean', 'Determines whether line item taxes are displayed in the customer''s shopping cart.', '', 1, 0, 1),
(20, 5, 'DisplayTaxOnProduct', 'Display Product Price Including and Excluding Tax', 'True', 'boolean', 'Determines whether prices including taxes are displayed on the product detail pages.', '', 1, 0, 1),
(21, 5, 'TaxIDNumber', 'Tax ID Number', '', 'text', 'Tax ID Number, or VAT number. Can be displayed on the customer invoice if necessary.', '', 1, 0, 1),
(22, 5, 'DisplayTaxID', 'Display TAX ID Number on Invoice', 'False', 'boolean', 'Determines whether the Tax ID Number is displayed on the customer''s invoice.', '', 1, 0, 1),
(25, 6, 'EnableShipping', 'Enable Shipping', 'True', 'boolean', 'Determines if shipping calculations are performed during checkout.', '', 1, 1, 1),
(26, 6, 'ChargeShipBase', 'Charge Base', 'True', 'boolean', 'Determines if a base rate is charged during shipping calculations.', '', 1, 2, 1),
(28, 6, 'ChargeShipExtension', 'Charge Location Extension', 'True', 'boolean', 'Determines if an additional charge is added to the shipping costs based on the user''s geographical location.', '', 1, 4, 1),
(29, 7, 'AllowBackOrders', 'Allow Backorders', 'True', 'boolean', 'Determines if backorders are allowed in the application. If this option is disabled, all products must have a positive stock count in order to display on the site.', '', 1, 0, 1),
(30, 8, 'showupsell', 'Show Up-sell', 'True', 'boolean', 'Determines whether upsell products are displayed on the product details pages.', '', 1, 0, 1),
(31, 7, 'shipcalctype', 'Ship Calculation Type', 'localcalc', 'text', 'Determines the type of shipping calculation to perform. The default application only supports local shipping calculations.', '', 0, 0, 1),
(32, 8, 'NumberOfColumns', 'Number of Columns', '2', 'text', 'The number of columns to be displayed on the product results page. Set this value to 1 to show the product short description and image. Set this value to any number greater than 1 to show only the product name and image in multiple columns.', '', 1, 0, 1),
(33, 8, 'ResultsPerPage', 'Results per Page', '4', 'text', 'This value should be evenly divisible by the Number of Columns in order to ensure correct display for multi-column results.', '', 1, 0, 1),
(34, 8, 'DetailsDisplay', 'Details Display', 'Advanced', 'select', 'Determines how product option details are displayed.', 'Advanced|Advanced\r\nSimple|Simple\r\nTables|Tables', 1, 0, 1),
(36, 10, 'ShowApplication', 'Show Application Variables', 'True', 'boolean', 'Show application variables when debugging is turned on', 'NULL', 0, 1, 1),
(37, 10, 'ShowSession', 'Show Session Variables', 'True', 'boolean', 'Show session variables when debugging is turned on', 'NULL', 0, 2, 1),
(38, 10, 'ShowRequest', 'Show Request Variables', 'True', 'boolean', 'Show request variables when debugging is turned on', 'NULL', 0, 3, 1),
(39, 10, 'ShowServer', 'Show Server Variables', 'False', 'boolean', 'Show server variables when debugging is turned on', 'NULL', 0, 4, 1),
(40, 10, 'ShowURL', 'Show URL Variables', 'False', 'boolean', 'Show URL variables when debugging is turned on', 'NULL', 0, 5, 1),
(41, 10, 'ShowLocal', 'Show Local Variables (and queries)', 'False', 'boolean', 'Show local variables when debugging is turned on', 'NULL', 0, 6, 1),
(42, 10, 'ShowForm', 'Show Form Variables', 'False', 'boolean', 'Show form variables when debugging is turned on', 'NULL', 0, 7, 1),
(43, 10, 'ShowCookie', 'Show Cookie Variables', 'False', 'boolean', 'Show cookie variables when debugging is turned on', 'NULL', 0, 8, 1),
(44, 10, 'ShowCGI', 'Show CGI Variables', 'False', 'boolean', 'Show CGI variables when debugging is turned on', 'NULL', 0, 9, 1),
(45, 10, 'ShowDebugLink', 'Show Debug Link', 'False', 'boolean', 'If debugging is turned on, should the cart show a link?', '', 0, 0, 1),
(46, 10, 'EnableDebugging', 'Enable Debugging', 'True', 'boolean', 'Enable debugging during development.', 'NULL', 0, 0, 1),
(47, 11, 'DisplayLineItemDiscount', 'Display Line Item Discount', 'True', 'boolean', 'Displays a line item discount in the shopping cart if checked and if the product is discounted', 'NULL', 1, 0, 0),
(48, 11, 'EnableDiscounts', 'Enable Discounts', 'True', 'boolean', 'Enables the discount feature in the store. If unchecked, discounts are disabled.', 'NULL', 1, 0, 0),
(50, 11, 'DisplayDiscountNotes', 'Display Discount Notes on Cart', 'True', 'boolean', 'Show an asterisk in the cart line item and tie it to a discount description below.', 'NULL', 1, 5, 0),
(51, 8, 'ShowImageInCart', 'Show Small Image in Cart', 'True', 'boolean', 'Determines whether the extra small images are displayed in the\r\nuser''s cart.\r\n', 'NULL', 1, 0, 0),
(52, 6, 'ChargeShipBy', 'Charge Range Based On', 'Subtotal', 'select', 'This value determines how shipping ranges are calculated. This value is either ignored (if set to "None"), or shipping ranges are calculated on the Cart Subtotal or total Cart Weight', 'None|None\r\nCart Subtotal|Subtotal\r\nCart Weight|Weight', 1, 0, 0),
(53, 8, 'RelateCategoriesSecondaries', 'Relate Categories/Secondaries', '1', 'boolean', 'Check the box if your categories and secondary categories are related. Relationships are handled at the product level.', 'NULL', 1, 0, 0),
(54, 8, 'ShowImagePopup', 'Show Expanded Image Popup', 'True', 'boolean', 'Determines whether a popup image is shown on the details page.', 'NULL', 1, 0, 0),
(55, 7, 'VersionNumber', 'Cartweaver Version Number', '3.0.14', 'text', 'The current Cartweaver version number is stored here for ', 'NULL', 1, 100, 0),
(56, 3, 'DeveloperEmail', 'Developer Email', '', 'text', 'Debugging and error emails will go to this address. If not defined, emails will go to the CompanyEmail', 'NULL', 0, 100, NULL),
(57, 10, 'EnableErrorHandling', 'Enable Error Handling', 'False', 'boolean', 'Determines whether or not error handling will be enabled on the site.', 'NULL', 0, 0, 1),
(58, 10, 'ShowClient', 'Show Client Variables', 'False', 'boolean', 'Show client variables when debugging is turned on', 'NULL', 0, 10, 1),
(59, 5, 'TaxSystem', 'Tax System', 'General', 'radio', 'Determine which tax system to use -- tax groups or general tax', 'Groups|Groups\r\nGeneral|General', 0, 10, NULL),
(60, 5, 'ChargeTaxBasedOn', 'ChargeTaxBasedOn', 'Shipping', 'radio', 'Taxes can be charged based on billing or shipping address, depending on state/country laws', 'Shipping Address|Shipping\r\nBilling Address|Billing', 0, 10, 0),
(61, 7, 'ContinueShopping', 'Continue Shopping', 'Details', 'radio', 'When the user clicks Continue Shopping on the cart page after adding an item, they can return to details, results, or home page', 'Details|Details\r\nResults|Results\r\nHome|Home', 1, 10, NULL),
(62, 6, 'ShowShippingInfo', 'Show Shipping Information', 'True', 'boolean', 'Shows the shipping form fields on the order form if checked', '', 1, 100, 0);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_configgroup`
--

CREATE TABLE IF NOT EXISTS `tbl_configgroup` (
  `configgroup_id` int(11) NOT NULL,
  `configgroup_name` varchar(50) DEFAULT NULL,
  `configgroup_sort` int(11) DEFAULT '0',
  `configgroup_showmerchant` tinyint(4) DEFAULT '0',
  `configgroup_protected` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_configgroup`
--

INSERT INTO `tbl_configgroup` (`configgroup_id`, `configgroup_name`, `configgroup_sort`, `configgroup_showmerchant`, `configgroup_protected`) VALUES
(3, 'Company Info.', 0, 1, 1),
(5, 'Tax Settings', 0, 1, 1),
(6, 'Shipping Settings', 0, 1, 1),
(7, 'Misc. Settings', 0, 1, 1),
(8, 'Display Settings', 0, 1, 1),
(10, 'Debug Settings', 0, 0, 0),
(11, 'Discount Settings', 0, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_customers`
--

CREATE TABLE IF NOT EXISTS `tbl_customers` (
  `cst_ID` varchar(50) NOT NULL DEFAULT '',
  `cst_Type_ID` int(11) DEFAULT NULL,
  `cst_FirstName` varchar(50) DEFAULT NULL,
  `cst_LastName` varchar(50) DEFAULT NULL,
  `cst_Address1` varchar(150) DEFAULT NULL,
  `cst_Address2` varchar(150) DEFAULT NULL,
  `cst_City` varchar(50) DEFAULT NULL,
  `cst_Zip` varchar(20) DEFAULT NULL,
  `cst_ShpName` varchar(50) DEFAULT NULL,
  `cst_ShpAddress1` varchar(150) DEFAULT NULL,
  `cst_ShpAddress2` varchar(100) DEFAULT NULL,
  `cst_ShpCity` varchar(50) DEFAULT NULL,
  `cst_ShpZip` varchar(50) DEFAULT NULL,
  `cst_Phone` varchar(30) DEFAULT NULL,
  `cst_Email` varchar(50) DEFAULT NULL,
  `cst_Username` varchar(20) DEFAULT NULL,
  `cst_Password` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_customers`
--

INSERT INTO `tbl_customers` (`cst_ID`, `cst_Type_ID`, `cst_FirstName`, `cst_LastName`, `cst_Address1`, `cst_Address2`, `cst_City`, `cst_Zip`, `cst_ShpName`, `cst_ShpAddress1`, `cst_ShpAddress2`, `cst_ShpCity`, `cst_ShpZip`, `cst_Phone`, `cst_Email`, `cst_Username`, `cst_Password`) VALUES
('1', 1, 'Bob', 'Buyer', '1234 St.', '', 'Sometown', '98801', 'Bob Buyer', '1234 St.', '', 'Sometown', '98801', '123.456.7890', 'test@testemail.com', 'test', 'test'),
('AE7EF16E-01-02-19', 1, 'Margaret', 'Gulya', '5566 Bent Oak dr', '', 'Sarasota', '34232', 'Margaret Gulya', '5566 Bent Oak dr', '', 'Sarasota', '34232', '9417353228', 'info@gulfgatepackandship.com', 'demo', 'demo'),
('D3970516-11-10-06', 1, 'Jane', 'Shopsalot', '123 Ave', '', 'Mysville', '87654', 'Jane Shopsalot', '123 Ave', '', 'Mysville', '87654', '555-555-1234', 'shopsalot@spendmore.com', 'Jane', 'test2');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_custstate`
--

CREATE TABLE IF NOT EXISTS `tbl_custstate` (
  `CustSt_ID` int(11) NOT NULL,
  `CustSt_Cust_ID` varchar(50) NOT NULL DEFAULT '',
  `CustSt_StPrv_ID` int(11) DEFAULT NULL,
  `CustSt_Destination` varchar(50) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=130 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_custstate`
--

INSERT INTO `tbl_custstate` (`CustSt_ID`, `CustSt_Cust_ID`, `CustSt_StPrv_ID`, `CustSt_Destination`) VALUES
(117, '1', 1, 'BillTo'),
(118, '1', 1, 'ShipTo'),
(126, 'D3970516-11-10-06', 6, 'BillTo'),
(127, 'D3970516-11-10-06', 6, 'ShipTo'),
(128, 'AE7EF16E-01-02-19', 9, 'BillTo'),
(129, 'AE7EF16E-01-02-19', 9, 'ShipTo');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_custtype`
--

CREATE TABLE IF NOT EXISTS `tbl_custtype` (
  `custtype_ID` int(11) NOT NULL,
  `custtype_Name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_custtype`
--

INSERT INTO `tbl_custtype` (`custtype_ID`, `custtype_Name`) VALUES
(1, 'Retail'),
(2, 'Wholesale');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_discounts`
--

CREATE TABLE IF NOT EXISTS `tbl_discounts` (
  `discount_id` int(11) NOT NULL,
  `discount_reference_id` varchar(50) DEFAULT NULL,
  `discount_name` varchar(100) DEFAULT NULL,
  `discount_description` varchar(100) DEFAULT NULL,
  `discount_promotionalCode` varchar(100) DEFAULT NULL,
  `discount_startDate` datetime DEFAULT NULL,
  `discount_endDate` datetime DEFAULT NULL,
  `discount_archive` tinyint(4) DEFAULT NULL,
  `discount_type` int(11) DEFAULT NULL,
  `discount_applyType` int(11) DEFAULT NULL,
  `discount_usage` int(11) DEFAULT NULL,
  `discount_limit` int(11) DEFAULT NULL,
  `discount_showDesc` int(11) DEFAULT NULL,
  `discount_applyTo` varchar(50) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_discounts`
--

INSERT INTO `tbl_discounts` (`discount_id`, `discount_reference_id`, `discount_name`, `discount_description`, `discount_promotionalCode`, `discount_startDate`, `discount_endDate`, `discount_archive`, `discount_type`, `discount_applyType`, `discount_usage`, `discount_limit`, `discount_showDesc`, `discount_applyTo`) VALUES
(64, 'test', 'test', 'test', '', '2006-10-01 00:00:00', '2006-11-07 00:00:00', 0, 1, 1, NULL, 0, 1, 'specific'),
(65, 'MailerDiscount_001', 'Mailer Discount', 'Discount code sent out in mailer', 'MailerDiscount_11032006', '2006-11-03 00:00:00', '2008-11-24 00:00:00', 0, 1, 1, NULL, 0, 1, 'all'),
(66, 'GlobalDiscount001', 'Global Discount', 'Your discount "Description" is displayed here. "For a limited time 10% everything!"', '', '2006-11-03 00:00:00', '2009-11-10 00:00:00', 0, 1, 1, NULL, 0, 1, 'all');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_discounts_products_rel`
--

CREATE TABLE IF NOT EXISTS `tbl_discounts_products_rel` (
  `discounts_products_rel_id` int(11) NOT NULL,
  `discounts_products_rel_discount_id` int(11) NOT NULL DEFAULT '0',
  `discounts_products_rel_prod_id` int(11) NOT NULL DEFAULT '0',
  `discounts_products_rel_active` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_discounts_skus_rel`
--

CREATE TABLE IF NOT EXISTS `tbl_discounts_skus_rel` (
  `discounts_skus_rel_id` int(11) NOT NULL,
  `discounts_skus_rel_discount_id` int(11) NOT NULL DEFAULT '0',
  `discounts_skus_rel_sku_id` int(11) NOT NULL DEFAULT '0',
  `discounts_skus_rel_active` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_discounts_skus_rel`
--

INSERT INTO `tbl_discounts_skus_rel` (`discounts_skus_rel_id`, `discounts_skus_rel_discount_id`, `discounts_skus_rel_sku_id`, `discounts_skus_rel_active`) VALUES
(64, 64, 29, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_discount_amounts`
--

CREATE TABLE IF NOT EXISTS `tbl_discount_amounts` (
  `discountAmount_id` int(11) NOT NULL,
  `discountAmount_discount_id` int(11) NOT NULL DEFAULT '0',
  `discountAmount_discount` decimal(20,4) NOT NULL DEFAULT '0.0000',
  `discountAmount_minimumQty` int(11) DEFAULT NULL,
  `discountAmount_minimumAmount` decimal(20,4) DEFAULT NULL,
  `discountAmount_rateType` varchar(50) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_discount_amounts`
--

INSERT INTO `tbl_discount_amounts` (`discountAmount_id`, `discountAmount_discount_id`, `discountAmount_discount`, `discountAmount_minimumQty`, `discountAmount_minimumAmount`, `discountAmount_rateType`) VALUES
(35, 64, '10.0000', 0, '0.0000', '0'),
(36, 65, '15.0000', 0, '0.0000', '0'),
(37, 66, '10.0000', 0, '0.0000', '0');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_discount_apply_types`
--

CREATE TABLE IF NOT EXISTS `tbl_discount_apply_types` (
  `discountApplyType_id` int(11) NOT NULL,
  `discountApplyType_desc` varchar(100) NOT NULL DEFAULT '',
  `discountApplyType_archive` tinyint(4) NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_discount_apply_types`
--

INSERT INTO `tbl_discount_apply_types` (`discountApplyType_id`, `discountApplyType_desc`, `discountApplyType_archive`) VALUES
(1, 'Purchase', 0);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_discount_types`
--

CREATE TABLE IF NOT EXISTS `tbl_discount_types` (
  `discountType_id` int(11) NOT NULL,
  `discountType_desc` varchar(100) DEFAULT NULL,
  `discountType_archive` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_discount_types`
--

INSERT INTO `tbl_discount_types` (`discountType_id`, `discountType_desc`, `discountType_archive`) VALUES
(1, 'Flat Rate', 0);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_discount_usage`
--

CREATE TABLE IF NOT EXISTS `tbl_discount_usage` (
  `discountUsage_id` int(11) NOT NULL,
  `discountUsage_customer` varchar(50) DEFAULT NULL,
  `discountUsage_discount_id` int(11) DEFAULT '0',
  `discountUsage_count` int(11) DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_discount_usage`
--

INSERT INTO `tbl_discount_usage` (`discountUsage_id`, `discountUsage_customer`, `discountUsage_discount_id`, `discountUsage_count`) VALUES
(4, '1', 64, 1),
(5, 'D3970516-11-10-06', 65, 1),
(6, '1', 65, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_list_ccards`
--

CREATE TABLE IF NOT EXISTS `tbl_list_ccards` (
  `ccard_ID` int(11) NOT NULL,
  `ccard_Name` varchar(50) DEFAULT NULL,
  `ccard_Code` varchar(50) DEFAULT NULL,
  `ccard_Archive` smallint(6) DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_list_ccards`
--

INSERT INTO `tbl_list_ccards` (`ccard_ID`, `ccard_Name`, `ccard_Code`, `ccard_Archive`) VALUES
(2, 'Master Card', 'master', 0),
(3, 'American Express', 'amex', 0),
(4, 'Discover', 'discover', 0),
(18, 'Visa', 'visa', 0);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_list_countries`
--

CREATE TABLE IF NOT EXISTS `tbl_list_countries` (
  `country_ID` int(11) NOT NULL,
  `country_Name` varchar(50) DEFAULT NULL,
  `country_Code` varchar(50) DEFAULT NULL,
  `country_Sort` int(11) DEFAULT '0',
  `country_Archive` smallint(6) DEFAULT '0',
  `country_DefaultCountry` int(11) DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_list_countries`
--

INSERT INTO `tbl_list_countries` (`country_ID`, `country_Name`, `country_Code`, `country_Sort`, `country_Archive`, `country_DefaultCountry`) VALUES
(1, 'United States', 'USA', 1, 0, 0),
(2, 'US Territories', 'USA_Terr', 2, 0, 0),
(3, 'Canada', 'CA', 3, 0, 0),
(4, 'Italy', 'IT', 0, 0, 0),
(5, 'United Kingdom', 'UK', 4, 0, 1),
(6, 'France', 'FRA', 0, 0, 0),
(7, 'Belgium', 'BEL', 0, 0, 0),
(8, 'Germany', 'GER', 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_list_imagetypes`
--

CREATE TABLE IF NOT EXISTS `tbl_list_imagetypes` (
  `imgType_ID` int(11) NOT NULL,
  `imgType_Name` varchar(100) DEFAULT NULL,
  `imgType_SortOrder` int(11) DEFAULT NULL,
  `imgType_Folder` varchar(50) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_list_imagetypes`
--

INSERT INTO `tbl_list_imagetypes` (`imgType_ID`, `imgType_Name`, `imgType_SortOrder`, `imgType_Folder`) VALUES
(1, 'Thumbnail', 1, 'cw3/assets/product_thumb/'),
(2, 'Large', 2, 'cw3/assets/product_full/'),
(3, 'Expanded', 3, 'cw3/assets/product_expanded/'),
(4, 'Extra Small Image', 4, 'cw3/assets/product_small/');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_list_optiontypes`
--

CREATE TABLE IF NOT EXISTS `tbl_list_optiontypes` (
  `optiontype_ID` int(11) NOT NULL,
  `optiontype_Required` tinyint(4) DEFAULT '1',
  `optiontype_Name` varchar(75) DEFAULT NULL,
  `optiontype_Archive` smallint(6) DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_list_optiontypes`
--

INSERT INTO `tbl_list_optiontypes` (`optiontype_ID`, `optiontype_Required`, `optiontype_Name`, `optiontype_Archive`) VALUES
(1, 1, 'Size', 0),
(2, 1, 'Color', 0),
(3, 1, 'Cut', 0),
(4, 1, 'Other', 0);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_list_shipstatus`
--

CREATE TABLE IF NOT EXISTS `tbl_list_shipstatus` (
  `shipstatus_id` int(11) NOT NULL,
  `shipstatus_Name` varchar(70) DEFAULT NULL,
  `shipstatus_Sort` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_list_shipstatus`
--

INSERT INTO `tbl_list_shipstatus` (`shipstatus_id`, `shipstatus_Name`, `shipstatus_Sort`) VALUES
(1, 'Pending', 1),
(2, 'Verified', 2),
(3, 'Shipped', 3),
(4, 'Canceled', 4),
(5, 'Returned', 5);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_orders`
--

CREATE TABLE IF NOT EXISTS `tbl_orders` (
  `order_ID` varchar(75) NOT NULL DEFAULT '',
  `order_TransactionID` varchar(50) DEFAULT NULL,
  `order_Date` datetime DEFAULT NULL,
  `order_Status` int(11) DEFAULT '0',
  `order_CustomerID` varchar(50) NOT NULL DEFAULT '',
  `order_Tax` double DEFAULT '0',
  `order_Shipping` double DEFAULT '0',
  `order_ShippingTax` double DEFAULT '0',
  `order_Total` double DEFAULT '0',
  `order_ShipMeth_ID` int(11) DEFAULT '0',
  `order_ShipDate` datetime DEFAULT NULL,
  `order_ShipTrackingID` varchar(100) DEFAULT NULL,
  `order_Address1` varchar(125) DEFAULT NULL,
  `order_Address2` varchar(50) DEFAULT NULL,
  `order_City` varchar(100) DEFAULT NULL,
  `order_State` varchar(50) DEFAULT NULL,
  `order_Zip` varchar(50) DEFAULT NULL,
  `order_Country` varchar(75) DEFAULT NULL,
  `order_Notes` text,
  `order_ActualShipCharge` double DEFAULT '0',
  `order_ShipName` varchar(75) DEFAULT NULL,
  `order_Comments` varchar(255) DEFAULT NULL,
  `order_DiscountID` int(11) DEFAULT '0',
  `order_DiscountAmount` double DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_orders`
--

INSERT INTO `tbl_orders` (`order_ID`, `order_TransactionID`, `order_Date`, `order_Status`, `order_CustomerID`, `order_Tax`, `order_Shipping`, `order_ShippingTax`, `order_Total`, `order_ShipMeth_ID`, `order_ShipDate`, `order_ShipTrackingID`, `order_Address1`, `order_Address2`, `order_City`, `order_State`, `order_Zip`, `order_Country`, `order_Notes`, `order_ActualShipCharge`, `order_ShipName`, `order_Comments`, `order_DiscountID`, `order_DiscountAmount`) VALUES
('AE85931F-C721-2630-7306CF65C01F3D2D', '4097540', '2019-01-02 21:03:45', 1, 'AE7EF16E-01-02-19', 0, 0, 0, 27.98, 35, NULL, NULL, '5566 Bent Oak dr', '', 'Sarasota', 'FL', '34232', 'USA', NULL, 0, 'Margaret Gulya', '', 0, 0),
('B412BC21-0A63-E73C-F2AE5FC28EB86E51', '2776080', '2006-11-04 12:44:56', 1, '1', 0.71, 37.4, 0, 51.87554, 35, NULL, NULL, '1234 St.', '', 'Sometown', 'AL', '98801', 'USA', NULL, 0, 'Bob Buyer', '', 0, 0),
('D39C2BB0-E9AA-C7BB-445E51CFA22A76B6', '5430656', '2006-11-10 12:43:17', 1, 'D3970516-11-10-06', 0, 34, 0, 259.25, 35, NULL, NULL, '123 Ave', '', 'Mysville', 'CO', '87654', 'USA', NULL, 0, 'Jane Shopsalot', '', 0, 0),
('D4E14B13-A2E2-2F84-B597120889E984A4', '4217872', '2006-11-10 18:38:24', 1, '1', 1.72, 37.4, 0, 52.51328, 35, NULL, NULL, '1234 St.', '', 'Sometown', 'AL', '98801', 'USA', NULL, 0, 'Bob Buyer', '', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_orderskus`
--

CREATE TABLE IF NOT EXISTS `tbl_orderskus` (
  `orderSKU_ID` int(11) NOT NULL,
  `orderSKU_OrderID` varchar(50) NOT NULL DEFAULT '',
  `orderSKU_SKU` int(11) NOT NULL DEFAULT '0',
  `orderSKU_Quantity` int(11) DEFAULT NULL,
  `orderSKU_UnitPrice` double DEFAULT NULL,
  `orderSKU_SKUTotal` double DEFAULT '0',
  `orderSKU_Picked` smallint(6) DEFAULT '0',
  `orderSKU_TaxRate` double DEFAULT '0',
  `orderSKU_TaxRateID` int(11) DEFAULT '0',
  `orderSKU_DiscountID` int(11) DEFAULT '0',
  `orderSKU_DiscountAmount` double DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_orderskus`
--

INSERT INTO `tbl_orderskus` (`orderSKU_ID`, `orderSKU_OrderID`, `orderSKU_SKU`, `orderSKU_Quantity`, `orderSKU_UnitPrice`, `orderSKU_SKUTotal`, `orderSKU_Picked`, `orderSKU_TaxRate`, `orderSKU_TaxRateID`, `orderSKU_DiscountID`, `orderSKU_DiscountAmount`) VALUES
(54, 'B412BC21-0A63-E73C-F2AE5FC28EB86E51', 29, 1, 15, 13.5, 0, 0.71, 0, 64, 1.5),
(55, 'D39C2BB0-E9AA-C7BB-445E51CFA22A76B6', 58, 1, 65, 55.25, 0, 0, 0, 65, 9.75),
(56, 'D39C2BB0-E9AA-C7BB-445E51CFA22A76B6', 44, 2, 100, 170, 0, 0, 0, 65, 15),
(57, 'D4E14B13-A2E2-2F84-B597120889E984A4', 28, 1, 15, 12.75, 0, 1.72, 0, 65, 2.25),
(58, 'AE85931F-C721-2630-7306CF65C01F3D2D', 62, 2, 13.99, 27.98, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_prdtcategories`
--

CREATE TABLE IF NOT EXISTS `tbl_prdtcategories` (
  `category_ID` int(11) NOT NULL,
  `category_Name` varchar(75) DEFAULT NULL,
  `category_archive` smallint(6) DEFAULT '0',
  `category_sortorder` int(11) DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_prdtcategories`
--

INSERT INTO `tbl_prdtcategories` (`category_ID`, `category_Name`, `category_archive`, `category_sortorder`) VALUES
(2, 'Clothing', 0, 0),
(4, 'Housewares', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_prdtcat_rel`
--

CREATE TABLE IF NOT EXISTS `tbl_prdtcat_rel` (
  `prdt_cat_rel_ID` int(11) NOT NULL,
  `prdt_cat_rel_Product_ID` int(11) DEFAULT '0',
  `prdt_cat_rel_Cat_ID` int(11) DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_prdtcat_rel`
--

INSERT INTO `tbl_prdtcat_rel` (`prdt_cat_rel_ID`, `prdt_cat_rel_Product_ID`, `prdt_cat_rel_Cat_ID`) VALUES
(49, 29, 4),
(57, 31, 4),
(58, 21, 2),
(59, 22, 2),
(60, 27, 4),
(61, 24, 4),
(62, 24, 2),
(63, 23, 4),
(64, 32, 2);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_prdtimages`
--

CREATE TABLE IF NOT EXISTS `tbl_prdtimages` (
  `prdctImage_ID` int(11) NOT NULL,
  `prdctImage_ProductID` int(11) DEFAULT '0',
  `prdctImage_ImgTypeID` int(11) DEFAULT '0',
  `prdctImage_FileName` varchar(50) DEFAULT NULL,
  `prdctImage_SortOrder` int(11) DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_prdtimages`
--

INSERT INTO `tbl_prdtimages` (`prdctImage_ID`, `prdctImage_ProductID`, `prdctImage_ImgTypeID`, `prdctImage_FileName`, `prdctImage_SortOrder`) VALUES
(33, 29, 2, 'product_full.gif', 1),
(42, 29, 1, 'product_thumb.gif', 1),
(43, 29, 3, 'product_expanded.gif', 1),
(44, 29, 4, 'product_small.gif', 1),
(45, 31, 1, 'product_thumb.gif', 1),
(46, 31, 3, 'product_expanded.gif', 1),
(47, 31, 4, 'product_small.gif', 1),
(48, 23, 1, 'product_thumb.gif', 1),
(49, 23, 3, 'product_expanded.gif', 1),
(50, 23, 4, 'product_small.gif', 1),
(51, 24, 1, 'product_thumb.gif', 1),
(52, 24, 3, 'product_expanded.gif', 1),
(53, 24, 4, 'product_small.gif', 1),
(54, 27, 1, 'product_thumb.gif', 1),
(55, 27, 3, 'product_expanded.gif', 1),
(56, 27, 4, 'product_small.gif', 1),
(57, 22, 1, 'product_thumb.gif', 1),
(58, 22, 3, 'product_expanded.gif', 1),
(59, 22, 4, 'product_small.gif', 1),
(60, 21, 1, 'product_thumb.gif', 1),
(61, 21, 3, 'product_expanded.gif', 1),
(62, 21, 4, 'product_small.gif', 1),
(63, 21, 2, 'product_full.gif', 1),
(64, 22, 2, 'product_full.gif', 1),
(65, 27, 2, 'product_full.gif', 1),
(66, 24, 2, 'product_full.gif', 1),
(67, 23, 2, 'product_full.gif', 1),
(68, 32, 1, 'product_thumb.gif', 1),
(69, 32, 2, 'PlaceHolder_Lrg.gif', 1),
(70, 32, 3, 'product_expanded.gif', 1),
(71, 32, 4, 'product_small.gif', 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_prdtoption_rel`
--

CREATE TABLE IF NOT EXISTS `tbl_prdtoption_rel` (
  `optn_rel_ID` int(11) NOT NULL,
  `optn_rel_Prod_ID` int(11) NOT NULL DEFAULT '0',
  `optn_rel_OptionType_ID` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=161 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_prdtoption_rel`
--

INSERT INTO `tbl_prdtoption_rel` (`optn_rel_ID`, `optn_rel_Prod_ID`, `optn_rel_OptionType_ID`) VALUES
(120, 21, 2),
(136, 29, 2),
(137, 29, 3),
(138, 29, 4),
(139, 29, 1),
(154, 31, 4),
(155, 22, 1),
(156, 24, 2),
(157, 24, 3),
(158, 24, 1),
(159, 23, 2),
(160, 23, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_prdtscndcats`
--

CREATE TABLE IF NOT EXISTS `tbl_prdtscndcats` (
  `scndctgry_ID` int(11) NOT NULL,
  `scndctgry_Name` varchar(100) DEFAULT NULL,
  `scndctgry_Archive` smallint(6) DEFAULT '0',
  `scndctgry_Sort` int(11) DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_prdtscndcats`
--

INSERT INTO `tbl_prdtscndcats` (`scndctgry_ID`, `scndctgry_Name`, `scndctgry_Archive`, `scndctgry_Sort`) VALUES
(2, 'Men''s', 0, 0),
(3, 'Women''s', 0, 0),
(4, 'Children''s', 0, 0),
(5, 'Shirts', 0, 0),
(6, 'Pants', 0, 0),
(7, 'Training', 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_prdtscndcat_rel`
--

CREATE TABLE IF NOT EXISTS `tbl_prdtscndcat_rel` (
  `prdt_scnd_rel_ID` int(11) NOT NULL,
  `prdt_scnd_rel_Product_ID` int(11) DEFAULT '0',
  `prdt_scnd_rel_ScndCat_ID` int(11) DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=229 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_prdtscndcat_rel`
--

INSERT INTO `tbl_prdtscndcat_rel` (`prdt_scnd_rel_ID`, `prdt_scnd_rel_Product_ID`, `prdt_scnd_rel_ScndCat_ID`) VALUES
(211, 29, 2),
(220, 21, 2),
(221, 21, 3),
(222, 22, 2),
(223, 22, 5),
(224, 24, 2),
(225, 24, 3),
(226, 24, 4),
(227, 23, 7),
(228, 32, 3);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_prdtupsell`
--

CREATE TABLE IF NOT EXISTS `tbl_prdtupsell` (
  `upsell_id` int(11) NOT NULL,
  `upsell_ProdID` int(11) DEFAULT '0',
  `upsell_RelProdID` int(11) DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_prdtupsell`
--

INSERT INTO `tbl_prdtupsell` (`upsell_id`, `upsell_ProdID`, `upsell_RelProdID`) VALUES
(1, 24, 29),
(2, 24, 27),
(3, 24, 23);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_products`
--

CREATE TABLE IF NOT EXISTS `tbl_products` (
  `product_ID` int(11) NOT NULL,
  `product_MerchantProductID` varchar(50) NOT NULL DEFAULT '',
  `product_Name` varchar(125) DEFAULT NULL,
  `product_Description` text,
  `product_ShortDescription` text,
  `product_Sort` int(11) DEFAULT '0',
  `product_OnWeb` smallint(6) DEFAULT '0',
  `product_Archive` smallint(6) DEFAULT '0',
  `product_shipchrg` smallint(6) DEFAULT '0',
  `product_taxgroupid` int(11) DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_products`
--

INSERT INTO `tbl_products` (`product_ID`, `product_MerchantProductID`, `product_Name`, `product_Description`, `product_ShortDescription`, `product_Sort`, `product_OnWeb`, `product_Archive`, `product_shipchrg`, `product_taxgroupid`) VALUES
(21, '1option', 'One Option Product', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Vestibulum vel augue quis velit vulputate commodo. Sed leo magna, adipiscing ut, nonummy ac, pulvinar at, libero. Sed vulputate. Etiam sed purus. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec porta. Pellentesque vel mauris ac dolor vulputate tincidunt. Aliquam justo eros, vehicula et, aliquet nec, molestie vitae, tellus. Ut mollis imperdiet mauris. Nam aliquam varius tellus. Praesent venenatis tellus vel ligula. Etiam mattis nisl et urna. Donec euismod egestas ipsum. Nulla facilisi. Praesent ac nulla. Sed nec turpis ut neque nonummy euismod. Vivamus sed augue vel magna interdum faucibus. In felis urna, laoreet convallis, facilisis eu, convallis sit amet, ligula. Maecenas consequat ultrices velit.\r\n\r\nDonec facilisis aliquam eros. Morbi lobortis dolor a sapien. Quisque nibh est, tempus nonummy, interdum vel, auctor in, urna. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Etiam rhoncus. Phasellus iaculis, ipsum ac mollis ultricies, nulla massa rutrum pede, et pellentesque massa massa ut massa. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia  In hac habitasse platea dictumst. Curabitur pretium nunc eget odio. Proin orci justo, auctor vel, consectetuer sed, hendrerit eu, tortor. Aliquam pede. Cras turpis purus, iaculis non, tincidunt molestie, hendrerit nec, lacus. Duis bibendum tempor velit.\r\n\r\nNam aliquet purus porttitor mi. Vivamus sed dolor. In hendrerit hendrerit nulla. Donec dapibus elit quis nisl. In eros ante, commodo a, vulputate et, auctor ut, turpis. Vivamus porttitor justo vitae sem. Integer suscipit ullamcorper velit. Morbi sit amet erat. Vestibulum ipsum augue, nonummy non, aliquam in, malesuada in, magna. Suspendisse iaculis.', 'orem ipsum dolor sit amet, consectetuer adipiscing elit. Nullam enim. Proin condimentum iaculis nisl. Fusce euismod, felis non auctor tincidunt, pede purus tempor felis, eu accumsan lacus orci quis velit. Integer at sapien. Suspendisse molestie.', 2, 1, 0, 1, 3),
(22, '1sku', 'Single SKU Product', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Vestibulum vel augue quis velit vulputate commodo. Sed leo magna, adipiscing ut, nonummy ac, pulvinar at, libero. Sed vulputate. Etiam sed purus. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec porta. Pellentesque vel mauris ac dolor vulputate tincidunt. Aliquam justo eros, vehicula et, aliquet nec, molestie vitae, tellus. Ut mollis imperdiet mauris. Nam aliquam varius tellus. Praesent venenatis tellus vel ligula. Etiam mattis nisl et urna. Donec euismod egestas ipsum. Nulla facilisi. Praesent ac nulla. Sed nec turpis ut neque nonummy euismod. Vivamus sed augue vel magna interdum faucibus. In felis urna, laoreet convallis, facilisis eu, convallis sit amet, ligula. Maecenas consequat ultrices velit.\r\n\r\nDonec facilisis aliquam eros. Morbi lobortis dolor a sapien. Quisque nibh est, tempus nonummy, interdum vel, auctor in, urna. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Etiam rhoncus. Phasellus iaculis, ipsum ac mollis ultricies, nulla massa rutrum pede, et pellentesque massa massa ut massa. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia  In hac habitasse platea dictumst. Curabitur pretium nunc eget odio. Proin orci justo, auctor vel, consectetuer sed, hendrerit eu, tortor. Aliquam pede. Cras turpis purus, iaculis non, tincidunt molestie, hendrerit nec, lacus. Duis bibendum tempor velit.\r\n\r\nNam aliquet purus porttitor mi. Vivamus sed dolor. In hendrerit hendrerit nulla. Donec dapibus elit quis nisl. In eros ante, commodo a, vulputate et, auctor ut, turpis. Vivamus porttitor justo vitae sem. Integer suscipit ullamcorper velit. Morbi sit amet erat. Vestibulum ipsum augue, nonummy non, aliquam in, malesuada in, magna. Suspendisse iaculis.', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aliquam felis wisi, rhoncus id, bibendum eu, tristique at, magna. Aliquam a nisl. Quisque accumsan molestie enim. Sed sit amet nisl. Nunc sit amet massa porta massa.', 1, 1, 0, 1, 0),
(23, '2option', 'Two Option Product', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Nunc lobortis, odio viverra vestibulum lacinia, ipsum nisl interdum dui, varius posuere velit lacus a ligula. Integer lacus. Suspendisse porttitor. Aenean commodo vehicula tellus. Cras pede lacus, tincidunt in, viverra quis, viverra hendrerit, lorem. Donec nibh neque, suscipit non, posuere nec, tristique ut, sem. Pellentesque quis lectus eget risus hendrerit viverra. Donec dui mi, iaculis vitae, pharetra ac, egestas in, lectus. Aenean non arcu. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos hymenaeos. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos hymenaeos. Integer hendrerit nunc nec dui. Vestibulum id nibh. Etiam elit. Nulla et erat ut leo scelerisque nonummy. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos hymenaeos. Etiam interdum purus non enim ultricies vulputate. Proin lacinia velit imperdiet libero.\r\n\r\nPellentesque at augue ac ante pulvinar blandit. Curabitur id tortor vitae elit pulvinar sagittis. Sed a augue. Proin pede velit, ornare vel, fermentum at, dignissim vitae, nulla. Donec feugiat ligula at risus. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia  Morbi elit risus, pellentesque rhoncus, vestibulum eget, euismod et, nibh. Ut metus enim, accumsan eu, gravida eget, dignissim eget, lectus. Nulla facilisi. Quisque tristique quam ut sem. Ut urna urna, dignissim at, dignissim quis, convallis elementum, turpis. Pellentesque quis purus. Duis eget enim. Nunc dictum, est sed vulputate dictum, diam nibh fermentum metus, eu accumsan massa enim nec enim. Donec ultrices, libero sed porttitor nonummy, libero ante ullamcorper tellus, tempor gravida mauris metus sed odio. Integer viverra felis posuere massa. Maecenas euismod rutrum nulla. Pellentesque gravida, neque ac malesuada consectetuer, sem massa varius mauris, id pulvinar diam pede in urna. ', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aliquam felis wisi, rhoncus id, bibendum eu, tristique at, magna. Aliquam a nisl. Quisque accumsan molestie enim. Sed sit amet nisl. Nunc sit amet massa porta massa.', 3, 1, 0, 1, 3),
(24, '3option', 'Three Option Product', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Nunc lobortis, odio viverra vestibulum lacinia, ipsum nisl interdum dui, varius posuere velit lacus a ligula. Integer lacus. Suspendisse porttitor. Aenean commodo vehicula tellus. Cras pede lacus, tincidunt in, viverra quis, viverra hendrerit, lorem. Donec nibh neque, suscipit non, posuere nec, tristique ut, sem. Pellentesque quis lectus eget risus hendrerit viverra. Donec dui mi, iaculis vitae, pharetra ac, egestas in, lectus. Aenean non arcu. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos hymenaeos. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos hymenaeos. Integer hendrerit nunc nec dui. Vestibulum id nibh. Etiam elit. Nulla et erat ut leo scelerisque nonummy. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos hymenaeos. Etiam interdum purus non enim ultricies vulputate. Proin lacinia velit imperdiet libero.\r\n\r\nPellentesque at augue ac ante pulvinar blandit. Curabitur id tortor vitae elit pulvinar sagittis. Sed a augue. Proin pede velit, ornare vel, fermentum at, dignissim vitae, nulla. Donec feugiat ligula at risus. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Morbi elit risus, pellentesque rhoncus, vestibulum eget, euismod et, nibh. Ut metus enim, accumsan eu, gravida eget, dignissim eget, lectus. Nulla facilisi. Quisque tristique quam ut sem. Ut urna urna, dignissim at, dignissim quis, convallis elementum, turpis. Pellentesque quis purus. Duis eget enim. Nunc dictum, est sed vulputate dictum, diam nibh fermentum metus, eu accumsan massa enim nec enim. Donec ultrices, libero sed porttitor nonummy, libero ante ullamcorper tellus, tempor gravida mauris metus sed odio. Integer viverra felis posuere massa. Maecenas euismod rutrum nulla. Pellentesque gravida, neque ac malesuada consectetuer, sem massa varius mauris, id pulvinar diam pede in urna. ', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Nunc lobortis, odio viverra vestibulum lacinia, ipsum nisl interdum dui, varius posuere velit lacus a ligula. Integer lacus.', 4, 1, 0, 1, 0),
(27, 'sku1', 'Test with VAT', 'Test product with VAT', 'Test product with VAT', 1, 1, 0, 1, 3),
(29, '4OptionProduct', '4 Option Product', 'This is a four option product, because I can', 'This is a four option product, because I can', 0, 1, 0, 0, 3),
(31, 'TestProd', 'Cheap Test Product', 'Test', 'Test', 0, 1, 0, 1, 1),
(32, 'noOption', 'no Option simple prod', 'Lond descr', 'short descr', 0, 1, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_shipmethcntry_rel`
--

CREATE TABLE IF NOT EXISTS `tbl_shipmethcntry_rel` (
  `shpmet_cntry_ID` int(11) NOT NULL,
  `shpmet_cntry_Meth_ID` int(11) DEFAULT '0',
  `shpmet_cntry_Country_ID` int(11) DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_shipmethcntry_rel`
--

INSERT INTO `tbl_shipmethcntry_rel` (`shpmet_cntry_ID`, `shpmet_cntry_Meth_ID`, `shpmet_cntry_Country_ID`) VALUES
(1, 35, 1),
(2, 36, 1),
(3, 60, 1),
(4, 76, 2),
(7, 65, 3),
(9, 74, 5),
(10, 75, 7);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_shipmethod`
--

CREATE TABLE IF NOT EXISTS `tbl_shipmethod` (
  `shipmeth_ID` int(11) NOT NULL,
  `shipmeth_Name` varchar(100) NOT NULL DEFAULT '',
  `shipmeth_Rate` double DEFAULT NULL,
  `shipmeth_Sort` int(11) NOT NULL DEFAULT '0',
  `shipmeth_Archive` smallint(6) DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_shipmethod`
--

INSERT INTO `tbl_shipmethod` (`shipmeth_ID`, `shipmeth_Name`, `shipmeth_Rate`, `shipmeth_Sort`, `shipmeth_Archive`) VALUES
(35, 'USA UPS Ground', 4, 1, 0),
(36, 'USA 2 Day Air', 7, 2, 0),
(60, 'USA Overnight Air', 8, 3, 0),
(65, 'Canadian UPS', 15, 4, 0),
(66, 'International UPS', 28, 5, 0),
(73, 'USPS', 4, 6, 0),
(74, 'Securicor', 0, 5, 0),
(75, 'Test', 3, 1, 0),
(76, 'USA Territories UPS', 14.5, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_shipranges`
--

CREATE TABLE IF NOT EXISTS `tbl_shipranges` (
  `ship_range_ID` int(11) NOT NULL,
  `ship_range_Method_ID` int(11) DEFAULT '0',
  `ship_range_From` double DEFAULT '0',
  `ship_range_To` double DEFAULT '0',
  `ship_range_Amount` double DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_shipranges`
--

INSERT INTO `tbl_shipranges` (`ship_range_ID`, `ship_range_Method_ID`, `ship_range_From`, `ship_range_To`, `ship_range_Amount`) VALUES
(1, 35, 0, 5, 11.55),
(2, 35, 5.01, 10, 20.5),
(3, 35, 10.01, 20, 30),
(4, 35, 20.01, 10000000, 40),
(5, 36, 0, 5, 15),
(6, 36, 5.01, 10, 25),
(7, 36, 10.01, 20, 35),
(8, 36, 20.01, 10000000, 45),
(9, 60, 1, 5, 16),
(10, 60, 5.01, 10, 26),
(11, 60, 10.01, 20, 36),
(12, 60, 20.01, 10000000, 46),
(13, 65, 0, 5, 19),
(14, 65, 5.01, 10, 29),
(15, 65, 10.01, 20, 39),
(16, 65, 20.01, 10000000, 49),
(17, 66, 0, 5, 21),
(18, 66, 5.01, 10, 31),
(19, 66, 10.01, 20, 41),
(20, 66, 20.01, 10000000, 51),
(21, 74, 0, 1, 2.5),
(22, 74, 1.01, 10000, 3),
(23, 76, 0, 100000, 5);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_skuoptions`
--

CREATE TABLE IF NOT EXISTS `tbl_skuoptions` (
  `option_ID` int(11) NOT NULL,
  `option_Type_ID` int(11) DEFAULT '0',
  `option_Name` varchar(50) DEFAULT NULL,
  `option_Sort` int(11) DEFAULT NULL,
  `option_Archive` smallint(6) DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_skuoptions`
--

INSERT INTO `tbl_skuoptions` (`option_ID`, `option_Type_ID`, `option_Name`, `option_Sort`, `option_Archive`) VALUES
(1, 1, 'Small', 1, 0),
(2, 1, 'Medium', 2, 0),
(3, 1, 'Large', 3, 0),
(4, 1, 'X-Large', 4, 0),
(5, 1, 'XX-Large', 5, 0),
(6, 2, 'Black', 1, 0),
(7, 2, 'Blue', 2, 0),
(9, 1, 'None', 9, 0),
(20, 2, 'None', 9, 0),
(21, 3, 'Fat', 1, 1),
(22, 3, 'Slim', 2, 0),
(24, 3, 'Form Fitting', 3, 0),
(25, 2, 'Green', 3, 0),
(26, 2, 'Red', 4, 0),
(27, 2, 'Mauve', 6, 0),
(28, 1, 'Boys Medium', 6, 0),
(29, 4, 'Short', 1, 0),
(30, 4, 'Long', 2, 0),
(31, 4, 'Really Long', 3, 0);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_skuoption_rel`
--

CREATE TABLE IF NOT EXISTS `tbl_skuoption_rel` (
  `optn_rel_ID` int(11) NOT NULL,
  `optn_rel_SKU_ID` int(11) NOT NULL DEFAULT '0',
  `optn_rel_Option_ID` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=558 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_skuoption_rel`
--

INSERT INTO `tbl_skuoption_rel` (`optn_rel_ID`, `optn_rel_SKU_ID`, `optn_rel_Option_ID`) VALUES
(463, 29, 7),
(465, 31, 1),
(466, 31, 6),
(467, 32, 6),
(468, 32, 2),
(469, 33, 3),
(470, 33, 6),
(471, 34, 6),
(472, 34, 4),
(473, 35, 1),
(474, 35, 7),
(475, 36, 7),
(476, 36, 3),
(477, 37, 1),
(478, 37, 25),
(479, 38, 25),
(480, 38, 2),
(481, 39, 1),
(482, 39, 6),
(483, 39, 22),
(484, 40, 22),
(485, 40, 2),
(486, 40, 6),
(487, 41, 24),
(488, 41, 2),
(489, 41, 6),
(490, 42, 24),
(491, 42, 6),
(492, 42, 3),
(505, 47, 7),
(506, 47, 22),
(507, 47, 1),
(508, 46, 1),
(509, 46, 7),
(510, 46, 24),
(511, 48, 25),
(512, 48, 22),
(513, 48, 1),
(514, 49, 25),
(515, 49, 3),
(516, 49, 22),
(517, 50, 29),
(518, 50, 1),
(519, 50, 6),
(520, 50, 22),
(521, 51, 1),
(522, 51, 24),
(523, 51, 6),
(524, 51, 29),
(525, 52, 22),
(526, 52, 2),
(527, 52, 29),
(528, 52, 6),
(529, 53, 6),
(530, 53, 3),
(531, 53, 22),
(532, 53, 29),
(533, 54, 6),
(534, 54, 30),
(535, 54, 22),
(536, 54, 1),
(537, 55, 22),
(538, 55, 31),
(539, 55, 1),
(540, 55, 6),
(541, 56, 2),
(542, 56, 6),
(543, 56, 22),
(544, 56, 30),
(545, 57, 22),
(546, 57, 30),
(547, 57, 6),
(548, 57, 3),
(549, 58, 5),
(550, 58, 31),
(551, 58, 6),
(552, 58, 22),
(554, 28, 6),
(555, 59, 30),
(556, 60, 1),
(557, 61, 2);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_skus`
--

CREATE TABLE IF NOT EXISTS `tbl_skus` (
  `SKU_ID` int(11) NOT NULL,
  `SKU_MerchSKUID` varchar(50) DEFAULT NULL,
  `SKU_ProductID` int(11) NOT NULL DEFAULT '0',
  `SKU_Price` double DEFAULT NULL,
  `SKU_Weight` double DEFAULT '0',
  `SKU_Stock` int(11) DEFAULT '0',
  `SKU_ShowWeb` smallint(6) DEFAULT '0',
  `SKU_Sort` int(11) DEFAULT '1'
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_skus`
--

INSERT INTO `tbl_skus` (`SKU_ID`, `SKU_MerchSKUID`, `SKU_ProductID`, `SKU_Price`, `SKU_Weight`, `SKU_Stock`, `SKU_ShowWeb`, `SKU_Sort`) VALUES
(28, '1option', 21, 15, 12.3, 0, 1, 1),
(29, '1option2', 21, 15, 12.3, 3, 1, 1),
(31, '2option1', 23, 14.99, 3, 5, 1, 0),
(32, '2option2', 23, 14.99, 3, 9, 1, 0),
(33, '2option3', 23, 14.99, 3, 9, 1, 0),
(34, '2option4', 23, 15.99, 0, 8, 1, 0),
(35, '2option5', 23, 14.99, 3, 9, 1, 0),
(36, '2option6', 23, 14.99, 3, 10, 1, 0),
(37, '2option7', 23, 14.99, 3, 10, 1, 0),
(38, '2option8', 23, 14.99, 3, 10, 1, 0),
(39, '3option1', 24, 13.99, 10, 2, 1, 0),
(40, '3option2', 24, 13.99, 10, 10, 1, 0),
(41, '3option3', 24, 13.99, 10, 10, 1, 0),
(42, '3option4', 24, 14.99, 10, 4, 1, 0),
(44, 'sku1', 27, 100, 10, 1, 1, 1),
(46, 'bss', 24, 19.95, 0, 1, 1, 0),
(47, 'bfx', 24, 19.95, 0, 10, 0, 0),
(48, 'gss', 24, 15.95, 0, 10, 1, 0),
(49, 'gsl', 24, 16.95, 0, 10, 1, 0),
(50, '1', 29, 14.95, 0, 9, 1, 0),
(51, '2', 29, 14.95, 0, 1, 1, 0),
(52, '3', 29, 14.95, 0, 10, 1, 0),
(53, '4', 29, 14.95, 0, 10, 1, 0),
(54, '5', 29, 65.95, 0, 10, 1, 0),
(55, '6', 29, 123, 0, 10, 1, 0),
(56, '7', 29, 123, 0, 6, 1, 0),
(57, '8', 29, 12, 0, 12, 1, 0),
(58, '9', 29, 65, 0, 9, 1, 0),
(59, 'Cheap Test Sku', 31, 0.02, 1, 997, 1, 0),
(60, '1sku-small', 22, 14.99, 0, 0, 1, 2),
(61, '1sku-medium', 22, 13.99, 0, 0, 1, 2),
(62, 'noOption', 32, 13.99, 12, -2, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_stateprov`
--

CREATE TABLE IF NOT EXISTS `tbl_stateprov` (
  `stprv_ID` int(11) NOT NULL,
  `stprv_Code` varchar(50) DEFAULT NULL,
  `stprv_Name` varchar(255) DEFAULT NULL,
  `stprv_Country_ID` int(11) DEFAULT '0',
  `stprv_Tax` double DEFAULT '0',
  `stprv_Ship_Ext` double DEFAULT '0',
  `stprv_Archive` smallint(6) DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_stateprov`
--

INSERT INTO `tbl_stateprov` (`stprv_ID`, `stprv_Code`, `stprv_Name`, `stprv_Country_ID`, `stprv_Tax`, `stprv_Ship_Ext`, `stprv_Archive`) VALUES
(1, 'AL', 'Alabama', 1, 0.085, 0.1, 0),
(2, 'AK', 'Alaska', 1, 0, 0, 0),
(3, 'AZ', 'Arizona', 1, 0, 0, 0),
(4, 'AR', 'Arkansas', 1, 0, 0, 0),
(5, 'CA', 'California', 1, 0, 0, 0),
(6, 'CO', 'Colorado', 1, 0, 0, 0),
(7, 'CT', 'Connecticut', 1, 0, 0, 0),
(8, 'DE', 'Delaware', 1, 0, 0, 0),
(9, 'FL', 'Florida', 1, 0, 0.5, 0),
(10, 'GA', 'Georgia', 1, 0, 0, 0),
(11, 'HI', 'Hawaii', 1, 0, 0, 0),
(12, 'ID', 'Idaho', 1, 0, 0, 0),
(13, 'IL', 'Illinois', 1, 0, 0, 0),
(14, 'IN', 'Indiana', 1, 0, 0, 0),
(15, 'IA', 'Iowa', 1, 0, 0, 0),
(16, 'KS', 'Kansas', 1, 0, 0, 0),
(17, 'KY', 'Kentucky', 1, 0, 0, 0),
(18, 'LA', 'Louisiana', 1, 0, 0, 0),
(19, 'ME', 'Maine', 1, 0, 0, 0),
(20, 'MD', 'Maryland', 1, 0, 0, 0),
(21, 'MA', 'Massachusetts', 1, 0, 0, 0),
(22, 'MI', 'Michigan', 1, 0, 0, 0),
(23, 'MN', 'Minnesota', 1, 0, 0, 0),
(24, 'MS', 'Mississippi', 1, 0, 0, 0),
(25, 'MO', 'Missouri', 1, 0, 0, 0),
(26, 'MT', 'Montana', 1, 0, 0, 0),
(27, 'NE', 'Nebraska', 1, 0, 0, 0),
(28, 'NV', 'Nevada', 1, 0, 0, 0),
(29, 'NH', 'New Hampshire', 1, 0, 0, 0),
(30, 'NJ', 'New Jersey', 1, 0, 0, 0),
(31, 'NM', 'New Mexico', 1, 0, 0, 0),
(32, 'NY', 'New York', 1, 0, 0, 0),
(33, 'NC', 'North Carolina', 1, 0, 0, 0),
(34, 'ND', 'North Dakota', 1, 0, 0, 0),
(35, 'OH', 'Ohio', 1, 0, 0, 0),
(36, 'OK', 'Oklahoma', 1, 0, 0, 0),
(37, 'OR', 'Oregon', 1, 0, 0, 0),
(38, 'PA', 'Pennsylvania', 1, 0, 0, 0),
(39, 'RI', 'Rhode Island', 1, 0, 0, 0),
(40, 'SC', 'South Carolina', 1, 0, 0, 0),
(41, 'SD', 'South Dakota', 1, 0, 0, 0),
(42, 'TN', 'Tennessee', 1, 0, 0, 0),
(43, 'TX', 'Texas', 1, 0, 0, 0),
(44, 'UT', 'Utah', 1, 0, 0, 0),
(45, 'VT', 'Vermont', 1, 0, 0, 0),
(46, 'VA', 'Virginia', 1, 0, 0, 0),
(47, 'WA', 'Washington', 1, 0.08, 0.25, 0),
(48, 'WV', 'West Virginia', 1, 0, 0, 0),
(49, 'WI', 'Wisconsin', 1, 0, 0, 0),
(50, 'WY', 'Wyoming', 1, 0, 0, 0),
(51, 'BC', 'British Columbia', 3, 0, 0, 0),
(52, 'MB', 'Manitoba', 3, 0, 0, 0),
(53, 'NF', 'Newfoundland', 3, 0, 0, 0),
(54, 'NB', 'New Brunswick', 3, 0, 0, 0),
(55, 'NT', 'Northwest Territories', 3, 0, 0, 0),
(56, 'NS', 'Nova Scotia', 3, 0, 0, 0),
(57, 'ON', 'Ontario', 3, 0, 0, 0),
(58, 'PE', 'Prince Edward Island', 3, 0, 0, 0),
(59, 'QC', 'Quebec', 3, 0, 0, 0),
(60, 'SK', 'Saskatchewan', 3, 0, 0, 0),
(61, 'YT', 'Yukon', 3, 0, 0, 0),
(62, 'AS', 'American Samoa', 2, 0, 0, 0),
(63, 'FM', 'Fed. Micronesia', 2, 0, 0, 0),
(64, 'G', 'Guam', 2, 0, 0, 0),
(65, 'MH', 'Marshall Island', 2, 0, 0, 0),
(66, 'MP', 'N. Mariana Is.', 2, 0, 0, 0),
(67, 'PW', 'Palau Island', 2, 0, 0, 0),
(68, 'PR', 'Puerto Rico', 2, 0, 0, 0),
(69, 'VI', 'Virgin Islands', 2, 0, 0, 0),
(70, 'None', 'None', 4, 0, 0, 0),
(71, 'None', 'None', 5, 0.175, 0.175, 0),
(72, 'None', 'None', 6, 0, 0, 0),
(73, 'None', 'None', 7, 0, 0, 0),
(74, 'None', 'None', 8, 0, 0, 0),
(75, 'DC', 'District of Columbia', 1, 0, 0, 0),
(76, 'NU', 'Territory of Nunavut', 3, 0, 0, 0),
(77, 'AB', 'Alberta', 3, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_taxgroups`
--

CREATE TABLE IF NOT EXISTS `tbl_taxgroups` (
  `taxgroup_id` int(11) NOT NULL,
  `taxgroup_name` varchar(150) DEFAULT NULL,
  `taxgroup_archive` smallint(6) DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_taxgroups`
--

INSERT INTO `tbl_taxgroups` (`taxgroup_id`, `taxgroup_name`, `taxgroup_archive`) VALUES
(1, 'Books', 0),
(2, 'Perishables', 0),
(3, 'Electronics', 0),
(4, 'Childrens Clothes', 0),
(5, 'Shipping', 0);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_taxrates`
--

CREATE TABLE IF NOT EXISTS `tbl_taxrates` (
  `taxrate_id` int(11) NOT NULL,
  `taxrate_regionid` int(11) DEFAULT '0',
  `taxrate_groupid` int(11) DEFAULT '0',
  `taxrate_percentage` double DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_taxrates`
--

INSERT INTO `tbl_taxrates` (`taxrate_id`, `taxrate_regionid`, `taxrate_groupid`, `taxrate_percentage`) VALUES
(4, 3, 1, 17),
(5, 1, 1, 2),
(6, 2, 1, 1.2),
(7, 2, 2, 3),
(10, 5, 2, 8),
(11, 5, 1, 10),
(12, 6, 4, 0),
(13, 7, 5, 0),
(14, 6, 3, 17.5),
(15, 8, 3, 0),
(16, 1, 3, 5.25),
(17, 2, 3, 8.25);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_taxregions`
--

CREATE TABLE IF NOT EXISTS `tbl_taxregions` (
  `taxregion_id` int(11) NOT NULL,
  `taxregion_countryid` int(11) NOT NULL DEFAULT '0',
  `taxregion_stateid` int(11) NOT NULL DEFAULT '0',
  `taxregion_label` varchar(150) DEFAULT NULL,
  `taxregion_taxid` varchar(50) DEFAULT NULL,
  `taxregion_showid` tinyint(4) DEFAULT NULL,
  `taxregion_shiptaxmethod` varchar(50) DEFAULT NULL,
  `taxregion_shiptaxgroupid` int(11) DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_taxregions`
--

INSERT INTO `tbl_taxregions` (`taxregion_id`, `taxregion_countryid`, `taxregion_stateid`, `taxregion_label`, `taxregion_taxid`, `taxregion_showid`, `taxregion_shiptaxmethod`, `taxregion_shiptaxgroupid`) VALUES
(1, 1, 0, 'US Tax', '', 0, 'No Tax', 0),
(2, 1, 1, 'Alabama State Tax', 'abc', 0, 'No Tax', 0),
(3, 1, 2, 'asdf', '', 0, 'Highest Item Taxed', 0),
(4, 3, 51, 'PST', '', 0, 'No Tax', 0),
(5, 1, 47, 'MyTax', 'XYZ', 1, 'Tax Group', 3),
(6, 5, 0, 'VAT', '1', 0, 'Highest Item Taxed', 0),
(7, 3, 56, 'No Tax', '2', 0, 'Highest Item Taxed', 0),
(8, 7, 0, 'CWE', '', 0, 'Highest Item Taxed', 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_adminusers`
--
ALTER TABLE `tbl_adminusers`
  ADD PRIMARY KEY (`admin_UserID`);

--
-- Indexes for table `tbl_cart`
--
ALTER TABLE `tbl_cart`
  ADD PRIMARY KEY (`cart_Line_ID`),
  ADD KEY `cart_custcart_ID` (`cart_custcart_ID`),
  ADD KEY `sku_ID` (`cart_sku_ID`);

--
-- Indexes for table `tbl_config`
--
ALTER TABLE `tbl_config`
  ADD PRIMARY KEY (`config_id`),
  ADD KEY `config_groupid` (`config_groupid`);

--
-- Indexes for table `tbl_configgroup`
--
ALTER TABLE `tbl_configgroup`
  ADD PRIMARY KEY (`configgroup_id`);

--
-- Indexes for table `tbl_customers`
--
ALTER TABLE `tbl_customers`
  ADD PRIMARY KEY (`cst_ID`),
  ADD UNIQUE KEY `cst_Email` (`cst_Email`),
  ADD UNIQUE KEY `cst_Username` (`cst_Username`),
  ADD KEY `tbl_Cust_Typetbl_Customers` (`cst_Type_ID`);

--
-- Indexes for table `tbl_custstate`
--
ALTER TABLE `tbl_custstate`
  ADD PRIMARY KEY (`CustSt_ID`),
  ADD KEY `CustStCntry_Cust_ID` (`CustSt_Cust_ID`),
  ADD KEY `tbl_Customerstbl_Cust_State` (`CustSt_Cust_ID`),
  ADD KEY `tbl_StateProvtbl_Cust_StProvCntry_relation` (`CustSt_StPrv_ID`);

--
-- Indexes for table `tbl_custtype`
--
ALTER TABLE `tbl_custtype`
  ADD PRIMARY KEY (`custtype_ID`);

--
-- Indexes for table `tbl_discounts`
--
ALTER TABLE `tbl_discounts`
  ADD PRIMARY KEY (`discount_id`);

--
-- Indexes for table `tbl_discounts_products_rel`
--
ALTER TABLE `tbl_discounts_products_rel`
  ADD PRIMARY KEY (`discounts_products_rel_id`);

--
-- Indexes for table `tbl_discounts_skus_rel`
--
ALTER TABLE `tbl_discounts_skus_rel`
  ADD PRIMARY KEY (`discounts_skus_rel_id`);

--
-- Indexes for table `tbl_discount_amounts`
--
ALTER TABLE `tbl_discount_amounts`
  ADD PRIMARY KEY (`discountAmount_id`);

--
-- Indexes for table `tbl_discount_apply_types`
--
ALTER TABLE `tbl_discount_apply_types`
  ADD PRIMARY KEY (`discountApplyType_id`);

--
-- Indexes for table `tbl_discount_types`
--
ALTER TABLE `tbl_discount_types`
  ADD PRIMARY KEY (`discountType_id`);

--
-- Indexes for table `tbl_discount_usage`
--
ALTER TABLE `tbl_discount_usage`
  ADD PRIMARY KEY (`discountUsage_id`),
  ADD KEY `discountUsage_discount_id` (`discountUsage_discount_id`);

--
-- Indexes for table `tbl_list_ccards`
--
ALTER TABLE `tbl_list_ccards`
  ADD PRIMARY KEY (`ccard_ID`),
  ADD KEY `ccard_code` (`ccard_Code`);

--
-- Indexes for table `tbl_list_countries`
--
ALTER TABLE `tbl_list_countries`
  ADD PRIMARY KEY (`country_ID`),
  ADD KEY `region_code` (`country_Code`);

--
-- Indexes for table `tbl_list_imagetypes`
--
ALTER TABLE `tbl_list_imagetypes`
  ADD PRIMARY KEY (`imgType_ID`);

--
-- Indexes for table `tbl_list_optiontypes`
--
ALTER TABLE `tbl_list_optiontypes`
  ADD PRIMARY KEY (`optiontype_ID`);

--
-- Indexes for table `tbl_list_shipstatus`
--
ALTER TABLE `tbl_list_shipstatus`
  ADD PRIMARY KEY (`shipstatus_id`);

--
-- Indexes for table `tbl_orders`
--
ALTER TABLE `tbl_orders`
  ADD PRIMARY KEY (`order_ID`),
  ADD KEY `order_Discountid` (`order_DiscountID`),
  ADD KEY `order_ShipTrackingID` (`order_ShipTrackingID`),
  ADD KEY `OrdersCustomerID` (`order_CustomerID`),
  ADD KEY `tbl_Customerstbl_Orders` (`order_CustomerID`),
  ADD KEY `FK_cw3_tbl_list_shipstatus_tbl_orders` (`order_Status`),
  ADD KEY `FK_cw3_tbl_shipmethod_tbl_orders` (`order_ShipMeth_ID`);

--
-- Indexes for table `tbl_orderskus`
--
ALTER TABLE `tbl_orderskus`
  ADD PRIMARY KEY (`orderSKU_ID`),
  ADD KEY `OrderDetailsOrderID` (`orderSKU_OrderID`),
  ADD KEY `orderSKU_DiscountID` (`orderSKU_DiscountID`),
  ADD KEY `orderSKU_TaxRateID` (`orderSKU_TaxRateID`),
  ADD KEY `OrderSKUsSKU` (`orderSKU_SKU`),
  ADD KEY `tbl_Orderstbl_OrderSKUs` (`orderSKU_OrderID`),
  ADD KEY `tbl_SKUstbl_OrderSKUs` (`orderSKU_SKU`);

--
-- Indexes for table `tbl_prdtcategories`
--
ALTER TABLE `tbl_prdtcategories`
  ADD PRIMARY KEY (`category_ID`);

--
-- Indexes for table `tbl_prdtcat_rel`
--
ALTER TABLE `tbl_prdtcat_rel`
  ADD PRIMARY KEY (`prdt_cat_rel_ID`),
  ADD KEY `prdt_cat_rel_Cat_ID` (`prdt_cat_rel_Cat_ID`),
  ADD KEY `prdt_cat_rel_Product_ID` (`prdt_cat_rel_Product_ID`),
  ADD KEY `tbl_PrdtCategoriestbl_prdtcat_rel` (`prdt_cat_rel_Cat_ID`),
  ADD KEY `tbl_Productstbl_prdtcat_rel` (`prdt_cat_rel_Product_ID`);

--
-- Indexes for table `tbl_prdtimages`
--
ALTER TABLE `tbl_prdtimages`
  ADD PRIMARY KEY (`prdctImage_ID`),
  ADD KEY `prdctImage_ImgTypeID` (`prdctImage_ImgTypeID`),
  ADD KEY `prdctImage_ProductID` (`prdctImage_ProductID`),
  ADD KEY `tbl_list_ImageTypestbl_PrdtImages` (`prdctImage_ImgTypeID`),
  ADD KEY `tbl_Productstbl_PrdtImages` (`prdctImage_ProductID`);

--
-- Indexes for table `tbl_prdtoption_rel`
--
ALTER TABLE `tbl_prdtoption_rel`
  ADD PRIMARY KEY (`optn_rel_ID`),
  ADD KEY `option_rel_optionID` (`optn_rel_OptionType_ID`),
  ADD KEY `tbl_list_OptionTypestbl_ProductOption_rel` (`optn_rel_OptionType_ID`),
  ADD KEY `tbl_Productstbl_ProductOption_rel` (`optn_rel_Prod_ID`);

--
-- Indexes for table `tbl_prdtscndcats`
--
ALTER TABLE `tbl_prdtscndcats`
  ADD PRIMARY KEY (`scndctgry_ID`);

--
-- Indexes for table `tbl_prdtscndcat_rel`
--
ALTER TABLE `tbl_prdtscndcat_rel`
  ADD PRIMARY KEY (`prdt_scnd_rel_ID`),
  ADD KEY `prdt_scnd_re_ScndID` (`prdt_scnd_rel_ScndCat_ID`),
  ADD KEY `prdt_scnd_rel_prdctID` (`prdt_scnd_rel_Product_ID`),
  ADD KEY `tbl_PrdtScndCategoriestbl_PrdtScndCtgry_rel` (`prdt_scnd_rel_ScndCat_ID`),
  ADD KEY `tbl_Productstbl_PrdtScndCtgry_rel` (`prdt_scnd_rel_Product_ID`);

--
-- Indexes for table `tbl_prdtupsell`
--
ALTER TABLE `tbl_prdtupsell`
  ADD PRIMARY KEY (`upsell_id`),
  ADD KEY `crosssell_ProdID` (`upsell_ProdID`),
  ADD KEY `FK_cw3_tbl_products_tbl_prdtupsell` (`upsell_RelProdID`);

--
-- Indexes for table `tbl_products`
--
ALTER TABLE `tbl_products`
  ADD PRIMARY KEY (`product_ID`),
  ADD UNIQUE KEY `ItemNumber` (`product_MerchantProductID`);

--
-- Indexes for table `tbl_shipmethcntry_rel`
--
ALTER TABLE `tbl_shipmethcntry_rel`
  ADD PRIMARY KEY (`shpmet_cntry_ID`),
  ADD KEY `shpmet_cntry_country_id` (`shpmet_cntry_Country_ID`),
  ADD KEY `shpmet_cntry_ID` (`shpmet_cntry_ID`),
  ADD KEY `shpmet_cntry_meth_id` (`shpmet_cntry_Meth_ID`),
  ADD KEY `tbl_ShipMethodtbl_shipmethcntry_rel` (`shpmet_cntry_Meth_ID`);

--
-- Indexes for table `tbl_shipmethod`
--
ALTER TABLE `tbl_shipmethod`
  ADD PRIMARY KEY (`shipmeth_ID`);

--
-- Indexes for table `tbl_shipranges`
--
ALTER TABLE `tbl_shipranges`
  ADD PRIMARY KEY (`ship_range_ID`),
  ADD KEY `shp_range_method_ID` (`ship_range_Method_ID`),
  ADD KEY `tbl_ShipMethodtbl_shipranges` (`ship_range_Method_ID`);

--
-- Indexes for table `tbl_skuoptions`
--
ALTER TABLE `tbl_skuoptions`
  ADD PRIMARY KEY (`option_ID`),
  ADD KEY `tbl_list_OptionTypestbl_SKUOptions` (`option_Type_ID`);

--
-- Indexes for table `tbl_skuoption_rel`
--
ALTER TABLE `tbl_skuoption_rel`
  ADD PRIMARY KEY (`optn_rel_ID`),
  ADD KEY `option_rel_optionID` (`optn_rel_Option_ID`),
  ADD KEY `tbl_SKU_optionstbl_SKU_Option_relation` (`optn_rel_Option_ID`),
  ADD KEY `tbl_SKUstbl_SKUOption_rel` (`optn_rel_SKU_ID`);

--
-- Indexes for table `tbl_skus`
--
ALTER TABLE `tbl_skus`
  ADD PRIMARY KEY (`SKU_ID`),
  ADD UNIQUE KEY `SKU_ID` (`SKU_MerchSKUID`),
  ADD KEY `ProductsProductID` (`SKU_ProductID`),
  ADD KEY `tbl_Productstbl_SKUs` (`SKU_ProductID`);

--
-- Indexes for table `tbl_stateprov`
--
ALTER TABLE `tbl_stateprov`
  ADD PRIMARY KEY (`stprv_ID`),
  ADD KEY `st_code` (`stprv_Code`),
  ADD KEY `tbl_list_Countriestbl_StateProv` (`stprv_Country_ID`);

--
-- Indexes for table `tbl_taxgroups`
--
ALTER TABLE `tbl_taxgroups`
  ADD PRIMARY KEY (`taxgroup_id`);

--
-- Indexes for table `tbl_taxrates`
--
ALTER TABLE `tbl_taxrates`
  ADD PRIMARY KEY (`taxrate_id`),
  ADD KEY `taxrate_groupid` (`taxrate_groupid`),
  ADD KEY `taxrate_regionid` (`taxrate_regionid`),
  ADD KEY `tbl_taxgroupstbl_taxrates` (`taxrate_groupid`),
  ADD KEY `tbl_taxregionstbl_taxrates` (`taxrate_regionid`);

--
-- Indexes for table `tbl_taxregions`
--
ALTER TABLE `tbl_taxregions`
  ADD PRIMARY KEY (`taxregion_id`),
  ADD KEY `taxregion_countryid` (`taxregion_countryid`),
  ADD KEY `taxregion_shiptaxgroupid` (`taxregion_shiptaxgroupid`),
  ADD KEY `taxregion_stateid` (`taxregion_stateid`),
  ADD KEY `taxregion_taxid` (`taxregion_taxid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_adminusers`
--
ALTER TABLE `tbl_adminusers`
  MODIFY `admin_UserID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `tbl_cart`
--
ALTER TABLE `tbl_cart`
  MODIFY `cart_Line_ID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tbl_config`
--
ALTER TABLE `tbl_config`
  MODIFY `config_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=63;
--
-- AUTO_INCREMENT for table `tbl_configgroup`
--
ALTER TABLE `tbl_configgroup`
  MODIFY `configgroup_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT for table `tbl_custstate`
--
ALTER TABLE `tbl_custstate`
  MODIFY `CustSt_ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=130;
--
-- AUTO_INCREMENT for table `tbl_custtype`
--
ALTER TABLE `tbl_custtype`
  MODIFY `custtype_ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `tbl_discounts`
--
ALTER TABLE `tbl_discounts`
  MODIFY `discount_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=67;
--
-- AUTO_INCREMENT for table `tbl_discounts_products_rel`
--
ALTER TABLE `tbl_discounts_products_rel`
  MODIFY `discounts_products_rel_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tbl_discounts_skus_rel`
--
ALTER TABLE `tbl_discounts_skus_rel`
  MODIFY `discounts_skus_rel_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=65;
--
-- AUTO_INCREMENT for table `tbl_discount_amounts`
--
ALTER TABLE `tbl_discount_amounts`
  MODIFY `discountAmount_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=38;
--
-- AUTO_INCREMENT for table `tbl_discount_apply_types`
--
ALTER TABLE `tbl_discount_apply_types`
  MODIFY `discountApplyType_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `tbl_discount_types`
--
ALTER TABLE `tbl_discount_types`
  MODIFY `discountType_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `tbl_discount_usage`
--
ALTER TABLE `tbl_discount_usage`
  MODIFY `discountUsage_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `tbl_list_ccards`
--
ALTER TABLE `tbl_list_ccards`
  MODIFY `ccard_ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=19;
--
-- AUTO_INCREMENT for table `tbl_list_countries`
--
ALTER TABLE `tbl_list_countries`
  MODIFY `country_ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `tbl_list_imagetypes`
--
ALTER TABLE `tbl_list_imagetypes`
  MODIFY `imgType_ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `tbl_list_optiontypes`
--
ALTER TABLE `tbl_list_optiontypes`
  MODIFY `optiontype_ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `tbl_list_shipstatus`
--
ALTER TABLE `tbl_list_shipstatus`
  MODIFY `shipstatus_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `tbl_orderskus`
--
ALTER TABLE `tbl_orderskus`
  MODIFY `orderSKU_ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=59;
--
-- AUTO_INCREMENT for table `tbl_prdtcategories`
--
ALTER TABLE `tbl_prdtcategories`
  MODIFY `category_ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `tbl_prdtcat_rel`
--
ALTER TABLE `tbl_prdtcat_rel`
  MODIFY `prdt_cat_rel_ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=65;
--
-- AUTO_INCREMENT for table `tbl_prdtimages`
--
ALTER TABLE `tbl_prdtimages`
  MODIFY `prdctImage_ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=72;
--
-- AUTO_INCREMENT for table `tbl_prdtoption_rel`
--
ALTER TABLE `tbl_prdtoption_rel`
  MODIFY `optn_rel_ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=161;
--
-- AUTO_INCREMENT for table `tbl_prdtscndcats`
--
ALTER TABLE `tbl_prdtscndcats`
  MODIFY `scndctgry_ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `tbl_prdtscndcat_rel`
--
ALTER TABLE `tbl_prdtscndcat_rel`
  MODIFY `prdt_scnd_rel_ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=229;
--
-- AUTO_INCREMENT for table `tbl_prdtupsell`
--
ALTER TABLE `tbl_prdtupsell`
  MODIFY `upsell_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `tbl_products`
--
ALTER TABLE `tbl_products`
  MODIFY `product_ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=33;
--
-- AUTO_INCREMENT for table `tbl_shipmethcntry_rel`
--
ALTER TABLE `tbl_shipmethcntry_rel`
  MODIFY `shpmet_cntry_ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `tbl_shipmethod`
--
ALTER TABLE `tbl_shipmethod`
  MODIFY `shipmeth_ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=77;
--
-- AUTO_INCREMENT for table `tbl_shipranges`
--
ALTER TABLE `tbl_shipranges`
  MODIFY `ship_range_ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=24;
--
-- AUTO_INCREMENT for table `tbl_skuoptions`
--
ALTER TABLE `tbl_skuoptions`
  MODIFY `option_ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=32;
--
-- AUTO_INCREMENT for table `tbl_skuoption_rel`
--
ALTER TABLE `tbl_skuoption_rel`
  MODIFY `optn_rel_ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=558;
--
-- AUTO_INCREMENT for table `tbl_skus`
--
ALTER TABLE `tbl_skus`
  MODIFY `SKU_ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=63;
--
-- AUTO_INCREMENT for table `tbl_stateprov`
--
ALTER TABLE `tbl_stateprov`
  MODIFY `stprv_ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=78;
--
-- AUTO_INCREMENT for table `tbl_taxgroups`
--
ALTER TABLE `tbl_taxgroups`
  MODIFY `taxgroup_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `tbl_taxrates`
--
ALTER TABLE `tbl_taxrates`
  MODIFY `taxrate_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=18;
--
-- AUTO_INCREMENT for table `tbl_taxregions`
--
ALTER TABLE `tbl_taxregions`
  MODIFY `taxregion_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=9;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `tbl_config`
--
ALTER TABLE `tbl_config`
  ADD CONSTRAINT `FK_cw3_tbl_configgroup_tbl_config` FOREIGN KEY (`config_groupid`) REFERENCES `tbl_configgroup` (`configgroup_id`) ON DELETE CASCADE;

--
-- Constraints for table `tbl_customers`
--
ALTER TABLE `tbl_customers`
  ADD CONSTRAINT `FK_cw3_tbl_custtype_tbl_customers` FOREIGN KEY (`cst_Type_ID`) REFERENCES `tbl_custtype` (`custtype_ID`);

--
-- Constraints for table `tbl_custstate`
--
ALTER TABLE `tbl_custstate`
  ADD CONSTRAINT `FK_cw3_tbl_customers_tbl_custstate` FOREIGN KEY (`CustSt_Cust_ID`) REFERENCES `tbl_customers` (`cst_ID`),
  ADD CONSTRAINT `FK_cw3_tbl_stateprov_tbl_custstate` FOREIGN KEY (`CustSt_StPrv_ID`) REFERENCES `tbl_stateprov` (`stprv_ID`);

--
-- Constraints for table `tbl_orders`
--
ALTER TABLE `tbl_orders`
  ADD CONSTRAINT `FK_cw3_tbl_customers_tbl_orders` FOREIGN KEY (`order_CustomerID`) REFERENCES `tbl_customers` (`cst_ID`),
  ADD CONSTRAINT `FK_cw3_tbl_list_shipstatus_tbl_orders` FOREIGN KEY (`order_Status`) REFERENCES `tbl_list_shipstatus` (`shipstatus_id`),
  ADD CONSTRAINT `FK_cw3_tbl_shipmethod_tbl_orders` FOREIGN KEY (`order_ShipMeth_ID`) REFERENCES `tbl_shipmethod` (`shipmeth_ID`);

--
-- Constraints for table `tbl_orderskus`
--
ALTER TABLE `tbl_orderskus`
  ADD CONSTRAINT `FK_cw3_tbl_orders_tbl_orderskus` FOREIGN KEY (`orderSKU_OrderID`) REFERENCES `tbl_orders` (`order_ID`),
  ADD CONSTRAINT `FK_cw3_tbl_skus_tbl_orderskus` FOREIGN KEY (`orderSKU_SKU`) REFERENCES `tbl_skus` (`SKU_ID`) ON DELETE CASCADE;

--
-- Constraints for table `tbl_prdtcat_rel`
--
ALTER TABLE `tbl_prdtcat_rel`
  ADD CONSTRAINT `FK_cw3_tbl_prdtcategories_tbl_prdtcat_rel` FOREIGN KEY (`prdt_cat_rel_Cat_ID`) REFERENCES `tbl_prdtcategories` (`category_ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_cw3_tbl_products_tbl_prdtcat_rel` FOREIGN KEY (`prdt_cat_rel_Product_ID`) REFERENCES `tbl_products` (`product_ID`) ON DELETE CASCADE;

--
-- Constraints for table `tbl_prdtimages`
--
ALTER TABLE `tbl_prdtimages`
  ADD CONSTRAINT `FK_cw3_tbl_list_imagetypes_tbl_prdtimages` FOREIGN KEY (`prdctImage_ImgTypeID`) REFERENCES `tbl_list_imagetypes` (`imgType_ID`),
  ADD CONSTRAINT `FK_cw3_tbl_products_tbl_prdtimages` FOREIGN KEY (`prdctImage_ProductID`) REFERENCES `tbl_products` (`product_ID`) ON DELETE CASCADE;

--
-- Constraints for table `tbl_prdtoption_rel`
--
ALTER TABLE `tbl_prdtoption_rel`
  ADD CONSTRAINT `FK_cw3_tbl_list_optiontypes_tbl_prdtoption_rel` FOREIGN KEY (`optn_rel_OptionType_ID`) REFERENCES `tbl_list_optiontypes` (`optiontype_ID`),
  ADD CONSTRAINT `FK_cw3_tbl_products_tbl_prdtoption_rel` FOREIGN KEY (`optn_rel_Prod_ID`) REFERENCES `tbl_products` (`product_ID`) ON DELETE CASCADE;

--
-- Constraints for table `tbl_prdtscndcat_rel`
--
ALTER TABLE `tbl_prdtscndcat_rel`
  ADD CONSTRAINT `FK_cw3_tbl_prdtscndcats_tbl_prdtscndcat_rel` FOREIGN KEY (`prdt_scnd_rel_ScndCat_ID`) REFERENCES `tbl_prdtscndcats` (`scndctgry_ID`),
  ADD CONSTRAINT `FK_cw3_tbl_products_tbl_prdtscndcat_rel` FOREIGN KEY (`prdt_scnd_rel_Product_ID`) REFERENCES `tbl_products` (`product_ID`) ON DELETE CASCADE;

--
-- Constraints for table `tbl_prdtupsell`
--
ALTER TABLE `tbl_prdtupsell`
  ADD CONSTRAINT `FK_cw3_tbl_products_tbl_prdtupsell` FOREIGN KEY (`upsell_RelProdID`) REFERENCES `tbl_products` (`product_ID`);

--
-- Constraints for table `tbl_shipmethcntry_rel`
--
ALTER TABLE `tbl_shipmethcntry_rel`
  ADD CONSTRAINT `FK_cw3_tbl_list_countries_tbl_shipmethcntry_rel` FOREIGN KEY (`shpmet_cntry_Country_ID`) REFERENCES `tbl_list_countries` (`country_ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_cw3_tbl_shipmethod_tbl_shipmethcntry_rel` FOREIGN KEY (`shpmet_cntry_Meth_ID`) REFERENCES `tbl_shipmethod` (`shipmeth_ID`) ON DELETE CASCADE;

--
-- Constraints for table `tbl_shipranges`
--
ALTER TABLE `tbl_shipranges`
  ADD CONSTRAINT `FK_cw3_tbl_shipmethod_tbl_shipranges` FOREIGN KEY (`ship_range_Method_ID`) REFERENCES `tbl_shipmethod` (`shipmeth_ID`) ON DELETE CASCADE;

--
-- Constraints for table `tbl_skuoptions`
--
ALTER TABLE `tbl_skuoptions`
  ADD CONSTRAINT `FK_cw3_tbl_list_optiontypes_tbl_skuoptions` FOREIGN KEY (`option_Type_ID`) REFERENCES `tbl_list_optiontypes` (`optiontype_ID`) ON DELETE CASCADE;

--
-- Constraints for table `tbl_skuoption_rel`
--
ALTER TABLE `tbl_skuoption_rel`
  ADD CONSTRAINT `FK_cw3_tbl_skuoptions_tbl_skuoption_rel` FOREIGN KEY (`optn_rel_Option_ID`) REFERENCES `tbl_skuoptions` (`option_ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_cw3_tbl_skus_tbl_skuoption_rel` FOREIGN KEY (`optn_rel_SKU_ID`) REFERENCES `tbl_skus` (`SKU_ID`) ON DELETE CASCADE;

--
-- Constraints for table `tbl_skus`
--
ALTER TABLE `tbl_skus`
  ADD CONSTRAINT `FK_cw3_tbl_products_tbl_skus` FOREIGN KEY (`SKU_ProductID`) REFERENCES `tbl_products` (`product_ID`) ON DELETE CASCADE;

--
-- Constraints for table `tbl_taxrates`
--
ALTER TABLE `tbl_taxrates`
  ADD CONSTRAINT `FK_cw3_tbl_taxgroups_tbl_taxrates` FOREIGN KEY (`taxrate_groupid`) REFERENCES `tbl_taxgroups` (`taxgroup_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_cw3_tbl_taxregions_tbl_taxrates` FOREIGN KEY (`taxrate_regionid`) REFERENCES `tbl_taxregions` (`taxregion_id`) ON DELETE CASCADE;

--
-- Constraints for table `tbl_taxregions`
--
ALTER TABLE `tbl_taxregions`
  ADD CONSTRAINT `FK_cw3_tbl_list_countries_tbl_taxregions` FOREIGN KEY (`taxregion_countryid`) REFERENCES `tbl_list_countries` (`country_ID`),
  ADD CONSTRAINT `FK_cw3_tbl_stateprov_tbl_taxregions` FOREIGN KEY (`taxregion_stateid`) REFERENCES `tbl_stateprov` (`stprv_ID`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
