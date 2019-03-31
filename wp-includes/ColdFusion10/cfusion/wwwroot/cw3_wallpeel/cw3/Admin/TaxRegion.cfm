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
Name: TaxRegion.cfm
Description: Tax Regions
================================================================
--->
<!--- Set location for highlighting in Nav Menu --->
<cfset strSelectNav = "ShippingTax">
<cfparam name="URL.id" default="0" />
<cfparam name="FORM.action" default="" />

<cfswitch expression="#FORM.action#">
	<cfcase value="UpdateTaxRegion">
		<cfparam name="FORM.ShowID" default="false" />
		<cfquery datasource="#request.dsn#" username="#request.dsnusername#" password="#request.dsnpassword#">
		UPDATE tbl_taxregions SET
		taxregion_label = <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.TaxLabel#" />
		, taxregion_taxid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.TaxID#" />
		, taxregion_showid = <cfqueryparam cfsqltype="cf_sql_bit" value="#FORM.ShowID#" />
		<cfif IsNumeric(FORM.ShippingTax)>
			<!--- Shipping based on tax group --->
			, taxregion_shiptaxmethod = <cfqueryparam cfsqltype="cf_sql_varchar" value="Tax Group" />
			, taxregion_shiptaxgroupid = <cfqueryparam cfsqltype="cf_sql_integer" value="#FORM.ShippingTax#" />
		<cfelse>
			, taxregion_shiptaxmethod = <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.ShippingTax#" />
			, taxregion_shiptaxgroupid = <cfqueryparam cfsqltype="cf_sql_integer" value="0" />
		</cfif>
		WHERE taxregion_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#URL.id#" />
		</cfquery>
		
		<cflocation url="#Request.ThisPageQS#" addtoken="no" />
	</cfcase>
	
	<cfcase value="AddTaxRate">
		<cfquery datasource="#request.dsn#" username="#request.dsnusername#" password="#request.dsnpassword#">
		INSERT INTO tbl_taxrates (taxrate_regionid, taxrate_groupid, taxrate_percentage)
		VALUES (
			<cfqueryparam cfsqltype="cf_sql_integer" value="#URL.id#" />
			, <cfqueryparam cfsqltype="cf_sql_integer" value="#FORM.TaxGroupID#" />
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
<cfquery name="rsTaxRegion" datasource="#request.dsn#" username="#request.dsnusername#" password="#request.dsnpassword#">
SELECT tbl_taxregions.*, tbl_stateprov.stprv_Name, tbl_list_countries.country_Name
FROM tbl_list_countries 
	RIGHT JOIN (tbl_stateprov RIGHT JOIN tbl_taxregions ON tbl_stateprov.stprv_ID = tbl_taxregions.taxregion_stateid) 
	ON tbl_list_countries.country_ID = tbl_taxregions.taxregion_countryid
WHERE taxregion_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#URL.id#" />
</cfquery>

<cfquery name="rsAllTaxGroups" datasource="#request.dsn#" username="#request.dsnusername#" password="#request.dsnpassword#">
SELECT * FROM tbl_taxgroups ORDER BY taxgroup_name
</cfquery>

<cfquery name="rsTaxRates" datasource="#request.dsn#" username="#request.dsnusername#" password="#request.dsnpassword#">
SELECT tbl_taxrates.taxrate_id, tbl_taxrates.taxrate_percentage, tbl_taxgroups.taxgroup_name, tbl_taxgroups.taxgroup_id
FROM tbl_taxgroups INNER JOIN tbl_taxrates ON tbl_taxgroups.taxgroup_id = tbl_taxrates.taxrate_groupid
WHERE tbl_taxrates.taxrate_regionid = <cfqueryparam cfsqltype="cf_sql_integer" value="#URL.id#" />
ORDER BY taxgroup_name
</cfquery>

<cfset UsedGroupIDs = ValueList(rsTaxRates.taxgroup_id) />
<cfif UsedGroupIDs EQ "">
	<cfset UsedGroupIDs = 0 />
</cfif>

<cfquery name="rsTaxGroups" datasource="#request.dsn#" username="#request.dsnusername#" password="#request.dsnpassword#">
SELECT * 
FROM tbl_taxgroups 
WHERE taxgroup_id NOT IN (#UsedGroupIDs#)
ORDER BY taxgroup_name
</cfquery>

<cfif rsTaxRegion.RecordCount NEQ 0>
	<!--- Set default form variables --->
	<cfparam name="FORM.TaxLabel" default="#rsTaxRegion.taxregion_label#" />
	<cfparam name="FORM.TaxID" default="#rsTaxRegion.taxregion_taxid#" />
	<cfparam name="FORM.ShowID" default="#rsTaxRegion.taxregion_showid#" />
	<cfif rsTaxRegion.taxregion_shiptaxmethod EQ "Tax Group">
		<cfparam name="FORM.ShippingTax" default="#rsTaxRegion.taxregion_shiptaxgroupid#" />
	<cfelse>
		<cfparam name="FORM.ShippingTax" default="#rsTaxRegion.taxregion_shiptaxmethod#" />
	</cfif>
</cfif>

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
	<h1> Tax Region - <cfoutput>#rsTaxRegion.country_Name#<cfif rsTaxRegion.stprv_Name NEQ "">: #rsTaxRegion.stprv_Name#</cfif></cfoutput></h1>
	<cfif rsTaxRegion.RecordCount EQ 0>
		<p>Invalid Tax Regon id. Please return to the <a href="ListTaxRegions.cfm">Tax Region Listing</a> and choose a valid Tax Region.</p>
		<cfelse>
		<cfform name="updateTaxGroup" method="POST" action="#request.ThisPageQS#">
			<table>
				<caption>
				Tax Region Details
				</caption>
				<tr class="altRowEven">
					<th align="right"><label for="TaxLabel">Tax Label: </label></th>
					<td><input name="TaxLabel" type="text" id="TaxLabel" value="<cfoutput>#FORM.TaxLabel#</cfoutput>" size="30"></td>
				</tr>
				<tr class="altRowEven">
					<th align="right"><label for="TaxID">Tax ID Number: </label></th>
					<td><input name="TaxID" type="text" id="TaxID" value="<cfoutput>#FORM.TaxID#</cfoutput>" size="30">
						<br />
						<input name="ShowTaxID" type="checkbox" class="formCheckbox" id="ShowTaxID" value="true" <cfif FORM.ShowID>checked="checked"</cfif>>
						Show Tax ID on Invoice</td>
				</tr>
				<tr class="altRowEven">
					<th align="right"><label for="ShippingTax">Shipping Tax Method: </label></th>
					<td><select name="ShippingTax" id="ShippingTax">
							<option value="No Tax" <cfif FORM.ShippingTax EQ "No Tax"> selected="selected"</cfif>>No tax on shipping</option>
							<option value="Highest Item Taxed" <cfif FORM.ShippingTax EQ "Highest Item Taxed"> selected="selected"</cfif>>Use Tax Rate of the highest taxed item in the order</option>
							<optgroup label="Based on a Tax Group"> <cfoutput query="rsAllTaxGroups">
								<option value="#rsAllTaxGroups.taxgroup_id#" <cfif FORM.ShippingTax EQ rsAllTaxGroups.taxgroup_id> selected="selected"</cfif>>#rsAllTaxGroups.taxgroup_name#</option>
							</cfoutput> </optgroup>
						</select>
					</td>
				</tr>
			</table>
			<p>
				<input type="submit" class="formButton" value="Update">
				<input type="hidden" name="action" value="UpdateTaxRegion" />
			</p>
		</cfform>
		<cfif rsTaxGroups.RecordCount EQ 0>
			<p>You must have at least one Tax Group not assigned to this Tax Region in order to add a new Tax Rate to this Tax Region. <a href="ListTaxGroups.cfm">Add a new Tax Group...</a></p>
			<cfelse>
			<cfform name="addTaxRate" method="post" action="#Request.ThisPageQS#">
				<table>
					<caption>
					Add New Tax Rate
					</caption>
					<tr>
						<th scope="col">Unassigned Tax Groups </th>
						<th scope="col">Tax Rate </th>
						<th scope="col">&nbsp;</th>
					</tr>
					<tr class="altRowOdd">
						<td scope="col"><select name="TaxGroupID">
								<option value="0">Choose Tax Group</option>
								<cfoutput query="rsTaxGroups">
									<option value="#rsTaxGroups.taxgroup_id#">#rsTaxGroups.taxgroup_name#</option>
								</cfoutput>
							</select>
							<br />
							<a href="ListTaxGroups.cfm">Add New Tax Group </a> <br /></td>
						<td scope="col"><input name="TaxRate" type="text" id="TaxRate" size="6" maxlength="10">
							%</td>
						<td scope="col"><input type="submit" class="formButton" value="Add New Tax Rate"></td>
					</tr>
				</table>
				<input type="hidden" name="action" value="AddTaxRate" />
			</cfform>
		</cfif>
		<cfif rsTaxRates.RecordCount EQ 0>
			<cfif rsTaxGroups.RecordCount NEQ 0>
				<p>There are currently no Tax Rates defined for this Tax Region</p>
			</cfif>
			<cfelse>
			<cfform>
				<table>
					<caption>
					Tax Groups
					</caption>
					<tr>
						<th align="center">Name</th>
						<th align="center">Tax Rate </th>
						<th align="center">Delete</th>
					</tr>
					<cfoutput query="rsTaxRates">
						<tr class="#IIF(CurrentRow MOD 2, DE('altRowOdd'), DE('altRowEven'))#">
							<td><a href="TaxGroup.cfm?id=#rsTaxRates.taxgroup_id#">#rsTaxRates.taxgroup_name#</a></td>
							<td><input name="TaxRate#CurrentRow#" type="text" id="TaxRate#CurrentRow#" value="#rsTaxRates.taxrate_percentage#" size="6" maxlength="10">
								%</td>
							<td><input name="DeleteRate" type="checkbox" class="formCheckbox" value="#rsTaxRates.taxrate_id#" />
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
