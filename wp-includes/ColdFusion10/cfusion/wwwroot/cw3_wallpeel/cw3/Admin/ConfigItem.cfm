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
Name: ConfigGroup.cfm
Description: Config Group
================================================================
--->
<cfif Not IsDefined('Session.AccessLevel') OR Session.AccessLevel NEQ 'superadmin'>
	<cflocation url="AdminHome.cfm" addtoken="no" />
</cfif>
<!--- Set location for highlighting in Nav Menu --->
<cfset strSelectNav = "Settings">

<cfparam name="URL.id" default="0" type="numeric" />
<cfparam name="URL.configid" default="0" type="numeric" />

<cfquery name="rsConfigItem" datasource="#request.dsn#" username="#request.dsnusername#" password="#request.dsnpassword#">
SELECT * FROM tbl_config
WHERE config_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#URL.id#" />
</cfquery>

<!--- Check for current action --->
<cfif IsDefined("FORM.fieldnames")>
	<cfif IsDefined("FORM.DeleteConfigItem")>
		<cfset tempVar = StructDelete(Application, rsConfigItem.config_variable) />
		<cfquery datasource="#request.dsn#" username="#request.dsnusername#" password="#request.dsnpassword#">
		DELETE FROM tbl_config 
		WHERE config_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#URL.id#" />
		</cfquery>
		<cflocation url="ConfigGroup.cfm?id=#URL.configid#" addtoken="no" />
	<cfelse>
		<!--- Update the rate --->
		<cfparam name="FORM.config_showmerchant" default="0" />
		<cfquery datasource="#request.dsn#" username="#request.dsnusername#" password="#request.dsnpassword#">
		UPDATE tbl_config SET 
			config_variable = <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.config_variable#" />
			, config_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.config_name#" />
			, config_value = <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.config_value#" />
			, config_type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.config_type#" />
			, config_description = <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.config_description#" />
			, config_possibles = <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.config_possibles#" />
			, config_showmerchant = <cfqueryparam cfsqltype="cf_sql_bit" value="#FORM.config_showmerchant#" />
			, config_sort = <cfqueryparam cfsqltype="cf_sql_integer" value="#FORM.config_sort#" />
		WHERE config_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#FORM.ConfigID#" />
		</cfquery>
		<!--- Delete the old value --->
		<cfset tempVar = StructDelete(Application, rsConfigItem.config_variable) />
		<!--- Set the new application variable --->
		<cfset Application[FORM.config_variable] = FORM.config_value />
		<cflocation url="#Request.ThisPageQS#" addtoken="no" />
	</cfif>
</cfif>

<cfquery name="rsConfigGroup" datasource="#request.dsn#" username="#request.dsnusername#" password="#request.dsnpassword#">
SELECT configgroup_name FROM tbl_configgroup 
WHERE configgroup_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#URL.configid#" />
</cfquery>

