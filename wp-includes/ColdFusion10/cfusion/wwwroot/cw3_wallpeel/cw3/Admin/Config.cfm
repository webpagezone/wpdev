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
<!--- Set location for highlighting in Nav Menu --->
<cfset strSelectNav = "Settings">

<cfparam name="URL.id" default="0" type="numeric" />

<!--- Check for current action --->
<cfif IsDefined("FORM.fieldnames")>
	<cfloop from="1" to="#FORM.ConfigCount#" index="i">
		<!--- Update the config item --->
		<cfparam name="FORM.ConfigValue#i#" default="False" />
		<cfquery datasource="#request.dsn#" username="#request.dsnusername#" password="#request.dsnpassword#">
		UPDATE tbl_config SET config_value = <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM["ConfigValue#i#"]#" />
		WHERE config_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#FORM["ConfigItem#i#"]#" />
		</cfquery>
		<cfset Application[FORM["ConfigVariable#i#"]] = FORM["ConfigValue#i#"] />
	</cfloop>
	<cflocation url="#Request.ThisPageQS#" addtoken="no" />
</cfif>

<!--- Get Records --->
<cfquery name="rsConfigGroup" datasource="#request.dsn#" username="#request.dsnusername#" password="#request.dsnpassword#">
SELECT * FROM tbl_configgroup 
WHERE configgroup_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#URL.id#" />
</cfquery>

<cfquery name="rsConfigItems" datasource="#request.dsn#" username="#request.dsnusername#" password="#request.dsnpassword#">
SELECT * FROM tbl_config
WHERE config_groupid = <cfqueryparam cfsqltype="cf_sql_integer" value="#URL.id#" />
<cfif Not IsDefined('Session.AccessLevel') OR Session.AccessLevel NEQ 'superadmin'>
AND config_showmerchant = 1
</cfif>
ORDER BY config_sort
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
//-->
</script>
</head>
<body> 
<!--- Include Admin Navigation Menu---> 
<cfinclude template="CWIncNav.cfm">
<div id="divMainContent">
	<h1> Configuration Group - <cfoutput>#rsConfigGroup.configgroup_name#</cfoutput> </h1>
	<cfif rsConfigGroup.RecordCount EQ 0>
		<p>Invalid configuration group id.</p>
		<cfelse>
		<cfif rsConfigItems.RecordCount EQ 0>
			<p>There are no configuration items in this group.</p>
			<cfelse>
			<br />
			<cfform name="UpdateItems" action="#Request.ThisPageQS#" method="post">
				<table>
					<caption>
					Configuration Items
					</caption>
					<cfoutput query="rsConfigItems">
						<cfset fieldName = "ConfigValue" & CurrentRow />
						<cfset fieldValue = rsConfigItems.config_value />
						<cfset fieldNotes = rsConfigItems.config_description />
						<cfset Application[rsConfigItems.config_variable] = rsConfigItems.config_value />
						<tr class="#IIF(CurrentRow MOD 2, DE('altRowOdd'), DE('altRowEven'))#">
							<th align="right">#rsConfigItems.config_name#:</th>
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
									<input type="radio" name="#fieldName#" class="formRadio" value="#ListLast(NameValuePair, "|")#"<cfif ListFind(fieldValue, ListLast(NameValuePair, "|"))> checked="checked"</cfif> />
									#ListFirst(NameValuePair, "|")#<br />
								</cfloop>
							</cfcase>

							<cfcase value="checkboxgroup">
								<cfset Possibilities = rsConfigItems.config_possibles />
								<cfloop list="#Possibilities#" index="NameValuePair" delimiters="#Chr(13)##Chr(10)#">
									<input type="checkbox" name="#fieldName#" class="formCheckbox" value="#ListLast(NameValuePair, "|")#"<cfif ListFind(fieldValue, ListLast(NameValuePair, "|"))> checked="checked"</cfif> />
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
									<input name="id#CurrentRow#" type="hidden" value="#rsConfigItems.config_id#" />
									<img src="assets/images/cwContextHelp.gif" alt="Get help on this option" width="16" height="16" /></a>
								</cfif>
								<input type="hidden" name="ConfigItem#CurrentRow#" value="#rsConfigItems.config_id#" />
								<input type="hidden" name="ConfigVariable#CurrentRow#" value="#rsConfigItems.config_variable#" />							</td>
							</td>
						</tr>
					</cfoutput>
				</table>
				<input type="submit" class="formButton" value="Update Configuration">
				<input type="hidden" name="action" value="UpdateConfigItems" />
				<input type="hidden" name="ConfigCount" value="<cfoutput>#rsConfigItems.RecordCount#</cfoutput>" />
			</cfform>
		</cfif>
	</cfif>
</div>
</body>
</html>
