<cfsilent>
<!---
================================================================
Application Info: Cartweaver 2002 - 2007, All Rights Reserved.
Developer Info: Application Dynamics Inc.
                1560 NE 10th
                East Wenatchee, WA 98802
Support Info: http://www.cartweaver.com/go/cfhelp
    
Cartweaver Version: 3.0.13  -  Date: 7/25/2008
================================================================
Name: CWIncFunctions
================================================================
--->

<cffunction name="cwAltRows">
	<cfargument name="RowNumber" type="numeric" required="true" />
	<cfif RowNumber MOD 2>
		<cfreturn "altRowOdd" />
	<cfelse>
		<cfreturn "altRowEven" />
	</cfif>
</cffunction>

<cffunction name="cwKeepURL">
	<cfargument name="strStripValues" required="true" />
<!------------------------------------------------------------------------
	DESCRIPTION: This function returns a querystring with the URL values 
	 passed to the function stripped from the querystring. Use this to 
	 maintain querystring values through paging, while removing those 
	 values responsible for the paging itself.
	
	'ARGUMENTS	
	strStripValues: A comma separated string containing the names of all 
	 values that should be removed from the querystring.
	
	RETURNS
	A string with the supplied values removed from the querystring.
	--->
	
	<cfset var retVal = "" />
	<cfloop collection="#URL#" item="qsItem">
		<cfif NOT ListFindNoCase(strStripValues, qsItem)>
			<cfoutput>#qsItem#<br /></cfoutput>
			<!--- Add the querystring item to the return value --->
			<cfset retVal = ListAppend(retVal, LCase(qsItem) & "=" & URL[qsItem], "&") />
		</cfif>
	</cfloop>
	<cfreturn retVal />
</cffunction>

<!----------------------------------------------------------------------
	DESCRIPTION: This function returns an image path based on product id and
		image type
	
	'ARGUMENTS	
	ProductID: Integer product id from the database.
	ImageID: Type of image required (integer key representing large, thumbnail, etc).
	
	RETURNS
	A string with the image location.
	--->
<cffunction name="cwGetImage">
	<cfargument name="ProductID" required="true" />
	<cfargument name="ImageID" required="true" />
	
	<cfset var rs = "" />
	<!--- Query the database and return a url to an image, if it exists --->
	<cfquery name="rs" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
	SELECT tbl_prdtimages.prdctImage_FileName, tbl_list_imagetypes.imgType_Folder
	FROM tbl_list_imagetypes INNER JOIN tbl_prdtimages ON tbl_list_imagetypes.imgType_ID = tbl_prdtimages.prdctImage_ImgTypeID
	WHERE tbl_prdtimages.prdctImage_ProductID = <cfqueryparam cfsqltype="cf_sql_integer" value="#Arguments.ProductID#" />
		AND tbl_prdtimages.prdctImage_ImgTypeID = <cfqueryparam cfsqltype="cf_sql_integer" value="#Arguments.ImageID#" />
	</cfquery>
	
	<cfif rs.RecordCount NEQ 0>
		<!--- Process the image --->
		<cfset imageSRC = rs.imgType_Folder & rs.prdctImage_FileName />
		<cfset imagePath = "">
		<cfset localPath = Replace(ExpandPath("*.*"),"*.*","")>
		<cfif FindNoCase("/cw3/admin",localPath) OR FindNoCase("\cw3\admin",localPath)>
			<cfset localPath = ReplaceNoCase(localPath, "/cw3/admin","")>
			<cfset localPath = ReplaceNoCase(localPath, "\cw3\admin","")>
			<cfset imagePath = "../../">
		</cfif>
		<cfif FileExists(localPath & imageSRC)>
			<cfreturn imagePath & imageSRC />
		<cfelse>
			<cfreturn "" />
		</cfif>
	<cfelse>
		<!--- There's no related image, return an empty string --->
		<cfreturn "" />
	</cfif>
	
</cffunction>

<!----------------------------------------------------------------------
	DESCRIPTION: This function returns an image complete with image tag 
		with alt attribute based on product id and image type
	
	'ARGUMENTS	
	ProductID: Integer product id from the database.
	ImageID: Type of image required (integer key representing large, thumbnail, etc).
	altText: Alternate text for the image, or blank if none.
	noImageText: Text to display if image doesn't exist, if any.
	class: optional css class.
	noImageText: optional element id.
	
	RETURNS
	A string with the image location.
	
	--->
