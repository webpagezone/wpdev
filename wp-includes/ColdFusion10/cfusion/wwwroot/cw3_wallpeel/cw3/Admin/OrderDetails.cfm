<cfsilent>
<!--- 
================================================================
Application Info: Cartweaver© 2002 - 2007, All Rights Reserved.
Developer Info: Application Dynamics Inc.
                1560 NE 10th
                East Wenatchee, WA 98802
Support Info: http://www.cartweaver.com/go/cfhelp
				
Cartweaver Version: 3.0.7  -  Date: 7/8/2007
================================================================
Name: OrderDetails.cfm
Description: Displays and administers status of a selected order.
================================================================
--->

<!--- Set location for highlighting in Nav Menu --->
<cfset strSelectNav = "Orders">
<!--- Set local variable for storing display line item tax and discount preferences --->
<cfparam name="Application.DisplayLineItemTaxes" default="false" />
<cfparam name="Application.DisplayLineItemDiscount" default="false" />
<cfset DisplayLineItemTaxes = Application.DisplayLineItemTaxes />
<cfset DisplayLineItemDiscount = Application.DisplayLineItemDiscount />
<cfset CartColumnCount = 0>
<cfif DisplayLineItemTaxes>
	<cfset CartColumnCount = CartColumnCount + 2>
</cfif>
<cfif DisplayLineItemDiscount>
	<cfset CartColumnCount = CartColumnCount + 1>
</cfif>
<cfparam name="url.Order_ID" default="0">
<!--- If DELETE was submitted, delete this order. --->
<cfif IsDefined ('FORM.Delete')>
<!--- First we delete the Order Skus --->
  <cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
  DELETE FROM tbl_orderskus WHERE orderSKU_OrderID='#FORM.orderID#'
  </cfquery>
<!--- Now we delete the order record itself --->
  <cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
  DELETE FROM tbl_orders WHERE order_ID='#FORM.orderID#'
  </cfquery>
  <cfset returnUrl = "Orders.cfm">
  <cfif isdefined("url.returnurl")>
  	<cfset returnurl = url.returnurl>
  </cfif>
  <cflocation url="#returnurl#" addtoken="No">
</cfif>

<!--- set default FormError variable --->
<cfparam name="FormError" default="NONE">

<!--- If Update Query has been submited, update the record. --->
<cfif IsDefined ('FORM.Update')>
  <cfif FORM.order_Status EQ 3 AND FORM.order_ShipDate EQ "">
      <cfset FormError = "A shipped order must have a Ship Date">
  </cfif>
  
  <cfif FormError EQ "NONE">
  	<cfquery name="rsGetStatus" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
	SELECT o.order_Status, c.cst_Email 
	FROM tbl_orders o
	INNER JOIN tbl_customers c 
	ON c.cst_ID = o.order_CustomerID
	WHERE order_ID = '#FORM.orderID#'
	</cfquery>
    <cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
    UPDATE tbl_orders 
		SET order_Status='#FORM.order_Status#'
			, order_ActualShipCharge = #makeSQLSafeNumber(FORM.order_ActualShipCharge)#
			, order_ShipDate=<cfif FORM.order_ShipDate NEQ "">
			'#LSDateFormat(LSParseDateTime(FORM.order_ShipDate),"yyyy-mm-dd")#'
			<cfelse>
			Null
			</cfif>
			, order_ShipTrackingID='#FORM.order_ShipTrackingID#', 
			order_Notes = '#FORM.order_Notes#'
    WHERE order_ID='#FORM.orderID#'
		</cfquery>
		<cfif FORM.order_Status EQ 3 AND rsGetStatus.order_Status NEQ 3>
			<cfinclude template="../CWTags/CWFunOrderConfirmEmails.cfm">
			<cfset EmailContents = cwBuildConfirmationEmail(FORM.orderID)>
			<cfset cwOrderShippingEmails(EmailContents, rsGetStatus.cst_Email)>
		</cfif>
		
		<!--- Redirect to clear form values --->
		<cflocation url="#request.ThisPageQS#" addtoken="no">
	</cfif>
</cfif><!--- END IF - FormError EQ "none" --->  

<!--- END IF - IsDefined ('FORM.Update') --->

