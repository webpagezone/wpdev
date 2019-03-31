<cfsilent><!--- 
================================================================
Application Info: Cartweaver© 2002 - 2007, All Rights Reserved.
Developer Info: Application Dynamics Inc.
                1560 NE 10th
                East Wenatchee, WA 98802
Support Info: http://www.cartweaver.com/go/cfhelp
				
Cartweaver Version: 3.0.12  -  Date: 5/25/2008
================================================================
Name: CWIncDiscountFunctions
================================================================
--->
<cfif not isdefined('decimalRound') OR Not IsCustomFunction(decimalRound)><cfinclude template="CWIncFunctions.cfm"></cfif>
<!---
	---------------------------------------------------------------------
	Created: April 1, 2007 
	Modified: 

	FUNCTION: cwGetDiscountObject

	DESCRIPTION: This function returns an empty discount object with all 
		required properties
	
	ARGUMENTS	
	none
	
	RETURNS
	A discount object
	
	
	--->
<cffunction name="cwGetDiscountObject">
	<cfset discount = StructNew()>
	<cfset discount.rate = 0>
	<cfset discount.amount = 0>
	<cfset discount.discountid = 0>
	<cfset discount.description = "">
	<cfreturn discount />
</cffunction>


<!---
	---------------------------------------------------------------------
	Created: April 1, 2007 
	Modified: 

	FUNCTION: cwRemoveDiscountsWithLimits
	
	Not implemented
--->
<cffunction name="cwRemoveDiscountsWithLimits">
	<cfargument name="DiscountList">
	<cfargument name="CustomerID">
	
	<cfreturn DiscountList />
</cffunction>

