<cfsilent>
<!---
==========================================================
Application: Cartweaver 4 ColdFusion
Copyright 2002 - 2013, All Rights Reserved
Developer: Application Dynamics Inc. | Cartweaver.com
Licensing: http://www.cartweaver.com/eula
Support: http://www.cartweaver.com/support
==========================================================
File: cw-func-product.cfm
File Date: 2014-07-01
Description: manages product-related functions
Dependencies: requires cw-func-query to be included in calling page
==========================================================
--->

<!--- /////////////// --->
<!--- PRODUCT QUERIES --->
<!--- /////////////// --->

<!--- // ---------- // Get Product Details: CWgetProduct() // ---------- // --->
<cfif not isDefined('variables.CWgetProduct')>
<cffunction name="CWgetProduct"
			access="public"
			output="false"
			returntype="struct"
			hint="Creates a struct of data for any given product"
			>

	<cfargument required="true" name="product_id" type="numeric"
				hint="The ID of the product to look up">

	<cfargument required="false" name="info_type" type="string"
				hint="The level of product data detail: mini|simple|complex" default="simple">

	<cfargument required="false" name="customer_id" type="string"
				hint="ID of current customer: used for discount lookup" default="0">

	<cfargument required="false" name="customer_type" type="string"
				hint="Type of current customer: used for discount lookup" default="0">

	<cfargument required="false" name="promo_code" type="string"
				hint="Promotional code in user's session: used for discount lookup" default="">

<!--- product parent struct --->
<cfset var product = structNew()>
<!--- query: get product details --->
<cfset var detailsQuery = CWquerySelectProductDetails(arguments.product_ID)>
<!--- set up switch for return type --->
<cfset var datatype = trim(arguments.info_type)>
<!--- var scope the loop index to keep local --->
<cfset var ii = ''>
<cfset var idList = ''>
<cfset var skuct = 0>
<cfset var skupricelow = 0>
<cfset var skupricehigh = 0>
<cfset var altpricelow = 0>
<cfset var altpricehigh = 0>
<cfset var discountamount = 0>
<cfset var discountedprice = 0>
<cfset var discpricelow = 0>
<cfset var discpricehigh = 0>
<cfset var skusQuery = ''>
<cfset var imagesQuery = ''>
<cfset var imagelist = ''>
<cfset var image_typelist = ''>
<cfset var image_thumbnails = ''>
<cfset var imgct = 0>
<cfset var catList = ''>
<cfset var catsQuery = ''>
<cfset var catct = 0>
<cfset var optCt = 0>
<cfset var optList = ''>
<cfset var optionsQuery = ''>
<cfset var upsellList = ''>
<cfset var upsellQuery = ''>
<cfset var recipQuery = ''>
<cfset var recipList = ''>
<!--- product start values --->
<cfset product.qty_max = -99999>
<cfset product.price_low = 0>
<cfset product.price_high = 0>
<cfset product.price_alt_low = 0>
<cfset product.price_alt_high = 0>

<!--- use customer id from session if not provided --->
<cfif arguments.customer_id eq '0'
	AND isDefined('session.cwclient.cwCustomerID')
	AND session.cwclient.cwCustomerID neq '0'>
	<cfset arguments.customer_id = session.cwclient.cwCustomerID>
</cfif>

<!--- use customer type from session if not provtypeed --->
<cfif arguments.customer_type eq '0'
	AND isDefined('session.cwclient.cwCustomerType')
	AND session.cwclient.cwCustomerType neq '0'>
	<cfset arguments.customer_type = session.cwclient.cwCustomerType>
</cfif>

<!--- use promo code from session if not provided --->
<cfif arguments.promo_code eq ''
	AND isDefined('session.cwclient.discountPromoCode')
	AND session.cwclient.discountPromoCode neq ''>
	<cfset arguments.promo_code = session.cwclient.discountPromoCode>
</cfif>

<cfloop list="#detailsQuery.columnList#" index="ii">
	<cfset 'product.#ii#' = evaluate('detailsquery.#ii#')>
</cfloop>
<!--- /end product struct --->

<!--- skus child struct --->
<cfif datatype eq 'complex'>
<cfset product.skus = structNew()>
</cfif>
<!--- query: get product skus --->
<cfset skusQuery = CWquerySelectSKUs(arguments.product_ID)>
<!--- loop skus query --->

	<!--- set up sku struct, loop query --->
	<cfloop query="skusQuery">
		<cfset skuct = skuct + 1>
		<!--- create numbered substruct for each sku --->
		<cfif datatype eq 'complex'>
			<cfset 'product.skus.sku#skuct#' = structNew()>
			<cfloop list="#skusQuery.columnList#" index="ii">
			<cfset 'product.skus.sku#skuct#.#ii#' = evaluate('skusquery.#ii#')>
			</cfloop>
		</cfif>
			<cfset idList = listAppend(idList, skusquery.sku_id)>
		<!--- set high/low prices --->
		<cfif skusQuery.sku_price gt skupricehigh>
		<cfset skupricehigh = skusQuery.sku_price>
		<cfset product.price_high = skusQuery.sku_price>
		</cfif>
		<cfif skusQuery.sku_price lt skupricelow OR (skupricelow eq 0 and skusquery.sku_price neq 0)>
		<cfset skupricelow = skusQuery.sku_price>
		<cfset product.price_low = skusQuery.sku_price>
		</cfif>
		<!--- set alt price high/low --->
		<cfif skusQuery.sku_alt_price gt altpricehigh>
		<cfset altpricehigh = skusQuery.sku_alt_price>
		<cfset product.price_alt_high = skusQuery.sku_alt_price>
		</cfif>
		<cfif skusQuery.sku_alt_price lt altpricelow OR (altpricelow eq 0 and skusquery.sku_alt_price neq 0)>
		<cfset altpricelow = skusQuery.sku_alt_price>
		<cfset product.price_alt_low = skusQuery.sku_alt_price>
		</cfif>
		<!--- set discount price high/low --->
		<cfif application.cw.discountsEnabled>

			<!--- check for discounts applied to each sku --->
			<cfset discountAmount = CWgetSkuDiscountAmount(
									discount_type='sku_cost',
									sku_id=sku_id,
									customer_id=arguments.customer_id,
									customer_type=arguments.customer_type,
									promo_code=arguments.promo_code
									)>

			<!--- if a discount applies --->
			<cfif discountAmount gt 0>
				<cfset discountedPrice = skusQuery.sku_price - discountAmount>
				<cfif discountedPrice gt discPriceHigh>
					<cfset discpricehigh = discountedPrice>
					<cfset product.price_disc_high = discountedPrice>
				</cfif>
				<cfif discountedPrice lt discPriceLow OR (discPriceLow eq 0 and discountedPrice neq 0)>
					<cfset discPriceLow = discountedPrice>
					<cfset product.price_disc_low = discountedPrice>
				</cfif>
			</cfif>
		<cfelse>
			<cfset product.price_disc_low = discPriceLow>
			<cfset product.price_disc_high = discPriceLow>
		</cfif>

		<!--- set qty max for product --->
		<cfif skusQuery.sku_stock gt product.qty_max>
			<cfset product.qty_max = skusQuery.sku_stock>
		</cfif>
	</cfloop>
	<cfif product.price_low eq 0>
	<cfset product.price_low = product.price_high>
	</cfif>
	<cfif product.price_high eq 0>
	<cfset product.price_high = product.price_low>
	</cfif>
	<cfset product.sku_ids = idList>
	<cfset idlist = ''>

	<!--- format price strings --->
	<cfset product.price_high = numberFormat(product.price_high,'__.__')>
	<cfset product.price_low = numberFormat(product.price_low,'__.__')>
	<cfset product.price_alt_high = numberFormat(product.price_alt_high,'__.__')>
	<cfset product.price_alt_low = numberFormat(product.price_alt_low,'__.__')>
<!--- end skus/prices --->

<!--- images child struct --->
<cfif datatype eq 'complex'>
<cfset product.images = structNew()>
</cfif>

<!--- query: get product images --->
<cfset imagesQuery = CWquerySelectProductImages(arguments.product_ID)>
<!--- loop images query --->
<cfloop query="imagesQuery">
	<cfset imgct = imgct + 1>
	<cfif datatype eq 'complex'>
	<!--- create numbered substruct for each image --->
	<cfset 'product.images.image#imgct#' = structNew()>
	<cfloop list="#imagesQuery.columnList#" index="ii">
	<cfset 'product.images.image#imgct#.#ii#' = evaluate('imagesquery.#ii#')>
	</cfloop>
	</cfif>
	<!--- set up list of image ids --->
	<cfset image_typelist = listAppend(image_typeList, imagesQuery.product_image_id)>
	<!--- set up list of image filenames --->
	<cfif not listFindNoCase(imageList, imagesQuery.product_image_filename)>
	<cfset imageList = listAppend(imageList, imagesQuery.product_image_filename)>
	</cfif>
	<!--- set up list of image thumbnails --->
	<cfif imagesQuery.imagetype_folder is 'product_thumb' and not listFindNoCase(image_thumbnails, imagesQuery.product_image_filename)>
	<cfset image_thumbnails = listAppend(image_thumbnails,imagesQuery.product_image_filename)>
	</cfif>
