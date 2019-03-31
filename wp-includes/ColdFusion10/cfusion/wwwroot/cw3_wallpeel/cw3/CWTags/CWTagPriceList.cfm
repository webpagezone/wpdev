<cfsilent>
<!--- 
================================================================
Application Info: Cartweaver© 2002 - 2007, All Rights Reserved.
Developer Info: Application Dynamics Inc.
                1560 NE 10th
                East Wenatchee, WA 98802
Support Info: http://www.cartweaver.com/go/cfhelp
				
Cartweaver Version: 3.0.13 -  Date: 7/25/2008
================================================================
Name:  CWTagPriceList.cfm
Description: This file gets and displays product pricing based 
on the number of SKU and Product options related to the product. 
It is called by the CWIncDetails.cfm file using the cfmodule tag.

The custom tag takes 5 arguments.
product_id: The product ID to display.
	product_id = "#request.Product_ID#"
TaxRate: Tax struct from custom function
CurrentRecord: Current row number in results page
ShowMax: flag to show max price along with min price
PriceFormat: string with replaceable masks for price parts

Price format string new in 3.0.9 to format price on results and details page for taxable items
	Attributes.PriceFormat in this format:
		@@beforeDiscountPrice@@
		@@currentPrice@@
		@@tax@@
		@@priceWithTax@@
		@@taxAmount@@
		
		for example,
		@@beforeDiscountPrice@@ @@currentPrice@@ (@@priceWithTax@@ including @@tax@@% tax)
		@@beforeDiscountPrice@@ @@priceWithTax@@ (@@currentPrice@@ + @@taxAmount@@ VAT)
		
Use in combination with $Attributes.ShowMax. By default, minimum and maximum price of product are shown ($1.00 - $5.00)
Set to false to show only the minimum price. Then, $Attributes.PriceFormat can be used to format the price like this:

