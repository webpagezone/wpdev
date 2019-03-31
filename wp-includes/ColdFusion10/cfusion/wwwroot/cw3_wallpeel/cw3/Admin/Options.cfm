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
Name: Options.cfm
Description: Control the options available for product SKUs
================================================================
--->

<!--- Set location for highlighting in Nav Menu --->
<cfset strSelectNav = "Options">

<!--- Set Local Variable for currently selected option --->
<cfparam name="URL.optionID" default="0">
<cfparam name="ThisOption" default="#URL.optionID#">

<!--- Set Page Archive Status --->
<cfparam  name="URL.OptionView" default="0">

<!--- Set default Action value --->
<cfparam name="FORM.action" default="">

<!--- Delete this entire option group--->
<cfif IsDefined("URL.DeleteOption")>
	<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
	DELETE FROM tbl_list_optiontypes 
	WHERE optiontype_ID=#URL.DeleteOption#
	</cfquery>
	<cflock timeout="5" throwontimeout="no" type="exclusive" scope="Application">
		<cfset StructDelete(Application, "OptionsMenu") >
	</cflock>
	<cflocation url="#Request.ThisPage#" addtoken="no">
</cfif>

<!--- Insert a new option type --->
<cfif FORM.action EQ "AddOption">
	<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
	INSERT INTO tbl_list_optiontypes 
	(optiontype_Name, optiontype_Required, optiontype_Archive) 
	VALUES 
	('#FORM.option_name#', 1, 0)
	</cfquery>
	<cflock timeout="5" throwontimeout="no" type="exclusive" scope="Application">
		<cfset StructDelete(Application, "OptionsMenu") >
	</cflock>
	<cflocation url="#Request.ThisPage#" addtoken="no">
</cfif>