</cfloop>
<cfset product.image_ids = image_typelist>
<cfset product.image_filenames = imagelist>
<cfset product.image_thumbnails = image_thumbnails>
<!--- /end images --->

<!--- category(ies) child struct --->
<cfif datatype eq 'complex'>
	<cfset product.categories_primary = structNew()>
	<!--- query: get product categories --->
	<cfset catsQuery = CWquerySelectRelCategories(arguments.product_ID)>
	<!--- loop query --->
	<cfloop query="catsQuery">
		<cfset catct = catct + 1>
		<!--- create numbered substruct for each category --->
		<cfset 'product.categories_primary.primary#catct#' = structNew()>
		<cfloop list="#catsQuery.columnList#" index="ii">
			<cfset 'product.categories_primary.primary#catct#.#ii#' = evaluate('catsquery.#ii#')>
		</cfloop>
		<!--- add to list of ids --->
		<cfset catList = listAppend(catList,catsQuery.category_id)>
	</cfloop>
	<cfset product.categories_primary_ids = catList>
	<cfset catList = ''>
</cfif>
<!--- /end categories --->

<!--- subcategory(ies) child struct --->
<cfif datatype eq 'complex'>
	<cfset product.categories_secondary = structNew()>
	<!--- query: get product secondary categories --->
	<cfset catsQuery = CWquerySelectRelScndCategories(arguments.product_ID)>
	<!--- loop query --->
	<cfset catCt = 0>
	<cfset catList = ''>
	<cfloop query="catsQuery">
		<cfset catct = catct + 1>
		<!--- create numbered substruct for each secondary category --->
		<cfset 'product.categories_secondary.secondary#catct#' = structNew()>
		<cfloop list="#catsQuery.columnList#" index="ii">
		<cfset 'product.categories_secondary.secondary#catct#.#ii#' = evaluate('catsquery.#ii#')>
		</cfloop>
		<!--- add to list of ids --->
		<cfset catList = listAppend(catList,catsQuery.secondary_id)>
	</cfloop>
	<cfset product.categories_secondary_ids = catList>
	<cfset catList = ''>
</cfif>
<!--- end subcategories --->

<!--- options child struct --->
<cfif not datatype eq 'mini'>
	<cfif datatype eq 'complex'>
	<cfset product.optiontypes = structNew()>
	</cfif>
	<!--- query: get options --->
	<cfset optionsQuery = CWquerySelectProductOptions(arguments.product_ID)>
	<!--- loop options query --->
	<cfoutput query="optionsQuery" group="optiontype_ID">
		<cfset optCt = optCt + 1>
		<!--- create numbered substruct for each optiontype --->
		<cfif datatype eq 'complex'>
			<cfset 'product.optiontypes.option#optCt#' = structNew()>
			<cfloop list="#optionsQuery.columnList#" index="ii">
				<cfif ii is 'option_values'>
					<cfoutput>
						<!--- add unique values only --->
						<cfif not listFind(optList,trim(evaluate('optionsQuery.#ii#')))>
							<cfset optList = listAppend(optList,trim(evaluate('optionsQuery.#ii#')))>
						</cfif>
					</cfoutput>
					<cfset 'product.optiontypes.option#optCt#.#ii#' = optList>
					<!--- all other columns appended here, except sku_option_id, used to get options but not needed here --->
				<cfelseif ii is not 'sku_option_id'>
					<cfset 'product.optiontypes.option#optCt#.#ii#' = evaluate('optionsQuery.#ii#')>
				</cfif>
			</cfloop>
		</cfif>
		<!--- add to id list --->
		<cfif not listFind(idList,trim(optionsQuery.optiontype_id))>
			<cfset idList = listAppend(idList,optionsQuery.optiontype_id)>
		</cfif>
	</cfoutput>
	<cfset product.optiontype_ids = idList>
	<cfset idList = ''>
</cfif>
<!--- /end options --->

<!--- related products id list --->
<cfif datatype eq 'complex' and not application.cw.appDisplayUpsell eq false>
	<cfset upsellQuery = CWquerySelectUpsellProducts(arguments.product_ID)>
	<cfloop query="upsellQuery">
		<cfset upsellList = listAppend(upsellList,upsellQuery.product_ID)>
	</cfloop>
<cfelse>
	<cfset upsellList = ''>
</cfif>
<cfset product.related_product_ids = upsellList>
<!--- /end related --->

<!--- reciprocal related products id list --->
<cfif datatype eq 'complex' and not application.cw.appDisplayUpsell eq false>
<cfset recipQuery = CWquerySelectReciprocalUpsellProducts(arguments.product_ID)>
	<cfloop query="recipQuery">
		<cfset recipList = listAppend(recipList,recipQuery.product_ID)>
	</cfloop>
<cfset product.related_reciprocal_ids = recipList>
</cfif>
<!--- /end reciprocal --->

<cfreturn product>
</cffunction>
</cfif>

<!--- // ---------- // Get Parent Product for Any SKU: CWgetProductBySku() // ---------- // --->
<cfif not isDefined('variables.CWgetProductBySku')>
<cffunction name="CWgetProductBySku"
			access="public"
			output="false"
			returntype="numeric"
			hint="returns the ID of the parent product for any SKU"
			>

		<cfargument name="sku_id"
			required="true"
			default="0"
			type="numeric"
			hint="Sku ID to look up">

	<cfset var returnVal = '0'>
	<cfset var skuQuery = ''>

	<cfquery name="skuQuery" datasource="#application.cw.dsn#" username="#application.cw.dsnUsername#" password="#application.cw.dsnPassword#">
	SELECT sku_product_id
	FROM cw_skus
	WHERE sku_id = <cfqueryparam value="#arguments.sku_id#" cfsqltype="cf_sql_integer">
	</cfquery>

	<cfif skuQuery.RecordCount neq 0>
		<cfset returnVal = skuQuery.sku_product_id>
	</cfif>

	<cfreturn returnVal>

</cffunction>
</cfif>

<!--- // ---------- // Get Custom Info Text: CWgetCustomInfo() // ---------- // --->
<cfif not isDefined('variables.CWgetCustomInfo')>
<cffunction name="CWgetCustomInfo"
			access="public"
			output="false"
			returntype="any"
			hint="Returns the custom value stored for a customized sku, based on phrase ID"
			>

	<cfargument name="phrase_id"
			required="true"
			type="string"
			hint="the ID of the custom value to look up">

	<cfset var lookup_id = val(arguments.phrase_id)>
	<cfset var returnVal = ''>
	<cfset var infoQuery = ''>

	<cfquery name="infoQuery" datasource="#application.cw.dsn#" username="#application.cw.dsnUsername#" password="#application.cw.dsnPassword#">
	SELECT data_content
	FROM cw_order_sku_data
	WHERE data_id = <cfqueryparam value="#lookup_id#" cfsqltype="cf_sql_integer">
	</cfquery>

	<cfif infoQuery.RecordCount neq 0>
		<cfset returnVal = infoQuery.data_content>
	</cfif>


	<cfreturn returnVal>

</cffunction>
</cfif>

<!--- // ---------- // Get Sku Quantity: CWgetSkuQty() // ---------- // --->
<cfif not isDefined('variables.CWgetSkuQty')>
<cffunction name="CWgetSkuQty"
			access="public"
			output="false"
			returntype="any"
			hint="returns quantity of any sku by ID or blank of sku not found"
			>
	<cfargument name="sku_id"
			required="true"
			default="0"
			type="numeric"
			hint="Sku ID to look up">

	<cfset var returnVal = ''>
	<cfset var skuQuery = ''>

	<cfquery name="skuQuery" datasource="#application.cw.dsn#" username="#application.cw.dsnUsername#" password="#application.cw.dsnPassword#">
	SELECT sku_stock
	FROM cw_skus
	WHERE sku_id = <cfqueryparam value="#arguments.sku_id#" cfsqltype="cf_sql_integer">
	</cfquery>

	<cfif skuQuery.RecordCount neq 0>
		<cfset returnVal = skuQuery.sku_stock>
	</cfif>

	<cfreturn returnVal>

</cffunction>
</cfif>

<!--- // ---------- // Get Product Display Status - true/false // ---------- // --->
<cfif not isDefined('variables.CWproductAvailable')>
<cffunction name="CWproductAvailable"
			access="public"
			output="false"
			returntype="boolean"
			hint="Returns true if product is ok for display, based on ID"
			>

	<cfargument required="true" name="product_id" type="numeric"
			hint="The ID of the product to look up">

<cfset var productOK = false>
<cfset var prodQuery = ''>

<cfquery name="prodQuery" datasource="#application.cw.dsn#" username="#application.cw.dsnUsername#" password="#application.cw.dsnPassword#">
SELECT DISTINCT p.product_id
FROM cw_products p, cw_skus s
	WHERE p.product_id = s.sku_product_id
	AND NOT p.product_on_web = 0
	AND NOT p.product_archive = 1
	<!--- if not allowing backorders, return stock gt 0 only --->
	<cfif application.cw.appEnableBackOrders eq 0>
		AND s.sku_stock > 0
	</cfif>
	AND NOT s.sku_on_web = 0
	AND p.product_id = <cfqueryparam value="#arguments.product_id#" cfsqltype="cf_sql_numeric">
</cfquery>

<cfif prodQuery.recordCount is 1>
<cfset productOk = true>
</cfif>