Prices starting at $1.00  (format string would look like this:  "Prices starting at @@currentPrice@@"
================================================================
--->

<cfparam name="Attributes.Product_ID" default="0" />
<cfparam name="Attributes.TaxRate" default="" />
<cfparam name="Attributes.CurrentRecord" default="" />
<cfparam name="Attributes.ShowMax" default="true" />
<cfparam name="Attributes.priceFormat" default="@@beforeDiscountPrice@@ @@priceWithTax@@ (@@currentPrice@@ + @@taxAmount@@ VAT)" />

<cfif Not IsDefined("cwAltRows") OR Not IsCustomFunction(cwAltRows)>
	<cfinclude template="CWIncFunctions.cfm" />
</cfif>
<cfif Not IsDefined("cwGetDiscountObject") OR Not IsCustomFunction(cwGetDiscountObject)>
	<cfinclude template="CWIncDiscountFunctions.cfm">
</cfif>
</cfsilent>
<cfprocessingdirective suppresswhitespace="yes">
<cfsilent>
	<!---  Set default Product ID Variable  ---> 
	<cfparam name="attributes.Product_ID" default="0"> 
	<cfquery name="rsPricing" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
	SELECT Min(SKU_Price) AS minPrice, Max(SKU_Price) AS maxPrice 
	FROM tbl_skus
	WHERE SKU_ProductID = <cfqueryparam cfsqltype="cf_sql_integer" value="#Attributes.Product_ID#" />
	AND SKU_ShowWeb = 1
	<cfif application.AllowBackOrders EQ "no">
		AND SKU_Stock > 0
	</cfif>
	</cfquery>
	
	<cfset PriceList = "">
	<!--- get discount information currently available --->
	<cfset discount = cwGetDiscountObject()>
	<cfset cwGetDiscounts()>
	<cfif ListLen(session.availableDiscounts) GT 0>
		<cfset discount = cwGetDiscountProduct(Attributes.Product_ID)>
	</cfif>
	<cfset request.showDiscount = false>
	
	<cfif rsPricing.RecordCount NEQ 0>
		<cfset newPrice = decimalRound(cwGetNewPrice(discount,rsPricing.minPrice))>
		<cfset newMaxPrice = decimalRound(cwGetNewPrice(discount,rsPricing.maxPrice))>
		<cfset oldPrice = decimalRound(rsPricing.minPrice)>
		<cfset oldMaxPrice = decimalRound(rsPricing.maxPrice)>
		
		<cfif newPrice NEQ oldPrice>
			<cfset request.showDiscount = true>
		</cfif>
		
		<cfset currentPrice = "">
		<cfset tax = "">
		<cfset priceWithTax = "">
		<cfscript>
		if(IsStruct(Attributes.TaxRate) AND Attributes.TaxRate.CalcTax NEQ 0) {				
			// Set up variables
			// Price with tax
			minWithTax = oldPrice * Attributes.TaxRate.CalcTax;
			maxWithTax = oldMaxPrice * Attributes.TaxRate.CalcTax;
			// Discounted price with tax
			minWithTaxNew = newPrice * Attributes.TaxRate.CalcTax;
			maxWithTaxNew = newMaxPrice * Attributes.TaxRate.CalcTax;
			// Tax amounts
			minTax = oldPrice * Attributes.TaxRate.CalcTax - oldPrice;
			maxTax = oldMaxPrice * Attributes.TaxRate.CalcTax - oldMaxPrice;
			// Tax amounts after discount
			minTaxNew = newPrice * Attributes.TaxRate.CalcTax - newPrice;
			maxTaxNew = newMaxPrice * Attributes.TaxRate.CalcTax - newMaxPrice;

			tax = Attributes.TaxRate.DisplayTax;
			
			// Show old minimum price
			currentPrice =  LSCurrencyFormat(oldPrice);
			// Show range to maximum price
			if (Attributes.ShowMax EQ true And oldPrice NEQ oldMaxPrice) {
				currentPrice = currentPrice & " - " & LSCurrencyFormat(oldMaxPrice);
			}
			// price with tax
			priceWithTax = LSCurrencyFormat(minWithTax);
			if (Attributes.ShowMax EQ true  And oldPrice NEQ  oldMaxPrice) {
				priceWithTax = priceWithTax & " - " & LSCurrencyFormat(maxWithTax);
			}
			// Tax amount
			taxAmount = LSCurrencyFormat(minTax);
			if (Attributes.ShowMax EQ true  And oldPrice NEQ  oldMaxPrice) {
				taxAmount = taxAmount & " - " & LSCurrencyFormat(maxTax);
			}
			
			// If discount is shown, put a strikethru through the entire old price defined above, and create a new price
			if(request.showDiscount) {
				PriceList = ReplaceNoCase(Attributes.PriceFormat, "@@currentPrice@@", currentPrice, "all");
				PriceList = ReplaceNoCase(PriceList, "@@priceWithTax@@", priceWithTax, "all");
				PriceList = ReplaceNoCase(PriceList, "@@tax@@", tax, "all");
				PriceList = ReplaceNoCase(PriceList, "@@taxAmount@@", taxAmount, "all");
				PriceList = ReplaceNoCase(PriceList, "@@beforeDiscountPrice@@", "", "all");
				
				beforeDiscountPrice =  cwDisplayOldPrice(PriceList, discount.discountid);
				PriceList = ReplaceNoCase(Attributes.PriceFormat, "@@beforeDiscountPrice@@", beforeDiscountPrice, "all");
				
				// Show new price
				currentPrice = LSCurrencyFormat(newPrice);
				// Show new range to max price
				if (Attributes.ShowMax EQ true  AND newPrice NEQ  newMaxPrice) {
					currentPrice = currentPrice & " - " & LSCurrencyFormat(newMaxPrice);
				}
				// price with tax
				priceWithTax = LSCurrencyFormat(minWithTaxNew);
				if (Attributes.ShowMax EQ true  AND oldPrice NEQ oldMaxPrice) {
					priceWithTax = priceWithTax & " - " & LSCurrencyFormat(maxWithTaxNew);
				}
				// Tax amount
				taxAmount = LSCurrencyFormat(minTaxNew);
				if (Attributes.ShowMax EQ true  AND oldPrice NEQ  oldMaxPrice) {
					taxAmount = taxAmount & " - " & LSCurrencyFormat(maxTaxNew);
				}
				PriceList = ReplaceNoCase(PriceList, "@@currentPrice@@", currentPrice, "all");
				PriceList = ReplaceNoCase(PriceList, "@@priceWithTax@@", priceWithTax, "all");
				PriceList = ReplaceNoCase(PriceList, "@@tax@@", tax, "all");
				PriceList = ReplaceNoCase(PriceList, "@@taxAmount@@", taxAmount, "all");
			} /* END if */
		}else{
			// Show old minimum price
			PriceList =  LSCurrencyFormat(oldPrice);
			// Show range to maximum price
			if (Attributes.ShowMax EQ true  AND oldPrice NEQ oldMaxPrice) {
				PriceList = PriceList & " - " & LSCurrencyFormat(oldMaxPrice);
			}
			if(Request.showDiscount) {
				PriceList =  cwDisplayOldPrice(PriceList, discount.discountid);
				PriceList = PriceList & LSCurrencyFormat(newPrice);
				if (Attributes.ShowMax AND oldPrice NEQ oldMaxPrice) {
					PriceList = PriceList & " - " & LSCurrencyFormat(newMaxPrice);
				}
			} /* END if(_REQUEST["showDiscount"]) */
		} /* END if(IsStruct(Attributes.TaxRate) AND Attributes.TaxRate.CalcTax NEQ 0) {	 */
	
			</cfscript>
		<cfelse>
			<cfset PriceList = "Out of stock..." >
		</cfif>
		<cfif NOT IsDefined("PriceList") OR PriceList EQ "">
			<cfset PriceList = Replace(attributes.priceFormat, "@@currentPrice@@", currentPrice, "all") />
			<cfset PriceList = Replace(PriceList, "@@priceWithTax@@", priceWithTax, "all") />
			<cfset PriceList = Replace(PriceList, "@@tax@@", tax, "all") />
			<cfset PriceList = Replace(PriceList, "@@taxAmount@@", taxAmount, "all") />
			<cfset PriceList = Replace(PriceList, "@@beforeDiscountPrice@@", "", "all") />
		</cfif>
	</cfsilent>	
<cfoutput><strong>Price: </strong><span id="divPrice#Attributes.CurrentRecord#">#PriceList#</span></cfoutput>
</cfprocessingdirective> 