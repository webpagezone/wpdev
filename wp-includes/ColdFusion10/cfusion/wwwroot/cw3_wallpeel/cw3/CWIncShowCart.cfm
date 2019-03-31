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
Name: Show Cart Include
Description: 
	This page shows the user their shopping cart contents. If the
	user is checking it out, it also collects their credit card
	information and submits the data to your payment gateway or
	payment processor. If the order is processed successfully the
	customer is sent to the confirmation page.
================================================================
--->
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
<!--- Including the shipping functions --->
<cfinclude template="CWTags/CWTagShipping.cfm" />
<!--- Set up promocode if entered --->
<cfif isDefined("form.promocode")>
	<cfset session.promotionalcode = LCase(form.promocode)>
	<cfset session.availableDiscounts = "">
</cfif>
<cfif IsDefined("session.promotionalcode") AND session.promotionalcode NEQ "">
	<cfset cwGetDiscounts()>
</cfif>
<cfset shippingDiscounts = cwGetShippingDiscounts()>
<!--- START [ SET PARAMETERS ] ================================================== --->
<!--- Set local variable for storing display line item tax and discount preferences --->
<cfparam name="Application.DisplayLineItemTaxes" default="false" />
<cfparam name="Application.DisplayLineItemDiscount" default="false" />
<cfparam name="Application.ChargeTaxOnShipping" default="false" />
<cfparam name="Application.ShowShippingInfo" default="true" />
<cfset ShowShippingInfo = Application.ShowShippingInfo />

<cfset DisplayLineItemTaxes = Application.DisplayLineItemTaxes />
<cfif application.EnableDiscounts EQ true>
	<cfset DisplayLineItemDiscount = Application.DisplayLineItemDiscount />
<cfelse>
	<cfset DisplayLineItemDiscount = false>
</cfif>
<cfset ChargeTaxOnShipping = Application.ChargeTaxOnShipping />

<cfset CartColumnCount = 0>
<cfif DisplayLineItemTaxes>
	<cfset CartColumnCount = CartColumnCount + 2>
</cfif>
<cfif DisplayLineItemDiscount>
	<cfset CartColumnCount = CartColumnCount + 1>
</cfif>
<!--- Set default Low Stock parameter --->
<cfparam name="URL.StockAlert" default="NO">
<!--- set local variable for backorder preference, doing this reduces the number of CFLOCKs we need to use. --->
<cflock type="readonly" scope="application" timeout="5" throwontimeout="no">
	<cfset variables.BackOrderPref = application.AllowBackOrders>
	<cfset variables.ShipCalc = application.ShipCalcType>
</cflock>
<cfparam name="Client.ShipToCountryID" default="1">
<cfparam name="Client.CheckingOut" default="NO">

<!--- If ship pref form has been submitted, set shipping Preference  --->
<cfparam name="Client.ShipPref" default="0">
<cfif IsDefined("FORM.PickShipPref")>
	<cfset Client.ShipPref = FORM.PickShipPref>
</cfif>
<!--- Set defaults for Credit Card processing fields --->
<cfparam name="FORM.cstCCardHolderName" default="">
<cfparam name="FORM.cstCCardType" default="">
<cfparam name="FORM.cstCCNumber" default="">
<cfparam name="FORM.cstCCV" default="">
<cfparam name="FORM.cstExprMonth" default="">
<cfparam name="FORM.cstExprYr" default="">
<!--- Set default error checking variables --->
<cfparam name="request.FieldErrorText" default="">
<cfparam name="request.TransactionMessage" default="">
<!--- Set defaults for CWTagCartweaver work --->
<cfparam name="request.QtyAdded" default="0">
<cfparam name="FORM.action" default="">
<!--- END [ SET parameters ] ===================================================== --->
<!--- START [ CART ACTIONS ] ===================================================== --->
<!--- DELETE Items checked "remove" from cart --->
<cfif IsDefined ('FORM.remove')>
	<cfloop from="1" to="#ListLen(FORM.remove)#" index="index" >
		<cfmodule 
		template="CWTags/CWTagCartweaver.cfm"
		cartaction = "delete"
		sku_id = "#ListGetAt(FORM.remove,index)#"
		redirect = "no"
		>
	</cfloop>