<cffunction name="cwDisplayImage">
	<cfargument name="ProductID">
	<cfargument name="ImageID">
	<cfargument name="altText" default="">
	<cfargument name="noImageText" default="">
	<cfargument name="class" default="">
	<cfargument name="id" default="">
	
	<cfset var DisplayImage = "">
	<cfset var ImageSRC = cwGetImage(ProductID, ImageID)>
	<cfif class NEQ "">
		<cfset class = ' class="#class#"' />
	</cfif>
	<cfif id NEQ "">
		<cfset id = ' id="#id#"' />
	</cfif>
	<cfset altText = Replace(altText, '"','&quot;','all')>
	<cfif ImageSRC NEQ "">		
		<cfset DisplayImage = '<img src="#ImageSRC#" alt="#altText#"#class##id# />'>
	<cfelse>
		<cfset DisplayImage = noImageText>
	</cfif>
	<cfreturn DisplayImage />
</cffunction>


<!----------------------------------------------------------------------
	DESCRIPTION: This function Returns a Struct with the total tax rate, 
		and information on each individual tax rate
	
	'ARGUMENTS	
	ProductID: Integer product id from the database.
	StateID: ID of the customer state
	CountryID: ID of the customer country
	
	RETURNS
	A struct with tax rate
	--->
<cffunction name="cwGetTotalProductTaxRate">
	<cfargument name="ProductID" type="numeric" required="true" />
	<cfargument name="StateID" type="numeric" required="true" />
	<cfargument name="CountryID" type="numeric" required="true" />
	<cfset var rs = "" />
	<cfset var TaxRates = StructNew() />
	<cfset var temp = StructNew() />

	<cfset TaxRates.DisplayTax = 0 />
	<cfset TaxRates.CalcTax = 0 />
	<cfset TaxRates.Rates = ArrayNew(1) />
	<cfif Application.TaxSystem EQ "Groups">
		<!--- Get the product tax information, including current tax rate and tax type --->
		<cfquery name="rs" datasource="#request.dsn#" username="#request.dsnusername#" password="#request.dsnpassword#">
		SELECT r.taxrate_percentage, tr.taxregion_label
		FROM tbl_taxregions tr
		RIGHT JOIN ((tbl_taxgroups g
		INNER JOIN tbl_products p
		ON g.taxgroup_id = p.product_taxgroupid) 
		LEFT JOIN tbl_taxrates r
		ON g.taxgroup_id = r.taxrate_groupid) 
		ON tr.taxregion_id = r.taxrate_regionid
		WHERE 
			p.product_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#Arguments.ProductID#" />
			AND (
				(
					taxregion_countryid = <cfqueryparam cfsqltype="cf_sql_integer" value="#Arguments.CountryID#" /> 
					AND taxregion_stateid = 0)
				OR 
				(
					taxregion_countryid = <cfqueryparam cfsqltype="cf_sql_integer" value="#Arguments.CountryID#" /> 
					AND taxregion_stateid = <cfqueryparam cfsqltype="cf_sql_integer" value="#Arguments.StateID#" /> )
				)			
		
		</cfquery>
	<cfelse>
		<!--- Old style CW 2 taxes for backward compatibility and "general" tax on one or more states -- all products --->
		<cfif Arguments.StateID EQ 0>
			<cfif countryHasStates(Arguments.CountryID)>
				<!---  // user is not logged in, and country has states, so no default tax can be assumed --->
				<cfreturn TaxRates />
			</cfif>
			<cfquery name="rs" datasource="#request.dsn#" username="#request.dsnusername#" password="#request.dsnpassword#">
			SELECT stprv_Tax * 100.0 as taxrate_percentage, stprv_Code + ' tax' as taxregion_label
			FROM tbl_stateprov 
			WHERE stprv_Country_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#Arguments.CountryID#" />
			</cfquery>
		<cfelse>
			<cfquery name="rs" datasource="#request.dsn#" username="#request.dsnusername#" password="#request.dsnpassword#">
			SELECT stprv_Tax * 100.0 as taxrate_percentage, stprv_Code + ' tax' as taxregion_label
			FROM tbl_stateprov 
			WHERE stprv_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#Arguments.StateID#" />
			</cfquery>
		</cfif>
	</cfif>
	<cfloop query="rs">
		<cfset temp = StructNew()>
		<cfset TaxRates.DisplayTax = val(TaxRates.DisplayTax) + val(rs.taxrate_percentage) />
		<cfset temp.Label = rs.taxregion_label />
		<cfset temp.DisplayTax = val(rs.taxrate_percentage) />
		<cfif temp.DisplayTax NEQ 0>
			<cfset temp.CalcTax = (temp.DisplayTax / 100) + 1 />
		<cfelse>
			<cfset temp.CalcTax = 0 />
		</cfif>
		<cfset ArrayAppend(TaxRates.Rates, temp) />
	</cfloop>
	
	<cfif val(TaxRates.DisplayTax) NEQ 0>
		<cfset TaxRates.CalcTax = (TaxRates.DisplayTax / 100) + 1 />
	</cfif>
	
	<cfreturn TaxRates />
