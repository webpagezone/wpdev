<cfsilent>
<!--- 
================================================================
Application Info: Cartweaver© 2002 - 2007, All Rights Reserved.
Developer Info: Application Dynamics Inc.
                1560 NE 10th
                East Wenatchee, WA 98802
Support Info: http://www.cartweaver.com/go/cfhelp
    
Cartweaver Version: 3.0.9  -  Date: 2/18/2008

================================================================
Name: Order Confirmation
Description: This page sends both confirmation emails to the 
customer and the store merchant.
================================================================
--->

<!--- Email confirmation notice to customer --->
<cflock timeout="10" throwontimeout="no" type="readonly" scope="application">
  <cfset variables.MailServer = application.mailserver>
  <cfset variables.subject = "Your Order From #application.companyname#">
  <cfset variables.CompanyEmail = application.companyemail>
  <cfset variables.Company = application.companyname>
</cflock>
<cffunction name="cwOrderConfirmEmails">
	<cfargument name="EmailContents" default="">
	<cfargument name="CustomerEmail" default="">
	<!--- If you're using a payment gateway --->
	<cfif request.PaymentAuthType EQ "Gateway">
	
		<cfmail to="#CustomerEmail#"
			from="#variables.CompanyEmail#"
			subject="#variables.subject#"
			server="#variables.MailServer#">
Your order has been received and will be shipped to you shortly! Your details are as follows.

#EmailContents#	
Thank you!
		</cfmail>
	
	<!--- If you're using anything other than a payment gateway --->
	<cfelse>
	
		<cfmail to="#CustomerEmail#"
			from="#variables.CompanyEmail#"
			subject="#variables.subject#"
			server="#variables.MailServer#">
Your order has been received.
As soon as your payment is verified you will receive a confirmation notice and your order will be shipped! Your order details are as follows.

#EmailContents#	
Thank you!
		</cfmail>
	
	</cfif>
	
	
	<!--- "You have an order" Notification sent to Merchant --->
	<cfmail to="#variables.CompanyEmail#"
		from="#variables.CompanyEmail#"
		subject="#variables.subject# - Merchant Order Notification"
		server="#variables.MailServer#">
	You have just received an order. The order details are as follows:
	
	#EmailContents#	
	</cfmail>

</cffunction>

<cffunction name="cwOrderShippingEmails">
	<cfargument name="EmailContents" default="">
	<cfargument name="CustomerEmail" default="">
	
	<cfmail to="#CustomerEmail#"
		from="#variables.CompanyEmail#"
		subject="#variables.subject# has shipped"
		server="#variables.MailServer#">
Your order has been shipped! Your details are as follows.

#EmailContents#	
Thank you!
	</cfmail>
	
</cffunction>

<cffunction name="cwBuildConfirmationEmail">
<cfargument name="OrderID" default="">
<cfquery name="rsOrder" 
datasource="#request.dsn#" 
username="#request.dsnUsername#" 
password="#request.dsnPassword#">
SELECT o.*, 
c.cst_FirstName, 
c.cst_LastName, 
c.cst_Email, 
os.orderSKU_SKU, 
p.product_Name, 
os.orderSKU_Quantity, 
os.orderSKU_UnitPrice, 
os.orderSKU_SKUTotal, 
sm.shipmeth_Name, 
s.SKU_MerchSKUID,
os.orderSKU_TaxRate,
os.orderSKU_DiscountID,
os.orderSKU_DiscountAmount,
(o.order_Total - (o.order_Tax + o.order_Shipping + o.order_ShippingTax)) as order_SubTotal
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
WHERE (((o.order_ID)='#OrderID#'))
ORDER BY p.product_Sort, 
p.product_Name, 
s.SKU_Sort, 
s.SKU_ID
</cfquery>
<cfif rsOrder.RecordCount GT 0>
<!--- Create Ship To information for confirmation email --->
<cfsavecontent variable="EmailContents">
<cfoutput>Order ID: #rsOrder.order_ID#

Ship To
====================
#rsOrder.order_ShipName#
#rsOrder.order_Address1#
<cfif rsOrder.order_Address2 NEQ "">
#rsOrder.order_Address2#
</cfif>
#rsOrder.order_City#, #rsOrder.order_State# #rsOrder.order_Zip#
#rsOrder.order_Country#</cfoutput>

Order Details
====================
<cfoutput query="rsOrder" group="orderSKU_SKU">
<cfsilent>	
	<cfquery name="rsGetOptions" 
		datasource="#request.dsn#" 
		username="#request.dsnUsername#" 
		password="#request.dsnPassword#">
		SELECT tbl_list_optiontypes.optiontype_Name, tbl_skuoptions.option_Name
		FROM (tbl_list_optiontypes 
		INNER JOIN tbl_skuoptions 
		ON (tbl_list_optiontypes.optiontype_ID = tbl_skuoptions.option_Type_ID) 
		AND (tbl_list_optiontypes.optiontype_ID	= tbl_skuoptions.option_Type_ID)) 
		INNER JOIN tbl_skuoption_rel 
		ON tbl_skuoptions.option_ID	= tbl_skuoption_rel.optn_rel_Option_ID 
		WHERE tbl_skuoption_rel.optn_rel_SKU_ID=#rsOrder.orderSKU_SKU# 
		ORDER BY tbl_list_optiontypes.optiontype_Name, tbl_skuoptions.option_Sort
	</cfquery>
</cfsilent>

#rsOrder.product_Name#(#rsOrder.SKU_MerchSKUID#)
	
	<cfloop query="rsGetOptions"><!--- Output the individual sku options --->
   #rsGetOptions.optiontype_name#: #rsGetOptions.option_Name#
	</cfloop>
Quantity: #rsOrder.orderSKU_Quantity#
Price: #LSCurrencyFormat(rsOrder.orderSKU_UnitPrice)#
<cfif Application.DisplayLineItemDiscount>
Discount: #LSCurrencyFormat(rsOrder.orderSKU_DiscountAmount)#</cfif>
<cfif Application.DisplayLineItemTaxes>
Tax: #LSCurrencyFormat(rsOrder.orderSKU_TaxRate, 'local')#</cfif>
Total: #LSCurrencyFormat(rsOrder.orderSKU_SKUTotal)#

</cfoutput>
<cfoutput>
====================
Subtotal: #LSCurrencyFormat(rsOrder.order_SubTotal)#
Shipping (#rsOrder.shipmeth_Name#): #LSCurrencyFormat(rsOrder.order_Shipping)#
Tax: #LSCurrencyFormat(rsOrder.order_Tax + rsOrder.order_ShippingTax)#
Order Total: #LSCurrencyFormat(rsOrder.order_Total)#
Order Comments: #rsOrder.order_Comments#

<cfif rsOrder.order_Status EQ 3>
Shipped: #DateFormat(rsOrder.order_ShipDate)#
<cfif rsOrder.order_ShipTrackingID NEQ "">
Tracking Number: #rsOrder.order_ShipTrackingID#
</cfif>
</cfif>
</cfoutput>
</cfsavecontent>
</cfif>
<cfreturn EmailContents />
</cffunction>
</cfsilent>