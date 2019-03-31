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
<cfparam name="FORM.action" default="" type="string" />

<!--- Check for current action --->
<cfswitch expression="#FORM.action#">
	<cfcase value="UpdateTaxGroup">
		<!--- Check to see if there is already a tax group by the new name --->
		<cfquery name="rsCheckDupe" datasource="#request.dsn#" username="#request.dsnusername#" password="#request.dsnpassword#">
		SELECT taxgroup_name 
		FROM tbl_taxgroups
		WHERE taxgroup_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.taxGroupName#" />
		AND taxgroup_id <> <cfqueryparam cfsqltype="cf_sql_integer" value="#URL.id#" />
		</cfquery>
		<cfif rsCheckDupe.RecordCount NEQ 0>
			<cfset taxGroupErrorText = "The tax group <strong>#FORM.taxGroupName#</strong> already exists. Please choose a different tax group name." />
		<cfelse>
			<cfquery datasource="#request.dsn#" username="#request.dsnusername#" password="#request.dsnpassword#">
			UPDATE tbl_taxgroups 
			SET taxgroup_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.taxGroupName#" />
			WHERE taxgroup_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#URL.id#" />
			</cfquery>
			<cflocation url="#Request.ThisPageQS#" addtoken="no" />
		</cfif>
	</cfcase>

	<cfcase value="AddTaxRate">
		<cfquery datasource="#request.dsn#" username="#request.dsnusername#" password="#request.dsnpassword#">
		INSERT INTO tbl_taxrates (taxrate_regionid, taxrate_groupid, taxrate_percentage)
		VALUES(
			<cfqueryparam cfsqltype="cf_sql_integer" value="#FORM.TaxRegionID#" />
			, <cfqueryparam cfsqltype="cf_sql_integer" value="#URL.id#" />
			, <cfqueryparam cfsqltype="cf_sql_double" value="#FORM.TaxRate#" />
		)
		</cfquery>
		<cflocation url="#Request.ThisPageQS#" addtoken="no" />
	</cfcase>
	
	<cfcase value="UpdateTaxRates">
		<cfparam name="FORM.DeleteRate" default="0" />
		<cfloop from="1" to="#FORM.RateCount#" index="i">
			<cfif NOT ListFind(FORM.DeleteRate, FORM["TaxRateID#i#"])>
				<!--- Update the rate --->
				<cfquery datasource="#request.dsn#" username="#request.dsnusername#" password="#request.dsnpassword#">
				UPDATE tbl_taxrates SET taxrate_percentage = <cfqueryparam cfsqltype="cf_sql_double" value="#FORM["TaxRate#i#"]#" />
				WHERE taxrate_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#FORM["TaxRateID#i#"]#" />
				</cfquery>
			</cfif>
			
			<!--- Delete tax rates --->
			<cfif FORM.DeleteRate NEQ 0>
				<cfquery datasource="#request.dsn#" username="#request.dsnusername#" password="#request.dsnpassword#">
				DELETE FROM tbl_taxrates WHERE taxrate_id IN (#FORM.DeleteRate#)
				</cfquery>
			</cfif>
		</cfloop>
		<cflocation url="#Request.ThisPageQS#" addtoken="no" />
	</cfcase>

</cfswitch>

<!--- Get Records --->
<cfquery name="rsTaxGroup" datasource="#request.dsn#" username="#request.dsnusername#" password="#request.dsnpassword#">
SELECT * FROM tbl_taxgroups WHERE taxgroup_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#URL.id#" />
</cfquery>

<cfquery name="rsTaxRates" datasource="#request.dsn#" username="#request.dsnusername#" password="#request.dsnpassword#">
SELECT tbl_taxregions.taxregion_id, tbl_taxregions.taxregion_label, tbl_taxrates.taxrate_regionid, tbl_stateprov.stprv_Name
, tbl_list_countries.country_Name, tbl_taxrates.taxrate_id, tbl_taxrates.taxrate_percentage
FROM (tbl_stateprov 
	RIGHT JOIN (tbl_list_countries 
		RIGHT JOIN tbl_taxregions ON tbl_list_countries.country_ID = tbl_taxregions.taxregion_countryid) 
	ON tbl_stateprov.stprv_ID = tbl_taxregions.taxregion_stateid) 
	INNER JOIN tbl_taxrates ON tbl_taxregions.taxregion_id = tbl_taxrates.taxrate_regionid
WHERE tbl_taxrates.taxrate_groupid = <cfqueryparam cfsqltype="cf_sql_integer" value="#URL.id#" />
</cfquery>

<cfset CurrentRegions = ValueList(rsTaxRates.taxrate_regionid) />
<cfif CurrentRegions EQ "">
	<cfset CurrentRegions = 0 />
</cfif>

<cfquery name="rsTaxRegions" datasource="#request.dsn#" username="#request.dsnusername#" password="#request.dsnpassword#">
SELECT tbl_taxregions.taxregion_id, tbl_taxregions.taxregion_label, tbl_stateprov.stprv_Name, tbl_list_countries.country_Name
FROM tbl_stateprov 
	RIGHT JOIN (tbl_list_countries 
		RIGHT JOIN tbl_taxregions ON tbl_list_countries.country_ID = tbl_taxregions.taxregion_countryid) 
	ON tbl_stateprov.stprv_ID = tbl_taxregions.taxregion_stateid
WHERE taxregion_id NOT IN (#CurrentRegions#)
ORDER BY tbl_list_countries.country_Name, tbl_stateprov.stprv_Name
</cfquery>

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
	<h1> Tax Group - <cfoutput>#rsTaxGroup.taxgroup_name#</cfoutput> </h1>
	<cfif rsTaxGroup.RecordCount EQ 0>
		<p>Invalid tax group id. Please return to the <a href="ListTaxGroups.cfm">Tax Group Listing</a> and choose a valid tax group.</p>
		<cfelse>
		<p>Tax Rates | <a href="TaxGroupProducts.cfm?id=<cfoutput>#URL.id#</cfoutput>">Associated Products</a> </p>
		<cfform name="updateTaxGroup" method="POST" action="#request.ThisPageQS#">
			<cfif IsDefined("taxGroupErrorText")>
				<p><cfoutput>#taxGroupErrorText#</cfoutput></p>
			</cfif>
			<table>
				<caption>
				Update Tax Group Name
				</caption>
				<tr align="center">
					<th>Name</th>
					<th>&nbsp;</th>
				</tr>
				<tr align="center" class="altRowOdd">
					<td><cfinput type="text" name="taxGroupName"  message="Name is Required" required="yes" value="#rsTaxGroup.taxgroup_name#" size="25">
					</td>
					<td><input type="submit" class="formButton" value="Update">
					</td>
				</tr>
			</table>
			<input type="hidden" name="action" value="UpdateTaxGroup" />
		</cfform>
		<cfif rsTaxRegions.RecordCount EQ 0>
			<p>You must have at least one  Tax Region  assigned to this Tax Group in order to add a new Tax Rate to this Tax Group. <a href="ListTaxRegions.cfm">Add a new Tax Region...</a></p>
			<cfelse>
			<cfform name="addTaxRate" action="#Request.ThisPageQS#" method="post">
				<table>
					<caption>
					Add New Tax Rate
					</caption>
					<tr>
						<th scope="col">Unassigned Tax Regions </th>
						<th scope="col">Tax Rate </th>
						<th scope="col">&nbsp;</th>
					</tr>
					<tr class="altRowOdd">
						<td scope="col"><select name="TaxRegionID">
								<option value="0" selected="selected">Choose Tax Region</option>
								<cfoutput query="rsTaxRegions">
									<option value="#rsTaxRegions.taxregion_id#">#rsTaxRegions.country_Name#
									<cfif rsTaxRegions.stprv_Name NEQ "">
										: #rsTaxRegions.stprv_Name#
									</cfif>
									(#rsTaxRegions.taxregion_label#)</option>
								</cfoutput>
							</select>
							<br />
							<a href="ListTaxRegions.cfm">Add New Tax Region</a> <br /></td>
						<td scope="col"><input name="taxRate" type="text" id="taxRate" size="6" maxlength="10">
							%</td>
						<td scope="col"><input type="submit" class="formButton" value="Add New Tax Rate"></td>
					</tr>
				</table>
				<input type="hidden" name="action" value="AddTaxRate" />
			</cfform>
		</cfif>
		<cfif rsTaxRates.RecordCount EQ 0>
			<cfif rsTaxRegions.RecordCount NEQ 0>
				<p>There are currently no tax rates defined for this tax group</p>
			</cfif>
			<cfelse>
			<cfform name="UpdateRates" action="#Request.ThisPageQS#" method="post">
				<table>
					<caption>
					Tax Rates
					</caption>
					<tr>
						<th align="center">Name</th>
						<th align="center">Tax Rate </th>
						<th align="center">Delete</th>
					</tr>
					<cfoutput query="rsTaxRates">
						<tr class="#IIF(CurrentRow MOD 2, DE('altRowOdd'), DE('altRowEven'))#">
							<td><a href="TaxRegion.cfm?id=#rsTaxRates.taxregion_id#">#rsTaxRates.country_Name#<cfif #rsTaxRates.stprv_Name# NEQ "">: #rsTaxRates.stprv_Name#</cfif>
								</a> (#rsTaxRates.taxregion_label#) </td>
							<td><input name="TaxRate#CurrentRow#" type="text" id="TaxRate#CurrentRow#" value="#rsTaxRates.taxrate_percentage#" size="6" maxlength="6">
								%</td>
							<td><input name="DeleteRate" type="checkbox" class="formCheckbox" value="#rsTaxRates.taxrate_id#">
								<input type="hidden" name="TaxRateID#CurrentRow#" value="#rsTaxRates.taxrate_id#" /></td>
						</tr>
					</cfoutput>
				</table>
				<input type="submit" class="formButton" value="Update Tax Rates">
				<input type="hidden" name="action" value="UpdateTaxRates" />
				<input type="hidden" name="RateCount" value="<cfoutput>#rsTaxRates.RecordCount#</cfoutput>" />
			</cfform>
		</cfif>
	</cfif>
</div>
</body>
</html>