</cfsilent>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>CW Admin: Config Item</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="assets/admin.css" rel="stylesheet" type="text/css">
<script type="text/JavaScript">
<!--
function tmt_confirm(msg){
	document.MM_returnValue=(confirm(unescape(msg)));
}
//-->
</script>
</head>
<body> 
<!--- Include Admin Navigation Menu---> 
<cfinclude template="CWIncNav.cfm">
<div id="divMainContent">
	<h1> Configuration Group - <cfoutput>#rsConfigGroup.configgroup_name# - #rsConfigItem.config_name#</cfoutput></h1>
	<cfif rsConfigGroup.RecordCount EQ 0>
		<p>Invalid configuration group id. Please return to the <a href="ListConfigGroups.cfm">Configuration Group Listing</a> and choose a valid configuration group.</p>
		<cfelse>
		<cfform name="AddConfigItem" action="#Request.ThisPageQS#" method="post">
				<table>
					<caption>
					Edit Configuration Item
					</caption>
					<tr class="altRowOdd">
						<th align="right" scope="col"><label for="config_name">Friendly Name</label>:</th>
						<td scope="col"><input name="config_name" type="text" id="config_name" value="<cfoutput>#rsConfigItem.config_name#</cfoutput>"></td>
					</tr>
					<tr class="altRowOdd">
						<th align="right" scope="col"><label for="config_variable">Variable Name</label>:</th>
						<td scope="col"><input name="config_variable" type="text" id="config_variable" value="<cfoutput>#rsConfigItem.config_variable#</cfoutput>"></td>
					</tr>
					<tr class="altRowOdd">
						<th align="right" scope="col"><label for="config_sort">Sort Order</label>: </th>
						<td scope="col"><input name="config_sort" type="text" id="config_sort" value="<cfoutput>#rsConfigItem.config_sort#</cfoutput>" size="4"></td>
					</tr>
					<tr class="altRowOdd">
						<th align="right" scope="col"><label for="config_type">Form Type</label>:</th>
						<td scope="col"><select name="config_type" id="config_type">
							<option selected value="">Choose Form Field Type</option>
							<option value="boolean" <cfif rsConfigItem.config_type EQ "boolean">selected="selected"</cfif>>Checkbox</option>
							<option value="checkboxgroup" <cfif rsConfigItem.config_type EQ "checkbox">selected="selected"</cfif>>Checkbox Group</option>
							<option value="multiselect" <cfif rsConfigItem.config_type EQ "multiselect">selected="selected"</cfif>>Multiple Select List</option>
							<option value="radio" <cfif rsConfigItem.config_type EQ "radio">selected="selected"</cfif>>Radio Group</option>
							<option value="select" <cfif rsConfigItem.config_type EQ "select">selected="selected"</cfif>>Select List</option>
							<option value="textarea" <cfif rsConfigItem.config_type EQ "textarea">selected="selected"</cfif>>Textarea</option>
							<option value="text" <cfif rsConfigItem.config_type EQ "text">selected="selected"</cfif>>Text Field</option>
						</select></td>
					</tr>
					<tr class="altRowOdd">
						<th align="right" scope="col"><label for="config_value"> Value</label>:</th>
						<td scope="col"><input name="config_value" type="text" id="config_value" value="<cfoutput>#HTMLEditFormat(rsConfigItem.config_value)#</cfoutput>"></td>
					</tr>
					<tr class="altRowOdd">
						<th align="right" scope="col"><label for="config_possibles">Possible Values</label>:</th>
						<td scope="col">Enter one Name|Value pair per line <br />
						<textarea name="config_possibles" cols="40" rows="3" id="config_possibles"><cfoutput>#rsConfigItem.config_possibles#</cfoutput></textarea></td>
					</tr>
					<tr class="altRowOdd">
						<th align="right" scope="col"><label for="config_description">Description</label>: </th>
						<td scope="col"><textarea name="config_description" cols="40" rows="4" id="config_description"><cfoutput>#rsConfigItem.config_description#</cfoutput></textarea></td>
					</tr>
					
					<tr class="altRowOdd">
						<th align="right" scope="col">Show Merchant: </th>
						<td scope="col"><input name="config_showmerchant" type="checkbox" class="formCheckbox" id="config_showmerchant" value="1" <cfif rsConfigItem.config_showmerchant>checked="checked"</cfif>></td>
					</tr>
				</table>
				<input type="submit" class="formButton" value="Update Configuration Item">
				<input type="hidden" name="ConfigID" value="<cfoutput>#rsConfigItem.config_id#</cfoutput>" />
		</cfform>
		<cfif rsConfigItem.config_protected EQ 1>
			<p>This configuration item cannot be deleted.</p>
		<cfelse>
			<form method="post" name="deleteConfigItem" onSubmit="tmt_confirm('Are%20you%20sure%20you%20want%20to%20delete%20this%20config%20item?%0D%0AAny%20application%20code%20that%20depends%20on%20this%20value%20will%20no%20longer%20function%20correctly.%0D%0AClick%20OK%20to%20delete%20this%20item.');return document.MM_returnValue" accessible="<cfoutput>#Request.ThisPageQS#</cfoutput>">
				<div style="text-align: right;">
					<input name="deleteConfigItem" type="submit" class="formButton" value="Delete">
				</div>
			</form>
		</cfif>
	</cfif>
</div>
</body>
</html>
