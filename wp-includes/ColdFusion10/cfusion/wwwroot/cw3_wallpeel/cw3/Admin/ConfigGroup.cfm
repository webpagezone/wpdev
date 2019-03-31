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
<cfparam name="FORM.action" default="" type="string" />
<cfparam name="Form.config_possibles" default="NULL" />
<!--- Check for current action --->
<cfswitch expression="#FORM.action#">
	<cfcase value="UpdateConfigGroup">
		<!--- Check to see if there is already a tax group by the new name --->
		<cfquery name="rsCheckDupe" datasource="#request.dsn#" username="#request.dsnusername#" password="#request.dsnpassword#">
		SELECT configgroup_name 
		FROM tbl_configgroup
		WHERE configgroup_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.configgroup_name#" />
		AND configgroup_id <> <cfqueryparam cfsqltype="cf_sql_integer" value="#URL.id#" />
		</cfquery>
		<cfif rsCheckDupe.RecordCount NEQ 0>
			<cfset configgroupErrorText = "The configuration group <strong>#FORM.configgroup_name#</strong> already exists. Please choose a different configuration group name." />
		<cfelse>
			<cfparam name="FORM.configgroup_showmerchant" default="False" />
			<cfquery datasource="#request.dsn#" username="#request.dsnusername#" password="#request.dsnpassword#">
			UPDATE tbl_configgroup
			SET 
				configgroup_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.configgroup_name#" />
				, configgroup_sort = <cfqueryparam cfsqltype="cf_sql_integer" value="#FORM.configgroup_sort#" />
				, configgroup_showmerchant = <cfqueryparam cfsqltype="cf_sql_bit" value="#FORM.configgroup_showmerchant#" />
			WHERE configgroup_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#URL.id#" />
			</cfquery>
			<cflocation url="#Request.ThisPageQS#" addtoken="no" />
		</cfif>
	</cfcase>

	<cfcase value="AddConfigItem">
		<cfparam name="FORM.config_showmerchant" default="0" />
		<cfquery datasource="#request.dsn#" username="#request.dsnusername#" password="#request.dsnpassword#">
		INSERT INTO tbl_config (config_groupid, config_variable, config_name, config_value, config_type, config_description, config_possibles, config_showmerchant, config_sort)
		VALUES(
			<cfqueryparam cfsqltype="cf_sql_integer" value="#URL.id#" />
			, <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.config_variable#" />
			, <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.config_name#" />
			, <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.config_value#" />
			, <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.config_type#" />
			, <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.config_description#" />
			, <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.config_possibles#" />
			, <cfqueryparam cfsqltype="cf_sql_bit" value="#FORM.config_showmerchant#" />
			, <cfqueryparam cfsqltype="cf_sql_integer" value="#FORM.config_sort#" />
		)
		</cfquery>
		<cflocation url="#Request.ThisPageQS#" addtoken="no" />
	</cfcase>
	
	<cfcase value="UpdateConfigItems">
		<cfparam name="FORM.DeleteConfigItem" default="0" />
		<cfloop from="1" to="#FORM.ConfigCount#" index="i">
			<cfparam name="FORM.ConfigValue#i#" default="False" />
			<!--- Update the config item --->
			<cfquery datasource="#request.dsn#" username="#request.dsnusername#" password="#request.dsnpassword#">
			UPDATE tbl_config SET config_value = <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM["ConfigValue#i#"]#" />
			WHERE config_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#FORM["ConfigItem#i#"]#" />
			</cfquery>
			<cfset Application[FORM["ConfigVariable#i#"]] = FORM["ConfigValue#i#"] />
			
		</cfloop>
		<cflocation url="#Request.ThisPageQS#" addtoken="no" />
	</cfcase>
	
	<cfcase value="Delete Group">
		<!--- Get a list of all existing config items to clear application variables --->
		<cfquery name="rsDeleteItems" datasource="#request.dsn#" username="#request.dsnusername#" password="#request.dsnpassword#">
		SELECT config_variable FROM tbl_config
		WHERE config_groupid = <cfqueryparam cfsqltype="cf_sql_integer" value="#URL.id#" />
		AND config_protected = <cfqueryparam cfsqltype="cf_sql_integer" value="0" />
		</cfquery>

		<cfloop query="rsDeleteItems">
			<cfset tempVar = StructDelete(Application, rsDeleteItems.config_variable) />
		</cfloop>
		
		<!--- Delete group items --->
		<cfquery datasource="#request.dsn#" username="#request.dsnusername#" password="#request.dsnpassword#">
		DELETE FROM tbl_config 
		WHERE config_groupid = <cfqueryparam cfsqltype="cf_sql_integer" value="#URL.id#" />
		AND config_protected = <cfqueryparam cfsqltype="cf_sql_integer" value="0" />
		</cfquery>
		
		<!--- Check to see if there are any config items left that were protected --->
		<cfquery name="rsCheck" datasource="#request.dsn#" username="#request.dsnusername#" password="#request.dsnpassword#">
		SELECT config_variable FROM tbl_config
		WHERE config_groupid = <cfqueryparam cfsqltype="cf_sql_integer" value="#URL.id#" />
		</cfquery>
		
		<cfif rsCheck.RecordCount EQ 0>
			<!--- Delete the group --->
			<cfquery datasource="#request.dsn#" username="#request.dsnusername#" password="#request.dsnpassword#">
			DELETE FROM tbl_configgroup
			WHERE configgroup_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#URL.id#" />
			</cfquery>
		</cfif>
		
		<!--- Redirect to the group list --->
		<cflocation url="ListConfigGroups.cfm" addtoken="no" />
	</cfcase>

