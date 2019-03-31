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

<!--- Set Page Archive Status --->
<cfparam name="URL.TaxgroupView" default="0">

<!--- Set local variable for currently viewed status to limit hits to Client scope --->
<cfparam name="CurrentStatus" default="Active">
<cfif URL.TaxgroupView NEQ 0>
	<cfset CurrentStatus = "Archived">
</cfif>


<!--- ADD Record --->
<cfif IsDefined("FORM.AddRecord")>
	<!--- Check to be sure there isn't already a tax group by this name --->
	<cfquery name="rsCheckDupe" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
	SELECT taxgroup_name FROM tbl_taxgroups WHERE taxgroup_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.taxGroupName#" />
	</cfquery>
	<cfif rsCheckDupe.RecordCount NEQ 0>
		<cfset errorText = "The tax group <strong>#FORM.taxGroupName#</strong> already exists. Please choose a different tax group name." />
	<cfelse>
		<!--- Add a new tax group --->
		<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
		INSERT INTO tbl_taxgroups (taxgroup_name, taxgroup_archive) 
		VALUES (<cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.taxGroupName#" />,0)
		</cfquery>
		<cflocation url="#request.ThisPageQS#" addtoken="no">
	</cfif>
</cfif>

<!--- Update all taxgroups delete/archive --->
<cfif IsDefined("FORM.UpdateRecords")>
	<cfparam name="FORM.deleteTaxgroups" default="">
	<cfloop from="1" to="#FORM.TaxgroupCount#" index="id">
		<cfif IsDefined("form.deleteTaxgroup") AND ListFind(FORM.deleteTaxgroup,Evaluate("FORM.taxgroup_id"&id))>
			<!--- Delete Record --->
			<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
			DELETE FROM tbl_taxgroups WHERE taxgroup_id = #Evaluate("FORM.taxgroup_id"&id)#
			</cfquery>
		<cfelse>
			<!--- Update Records --->
			<cfparam name="FORM.taxgroup_Archive#id#" default="#URL.TaxgroupView#">
			<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
			UPDATE tbl_taxgroups SET 
			taxgroup_archive = #FORM["taxgroup_archive#id#"]# 
			WHERE taxgroup_id = #FORM["taxgroup_id#id#"]#
			</cfquery>
		</cfif>
	</cfloop>
	<cflocation url="#request.ThisPageQS#" addtoken="no">
</cfif>

<!--- Get Records --->
<cfquery name="rsTaxgroups" datasource="#request.dsn#" username="#request.dsnusername#" password="#request.dsnpassword#">
SELECT *
FROM tbl_taxgroups
WHERE taxgroup_archive = #url.TaxgroupView#
ORDER BY taxgroup_name ASC
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
	<h1> Tax Groups </h1>
	<cfif Application.TaxSystem NEQ "Groups"><p style="color:red">Tax groups disabled. To enable, choose Store Settings > Tax Settings > Tax System > Groups</p><cfabort></cfif>
	
	<cfif IsDefined("errorText")>
		<p><cfoutput>#errorText#</cfoutput></p>
	</cfif>
	<p>
	<cfif CurrentStatus EQ "Active"> 
		<a href="<cfoutput>#request.ThisPage#</cfoutput>?TaxgroupView=1">View Archived</a> 
		<cfelse> 
		<a href="<cfoutput>#request.ThisPage#</cfoutput>?TaxgroupView=0">View Active</a> 
	</cfif></p>

	<!--- If we are viewing ACTIVE records show the ADD NEW form ---> 
	<cfif CurrentStatus EQ "Active"> 
	<cfform name="Add" method="POST" action="#request.ThisPage#">
		<table>
			<caption>
			Add Tax Group
			</caption>
			<tr align="center">
				<th>Name</th>
				<th>Add</th>
			</tr>
			<tr align="center" class="altRowEven">
				<td><cfinput type="text" name="taxGroupName"  message="Name is Required" required="yes" size="25">
				</td>
				<td><input name="AddRecord" type="submit" class="formButton" id="AddRecord" value="Add">
				</td>
			</tr>
		</table>
	</cfform>
	</cfif>
	<!--- Only show table if we have records --->
	<cfif rsTaxGroups.RecordCount NEQ 0>
	<form action="<cfoutput>#Request.ThisPageQS#</cfoutput>" method="post" name="frmTaxgroups"> 
		<table>
			<caption>
			Tax Groups
			</caption>
			<tr>
				<th>Name</th>
				<th>Delete</th>
				<th><cfif URL.TaxgroupView EQ 0>Archive<cfelse>Activate</cfif></th>
			</tr>
			<cfoutput query="rsTaxGroups">
			<!--- Check to see if the tax group is associated with any Products. ---> 
			<cfquery name="rsProductTaxGroups" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
			SELECT product_taxgroupid FROM tbl_products 
			WHERE product_taxgroupid = #rsTaxGroups.taxgroup_id#
			</cfquery> 

				<tr class="#IIF(CurrentRow MOD 2, DE('altRowOdd'), DE('altRowEven'))#">
					<td><input type="hidden" name="taxgroup_id#CurrentRow#" value="#rsTaxGroups.taxgroup_id#"> 
					<a href="TaxGroup.cfm?id=#rsTaxGroups.taxgroup_id#">#rsTaxgroups.taxgroup_name#</a></td>
					<td align="center"><input type="checkbox" name="deleteTaxgroup" value="#rsTaxGroups.taxgroup_id#" class="formCheckbox"<cfif rsProductTaxGroups.RecordCount NEQ 0> disabled="disabled"</cfif> /></td>
					<td align="center"><input type="checkbox" name="taxgroup_archive#CurrentRow#" class="formCheckbox" value="<cfif URL.TaxgroupView EQ 1>0<cfelse>1</cfif>"> </td> 
				</tr>
			</cfoutput>
		</table>
		<input type="hidden" name="TaxgroupCount" id="TaxgroupCount" value="<cfoutput>#rsTaxgroups.RecordCount#</cfoutput>" /> 
		<input name="UpdateRecords" type="submit" class="formButton" id="UpdateRecords" value="Update Tax Groups" /> 
	</form>
		<cfelse>
		<p>There are currently no defined tax groups.</p>
	</cfif>
</div>
</body>
</html>
