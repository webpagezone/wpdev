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
Name: CWIncTaxes
Description: 
	Calculates taxes for the user's current cart contents.

Attributes:
	CalcType: Determines the type of calculation to perform.
		Cart
		Product
		Shipping
	
	LocationID: The location to base tax calculations on

Returns:
	A numeric value representing the amount of taxes to be charged
================================================================
--->

<cffunction name="cwGetCartTaxes">
	<cfargument name="LocationID" type="numeric" required="true" />
	<cfset var TaxAmount = 0 />
	<cfset var rsCartContents = "" />

	<!--- Calculate taxes for the entire cart, excluding shipping --->
	<!--- Retrieve the cart contents 
	<cfquery name="rsCartContents">
	SELECT from tbl_cart, and join to Products for pricing, and join to TaxGroup and TaxRate tables
	tax information and do calculation locally.
	</cfquery>--->
	
	<!--- Loop through the cart contents and calculate the taxes for each product --->
	<cfloop query="rsCartContents">
		<cfset TaxAmount = TaxAmount + cwCalculateTax((rsCartContents.ProductPrice * rsCartContents.Qty), rsCartContents.TaxRate) />
	</cfloop>
	
	<cfreturn TaxAmount />
</cffunction>

<cffunction name="cwGetProductTax">
	<cfargument name="LocationID" type="numeric" required="true" />
	<cfargument name="ProductID" type="numeric" required="true" />
	<cfset var TaxAmount = 0 />
	<cfset var rsProductTax = "" />

	<!--- Get the product tax information, including current tax rate and tax type 
	<cfquery name="rsProduct">
	SELECT from Products and Join to TaxGroup and TaxRate tables	
	</cfquery>--->
		
	<cfreturn cwCalculateTax(rsProduct.ProductPrice, rsProduct.TaxRate) />
</cffunction>

<cffunction name="cwGetShippingTaxes">
	<cfargument name="LocationID" type="numeric" required="true" />
	<cfargument name="ShippingTotal" type="numeric" required="true" />
	<cfset var TaxAmount = 0 />
	<cfset var rsShipTax = "" />
	<cfset var rsMaxTax = "" />
	
	<!---<cfquery name="rsShipTax">
	SELECT from shipping options to determine if taxes should be charged to shipping
	</cfquery>--->
	
	<cfif ChargeTaxOnShipping>
		<!--- Determine method of charging tax to shipping --->
		<cfif rsShipTax.ShipTaxMethod EQ "Highest Item Taxed">
			<!--- Charge tax based on the highest taxed item currently in the cart --->
			
			<!--- Query the cart to find the highest taxed item using the Max function 
			<cfquery name="rsMaxTax">
			</cfquery>--->
			
			<cfset TaxAmount = cwCalculateTax(ShippingTotal, rsMaxTax.Rate) />

		<cfelseif rsShipTax.ShipTaxMethod NEQ "No Tax">
			<!--- The tax rate is set to a specific tax group --->
			<cfset TaxAmount = cwCalculateTax(ShippingTotal, rsShipTax.Rate) />

		<cfelse>
			<!--- The user selected "No Tax", do nothing since the TaxAmount is already set to 0 ... --->
			<cfset TaxAmount = 0 />
		</cfif>
	</cfif>
	
	<cfreturn TaxAmount />
</cffunction>

<cffunction name="cwCalculateTax">
	<cfargument name="Cost" type="numeric" required="true" hint="The cost that tax should be calculated against." />
	<cfargument name="TaxRate" type="numeric" required="true" hint="This should be a tax rate not already divided by 100. For 25%, pass in 25, not .25." />
	
	<cfreturn Cost * (TaxRate/100) />
</cffunction>

</cfsilent>