<cfreturn productOK>

</cffunction>
</cfif>

<!--- // ---------- // Get Product Image: CWgetImage() // ---------- // --->
<cfif not isDefined('variables.CWgetImage')>
<cffunction name="CWgetImage"
			access="public"
			output="false"
			returntype="string"
			hint="Returns full image url if file exists"
			>

	<cfargument required="true" name="product_id" type="numeric"
				hint="The ID of the product to look up">

	<cfargument required="true" name="image_type" type="string"
				hint="The image type to retrieve">

	<cfargument required="false" name="default_image" type="string" default=""
				hint="Default filename to use if image does not exist">

	<cfset var imageSrc = ''>
	<cfset var imagePath = ''>
	<cfset var imageDir = ''>
	<cfset var imageDirPath = ''>
	<cfset var defaultImageSrc = ''>
	<cfset var defaultImagePath = ''>
	<cfset var imageQuery = "">
	<cfset var imageDirQuery = "">
	<cfset var imageTypeDir = "">
	<cfset var returnSrc = "">

	<cfquery name="imageQuery" datasource="#application.cw.dsn#" username="#application.cw.dsnUsername#" password="#application.cw.dsnPassword#">
	SELECT cw_product_images.product_image_filename, cw_image_types.imagetype_folder
	FROM cw_image_types, cw_product_images
	WHERE cw_image_types.imagetype_id = cw_product_images.product_image_imagetype_id
	AND cw_product_images.product_image_product_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.product_id#">
	AND cw_product_images.product_image_imagetype_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.image_type#">
	</cfquery>

	<!--- if an image record is found, or default image is provided --->
	<cfif imageQuery.RecordCount neq 0 OR len(trim(arguments.default_image))>
		<!--- if going for default, we need the folder --->
		<cfif imageQuery.recordCount is 0>
			<cfquery name="imageDirQuery" maxrows="1" datasource="#application.cw.dsn#" username="#application.cw.dsnUsername#" password="#application.cw.dsnPassword#">
			SELECT cw_image_types.imagetype_folder
			FROM cw_image_types, cw_product_images
			WHERE cw_image_types.imagetype_id = cw_product_images.product_image_imagetype_id
			AND cw_product_images.product_image_imagetype_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.image_type#">
			</cfquery>
			<cfset imageTypeDir = imageDirQuery.imageType_folder>
		<cfelse>
			<cfset imageTypeDir = imageQuery.imageType_folder>
		</cfif>
		<!--- set up image paths and urls --->
		<cfset imageDir = cwTrailingChar(request.cw.assetSrcDir) & cwTrailingChar(cwLeadingChar(application.cw.appImagesDir,"remove")) & cwTrailingChar(imageTypeDir)>
		<cfset imageDirPath = expandPath(cwTrailingChar(application.cw.appCwContentDir) & cwTrailingChar(cwLeadingChar(application.cw.appImagesDir,"remove")) & cwTrailingChar(imageTypeDir))>
		<cfset imageSrc = imageDir & trim(imageQuery.product_image_filename)>
		<cfset imagePath = imageDirPath & trim(imageQuery.product_image_filename)>
		<cfset defaultImageSrc = imageDir & trim(arguments.default_image)>
		<cfset defaultImagePath = imageDirPath & trim(arguments.default_image)>
		<!--- if the file exists, return image src --->
		<cfif fileExists(imagePath)>
			<cfset returnSrc = imageSrc>
		<!--- if file does not exist, attempt default image --->
		<cfelseif len(trim(arguments.default_image)) and fileExists(defaultImagePath)>
			<cfset returnSrc = defaultImageSrc>
		</cfif>
	</cfif>
	<cfreturn returnSrc>
</cffunction>
</cfif>

<!--- // ---------- // Get Top Selling Products (by sku) // ---------- // --->
<cfif not isDefined('variables.CWgetBestSelling')>
<cffunction name="CWgetBestSelling"
			access="public"
			output="false"
			returntype="query"
			hint="Returns a query of top selling products, with option to insert placeholder for new stores"
			>

<cfargument name="max_products"
		required="false"
		default="5"
		type="numeric"
		hint="number of products to return">

<cfargument name="sub_ids"
		required="false"
		default="0"
		type="string"
		hint="IDs of products to be shown until order data is available">

<cfset var productQuery = ''>
<cfset var sortQuery = ''>
<cfset var idList = '#arguments.sub_ids#'>
<cfset var keyIds = ''>
<cfset var itemsToAdd = ''>
<cfif not IsNumeric(listFirst(idList))>
	<cfset idList = '0'>
</cfif>

<cfquery name="productQuery" datasource="#application.cw.dsn#" username="#application.cw.dsnUsername#" password="#application.cw.dsnPassword#" maxrows="#arguments.max_products#">
SELECT count(*) as prod_counter,
p.product_id,
p.product_name,
p.product_preview_description,
p.product_date_modified
FROM cw_products p
INNER JOIN cw_order_skus o
INNER JOIN cw_skus s
WHERE o.ordersku_sku = s.sku_id
AND s.sku_product_id = p.product_id
AND NOT p.product_on_web = 0
AND NOT p.product_archive = 1
AND NOT s.sku_on_web = 0
GROUP BY product_id
ORDER BY prod_counter DESC
</cfquery>

<cfset idList = listPrepend(idList,valueList(productQuery.product_id))>

