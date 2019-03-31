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
Name: CWIncConfirmation.cfm
Description: 
	This page is displayed to the user once they've completed their
	order. It sends the confirmation email to the customer as well
	as displaying all of their order details in a table suitable
	for printing.
================================================================
--->
<cfparam name="Application.DisplayTaxID" default="false" />
<cfset DisplayTaxID = Application.DisplayTaxID />

<!--- If the Payment Processor is posting to the page, then process the payment --->
<cfif request.PaymentAuthType EQ "Processor">
	<cfset ProcessorStatus = "NoForm">
	<cfinclude template="CWTags/ProcessPayment/#request.PaymentAuthName#">
</cfif>
<!--- End Payment Processing check --->

<!--- Set Headers to prevent browser cache issues --->
<cfset gmt=gettimezoneinfo()>
<cfset gmt=gmt.utcHourOffset>
<cfif gmt EQ 0>
	<cfset gmt="">
	<cfelseif gmt GT 0>
	<cfset gmt="+"&gmt>
</cfif>
<cfheader name="Expires" value="#DateFormat(now(), 'ddd, dd mmm yyyy')# #TimeFormat(now(), 'HH:mm:ss')# GMT#gmt#">
<cfheader name="Pragma" value="no-cache">
<cfheader name="Cache-Control" value="no-cache, no-store, proxy-revalidate, must-revalidate">
<cfparam name="Client.CompleteOrderID" default="0">
<!--- Set local variable for storing display line item tax and discount preferences --->
<cfparam name="Application.DisplayLineItemTaxes" default="false" />
<cfparam name="Application.DisplayLineItemDiscount" default="false" />
<cfparam name="Application.ChargeTaxOnShipping" default="false" />
<cfset DisplayLineItemTaxes = Application.DisplayLineItemTaxes />
<cfset DisplayLineItemDiscount = Application.DisplayLineItemDiscount />
<cfset ChargeTaxOnShipping = Application.ChargeTaxOnShipping />

<cfset CartColumnCount = 0>
<cfif DisplayLineItemTaxes>
	<cfset CartColumnCount = CartColumnCount + 2>
</cfif>
<cfif DisplayLineItemDiscount>
	<cfset CartColumnCount = CartColumnCount + 1>
</cfif>
</cfsilent>
<cfprocessingdirective suppresswhitespace="yes">
<!--- If we have a valid order id, output the order --->

<cfif Client.CompleteOrderID NEQ 0>
	<cfset ThisOrderID = Client.CompleteOrderID>
	<!--- Output order details for the user to print out. --->
	<!--- Get Order --->
	<cfquery name="rsOrder" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
	SELECT o.*, c.cst_FirstName, c.cst_LastName, c.cst_Email, os.orderSKU_SKU, 
	p.product_Name, os.orderSKU_Quantity, os.orderSKU_UnitPrice, 
	os.orderSKU_SKUTotal, sm.shipmeth_Name, s.SKU_MerchSKUID,
	os.orderSKU_TaxRate,
	os.orderSKU_DiscountID,
	os.orderSKU_DiscountAmount

	FROM (tbl_products p
	INNER JOIN tbl_skus s
	ON p.product_ID = s.SKU_ProductID) 
	INNER JOIN ((tbl_customers c
	INNER JOIN (tbl_shipmethod sm
	RIGHT JOIN tbl_orders o 
	ON sm.shipmeth_ID = o.order_ShipMeth_ID) 
	ON c.cst_ID = o.order_CustomerID) 
	INNER JOIN tbl_orderskus os
	ON o.order_ID = os.orderSKU_OrderID) 
	ON s.SKU_ID = os.orderSKU_SKU
	WHERE (((o.order_ID)='#ThisOrderID#'))
	ORDER BY p.product_Sort, p.product_Name, s.SKU_Sort, s.SKU_ID
	</cfquery>
	<!--- If there are valid order records --->
	<cfif rsOrder.RecordCount NEQ 0>
	<!--- Shipping Details --->
	<h2>Ship To</h2>
	<p><cfoutput><strong>#rsOrder.order_ShipName#</strong><br />
	 #rsOrder.order_Address1#
	 <cfif rsOrder.order_Address2 NEQ "">
	  <br />
	  #rsOrder.order_Address2#
	 </cfif>
	 <br />
	 #rsOrder.order_City#, #rsOrder.order_State# #rsOrder.order_Zip#<br />
	 #rsOrder.order_Country#</cfoutput></p>

