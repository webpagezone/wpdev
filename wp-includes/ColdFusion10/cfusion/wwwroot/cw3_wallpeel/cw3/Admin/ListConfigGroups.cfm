<cfsilent>
<!--- 
======================================================================
Application Info: Cartweaver© 2002 - 2007, All Rights Reserved.
Developer Info: Application Dynamics Inc.
                1560 NE 10th
                East Wenatchee, WA 98802
Support Info: http://www.cartweaver.com/go/cfhelp
				
Cartweaver Version: 3.0.5  -  Date: 5/13/2007
================================================================
Name: ListConfigGroups.cfm
Description: List Config Groups
================================================================
--->
<cfif Not IsDefined('Session.AccessLevel') OR Session.AccessLevel NEQ 'superadmin'>
	<cflocation url="AdminHome.cfm" addtoken="no" />
</cfif>
<!--- Set location for highlighting in Nav Menu --->
<cfset strSelectNav = "Settings">

<!--- ADD Record --->
<cfif IsDefined("FORM.AddRecord")>
	<!--- Check to be sure there isn't already a tax group by this name --->
	<cfquery name="rsCheckDupe" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
	SELECT configgroup_name FROM tbl_configgroup WHERE configgroup_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.configgroup_name#" />
	</cfquery>
	<cfif rsCheckDupe.RecordCount NEQ 0>
		<cfset errorText = "The configuration group <strong>#FORM.configgroup_name#</strong> already exists. Please choose a different configuration group name." />
	<cfelse>
		<!--- Add a new tax group --->
		<cfparam name="FORM.configgroup_showmerchant" default="False" />
		<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
		INSERT INTO tbl_configgroup (configgroup_name, configgroup_sort, configgroup_showmerchant, configgroup_protected) 
		VALUES (<cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.configgroup_name#" />
		, <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.configgroup_sort#" />
		, <cfqueryparam cfsqltype="cf_sql_bit" value="#FORM.configgroup_showmerchant#" />
		, <cfqueryparam cfsqltype="cf_sql_bit" value="0" />
		)
		</cfquery>
		<cflocation url="#request.ThisPageQS#" addtoken="no">
	</cfif>
</cfif>

<!--- Get Records --->
<cfquery name="rsConfigGroups" datasource="#request.dsn#" username="#request.dsnusername#" password="#request.dsnpassword#">
SELECT *
FROM tbl_configgroup
ORDER BY configgroup_sort, configgroup_name
</cfquery>
</cfsilent>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>CW Admin: Config Groups</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="assets/admin.css" rel="stylesheet" type="text/css">
</head>
<body> 
<!--- Include Admin Navigation Menu---> 
<cfinclude template="CWIncNav.cfm">
<div id="divMainContent">
	<h1>Config Groups </h1>
	<cfif IsDefined("errorText")>
		<p><cfoutput>#errorText#</cfoutput></p>
	<cfelse>
	<br/>
	</cfif>
	<cfform name="Add" method="POST" action="#request.ThisPage#">
		<table>
			<caption>
			Add Config Group
			</caption>
			<tr align="center">
				<th>Name</th>
				<th>Sort</th>
				<th>Show <br />
				Merchant </th>
				<th>Add</th>
			</tr>
			<tr align="center" class="altRowEven">
				<td><cfinput type="text" name="configgroup_name"  message="Name is Required" required="yes" size="25"></td>
				<td><cfinput type="text" name="configgroup_sort" required="yes" message="A sort order is required" validate="integer" size="4" value="0"></td>
				<td><input name="configgroup_showmerchant" type="checkbox" class="formCheckbox" id="configgroup_showmerchant" value="True"></td>
				<td><input name="AddRecord" type="submit" class="formButton" id="AddRecord" value="Add">				</td>
			</tr>
		</table>
	</cfform>
	<!--- Only show table if we have records --->
	<cfif rsConfigGroups.RecordCount NEQ 0>
		<table>
			<caption>
			Config Groups
			</caption>
			<tr>
				<th>Name</th>
				<th>Show<br />
					Merchant</th>
				<th>Sort</th>
			</tr>
			<cfoutput query="rsConfigGroups">
				<tr class="#IIF(CurrentRow MOD 2, DE('altRowOdd'), DE('altRowEven'))#">
					<td><a href="ConfigGroup.cfm?id=#rsConfigGroups.configgroup_id#">#rsConfigGroups.configgroup_name#</a></td>
					<td>#YesNoFormat(rsConfigGroups.configgroup_showmerchant)#</td>
					<td>#rsConfigGroups.configgroup_sort#</td>
				</tr>
			</cfoutput>
		</table>
		<cfelse>
		<p>There are currently no defined configuration groups.</p>
	</cfif>
</div>
</body>
</html>
