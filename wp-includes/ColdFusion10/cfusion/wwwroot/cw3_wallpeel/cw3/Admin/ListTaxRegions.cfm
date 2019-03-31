<cfsilent>
<!--- 
======================================================================
Application Info: Cartweaver© 2002 - 2007, All Rights Reserved.
Developer Info: Application Dynamics Inc.
                1560 NE 10th
                East Wenatchee, WA 98802
Support Info: http://www.cartweaver.com/go/cfhelp
				
Cartweaver Version: 3.0.9  -  Date: 2/18/2008
================================================================
Name: ListTaxGroups.cfm
Description: List Tax Groups
================================================================
--->
<!--- Set location for highlighting in Nav Menu --->
<cfset strSelectNav = "ShippingTax">

<cfif IsDefined("FORM.fieldnames")>
	<!--- Check to see if the tax region is already defined --->
	<cfquery name="rsCheckDupe" datasource="#request.dsn#" username="#request.dsnusername#" password="#request.dsnpassword#">
	SELECT taxregion_id
	FROM tbl_taxregions
	WHERE taxregion_countryid = <cfqueryparam cfsqltype="cf_sql_integer" value="#FORM.CountryID#" />
	AND taxregion_stateid = <cfqueryparam cfsqltype="cf_sql_integer" value="#FORM.StateID#" />
	</cfquery>
	
	<cfif rsCheckDupe.RecordCount EQ 0>
		<!--- Add a new Tax Region --->
		<cfparam name="FORM.ShowTaxID" default="false" type="boolean" />
		<cfquery datasource="#request.dsn#" username="#request.dsnusername#" password="#request.dsnpassword#">
		INSERT INTO tbl_taxregions (
			taxregion_countryid, taxregion_stateid, taxregion_label, taxregion_taxid
			, taxregion_showid, taxregion_shiptaxmethod, taxregion_shiptaxgroupid)
		VALUES (
			<cfqueryparam cfsqltype="cf_sql_integer" value="#FORM.CountryID#" />
			, <cfqueryparam cfsqltype="cf_sql_integer" value="#FORM.StateID#" />
			, <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.TaxLabel#" />
			, <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.TaxID#" />
			, <cfqueryparam cfsqltype="cf_sql_bit" value="#FORM.ShowTaxID#" />
			<cfif IsNumeric(FORM.ShippingTax)>
				<!--- Shipping based on tax group --->
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="Tax Group" />
				, <cfqueryparam cfsqltype="cf_sql_integer" value="#FORM.ShippingTax#" />
			<cfelse>
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.ShippingTax#" />
				, <cfqueryparam cfsqltype="cf_sql_integer" value="0" />
			</cfif>
		)
		</cfquery>
		
		<cflocation url="#Request.ThisPage#" addtoken="no" />
	<cfelse>
		<cfset errorText = "A Tax Region matching your criteria is already defined." />
	</cfif>
	
</cfif>

<!--- Get Records --->
<cfquery name="rsTaxGroups" datasource="#request.dsn#" username="#request.dsnusername#" password="#request.dsnpassword#">
SELECT * FROM tbl_taxgroups ORDER BY taxgroup_name
</cfquery>

<cfquery name="rsTaxRegions" datasource="#request.dsn#" username="#request.dsnusername#" password="#request.dsnpassword#">
SELECT tbl_taxregions.*, tbl_stateprov.stprv_Name, tbl_list_countries.country_Name, tbl_taxgroups.taxgroup_name
FROM (tbl_stateprov RIGHT JOIN 
	(tbl_list_countries RIGHT JOIN tbl_taxregions ON tbl_list_countries.country_ID = tbl_taxregions.taxregion_countryid) 
	ON tbl_stateprov.stprv_ID = tbl_taxregions.taxregion_stateid) 
	LEFT JOIN tbl_taxgroups ON tbl_taxregions.taxregion_shiptaxgroupid = tbl_taxgroups.taxgroup_id
ORDER BY tbl_list_countries.country_Name, tbl_stateprov.stprv_Name
</cfquery>

<!--- Get states for select menus ---> 
<cfquery name="rsGetStates" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
SELECT tbl_list_countries.country_ID, tbl_stateprov.stprv_ID, tbl_list_countries.country_Name, tbl_stateprov.stprv_Name, tbl_list_countries.country_DefaultCountry
FROM tbl_list_countries INNER JOIN tbl_stateprov ON tbl_list_countries.country_ID = tbl_stateprov.stprv_Country_ID
WHERE tbl_list_countries.country_Archive = 0 AND tbl_stateprov.stprv_Archive = 0
ORDER BY tbl_list_countries.country_Sort, tbl_list_countries.country_Name, tbl_stateprov.stprv_Name
</cfquery>