</cffunction>


<!----------------------------------------------------------------------
	DESCRIPTION: This function Returns a tax amount on shipping, 
		based on location id and shipping total
	
	'ARGUMENTS	
	CountryID: Integer location id for the customer.
	ShippingTotal: Total amount of shipping for the cart
	Cart: The cart object
	
	RETURNS
	A tax amount on the current shipping charge
	--->
<cffunction name="cwGetShippingTaxes">
	<cfargument name="CountryID" type="numeric" required="true" />
	<cfargument name="ShippingTotal" type="numeric" required="true" />
	<cfargument name="Cart" type="struct" required="true" />
	<cfargument name="StateID" type="numeric" required="true" />
	
	<cfset var TaxAmount = 0 /><!--- NO tax by default --->
	<cfset var TaxRate = 0 />
	<cfset var rsShipTax = "" />
	<cfset var rsMaxTax = "" />
		
	<cfif Application.TaxSystem EQ "Groups">
		<cfquery name="rsShipTax" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
		SELECT t.taxrate_percentage as ShipTaxRate, 
		r.taxregion_shiptaxmethod as ShipTaxMethod
		FROM tbl_taxregions r 
		RIGHT JOIN tbl_taxrates t
		ON r.taxregion_id = t.taxrate_regionid
		WHERE r.taxregion_shiptaxmethod <> 'No Tax'
		AND r.taxregion_countryid = #Val(CountryID)#
		AND r.taxregion_stateid = #Val(StateID)#
		</cfquery>
		
		<cfif rsShipTax.RecordCount GT 0>
			<!--- Determine method of charging tax to shipping --->
			<cfif rsShipTax.ShipTaxMethod EQ "Highest Item Taxed">
				<!--- Charge tax based on the highest taxed item currently in the cart --->
				
				<!--- Check the cart to find the highest taxed item --->
				<cfset ShipTaxRate = 0>
				<cfloop from="1" to="#ArrayLen(Cart.Products)#" index="i">
					<cfif Cart.Products[i].Tax GT ShipTaxRate>
						<cfset ShipTaxRate = Cart.Products[i].TaxRates.DisplayTax>
					</cfif>
				</cfloop>
				<cfset TaxAmount = cwCalculateTax(ShippingTotal, ShipTaxRate) />
			<cfelse>
				<!--- The tax rate is set to a specific tax group --->
				<cfset TaxAmount = cwCalculateTax(ShippingTotal, rsShipTax.ShipTaxRate) />
			</cfif>
		</cfif>
	<cfelse>
		<cfset TaxRate = getBasicTax(Arguments.StateID, Arguments.CountryID) />
		<cfset TaxAmount = cwCalculateTax(Arguments.ShippingTotal, TaxRate) />
	</cfif>
	<cfreturn TaxAmount />
</cffunction>

<cffunction name="getBasicTax">
<!--- // Get a General tax (basic tax) --->
	<cfargument name="StateID" type="numeric" required="true" />
	<cfargument name="CountryID" type="numeric" required="true" />
	<cfset var rsCWBasicTax = QueryNew('empty') />
	<cfif Arguments.StateID EQ 0>
		<cfif countryHasStates(Arguments.CountryID)>
			<!---  // user is not logged in, and country has states, so no default tax can be assumed --->
			<cfreturn 0 />
		</cfif>
		<cfquery name="rsCWBasicTax" datasource="#request.dsn#" username="#request.dsnusername#" password="#request.dsnpassword#">
		SELECT stprv_Tax * 100.0 as taxrate_percentage
		FROM tbl_stateprov 
		WHERE stprv_Country_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#Arguments.CountryID#" />
		</cfquery>
	<cfelse>
		<cfquery name="rsCWBasicTax" datasource="#request.dsn#" username="#request.dsnusername#" password="#request.dsnpassword#">
		SELECT stprv_Tax * 100.0 as taxrate_percentage
		FROM tbl_stateprov 
		WHERE stprv_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#Arguments.StateID#" />
		</cfquery>
	</cfif>
	<cfif rsCWBasicTax.recordCount GT 0>
		<cfreturn rsCWBasicTax.taxrate_percentage />
	<cfelse>
		<cfreturn 0 />
	</cfif>
