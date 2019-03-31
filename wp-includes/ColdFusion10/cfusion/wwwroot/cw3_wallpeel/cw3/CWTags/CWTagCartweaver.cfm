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
		Name: Cartweaver Custom Tag
		Description: This is the heart of the Cartweaver functionality.
		This Tag (file) creates the cart, adds to, updates and deletes
		items from the cart.
		================================================================
		Attributes:
		cartaction (required): The cartaction attribute determines what
		the Cartweaver Custom Tag will do with the sku_id and sku_qty
		passed to the custom tag. The following values are possible:
		*	add: Add a SKU and quantity to the cart as defined by the
		sku_id and sku_qty attributes. The sku_id is required for the add action.
		*	update: Update a SKU to a specific quantity in the cart as
		defined by the sku_id and sku_qty attributes. The sku_id is
		required for the update action. Setting the quantity to 0 will
		delete an item from the cart.
		*	delete: Delete a SKU from the cart as defined by the sku_id
		attribute. The sku_id is required for the delete action.
		*	multi-sku: Add multiple SKUs to the cart as defined by the
		sku_id and sku_qty attributes. The sku_id and sku_qty are
		required for the multi-sku action. The sku_id and sku_qty must
		be passed in comma delimited lists corresponding to the SKU ids
		and quantities to be added. The CWIncDetails.cfm include uses
		this method when adding products from a crosstab table of SKUs,
		where multiple SKUs can be added at one time.
		*	multi-option: Add a SKU based on the SKU options as defined in
		the optionlist attribute. The optionlist attribute is required
		for the multi-option action. The appropriate SKU is found for
		you based on the options based to the custom tag. The CWIncDetails.cfm
		include uses this method when adding products with two options.
		sku_id (optional): The sku_id attribute passes either a specific SKU ID
		(for the add, update and delete cartactions) or a comma delimited
		list of SKU IDs for the multi-sku cart action. The SKU ID passed is
		the SKU_ID field from tbl_SKUs. The default is 0 if the attribute is not provided.
		sku_qty (optional): The sku_qty attribute passes either a single quantity
		(for the add and update cartactions) or a comma delimited list of
		quantities for the multi-option cart action. The default is 1 if the
		attribute is not provided. If 0 is passed, the SKU is deleted from the
		cart, regardless of the cartaction.
		optionlist (optional): The optionlist attribute passes a comma separated
		list of option IDs for use with the multi-option cartaction.
		This attribute is not used with any other cartaction.
		Returns:
		request.fielderror: Any errors that occur during cart actions are returned
		in the fielderror request variable.
		request.QtyAdded: Returns the number of items successfully added to the cart.
		request.StockAlert: Returns “Yes” if backorders are not allowed and there
		is not enough quantity to fill a particular quantity request.
		--->
	<!--- In case a quantity is not passed, set default quantity to 1. --->
	<cfparam name="attributes.sku_qty" default="1">
	<!--- In case a sku_id is not passed, in deleting for example set default to 0 to avoid errors. --->
	<cfparam name="attributes.sku_id" default="0">
	<cfparam name="attributes.product_id" default="0">
	<!--- Variable to hold current cart quantity for a SKU. Defaut to 0, change if an item is already in the cart --->
	<cfparam name="oldQty" default="0">
	<cfparam name="request.FieldError" default="">
	<cfparam name="attributes.redirect" default="yes">
	<cfparam name="request.StockAlert" default="no">
	<!---
		This section handles multi-sku and multi-option adds, if a valid SKU
		is found, then the Cartweaver custom tag is called recursively to
		add the new SKU to the cart
		--->
	<!--- If we have multiple skus --->
