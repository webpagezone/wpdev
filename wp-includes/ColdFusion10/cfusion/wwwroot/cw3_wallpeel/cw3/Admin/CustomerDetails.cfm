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
Name: CustomerDetails.cfm
Description: Administers individual customer data
================================================================
--->
<!--- Set location for highlighting in Nav Menu --->
<cfset strSelectNav = "Customers">

<!--- If form has been submitted, Update or Delete Customer --->
<cfif IsDefined ('FORM.Update')>
	<cfif isdefined("form.fieldnames")>
		<cfloop list=#form.fieldnames# index="i">
			<cfset form[i] = request.makeHtmlSafe(form[i])>
		</cfloop>
	</cfif>
	<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
	UPDATE tbl_customers SET 
	cst_FirstName = '#FORM.cst_FirstName#'
	, cst_LastName = '#FORM.cst_LastName#'
	, cst_Email=
	<cfif IsDefined("FORM.cst_Email") AND #FORM.cst_Email# NEQ "">
		'#FORM.cst_Email#'<cfelse>NULL
	</cfif>
	, cst_Username=
	<cfif IsDefined("FORM.cst_Username") AND #FORM.cst_Username# NEQ "">
		'#FORM.cst_Username#'<cfelse>NULL
	</cfif>
	, cst_Password=
	<cfif IsDefined("FORM.cst_Password") AND #FORM.cst_Password# NEQ "">
		'#FORM.cst_Password#'<cfelse>NULL
	</cfif>
	
	, cst_Address1=
	<cfif IsDefined("FORM.cst_Address1") AND #FORM.cst_Address1# NEQ "">
		'#FORM.cst_Address1#'<cfelse>NULL
	</cfif>
	, cst_Address2=
	<cfif IsDefined("FORM.cst_Address2") AND #FORM.cst_Address2# NEQ "">
		'#FORM.cst_Address2#'<cfelse>NULL
	</cfif>
	, cst_City=
	<cfif IsDefined("FORM.cst_City") AND #FORM.cst_City# NEQ "">
		'#FORM.cst_City#'<cfelse>NULL
	</cfif>
	, cst_Zip=
	<cfif IsDefined("FORM.cst_Zip") AND #FORM.cst_Zip# NEQ "">
		'#FORM.cst_Zip#'<cfelse>NULL
	</cfif>
	, cst_ShpAddress1=
	<cfif IsDefined("FORM.cst_ShpAddress1") AND #FORM.cst_ShpAddress1# NEQ "">
		'#FORM.cst_ShpAddress1#'<cfelse>NULL
	</cfif>
	, cst_ShpAddress2=
	<cfif IsDefined("FORM.cst_ShpAddress2") AND #FORM.cst_ShpAddress2# NEQ "">
		'#FORM.cst_ShpAddress2#'<cfelse>NULL
	</cfif>
	, cst_ShpCity=
	<cfif IsDefined("FORM.cst_ShpCity") AND #FORM.cst_ShpCity# NEQ "">
		'#FORM.cst_ShpCity#'<cfelse>NULL
	</cfif>
	, cst_ShpZip=
	<cfif IsDefined("FORM.cst_ShpZip") AND #FORM.cst_ShpZip# NEQ "">
		'#FORM.cst_ShpZip#'<cfelse>NULL
	</cfif>
	, cst_Phone=
	<cfif IsDefined("FORM.cst_Phone") AND #FORM.cst_Phone# NEQ "">
		'#FORM.cst_Phone#'<cfelse>NULL
	</cfif>
	WHERE cst_ID='#URL.cst_ID#'
	</cfquery>
	<!--- Update Billing state --->
	<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
	UPDATE tbl_custstate SET
	CustSt_StPrv_ID = #FORM.cst_BillState#
	WHERE CustSt_Cust_ID = '#URL.cst_ID#' AND CustSt_Destination = 'BillTo'
	</cfquery>
	<!--- Update Shipping State --->
	<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
	UPDATE tbl_custstate SET
	CustSt_StPrv_ID = #FORM.cst_ShipState#
	WHERE CustSt_Cust_ID = '#URL.cst_ID#' AND CustSt_Destination = 'ShipTo'
	</cfquery>
	
	<cfelseif IsDefined ('FORM.Delete')>
	<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
	DELETE FROM tbl_custstate WHERE CustSt_Cust_ID = '#URL.cst_ID#'
	</cfquery>
	<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
	DELETE FROM tbl_customers WHERE cst_ID='#URL.cst_ID#'
	</cfquery>
	
	<cflocation url="Customers.cfm">
</cfif>

<cfparam name="URL.cst_ID" default="0">

<cfquery name="rsGetCustDetails" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
SELECT *
FROM tbl_customers
WHERE cst_ID = '#URL.cst_ID#'
</cfquery>

<cfquery name="rsGetCustOrders" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
SELECT 
	tbl_orders.order_ID, 
	tbl_orders.order_Date, 
	tbl_orders.order_Total, 
	tbl_orderskus.orderSKU_SKU, 
	tbl_skus.SKU_MerchSKUID, 
	tbl_products.product_Name