<!--- ADD Record --->
<cfif FORM.action EQ "AddRecord">
	<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
	INSERT INTO tbl_skuoptions 
	(option_Type_ID, option_Name, option_Sort, option_Archive) 
	VALUES
	('#FORM.option_Type_ID#','#FORM.option_Name#',#FORM.option_Sort#, 0)
	</cfquery>
	<cflocation url="#Request.ThisPageQS#" addtoken="no">
</cfif>

<!--- Perform Update Action --->
<cfif FORM.action EQ "UpdateOptions">
	<cfparam name="FORM.deleteOption" default="">
	<!--- Loop through all options --->
	<cfloop from="1" to="#FORM.OptionCounter#" index="id">
		<cfif ListFind(FORM.deleteOption,Evaluate("FORM.option_ID#id#"))>
			<!--- Delete Record --->
			<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
			DELETE FROM tbl_skuoptions 
			WHERE option_ID IN (#FORM.deleteOption#)
			</cfquery>

			<cfelse>
			<!--- Update Record --->
			<cfparam name="FORM.archiveOption#ID#" default="#URL.OptionView#">
			<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
			UPDATE tbl_skuoptions 
			SET option_Sort = #FORM["option_Sort#id#"]#, 
			option_Name = '#FORM["option_Name#id#"]#', 
			option_Archive = #FORM["archiveOption#id#"]#
			WHERE option_ID = #FORM["option_ID#id#"]#
			</cfquery>
		</cfif>
	</cfloop>
	<cflocation url="#Request.ThisPageQS#" addtoken="no">
</cfif>

<!--- Get Record --->
<cfif ThisOption NEQ 0>
	<cfquery name="rsGetOptions" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
	SELECT so.option_Name, 
	optiontype_Name, option_ID, option_Sort
	FROM tbl_list_optiontypes ot
	INNER JOIN tbl_skuoptions so
	ON ot.optiontype_ID = so.option_Type_ID 
	WHERE ot.optiontype_ID = #ThisOption#
	AND so.option_Archive = #URL.OptionView# 
	ORDER BY so.option_Sort
	</cfquery>
	<cfif rsGetOptions.RecordCount EQ 0>
		<!--- Get Option Name if there are no records from rsGetOptions --->
		<cfquery name="rsOptionName" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
		SELECT optiontype_Name 
		FROM tbl_list_optiontypes 
		WHERE optiontype_ID = #ThisOption#
		</cfquery>
		<cfset ThisOptionName = rsOptionName.optiontype_Name>

		<!--- Check to see if there are archived options to hide Delete Option if necessary --->
		<cfquery name="rsArchivedOptions" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
		SELECT option_ID 
		FROM tbl_skuoptions 
		WHERE option_type_ID = #ThisOption# AND option_Archive = 1
		</cfquery>
		<cfelse>
		<cfset ThisOptionName = rsGetOptions.optiontype_Name>
	</cfif>
	<cfelse>
	<cfset ThisOptionName = "Add New Option Group">
</cfif>
</cfsilent>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>CW Admin:<cfoutput>#ThisOptionName#</cfoutput></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="assets/admin.css" rel="stylesheet" type="text/css">
</head>
<body> 
<!--- Include Admin Navigation Menu---> 
<cfinclude template="CWIncNav.cfm"> 
<div id="divMainContent"> 
	<cfif ThisOption NEQ 0> 
		<h1>Option Group: <cfoutput>#ThisOptionName#</cfoutput></h1> 
		<p> 
			<cfif URL.OptionView EQ "0"> 
				<a href="<cfoutput>#request.ThisPage#</cfoutput>?OptionView=1&optionID=<cfoutput>#ThisOption#</cfoutput>">View
				Archived</a> 
				<cfelse> 
				<a href="<cfoutput>#request.ThisPage#</cfoutput>?OptionView=0&optionID=<cfoutput>#ThisOption#</cfoutput>">View
				Active</a> 
			</cfif> 
		</p> 
		<cfif URL.OptionView EQ 0>
			<cfform name="Add" method="POST" action="#Request.ThisPageQS#">
				<table>
					<caption>
					Add <cfoutput>#ThisOptionName#</cfoutput>
					</caption>
					<tr align="center">
						<th><cfoutput>#ThisOptionName#</cfoutput> </th>
						<th>Sort</th>
						<th>Add</th>
					</tr>
					<tr align="center">
						<td><cfinput name="option_Name" required="yes" message="Name Required" type="text">
						</td>
						<td><cfinput name="option_Sort" type="text" size="5" required="yes" validate="integer" message="Sort Required - Must be Numeric Value">
							<input name="option_Type_ID" type="hidden" id="option_Type_ID" value="<cfoutput>#ThisOption#</cfoutput>">
						</td>
						<td><input name="AddRecord" type="submit" class="formButton" value="Add">
						</td>
					</tr>
				</table>
				<input name="action" type="hidden" value="AddRecord">
			</cfform>
		</cfif>
		<!--- Show table only if we have options ---> 
		<cfif #rsGetOptions.RecordCount# NEQ 0> 
			<cfform action="#request.ThisPageQS#" method="POST" name="Update"> 
				<table> 
					<caption>
 					Current Option Values
					</caption> 
					<tr align="center"> 
						<th><cfoutput>#ThisOptionName#</cfoutput> </th> 
						<th>Sort</th> 
						<th>Delete</th> 
						<th> <cfif URL.OptionView EQ "0">
 								Archive
								<cfelse> 
								Activate
							</cfif> </th> 
					</tr> 
					<cfoutput query="rsGetOptions"> 
						<cfsilent> 
						<!--- Check to see if this option is associated with a SKU. ---> 
						<cfquery name="rsCheckSKUOptions" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
 						SELECT Count(optn_rel_sku_id) as AreThereSkus 
						FROM tbl_skuoption_rel
 						WHERE optn_rel_Option_ID = #rsGetOptions.option_ID# 
						</cfquery> 
						<!--- Check to see if this option is associated with an active product. ---> 
						<cfquery name="rsCheckProductOptions" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
 						SELECT Count(optn_rel_sku_id) AS AreThereOptions 
						FROM tbl_products p
 						INNER JOIN (tbl_skus s
						INNER JOIN tbl_skuoption_rel sr
						ON s.SKU_ID = sr.optn_rel_SKU_ID) 
						ON p.product_ID = s.SKU_ProductID
 						WHERE sr.optn_rel_Option_ID = #rsGetOptions.option_ID# 
						AND	p.product_Archive = 0
						</cfquery> 
						</cfsilent> 
						<tr class="#IIF(CurrentRow MOD 2, DE('altRowEven'), DE('altRowOdd'))#"> 
							<td>#CurrentRow#. <cfinput name="option_Name#CurrentRow#" required="yes" message="Name required for option #CurrentRow# - Please insert a value" type="text" value="#rsGetOptions.option_Name#" size="25"> 
								<input name="option_ID#CurrentRow#" type="hidden" id="option_ID" value="#rsGetOptions.option_ID#"> 
								<input name="option_Type_ID#CurrentRow#" type="hidden" id="option_Type_ID" value="#ThisOption#"> </td> 
							<td> <cfinput name="option_Sort#CurrentRow#" required="yes" validate="integer" message="Sort required for option #CurrentRow#- Must be Numeric Value" type="text" id="option_Sort" value="#rsGetOptions.option_Sort#" size="3"> </td> 
							<td align="center"> <input type="checkbox" name="deleteOption" class="formCheckbox" value="#option_ID#"<cfif rsCheckSKUOptions.AreThereSkus NEQ 0> disabled</cfif>> </td> 
							<td align="center"> <input type="checkbox" class="formCheckbox" name="archiveOption#CurrentRow#" value="<cfif URL.OptionView EQ 0>1<cfelse>0</cfif>"<cfif rsCheckProductOptions.AreThereOptions NEQ 0> disabled</cfif>> </td> 
						</tr> 
					</cfoutput> 
				</table> 
				<input type="hidden" name="optionCounter" value="<cfoutput>#rsGetOptions.RecordCount#</cfoutput>"> 
				<input type="submit" name="UpdateOptions" value="Update Options" class="formButton"> 
				<input type="hidden" name="action" value="UpdateOptions">
			</cfform> 
			<cfelse> 
			<cfif URL.OptionView EQ 0>
				<cfif rsArchivedOptions.RecordCount EQ 0>
					<p>There are currently no options available.<br /> 
						Would you like to [<a href="<cfoutput>#request.ThisPage#</cfoutput>?DeleteOption=<cfoutput>#ThisOption#</cfoutput>">DELETE OPTION</a>]</p> 
					<cfelse>
					<p>Delete all active and archived options to delete this option group.</p>
				</cfif>
				<cfelse>
				<p>There are currently no archived options.</p>
			</cfif>
		</cfif> 
		<cfelse> 
		<h1>Add New Option Group</h1> 
		<form action="Options.cfm" method="post" name="frmAddOptions" id="frmAddOptions"> 
			<p> 
				<label>Option Name:
				<input name="option_name" type="text" id="option_name"> 
				<input name="AddOption" type="submit" class="formButton" id="AddOption" value="Add Option"> 
				</label> 
			</p> 
			<input type="hidden" name="action" value="AddOption">
		</form> 
	</cfif> 
</div> 
</body>
</html>