</cfsilent>
<cfif attributes.cartaction EQ "multi-sku">
	<!--- Put the skus and qtys in parallel arrays --->
	<cfset arSKUs = ListToArray(attributes.sku_ID)>
	<cfset arQty = ListToArray(attributes.sku_qty)>
	<cfloop from="#Evaluate(ArrayLen(arQty) + 1)#" to="#ArrayLen(arSKUs)#" index="i">
		<!--- Add empty values if not enough qtys were passed --->
		<cfset ArrayAppend(arQty, 0) />
	</cfloop>
	<cfset lstDeletions = "">
	<!--- Find out which items have 0 quantities, and set them for deletion --->
	<cfloop from="1" to="#ArrayLen(arSKUs)#" index="i">
		<!--- If they didn't enter a number, set the value to 0 --->
		<cfif NOT IsNumeric(arQty[i])>
			<cfset arQty[i] = 0>
		</cfif>
		<!--- If the quantity is less than 1, then remove the item from the list --->
		<cfif arQty[i] LT 1>
			<cfset lstDeletions = ListAppend(lstDeletions,arSKUs[i])>
		</cfif>
	</cfloop>
	<!--- Remove items that have been marked for deletion --->
	<cfif ListLen(lstDeletions) NEQ 0>
		<!--- Make our arrays lists to make for easier deleting --->
		<cfset arSKUs = ArrayTolist(arSKUs)>
		<cfset arQty = ArrayToList(arQty)>
		<!--- Loop through our list of SKUs to delete and take them out --->
		<cfloop list="#lstDeletions#" index="ListItem">
			<cfset intIndex = ListFind(arSKUs,ListItem)>
			<!--- If we found a match, delete the item --->
			<cfif #intIndex# NEQ 0>
				<cfset arSKUs = ListDeleteAt(arSKUs,intIndex)>
				<cfset arQty = ListDeleteAt(arQty,intIndex)>
			</cfif>
		</cfloop>
		<!--- Convert our lists back into arrays --->
		<cfset arSKUs = ListToArray(arSKUs)>
		<cfset arQty = ListToArray(arQty)>
	</cfif>
	<!--- If we have multiple options, but no definite sku --->