FROM 
	tbl_products 
	INNER JOIN (tbl_skus 
		INNER JOIN (tbl_orders 
			INNER JOIN tbl_orderskus 
			ON tbl_orders.order_ID = tbl_orderskus.orderSKU_OrderID) 
		ON tbl_skus.SKU_ID = tbl_orderskus.orderSKU_SKU) 
	ON tbl_products.product_ID = tbl_skus.SKU_ProductID
WHERE 
	tbl_orders.order_CustomerID = '#URL.cst_ID#'
ORDER BY 
	tbl_orders.order_Date DESC
</cfquery>

<cfquery name="rsGetBillTo" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
SELECT
	tbl_list_countries.country_Name, 
	tbl_stateprov.stprv_Name, 
	tbl_list_countries.country_ID, 
	tbl_stateprov.stprv_ID
FROM 
	(tbl_list_countries 
	INNER JOIN tbl_stateprov ON tbl_list_countries.country_ID = tbl_stateprov.stprv_Country_ID) 
	INNER JOIN tbl_custstate ON tbl_stateprov.stprv_ID = tbl_custstate.CustSt_StPrv_ID
WHERE 
	tbl_custstate.CustSt_Cust_ID = '#URL.cst_ID#' 
	AND tbl_custstate.CustSt_Destination = 'BillTo'
</cfquery>

<cfquery name="rsGetShipTo" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
SELECT
	tbl_list_countries.country_Name, 
	tbl_stateprov.stprv_Name, 
	tbl_list_countries.country_ID, 
	tbl_stateprov.stprv_ID, 
	tbl_custstate.CustSt_Destination
FROM 
	(tbl_list_countries 
	INNER JOIN tbl_stateprov ON tbl_list_countries.country_ID = tbl_stateprov.stprv_Country_ID) 
	INNER JOIN tbl_custstate ON tbl_stateprov.stprv_ID = tbl_custstate.CustSt_StPrv_ID
WHERE 
	tbl_custstate.CustSt_Cust_ID = '#URL.cst_ID#' 
	AND tbl_custstate.CustSt_Destination = 'ShipTo'
</cfquery>

<cfquery name="rsGetStateList" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
SELECT 
	tbl_list_countries.country_Name, 
	tbl_stateprov.stprv_ID, 
	tbl_stateprov.stprv_Name
FROM tbl_list_countries INNER JOIN tbl_stateprov ON tbl_list_countries.country_ID = tbl_stateprov.stprv_Country_ID
WHERE 
	tbl_stateprov.stprv_Archive = 0 
	AND tbl_list_countries.country_Archive = 0
ORDER BY 
	tbl_list_countries.country_Sort, 
	tbl_stateprov.stprv_Name
</cfquery>

</cfsilent>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>CW Admin: Customer Details</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="assets/admin.css" rel="stylesheet" type="text/css">
</head>
<body>
<!--- Include Admin Navigation Menu--->
<cfinclude template="CWIncNav.cfm">
<div id="divMainContent">
  <h1>Customer Details</h1>
  <form action="<cfoutput>#request.ThisPageQS#</cfoutput>" method="POST" name="editCustomer">
    <table>
      <tr>
        <th align="right">Customer ID:</th>
        <td><cfoutput>#rsGetCustDetails.cst_ID#</cfoutput>
          
        </td>
      </tr>
      <tr>
      	<th align="right">First Name: </th>
      	<td><input name="cst_FirstName" type="text" id="cst_FirstName" value="<cfoutput>#rsGetCustDetails.cst_FirstName#</cfoutput>"></td>
     	</tr>
      <tr>
      	<th align="right">Last Name: </th>
      	<td><input name="cst_LastName" type="text" id="cst_LastName" value="<cfoutput>#rsGetCustDetails.cst_LastName#</cfoutput>"></td>
     	</tr>
      <tr>
        <th align="right">Email:</th>
        <td>
            <input type="text" name="cst_Email" value="<cfoutput>#rsGetCustDetails.cst_Email#</cfoutput>">
        </td>
      </tr>
      <tr>
        <th align="right">Phone:</th>
        <td>
            <input type="text" name="cst_Phone" value="<cfoutput>#rsGetCustDetails.cst_Phone#</cfoutput>">
        </td>
      </tr>
      <tr>
        <th align="right">Username:</th>
        <td><input name="cst_Username" type="text" id="cst_Username" value="<cfoutput>#rsGetCustDetails.cst_Username#</cfoutput>">
        </td>
      </tr>
      <tr>
        <th align="right">Password: </th>
        <td><input type="text" name="cst_Password" value="<cfoutput>#rsGetCustDetails.cst_Password#</cfoutput>">
        </td>
      </tr>
    </table>
    <table>
      <caption>