<cfquery name="rsOrder" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
SELECT 
	ss.shipstatus_Name, 
	o.*, 
	c.cst_FirstName, 
	c.cst_LastName, 
	os.orderSKU_SKU, 
	p.product_Name, 
	os.orderSKU_Quantity, 
	os.orderSKU_UnitPrice, 
	os.orderSKU_SKUTotal, 
	sm.shipmeth_Name, 
	s.SKU_ID, 
	s.SKU_MerchSKUID, 
	os.orderSKU_TaxRate,
	os.orderSKU_DiscountID,
	os.orderSKU_DiscountAmount
FROM (
	tbl_products p
	INNER JOIN tbl_skus s
	ON p.product_ID = s.SKU_ProductID) 
	INNER JOIN ((tbl_customers c
		INNER JOIN (tbl_list_shipstatus ss
			RIGHT JOIN (tbl_shipmethod sm
				RIGHT JOIN tbl_orders o 
				ON sm.shipmeth_ID = o.order_ShipMeth_ID) 
			ON ss.shipstatus_id = o.order_Status) 
		ON c.cst_ID = o.order_CustomerID) 
		INNER JOIN tbl_orderskus os
		ON o.order_ID = os.orderSKU_OrderID) 
	ON s.SKU_ID = os.orderSKU_SKU
WHERE o.order_ID = '#URL.Order_ID#'
ORDER BY 
	p.product_Name, 
	s.SKU_Sort
</cfquery>

<cfset discountList = "">
<cfloop query="rsOrder">
	<cfif Val(rsOrder.orderSKU_DiscountID) NEQ 0>
		<cfset discountList = ListAppend(discountList, rsOrder.orderSKU_DiscountID)>
	</cfif>
</cfloop>

<cfif rsOrder.order_DiscountID NEQ "">
	<cfset discountList = ListAppend(discountList, rsOrder.order_DiscountID)>