<!---
	---------------------------------------------------------------------
	Created: April 1, 2007 
	Modified: 

	FUNCTION: cwRemoveDiscountsWithLimits

	DESCRIPTION: This function returns a list of discounts with any limited discount 
		that doesn't meet the requirements removed. For example, if a customer has
		already used a discount and there is a limit of one use, discount is removed
	
	ARGUMENTS	
	DiscountList: All available discounts to check.
	CustomerID: ID of the customer to test for limited discounts
	
	RETURNS
	A string with the discount list
	
	EXAMPLES
	<cfset discountList = cwRemoveDiscountsWithLimits(discountList, #Client.customerid#)>
	
	
	--->
<cffunction name="cwGetDiscounts">
	<cfparam name="session.availableDiscounts" default="">
	<cfif application.EnableDiscounts EQ true>
		<cfset today = DateFormat(Now(), "mm/dd/yyyy")>
		<cfparam name="session.promotionalcode" default="">
		<cfquery name="rsGetDiscounts"  datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
		SELECT discount_id, discount_promotionalCode
		FROM tbl_discounts d
		WHERE (#CreateODBCDate(today)# >= d.discount_startDate 
			AND #CreateODBCDate(today)# <= d.discount_endDate)
		AND d.discount_archive = 0	
		AND (d.discount_promotionalCode = '' 
			OR d.discount_promotionalCode = '#session.promotionalcode#')
		</cfquery>
		<cfset availableDiscounts = ValueList(rsGetDiscounts.discount_id)>

		<cfif ListFindNoCase(ValueList(rsGetDiscounts.discount_promotionalCode), session.promotionalCode) NEQ 0>
			<cfset request.promocodeApplied = true>
		</cfif>
		<cfset session.availableDiscounts = availableDiscounts>
	</cfif>
</cffunction>

<!---
	---------------------------------------------------------------------
	Created: April 1, 2007 
	Modified: 

	FUNCTION: cwGetDiscountProduct

	DESCRIPTION: This function returns a discount amount for a product. A productid
	or skuid can be given, and the id is checked against available discounts for 
	products, skus, and exclusions
	
	ARGUMENTS	
	Product_ID: Integer product id from the database.
	SkuID: Integer skuid from the database
	
	RETURNS
	A discount object with the discount properties filled in
	
	--->
<cffunction name="cwGetDiscountProduct">
	<cfargument name="Product_ID">
	<cfargument name="Skuid" required="false" />
	
	<cfset var discount = cwGetDiscountObject()>
	<cfif application.EnableDiscounts EQ true>
		<cfquery name="rsCWGetPrice"  datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
		SELECT MIN(SKU_Price) as Price
		FROM tbl_skus s
		INNER JOIN tbl_products p
		ON s.SKU_ProductID = p.product_ID
		WHERE p.product_ID = #Product_ID#
		<cfif isDefined("skuid")>
			 AND s.SKU_ID = #Skuid#
		</cfif>
		</cfquery>
		<cfset oldPrice = rsCWGetPrice.Price> 
		<cfif ListLen(session.availableDiscounts) NEQ 0>
			
			<cfquery name="rsGetDiscounts"  datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
			SELECT d.discount_id, d.discount_applyTo
			FROM (tbl_discounts AS d 
			INNER JOIN tbl_discount_amounts AS a 
			ON d.discount_id = a.discountAmount_discount_id) 
			
			WHERE (((d.discount_id) IN (#session.availableDiscounts#)) 
			AND ((d.discount_applyType) In (1,4,5,6)))
			</cfquery>
			<!--- Logic here --->
			<cfset validDiscounts = "">
			<cfset invalidDiscounts = "">
			<cfloop from="#rsGetDiscounts.recordcount#" to="1" index="i" step="-1">
			<!--- Check for inclusions --->		
				<cfif rsGetDiscounts.discount_applyTo[i] EQ "specific">
					<!--- Include product ids --->
					<cfquery name="rsInclude" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
					SELECT discounts_products_rel_discount_id FROM tbl_discounts_products_rel
					WHERE discounts_products_rel_prod_id = #product_ID#
					AND discounts_products_rel_discount_id = #rsGetDiscounts.discount_id[i]#
					</cfquery>
					<cfif rsInclude.recordCount GT 0>
						<cfset validDiscounts = ListAppend(validDiscounts, rsInclude.discounts_products_rel_discount_id)>
					</cfif>
					<cfif IsDefined("skuid")>
						<!--- include skuids --->
						<cfquery name="rsInclude" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
						SELECT discounts_skus_rel_discount_id 
						FROM tbl_discounts_skus_rel
						WHERE discounts_skus_rel_sku_id = #skuid#
						AND discounts_skus_rel_discount_id = #rsGetDiscounts.discount_id[i]#
						</cfquery>
						<cfif rsInclude.recordCount GT 0>					
							<cfset validDiscounts = ListAppend(validDiscounts, rsInclude.discounts_skus_rel_discount_id)>
						</cfif>
					</cfif>
				</cfif>
			</cfloop>
			<!--- Query requires testing the discount rate type -- different clauses for Access and other databases --->
			<cfif Application.DBType EQ "MSAccess" OR Application.DBType EQ "MSAccessJet">
				<cfset discountAmountClause = "IIF(discountAmount_rateType = '0', #oldPrice# * discountAmount_discount / 100, discountAmount_discount)">
			<cfelse>
				<cfset discountAmountClause = "CASE WHEN discountAmount_rateType = 0 THEN 
					#oldPrice# * discountAmount_discount / 100 
				ELSE 
					discountAmount_discount 
				END">
			</cfif>
			<cfquery name="rsDiscountsFinal" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
			SELECT d.*, a.*, #PreserveSingleQuotes(discountAmountClause)# as discount
			FROM (tbl_discounts AS d 
			INNER JOIN tbl_discount_amounts AS a 
			ON d.discount_id = a.discountAmount_discount_id) 
			WHERE ((discount_applyTo = 'all')
			
			<cfif validDiscounts NEQ "">
			OR discount_id IN (#validDiscounts#)
			</cfif>
			)
			AND (((d.discount_id) IN (#session.availableDiscounts#)) 
			AND ((d.discount_applyType) In (1,4,5,6)))
			
			ORDER BY #PreserveSingleQuotes(discountAmountClause)# DESC
			</cfquery>

			<cfif rsDiscountsFinal.RecordCount GT 0>
				<cfset discount.rate = val(rsDiscountsFinal.discountAmount_discount)/100>
				<cfset discount.amount = val(rsDiscountsFinal.discountAmount_discount)>
				<cfif rsDiscountsFinal.discountAmount_rateType EQ 0>
					<cfset discount.amount = 0>
				<cfelse>
					<cfset discount.rate = 1>
				</cfif>
				<cfset discount.discountid = rsDiscountsFinal.discount_id>
				<cfset discount.description = cwGetDiscountDescription(rsDiscountsFinal.discount_id)>
				<cfset session.currentDiscount = discount.discountid>
				<!--- Set page-level discount list --->
				<cfif Not ListFind(request.discounts, discount.discountid)>
					<cfset request.discounts = ListAppend(request.discounts, discount.discountid)>
				</cfif>
			</cfif>
		</cfif>
	</cfif>
	
	<cfreturn discount />
</cffunction>

<!---
	---------------------------------------------------------------------
	Created: April 1, 2007 
	Modified: 

	FUNCTION: cwGetNewPrice

	DESCRIPTION: This function returns an empty discount object with all 
		required properties
	
	ARGUMENTS	
	discount: Discount object containing properties of discount
	oldPrice: Original price of product
	quantity: Quantity of product in cart
	
	RETURNS
	A new price with discount applied
	
	
	
	--->
<cffunction name="cwGetNewPrice">
	<cfargument name="discount">
	<cfargument name="oldPrice" default="0">
	<cfargument name="quantity" default="1">
	<cfif discount.amount EQ 0>
		<cfset oldPrice = oldPrice - (decimalRound(oldPrice * discount.rate))>
	<cfelse>
		<cfset oldPrice = oldPrice - discount.amount>
	</cfif>
	
	<cfreturn oldPrice />	
</cffunction>

<!---
	---------------------------------------------------------------------
	Created: April 1, 2007 
	Modified: 

	FUNCTION: cwGetDiscount

	DESCRIPTION: This function returns the discount amount on a product
	
	ARGUMENTS	
	discount: Discount object containing properties of discount
	oldPrice: Original price of product
	quantity: Quantity of product in cart
	
	RETURNS
	An amount of the discount for a given product
	
	
	--->
<cffunction name="cwGetDiscount">
	<cfargument name="discount">
	<cfargument name="oldPrice" default="0">
	<cfargument name="quantity" default="1">
	<cfset var discountAmount = 0>
	
	<cfif discount.discountid NEQ 0>
		<cfif discount.amount EQ 0>
			<cfset discountAmount = decimalRound(oldPrice * discount.rate)>
		<cfelse>
			<cfset discountAmount = discount.amount>
		</cfif>
	</cfif>
	<cfreturn discountAmount />	
</cffunction>
<!---
	---------------------------------------------------------------------
	Created: April 1, 2007 
	Modified: 

	FUNCTION: cwDisplayOldPrice

	DESCRIPTION: This function returns an empty discount object with all 
		required properties
	
	ARGUMENTS	
	oldPrice: original price of product
	discount_id: ID of discount
	
	RETURNS
	A string with an old price with a line-through and a descriptive note if specified
	
	EXAMPLES
	Display large image
	<cfoutput>#cwGetImage(rsGetProducts.ProductID, 1)#</cfoutput>
	
	
	--->
<cffunction name="cwDisplayOldPrice">
	<cfargument name="oldPrice">
	<cfargument name="discount_id" default="0">
	<cfset var description = cwGetDiscountDescription(discount_id)>
	<cfset var descriptionNote = ListFirst(description, " ")>
	<cfset oldPrice = '<span class="oldprice">' & oldPrice & '</span>#descriptionNote# ' />

	<cfreturn oldPrice />	
</cffunction>

<!---
	---------------------------------------------------------------------
	Created: April 1, 2007 
	Modified: 

	FUNCTION: cwDisplayDiscountAmount

	DESCRIPTION: This function returns an empty discount object with all 
		required properties
	
	ARGUMENTS	
	discountAmount: Integer product id from the database.
	discount_id: Type of image required (integer key representing large, thumbnail, etc).
	
	RETURNS
	A string with the discount amount along with a descriptive note if specified.
	
	
	--->
<cffunction name="cwDisplayDiscountAmount">
	<cfargument name="discountAmount">
	<cfargument name="discount_id" default="0">
	<cfset var description = cwGetDiscountDescription(discount_id)>
	<cfset var descriptionNote = "">
	<cfif Application.DisplayDiscountNotes>
		<cfset descriptionNote =  ListFirst(description, " ")/>
	</cfif>
	<cfset discountAmount = '#descriptionNote##discountAmount#' />

	<cfreturn discountAmount />	
</cffunction>

<!---
	---------------------------------------------------------------------
	Created: April 1, 2007 
	Modified: 

	FUNCTION: cwGetDiscountDescription

	DESCRIPTION: This function returns a string containing a description, given 
		the discount id
	
	ARGUMENTS	
	discount_id: Integer discount id from the database.
	
	RETURNS
	A string with the discount description, if specified in the discount configuration
	
		
	--->
<cffunction name="cwGetDiscountDescription">
	<cfargument name="discount_id">
	<cfset var description = "">
	<cfset var found = 0>
	<cfquery name="rsGetDescription" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
	SELECT discount_description, discount_limit 
	FROM tbl_discounts 
	WHERE discount_id = #val(discount_id)# 
	AND discount_showDesc = 1 
	</cfquery>

	<cfif rsGetDescription.RecordCount GT 0>
		<cfset description = rsGetDescription.discount_description>
		<cfif rsGetDescription.discount_limit GT 0>
			<cfif rsGetDescription.discount_limit GT 1>
				<cfset description = "#description# (limited to #rsGetDescription.discount_limit# times per customer)">
			<cfelse>
				<cfset description = "#description# (limited to #rsGetDescription.discount_limit# once per customer)">
			</cfif>
		</cfif>
	</cfif>
	<cfif description NEQ "">
		<cfif Not IsDefined("Request.discountDescriptions")>
			<cfset Request.DiscountDescriptions = ArrayNew(1)>
		</cfif>
		<cfloop from="1" to="#ArrayLen(Request.DiscountDescriptions)#" index="i">
			<cfif Request.DiscountDescriptions[i] EQ description>
				<cfset found = i>
			</cfif>
		</cfloop>
		<cfif found EQ 0>
			<cfset ArrayAppend(Request.DiscountDescriptions, description)>
		</cfif>
	</cfif> <!--- & " " & RepeatString("*", found) --->
	<cfif Application.DisplayDiscountNotes>
		<!---<cfset description =  RepeatString("*", found) & " " & description/>--->
		<cfset description =  getNotationCharacter(found) & " " & description/>
	</cfif>
	<cfreturn  description />
</cffunction>

<!---
	---------------------------------------------------------------------
	Created: April 1, 2007 
	Modified: 

	FUNCTION: cwGetNotationCharacter

	DESCRIPTION: This function returns the notation character given a number. Notation
		characters show notes using asterisks or &##8224;
	
	ARGUMENTS	
	ProductID: Integer product id from the database.
	ImageID: Type of image required (integer key representing large, thumbnail, etc).
	altText: Alternate text for the image, or blank if none.
	noImageText: Text to display if image doesn't exist, if any.
	
	RETURNS
	A string of the required number of notation characters.
	
	EXAMPLES
	to show 
	** Note
	<cfoutput>#cwGetNotationCharacter(2)# Note</cfoutput>
	
	
	--->
<cffunction name="getNotationCharacter">
	<cfargument name="number">
	<cfif val(number) EQ 0><cfreturn/></cfif>
	<cfif number EQ 1 or number EQ 2>
		<cfreturn repeatString("*",number)>
	<cfelse>
		<cfset returnString = "">
		<cfreturn repeatString ("&##8224;",number-2)>
	</cfif>
</cffunction>

<!---
	---------------------------------------------------------------------
	Created: April 1, 2007 
	Modified: 

	FUNCTION: cwDisplayDiscountDescriptions

	DESCRIPTION: This function displays all discount descriptions stored in 
		the Request.discountDescriptions variable
	
	ARGUMENTS	
	none
	
	RETURNS
	nothing.
	
	EXAMPLES
	Display all discount descriptions
	<cfoutput>#cwDisplayDiscountDescriptions()#</cfoutput>
	
	
	--->
<cffunction name="cwDisplayDiscountDescriptions">
	<cfif Not IsDefined("Request.discountDescriptions")>
		<cfset Request.DiscountDescriptions = ArrayNew(1)>
	</cfif>
	<cfif ArrayLen(Request.DiscountDescriptions) GT 0>
	<div id="discountDescriptions">
	<cfloop from="1" to="#ArrayLen(request.DiscountDescriptions)#" index="i">
		<cfif Application.DisplayDiscountNotes>
			<!---<cfoutput>#RepeatString("*", i)# #Session.DiscountDescriptions[i]#<br /></cfoutput>--->
			<cfoutput>#getNotationCharacter(i)# #request.DiscountDescriptions[i]#<br /></cfoutput>
		<cfelse>
			<cfoutput>#request.DiscountDescriptions[i]#<br /></cfoutput>
		</cfif>
	</cfloop>
	</div>
	</cfif>
</cffunction>

<!---
	---------------------------------------------------------------------
	Created: April 1, 2007 
	Modified: 

	FUNCTION: cwGetShippingDiscounts

	DESCRIPTION: not implemented
	
	--->
<cffunction name="cwGetShippingDiscounts">
	<cfargument name="totalShipping" type="numeric">
	
	<cfreturn "" />
</cffunction>

<!---
	---------------------------------------------------------------------
	Created: April 1, 2007 
	Modified: 

	FUNCTION: cwGetShippingDiscount

	DESCRIPTION: not implemented
	
	--->
<cffunction name="cwGetShippingDiscount">
	<cfargument name="ShipTotal" type="numeric">
	<cfargument name="shippingDiscounts" type="string" default="0">
	<cfargument name="ShipPref" type="numeric">
	<cfargument name="CartTotal" type="numeric">
	<cfreturn ShipTotal/>
</cffunction>

<!---
	---------------------------------------------------------------------
	Created: April 1, 2007 
	Modified: 

	FUNCTION: cwApplyDiscounts

	DESCRIPTION: This function helps track customer discount usage in the database
		by storing the current discount usage for this transaction
	
	ARGUMENTS	
	appliedDiscounts: Integer discount ids
	CustomerID: Type of image required (integer key representing large, thumbnail, etc).
	
	RETURNS
	nothing
	
		
	--->
<cffunction name="cwApplyDiscounts">
	<cfargument name="appliedDiscounts" type="string">
	<cfargument name="CustomerID" type="string">
	
	<cfif listLen(appliedDiscounts) GT 0>
		<cfloop list="#appliedDiscounts#" index="discountid">
			<cfquery name="rsDiscount" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
			SELECT discountUsage_discount_id 
			FROM tbl_discount_usage
			WHERE discountUsage_discount_id = #discountid#
			AND discountUsage_customer = '#CustomerID#'
			</cfquery>
			<cfif rsDiscount.recordCount GT 0>
				<cfquery  datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
				UPDATE tbl_discount_usage SET discountUsage_count = discountUsage_count + 1
				WHERE discountUsage_discount_id = #discountid#
				AND discountUsage_customer = '#CustomerID#'
				</cfquery>
			<cfelse>
				<cfquery  datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
				INSERT INTO tbl_discount_usage (
					discountUsage_discount_id, discountUsage_customer, discountUsage_count
				) VALUES (
					#discountid#, '#CustomerID#', 1
				)
				</cfquery>
			</cfif>
		</cfloop>
	</cfif>
</cffunction>
</cfsilent>