<!--- Output Order Table --->
<h2>Order Details</h2>
<p>Order ID: <cfoutput>#rsOrder.order_ID#</cfoutput></p>
<cfif DisplayTaxID>
<p>Tax ID: <cfoutput>#Application.TaxIDNumber#</cfoutput></p>
</cfif>
<table class="tabularData" id="tblOrderDetails"> 
	<tr> 
		<th>Product Name</th> 
		<th align="center">Price</th> 
		<th align="center">Qty.</th>
		<cfif DisplayLineItemDiscount>
		<th align="center">Discount</th>
		</cfif> 
		<cfif DisplayLineItemTaxes>
			<th align="center">Subtotal</th>
			<th align="center">Tax</th>
		</cfif>
		<th align="center">Total</th>
	</tr> 
	<cfset rowCount = 0>
	<cfoutput query="rsOrder" group="orderSKU_SKU">
	<cfquery name="rsGetOptions" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
	SELECT ot.optiontype_Name, so.option_Name
	FROM (tbl_list_optiontypes ot
	INNER JOIN tbl_skuoptions so
	ON (ot.optiontype_ID = so.option_Type_ID) 
	AND (ot.optiontype_ID = so.option_Type_ID)) 
	INNER JOIN tbl_skuoption_rel r 
	ON so.option_ID = r.optn_rel_Option_ID 
	WHERE r.optn_rel_SKU_ID=#rsOrder.orderSKU_SKU# 
	ORDER BY ot.optiontype_Name, so.option_Sort
	</cfquery>
		<tr valign="top" class="#cwAltRows(rowCount)#">
		<cfset rowCount = rowCount + 1> 
			<td>#rsOrder.product_Name# (#rsOrder.SKU_MerchSKUID#)
			<!--- Output sku options ---> 
			<cfloop query="rsGetOptions">
			<br />
			<strong style="margin-left: 10px;">#optiontype_name#</strong>: #option_Name#				
			</cfloop>
			</td>
			<cfif rsOrder.orderSKU_DiscountAmount NEQ 0>
			<td align="right"><cfif DisplayLineItemDiscount>
			#LSCurrencyFormat(rsOrder.orderSKU_UnitPrice,'local')#
			<cfelse>
			#cwDisplayOldPrice(LSCurrencyFormat(rsOrder.orderSKU_UnitPrice),rsOrder.orderSKU_DiscountID) & 
						LSCurrencyFormat(rsOrder.orderSKU_UnitPrice - rsOrder.orderSKU_DiscountAmount,'local')#</cfif>
			</td> 
			<cfelse>
			<td align="right">#LSCurrencyFormat(rsOrder.orderSKU_UnitPrice,'local')#</td> 
			</cfif>
			<td align="center">#rsOrder.orderSKU_Quantity#</td>
			<cfif DisplayLineItemDiscount>
			<td align="right"><cfif rsOrder.orderSKU_DiscountAmount NEQ 0>#LSCurrencyFormat(rsOrder.orderSKU_DiscountAmount * rsOrder.orderSKU_Quantity,'local')#</cfif></td> 
			</cfif>
			<cfif DisplayLineItemTaxes>
				<td align="right">#LSCurrencyFormat((rsOrder.orderSKU_UnitPrice  - rsOrder.orderSKU_DiscountAmount)* rsOrder.orderSKU_Quantity,'local')#</td>
				<td align="right">#LSCurrencyFormat(rsOrder.orderSKU_TaxRate,'local')#</td>
				<td align="right">#LSCurrencyFormat(((rsOrder.orderSKU_UnitPrice - rsOrder.orderSKU_DiscountAmount) * rsOrder.orderSKU_Quantity + rsOrder.orderSKU_TaxRate)
					,'local')#</td> 
			<cfelse>
				<td align="right">#LSCurrencyFormat((rsOrder.orderSKU_UnitPrice - rsOrder.orderSKU_DiscountAmount) * rsOrder.orderSKU_Quantity,'local')#</td> 
			</cfif>
		</tr> 
	</cfoutput>
	<cfquery name="rsCWSums" dbtype="query">
	SELECT SUM(orderSKU_DiscountAmount * orderSKU_Quantity) as TotalDiscount,
	SUM(orderSKU_UnitPrice * orderSKU_Quantity) as SubTotal,
	SUM(orderSKU_TaxRate) as TotalTax FROM rsOrder
	</cfquery>
	<tr> 
		<th colspan="3" align="right">Subtotal:&nbsp;</th>
		<cfif DisplayLineItemDiscount>
			<td align="right"><cfif rsCWSums.TotalDiscount NEQ 0><cfoutput>#LSCurrencyFormat(rsCWSums.TotalDiscount, "local")#</cfoutput></cfif></td>
		</cfif>
		<cfif DisplayLineItemTaxes>
			<td align="right"><cfoutput>#LSCurrencyFormat(rsCWSums.SubTotal - rsCWSums.TotalDiscount, "local")#</cfoutput></td>
			<td align="right"><cfoutput>#LSCurrencyFormat(rsCWSums.TotalTax, "local")#</cfoutput></td>
			<td align="right"><cfoutput>#LSCurrencyFormat(rsCWSums.SubTotal + rsCWSums.TotalTax - rsCWSums.TotalDiscount, "local")#</cfoutput></td> 
		<cfelse>
			<td align="right"><cfoutput>#LSCurrencyFormat(rsCWSums.SubTotal - rsCWSums.TotalDiscount,"local")#</cfoutput></td>
		</cfif>
	 </tr> 
	<cfif rsOrder.order_ShipMeth_ID NEQ 0>
	<tr> 
		<th colspan="3" align="right" valign="top"> Ship By: <cfoutput>#rsOrder.shipmeth_Name#</cfoutput>
		</th>
		<!--- If showing line item discounts, show shipping discount in cell --->
		<cfif displayLineItemDiscount>
		<td align="right" valign="top">&nbsp;<cfif rsOrder.order_DiscountAmount NEQ 0><cfoutput>#LSCurrencyFormat(rsOrder.order_DiscountAmount,'local')#</cfoutput></cfif></td>
		</cfif>
		<!--- If showing line item discounts, show shipping taxes and subtotals in cells --->
		<cfif displayLineItemTaxes>
		<td align="right" valign="top"><cfoutput><cfif DisplayLineItemDiscount>
		#LSCurrencyFormat(rsOrder.order_Shipping,'local')#
		<cfelse>
			<cfif rsCWSums.TotalDiscount NEQ 0>
		#cwDisplayOldPrice(LSCurrencyFormat(rsOrder.order_Shipping), rsOrder.order_DiscountID) & 
					LSCurrencyFormat(rsOrder.order_Shipping - rsOrder.order_DiscountAmount,'local')#
			<cfelse>
				#LSCurrencyFormat(rsOrder.order_Shipping,'local')#
			</cfif></cfif></cfoutput></td>
		<td align="right" valign="top">&nbsp;<cfif rsOrder.order_ShippingTax NEQ 0><cfoutput>#LSCurrencyFormat(rsOrder.order_ShippingTax,'local')#</cfoutput></cfif></td>
		<td align="right" valign="top"><cfoutput>#LSCurrencyFormat(rsOrder.order_ShippingTax + rsOrder.order_Shipping,'local')#</cfoutput></td>
		<cfelse>
		<td align="right" valign="top">
		<cfif rsOrder.order_DiscountAmount NEQ 0>
			<cfoutput>#cwDisplayOldPrice(LSCurrencyFormat(rsOrder.order_Shipping,'local'), rsOrder.order_DiscountID)#</cfoutput>
		<cfelse>
			<cfoutput>#LSCurrencyFormat(rsOrder.order_Shipping + rsOrder.order_ShippingTax,'local')#</cfoutput>					
		</cfif>
		</td>
		</cfif>
	</tr>
	</cfif>	
	
	<cfif NOT DisplayLineItemTaxes>
	<tr>
		<th colspan="<cfoutput>#CartColumnCount + 3#</cfoutput>" align="right">Tax: </th>
		<td align="right"><cfoutput>#LSCurrencyFormat(rsOrder.order_Tax)#</cfoutput></td>
	</tr>
	</cfif>
	<!--- Display ORDER TOTAL ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ---> 
	<tr>
		<th colspan="<cfoutput>#CartColumnCount + 3#</cfoutput>" align="right">Order Total: </th>
		<td align="right"><strong><cfoutput>#LSCurrencyFormat(rsOrder.order_Total)#</cfoutput></strong></td>
	</tr>
