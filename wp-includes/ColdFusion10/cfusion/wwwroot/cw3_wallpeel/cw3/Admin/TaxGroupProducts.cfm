<cfsilent>
<!--- 
======================================================================
Application Info: Cartweaver© 2002 - 2007, All Rights Reserved.
Developer Info: Application Dynamics Inc.
                1560 NE 10th
                East Wenatchee, WA 98802
Support Info: http://www.cartweaver.com/go/cfhelp
				
Cartweaver Version: 3.0.0  -  Date: 4/21/2007
================================================================
Name: ListTaxGroups.cfm
Description: List Tax Groups
================================================================
--->
<!--- Set location for highlighting in Nav Menu --->
<cfset strSelectNav = "ShippingTax">
<cfparam name="URL.id" default="0" type="numeric" />

<cfif IsDefined("FORM.fieldnames")>
	<cfloop from="1" to="#FORM.ProductCount#" index="i">
		<cfquery datasource="#request.dsn#" username="#request.dsnusername#" password="#request.dsnpassword#">
		UPDATE tbl_products 
		SET product_taxgroupid = <cfqueryparam cfsqltype="cf_sql_integer" value="#FORM["TaxGroupID#i#"]#" />
		WHERE product_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#FORM["ProductID#i#"]#" />
		</cfquery>
	</cfloop>
</cfif>

<!--- Get Records --->
<cfquery name="rsProducts" datasource="#request.dsn#" username="#request.dsnusername#" password="#request.dsnpassword#">
SELECT product_id, product_name 
FROM tbl_Products 
WHERE product_taxgroupid = <cfqueryparam cfsqltype="cf_sql_integer" value="#URL.id#" />
</cfquery>

<cfquery name="rsTaxGroups" datasource="#request.dsn#" username="#request.dsnusername#" password="#request.dsnpassword#">
SELECT * FROM tbl_taxgroups
WHERE taxgroup_id <> <cfqueryparam cfsqltype="cf_sql_integer" value="#URL.id#" />
</cfquery>

<cfquery name="rsCurrentGroup" datasource="#request.dsn#" username="#request.dsnusername#" password="#request.dsnpassword#">
SELECT taxgroup_name FROM tbl_taxgroups
WHERE taxgroup_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#URL.id#" />
</cfquery>

<cfsavecontent variable="SelectMenuOptions">
<option value="">...</option>
<cfoutput query="rsTaxGroups"><option value="#rsTaxGroups.taxgroup_id#">#rsTaxGroups.taxgroup_name#</option></cfoutput>
</cfsavecontent>

</cfsilent>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>CW Admin: Tax Groups</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="assets/admin.css" rel="stylesheet" type="text/css">
</head>
<body> 
<!--- Include Admin Navigation Menu---> 
<cfinclude template="CWIncNav.cfm">
<div id="divMainContent">
	<cfif rsCurrentGroup.RecordCount EQ 0>
		<p>Invalid tax group id. Please return to the <a href="ListTaxGroups.cfm">Tax Group Listing</a> and choose a valid tax group.</p>
		<cfelse>
		<h1> Tax Group - <cfoutput>#rsCurrentGroup.taxgroup_name#</cfoutput></h1>
		<p><a href="TaxGroup.cfm?id=<cfoutput>#URL.id#</cfoutput>">Tax Rates</a> | Associated Products </p>
		<cfif rsProducts.RecordCount EQ 0>
			<p>There are currently no products assigned to this Tax Group. Products must be individually assigned to Tax Groups by editing the product. <a href="ProductActive.cfm">View Products</a>.</p>
			<cfelse>
			<cfform name="updateTaxGroup" method="POST" action="#request.ThisPageQS#">
				<table>
					<caption>
					Associated Products
					</caption>
					<tr>
						<th scope="col">Product Name </th>
						<th scope="col">Change to: </th>
					</tr>
					<cfoutput query="rsProducts">
						<tr class="#IIF(CurrentRow MOD 2, DE('altRowOdd'), DE('altRowEven'))#">
							<td><a href="ProductForm.cfm?product_id=#rsProducts.product_id#">#rsProducts.product_name#</a></td>
							<td><select name="TaxGroupID#CurrentRow#">
									#SelectMenuOptions#
								</select>
								<input type="hidden" name="ProductID#CurrentRow#" value="#rsProducts.product_id#" /></td>
						</tr>
					</cfoutput>
				</table>
				<input type="submit" class="formButton" value="Update Products">
				<input type="hidden" name="ProductCount" value="<cfoutput>#rsProducts.RecordCount#</cfoutput>" />
			</cfform>
		</cfif>
	</cfif>
</div>
</body>
</html>