<cfelseif attributes.cartaction EQ "multi-option">
	<!--- create two arrays with just one element --->
	<cfset arSkus = ArrayNew(1)>
	<cfset arQty = ArrayNew(1)>
	<cfset numOptions = ListLen(attributes.optionlist)>
	<cfif attributes.optionlist EQ "">
		<cfset attributes.optionlist = 0>
	</cfif>
	<!--- Get any found skus. Use optionlist variable to filter the recordset. --->
	<cfquery name="rsoptn_rel_SKU_ID" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
	SELECT
		tbl_skuoption_rel.optn_rel_SKU_ID
	FROM tbl_skus INNER JOIN tbl_skuoption_rel ON tbl_skus.SKU_ID = tbl_skuoption_rel.optn_rel_SKU_ID
	WHERE tbl_skus.SKU_ProductID = #attributes.product_ID#
	GROUP BY
		tbl_skuoption_rel.optn_rel_SKU_ID
	HAVING
		Count(tbl_skuoption_rel.optn_rel_SKU_ID)=#numOptions#
	</cfquery>
	<cfset optn_rel_SKU_ID = ValueList(rsoptn_rel_SKU_ID.optn_rel_SKU_ID)>
	<cfif optn_rel_SKU_ID EQ "">
		<cfset optn_rel_SKU_ID = 0>
	</cfif>
	<cfquery name="rsoptn_rel_SKU_ID2" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
	SELECT
		tbl_skuoption_rel.optn_rel_SKU_ID
	FROM tbl_skuoption_rel
	WHERE
		tbl_skuoption_rel.optn_rel_Option_ID In (#attributes.optionlist#)
		AND tbl_skuoption_rel.optn_rel_SKU_ID IN
		(#optn_rel_SKU_ID#)
	GROUP BY tbl_skuoption_rel.optn_rel_SKU_ID
	HAVING Count(tbl_skuoption_rel.optn_rel_SKU_ID)=#numOptions#
	</cfquery>
	<cfset optn_rel_SKU_ID2 = ValueList(rsoptn_rel_SKU_ID2.optn_rel_SKU_ID)>
	<cfif optn_rel_SKU_ID2 EQ "">
		<cfset optn_rel_SKU_ID2 = 0>
	</cfif>
	<cfquery name="FindSKU" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
	SELECT DISTINCT (SKU_ID) AS ThisSKU, SKU_Stock
	FROM tbl_skuoption_rel, tbl_skus
	WHERE
	SKU_ID IN
		(#optn_rel_SKU_ID2#)
	AND SKU_ProductID = #attributes.product_id#
	</cfquery>
	<!--- If we didn't find a sku --->
	<cfif #FindSKU.RecordCount# EQ 0>
		<!--- Set an error to display on the page --->
		<cfset request.FieldError = "No product found for your selected options.">
	<cfelse>
		<!--- Add the sku to be added to our cart to the end of our array --->
		<cfset ArrayAppend(arSKUs,FindSKU.ThisSKU)>
		<!--- Clean up quantity and place in array --->
		<cfif NOT IsNumeric(#attributes.sku_qty#) OR #attributes.sku_qty# LT 0>
			<cfset arQty[1] = 1>
		<cfelse>
			<cfset arQty[1] = #attributes.sku_qty#>
		</cfif>
	</cfif>
	<!--- End Multi add section --->
<cfelse>
	<!--- If it's not a multi add of some sort, do regular add, updates or deletes --->
	<!--- If quantity is submmited as "blank" set quantity to 1 --->
	<cfif #attributes.sku_qty# EQ "">
		<cfset attributes.sku_qty = 1>
	</cfif>
	<!--- If a quantity of 0 is passed, set cartaction to "delete" and remove sku from the cart --->
	<cfif attributes.sku_qty EQ 0>
		<cfset attributes.cartaction = "delete">
	</cfif>
	<!--- VALIDATIONS ==============================
		Validate Quantity to be sure that the quantity is not 0,
		and does not contain a fraction or negative number.
		--->
	<cfset ValidateQuantity = attributes.sku_qty>
	<cfif (ValidateQuantity NEQ 0) AND (ValidateQuantity LTE 1)>
		<cfset attributes.sku_qty = 1>
	<cfelse>
		<cfset attributes.sku_qty = Abs(Round(ValidateQuantity)) >
	</cfif>
	<cfparam name="request.QtyAdded" default="0">
	<!---
		Validate Add - to prevent duplicate SKUs in the cart, Check if sku is already in cart.
		If so set "cartaction" to "update"
		--->
	<cfif #attributes.cartaction# IS "add">
		<cfquery name="rsCheckForSKU" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
		SELECT cart_Line_ID, cart_sku_qty FROM tbl_cart	WHERE cart_custcart_ID ='#Client.CartID#'AND
		cart_sku_ID = #attributes.sku_id#
		</cfquery>
		<cfif rsCheckForSKU.RecordCount NEQ 0>
			<!--- If sku is already in the cart change cartaction and set update quantity --->
			<cfset attributes.cartaction = "update">
			<cfset oldQty = rsCheckForSKU.cart_sku_qty>
		</cfif>
	</cfif>
	<!--- Get SKU Data  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --->
	<cfif attributes.sku_id NEQ 0 AND attributes.cartaction NEQ "Delete">
		<cfquery name="rsGetSKUData" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
		SELECT tbl_skus.SKU_Price, tbl_skus.SKU_Weight, tbl_products.product_shipchrg
		FROM tbl_skus INNER JOIN tbl_products ON tbl_skus.SKU_ProductID = tbl_products.product_ID
		WHERE	tbl_skus.SKU_ID = #attributes.sku_id#
		</cfquery>
	</cfif>
	<!--- Check quantity and backorder data --->
	<cfset newqty = 0>
	<!--- Set the newqty to the requested quantity plus the old quantity from the user's cart --->
	<cfset newqty = attributes.sku_qty + oldQty>
	<!--- if back orders are not allowed verify quantity against SKU_Stock  --->
	<cfif application.AllowBackOrders EQ "No" AND attributes.cartaction NEQ "Delete">
		<!---
			If Backorders are not allowed Check total quantity in the cart to be sure
			that the updated amount will not exceed the stock count.
			If it does, adjust quantity to Stock Count.
			--->
		<cfquery name="rsCheckStockCount" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
		SELECT SKU_Stock FROM tbl_skus	WHERE SKU_ID = #attributes.sku_id#
		</cfquery>
		<!--- If the new quantity exceeds the stock quantity --->
		<cfif newqty GT rsCheckStockCount.SKU_Stock>
			<!--- Set the StockAlert to Yes so we can display an error on the add to cart page. --->
			<cfset request.StockAlert = "Yes">
			<!--- Set the new quantity to the current stock quantity --->
			<cfif rsCheckStockCount.SKU_Stock GT 0>
				<cfset newqty = rsCheckStockCount.SKU_Stock>
			<cfelse>
				<cfset newqty = 0>
			</cfif>
		</cfif>
		<!--- If we added less than the user requested --->
	</cfif>
	<!--- Update the quantity added for display on the details page --->
	<cfset request.QtyAdded = request.QtyAdded + (newqty - oldQty)>
	<!--- now reset the quanity to the "newqty" figure for updating or adding later --->
	<cfset attributes.sku_qty = newqty >
	<!--- BEGIN CART ACTIONS ================================================== --->
	<!--- If the new quantity is 0, then delete the product --->
	<cfif attributes.sku_qty EQ 0>
		<cfset attributes.cartaction = "delete">
	</cfif>
	<cfswitch expression="#attributes.cartaction#">
		<!--- [ ADD NEW ITEM TO CART ] === START ============== --->
		<cfcase value="add">
			<!--- Insert sku into cart --->
			<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
			INSERT INTO tbl_cart (cart_custcart_ID, cart_sku_ID, cart_sku_qty, cart_dateadded)
			VALUES ('#Client.CartID#',#attributes.sku_id# ,#attributes.sku_qty# ,#CreateODBCDate(Now())#
			)
			</cfquery>
		</cfcase>
		<!--- [ ADD NEW ITEM TO CART ] === END =========================== --->
		<!--- ///////////////////////////////////////////////////////////////////// --->
		<!--- [ UPDATE ITEM IN CART ] === START ============ --->
		<cfcase value="update">
			<!--- update sku that already exists in the cart --->
			<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
			UPDATE tbl_cart	SET cart_custcart_ID='#Client.CartID#', cart_sku_ID=#attributes.sku_id#
			, cart_sku_qty=#attributes.sku_qty# , cart_dateadded=#CreateODBCDate(Now())#
			WHERE cart_sku_ID=#attributes.sku_id#	AND cart_custcart_ID='#Client.CartID#'
			</cfquery>
		</cfcase>
		<!--- [ UPDATE ITEM IN CART ] === END =========================== --->
		<!--- ///////////////////////////////////////////////////////////////////// --->
		<!--- [ DELETE ITEM IN CART ] === START ============ --->
		<cfcase value="delete">
			<!--- delete sku from cart --->
			<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
			DELETE FROM tbl_cart WHERE cart_sku_ID=#attributes.sku_id# AND cart_custcart_ID
			='#Client.CartID#'
			</cfquery>
		</cfcase>
		<!--- [ DELETE ITEM IN CART ] === END ============================ --->
	</cfswitch>
</cfif>
<!--- If we have valid products to add to the cart --->
<cfif (attributes.cartaction EQ "multi-sku" OR attributes.cartaction EQ "multi-option") AND request.FieldError EQ "">
	<cfif IsDefined('arSKUs') AND ArrayLen(arSKUs) NEQ 0>
		<!--- Loop through our array of SKUs and get SKU data --->
		<cfloop index="i" from="1" to="#ArrayLen(arSKUs)#">
			<!--- ADD TO CART CUSTOM TAG HERE --->
			<cfmodule
				template="CWTagCartweaver.cfm"
				cartaction = "add"
				sku_id = "#arSKUs[i]#"
				sku_qty = "#arQty[i]#"
				redirect = "no"
				>
		</cfloop>
		<!--- Else, we don't have any items, the user hasn't chosen any valid quantities. Output an error --->
	<cfelse>
		<cfset request.FieldError = "Please enter a valid quantity.">
	</cfif>
</cfif>
<!--- After adding an item to cart, "GoTo" Target page or "Comfirm". This variable is set on the Application.cfm page.--->
<cfif request.OnSubmitAction EQ "GoTo" AND request.FieldError EQ "" AND (request.ThisPage & "?" & Client.CartID) NEQ request.targetGoToCart AND attributes.redirect NEQ "no">
	<cflocation url="#request.targetGoToCart#&result=#request.qtyadded#&stockalert=#request.Stockalert#&returnurl=#URLEncodedFormat(request.returnURL)#" addtoken="no">
</cfif>