</table> 

	<cfif request.PaymentAuthType EQ "gateway" or request.PaymentAuthType EQ "none">
	<!--- 
	Send Order confirmation Email to Customer and Order Notice Email to Merchant.
	Do this before anything else just in case there are errors with the display portion. 
	--->	
		<cfinclude template="CWTags/CWFunOrderConfirmEmails.cfm">
		<cfset EmailContents = cwBuildConfirmationEmail(rsOrder.order_ID)>
		<cfset cwOrderConfirmEmails(EmailContents, rsOrder.cst_Email)>
	</cfif>
	<!--- // All Done Now ... Need to Kill Sessions and delete Client Order ID // --->
	<cfset DeleteClientVariable("CompleteOrderID")>
	<cfset DeleteClientVariable("CustomerID")>
	<cfset DeleteClientVariable("CheckingOut")>
	<cfif request.PaymentAuthType EQ "Processor">
		<cfset ProcessorStatus = "Form">
		<cfinclude template="CWTags/ProcessPayment/#request.PaymentAuthName#">
	</cfif>
	<cfelse>
	Invalid order number.
	</cfif>
	<cfelseif IsDefined("URL.mode")>
		<cfswitch expression="#URL.mode#">
			<cfcase value="return">
				<p>Thank you for your payment. Your order will be processed shortly.</p>
			</cfcase>
			<cfcase value="cancel">
				<p>You have chosen to cancel your payment. Your order will not be processed.</p>
				<cfif isDefined("url.orderid") AND isdefined("Client.CompleteOrderID") AND url.orderid EQ Client.CompleteOrderID>
					<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
					UPDATE tbl_orders SET order_Status = 4 
					WHERE order_ID = '#Client.CompleteOrderID#'
					</cfquery>
				</cfif>
			</cfcase>
			<cfdefaultcase>
				<p>Invalid mode submission.</p>
			</cfdefaultcase>
		</cfswitch>
	<cfelse>
	<!--- no valid cart, redirect the user. --->
	<cfif IsDefined("URL.Mode")>
		<cfif URL.Mode EQ "return">
			<p>Thank you for your payment.</p>
			<cfelse>
			<p>Your payment has been cancelled.</p>
		</cfif>
		<cfelse>
		<cflocation url="#request.targetGoToCart#" addtoken="no">
	</cfif>
</cfif>
</cfprocessingdirective>