Billing Information
</caption>
      <tr>
        <th align="right">Address:</th>
        <td valign="top">
            <input type="text" name="cst_Address1" value="<cfoutput>#rsGetCustDetails.cst_Address1#</cfoutput>">
            <br />
            <input type="text" name="cst_Address2" value="<cfoutput>#rsGetCustDetails.cst_Address2#</cfoutput>">
        </td>
      </tr>
      <tr>
        <th align="right">City:</th>
        <td valign="top">
            <input type="text" name="cst_City" value="<cfoutput>#rsGetCustDetails.cst_City#</cfoutput>">
        </td>
      </tr>
      <tr>
        <th align="right">State/Prov:</th>
        <td valign="top">
					<select name="cst_BillState">
        	<cfoutput query="rsGetStateList" group="country_Name">
						<optgroup label="#country_Name#">
        		<cfoutput><option value="#stprv_ID#"<cfif rsGetStateList.stprv_ID EQ rsGetBillTo.stprv_ID> selected="selected"</cfif>>#stprv_Name#</option></cfoutput>
        		</optgroup>
						</cfoutput>
					</select>
        </td>
      </tr>
      <tr>
        <th align="right">Zip:</th>
        <td valign="top">
            <input type="text" name="cst_Zip" value="<cfoutput>#rsGetCustDetails.cst_Zip#</cfoutput>" size="8">
        </td>
      </tr>
      <tr>
        <th align="right">Country:</th>
        <td valign="top"> 
						<cfoutput>#rsGetBillTo.country_Name#</cfoutput>
        </td>
      </tr>
	
    </table>
    <table>
    	<caption>
    	Shipping Information
    	</caption>
    	<tr>
    		<th align="right" scope="row">Name: </th>
    		<td><input name="cstShipName" type="text" id="cstShipName" value="<cfoutput>#rsGetCustDetails.cst_ShpName#</cfoutput>"></td>
   		</tr>
    	<tr>
    		<th align="right" scope="row">Address: </th>
    		<td><input type="text" name="cst_ShpAddress1" value="<cfoutput>#rsGetCustDetails.cst_ShpAddress1#</cfoutput>">
   			<br />
   			<input type="text" name="cst_ShpAddress2" value="<cfoutput>#rsGetCustDetails.cst_ShpAddress2#</cfoutput>"></td>
   		</tr>
    	<tr>
    		<th align="right" scope="row">City: </th>
    		<td><input type="text" name="cst_ShpCity" value="<cfoutput>#rsGetCustDetails.cst_ShpCity#</cfoutput>"></td>
   		</tr>
    	<tr>
    		<th align="right" scope="row">State/Prov: </th>
    		<td><select name="cst_ShipState" id="cst_ShipState">
        	<cfoutput query="rsGetStateList" group="country_Name">
						<optgroup label="#country_Name#">
        		<cfoutput><option value="#stprv_ID#"<cfif rsGetStateList.stprv_ID EQ rsGetShipTo.stprv_ID> selected="selected"</cfif>>#stprv_Name#</option></cfoutput>
        		</optgroup>
						</cfoutput>
        	</select></td>
   		</tr>
    	<tr>
    		<th align="right" scope="row">Zip: </th>
    		<td><input type="text" name="cst_ShpZip" value="<cfoutput>#rsGetCustDetails.cst_ShpZip#</cfoutput>" size="8"></td>
   		</tr>
    	<tr>
    		<th align="right" scope="row">Country: </th>
    		<td><cfoutput>#rsGetShipTo.country_Name#</cfoutput>
        	</td>
   		</tr>
    	</table>
    <p><input name="Update" type="submit" class="formButton" id="Update3" value="Update">
    <cfif rsGetCustOrders.RecordCount EQ 0><!--- If there are no orders hid this section --->
       <input name="Delete" type="submit" class="formButton" id="Delete" value="No Orders - Delete">
    </cfif></p>
</form>

<cfif rsGetCustOrders.RecordCount NEQ 0><!--- If there are no orders hide this section --->
  <h1>Order History</h1>
  <table>
    <tr>
      <th>Order ID</th>
      <th>Order Date</th>
			<th>Products</th>
      <th>Order Total</th>
      <th>View</th>
    </tr>
  <cfsilent>
	<!--- Set variables for control cell row colors --->
	<cfset rowCounter = 0>
  </cfsilent>
<cfoutput query="rsGetCustOrders" group="order_ID">
		<cfset rowCounter = IncrementValue(rowCounter)>
		<tr class="#IIF(rowCounter MOD 2, DE('altRowEven'), DE('altRowOdd'))#">
      <td>#rsGetCustOrders.order_ID#</td>
      <td align="right">#LSDateFormat(rsGetCustOrders.order_Date,'DD MMM YY')#</td>
			<td>
				<cfoutput>
					#product_Name# <span class="smallprint">(#SKU_MerchSKUID#)</span><br />
				</cfoutput>
			</td>
      <td align="right">#LSCurrencyFormat(rsGetCustOrders.order_Total)#</td>
      <td align="center"><a href="OrderDetails.cfm?order_ID=#rsGetCustOrders.order_ID#&amp;returnurl=#URLEncodedFormat(request.ThisPageQS)#">
	  <img src="assets/images/viewdetails.gif" alt="View Order Details" width="15" height="15"></a></td>
    </tr>
</cfoutput>
  </table>
</cfif><!--- END IF - rsGetCustOrders.RecordCount NEQ 0 --->
  
</div>
</body>
</html>