</cfif>
<cfif discountList NEQ "">
	<cfquery name="rsGetDiscounts" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
	SELECT discount_ID, discount_name, discount_Description 
	FROM tbl_discounts WHERE discount_ID IN (#discountList#)
	</cfquery>
</cfif>
<cfquery name="rsShipStatusList" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
SELECT *
FROM tbl_list_shipstatus
ORDER BY shipstatus_Sort
</cfquery>
</cfsilent>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>CW Admin: Transaction Details</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<!--- Date Pop Up --->
<script language="JavaScript">
<!--

// function to load the calendar window.
function ShowCalendar(FormName, FieldName) {
	var curValue = eval("document."+FormName+"."+FieldName+".value");
	window.open("DatePopup.cfm?getDate="+ curValue + "&FormName=" + FormName + "&FieldName=" + FieldName, "CalendarWindow", "width=250,height=200");
}

//-->
</script>
<link href="assets/admin.css" rel="stylesheet" type="text/css">
<link href="assets/orderprint.css" rel="stylesheet" type="text/css" media="print">
</head>
<body>
<!--- Include Admin Navigation Menu--->
<cfinclude template="CWIncNav.cfm">

<div id="divMainContent">
  <h1>Transaction Details</h1>
<cfif rsOrder.Recordcount NEQ 0>
	<table>
    <tr>
      <th>Order ID</th>
      <th>Date</th>
      <th>Customer ID</th>
    </tr>
    <tr align="center">
      <td><cfoutput>#rsOrder.Order_ID#</cfoutput></td>
      <td><cfoutput>#LSDateFormat(rsOrder.order_Date,'DD MMM YY')#</cfoutput></td>
      <td><a href="CustomerDetails.cfm?cst_ID=<cfoutput>#rsOrder.order_CustomerID#</cfoutput>"><cfoutput>#rsOrder.order_CustomerID#</cfoutput></a></td>
    </tr>
  </table>
  <h2>Ship To</h2>
  <p><cfoutput><strong>#rsOrder.order_ShipName#</strong></cfoutput><br />
    <cfoutput>#rsOrder.order_Address1#</cfoutput>
    <cfif rsOrder.order_Address2 NEQ "">
      <br />
      <cfoutput>#rsOrder.order_Address2#</cfoutput>
    </cfif>
    <br />
    <cfoutput>#rsOrder.order_City#</cfoutput>, <cfoutput>#rsOrder.order_State#</cfoutput> <cfoutput>#rsOrder.order_Zip#</cfoutput><br />
    <cfoutput>#rsOrder.order_Country#</cfoutput>
	<!--- Show Transaction Id captured from the payment gateway. --->
	<cfif request.PaymentAuthType NEQ "NONE">
	<br /><br />
	Gateway Transaction ID: <cfoutput>#rsOrder.order_TransactionID#</cfoutput>
	</cfif>
	</p>
<div id="divOrderShippingInfo">
<cfif FormError NEQ "NONE">
<br />
<cfoutput>
<span class="txt-Error">#FormError#</span>
</cfoutput>
<br />
</cfif>
		<!--- Set default form values for the form --->
		<cfparam name="FORM.order_Status" default="#rsOrder.order_Status#">
		<cfparam name="FORM.order_ShipDate" default="#rsOrder.order_Shipdate#">
		<cfparam name="FORM.order_ShipTrackingID" default="#rsOrder.order_ShipTrackingID#">
		<cfparam name="FORM.order_Notes" default="#rsOrder.order_NOtes#">
    <cfform name="OrderStatus" method="POST" action="#request.ThisPageQS#">
	  <table>
        <caption>
        Order Status 
        </caption>
        <tr>
          <th align="right">
		  Order Status:
		  <input name="orderID" type="hidden" value="<cfoutput>#rsOrder.order_ID#</cfoutput>">
		  </th>
          <td> 
		  
		  <cfif (rsOrder.order_Status NEQ 4) AND (rsOrder.order_Status NEQ 5)>
			   <!--- If order status is NOT cancelled --->
				<select name="order_Status" id="order_Status">
					  <cfif rsOrder.order_Status NEQ 3>
					  <!--- If order status is NOT Shipped --->
					  <cfoutput query="rsShipStatusList">
						<cfif FORM.order_Status EQ rsShipStatusList.shipstatus_id >
						  <option value="#rsShipStatusList.shipstatus_id#" selected="selected">#rsShipStatusList.shipstatus_Name#</option>
						  <cfelse>
						  <option value="#rsShipStatusList.shipstatus_id#">#rsShipStatusList.shipstatus_Name#</option>
						</cfif>
						</cfoutput>
				<cfelse>
				  <!--- If order status IS Shipped --->
					  <option value="3" selected="selected">Shipped</option>
					  <option value="5">Returned</option>
				  </cfif>
				</select>
			<cfelse>
			 <cfif rsOrder.order_Status EQ 4>
			   Order cancelled
			 <cfelseif rsOrder.order_Status EQ 5>
			   Order Returned
			 </cfif>
			</cfif>
</td>
        </tr>
        <tr>
          <th align="right">Shipping Method: </th>
          <td><cfoutput>#rsOrder.shipmeth_Name#</cfoutput></td>
        </tr>
        <tr>
          <th align="right">
            <cfif FormError EQ "None">
              Ship Date:
              <cfelse>
              <span class="txt-formerror">Ship Date Required!</span>
            </cfif>
          </th>
          <td>
				  <cfinput name="order_ShipDate" type="text" size="12" validate="#request.dateValidate#" value="#DateFormat(FORM.order_ShipDate,request.dateMask)#">
          <a href="javascript:ShowCalendar('OrderStatus', 'order_ShipDate')"><img src="assets/images/calendar.gif" alt="Click to Select Date" width="16" height="16"></a>
		  </td>
        </tr>
        <tr>
          <th align="right">Tracking ID: </th>
          <td>
		  <cfif rsOrder.order_Status NEQ 5>
            <input name="order_ShipTrackingID" type="text" id="order_ShipTrackingID" size="25" value="<cfoutput>#order_ShipTrackingID#</cfoutput>">
		  <cfelse>
		    <cfoutput>#order_ShipTrackingID#</cfoutput>
		  </cfif>
          </td>
        </tr>
        <tr>
          <th align="right">Actual Shipping Cost: </th>
          <td><input name="order_ActualShipCharge" type="text" value="<cfoutput>#rsOrder.order_ActualShipCharge#</cfoutput>"></td>
        </tr>
		<tr>
			<th align="right">Order Comments: </th>
			<td><cfoutput>#rsOrder.order_Comments#</cfoutput></td>
		</tr>
        <tr>
        <tr>
        	<th align="right">Notes: </th>
        	<td><textarea name="order_Notes" cols="50" rows="15" id="order_Notes"><cfoutput>#FORM.order_Notes#</cfoutput></textarea></td>
       	</tr>
      </table>
	  <cfif rsOrder.order_Status NEQ 5 AND rsOrder.order_Status NEQ 4>
      <input name="Update" type="submit" class="formButton" id="Update" value="Update Order Status" style="margin-bottom:20px;">
      </cfif>
	  <!--- Show Delete button is the order is not "Shipped" --->
      <cfif rsOrder.order_Status NEQ 3 AND rsOrder.order_Status NEQ 5>
	  <br />
	  <input name="Delete" type="submit" class="formButton" id="Delete" onClick="return confirm('Are you SURE you want to DELETE this Order? This action cannot be undone.')" value="Delete This Order">
	  </cfif>
</cfform>
  </div>
	<h2>Order Details</h2>
  <table id="tblOrderDetails">
    <tr>
      <th>Product Name</th>
      <th>Qty.</th>
      <th>Price</th>
      <cfif DisplayLineItemDiscount>
		<th>Discount</th>
		</cfif> 
		<cfif DisplayLineItemTaxes>
			<th>Subtotal</th>
			<th>Tax</th>
		</cfif>
      <th>Total</th>
    </tr>
		<cfset rowCount = 0>
    <cfoutput query="rsOrder" group="orderSKU_SKU">
			<cfquery name="rsGetOptions" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
				SELECT 
					ot.optiontype_Name, 
					so.option_Name
				FROM (
					tbl_list_optiontypes ot
						INNER JOIN tbl_skuoptions so
						ON (ot.optiontype_ID = so.option_Type_ID) 
						AND (ot.optiontype_ID = so.option_Type_ID)) 
						INNER JOIN tbl_skuoption_rel r
						ON so.option_ID = r.optn_rel_Option_ID
				WHERE 
					r.optn_rel_SKU_ID=#rsOrder.orderSKU_SKU#
				ORDER BY so.option_Sort
			</cfquery>
			<cfset rowCount = IncrementValue(rowCount)>
      <tr class="#IIF(rowCount MOD 2, DE('altRowEven'), DE('altRowOdd'))#">
        <td> #rsOrder.product_Name# (#rsOrder.SKU_MerchSKUID#) <cfloop query="rsGetOptions"> <br />
            <strong style="margin-left: 10px;">#optiontype_name#</strong>: #option_Name# </cfloop> </td>
        <td align="center">#rsOrder.orderSKU_Quantity#</td>
        <td align="right">#LSCurrencyFormat(val(rsOrder.orderSKU_UnitPrice), 'local')#</td>
        <cfif DisplayLineItemDiscount>
			<td align="right"><cfif val(rsOrder.orderSKU_DiscountAmount) NEQ 0>#LSCurrencyFormat(val(rsOrder.orderSKU_DiscountAmount) * val(rsOrder.orderSKU_Quantity),'local')#</cfif></td> 
			</cfif>
			<cfif DisplayLineItemTaxes>
				<td align="right">#LSCurrencyFormat((val(rsOrder.orderSKU_UnitPrice)  - val(rsOrder.orderSKU_DiscountAmount))* val(rsOrder.orderSKU_Quantity),'local')#</td>
				<td align="right">#LSCurrencyFormat(val(rsOrder.orderSKU_TaxRate),'local')#</td>
				<td align="right">#LSCurrencyFormat(((val(rsOrder.orderSKU_UnitPrice) - val(rsOrder.orderSKU_DiscountAmount)) * val(rsOrder.orderSKU_Quantity) + val(rsOrder.orderSKU_TaxRate))
					,'local')#</td> 
			<cfelse>
				<td align="right">#LSCurrencyFormat((val(rsOrder.orderSKU_UnitPrice) - val(rsOrder.orderSKU_DiscountAmount)) * val(rsOrder.orderSKU_Quantity),'local')#</td> 
			</cfif>
      </tr>
    </cfoutput>
	<cfquery name="rsCWSums" dbtype="query">
	SELECT SUM(orderSKU_DiscountAmount * orderSKU_Quantity) as TotalDiscount,
	SUM(orderSKU_UnitPrice * orderSKU_Quantity) as SubTotal,
	SUM(orderSKU_TaxRate) as TotalTax FROM rsOrder
	</cfquery>
    <tr>
      <th colspan="2" align="right">Subtotal: </th>
      <td align="right"><cfoutput>#LSCurrencyFormat(rsCWSums.SubTotal, "local")#</cfoutput></td>
      <cfif DisplayLineItemDiscount>
			<td align="right"><cfif rsCWSums.TotalDiscount NEQ 0><cfoutput>#LSCurrencyFormat(rsCWSums.TotalDiscount, "local")#</cfoutput></cfif></td>
		</cfif>
		<cfif DisplayLineItemTaxes>
			<td align="right"><cfoutput>#LSCurrencyFormat(rsCWSums.SubTotal - rsCWSums.TotalDiscount, "local")#</cfoutput></td>
			<td align="right"><cfoutput>#LSCurrencyFormat(rsCWSums.TotalTax, "local")#</cfoutput></td>
			<td align="right"><cfoutput>#LSCurrencyFormat(rsCWSums.SubTotal + rsCWSums.TotalTax - rsCWSums.TotalDiscount, "local")#</cfoutput></td> 
		<cfelse>
			<td align="right"><cfoutput>#LSCurrencyFormat(rsOrder.Order_Total-(rsOrder.order_Shipping+rsOrder.Order_Tax),"local")#</cfoutput></td>
		</cfif>
    </tr>
	<cfif rsOrder.order_ShipMeth_ID NEQ 0>
	<tr> 
		<th colspan="2" align="right" valign="top"> Ship By: <cfoutput>#rsOrder.shipmeth_Name#</cfoutput></th>
		<td><cfoutput>#LSCurrencyFormat(rsOrder.order_Shipping,'local')#</cfoutput></td>
		<!--- If showing line item discounts, show shipping discount in cell --->
		<cfif displayLineItemDiscount>
		<td align="right" valign="top">&nbsp;<cfif rsOrder.order_DiscountAmount NEQ 0><cfoutput>#LSCurrencyFormat(val(rsOrder.order_DiscountAmount),'local')#</cfoutput></cfif></td>
		</cfif>
		<!--- If showing line item discounts, show shipping taxes and subtotals in cells --->
		<cfif displayLineItemTaxes>
		<td align="right" valign="top"><cfoutput><cfif DisplayLineItemDiscount>
		#LSCurrencyFormat(val(rsOrder.order_Shipping),'local')#
		<cfelse>
			<cfif val(rsCWSums.TotalDiscount) NEQ 0>
		#cwDisplayOldPrice(LSCurrencyFormat(val(rsOrder.order_Shipping)), rsOrder.order_DiscountID) & 
					LSCurrencyFormat(val(rsOrder.order_Shipping) - val(rsOrder.order_DiscountAmount),'local')#
			<cfelse>
				#LSCurrencyFormat(val(rsOrder.order_Shipping),'local')#
			</cfif></cfif></cfoutput></td>
		<td align="right" valign="top">&nbsp;<cfif val(rsOrder.order_ShippingTax) NEQ 0><cfoutput>#LSCurrencyFormat(val(rsOrder.order_ShippingTax),'local')#</cfoutput></cfif></td>
		<td align="right" valign="top"><cfoutput>#LSCurrencyFormat(val(rsOrder.order_ShippingTax) + val(rsOrder.order_Shipping),'local')#</cfoutput></td>
		<cfelse>
		<td align="right" valign="top">
		<cfif rsOrder.order_DiscountAmount NEQ 0>
			<cfoutput>#cwDisplayOldPrice(LSCurrencyFormat(val(rsOrder.order_Shipping),'local'), rsOrder.order_DiscountID)#</cfoutput>
		<cfelse>
			<cfoutput>#LSCurrencyFormat(val(rsOrder.order_Shipping),'local')#</cfoutput>					
		</cfif>
		</td>
		</cfif>
	</tr>
	</cfif>	
	<cfif NOT DisplayLineItemTaxes>
	<tr>
		<th colspan="<cfoutput>#CartColumnCount + 3#</cfoutput>" align="right">Tax: </th>
		<td align="right"><cfoutput>#LSCurrencyFormat(val(rsOrder.order_Tax))#</cfoutput></td>
	</tr>
	</cfif>
	<!--- Display ORDER TOTAL ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ---> 
	<tr>
		<th colspan="<cfoutput>#CartColumnCount + 3#</cfoutput>" align="right">Order Total: </th>
		<td align="right"><strong><cfoutput>#LSCurrencyFormat(val(rsOrder.order_Total))#</cfoutput></strong></td>
	</tr>
  </table>
  <cfif isdefined("rsGetDiscounts.RecordCount") And rsGetDiscounts.RecordCount GT 0>
  <p>Applying the following discounts: </p>
  <ul>
  	<cfoutput query="rsGetDiscounts">
	<li><a href="DiscountDetails.cfm?discount_id=#rsGetDiscounts.discount_ID#">#rsGetDiscounts.discount_name#</a> #rsGetDiscounts.discount_description#</li>
	</cfoutput></ul>
  </cfif>
	<cfelse>
	<p>Invalid order number</p>
	</cfif>
	</div>
</body>
</html>