</cfif>
<!--- UPDATE ITEM ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --->
<cfif FORM.action EQ "update">
	<!--- Loop through the form --->
	<cfparam name="FORM.remove" default="">
	<cfloop from="1" to="#FORM.productCount#" index="i" >
		<cfif IsNumeric(FORM["qty#i#"]) 
			AND FORM["qty#i#"] NEQ FORM["qty_now#i#"] 
			AND FORM["qty#i#"] GT 0 
			AND ListFind(FORM.remove, FORM["skuID#i#"]) EQ 0>
			<cfmodule 
				template="CWTags/CWTagCartweaver.cfm"
				cartaction = "update"
				sku_id = "#FORM['skuID#i#']#"
				sku_qty = "#FORM['qty#i#']#"
				redirect="no"
				>
		<cfelseif FORM["qty#i#"] EQ 0>
		<!--- If the user has set quantity to "0" or deleted the quantity, remove the item from the cart --->
			<cfmodule 
				template="CWTags/CWTagCartweaver.cfm"
				cartaction = "delete"
				sku_id = "#FORM["skuID#i#"]#"
				redirect="no"
				>
		</cfif>
	</cfloop>
</cfif>
<!--- END [ CART ACTIONS ] ===================================================== --->
<!--- First, get order --->
<cfif IsDefined("Client.CartID")>
	<cfset Cart = cwGetCart(Client.CartID, Client.TaxStateID, Client.TaxCountryID) />
	<cfif ArrayIsEmpty(Cart.Products)>
		<cfset HasCart = False />
	<cfelse>
		<cfset HasCart = True />

		<cfif Client.CheckingOut EQ "YES">
			<!--- Get customer's address Information. --->
			<cfquery name="rsGetCustData" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
			SELECT * FROM tbl_customers WHERE cst_ID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Client.CustomerID#" />
			</cfquery>
			<cfquery name="rsGetBillTo" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
			SELECT cs.CustSt_StPrv_ID, s.stprv_Name, s.stprv_Code, c.country_Name,
			s.stprv_Tax, s.stprv_Ship_Ext 
			FROM (tbl_custstate cs
			INNER JOIN tbl_stateprov s
			ON cs.CustSt_StPrv_ID = s.stprv_ID)
			INNER JOIN tbl_list_countries c 
			ON s.stprv_Country_ID = c.country_ID
			WHERE cs.CustSt_Cust_ID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Client.CustomerID#" />
			AND cs.CustSt_Destination='BillTo'
			</cfquery>
			<!--- Get customer ship to information --->
			<cfquery name="rsGetShipTo" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
			SELECT cs.CustSt_StPrv_ID, s.stprv_Name, c.country_Name,
			s.stprv_Tax, s.stprv_Ship_Ext 
			FROM (tbl_custstate cs
			INNER JOIN tbl_stateprov s
			ON cs.CustSt_StPrv_ID = s.stprv_ID)
			INNER JOIN tbl_list_countries c
			ON s.stprv_Country_ID = c.country_ID
			WHERE cs.CustSt_Cust_ID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Client.CustomerID#" />
			AND cs.CustSt_Destination='ShipTo'
			</cfquery>
			<!--- For Shipping, set ship to StProv Shipping extension --->
			<cfset Request.ShipExtension = rsGetShipTo.stprv_Ship_Ext>
			<!--- ============================================================= --->
			<!--- Calculate SHIPPING  [ START ]================================ --->
			<!--- ============================================================= --->
			<!--- Get Shipping Methods Available for Customer's Location --->
			<!--- If you're not charging shipping by weight, then just get everything --->
			<cfset rsGetShipMethods = getShippingRates(
				Mode = "ShipList", 
				ShipToCountryID = val(Client.ShipToCountryID), 
				CartWeight = Cart.CartTotals.ShipWeight, 
				CartTotal = Cart.CartTotals.ShipSubtotal) />
				<!---<cfset cwDebugger(Cart)>--->
			<cfset Client.ShipTotal = getShippingRates(Mode = "Calculate", 
				ShipToCountryID = Client.ShipToCountryID,
				CartWeight = Cart.CartTotals.ShipWeight,
				CartTotal = Cart.CartTotals.ShipSubtotal) />
			<cfset Cart.CartTotals.Shipping = Client.ShipTotal />
			<cfif shippingDiscounts NEQ "">	
				<!--- There is a shipping discount --->
				<cfset tempShipping = cwGetShippingDiscount(Cart.CartTotals.Shipping, shippingDiscounts, Client.ShipPref, Cart.CartTotals.ProductTotal)>
				<cfset Cart.CartTotals.Shipping = tempShipping>
				<cfset Cart.CartTotals.ShippingDiscounts = Client.ShipTotal - tempShipping>
			</cfif>
			<cfif ChargeTaxOnShipping>
				<cfset Cart.CartTotals.ShippingTax = cwGetShippingTaxes(Client.TaxCountryID, Client.ShipTotal, Cart, Client.TaxStateID)>
			</cfif>
			<cfset Cart.CartTotals.Total = Cart.CartTotals.ProductTotal + Cart.CartTotals.Shipping + Cart.CartTotals.ShippingTax />
			<cfset Client.OrderTotal = Cart.CartTotals.Total>
            <cfset Client.TaxAmt = Cart.CartTotals.Tax>
		</cfif>
		<!--- End Client.CheckingOut EQ "YES" --->
	</cfif>
	<!--- End rsGetCart.RecordCount EQ 0 --->

	<!--- If the "PLACE ORDER" button has been clicked... --->
	<!--- START [ PROCESS ORDER ] =================================================== --->
	<cfif FORM.action EQ "placeorder">
		<!--- Process order --->
		<cfmodule template="CWTags/CWTagProcessOrder.cfm" Cart="#Cart#">
	</cfif>
	<!--- END [ PROCESS ORDER ] =============================++====================== --->

	<cfif FORM.action NEQ "" AND Request.FieldErrorText EQ "">
		<cflocation url="#request.targetGoToCart#&result=#request.qtyadded#&stockalert=#URL.Stockalert#&returnurl=#URLEncodedFormat(request.ThisPageQS)#" addtoken="no">
	</cfif>

