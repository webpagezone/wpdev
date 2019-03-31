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
Name: AdminHome.cfm
Description: Admin home page and dispalys basics sales reports.
================================================================
--->
<cfquery name="rsNewOrders" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
SELECT tbl_orders.order_Date, tbl_orders.order_ID, tbl_orders.order_Total FROM
tbl_orders WHERE tbl_orders.order_Date BETWEEN #Session.LastLogin# AND #CreateODBCDateTime(Now())#
ORDER BY tbl_orders.order_Date
</cfquery>
<cfquery name="rsToVerify" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
SELECT tbl_orders.order_Date, tbl_orders.order_ID, tbl_orders.order_Total FROM
tbl_orders
WHERE tbl_orders.order_Status = 1
ORDER BY tbl_orders.order_Date
</cfquery>

<cfquery name="rsToShip" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
SELECT tbl_orders.order_ID, tbl_orders.order_Date, tbl_orders.order_Total, tbl_shipmethod.shipmeth_Name
FROM tbl_shipmethod INNER JOIN tbl_orders ON tbl_shipmethod.shipmeth_ID = tbl_orders.order_ShipMeth_ID
WHERE tbl_orders.order_Status = 2
ORDER BY tbl_orders.order_Date
</cfquery>
</cfsilent>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>CW Admin: Home</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="assets/admin.css" rel="stylesheet" type="text/css">
</head>
<body> 
<!--- Include Admin Navigation Menu--->
<cfinclude template="CWIncNav.cfm"> 

<div id="divMainContent"> 
	<h1>Admin Home</h1>
	<h2>Order Status</h2> 
	<h3>New Orders</h3> 
	<p> 
		<cfif rsNeworders.Recordcount EQ 0>
 			No new orders
			<cfelse> 
			<cfoutput>#rsNeworders.Recordcount#</cfoutput> new
			<cfif rsNeworders.Recordcount GT 1>
 				orders
				<cfelse> 
				order
			</cfif> 
		</cfif> 
		since <cfoutput>#LSDateFormat(Session.LastLogin,'DD MMMM YYYY')#, #LSTimeFormat(Session.LastLogin,'hh:mm:ss tt')#</cfoutput></p> 
	<cfif rsNeworders.Recordcount GT 0> 
		<table> 
			<col /> 
			<col style="text-align: right;" /> 
			<col style="text-align: center;" /> 
			<tr> 
				<th>Order Date</th> 
				<th>Total</th> 
				<th>View</th> 
			</tr> 
			<cfoutput query="rsNewOrders"> 
				<tr class="#IIF(CurrentRow MOD 2, DE('altRowEven'), DE('altRowOdd'))#"> 
					<td>#LSDateFormat(rsNewOrders.order_Date,'DD MMMM YYYY')#, #LSTimeFormat(rsNewOrders.order_Date,'hh:mm:ss tt')#</td> 
					<td>#LSCurrencyFormat(rsNewOrders.order_Total)#</td> 
					<td><a href="OrderDetails.cfm?order_ID=#rsNewOrders.order_ID#"><img src="assets/images/viewdetails.gif" alt="View Order" width="15" height="15" border="0"></a></td> 
				</tr> 
			</cfoutput> 
		</table> 
	</cfif> 
	<h3>Unverified Orders</h3>
	<p><cfoutput>#rsToVerify.Recordcount#</cfoutput>  
		<cfif rsToVerify.Recordcount GT 1 OR rsToVerify.Recordcount EQ 0>
 			orders
			<cfelse>
			order
		</cfif> 
		to verify </p> 
	<cfif rsToVerify.Recordcount GT 0> 
		<table> 
			<col /> 
			<col style="text-align: right;" /> 
			<col style="text-align: center;" /> 
			<tr> 
				<th>Order Date</th> 
				<th>Total</th> 
				<th>View</th> 
			</tr> 
			<cfoutput query="rsToVerify"> 
				<tr class="#IIF(CurrentRow MOD 2, DE('altRowEven'), DE('altRowOdd'))#"> 
					<td>#LSDateFormat(rsToVerify.order_Date,'DD MMMM YYYY')#, #LSTimeFormat(rsToVerify.order_Date,'hh:mm:ss	tt')#</td> 
					<td>#LSCurrencyFormat(rsToVerify.order_Total)#</td> 
					<td><a href="OrderDetails.cfm?order_ID=#rsToVerify.order_ID#"><img src="assets/images/viewdetails.gif" alt="View Order" width="15" height="15" border="0"></a></td> 
				</tr> 
			</cfoutput> 
		</table> 
	</cfif> 
	<h3>Orders to ship</h3>
	<p><cfoutput>#rsToShip.Recordcount#</cfoutput> 
		<cfif rsToShip.Recordcount GT 1 OR rsToShip.Recordcount EQ 0>
 			orders
			<cfelse>
			order
		</cfif> 
		to ship </p> 
	<cfif rsToShip.Recordcount GT 0> 
		<table> 
			<col /> 
			<col style="text-align: right;" /> 
			<col />
			<col style="text-align: center;" /> 
			<tr> 
				<th>Order Date</th>
				<th>Total</th> 
				<th>Ship Method</th>
				<th>View</th> 
			</tr> 
			<cfoutput query="rsToShip"> 
				<tr class="#IIF(CurrentRow MOD 2, DE('altRowEven'), DE('altRowOdd'))#"> 
					<td>#LSDateFormat(rsToShip.order_Date,'DD MMMM YYYY')#, #LSTimeFormat(rsToShip.order_Date,'hh:mm:ss	tt')#</td> 
					<td>#LSCurrencyFormat(rsToShip.order_Total)#</td> 
					<td>#rsToShip.shipmeth_Name#</td>
					<td><a href="OrderDetails.cfm?order_ID=#rsToShip.order_ID#"><img src="assets/images/viewdetails.gif" alt="View Order" width="15" height="15" border="0"></a></td> 
				</tr> 
			</cfoutput> 
		</table> 
	</cfif>
</div>
</body>
</html>