</cffunction>

<cffunction name="countryHasStates">
	<cfargument name="CountryID" type="numeric" required="true" hint="Country id of country to find states for, returns true or false" />
	<cfset var rsCWCountryHasStates = QueryNew('empty') />
	
	<cfquery name="rsCWCountryHasStates" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
	SELECT COUNT(*) as TheStateCount
	FROM tbl_list_countries c
	INNER JOIN tbl_stateprov s
	ON c.country_ID = s.stprv_Country_ID
	WHERE stprv_Archive = 0
	AND stprv_Country_ID = #arguments.CountryID#
	AND stprv_Name <> 'None'
	</cfquery>

	<cfif rsCWCountryHasStates.TheStateCount EQ 0>
		<cfreturn false />
	<cfelse>
		<cfreturn true />
	</cfif>
</cffunction>

<!----------------------------------------------------------------------
	DESCRIPTION: This function returns a tax calculation on an amount, given the amount and the rate
	
	'ARGUMENTS	
	Cost: Cost of something (product, total, shipping, etc)
	TaxRate: The rate of tax, such as 25 for 25% tax
	
	RETURNS
	A tax amount for a given cost	
	--->
<cffunction name="cwCalculateTax">
	<cfargument name="Cost" type="numeric" required="true" hint="The cost that tax should be calculated against." />
	<cfargument name="TaxRate" type="numeric" required="true" hint="This should be a tax rate not already divided by 100. For 25%, pass in 25, not .25." />
	
	<cfreturn decimalRound(Cost * (TaxRate/100)) />
</cffunction>

<!--- DESCRIPTION: This function rounds to 2 places --->
<cffunction name="decimalRound">
	<cfargument name="theNumber" type="numeric">
	<cfreturn round(theNumber * 100)/100/>
</cffunction>


<!----------------------------------------------------------------------
	DESCRIPTION: This function Returns a tax amount on shipping, 
		based on location id and shipping total
	
	'ARGUMENTS	
	CartID: ID of customer cart
	TaxStateID: State id of the customer
	TaxCountryID: Country id of the customer
	
	RETURNS
	A struct containing the customer's cart, with product information
	--->