<cfset intListCounter = 0>
</cfsilent>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>CW Admin: Tax Regions</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="assets/admin.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="../assets/scripts/dropdowns.js"></script>
<script language="JavaScript">
	var arrDynaList = new Array();
	var arrDL1 = new Array();
	arrDL1[1] = "CountryID";
	arrDL1[2] = "AddRegion";
	arrDL1[3] = "StateID";
	arrDL1[4] = "AddRegion";
	arrDL1[5] = arrDynaList;
	//Explanation:
	//Element 1: Parent relationship
	//Element 2: Child Label
	//Element 3: Child Value
	<cfoutput query="rsGetStates" group="country_id">
		arrDynaList[#intListCounter#] = "#country_ID#";
		<cfset intListCounter = intListCounter + 1>
		arrDynaList[#intListCounter#] = "Entire Country";
		<cfset intListCounter = intListCounter + 1>
		arrDynaList[#intListCounter#] = "0";
		<cfset intListCounter = intListCounter + 1>
		<cfoutput>
			arrDynaList[#intListCounter#] = "#country_ID#";
			<cfset intListCounter = intListCounter + 1>
			arrDynaList[#intListCounter#] = "#stprv_Name#";
			<cfset intListCounter = intListCounter + 1>
			arrDynaList[#intListCounter#] = "#stprv_ID#";
			<cfset intListCounter = intListCounter + 1>
		</cfoutput>
	</cfoutput> 
</script> 
</head>
<body> 
<!--- Include Admin Navigation Menu---> 
<cfinclude template="CWIncNav.cfm">
<div id="divMainContent">
	<h1> Tax Regions </h1>
	<cfif Application.TaxSystem NEQ "Groups"><p style="color:red">Tax groups disabled. To enable, choose Store Settings > Tax Settings > Tax System > Groups</p><cfabort></cfif>
	
	<cfif IsDefined("errorText")>
		<p><cfoutput>#errorText#</cfoutput></p>
	</cfif>
	<cfform name="AddRegion" method="POST" action="#request.ThisPage#">
		<table>
			<caption>
			Add Tax Region
			</caption>
			<tr class="altRowEven">
				<th align="right"><label for="Country">Tax Region: </label></th>
				<td><noscript>
					Please enable javascript for this page to function properly
					<style type="text/css">
				#countryMenus {display: none;}
				</style>
					</noscript>
					<div id="countryMenus">
						<select name="CountryID" onChange="setDynaList(arrDL1)">
							<option value="0" selected="selected">Choose Country</option>
							<cfoutput query="rsGetStates" group="country_Name">
								<option value="#country_ID#">#country_Name#</option>
							</cfoutput>
						</select>
						:
						<select name="StateID">
							<option></option>
						</select>
					</div></td>
			</tr>
			<tr class="altRowEven">
				<th align="right"><label for="TaxLabel">Tax Label: </label></th>
				<td><input name="TaxLabel" type="text" id="TaxLabel" size="30"></td>
			</tr>
			<tr class="altRowEven">
				<th align="right"><label for="TaxID">Tax ID Number: </label></th>
				<td><input name="TaxID" type="text" id="TaxID" size="30">
					<br />
					<input name="ShowTaxID" type="checkbox" class="formCheckbox" id="ShowTaxID" value="true">
					Show Tax ID on Invoice</td>
			</tr>
			<tr class="altRowEven">
				<th align="right"><label for="ShippingTax">Shipping Tax Method: </label></th>
				<td><select name="ShippingTax" id="ShippingTax">
						<option value="No Tax">No tax on shipping</option>
						<option value="Highest Item Taxed">Use Tax Rate of the highest taxed item in the order</option>
						<optgroup label="Based on a Tax Group"> <cfoutput query="rsTaxGroups">
							<option value="#rsTaxGroups.taxgroup_id#">#rsTaxGroups.taxgroup_name#</option>
						</cfoutput> </optgroup>
					</select>
				</td>
			</tr>
		</table>
		<input name="AddRecord" type="submit" class="formButton" id="AddRecord" value="Add">
		<script language="JavaScript">setDynaList(arrDL1);</script>
	</cfform>
	<cfif rsTaxRegions.RecordCount EQ 0>
		<p>There are currently no defined Tax Regions.</p>
		<cfelse>
		<table>
			<caption>
			Tax Regions
			</caption>
			<tr>
				<th>Name</th>
				<th>Tax Label </th>
				<th>Tax ID </th>
				<th>Show Tax ID </th>
				<th>Ship Tax Method </th>
			</tr>
			<cfoutput query="rsTaxRegions">
				<tr class="#IIF(CurrentRow MOD 2, DE('altRowOdd'), DE('altRowEven'))#">
					<td><a href="TaxRegion.cfm?id=#rsTaxRegions.taxregion_id#">#rsTaxRegions.country_Name#
						<cfif rsTaxRegions.stprv_Name NEQ "">
							: #rsTaxRegions.stprv_Name#
						</cfif>
						</a></td>
					<td>#rsTaxRegions.taxregion_label#</td>
					<td>#rsTaxRegions.taxregion_taxid#</td>
					<td>#YesNoFormat(rsTaxRegions.taxregion_showid)#</td>
					<td>#rsTaxRegions.taxregion_shiptaxmethod#<cfif rsTaxRegions.taxgroup_name NEQ "">: <a href="TaxGroup.cfm?id=#rsTaxRegions.taxregion_shiptaxgroupid#">#rsTaxRegions.taxgroup_name#</a></cfif></td>
				</tr>
			</cfoutput>
		</table>
	</cfif>
</div>
</body>
</html>