<cfelse>
	<cfset HasCart = False>
</cfif>
<!--- END isDefined("Client.CartID") --->
</cfsilent>
<cfprocessingdirective suppresswhitespace="yes">
<script type="text/javascript">
var allOn = true;
function SelectAll(MyForm,MyBox){
var countBoxes = eval("document."+MyForm+"."+MyBox+".length");
	if(!countBoxes){
		eval("document."+MyForm+"."+MyBox+".checked =  allOn");
	}
	else{
		for (var i=0; i<countBoxes ;i++){
			eval("document."+MyForm+"."+MyBox+"[i].checked =  allOn");
		}
	}
allOn = !allOn;
}

function cleanField(obj){
	obj.value = obj.value.replace(/[^\d]/g,"");
	if(obj.value.length == 0 || obj.value == 0){obj.value=1}
}
</script>
<!--- Check for the existance of a Client.CardID --->
	<!---  [ START ] ==	ERROR ALERTS and CONFIRMATION NOTICE =========================  ---> 
	<cfparam name="URL.result" default="0">
	<cfparam name="URL.stockalert" default="No">
	<cfparam name="request.FieldError" default="">
	<cfparam name="request.QtyAdded" default="#URL.result#">
	<cfif request.FieldError NEQ ""> 
		<!--- If fields were left blank or in correct data entered, show "Field Alert" ---> 
		<p><span class="errorMessage"><cfoutput>#request.FieldError#</cfoutput></span></p> 
	</cfif>
	<cfif request.QtyAdded NEQ 0 AND request.FieldError EQ ""> 
		<cfoutput> 
			<p><strong>Your shopping cart has been successfully updated.</strong></p> 
		</cfoutput> 
	</cfif> 
	<!--- Not enough stock alert ---> 
	<cfif URL.StockAlert EQ "Yes"> 
		<p class="errorMessage">You have selected more quantity than is currently available.</p>
	</cfif> 
 <cfif HasCart NEQ True> 
	<p>There is nothing in your Cart at this time.</p> 
	<cfelse> 
	<cfif Client.CheckingOut EQ "YES"> 
		 <!--- Error Outputting ---> 
		 <cfif request.FieldErrorText NEQ ""> 
			<p class="errorMessage">There was a problem while processing your credit card.<br /> 
				 <cfoutput>#request.FieldErrorText#</cfoutput></p> 
		</cfif> 
		 <cfif Request.TransactionMessage NEQ ""> 
			<p class="errorMessage">Your Credit Card Transaction Has Failed.<br /> 
				 Gateway Message: <span class="errorMessage"><cfoutput>#request.TransactionMessage#</cfoutput></span></p> 
		</cfif> 
		 <p class="smallprint"> [<a href="<cfoutput>#request.targetCheckOut#</cfoutput>&amp;logout=yes"> Your
		 		name is not <cfoutput>#rsGetCustData.cst_FirstName#</cfoutput> <cfoutput>#rsGetCustData.cst_LastName#</cfoutput>? Click Here. </a>] </p> 
		 <table class="tabularData"> 
			<cfif ShowShippingInfo><tr> 
				 <th align="right">&nbsp;</th> 
				 <th>Billing</th>
				 <th>Shipping</th>
			 </tr></cfif> 
			<tr> 
				 <th align="right">Name</th> 
				 <td><cfoutput>#rsGetCustData.cst_FirstName# #rsGetCustData.cst_LastName#</cfoutput></td> 
				 <cfif ShowShippingInfo><td valign="top"><cfoutput>#rsGetCustData.cst_ShpName#</cfoutput></td></cfif>
			</tr> 
			<tr valign="top"> 
				<th align="right">Address:</th> 
				<td> <cfoutput>#rsGetCustData.cst_Address1#<br /> 
						 <cfif rsGetCustData.cst_Address2 NEQ ""> 
							#rsGetCustData.cst_Address2#<br /> 
						</cfif> 
						 #rsGetCustData.cst_City#<cfif rsGetBillTo.stprv_Name NEQ "None">, #rsGetBillTo.stprv_Name#</cfif> #rsGetCustData.cst_Zip#
						 <br />#rsGetBillTo.country_name#</cfoutput></td> 
				<cfif ShowShippingInfo><td> <cfoutput>#rsGetCustData.cst_ShpAddress1#<br /> 
					 <cfif rsGetCustData.cst_ShpAddress2 NEQ ""> 
						#rsGetCustData.cst_ShpAddress2#<br /> 
					</cfif> 
					 #rsGetCustData.cst_ShpCity#<cfif rsGetShipTo.stprv_Name NEQ "None">, #rsGetShipTo.stprv_Name#</cfif> #rsGetCustData.cst_ShpZip#
					 <br />#rsGetShipTo.country_name#</cfoutput></td></cfif>
			</tr> 
			<tr> 
				 <th align="right">Phone</th> 
				 <td><cfoutput>#rsGetCustData.cst_Phone#</cfoutput></td> 
				 <cfif ShowShippingInfo><td>&nbsp;</td></cfif>
			</tr> 
			<tr> 
				 <th align="right">Email:</th> 
				 <td><cfoutput>#rsGetCustData.cst_Email#</cfoutput></td> 
				 <cfif ShowShippingInfo><td>&nbsp;</td></cfif>
			</tr> 
		</table> 
		 <p>If address is incorrect - <a href="<cfoutput>#request.targetCheckOut#</cfoutput>"> <strong>Return
		 			to Order Form</strong></a> </p> 
	 </cfif> 
	<!--- End Client.CheckingOut EQ "YES" ---> 
	<form name="updatecart" action="<cfoutput>#request.ThisPage#</cfoutput>" method="post"> 
		<input type="hidden" name="productCount" value="<cfoutput>#ArrayLen(Cart.Products)#</cfoutput>">
		 <table class="tabularData"> 
			<tr> 
				<th>Name</th> 
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
				<th align="center">Remove<br /> 
				<a href="javascript:SelectAll('updatecart','remove');">Select All</a></th> 
			</tr> 
			<!--- Set a counter for the row colors. Can't use CurrentRow since we're grouping ---> 
			<cfoutput>
			<cfloop from="1" to="#ArrayLen(Cart.Products)#" index="lineNumber">
				<!--- Set the current product to a variable for easier reference --->
				<cfset Product = Cart.Products[lineNumber] />
				<tr valign="top" class="#cwAltRows(lineNumber)#"> 
					<td><cfif application.ShowImageInCart>					
						<cfset ImageTag = cwDisplayImage(Product.ID, 4, Product.Name, "")>
						<cfif ImageTag NEQ "">
						<div style="float: left; margin-right: 1em; border: 1px solid ##000;">#ImageTag#</div>
						</cfif>
					</cfif><input name="skuid#lineNumber#" type="hidden" value="#Product.SKUID#"> 
					#Product.Name# (#Product.MerchSKUID#)
					<!--- Output sku options ---> 
					<cfloop from="1" to="#ArrayLen(Product.Options)#" index="optionNumber">
					<br /> 
					<strong style="margin-left: 10px;">#Product.Options[optionNumber].Name#:</strong> #Product.Options[optionNumber].Value# 
					</cfloop>
					</td>
					<cfif Product.DiscountAmount NEQ 0>
					<td align="right"><cfif DisplayLineItemDiscount>
					#LSCurrencyFormat(Product.Price,'local')#
					<cfelse>
					#cwDisplayOldPrice(LSCurrencyFormat(Product.Price), Product.Discount.DiscountID) & 
								LSCurrencyFormat(cwGetNewPrice(Product.Discount,Product.Price,Product.Quantity),'local')#</cfif>
					</td> 
					<cfelse>
					<td align="right">#LSCurrencyFormat(Product.Price,'local')#</td> 
					</cfif>
					<td align="center"><input name="qty#lineNumber#" type="text" value="#Product.Quantity#" size="3" onBlur="cleanField(this)"> 
					<input name="qty_now#lineNumber#" type="hidden" value="#Product.Quantity#"></td>
					<cfif DisplayLineItemDiscount>
					<td align="right"><cfif Product.DiscountAmount NEQ 0>#cwDisplayDiscountAmount(LSCurrencyFormat(Product.DiscountAmount * Product.Quantity,'local'),Product.Discount.DiscountID)#</cfif></td> 
					</cfif>
					<cfif DisplayLineItemTaxes>
						<td align="right">#LSCurrencyFormat(Product.SubTotal,'local')#</td>
						<td align="right">#LSCurrencyFormat(Product.Tax,'local')#</td>
						<td align="right">#LSCurrencyFormat(Product.Total,'local')#</td> 
					<cfelse>
						<td align="right">#LSCurrencyFormat(Product.SubTotal,'local')#</td> 
					</cfif>
					<td align="center"> <input name="remove" type="checkbox" class="formCheckbox" value="#Product.SKUID#"> </td> 
				</tr> 
			</cfloop>
			</cfoutput>
			<tr> 
				 <td colspan="<cfoutput>#CartColumnCount+4#</cfoutput>" align="center">&nbsp;</td>
				 <td align="center"> <input name="update" type="submit" class="formButton" id="update" value="Update" /> 
					<input name="action" type="hidden" id="action" value="update"> </td> 
			</tr> 
			<tr> 
				<th colspan="3" align="right">Subtotal:&nbsp;</th>
				<cfif DisplayLineItemDiscount>
					<td align="right"><cfif Cart.CartTotals.Discounts NEQ 0><cfoutput>#LSCurrencyFormat(Cart.CartTotals.Discounts, "local")#</cfoutput></cfif></td>
				</cfif>
				<cfif DisplayLineItemTaxes>
					<td align="right"><cfoutput>#LSCurrencyFormat(Cart.CartTotals.Sub, "local")#</cfoutput></td>
					<td align="right"><cfoutput>#LSCurrencyFormat(Cart.CartTotals.Tax, "local")#</cfoutput></td>
					<td align="right"><cfoutput>#LSCurrencyFormat(Cart.CartTotals.ProductTotal, "local")#</cfoutput></td> 
				<cfelse>
					<td align="right"><cfoutput>#LSCurrencyFormat(Cart.CartTotals.Sub, "local")#</cfoutput></td>
				</cfif>
				<td>&nbsp;</td> 
			 </tr> 
			<!--- If Checking out show Tax, Shipping and Total ---> 
			<cfif Client.CheckingOut EQ "YES"> 
				<cfif NOT DisplayLineItemTaxes>
				 <!--- Display Tax ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ---> 
				 <tr> 
					<th colspan="3" align="right">Tax:&nbsp;<!---<cfif rsGetBillTo.stprv_Tax NEQ 0>(inc. <cfoutput>#rsGetBillTo.stprv_Code#</cfoutput> tax)</cfif>---></th> 
					<td align="right"<cfif DisplayLineItemDiscount> colspan="2"</cfif>><cfoutput>#LSCurrencyFormat(Cart.CartTotals.Tax,'local')#</cfoutput></td> 
					<td>&nbsp;</td> 
				</tr> 
				</cfif>
				<!--- Display Shipping ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ---> 
				<cfif application.EnableShipping EQ 1>
				 <tr> 
					<th colspan="3" align="right" valign="top"> Ship By: 
					<!--- 	If more than one shipping option is available, allow user to select a method ---> 
					<cfif rsGetShipMethods.RecordCount NEQ 0> 
						 <cfif rsGetShipMethods.RecordCount GT 1> 
							<select name="PickShipPref"> 
								 <option value="0" selected="selected">Shipping Method</option> 
								 <cfoutput query="rsGetShipMethods"> 
									<cfif Client.ShipPref EQ rsGetShipMethods.shipmeth_ID> 
										 <option value="#shipmeth_ID#" selected="selected">#shipmeth_Name#</option> 
										 <cfelse> 
										 <option value="#shipmeth_ID#">#shipmeth_Name#</option> 
									 </cfif> 
								</cfoutput> 
							 </select> 
							<br /> 
							<input name="Submit" type="submit" value="Calculate Shipping" style="margin-top: 3px;" class="formButton"> 
						<cfelse>
							<cfoutput>#rsGetShipMethods.shipmeth_Name#</cfoutput>
						</cfif>
					</cfif></th>
					<!--- If showing line item discounts, show shipping discount in cell --->
					<cfif displayLineItemDiscount>
					<td align="right" valign="top">&nbsp;<cfif Cart.CartTotals.ShippingDiscounts NEQ 0><cfoutput>#LSCurrencyFormat(Cart.CartTotals.ShippingDiscounts,'local')#</cfoutput></cfif></td>
					</cfif>
					<!--- If showing line item discounts, show shipping taxes and subtotals in cells --->
					<cfif displayLineItemTaxes>
					<td align="right" valign="top"><cfoutput><cfif DisplayLineItemDiscount>
					#LSCurrencyFormat(Client.ShipTotal,'local')#
					<cfelse>
						<cfif Cart.CartTotals.ShippingDiscounts NEQ 0>
					#cwDisplayOldPrice(LSCurrencyFormat(Client.ShipTotal), request.shippingDiscount) & 
								LSCurrencyFormat(Client.ShipTotal - Cart.CartTotals.ShippingDiscounts,'local')#
						<cfelse>
							#LSCurrencyFormat(Client.ShipTotal,'local')#
						</cfif></cfif></cfoutput></td>
					<td align="right" valign="top">&nbsp;<cfif Cart.CartTotals.ShippingTax NEQ 0><cfoutput>#LSCurrencyFormat(Cart.CartTotals.ShippingTax,'local')#</cfoutput></cfif></td>
					<td align="right" valign="top"><cfoutput>#LSCurrencyFormat(Cart.CartTotals.ShippingTax + Cart.CartTotals.Shipping,'local')#</cfoutput></td>
					<cfelse>
					<td align="right" valign="top">
					<cfif Cart.CartTotals.ShippingDiscounts NEQ 0>
						<cfoutput>#cwDisplayOldPrice(LSCurrencyFormat(Client.ShipTotal,'local'), request.shippingDiscount)#</cfoutput>
					<cfelse>
						<cfoutput>#LSCurrencyFormat(Cart.CartTotals.Shipping,'local')#</cfoutput>					
					</cfif>
					</td>
					</cfif>
					<td>&nbsp;</td> 
				</tr>
				<!--- Line item taxes not shown, so display shipping tax if necessary on separate line --->
				<cfif Cart.CartTotals.ShippingTax NEQ 0 AND NOT displayLineItemTaxes>
				<tr>
					<th colspan="3" align="right" valign="top">Shipping Tax:</th>
					<td align="right" valign="top" colspan="<cfoutput>#CartColumnCount+1#</cfoutput>"><cfoutput>#LSCurrencyFormat(Cart.CartTotals.ShippingTax,'local')#</cfoutput></td>
					<td>&nbsp;</td>
				</tr>
				</cfif>
			</cfif>
				 <!--- Display ORDER TOTAL ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ---> 
				 <tr> 
					<th colspan="3" align="right">Order Total:&nbsp;</th> 
					<td align="right" colspan="<cfoutput>#CartColumnCount+1#</cfoutput>"><cfoutput>#LSCurrencyFormat(Cart.CartTotals.Total,'local')#</cfoutput></td> 
					<td align="center">&nbsp;</td> 
				</tr> 
			 </cfif> 
			<!--- END IF - CheckingOut EQ "YES" ---> 
		</table> 
	 </form> 
	<!--- End of presentation table ---> 
	<!--- show discount information --->
	 <cfif application.enableDiscounts EQ true>
		<form name="discounts" action="<cfoutput>#request.ThisPageQS#</cfoutput>" method="post">
		<p>If you have a promotional code, enter it now: </p>
		<input type="text" name="promoCode" value="" /><input type="submit" name="submitpromo" value="Apply Code" class="formButton"/>
		<cfif IsDefined("session.promotionalcode") AND session.promotionalcode NEQ "">
		<p><cfif request.promocodeApplied>Applying promo code <cfoutput>#session.promotionalcode#</cfoutput>
		<cfelse>
		Promo code <cfoutput>#session.promotionalcode#</cfoutput> not found.
		<cfset session.promotionalcode = "">
		</cfif></p>
		</cfif>
		<cfif Cart.CartTotals.Discounts NEQ 0>
		<cfset cwDisplayDiscountDescriptions()>
		<p>Savings of <cfoutput>#LSCurrencyFormat(Cart.CartTotals.Discounts + Cart.CartTotals.ShippingDiscounts)#</cfoutput></p>
		</cfif>
		</form>
	 </cfif>
	<cfif Client.CheckingOut NEQ "YES"> 
		 <form action="<cfoutput>#request.targetCheckOut#</cfoutput>" method="post"> 
			<input name="checkout" type="submit" id="checkout" value="Checkout" class="formButton"> 
		</form> 
		 <cfif IsDefined('url.returnurl')> 
			<p><a href="<cfoutput>#URLDecode(url.returnurl)#</cfoutput>">Continue Shopping</a></p> 
		</cfif> 
		 <cfelse>
		
		 <!--- If Checking out, show credit card input form or Processor information---> 
		 <form action="<cfoutput>#request.ThisPage#</cfoutput>" method="post" name="PlaceOrder"> 
			<cfif request.PaymentAuthType EQ "Gateway"> 
				 <!--- get Credit Cards for form field ---> 
				 <cfquery name="rsGetCCards" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
 				SELECT ccard_Name, ccard_Code 
				FROM tbl_list_ccards 
				WHERE ccard_Archive	= 0 ORDER BY ccard_Name
				</cfquery> 
				 <p>Enter your credit card details to complete your order.</p> 
				 <!--- Output any error messages from credit card input ---> 
				 <cfif request.FieldErrorText NEQ ""> 
					<span class="errorMessage"><cfoutput>#request.FieldErrorText#</cfoutput></span> 
				</cfif> 
				 <table class="tabularData"> 
					<tr> 
						 <th colspan="2">Credit Card Data</th> 
					 </tr> 
					<tr class="altRowOdd" > 
						 <td align="right"> <cfif IsDefined ('request.FieldErrorCHN')> 
								 <span class="errorMessage">Card Holder Name</span> 
								 <cfelse> 
								 Card Holder Name
							 </cfif> </td> 
						 <td> <input name="cstCCardHolderName" type="text" value="<cfoutput>#FORM.cstCCardHolderName#</cfoutput>"> 
							* </td> 
					 </tr> 
					<tr class="altRowEven" > 
						 <td align="right"> <cfif IsDefined ('request.FieldErrorCT')> 
								 <span class="errorMessage">Card Type</span> 
								 <cfelse> 
								 Card Type
							 </cfif> </td> 
						 <td> <select name="cstCCardType"> 
								 <option value="forgot" selected="selected">Choose Credit Card</option> 
								 <cfoutput query="rsGetCCards"> 
									<option value="#rsGetCCards.ccard_Code#"<cfif FORM.cstCCardType EQ rsGetCCards.ccard_Code> selected</cfif>>#rsGetCCards.ccard_Name#</option> 
								</cfoutput> 
							 </select> 
							* </td> 
					 </tr> 
					<tr class="altRowOdd" > 
						 <td align="right"> <cfif IsDefined ('request.FieldErrorCN')> 
								 <span class="errorMessage">Card Number</span> 
								 <cfelse> 
								 Card Number
							 </cfif> 
							<br /> </td> 
						 <td> <input type="text" name="cstCCNumber" value="<cfoutput>#FORM.cstCCNumber#</cfoutput>"> 
							*</td> 
					 </tr> 
					<tr class="altRowEven" > 
						 <td align="right"> <cfif IsDefined ('request.FieldErrorCY') OR IsDefined ('request.FieldErrorCM')> 
								 <span class="errorMessage">Expiration Date</span> 
								 <cfelse> 
								 Expiration Date
							 </cfif> </td> 
						 <td> <select name="cstExprMonth" id="cst_ExprMonth"> 
								 <option value="forgot">--</option> 
								 <cfloop index="MonthValue" from="01" to="12"> 
									<option<cfif FORM.cstExprMonth EQ MonthValue> selected</cfif>><cfoutput>#NumberFormat(MonthValue,"09")#</cfoutput></option> 
								</cfloop> 
							 </select> 
							/
							<select name="cstExprYr" id="cst_ExprYr"> 
								 <option value="forgot">--</option> 
								 <cfloop index="YearValue" from="#DateFormat(Now(),'yyyy')#" to="#DateFormat(DateAdd('yyyy',6,Now()),'yyyy')#"> 
									<option<cfif FORM.cstExprYr EQ YearValue> selected="selected"</cfif> value="<cfoutput>#Right(YearValue,2)#</cfoutput>"><cfoutput>#YearValue#</cfoutput></option> 
								</cfloop> 
							 </select> 
							* </td> 
					 </tr> 
					<tr class="altRowEven" > 
						 <td align="right" valign="top"><cfif IsDefined ('request.FieldErrorCCV')> 
								 <span class="errorMessage">CCV Code</span> 
								 <cfelse> 
								 CCV Code
							 </cfif></td> 
						 <td><p> 
								 <input name="cstCCV" type="text" value="<cfoutput>#FORM.cstCCV#</cfoutput>" size="4" maxlength="4"> 
								 <br /> 
								<span class="smallprint">This is the 3 digit number<br /> 
								that appears on the reverse side of your <br /> 
								credit card (where your signature appears).<br /> 
								Amex cards only - the 4 digit number on <br /> 
								the front of your card.</span><br /> 
								 <br /> 
								 <img src="cw3/assets/cards/ccv.gif" width="135" height="86"></p></td> 
					 </tr> 
				</table> 
				 <cfelseif request.PaymentAuthType EQ "Processor"> 
				 <p>Once you click Place Order below you will receive an order number. On
				 	the next page you will need to process your payment through our third party
				 	payment processor before your order will be shipped. </p> 
			 </cfif> 
			<cfif Client.ShipPref EQ 0 AND application.enableshipping EQ 1>
				<p>You must choose a shipping method to complete your order</p>
				<cfelse>
				<input name="placeorder" type="submit" class="formButton" value="Place Order">
				<input name="action" type="hidden" value="placeorder">
			</cfif> 
			<input type="hidden" name="PickShipPref" value="<cfoutput>#Client.ShipPref#</cfoutput>">
		 </form> 
	 </cfif> 
</cfif> 
<!--- END IF - NOT IsDefined ('Client.CartID') --->
</cfprocessingdirective> 