<cffunction name="cwGetCart">
	<cfargument name="CartID" required="true" />
	<cfargument name="TaxStateID" default="0" />
	<cfargument name="TaxCountryID" default="0" />
	<!--- Creates a structure representing the user's cart --->
	<cfset var Cart = StructNew() />
	<cfset var rsCWCart = QueryNew('empty') />
	<cfset var Product = StructNew() />
	<cfset var Option = StructNew() />

	<!--- Set default values for cart totals --->
	<cfset Cart.CartTotals = StructNew() />
	<cfset Cart.CartTotals.Base = 0 />
	<cfset Cart.CartTotals.Discounts = 0 />
	<cfset Cart.CartTotals.ShippingDiscounts = 0 />
	<cfset Cart.CartTotals.ShippingTax = 0 />
	<cfset Cart.CartTotals.Sub = 0 />
	<cfset Cart.CartTotals.Tax = 0 />
	<cfset Cart.CartTotals.ProductTotal = 0 />
	<cfset Cart.CartTotals.Weight = 0 />
	<cfset Cart.CartTotals.ProductCount = 0 />
	<cfset Cart.CartTotals.ShipWeight = 0 />
	<cfset Cart.CartTotals.ShipSubtotal = 0 />
	
	<!--- Set default product information --->
	<cfset Cart.Products = ArrayNew(1) />

	<!--- Check to see if the user has a valid shopping cart --->
	<cfif Application.DBType EQ "MSAccess" OR Application.DBType EQ "MSAccessJet">
	<cfquery name="rsCWCart" datasource="#request.dsn#" username="#request.dsnusername#" password="#request.dsnpassword#">
	SELECT p.product_ID, p.product_Name, p.product_shipchrg, 
		s.SKU_MerchSKUID , s.SKU_ID, c.cart_sku_qty, s.SKU_Price, 
		s.SKU_Weight, ot.optiontype_Name , 
		so.option_Name, 
		c.cart_sku_qty * s.sku_price AS TotalPrice , 
		c.cart_sku_qty * s.SKU_Weight AS TotalWeight 
		FROM (tbl_products p
		INNER JOIN (tbl_cart c
		INNER JOIN tbl_skus s
		ON c.cart_sku_ID = s.SKU_ID) 
		ON p.product_ID = s.SKU_ProductID) 
		LEFT JOIN ((tbl_list_optiontypes ot
		RIGHT JOIN tbl_skuoptions so
		ON ot.optiontype_ID = so.option_Type_ID) 
		RIGHT JOIN tbl_skuoption_rel r
		ON so.option_ID = r.optn_rel_Option_ID) 
		ON s.SKU_ID = r.optn_rel_SKU_ID 
		WHERE c.cart_custcart_ID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Arguments.CartID#" />
		AND p.product_Archive = 0 
		AND s.SKU_ShowWeb = 1 
		AND p.product_OnWeb = 1 
		ORDER BY p.product_Sort, p.product_Name, 
		s.SKU_Sort, s.SKU_ID , so.option_Name, so.option_Sort 
	
	</cfquery>
	<cfelse>
	<cfquery name="rsCWCart" datasource="#request.dsn#" username="#request.dsnusername#" password="#request.dsnpassword#">
	SELECT p.product_ID, p.product_Name, p.product_shipchrg, 
		s.SKU_MerchSKUID , s.SKU_ID, c.cart_sku_qty, s.SKU_Price, 
		s.SKU_Weight, ot.optiontype_Name , 
		so.option_Name, 
		c.cart_sku_qty * s.sku_price AS TotalPrice , 
		c.cart_sku_qty * s.SKU_Weight AS TotalWeight 
		FROM tbl_products p
		INNER JOIN tbl_skus s
		ON p.product_ID = s.SKU_ProductID
		INNER JOIN tbl_cart c
		ON c.cart_sku_ID = s.SKU_ID
		LEFT JOIN tbl_skuoption_rel r
		ON s.SKU_ID = r.optn_rel_SKU_ID 
		LEFT JOIN tbl_skuoptions so
		ON so.option_ID = r.optn_rel_Option_ID
		LEFT JOIN tbl_list_optiontypes ot
		ON ot.optiontype_ID = so.option_Type_ID			
		WHERE c.cart_custcart_ID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Arguments.CartID#" />
		AND p.product_Archive = 0 
		AND s.SKU_ShowWeb = 1 
		AND p.product_OnWeb = 1 
		ORDER BY p.product_Sort, p.product_Name, 
		s.SKU_Sort, s.SKU_ID , so.option_Name, so.option_Sort 
	</cfquery>
	</cfif>
	<cfif rsCWCart.RecordCount NEQ 0>
		<!--- The user has some products in their cart --->
		<cfoutput query="rsCWCart" group="sku_id">
			<!--- Increment the product count --->
			<cfset Cart.CartTotals.ProductCount = Cart.CartTotals.ProductCount + 1 />

			<!--- Create an empty product struct --->
			<cfset Product = StructNew() />
			<cfset Product.Options = ArrayNew(1) />
			<cfset Product.Discount = StructNew() />

			<!--- Set the product base price, before *any* adjustments --->
			<cfset Product.BasePrice = rsCWCart.TotalPrice />
			<cfset Product.Price = rsCWCart.SKU_Price />
			<cfset Cart.CartTotals.Base = Cart.CartTotals.Base + Product.BasePrice />
			
			<!--- Set the product information values --->
			<cfset Product.Name = rsCWCart.product_Name />
			<cfset Product.ID = rsCWCart.product_ID />
			<cfset Product.SKUID = rsCWCart.SKU_ID />
			<cfset Product.MerchSKUID = rsCWCart.SKU_MerchSKUID />
			<cfset Product.Quantity = rsCWCart.cart_sku_qty />
			
			<!--- Get the total discount rate for the product --->
			<cfset Product.Discount =  cwGetDiscountProduct(Product.ID, Product.SKUID)>
			<cfset Product.DiscountAmount = decimalRound(cwGetDiscount(Product.Discount, Product.Price, Product.Quantity))/>
			<!---<cfset Product.Price = Product.Price - Product.DiscountAmount>--->
			<cfset Cart.CartTotals.Discounts = decimalRound(Cart.CartTotals.Discounts + Product.Quantity*Product.DiscountAmount) />
			
			<!--- Subtotal is the Base Price minus any applied discounts --->
			<cfset Product.SubTotal = Product.Quantity*Product.Price - (Product.Quantity*Product.DiscountAmount) />
			<cfset Cart.CartTotals.Sub = Cart.CartTotals.Sub + Product.SubTotal />
			
			<!--- Set the weight and cost totals for shipping calculations --->
			<cfset Product.Weight = rsCWCart.TotalWeight />
			<cfset Cart.CartTotals.Weight = Cart.CartTotals.Weight + Product.Weight />
			<cfif rsCWCart.product_shipchrg EQ 1>
				<cfset Product.ShipCharge = True />
				<cfset Cart.CartTotals.ShipWeight = Cart.CartTotals.ShipWeight + Product.Weight />
				<cfset Cart.CartTotals.ShipSubtotal = Cart.CartTotals.ShipSubtotal + Product.SubTotal />
			<cfelse>
				<cfset Product.ShipCharge = False />
			</cfif>
			

			<!--- Calculate the tax rates --->
			<cfset Product.TaxRates = cwGetTotalProductTaxRate(val(Product.ID), val(Arguments.TaxStateID), val(Arguments.TaxCountryID)) />
			<cfset Product.Tax = (Product.SubTotal * Product.TaxRates.CalcTax) - Product.SubTotal />
			<cfif Product.Tax LT 0>
				<cfset Product.Tax = 0 />
			</cfif>
			<cfset Cart.CartTotals.Tax = decimalRound(Cart.CartTotals.Tax + Product.Tax) />
			
			<!--- Product Total is the SubTotal plus any applicable taxes --->
			<cfset Product.Total = Product.SubTotal + Product.Tax />
			<cfset Cart.CartTotals.ProductTotal = Cart.CartTotals.ProductTotal + Product.Total />
			
			<!--- Create product options array --->
			<cfoutput>
				<cfif rsCWCart.option_Name NEQ "">
					<!--- Loop through the grouped options --->
					<cfset Option = StructNew() />
					<cfset Option.Name = rsCWCart.optiontype_Name />
					<cfset Option.Value = rsCWCart.option_Name />
					<cfset ArrayAppend(Product.Options, Option) />
				</cfif>
			</cfoutput>
			<cfset ArrayAppend(Cart.Products, Product) />
		</cfoutput>
	</cfif>
	
	<cfreturn Cart />
