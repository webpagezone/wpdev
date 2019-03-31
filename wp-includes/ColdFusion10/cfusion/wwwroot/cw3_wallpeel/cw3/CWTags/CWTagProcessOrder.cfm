<cfsilent>
<!--- 
================================================================
Application Info: Cartweaver© 2002 - 2007, All Rights Reserved.
Developer Info: Application Dynamics Inc.
                1560 NE 10th
                East Wenatchee, WA 98802
Support Info: http://www.cartweaver.com/go/cfhelp
				
Cartweaver Version: 3.0.13  -  Date: 7/25/2008
================================================================
Name: Process Order Custom Tag
Description: 
	The Process Order Custom tag adds the user's order to the
	database. All data is validated before processing the order.
	This page calls the CWTagPaymentProcessors Custom Tag in order
	to pass data to the payment processor.
================================================================
--->
<cfinclude template="CWIncDiscountFunctions.cfm">
<cfparam name="Session.OrderComments" default="">
<cfif IsDefined('Client.CartID')>
  <!--- Validate Credit Card Input --->
  <cfparam name="request.FieldInvalid" default="NO">
	<cfif request.PaymentAuthType EQ "Gateway">
		<cfscript>
		// Check Card holder name
		if (FORM.cstCCardHolderName eq "")
			{ request.FieldErrorCHN = "<br />Card Holder Name cannot be blank.";
			 request.FieldInvalid = "YES";
		}
		
		// Check C Card Type
		if (FORM.cstCCardType eq "forgot")
			{ request.FieldErrorCT = "<br />Please choose your credit card type.";
			 request.FieldInvalid = "YES";
		}

		// Check C Card Number
		thisCCNum = FORM.cstCCNumber;
		ccLength = 16;
		altccLength = 16;
		ccvLength = 3;
		if(FORM.cstCCardType EQ "amex"){
			ccLength = 15;
			altccLength = 15;
			ccvLength = 4;
		}
		
		if(Form.cstCCardType EQ "visa"){      
			altccLength = 13; // visa now accepts 13 and 16 character numbers, so allow both    
		}
		
		if (IsNumeric(thisCCNum) IS "FALSE" OR (Len(thisCCNum) NEQ ccLength And Len(thisCCNum) NEQ altccLength)){ 
			request.FieldErrorCN = "<br />You did not enter a valid credit card number.";
			request.FieldInvalid = "YES";
		}
		
		if (IsNumeric(FORM.cstCCV) IS "FALSE" OR Len(FORM.cstCCV) LT ccvLength)
			{ request.FieldErrorCCV = "<br />You did not enter a CCV code.";
			 request.FieldInvalid = "YES";
		}
		
		
		// Check C Card Expr Month
		if (FORM.cstExprMonth eq "forgot"){ 
			request.FieldErrorCM ="<br />Please choose the month your card expires.";
			request.FieldInvalid = "YES";
		}
		
		// Check C Card Expr Year
		if (FORM.cstExprYr eq "forgot"){ 
			request.FieldErrorCY = "<br />Please choose the year your card expires.";
			request.FieldInvalid = "YES";
		}
		</cfscript>
	</cfif>
  <!--- Check to be sure there are no credit card errors --->
  <cfif request.FieldInvalid EQ "NO">
    <!--- If a payment processor or no payment verification is being used, 
		      then approve the transactions --->
    <cfif request.PaymentAuthType EQ "Processor" OR request.PaymentAuthType EQ "NONE">
      <cfset request.OrderStatusID = 1>
      <cfset Request.TransactionID = Client.CartID>
      <cfset request.TransactionMessage = "Approved">
      <cfset request.TransactionResult = "Approved">
    </cfif>

    <!--- [START Payment Gateway Custom Tag Call] --->
    <cfif request.PaymentAuthType EQ "Gateway">
      <!--- Set default values for use in the Gateway --->
      <cfset request.CCardHolderName = FORM.cstCCardHolderName>
      <cfset request.CCardType = FORM.cstCCardType>
      <cfset request.CCNumber = FORM.cstCCNumber>
      <cfset request.ExprMonth = FORM.cstExprMonth>
      <cfset request.ExprYr = FORM.cstExprYr>
			<cfset request.CCV = FORM.cstCCV>
      <cfset request.CCExprDate = "#request.ExprMonth##request.ExprYr#">
      <!--- Get billing information for Credit Card validation --->
      <cfquery name="rsGetCustBilling" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
			SELECT c.cst_FirstName, c.cst_LastName, s.stprv_Code, s.stprv_Name, co.country_Code, c.cst_Email, c.cst_Phone, 
			c.cst_Address1, c.cst_Address2, c.cst_City, c.cst_Zip
			FROM (tbl_list_countries co
			INNER JOIN tbl_stateprov s
			ON co.country_ID = s.stprv_Country_ID) 
			INNER JOIN (tbl_customers c
			INNER JOIN tbl_custstate cs
			ON c.cst_ID = cs.CustSt_Cust_ID) 
			ON s.stprv_ID = cs.CustSt_StPrv_ID
			WHERE c.cst_ID = '#Client.CustomerID#' 
			AND cs.CustSt_Destination = 'BillTo'
      </cfquery>
      <!--- Process the payment and return a result --->
      <cfinclude template="ProcessPayment/#request.PaymentAuthName#">
    </cfif>
    <!--- [END Payment Gateway Custom Tag Call] --->

    <!--- Tansaction APPROVED enter data in database. --->
    <cfif request.TransactionResult EQ "Approved">
      <!--- If your DBS does not support "transactions", remove the next Line and the closing tag--->
      <cftransaction action="begin">
        <cfquery name="rsGetCustShipping" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
        SELECT cst_ShpName, cst_ShpAddress1, cst_ShpAddress2, cst_ShpCity, stprv_Code, cst_ShpZip, country_Code, cst_Email 
		FROM tbl_customers, tbl_custstate, tbl_stateprov, tbl_list_countries 
		WHERE cst_ID ='#Client.CustomerID#'
		AND stprv_ID = CustSt_StPrv_ID 
		AND CustSt_Cust_ID = cst_ID 
		AND CustSt_Destination ='ShipTo'
		AND country_ID = stprv_Country_ID
        </cfquery>
		<!--- Keep a tally of applied discounts, including shipping --->
		<cfset appliedDiscounts = "">
        <!--- Create a New Order ID --->
        <cfset variables.ThisOrderID = CreateUUID()>
        <!--- Insert the order into the database --->
        <cfquery name="rsAddOrder" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
        INSERT INTO tbl_orders ( 
				order_ID, order_CustomerID, order_Tax, order_Shipping, order_ShippingTax, order_Total
				, order_Status, order_ShipMeth_ID, order_Address1, order_Address2, order_City,order_Zip
				, order_Country, order_State, order_TransactionID, order_Date, order_ShipName, order_DiscountID, order_DiscountAmount, order_Comments
			) VALUES (
				'#variables.ThisOrderID#','#Client.CustomerID#', #Attributes.Cart.CartTotals.Tax#, #Attributes.Cart.CartTotals.Shipping#, #Attributes.Cart.CartTotals.ShippingTax#
				, #Attributes.Cart.CartTotals.Total#, '#request.OrderStatusID#', #Client.ShipPref#,'#rsGetCustShipping.cst_ShpAddress1#'
				, '#rsGetCustShipping.cst_ShpAddress2#','#rsGetCustShipping.cst_ShpCity#','#rsGetCustShipping.cst_ShpZip#'
				, '#rsGetCustShipping.country_Code#','#rsGetCustShipping.stprv_Code#','#Request.TransactionID#'
				, #CreateODBCDateTime(Now())#, '#rsGetCustShipping.cst_ShpName#', #Val(Request.shippingDiscount)#, #Val(Attributes.Cart.CartTotals.ShippingDiscounts)#
				, '#Session.OrderComments#'
			)
        </cfquery>
		<cfif val(request.shippingDiscount) NEQ 0>
			<cfset appliedDiscounts = "#request.shippingDiscount#">
		</cfif>
        <!--- // === Now Add SKUs ordered to "OrderItems" Table === // --->
        <!--- Loop through the products and record them --->
        <cfloop from="1" to="#ArrayLen(Attributes.Cart.Products)#" index="lineNumber">
			<!--- Set the current product to a variable for easier reference --->
			<cfset Product = Attributes.Cart.Products[lineNumber] />
			<cfquery name="rsAddSKUs" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
			INSERT INTO tbl_orderskus (
					orderSKU_OrderID, orderSKU_SKU, orderSKU_Quantity, orderSKU_UnitPrice
					, orderSKU_SKUTotal, orderSKU_Picked, orderSKU_TaxRate, orderSKU_DiscountID, orderSKU_DiscountAmount
				) VALUES (
					'#variables.ThisOrderID#', #Product.SKUID#, #Product.Quantity#, #Product.Price#, #Product.SubTotal#
					, 0, #Product.Tax#, #Product.Discount.DiscountID#, #Product.DiscountAmount#
				)
			</cfquery>
			<!--- Debit purchased quantity from stock on hand. --->
			<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
			UPDATE tbl_skus 
			SET SKU_Stock = SKU_Stock - #Product.Quantity# 
			WHERE SKU_ID = #Product.SKUID#
			</cfquery>
			<!--- Add discount from product to the appliedDiscounts list --->
			<cfif val(Product.Discount.DiscountID) NEQ 0 AND NOT ListFind(appliedDiscounts, Product.Discount.DiscountID)>
				<cfset appliedDiscounts = ListAppend(appliedDiscounts, "#Product.Discount.DiscountID#")>
			</cfif>
        </cfloop>
		<cfif listLen(appliedDiscounts) GT 0>
			<cfset cwApplyDiscounts(appliedDiscounts, Client.CustomerID)>
		</cfif>
      </cftransaction>
      <!--- If your DBS does not support "transactions", remove the previous Line!--->
      <!--- Clear all Cart Client Variables --->
      <cfmodule template="CWTagClearCart.cfm">
      <!--- Set Client variable to current order ID for use on confirmation page --->
      <cfset Client.CompleteOrderID = variables.ThisOrderID>
      <!--- Redirect to Confirmation page --->
      <cflocation url="#request.targetConfirmOrder#" addtoken="no">
			<cfelse>
			<cfset Request.FieldErrorText = Request.TransactionMessage>
    </cfif>
		<cfelse>
		<cfset request.FieldErrorText = "Please correct the highlighted fields.">
  </cfif>
  <!--- End check for valid credit card data --->
  <cfelse>
  <!--- no valid cart, redirect the user to the cart page --->
  <cflocation url="#request.targetGoToCart#" addtoken="no">
</cfif>
</cfsilent>
