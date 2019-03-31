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
Name: ListCreditCard.cfm
Description: list available Credit Card choices
================================================================
--->
<!--- Set location for highlighting in Nav Menu --->
<cfset strSelectNav = "Settings">

<!--- ADD Record --->
<cfif IsDefined("FORM.AddRecord")>
	<cfquery name="rsCCardList" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
	SELECT * FROM tbl_list_ccards WHERE ccard_Code ='#FORM.ccard_Code#' ORDER	BY ccard_Name
	</cfquery>
	<cfif rsCCardList.RecordCount EQ 0>
		<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
		INSERT INTO tbl_list_ccards (ccard_Name, ccard_Code) VALUES ('#FORM.ccard_Name#',
		'#FORM.ccard_Code#')
		</cfquery>
		<cflocation url="#request.ThisPage#" addtoken="no">
		<cfelse>
		<cfset adderror="Card Code *" & #FORM.ccard_Code# & "* already exists in the database.">
	</cfif>
</cfif>
<!--- END IF IsDefined("FORM.AddRecord") --->

<!--- DELETE Record --->
<cfif IsDefined("URL.DeleteRecord")>
	<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
	DELETE FROM tbl_list_ccards WHERE ccard_ID=#URL.DeleteRecord#
	</cfquery>
	<cflocation url="#request.ThisPage#" addtoken="no">
</cfif>

<!--- Update Record --->
<cfif IsDefined("FORM.UpdateCards")>
	<cfloop from="1" to="#FORM.cardCounter#" index="id">
		<cfparam name="FORM.deleteCard" default="">
		<cfif ListFind(FORM.deleteCard,Evaluate("FORM.ccard_ID#ID#"))>
			<!--- Delete record --->
			<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
			DELETE FROM tbl_list_ccards WHERE ccard_ID = #Evaluate("FORM.ccard_ID#ID#")#
			</cfquery>
			
			<cfelse>
			<!--- Update record --->
			<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
			UPDATE tbl_list_ccards SET 
			ccard_Code = '#Evaluate("FORM.ccard_Code#id#")#', 
			ccard_Name = '#Evaluate("FORM.ccard_Name#id#")#'
			WHERE ccard_ID = #Evaluate("FORM.ccard_ID#id#")#
			</cfquery>
		</cfif>
	</cfloop>
	<cflocation url="#request.ThisPage#" addtoken="no">
</cfif>

<!--- Get Records --->
<cfquery name="rsCCardList" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
SELECT * FROM tbl_list_ccards ORDER BY ccard_Name
</cfquery>
</cfsilent>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>CW Admin: Credit Cards</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="assets/admin.css" rel="stylesheet" type="text/css">
</head>
<body> 
<!--- Include Admin Navigation Menu---> 
<cfinclude template="CWIncNav.cfm"> 
<div id="divMainContent"> 
	<h1>Credit Cards</h1> 
	<cfform name="Add" method="POST" action="#request.ThisPage#"> 
		<cfif IsDefined('adderror')> 
			<cfoutput>#adderror#</cfoutput> 
		</cfif> 
		<table> 
			<caption>
 			Add Credit Card
			</caption> 
			<tr align="center"> 
				<th>Card Name</th> 
				<th>Card Code</th> 
				<th>Add</th> 
			</tr> 
			<tr align="center" class="altRowEven"> 
				<td><cfinput name="ccard_Name" type="text" required="yes" message="Card Name Required" size="15"> </td> 
				<td><cfinput name="ccard_Code" type="text" required="yes" message="Card Code Required" size="8"> </td> 
				<td> <input name="AddRecord" type="submit" class="formButton" id="AddRecord" value="Add"> </td> 
			</tr> 
		</table> 
	</cfform> 
	<cfform action="#request.ThisPage#" method="POST" name="Update"> 
		<table> 
			<caption>
 			Currently Accepted Credit Cards
			</caption> 
			<tr> 
				<th align="center">Card Name</th> 
				<th align="center">Card Code</th> 
				<th align="center">Delete</th> 
			</tr> 
			<cfset CurrentRow = 0> 
			<cfoutput query="rsCCardList"> 
				<tr class="#IIF(CurrentRow MOD 2, DE('altRowEven'), DE('altRowOdd'))#"> 
					<td>#CurrentRow#.
						<input name="ccard_ID#CurrentRow#" type="hidden"value="#rsCCardList.ccard_ID#"> 
						<cfinput name="ccard_Name#CurrentRow#" type="text" size="15" required="yes" message="Card Name is required for card #CurrentRow#" value="#ccard_Name#"></td> 
					<td><cfinput name="ccard_Code#CurrentRow#" size="8" type="text" required="yes" message="Card Code is required for card #CurrentRow#" value="#rsCCardList.ccard_Code#"></td> 
					<td align="center"><input type="checkbox" class="formCheckbox" name="deleteCard" value="#ccard_ID#"></td> 
				</tr> 
			</cfoutput> 
		</table> 
		<input type="hidden" name="cardCounter" value="<cfoutput>#rsCCardList.RecordCount#</cfoutput>"> 
		<input type="submit" class="formButton" name="UpdateCards" value="Update Cards"> 
	</cfform> 
</div> 
</body>
</html>
