<cfsilent>
<!--- 
================================================================
Application Info: Cartweaver© 2002 - 2007, All Rights Reserved.
Developer Info: Application Dynamics Inc.
                1560 NE 10th
                East Wenatchee, WA 98802
Support Info: http://www.cartweaver.com/go/cfhelp
				
Cartweaver Version: 3.0.0  -  Date: 4/21/2007
================================================================
Name: ProductArchive.cfm
Description: Display a list of Archived products.
================================================================
--->

<!--- Set location for highlighting in Nav Menu --->
<cfset strSelectNav = "Products">

<!--- Reactivate Product --->
<cfif IsDefined ('URL.ReactivateProduct_ID')>
	<cfset Archive = "0">
	<cfquery name="rsArchiveProduct" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
	 UPDATE tbl_products
		SET product_Archive = '#Archive#'
		WHERE product_ID=#URL.ReactivateProduct_ID#
	</cfquery>
	<!--- Reactive all options associated with this product --->
	<cfquery name="rsArchivedOptions" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
	SELECT tbl_skuoptions.option_ID
	FROM tbl_skuoptions 
		INNER JOIN ((tbl_products 
			INNER JOIN tbl_skus 
			ON tbl_products.product_ID = tbl_skus.SKU_ProductID) 
			INNER JOIN tbl_skuoption_rel ON tbl_skus.SKU_ID = tbl_skuoption_rel.optn_rel_SKU_ID) 
			ON tbl_skuoptions.option_ID = tbl_skuoption_rel.optn_rel_Option_ID
	WHERE tbl_products.product_ID = #URL.ReactivateProduct_ID#
	AND tbl_skuoptions.option_Archive = 1
	</cfquery>
	<cfif rsArchivedOptions.recordcount NEQ 0>
		<cfset ArchivedOptions = ValueList(rsArchivedOptions.option_ID,",")>
		<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
		UPDATE tbl_skuoptions SET option_Archive = 0 WHERE option_ID IN (#ArchivedOptions#)
		</cfquery>
	</cfif>
	<cflocation url="ProductForm.cfm?product_ID=#URL.ReactivateProduct_ID#" addtoken="no">
</cfif>


<cfquery name="rsProductsSearch" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
SELECT tbl_products.product_ID, 
     tbl_products.product_MerchantProductID, 
	   tbl_products.product_Name 
FROM tbl_products
WHERE tbl_products.product_Archive = 1 
ORDER BY tbl_products.product_Sort, tbl_products.product_MerchantProductID, tbl_products.product_Name
</cfquery>


</cfsilent>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>CW Admin: Archived Products</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="assets/admin.css" rel="stylesheet" type="text/css">
</head>

<body>
<!--- Include Admin Navigation Menu--->
<cfinclude template="CWIncNav.cfm">

<div id="divMainContent">
	<cfparam name="ImagePath" default="">
	<cfparam name="ImageSRC" default="">
	<cfparam name="RowCounter" default="0">
  <h1>Archived Products</h1>
  <cfif #rsProductsSearch.RecordCount# NEQ 0>
	<table>
    <tr>
      <th>Product ID</th>
      <th>Name</th>
      <th align="center"><strong>Photo</strong></th>
      <th align="center">&nbsp;</th>
    </tr>
    <cfoutput query="rsProductsSearch" group="product_MerchantProductID">
			<!--- Get a product thumbnail if it exists --->
			<cfset ImageSRC = cwGetImage(rsProductsSearch.product_ID, 1) />

			<cfset RowCounter = IncrementValue(RowCounter)>
			
      <tr class="#IIF(RowCounter MOD 2, DE('altRowEven'), DE('altRowOdd'))#">
        <td align="center">#rsProductsSearch.product_MerchantProductID#</td>
        <td>#rsProductsSearch.product_Name#</td>
        <td align="center"><cfif ImageSRC NEQ ""><img src="#ImageSRC#"></cfif></td>
        <td align="center">[<a href="#request.ThisPage#?ReactivateProduct_ID=#rsProductsSearch.product_ID#">Reactivate</a>]</td>
      </tr>
    </cfoutput>
  </table>
	<cfelse>
		<p>There are currently no archived products.</p>
  </cfif>
</div>
</body>
</html>