</cffunction>
<!--- Remove commas from numbers for MySQL --->

<cffunction name="makeSQLSafeNumber">
	<cfargument name="theNumber" type="string">
	
	<cfreturn Replace(theNumber, ",",".","all")                           />
</cffunction>
<!----------------------------------------------------------------------
	DESCRIPTION: allows debugging of objects when debugging is turned on
	
	'ARGUMENTS	
	object: any variable to dump
	--->
<cffunction name="cwDebugger">
	<cfargument name="object">
	<cfset ArrayAppend(session.cwDebuggerItems, object)>
</cffunction>
<!----------------------------------------------------------------------
	DESCRIPTION: converts some html to htmlentities
	
	'ARGUMENTS	
	string to clean: any variable to dump
	--->
<cffunction name="makeHTMLSafe" output="false" returntype="string">
	<cfargument name="theString" type="string" />
	<cfset theString = Replace(theString,"<","&lt;","all")>
	<cfset theString = Replace(theString,">","&gt;","all")>
	<cfset theString = Replace(theString,'"',"&quot;","all")>
	<cfset theString = Replace(theString, chr(10),"<br />","all")>
	<cfreturn theString />
</cffunction>
<!----------------------------------------------------------------------
  Replace characters for Javascript, similar to jsStringFormat 
  only without the problem of double quotes
  --->
<cffunction name="cwStringFormat" output="false" returntype="string">
	<cfargument name="theString" type="string" />
	<cfset theString = makeHTMLSafe(theString)>
	<cfset theString = Replace(theString,"'","\'","all")>
	<cfreturn theString />
</cffunction>
<cfset request.makeHTMLSafe = makeHTMLsafe>
</cfsilent>