</cfswitch>

<!--- Get Records --->
<cfquery name="rsConfigGroup" datasource="#request.dsn#" username="#request.dsnusername#" password="#request.dsnpassword#">
SELECT * FROM tbl_configgroup WHERE configgroup_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#URL.id#" />
</cfquery>

<cfquery name="rsConfigItems" datasource="#request.dsn#" username="#request.dsnusername#" password="#request.dsnpassword#">
SELECT * FROM tbl_config
WHERE config_groupid = <cfqueryparam cfsqltype="cf_sql_integer" value="#URL.id#" />
</cfquery>

</cfsilent>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>CW Admin: Config Group</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="assets/admin.css" rel="stylesheet" type="text/css">
<script type="text/JavaScript">
<!--
function tmt_confirm(msg){
	document.MM_returnValue=(confirm(unescape(msg)));
}
function enablePossibles(obj){
	var enable = obj.options[obj.selectedIndex].getAttribute('multivalue');
	var objTextarea = document.getElementById('config_possibles');
	if(enable == "true"){
		objTextarea.removeAttribute('disabled');
	}else{
		objTextarea.disabled = "disabled";
	}
}
//-->
</script>
</head>
<body> 
<!--- Include Admin Navigation Menu---> 
<cfinclude template="CWIncNav.cfm">
<div id="divMainContent">
	<h1> Configuration Group - <cfoutput>#rsConfigGroup.configgroup_name#</cfoutput> </h1>
	<p>Return to <a href="ListConfigGroups.cfm">Configuration Group List</a> </p>
	<cfif rsConfigGroup.RecordCount EQ 0>
		<p>Invalid configuration group id. Please return to the <a href="ListConfigGroups.cfm">Configuration Group Listing</a> and choose a valid configuration group.</p>
		<cfelse>
		<cfform name="updateconfiggroup" method="POST" action="#request.ThisPageQS#">
			<cfif IsDefined("ConfigGroupErrorText")>
				<p><cfoutput>#ConfigGroupErrorText#</cfoutput></p>
			</cfif>
			<table>
				<caption>
				Update Configuration Group Name
				</caption>
				<tr align="center">
					<th>Name</th>
					<th>Sort</th>
					<th>Show <br />
						Merchant </th>
					<th>&nbsp;</th>
				</tr>
				<tr align="center" class="altRowOdd">
					<td><cfinput type="text" name="ConfigGroup_Name"  message="Name is Required" required="yes" id="ConfigGroup_Name" value="#rsConfigGroup.configgroup_name#" size="25">					</td>
					<td class="altRowEven"><cfinput type="text" name="configgroup_sort" required="yes" message="A sort order is required" validate="integer" size="4" value="#rsConfigGroup.configgroup_sort#"></td>
					<td class="altRowEven"><input name="configgroup_showmerchant" type="checkbox" class="formCheckbox" id="configgroup_showmerchant" value="True"<cfif rsConfigGroup.configgroup_showmerchant> checked="checked"</cfif>></td>
					<td><input type="submit" class="formButton" value="Update">					</td>
				</tr>
			</table>
			<input type="hidden" name="action" value="UpdateConfigGroup" />
		</cfform>
			<cfform name="AddConfigItem" action="#Request.ThisPageQS#" method="post">
				<table>
					<caption>
					Add New Configuration Item
					</caption>
					<tr class="altRowOdd">
						<th align="right" scope="col"><label for="config_name">Friendly Name</label>:</th>
						<td scope="col"><cfinput name="config_name" type="text" id="config_name" required="yes" message="A Friendly Name is required."></td>
					</tr>
					<tr class="altRowOdd">
						<th align="right" scope="col"><label for="config_variable">Variable Name</label>:</th>
						<td scope="col"><cfinput name="config_variable" type="text" id="config_variable" required="yes" message="A Variable Name is required."></td>
					</tr>
					<tr class="altRowOdd">
						<th align="right" scope="col"><label for="config_sort">Sort Order</label>: </th>
						<td scope="col"><cfinput name="config_sort" type="text" id="config_sort" value="0" size="4" required="yes" validate="integer" message="A numeric Sort Order is required."></td>
					</tr>
					<tr class="altRowOdd">
						<th align="right" scope="col"><label for="config_type">Form Type</label>:</th>
						<td scope="col"><select name="config_type" id="config_type" onchange="enablePossibles(this);">
							<option selected="selected">Choose Form Field Type</option>
							<option value="boolean" multivalue="false">Checkbox</option>
							<option value="checkboxgroup" multivalue="true">Checkbox Group</option>
							<option value="multiselect" multivalue="true">Multiple Select List</option>
							<option value="radio" multivalue="true">Radio Group</option>
							<option value="select" multivalue="true">Select List</option>
							<option value="textarea" multivalue="false">Textarea</option>
							<option value="text" multivalue="false">Text Field</option>
						</select></td>
					</tr>
					<tr class="altRowOdd">
						<th align="right" scope="col"><label for="config_value">Initial Value</label>:</th>
						<td scope="col"><cfinput name="config_value" type="text" id="config_value" required="yes" message="An Initial Value is required."></td>
					</tr>
					<tr class="altRowOdd">
						<th align="right" scope="col"><label for="config_possibles">Possible Values</label>:</th>
						<td scope="col">Enter one Name|Value pair per line <br />
						<textarea disabled="disabled" name="config_possibles" cols="40" rows="3" id="config_possibles"></textarea></td>
					</tr>
					<tr class="altRowOdd">
						<th align="right" scope="col"><label for="config_description">Description</label>: </th>
						<td scope="col"><textarea name="config_description" cols="40" rows="4" id="config_description"></textarea></td>
					</tr>
					
					<tr class="altRowOdd">
						<th align="right" scope="col">Show Merchant: </th>
						<td scope="col"><input name="config_showmerchant" type="checkbox" class="formCheckbox" id="config_showmerchant" value="1"></td>
					</tr>
				</table>
				<input type="submit" class="formButton" value="Add New Configuration Item">
				<input type="hidden" name="action" value="AddConfigItem" />
			</cfform>
		<cfif rsConfigItems.RecordCount EQ 0>
			<cfelse>
			<br />
			<cfform name="UpdateItems" action="#Request.ThisPageQS#" method="post">
				<table>
					<caption>
					Configuration Items
					</caption>
					<tr>
						<th align="center">Name</th>
						<th align="center">Value</th>
						<th align="center">Help</th>
					</tr>
					<cfoutput query="rsConfigItems">
						<cfset fieldName = "ConfigValue" & CurrentRow />
						<cfset fieldValue = rsConfigItems.config_value />
						<cfset fieldNotes = rsConfigItems.config_description />
						<cfset Application[rsConfigItems.config_variable] = rsConfigItems.config_value />
						<tr class="#IIF(CurrentRow MOD 2, DE('altRowOdd'), DE('altRowEven'))#">
							<td><a href="ConfigItem.cfm?id=#rsConfigItems.config_id#&configid=#URL.id#">#rsConfigItems.config_name#</a> (#rsConfigItems.config_variable#):</td>
							<td>
							<cfswitch expression="#rsConfigItems.config_type#">
							<cfcase value="boolean">
								<input name="#fieldName#" type="checkbox" class="formCheckbox" value="True"<cfif fieldValue EQ True> checked="checked"</cfif> />
							</cfcase>

							<cfcase value="text">
								<input type="text" name="#fieldName#" value="#HTMLEditFormat(fieldValue)#" size="40" />
							</cfcase>

							<cfcase value="radio">
								<cfset Possibilities = rsConfigItems.config_possibles />
								<cfloop list="#Possibilities#" index="NameValuePair" delimiters="#Chr(13)##Chr(10)#">
									<input name="#fieldName#" type="radio" class="formRadio" value="#ListLast(NameValuePair, "|")#"<cfif ListFind(fieldValue, ListLast(NameValuePair, "|"))> checked="checked"</cfif> />
									#ListFirst(NameValuePair, "|")#<br />
								</cfloop>
							</cfcase>

							<cfcase value="checkbox">
								<cfset Possibilities = rsConfigItems.config_possibles />
								<cfloop list="#Possibilities#" index="NameValuePair" delimiters="#Chr(13)##Chr(10)#">
									<input name="#fieldName#" type="checkbox" class="formCheckbox" value="#ListLast(NameValuePair, "|")#"<cfif ListFind(fieldValue, ListLast(NameValuePair, "|"))> checked="checked"</cfif> />
									#ListFirst(NameValuePair, "|")#<br />
								</cfloop>
							</cfcase>

							<cfcase value="textarea">
								<textarea name="#fieldName#" cols="40" rows="5">#fieldValue#</textarea>
							</cfcase>

							<cfcase value="select,multiselect">
								<cfset Possibilities = rsConfigItems.config_possibles />
								<select name="#fieldName#"<cfif rsConfigItems.config_type EQ "multiselect"> multiple="multiple" size="6"</cfif>>
									<cfloop list="#Possibilities#" index="NameValuePair" delimiters="#Chr(13)##Chr(10)#">
										<option value="#ListLast(NameValuePair, "|")#"<cfif ListFind(fieldValue, ListLast(NameValuePair, "|"))> selected="selected"</cfif>>#ListFirst(NameValuePair,"|")#</option>
									</cfloop>
								</select>
							</cfcase>

							<cfdefaultcase>
								No valid data type specified in tbl_config.
							</cfdefaultcase>
						</cfswitch>
						<div id="divOptionHelp#rsConfigItems.config_id#" style="display: none;">#fieldNotes#<br />
						<strong>Reference</strong>: Application.#rsConfigItems.config_variable#</div></td>
							<td>
								<cfif fieldNotes NEQ "">
									<a href="javascript:dwfaq_ToggleOMaticDisplay(this,'divOptionHelp#rsConfigItems.config_id#');">
									<img src="assets/images/cwContextHelp.gif" alt="Get help on this option" width="16" height="16" /></a>
								</cfif>
								<input type="hidden" name="ConfigItem#CurrentRow#" value="#rsConfigItems.config_id#" />
								<input type="hidden" name="ConfigVariable#CurrentRow#" value="#rsConfigItems.config_variable#" />
							</td>
						</tr>
					</cfoutput>
				</table>
				<input type="submit" class="formButton" value="Update Configuration">
				<input type="hidden" name="action" value="UpdateConfigItems" />
				<input type="hidden" name="ConfigCount" value="<cfoutput>#rsConfigItems.RecordCount#</cfoutput>" />
			</cfform>
		</cfif>
		<cfif rsConfigGroup.configgroup_protected>
			<p>This configuration group cannot be deleted.</p>
		<cfelse>
			<form action="<cfoutput>#Request.ThisPageQS#</cfoutput>" method="post" name="frmDelete" id="frmDelete">
				<div style="text-align: right;">
					<input name="action" type="submit" class="formButton" id="action" onClick="tmt_confirm('Are%20you%20sure%20you%20want%20to%20delete%20this%20configuration%20group?%0D%0A%0D%0AAny%20application%20code%20that%20depends%20on%20values%20in%20this%20group%20will%20no%20longer%20function%20correctly.%0D%0A%0D%0AClick%20OKto%20delete%20this%20group%20and%20all%20items%20within%20the%20group.');return document.MM_returnValue" value="Delete Group">
				</div>
			</form>
		</cfif>
	</cfif>
</div>
</body>
</html>
