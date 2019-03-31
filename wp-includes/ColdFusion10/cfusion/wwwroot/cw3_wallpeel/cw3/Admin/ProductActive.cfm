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
Name: ProductActive.cfm
Description: Display a list of Active Products
================================================================
--->

<!--- Set location for highlighting in Nav Menu --->
<cfset strSelectNav = "Products">

</cfsilent>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>CW Admin: Product List</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="assets/admin.css" rel="stylesheet" type="text/css">
</head>
<body>

<!--- Include Admin Navigation Menu--->
<cfinclude template="CWIncNav.cfm">

<div id="divMainContent">
 <cfinclude template="CWIncProductSearch.cfm">
<cfoutput>#PagingLinks#</cfoutput>
	<cfparam name="ImagePath" default="">
	<cfparam name="ImageSRC" default="">
 <cfparam name="RowCounter" default="0">
 <cfif rsProductsSearch.RecordCount NEQ 0>
    <h1>Product List</h1>
    <table>
      <tr>
        <th>Product ID</th>
        <th>Name</th>
        <th>Photo</th>
        <th>On Web</th>
        <th>Edit</th>
      </tr>
      <cfoutput query="rsProductsSearch" group="product_MerchantProductID" startrow="#StartRow_Results#" maxrows="#MaxRows_Results#">
				<cfset ImageSRC = cwGetImage(rsProductsSearch.product_ID, 1) />
				<cfset RowCounter = IncrementValue(RowCounter)>
        <tr class="#IIF(RowCounter MOD 2, DE('altRowEven'), DE('altRowOdd'))#">
          <td align="center">#rsProductsSearch.product_MerchantProductID#</td>
          <td><a href="ProductForm.cfm?product_ID=#rsProductsSearch.product_ID#" title="Edit #rsProductsSearch.product_Name#">#rsProductsSearch.product_Name#</a></td>
          <td align="center"><cfif ImageSRC NEQ ""><a href="ProductForm.cfm?product_ID=#rsProductsSearch.product_ID#"><img src="#ImageSRC#"></a></cfif></td>
          <td align="center"><input name="checkbox" type="checkbox" class="formCheckbox" value="checkbox" disabled<cfif #rsProductsSearch.product_OnWeb# EQ 1> checked</cfif>></td>
          <td align="center"><a href="ProductForm.cfm?product_ID=#rsProductsSearch.product_ID#"><img src="assets/images/edit.gif" alt="Edit #rsProductsSearch.product_Name#" width="15" height="15" border="0"></a></td>
        </tr>
      </cfoutput>
    </table>
		<cfoutput>#PagingLinks#</cfoutput>
  <cfelse>
 <p><strong>No Matches Found</strong></p>
 </cfif>
</div>
</body>
</html>