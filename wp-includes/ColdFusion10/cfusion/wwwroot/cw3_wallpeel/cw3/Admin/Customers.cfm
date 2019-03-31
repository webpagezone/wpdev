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
Name: Customers.cfm
Description: Searches for and lists customer records
================================================================
--->
<!--- Set location for highlighting in Nav Menu --->
<cfset strSelectNav = "Customers">
<cfparam name="URL.Alpha" default="xxx">
<cfparam name="URL.Email" default="">
<cfparam name="URL.Order" default="">
<cfparam name="URL.Zip" default="">
<!--- If the Search button was clicked, the form has been submitted --->
  <cfquery name="rsGetCustomer" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
		SELECT tbl_customers.*, tbl_stateprov.stprv_Name, tbl_custstate.CustSt_Destination
		FROM tbl_stateprov 
			INNER JOIN (tbl_customers 
				INNER JOIN tbl_custstate 
				ON tbl_customers.cst_ID = tbl_custstate.CustSt_Cust_ID) 
			ON tbl_stateprov.stprv_ID = tbl_custstate.CustSt_StPrv_ID
		WHERE tbl_custstate.CustSt_Destination='BillTo'
  <!--- We'll always have an option selected in the Alpha list, so start the WHERE clasue --->
  AND cst_LastName LIKE '#URL.Alpha#%'
  <!--- Add to the WHERE clause if we have a Zip --->
  <cfif URL.Zip NEQ "">
    AND cst_Zip LIKE '#URL.Zip#%'
  </cfif>
  <!--- Add to the WHERE clause if we have an email --->
  <cfif url.email NEQ "">
	AND cst_email LIKE '%#URL.email#%'
  </cfif>
  <!--- Add to the WHERE clause if we have an Order number --->
  <cfif URL.Order NEQ "" AND IsNumeric(URL.Order) IS "TRUE">
    AND cst_ID IN (SELECT order_CustomerID FROM tbl_orders WHERE order_ID = '#URL.Order#')
  </cfif>
	ORDER BY cst_LastName, cst_FirstName
  </cfquery>
</cfsilent>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>CW Admin: Customer List</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="assets/admin.css" rel="stylesheet" type="text/css">
</head>
<body>
<!--- Include Admin Navigation Menu--->
<cfinclude template="CWIncNav.cfm">
<div id="divMainContent">
	<form name="CustSearch" action="<cfoutput>#request.ThisPage#</cfoutput>" method="get">
	    <table class="noBorders">
			<tr>
			<td><label for="Alpha">Last Name:</label></td>
			<td><!--- Create the alphabet array so that we can show the item selected after the form is submitted. --->
		<cfset theAlphabet="A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z">
		<select name="Alpha" id="Alpha">
			<option value="%" <cfif URL.Alpha EQ "xxx"> selected="selected"</cfif>>--</option>
			<option value="" <cfif URL.Alpha EQ ""> selected="selected"</cfif>>ALL</option>
			<cfloop list="#theAlphabet#" index="i">
				<cfoutput>
					<option value="#i#"<cfif URL.Alpha EQ i> selected="selected"</cfif>>#i#</option>
				</cfoutput>
			</cfloop>
		</select></td>
			  <td><label for="Zip">Zip Code:</label></td>
			  <td><input name="Zip" type="text" id="Zip" size="8" value="<cfoutput>#URL.Zip#</cfoutput>"></td>
			  <td><label for="Order">Order#:</label></td>
			  <td><input name="Order" type="text" id="Order" size="12"  value="<cfoutput>#URL.Order#</cfoutput>"><br/></td>
			</tr>
			<tr>
			<td> <label for="Email">Email Address:</label></td>
			<td colspan="4"><input type="text" name="Email" id="Email" size="30" value="<cfoutput>#URL.Email#</cfoutput>"></td>
			<td><input name="theSearch" type="submit" class="formButton" value="Search"></td>
			</tr>
		</table>
	</form>
	<h1>Customer List</h1>
	<cfif rsGetCustomer.RecordCount NEQ "0">
		<table>
			<tr>
				<th>Name</th>
				<th>Address</th>
				<th>E-mail</th>
				<th>Phone</th>
			</tr>
			<cfoutput query="rsGetCustomer">
				<tr class="#IIF(CurrentRow MOD 2, DE('altRowEven'), DE('altRowOdd'))#">
					<td><a href="CustomerDetails.cfm?cst_ID=#rsGetCustomer.cst_ID#">#rsGetCustomer.cst_LastName#, #rsGetCustomer.cst_FirstName#</a></td>
					<td>#rsGetCustomer.cst_City#,<br />#rsGetCustomer.stprv_Name# #rsGetCustomer.cst_Zip#</td>
					<td><a href="Mailto:#rsGetCustomer.cst_Email#">#rsGetCustomer.cst_Email#</a></td>
					<td nowrap="nowrap">#rsGetCustomer.cst_Phone#</td>
				</tr>
			</cfoutput>
		</table>
		<cfelse>
		<p><strong>No Matching Records Found.</strong></p>
	</cfif>
</div>
</body>
</html>