<!--- if not enough results, fill in from sub_ids --->
<cfif productQuery.recordCount lt arguments.max_products>
	<!--- number needed --->
	<cfset itemsToAdd = arguments.max_products - productQuery.recordCount>
		<cfloop from="1" to="#itemsToAdd#" index="ii">
		<cfif listLen(idList) gte ii>
			<cfset keyIDs = listAppend(keyIds,listGetAt(idList,ii))>
		</cfif>
	</cfloop>

	<cfquery name="resultsQuery" datasource="#application.cw.dsn#" username="#application.cw.dsnUsername#" password="#application.cw.dsnPassword#" maxrows="#arguments.max_products#">
	SELECT 0 as prod_counter,
	p.product_id,
	p.product_name,
	p.product_preview_description,
	p.product_date_modified
	FROM cw_products p
	WHERE p.product_id in(#keyIds#)
	AND NOT p.product_on_web = 0
	AND NOT p.product_archive = 1
	ORDER BY product_date_modified DESC
	</cfquery>
<cfelse>
	<cfset resultsQuery = productQuery>
</cfif>

<!--- sort the results --->
<cfquery name="sortQuery" dbtype="query" maxrows="#arguments.max_products#">
SELECT *
FROM resultsQuery
ORDER BY prod_counter DESC, product_date_modified
</cfquery>

<cfreturn sortQuery>

</cffunction>
</cfif>

<!--- // ---------- // Get Category or Subcategory Text for Listings Page // ---------- // --->
<cfif not isDefined('variables.CWgetListingText')>
<cffunction name="CWgetListingText"
			access="public"
			output="false"
			returntype="string"
			hint="Accepts a category ID and/or subcategory ID, and returns text descriptions from CW admin"
			>

	<cfargument name="category_id"
			required="false"
			default="0"
			type="numeric"
			hint="ID of category">

	<cfargument name="secondary_id"
			required="false"
			default="0"
			type="numeric"
			hint="ID of secondary category">

	<cfset var catQuery = ''>
	<cfset var secondQuery = ''>
	<cfset var catText = ''>
	<cfset var secondText = ''>

	<!--- category description --->
	<cfif arguments.category_id gt 0>
	<cfquery name="catQuery" datasource="#application.cw.dsn#" username="#application.cw.dsnUsername#" password="#application.cw.dsnPassword#">
	SELECT category_description
	FROM cw_categories_primary
	WHERE category_id = #arguments.category_id#
	</cfquery>
		<!--- trim and save the output --->
		<cfif len(trim(catQuery.category_description))>
			<cfset catText = trim(catQuery.category_description)>
		</cfif>
	</cfif>

	<!--- secondary description --->
	<cfif arguments.secondary_id gt 0>
	<cfquery name="secondQuery" datasource="#application.cw.dsn#" username="#application.cw.dsnUsername#" password="#application.cw.dsnPassword#">
	SELECT secondary_description
	FROM cw_categories_secondary
	WHERE secondary_id = #arguments.secondary_id#
	</cfquery>
		<!--- trim and save the output --->
		<cfif len(trim(secondQuery.secondary_description))>
			<cfset secondText = trim(secondQuery.secondary_description)>
		</cfif>
	</cfif>

	<!--- combine content if both exist --->
	<cfset returnText = catText & secondText>
	<cfreturn returnText>

</cffunction>
</cfif>

<!--- // ---------- // Get Products by Customer: CWgetProductsByCustomer() // ---------- // --->
<cfif not isDefined('variables.CWgetProductsByCustomer')>
<cffunction name="CWgetProductsByCustomer"
			access="public"
			output="false"
			returntype="query"
			hint="Returns all products purchased by a customer"
			>

	<cfargument name="customer_id"
			required="true"
			type="string"
			hint="ID of the customer to look up- usually session.cwclient.cwCustomerID">

<cfset var customerProductQuery = ''>

<cfquery name="customerProductQuery" datasource="#application.cw.dsn#" username="#application.cw.dsnUsername#" password="#application.cw.dsnPassword#">
SELECT DISTINCT p.product_id,
p.product_name,
p.product_preview_description,
p.product_date_modified,
p.product_on_web,
p.product_archive,
s.sku_on_web,
s.sku_id,
o.order_date,
o.order_id,
os.ordersku_unique_id,
os.ordersku_unit_price,
os.ordersku_quantity
FROM cw_products p, cw_order_skus os, cw_skus s, cw_orders o
WHERE os.ordersku_sku = s.sku_id
AND s.sku_product_id = p.product_id
AND o.order_customer_id = <cfqueryparam value="#arguments.customer_id#" cfsqltype="cf_sql_varchar">
AND o.order_id = os.ordersku_order_id
ORDER BY
p.product_name,
o.order_date DESC,
p.product_preview_description,
p.product_date_modified,
p.product_on_web,
p.product_archive,
s.sku_on_web,
s.sku_id,
o.order_id,
os.ordersku_unique_id,
os.ordersku_unit_price,
os.ordersku_quantity
</cfquery>

<cfreturn customerProductQuery>

</cffunction>
</cfif>

<!--- // ---------- Get Products (CARTWEAVER SEARCH) ---------- // --->
<cfif not isDefined('variables.CWqueryProductSearch')>
<cffunction name="CWqueryProductSearch" access="public" output="false" returntype="struct"
			hint="Returns a simple structure: list of product IDs / total records found">

	<cfargument required="false" name="category" type="numeric" default="0"
				hint="The ID of the category to look up">
	<cfargument required="false" name="secondary" type="numeric" default="0"
				hint="The ID of the secondary category to look up">
	<cfargument required="false" name="keywords" type="string" default=""
				hint="Text string to match">
	<cfargument required="false" name="keywords_delimiters" type="string" default=",-|:"
				hint="The delimiter(s) to use for keyword separation, can accept multiple characters">
	<cfargument required="false" name="start_page" type="numeric" default="1"
				hint="Page number to start on">
	<cfargument required="false" name="max_rows" type="numeric" default="1000"
				hint="Maximum results to return">
	<cfargument required="false" name="sort_by" type="string" default="p.product_sort, p.product_name"
				hint="Column name to sort results by">
	<cfargument required="false" name="sort_dir" type="string" default="asc"
				hint="Ascending or descending sort order (asc|desc)">
	<cfargument required="false" name="start_row" type="numeric" default="0"
				hint="The starting row of the query results to return (0=default)">
	<cfargument required="false" name="end_row" type="numeric" default="0"
				hint="The ending row of the query results to return (0=default)">
	<cfargument required="false" name="search_skus" type="boolean" default="1"
				hint="Include sku merchant IDs in product keyword search">
	<cfargument required="false" name="match_type" type="string" default="any"
				hint="possible values (any|all|phrase) matches any word, all words, full phrase">

<cfset var sortbystr = trim(arguments.sort_by)>
<cfset var sortdirstr = lcase(trim(arguments.sort_dir))>
<cfset var results = structNew()>
<!--- delimiters for looping keyword list --->
<cfset var delimList = trim(arguments.keywords_delimiters)>
<cfset var delimChar = ''>
<cfset var delimEsc = ''>
<cfset var wordList = ''>
<cfset var wordListStruct = structNew()>
<cfset var i = ''>
<!--- count Search Results (sr) --->
<cfset var srCount = 0>
<!--- set up default list of IDs --->
<cfset var idArr = arrayNew(1)>
<cfset var idUnique = structNew()>
<cfset var idList = ''>
<cfset var returnIDs = ''>

<!--- strip keyword values into a list of clean strings --->
<cfif len(delimList)>
<cfloop from="1" to="#len(delimList)#" index="i">
	<cfset delimChar = mid(delimList,i,1)>
	<cfset delimEsc = delimEsc & '\' & delimChar>
</cfloop>
</cfif>
<!--- replace all non-permitted characters with a space, then replace spaces with comma for search list, make lowercase --->
<cfset wordList = lcase(replace(rereplace(replace(arguments.keywords,'&quot;',' ','all'),"[^a-zA-Z0-9#delimEsc#]"," ","ALL"),' ',',','all'))>
<!--- only allow unique values --->
<cfloop list="#wordList#" index="i">
	<cfset wordListStruct[i] = i>
</cfloop>
<cfset wordList = structKeyList(wordListStruct)>

<!--- calculate start and end for final results --->
<cfif arguments.start_row eq 0>
	<cfset arguments.start_row = (arguments.start_page * arguments.max_rows) - arguments.max_rows + 1>
</cfif>
<cfif arguments.end_row eq 0>
	<cfset arguments.end_row = arguments.start_row + arguments.max_rows - 1>
</cfif>

<!--- add actual column names to sortable strings: price|name|sort|id --->
<cfif sortbystr is 'price'>
	<cfset sortbystr = 's.sku_price'>
	<cfset sortbyrem = ', p.product_sort, p.product_name, p.product_id, s.sku_id'>
<cfelseif sortbystr is 'name'>
	<cfset sortbystr = 'p.product_name'>
	<cfset sortbyrem = ', p.product_sort, s.sku_price, p.product_id, s.sku_id'>
<cfelseif sortbystr is 'sort'>
	<cfset sortbystr = 'p.product_sort'>
	<cfset sortbyrem = ', p.product_name, s.sku_price, p.product_id, s.sku_id'>
<cfelseif sortbystr is 'id'>
	<cfset sortbystr = 's.sku_id'>
	<cfset sortbyrem = ', p.product_sort, p.product_name, s.sku_price, p.product_id'>
<cfelse>
	<cfset sortbystr = 'p.product_sort, p.product_name'>
	<cfset sortbyrem = ', s.sku_price, p.product_id, s.sku_id'>
</cfif>

<!--- verify and clean up sort direction string: asc|desc --->
<cfif not (sortdirstr is 'asc' or sortdirstr is 'desc')>
	<cfset sortdirstr = 'asc'>
</cfif>
<!--- default values --->

<cfquery name="rsProductSearch" datasource="#application.cw.dsn#" username="#application.cw.dsnUsername#" password="#application.cw.dsnPassword#">
SELECT DISTINCT p.product_id, p.product_sort, p.product_name, s.sku_price as sku_price, s.sku_id
FROM
 <cfif arguments.secondary neq 0>(</cfif>
	(cw_products p
	INNER JOIN cw_skus s
	ON p.product_id = s.sku_product_id)
<cfif arguments.secondary neq 0>
	LEFT JOIN cw_product_categories_secondary sc
	ON p.product_id = sc.product2secondary_product_id)
</cfif>
<cfif arguments.category neq 0>
	LEFT JOIN cw_product_categories_primary pc
	ON p.product_id = pc.product2category_product_id
</cfif>
WHERE
	NOT p.product_on_web = 0
	AND NOT p.product_archive = 1
	<!--- if not allowing backorders, return stock gt 0 only --->
	<cfif application.cw.appEnableBackOrders eq 0>
		AND s.sku_stock > 0
	</cfif>
	<!--- if keyword string provided --->
	<cfif trim(arguments.keywords) neq "">
		<!--- first condition holds optional or statements open --->
		AND (1=0
		<cfswitch expression="#arguments.match_type#">
			<!--- match all search terms --->
			<cfcase value="all">
				OR
				(
				<cfloop index="searchTerm" list="#wordList#" delimiters="#delimList#">
				#application.cw.sqlLower#(p.product_name) LIKE '%#trim(searchTerm)#%'
					<cfif trim(searchTerm) neq trim(listLast(wordList,delimList))> AND </cfif>
				</cfloop>
				)
				OR
				(
				<cfloop index="searchTerm" list="#wordList#" delimiters="#delimList#">
					#application.cw.sqlLower#(p.product_preview_description) LIKE '%#trim(searchTerm)#%'
					<cfif trim(searchTerm) neq trim(listLast(wordList,delimList))> AND </cfif>
				</cfloop>
				)
				OR
				(
				<cfloop index="searchTerm" list="#wordList#" delimiters="#delimList#">
					#application.cw.sqlLower#(p.product_special_description) LIKE '%#trim(searchTerm)#%'
					<cfif trim(searchTerm) neq trim(listLast(wordList,delimList))> AND </cfif>
				</cfloop>
				)
				OR
				(
				<cfloop index="searchTerm" list="#wordList#" delimiters="#delimList#">
					 #application.cw.sqlLower#(p.product_description) LIKE '%#trim(searchTerm)#%'
					<cfif trim(searchTerm) neq trim(listLast(wordList,delimList))> AND </cfif>
				</cfloop>
				)
				OR
				(
				<cfloop index="searchTerm" list="#wordList#" delimiters="#delimList#">
					#application.cw.sqlLower#(p.product_keywords) LIKE '%#trim(searchTerm)#%'
					<cfif trim(searchTerm) neq trim(listLast(wordList,delimList))> AND </cfif>
				</cfloop>
				)
				<cfif arguments.search_skus>
					OR(
					<cfloop index="searchTerm" list="#wordList#" delimiters="#delimList#">
						#application.cw.sqlLower#(s.sku_merchant_sku_id) LIKE '%#trim(searchTerm)#%'
						<cfif trim(searchTerm) neq trim(listLast(wordList,delimList))> AND </cfif>
					</cfloop>
					)
				</cfif>
			</cfcase>
			<!--- /end match=all --->
			<!--- match exact search phrase --->
			<cfcase value="phrase">
				<!--- replace our word list delimiters with spaces --->
				<cfset searchTerm = wordList>
				<cfloop from="1" to="#len(delimList)#" index="i">
					<cfset delimChar = mid(delimList,i,1)>
					<cfset searchTerm = replace(searchTerm,delimChar,' ','all')>
				</cfloop>
				OR
				(
				#application.cw.sqlLower#(p.product_name) LIKE '%#trim(searchTerm)#%'
				)
				OR
				(
					#application.cw.sqlLower#(p.product_preview_description) LIKE '%#trim(searchTerm)#%'
				)
				OR
				(
					#application.cw.sqlLower#(p.product_special_description) LIKE '%#trim(searchTerm)#%'
				)
				OR
				(
					 #application.cw.sqlLower#(p.product_description) LIKE '%#trim(searchTerm)#%'
				)
				OR
				(
					#application.cw.sqlLower#(p.product_keywords) LIKE '%#trim(searchTerm)#%'
				)
				<cfif arguments.search_skus>
				OR(
					#application.cw.sqlLower#(s.sku_merchant_sku_id) LIKE '%#trim(searchTerm)#%'
				)
				</cfif>
			</cfcase>
			<!--- /end match=all --->
			<!--- match any word (default) --->
			<cfdefaultcase>
				<!--- loop string of keywords --->
				<cfloop index="searchTerm" list="#wordList#" delimiters="#delimList#">
					OR #application.cw.sqlLower#(p.product_name) LIKE '%#trim(searchTerm)#%'
				</cfloop>
				<cfloop index="searchTerm" list="#wordList#" delimiters="#delimList#">
					OR #application.cw.sqlLower#(p.product_preview_description) LIKE '%#trim(searchTerm)#%'
				</cfloop>
				<cfloop index="searchTerm" list="#wordList#" delimiters="#delimList#">
					OR #application.cw.sqlLower#(p.product_special_description) LIKE '%#trim(searchTerm)#%'
				</cfloop>
				<cfloop index="searchTerm" list="#wordList#" delimiters="#delimList#">
					OR #application.cw.sqlLower#(p.product_description) LIKE '%#trim(searchTerm)#%'
				</cfloop>
				<cfloop index="searchTerm" list="#wordList#" delimiters="#delimList#">
					OR #application.cw.sqlLower#(p.product_keywords) LIKE '%#trim(searchTerm)#%'
				</cfloop>
				<cfif arguments.search_skus>
					<cfloop index="searchTerm" list="#wordList#" delimiters="#delimList#">
						OR #application.cw.sqlLower#(s.sku_merchant_sku_id) LIKE '%#trim(searchTerm)#%'
					</cfloop>
				</cfif>
			</cfdefaultcase>
			<!--- /end match=any --->
		</cfswitch>
		)
	</cfif>
	<!--- /end keywords --->
	<!--- categories / secondaries --->
	<cfif arguments.category neq 0>
		AND pc.product2category_category_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.category#">
	</cfif>
	<cfif arguments.secondary neq 0>
		AND sc.product2secondary_secondary_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.secondary#">
	</cfif>
	<!--- /end categories / secondaries --->
	AND NOT s.sku_on_web = 0
	GROUP BY #sortbystr# #sortbyrem#
	ORDER BY #sortbystr# #sortdirstr# #sortbyrem#
</cfquery>

<!--- set up unique list of IDs --->
<cfloop list = "#valueList(rsProductSearch.product_id)#" index="i">
	<cfif not structKeyExists(idUnique,i)>
		<cfset arrayAppend(idArr,i)>
		<cfset idUnique[i] = true>
	</cfif>
</cfloop>

<cfset idList = arrayToList(idArr)>

<!--- count Search Results (sr) --->
<cfset srCount = listLen(idList)>

<!--- get just the records we want to return --->
<cfif srCount gt 0>
	<!--- if endrow gt actual records, set to match --->
	<cfif arguments.end_row gt srCount>
		<cfset arguments.end_row = srCount>
	</cfif>
	<!--- if startrow gt actual records, sort out start row --->
	<cfif arguments.start_row gt SRcount>
		<cfset arguments.start_row = fix(srCount/arguments.max_rows) * arguments.max_rows + 1>
	</cfif>
	<!--- create new ID list --->
	<cfloop from="#arguments.start_row#" to="#arguments.end_row#" index="ii">
		<cfset returnIDs = listAppend(returnIDs, listGetAt(idList, ii))>
	</cfloop>
	<cfset results.count = srCount>
	<!--- return '0' if no list is found --->
<cfelse>
	<cfset returnIDs = '0'>
	<cfset results.count = 0>
</cfif>

<cfset results.idList = returnIDs>

<cfreturn results>
</cffunction>
</cfif>

<!--- // ---------- Get Product Details ---------- // --->
<cfif not isDefined('variables.CWquerySelectProductDetails')>
<cffunction name="CWquerySelectProductDetails" access="public" output="false" returntype="query"
			hint="Returns all columns from the products table">

	<cfargument required="true" name="product_id" type="numeric"
				hint="The ID of the product to look up">

<cfset var productDetailsQuery = "">

	<!--- get from application if available --->
	<cfif structKeyExists(application.cwdata.productdata,arguments.product_id)>
		<cfset productDetailsQuery = QueryNew(structKeyList(application.cwdata.productdata[arguments.product_id]))>
		<cfset queryAddRow(productDetailsQuery)>
		<cfloop list="#structKeyList(application.cwdata.productdata[arguments.product_id])#" index="i">
			<cfset querySetCell(productDetailsQuery,i,application.cwdata.productdata[arguments.product_id][i],1)>
		</cfloop>
	<cfelse>
		<cfquery name="productDetailsQuery" datasource="#application.cw.dsn#" username="#application.cw.dsnUsername#" password="#application.cw.dsnPassword#">
			SELECT product_id,
		 	product_merchant_product_id,
		 	product_name,
		 	product_description,
		 	product_preview_description,
		 	product_sort,
		 	product_on_web,
		 	product_archive,
		 	product_ship_charge,
		 	product_tax_group_id,
		 	product_date_modified,
		 	product_special_description,
		 	product_keywords,
		 	product_out_of_stock_message,
		 	product_custom_info_label
		 	FROM cw_products
		 	WHERE product_id = #arguments.product_id#
		</cfquery>
	</cfif>

<cfreturn productDetailsQuery>
</cffunction>
</cfif>

<!--- // ---------- List Product skus ---------- // --->
<cfif not isDefined('variables.CWquerySelectskus')>
<cffunction name="CWquerySelectskus" access="public" output="false" returntype="query"
			hint="Returns all skus for a product">

	<cfargument name="product_id" type="numeric" required="true"
				hint="ID of Product to look up">

	<cfargument name="omit_inactive" type="boolean" required="true"
				hint="if false, all skus are shown regardless of stock or onweb" default="true">

<cfset var skusQuery = "">

	<!--- get from application if available --->
	<cfif structKeyExists(application.cwdata.productdata,arguments.product_id)>
		<cfquery name="skusQuery" dbtype="query">
			SELECT sku_id,
			sku_merchant_sku_id,
			sku_product_id,
			sku_price,
			sku_weight,
			sku_stock,
			sku_on_web,
			sku_sort,
			sku_alt_price,
			sku_ship_base
			FROM application.cwdata.skusquery
			WHERE sku_product_id = #arguments.product_id#
			<cfif arguments.omit_inactive>
				AND not sku_on_web = 0
				<cfif application.cw.appEnableBackOrders eq 0>
					AND sku_stock > 0
				</cfif>
			</cfif>
			ORDER BY sku_sort, sku_price
		</cfquery>
	<cfelse>
		<cfquery name="skusQuery" datasource="#application.cw.dsn#" username="#application.cw.dsnUsername#" password="#application.cw.dsnPassword#">
			SELECT sku_id,
			sku_merchant_sku_id,
			sku_product_id,
			sku_price,
			sku_weight,
			sku_stock,
			sku_on_web,
			sku_sort,
			sku_alt_price,
			sku_ship_base
			FROM cw_skus
			WHERE sku_product_id = #arguments.product_id#
			<cfif arguments.omit_inactive>
				AND not sku_on_web = 0
				<cfif application.cw.appEnableBackOrders eq 0>
					AND sku_stock > 0
				</cfif>
			</cfif>
			ORDER BY sku_sort, sku_price
		</cfquery>
	</cfif>
<cfreturn skusQuery>
</cffunction>
</cfif>

<!--- // ---------- Get SKU Options ---------- // --->
<cfif not isDefined('variables.CWquerySelectSkuOptions')>
<cffunction name="CWquerySelectSkuOptions"
			access="public"
			output="false"
			returntype="query"
			hint="selects all skus with options and price info for tabular product option display"
			>

	<!--- product_id is required --->
	<cfargument name="product_id" type="numeric" required="true"
				hint="ID of Product to look up">

	<!--- sku_id is optional, returns only the specified sku --->
	<cfargument name="sku_id" type="numeric" required="false" default="0"
				hint="ID of SKU to look up">

<cfset var rsGetskuOptions = ''>
<cfquery name="rsGetskuOptions" datasource="#application.cw.dsn#" username="#application.cw.dsnUsername#" password="#application.cw.dsnPassword#">
SELECT
	cw_option_types.optiontype_name,
	cw_skus.sku_id,
	cw_skus.sku_merchant_sku_id,
	cw_skus.sku_price,
	cw_skus.sku_alt_price,
	cw_skus.sku_ship_base,
	cw_skus.sku_sort,
	cw_options.option_name,
	cw_options.option_sort,
	cw_skus.sku_stock,
	cw_options.option_id
FROM cw_skus
INNER JOIN ((cw_option_types
	INNER JOIN cw_options
		ON cw_option_types.optiontype_id = cw_options.option_type_id)
		INNER JOIN cw_sku_options
			ON cw_options.option_id = cw_sku_options.sku_option2option_id)
ON cw_skus.sku_id = cw_sku_options.sku_option2sku_id
WHERE
	cw_skus.sku_product_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.product_ID#">
	AND NOT cw_skus.sku_on_web = 0
	<cfif application.cw.appEnableBackOrders eq 0>
		AND cw_skus.sku_stock > 0
	</cfif>
	<cfif arguments.sku_id gt 0>
		AND cw_skus.sku_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.sku_ID#">
	</cfif>
ORDER BY cw_skus.sku_sort, cw_skus.sku_merchant_sku_id, cw_options.option_sort
</cfquery>
<cfreturn rsGetSkuOptions>
</cffunction>
</cfif>

<!--- // ---------- Get Sku Details // ---------- // --->
<cfif not isDefined('variables.CWquerySkuDetails')>
<cffunction name="CWquerySkuDetails"
			access="public"
			output="false"
			returntype="query"
			hint="returns a query with details about any sku"
			>

		<cfargument name="sku_id"
			required="true"
			default="0"
			type="numeric"
			hint="Sku ID to look up">

	<cfset var skuQuery = ''>
	<cfset var i = ''>

	<!--- get from application if available --->
	<cfif structKeyExists(application.cwdata.skudata,arguments.sku_id)>
		<cfset skuQuery = QueryNew(structKeyList(application.cwdata.skudata[arguments.sku_id]))>
		<cfset queryAddRow(skuQuery)>
		<cfloop list="#structKeyList(application.cwdata.skudata[arguments.sku_id])#" index="i">
			<cfset querySetCell(skuQuery,i,application.cwdata.skudata[arguments.sku_id][i],1)>
		</cfloop>
	<cfelse>
		<cfquery name="skuQuery" datasource="#application.cw.dsn#" username="#application.cw.dsnUsername#" password="#application.cw.dsnPassword#">
		SELECT
		s.sku_id,
		s.sku_merchant_sku_id,
		s.sku_product_id,
		s.sku_price,
		s.sku_weight,
		s.sku_stock,
		s.sku_on_web,
		s.sku_alt_price,
		s.sku_ship_base
		FROM cw_skus s
		WHERE sku_id = <cfqueryparam value="#arguments.sku_id#" cfsqltype="cf_sql_integer">
		</cfquery>
	</cfif>

	<cfreturn skuQuery>
</cffunction>
</cfif>

<!--- // ---------- // Set SKU Stock Quantity // ---------- // --->
<cfif not isDefined('variables.CWsetSkuStock')>
<cffunction name="CWsetSkuStock"
			access="public"
			output="false"
			returntype="void"
			hint="Reduces SKU qty by the number provided"
			>

	<cfargument name="sku_id"
			required="true"
			default=""
			type="numeric"
			hint="ID of the sku to adjust quantity">

	<cfargument name="qty_purchased"
			required="false"
			default="1"
			type="any"
			hint="Amount to subtract from quantity">

	<cfargument name="reload_appdata"
				required="false"
				default="true"
				type="boolean"
				hint="if true, content is reset in application scope">

	<cfset var rsUpdateSku = ''>
	<cfset var temp = ''>

	<cfquery name="rsUpdateSku" datasource="#application.cw.dsn#" username="#application.cw.dsnUsername#" password="#application.cw.dsnPassword#">
		UPDATE cw_skus
		SET sku_stock = sku_stock - <cfqueryparam value="#arguments.qty_purchased#" cfsqltype="cf_sql_numeric">
		WHERE sku_id = <cfqueryparam value="#arguments.sku_id#" cfsqltype="cf_sql_integer">
	</cfquery>

	<!--- reload saved data --->
	<cfif arguments.reload_appdata>
		<cftry>
		<cfset temp = CWinitSkuData()>
		<cfcatch>
		</cfcatch>
		</cftry>
	</cfif>

</cffunction>
</cfif>

<!--- // ---------- List Product Images ---------- // --->
<cfif not isDefined('variables.CWquerySelectProductImages')>
<cffunction name="CWquerySelectProductImages" access="public" returntype="query" output="false"
			hint="Returns all image information for images associated with a given product - pass in ID of 0 to get all">

	<cfargument name="product_id" required="false" default="0" type="numeric"
				hint="the Product ID to look up">

	<cfargument name="imagetype_id" required="false" default="0" type="numeric"
				hint="specific image type from cw_image_types">

	<cfargument name="imagetype_upload_group" required="false" default="0" type="numeric"
				hint="return all image sizes for a specific upload group">

<cfset var rsProductImages = "">
<cfquery name="rsProductImages" datasource="#application.cw.dsn#" username="#application.cw.dsnUsername#" password="#application.cw.dsnPassword#">
	SELECT *
	FROM cw_product_images ii, cw_image_types tt
	WHERE tt.imagetype_id = ii.product_image_imagetype_id
	<cfif arguments.product_id gt 0>
	AND ii.product_image_product_id = #arguments.product_id#
	</cfif>
	<cfif arguments.imagetype_id gt 0>
	AND ii.product_image_imagetype_id = #arguments.imagetype_id#
	</cfif>
	<cfif arguments.imagetype_upload_group gt 0>
	AND tt.imagetype_upload_group = #arguments.imagetype_upload_group#
	</cfif>
	ORDER BY ii.product_image_sortorder, tt.imagetype_sortorder, tt.imagetype_upload_group
</cfquery>
<cfreturn rsProductImages>
</cffunction>
</cfif>

<!--- // ---------- Get Product Related Categories ---------- // --->
<cfif not isDefined('variables.CWquerySelectRelCategories')>
<cffunction name="CWquerySelectRelCategories" access="public" output="false" returntype="query"
			hint="Returns all selected categories for a given product">

	<cfargument name="product_id" required="true" type="numeric"
				hint="ID of product to look up">

<cfset var rsRelCategories = "">
<cfquery name="rsRelCategories" datasource="#application.cw.dsn#" username="#application.cw.dsnUsername#" password="#application.cw.dsnPassword#">
SELECT cc.category_id, cc.category_name
FROM cw_product_categories_primary rr, cw_categories_primary cc
WHERE rr.product2category_product_id = #arguments.product_id#
AND cc.category_id = rr.product2category_category_id
</cfquery>
<cfreturn rsRelCategories>
</cffunction>
</cfif>

<!--- // ---------- Get Product Related Secondary Categories ---------- // --->
<cfif not isDefined('variables.CWquerySelectRelScndCategories')>
<cffunction name="CWquerySelectRelScndCategories" access="public" output="false" returntype="query"
			hint="Returns all selected secondary categories for a given product">

	<cfargument name="product_id" required="true" type="numeric"
				hint="ID of product to look up">

<cfset var rsRelScndCategories = "">
<cfquery name="rsRelScndCategories" datasource="#application.cw.dsn#" username="#application.cw.dsnUsername#" password="#application.cw.dsnPassword#">
SELECT sc.secondary_id, sc.secondary_name
FROM cw_product_categories_secondary rr, cw_categories_secondary sc
WHERE rr.product2secondary_product_id = #arguments.product_id#
AND sc.secondary_id = rr.product2secondary_secondary_id
</cfquery>
<cfreturn rsRelScndCategories>
</cffunction>
</cfif>

<!--- // ---------- Get Product Related Options  ---------- // --->
<cfif not isDefined('variables.CWquerySelectProductOptions')>
<cffunction name="CWquerySelectProductOptions" access="public" returntype="query"  output="false"
			hint="Returns query of all active options">

	<cfargument name="product_id" required="false" type="numeric" default="0"
				hint="Optional Product ID - returns only options associated w/ this product">

<cfset var rsListOptions = "">

<cfquery name="rsListOptions" datasource="#application.cw.dsn#" username="#application.cw.dsnUsername#" password="#application.cw.dsnPassword#">
	SELECT DISTINCT
		<cfif arguments.product_id gt 0>
		cw_sku_options.sku_option_id,
		</cfif>
		cw_option_types.optiontype_id,
		cw_option_types.optiontype_name,
		cw_option_types.optiontype_sort
		<cfif arguments.product_id gt 0>
		,cw_options.option_name as option_values
		,cw_options.option_sort
		</cfif>
	FROM
		<cfif arguments.product_id gt 0>
	cw_products
	INNER JOIN ((((
			cw_skus
				INNER JOIN cw_sku_options
				ON cw_sku_options.sku_option2sku_id = cw_skus.sku_id)
					INNER JOIN cw_options
					ON cw_options.option_id = cw_sku_options.sku_option2option_id)
						INNER JOIN cw_product_options
 						ON cw_product_options.product_options2prod_id = #arguments.product_id#)
							INNER JOIN cw_option_types
							ON cw_option_types.optiontype_id = cw_product_options.product_options2optiontype_id)
			ON cw_skus.sku_product_ID = #arguments.product_id#
	WHERE cw_products.product_id= #arguments.product_id#
	AND cw_option_types.optiontype_id = cw_options.option_type_id
	AND NOT cw_options.option_archive = 1
		<cfelse>
	cw_skus
	INNER JOIN ((
		cw_sku_options
				INNER JOIN cw_options
				ON cw_options.option_id = cw_sku_options.sku_option2option_id)
						INNER JOIN cw_option_types
						ON cw_option_types.optiontype_id = cw_options.option_type_id)
		ON cw_sku_options.sku_option2sku_id = cw_skus.sku_id
	WHERE NOT optiontype_archive = 1
	AND NOT optiontype_deleted = 1
		</cfif>
	ORDER BY
		<cfif arguments.product_id gt 0>
		cw_option_types.optiontype_sort, cw_sku_options.sku_option_id,
		</cfif>
		cw_option_types.optiontype_name
		<cfif arguments.product_id gt 0>
		,cw_options.option_sort
		</cfif>
		,cw_options.option_name
		,cw_option_types.optiontype_id
</cfquery>

<cfreturn rsListOptions>
</cffunction>
</cfif>

<!--- // ---------- List Related Product Options  ---------- // --->
<cfif not isDefined('variables.CWquerySelectRelOptions')>
<cffunction name="CWquerySelectRelOptions" access="public" returntype="query" output="false"
			hint="Returns a query of relative options for a product">

	<cfargument name="product_id"
				type="numeric"
				required="true"
				hint="ID of Product to look up"
				>

	<cfargument name="product_options"
				type="string"
				required="false"
				default=""
				hint="Comma separated list of option group IDs to filter query by"
				>

	<cfargument name="allow_backorders"
				type="string"
				required="false"
				default="#application.cw.appEnableBackOrders#"
				hint="Comma separated list of option group IDs to filter query by"
				>

<cfset var rsGetOptnRelIDs = "">
<cfquery name="rsGetOptnRelIDs" datasource="#application.cw.dsn#" username="#application.cw.dsnUsername#" password="#application.cw.dsnPassword#">
  SELECT cw_sku_options.sku_option_id,
		 cw_options.option_name,

		 <!---cw_options.option_hex,
		 cw_options.option_texture,--->
		 cw_options.option_sort,
		 cw_options.option_id,
		 cw_skus.sku_merchant_sku_id,
		 cw_skus.sku_id,
		 cw_skus.sku_stock,
		 cw_option_types.optiontype_text,
		 cw_option_types.optiontype_iscolor,
		 cw_option_types.optiontype_name
	FROM ((cw_skus
		INNER JOIN cw_sku_options
				ON cw_skus.sku_id = cw_sku_options.sku_option2sku_id)
				INNER JOIN cw_options
				ON cw_options.option_id = cw_sku_options.sku_option2option_id)
			INNER JOIN cw_option_types
					ON cw_option_types.optiontype_ID = cw_options.option_type_id
	WHERE cw_skus.sku_product_id = #arguments.product_id#
	AND NOT cw_skus.sku_on_web = 0
		<cfif arguments.allow_backorders neq true>
		AND cw_skus.sku_stock > 0
		</cfif>
       <!--- only use this if there are some options --->
       <cfif listlen(arguments.product_options) gt 0 and isNumeric(listFirst(arguments.product_options))>
	AND cw_options.option_type_id IN (#arguments.product_options#)
       </cfif>
	ORDER BY cw_options.option_sort,
			 cw_options.option_name
</cfquery>

<cfreturn rsGetOptnRelIDs>
</cffunction>
</cfif>

<!--- // ---------- Get Product Optiontypes IDs ---------- // --->
<cfif not isDefined('variables.CWquerySelectOptiontypes')>
<cffunction name="CWquerySelectOptiontypes" access="public" returntype="query"  output="false"
			hint="Returns query of all active options">

	<cfargument name="product_id" required="false" type="numeric" default="0"
				hint="Optional Product ID - pass in blank or 0 to get all active optiontypes">

<cfset var rsListOptions = "">
<cfquery name="rsListOptions" datasource="#application.cw.dsn#" username="#application.cw.dsnUsername#" password="#application.cw.dsnPassword#">
	SELECT DISTINCT
		cw_option_types.optiontype_id,
		cw_option_types.optiontype_name,
		cw_option_types.optiontype_sort
		<cfif arguments.product_id gt 0>
		,
		cw_options.option_id,
		cw_options.option_name,
		cw_options.option_sort
		</cfif>
	FROM
		<cfif arguments.product_id gt 0>
	cw_products
	INNER JOIN (( cw_option_types
		INNER JOIN cw_options ON cw_option_types.optiontype_id = cw_options.option_type_id)
		INNER JOIN cw_product_options ON cw_option_types.optiontype_id = cw_product_options.product_options2optiontype_id) ON cw_products.product_id = cw_product_options.product_options2prod_id
	WHERE cw_products.product_id= #arguments.product_id# AND NOT cw_options.option_archive = 1
		<cfelse>
	cw_option_types
	WHERE NOT optiontype_archive = 1
	AND NOT optiontype_deleted = 1
		</cfif>
	ORDER BY
		cw_option_types.optiontype_sort,
		cw_option_types.optiontype_name
		<cfif arguments.product_id gt 0>
		,cw_options.option_name
		,cw_options.option_sort
		,cw_options.option_id
		</cfif>
		,cw_option_types.optiontype_id
</cfquery>
<cfreturn rsListOptions>
</cffunction>
</cfif>

<!--- // ---------- Get Related Products for a Specific Product ---------- // --->
<cfif not isDefined('variables.CWquerySelectUpsellProducts')>
<cffunction name="CWquerySelectUpsellProducts" access="public" output="false" returntype="query"
			hint="Returns all related (upsell) products for a given product">

	<cfargument name="product_id" required="true" type="numeric"
				hint="the Product ID to look up">

<cfset var rsSelectUpsell = "">
<cfquery name="rsSelectUpsell" datasource="#application.cw.dsn#" username="#application.cw.dsnUsername#" password="#application.cw.dsnPassword#">
	SELECT p.product_id,
	p.product_merchant_product_id,
	p.product_name,
	u.upsell_id
	FROM cw_products p, cw_product_upsell u, cw_skus s
	WHERE p.product_id = u.upsell_2product_id
	AND u.upsell_product_id = #arguments.product_id#
	AND s.sku_product_id = p.product_id
	AND NOT p.product_archive = 1
	<cfif not application.cw.appEnableBackOrders>
		AND s.sku_stock > 0
	</cfif>
	GROUP BY p.product_id, p.product_merchant_product_id, p.product_name, u.upsell_id
	ORDER BY p.product_name, p.product_merchant_product_id, p.product_id, u.upsell_id
</cfquery>
<cfreturn rsSelectUpsell>
</cffunction>
</cfif>

<!--- // ---------- Get Reciprocal Related Products for a Specific Product ---------- // --->
<cfif not isDefined('variables.CWquerySelectReciprocalUpsellProducts')>
<cffunction name="CWquerySelectReciprocalUpsellProducts" access="public" output="false" returntype="query"
			hint="Returns all upsell record with a given product as the related item">

	<cfargument name="product_id" required="true" type="numeric"
				hint="the Product ID to look up">

<cfset var rsSelectRecipUpsell = "">
<cfquery name="rsSelectRecipUpsell" datasource="#application.cw.dsn#" username="#application.cw.dsnUsername#" password="#application.cw.dsnPassword#">
	SELECT p.product_id,
	p.product_merchant_product_id,
	p.product_name,
	u.upsell_id
	FROM cw_products p, cw_product_upsell u, cw_skus s
	WHERE p.product_id = u.upsell_product_id
	AND u.upsell_2product_id = #arguments.product_id#
	AND s.sku_product_id = p.product_id
	AND NOT p.product_archive = 1
	<cfif not application.cw.appEnableBackOrders>
		AND s.sku_stock > 0
	</cfif>
	GROUP BY p.product_id, p.product_merchant_product_id, p.product_name, u.upsell_id
	ORDER BY p.product_name, p.product_merchant_product_id, p.product_id, u.upsell_id
</cfquery>
<cfreturn rsSelectRecipUpsell>
</cffunction>
</cfif>

<!--- // ---------- // Get New Products (by date_modified) // ---------- // --->
<cfif not isDefined('variables.CWqueryNewProducts')>
<cffunction name="CWqueryNewProducts"
			access="public"
			output="false"
			returntype="query"
			hint="Returns a query of new products"
			>

<cfargument name="max_products"
		required="false"
		default="5"
		type="numeric"
		hint="number of products to return">

<cfset var productQuery = ''>

<cfquery name="productQuery" datasource="#application.cw.dsn#" username="#application.cw.dsnUsername#" password="#application.cw.dsnPassword#" maxrows="#arguments.max_products#">
SELECT
p.product_id,
p.product_name,
p.product_preview_description,
p.product_date_modified
FROM cw_products p
WHERE NOT p.product_on_web = 0
AND NOT p.product_archive = 1
ORDER by p.product_date_modified DESC
</cfquery>

<cfreturn productQuery>

</cffunction>
</cfif>

<!--- /////////////// --->
<!--- CATEGORY QUERIES --->
<!--- /////////////// --->

<!--- // ---------- Get All Active Categories ---------- // --->
<cfif not isDefined('variables.CWquerySelectCategories')>
<cffunction name="CWquerySelectCategories" access="public" output="false" returntype="query"
			hint="Returns all active categories, along with number of products in each">

	<cfargument name="show_empty" default="#application.cw.appDisplayEmptyCategories#" type="numeric" required="false"
				hint="Set to false to return all categories, regardless of products">

	<cfargument name="nav_only" default="true" type="numeric" required="false"
				hint="If false, includes categories with category_nav = 0 (default is true)">

	<cfset var rsCats = "">

	<cfquery name="rsCats" datasource="#application.cw.dsn#" username="#application.cw.dsnUsername#" password="#application.cw.dsnPassword#">
		SELECT
		category_id,
		category_name,
		category_archive,
		category_sort,
		category_description,
		count(distinct product2category_product_id) as catProdCount
		FROM cw_categories_primary
			<cfif arguments.show_empty>
			LEFT OUTER JOIN cw_product_categories_primary
			<cfelse>
			INNER JOIN cw_product_categories_primary
			</cfif>
		ON cw_product_categories_primary.product2category_category_id = cw_categories_primary.category_id
		LEFT OUTER JOIN cw_products
		ON cw_products.product_id = cw_product_categories_primary.product2category_product_id
		LEFT OUTER JOIN cw_skus
		ON cw_skus.sku_product_id = cw_products.product_id
		WHERE NOT category_archive = 1
			<cfif NOT arguments.show_empty>
			AND NOT cw_products.product_on_web = 0
			AND NOT cw_products.product_archive = 1
			AND NOT cw_skus.sku_on_web = 0
				<cfif not application.cw.appEnableBackOrders>
				AND cw_skus.sku_stock > 0
				</cfif>
			</cfif>
			<cfif arguments.nav_only>
				AND NOT cw_categories_primary.category_nav = 0
			</cfif>
		GROUP BY
		category_id,
		category_name,
		category_archive,
		category_sort,
		category_description
		ORDER BY
		category_sort,
		category_name
	</cfquery>

<cfreturn rsCats>
</cffunction>
</cfif>

<!--- // ---------- Get All Active Secondary Categories ---------- // --->
<cfif not isDefined('variables.CWquerySelectSecondaries')>
<cffunction name="CWquerySelectSecondaries" access="public" output="false" returntype="query"
			hint="Returns all active secondary categories, along with number of products in each">

	<cfargument name="show_empty" default="#application.cw.appDisplayEmptyCategories#" type="boolean" required="false"
				hint="Set to false to return all categories, regardless of products">

	<cfargument name="relate_cats" default="false" type="boolean" required="false"
				hint="Set to true to return subcategories related to categories (by product entry)">

	<cfargument name="cat_id" default="0" type="numeric" required="false"
				hint="if relate_cats is true, provide category ID to retrieve secondaries only related to that category">

	<cfargument name="nav_only" default="true" type="numeric" required="false"
				hint="If false, includes categories with category_nav = 0 (default is true)">

<cfset var rsCats = "">

<!--- related categories / subcats --->
<cfif arguments.relate_cats>

<cfquery name="rsCats" datasource="#application.cw.dsn#" username="#application.cw.dsnUsername#" password="#application.cw.dsnPassword#">
	SELECT
	DISTINCT
	category_name,
	category_id,
	secondary_id,
	secondary_name,
	secondary_archive,
	secondary_sort,
	secondary_description,
	category_sort,
	count(distinct product2secondary_product_id) as catProdCount
	FROM cw_categories_secondary
		INNER JOIN (cw_categories_primary
			INNER JOIN (cw_product_categories_primary
				INNER JOIN cw_product_categories_secondary
				ON cw_product_categories_secondary.product2secondary_product_id = cw_product_categories_primary.product2category_product_id)
			ON cw_categories_primary.category_id = cw_product_categories_primary.product2category_category_id)
 		ON cw_categories_secondary.secondary_id = cw_product_categories_secondary.product2secondary_secondary_id
		LEFT OUTER JOIN cw_products
		ON cw_products.product_id = cw_product_categories_secondary.product2secondary_product_id
		LEFT OUTER JOIN cw_skus
		ON cw_skus.sku_product_id = cw_products.product_id
		WHERE NOT secondary_archive = 1
			<cfif arguments.cat_id gt 0>
			AND cw_categories_primary.category_id = <cfqueryparam value="#arguments.cat_id#" cfsqltype="cf_sql_integer">
			</cfif>
			<cfif NOT arguments.show_empty>
			AND NOT cw_products.product_on_web = 0
			AND NOT cw_products.product_archive = 1
			AND NOT cw_skus.sku_on_web = 0
				<cfif not application.cw.appEnableBackOrders>
				AND cw_skus.sku_stock > 0
				</cfif>
			</cfif>
			<cfif arguments.nav_only>
				AND NOT cw_categories_secondary.secondary_nav = 0
			</cfif>
	GROUP BY
	category_sort,
	category_name,
	category_id,
	secondary_id,
	secondary_name,
	secondary_archive,
	secondary_sort,
	secondary_description
	ORDER BY
	category_sort,
	category_name,
	secondary_sort,
	secondary_name,
	secondary_id,
	secondary_archive,
	secondary_description,
	category_id
</cfquery>

<!--- unrelated (all secondary categories) --->
<cfelse>

<cfquery name="rsCats" datasource="#application.cw.dsn#" username="#application.cw.dsnUsername#" password="#application.cw.dsnPassword#">
	SELECT secondary_id,
	secondary_name,
	secondary_archive,
	secondary_sort,
	secondary_description,
	count(distinct product2secondary_product_id) as catProdCount
	FROM cw_categories_secondary
		<cfif arguments.show_empty>
		LEFT OUTER JOIN cw_product_categories_secondary
		<cfelse>
		INNER JOIN cw_product_categories_secondary
		</cfif>
	ON cw_product_categories_secondary.product2secondary_secondary_id = cw_categories_secondary.secondary_id
		LEFT OUTER JOIN cw_products
		ON cw_products.product_id = cw_product_categories_secondary.product2secondary_product_id
		LEFT OUTER JOIN cw_skus
		ON cw_skus.sku_product_id = cw_products.product_id
		WHERE NOT secondary_archive = 1
			<cfif NOT arguments.show_empty>
			AND NOT cw_products.product_on_web = 0
			AND NOT cw_products.product_archive = 1
			AND NOT cw_skus.sku_on_web = 0
				<cfif not application.cw.appEnableBackOrders>
				AND cw_skus.sku_stock > 0
				</cfif>
			</cfif>
	GROUP BY
	secondary_id,
	secondary_name,
	secondary_archive,
	secondary_sort,
	secondary_description
	ORDER BY
	secondary_sort,
	secondary_name
</cfquery>
</cfif>

<cfreturn rsCats>
</cffunction>
</cfif>

<!--- // ---------- Get Category Details ---------- // --->
<cfif not isDefined('variables.CWquerySelectCatDetails')>
<cffunction name="CWquerySelectCatDetails" access="public" output="false" returntype="query"
			hint="Returns all details about a category, by name or ID">

	<cfargument name="cat_id" required="true" type="numeric"
				hint="ID of the category to lookup - pass in 0 to use name lookup instead">

	<cfargument name="cat_name" required="false" default="" type="string"
				hint="Name of the category to look up">

<cfset var rsSelectCatDetails = ''>
<cfquery name="rsSelectCatDetails" datasource="#application.cw.dsn#" username="#application.cw.dsnUsername#" password="#application.cw.dsnPassword#">
SELECT * FROM cw_categories_primary
WHERE
<cfif arguments.cat_id>
category_id = #arguments.cat_id#
<cfelse>
#application.cw.sqlLower#(category_name) ='#lcase(arguments.cat_name)#'
</cfif>
</cfquery>
<cfreturn rsSelectCatDetails>
</cffunction>
</cfif>

<!--- // ---------- Get Secondary Category Details ---------- // --->
<cfif not isDefined('variables.CWquerySelectSecondaryCatDetails')>
<cffunction name="CWquerySelectSecondaryCatDetails" access="public" output="false" returntype="query"
			hint="Returns all details about a secondary category, by name or ID">

	<cfargument name="cat_id" required="true" type="numeric"
				hint="ID of the category to lookup - pass in 0 to use name lookup instead">

	<cfargument name="cat_name" required="false" default="" type="string"
				hint="Name of the category to look up">

<cfset var rsSelectCatDetails = ''>
<cfquery name="rsSelectCatDetails" datasource="#application.cw.dsn#" username="#application.cw.dsnUsername#" password="#application.cw.dsnPassword#">
SELECT *
FROM cw_categories_secondary
WHERE
<cfif arguments.cat_id>
secondary_id = #arguments.cat_id#
<cfelse>
#application.cw.sqlLower#(secondary_name) ='#lcase(arguments.cat_name)#'
</cfif>
</cfquery>
<cfreturn rsSelectCatDetails>
</cffunction>
</cfif>

</cfsilent>