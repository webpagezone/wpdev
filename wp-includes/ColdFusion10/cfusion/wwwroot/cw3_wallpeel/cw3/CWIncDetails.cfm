<cfsilent>
<!---
================================================================
Application Info: Cartweaver© 2002 - 2007, All Rights Reserved.
Developer Info: Application Dynamics Inc.
                1560 NE 10th
                East Wenatchee, WA 98802
Support Info: http://www.cartweaver.com/go/cfhelp

Cartweaver Version: 3.0.14  -  Date: 08/07/2009
================================================================
Name:  CWIncDetails
Description: This page displays individual products along with all
	of the product's associated SKUs. If a product has only 1 or
	2 Option Groups, then select menus are shown for the customer to
	choose the desired SKUs. If more than 2 Option Groups are available
	for one product, then a crosstab table is displayed with all
	of the SKUs available. Options are handled through the
	CWTagProductOptions custom tag.
================================================================
--->
<!--- Set Local Product_ID variable based on value passed --->
<cfparam name="URL.StockAlert" default="No">
<cfparam name="request.StockAlert" default="#URL.StockAlert#">
<cfparam name="intQuantity" default="0">
<cfparam name="URL.result" default="0">
<cfparam name="request.FieldError" default="">
<cfif Not IsDefined("Application.PriceFormatString")>
	<cfset PriceFormatString = "@@beforeDiscountPrice@@ @@currentPrice@@ (@@priceWithTax@@ including @@tax@@% tax)" />
<cfelse>
	<cfset PriceFormatString = Application.PriceFormatString />
</cfif>

<cfif IsDefined('FORM.ProdID')>
	<cfset request.Product_ID = FORM.ProdID>
	<cfelseif IsDefined ('URL.ProdID')>
	<cfset request.Product_ID = URL.ProdID>
	<cfelseif IsDefined ('FORM.ProdID')>
	<cfset request.Product_ID = FORM.ProdID>
	<cfelseif IsDefined ('URL.SKU_ProductID')>
	<cfset request.Product_ID = URL.SKU_ProductID>
	<cfelse>
	<cfset request.Product_ID = 0>
</cfif>
<cfif NOT IsNumeric(Request.Product_ID)>
	<cfset Request.Product_ID = 0 />
</cfif>
<cflock timeout="8" throwontimeout="no" type="exclusive" scope="application">
  <cfset variables.DisplayUpsell = application.showupsell>
</cflock>

<cfparam name="Application.ContinueShopping" default="Details">
<cfswitch expression="#Application.ContinueShopping#">
    <cfcase value="Results">
        <cfparam name="URL.category" default="0">
        <cfparam name="URL.secondary" default="0">
        <cfparam name="URL.keywords" default="">
        <cfset Request.returnURL = URLEncodedFormat(Request.targetResults & "?category=#Url.category#&secondary=#url.secondary#&keywords=#url.keywords#")>
    </cfcase>
    <cfcase value="Details">
		<cfset Request.returnURL = URLEncodedFormat("#Request.targetDetails#?ProdID=#Request.Product_ID#")>
    </cfcase>
    <cfcase value="Home">
		<cfset Request.returnURL = URLEncodedFormat(Request.websiteURL)>
    </cfcase>
    <cfdefaultcase>
    	<cfset Request.returnURL = URLEncodedFormat(Request.ThisPage & "?ProdID=#Request.Product_ID#")>
    </cfdefaultcase>
</cfswitch>
<!--- Set up returnURL to any page by uncommenting the next line and putting in your page and variables within the urlencode function --->
<!---<cfset Request.returnURL = URLEncodedFormat("somepage.cfm?somevar=something")> --->


<!--- ======= ///  [ START ADD TO CART] /// ========================================================== --->
<!---  IF "FORM ADD TO CART" DEFINED, Add item to the cart. --->
<cfif IsDefined ('FORM.Fieldnames')>
	<!--- If we have specific skus, great, otherwise go through individual options --->
	<cfif IsDefined("FORM.skuID")>
		<!--- Add multiple skus to the cart --->
		<cfmodule
			template="CWTags/CWTagCartweaver.cfm"
			cartaction = "multi-sku"
			sku_id = "#FORM.skuID#"
			sku_qty = "#FORM.Qty#"
			>
	<cfelseif IsDefined("FORM.addSkus")>
		<!--- Collect SKUs and matching Qtys --->
		<cfset SKUIDs = "" />
		<cfset Qtys = "" />
		<cfloop from="1" to="#FORM.addSkus#" index="i">
			<cfset SKUIDs = ListAppend(SKUIDs, FORM["skuID#i#"]) />
			<cfif IsNumeric(FORM["Qty#i#"])>
				<cfset Qtys = ListAppend(Qtys, FORM["Qty#i#"]) />
			<cfelse>
				<cfset Qtys = ListAppend(Qtys, 0) />
			</cfif>
		</cfloop>
		<!--- Add multiple skus to the cart --->
		<cfmodule
			template="CWTags/CWTagCartweaver.cfm"
			cartaction = "multi-sku"
			sku_id = "#SKUIDs#"
			sku_qty = "#Qtys#"
			>
	<cfelse>
		<!--- Else we don't have SKUs --->
		<!--- Loop through the form collection and grab all the options --->
		<cfset strOptions = "">
		<cfset numOptions = 0>
		<cfloop collection="#FORM#" item="FieldName">
			<!--- If the form field is one of our select menus and they've chosen something besides
				the first option, then add the option to the list and increase the count --->
			<cfif Left(FieldName,3) EQ "sel" AND FORM[FieldName] NEQ "choose">
				<cfset strOptions = ListAppend(strOptions, FORM[FieldName], ",")>
				<cfset numOptions = IncrementValue(numOptions)>
			</cfif>
		</cfloop>
		<!--- Add to cart using only selected options. Pass option as a list, number of options as number and FORM.Qty --->
		<cfmodule
			template="CWTags/CWTagCartweaver.cfm"
			cartaction = "multi-option"
			optionlist = "#strOptions#"
			sku_qty = "#FORM.Qty#"
			product_id = "#request.product_ID#"
			>
	</cfif>
	<!--- End IsDefined('FORM.skuID') --->

	<cfif request.FieldError EQ "">
		<cflocation url="#request.targetDetails#?ProdID=#Request.Product_ID#&result=#request.qtyadded#&stockalert=#request.Stockalert#" addtoken="no">
	</cfif>
</cfif>
<!--- END IF - FORM.addtocart EQ "multi" --->

<!--- ============= ///  [ END ADD TO CART] /// =================== --->








<!--- ============================================================= --->
<!--- Get Product Data --->
<cfquery name="rsGetProduct" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
 SELECT
 	product_ID,
	product_Name,
	product_Description
  FROM
	tbl_products INNER JOIN tbl_skus
	ON tbl_products.product_ID = tbl_skus.SKU_ProductID
  WHERE product_ID = #request.Product_ID#
	AND product_Archive = 0
	AND product_OnWeb = 1
	AND tbl_skus.SKU_ShowWeb = 1
</cfquery>



<cfif variables.DisplayUpsell EQ 1>
	<!--- Get a list of Up-sell products --->
	<!--- If backorders are turned off, make sure products have stock --->
	<cfif application.allowbackorders EQ 0>
		<cfset backorderClause = "" />
	<cfelse>
		<cfset backorderClause = "AND tbl_prdtupsell.upsell_ProdID IN
		(
		SELECT product_ID
		FROM tbl_products p
		INNER JOIN tbl_skus s
		ON p.product_ID = s.SKU_ProductID
		WHERE SKU_Stock > 0
		)" />
	  </cfif>
	<cfquery name="rsGetupsell" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
	SELECT tbl_products.product_Name, tbl_prdtupsell.upsell_RelProdID
	FROM (tbl_products
		INNER JOIN tbl_prdtupsell ON tbl_products.product_ID = tbl_prdtupsell.upsell_RelProdID)

	WHERE
		tbl_products.product_Archive = 0
		AND tbl_products.product_OnWeb = 1

		AND tbl_prdtupsell.upsell_ProdID=#request.Product_ID# #backorderClause#
	</cfquery>
</cfif>

<!--- Get the current product tax rate if the merchant has elected to show prices including taxes --->
<cfif Application.DisplayTaxOnProduct EQ "True">
	<cfset taxRate = cwGetTotalProductTaxRate(request.Product_ID, Client.TaxStateID, Client.TaxCountryID) />
<cfelse>
	<cfset taxRate = "" />
</cfif>
</cfsilent>




<cfprocessingdirective suppresswhitespace="yes">
<script type="text/javascript" src="cw3/assets/scripts/global.js"></script>
<!--- ======================================================= --->
<!--- [ START ] DISPLAY PRODUCT --->
<cfif rsGetProduct.RecordCount NEQ 0>
<!--- Display Common Product data --->
 <table id="tableProductDetails">
	<tr>
	<td style="text-align: center;"><cfoutput>#cwDisplayImage(request.Product_ID, 2, rsGetProduct.product_Name, "")#</cfoutput>
	<cfif Application.showimagepopup EQ "true">
		<cfset popupImagePath = cwGetImage(request.Product_ID, 3) />
		<cfif popupImagePath NEQ "">
			<br /><cfoutput><a href="#popupImagePath#" onclick="return cwShowProductImage('#popupImagePath#','#cwStringFormat(rsGetProduct.product_Name)#')">View Larger Image</a></cfoutput>
		</cfif>
	</cfif></td>
	<td><!--- Anchor point for when form is submitted --->
	<a name="skus"></a>
	<h1><cfoutput>#rsGetProduct.product_Name#</cfoutput> </h1>
	<p><cfoutput>#rsGetProduct.product_Description#</cfoutput> </p>
	<!-- [ START ] SKUs DATA TABLE -->

<!--- Show Pricing --->
<cfif Application.DetailsDisplay NEQ "Tables">
 <cfmodule
	template="CWTags/CWTagPriceList.cfm"
	product_id = "#request.Product_ID#"
	taxrate = "#taxRate#"
	ShowMax = "true"
	PriceFormat = "#PriceFormatString#"
	>
</cfif>
<!---  [ START ] ==	ERROR ALERTS and CONFIRMATION NOTICE =========================  --->
   <cfif request.FieldError NEQ "">
	<!--- If fields were left blank or in correct data entered, show "Field Alert" --->
	<p><span class="errorMessage"><cfoutput>#request.FieldError#</cfoutput></span></p>
	</cfif>
	<!--- Not enough stock alert --->
	<cfif request.StockAlert EQ "Yes">
		<p class="errorMessage">You have selected more quantity than is currently available.</p>
	</cfif>
	<cfif URL.result NEQ 0 AND request.FieldError EQ "">
	<cfoutput>
	<p><strong>* #URL.result#
		<cfif URL.result GT 1>
			items
			<cfelse>
			item
		</cfif>
		added to cart! * <a href="#request.targetGoToCart#&amp;returnurl=#URLEncodedFormat(Request.returnURL)#">[Go To Cart]</a></strong></p>
	</cfoutput>
	</cfif>
<!---  [ END] ==  ERROR ALERTS and CONFIRMATION NOTICE =========================  --->
<!--- ===================== [ BEGIN MULTI SKU DISPLAY ]=========================================== --->
<!---
Set "AddToCartType" variable to indicate wether there are just
one "single" SKU or "multiple" SKUs associated with the product
--->
	<form action="<cfoutput>#request.ThisPage#</cfoutput>?ProdID=<cfoutput>#request.Product_ID#</cfoutput>#skus" method="post" name="AddToCart">
		<cfif Application.DetailsDisplay EQ "Tables">
		 <cfmodule
			template="CWTags/CWTagPriceList.cfm"
			product_id = "#request.Product_ID#"
			taxrate = "#taxRate#"
			ShowMax = "true"
			PriceFormat = "#PriceFormatString#"
			>
			<br />
		</cfif>


		<cfmodule
			template="CWTags/CWTagProductOptions.cfm"
			product_id = "#request.Product_ID#"
			fielderror = "#request.FieldError#"
			taxrate = "#taxRate#"
			>

		<cfoutput>
			<input name="ProdID" type="hidden" value="#request.Product_ID#">
			<input name="Submit" type="submit" class="formButton" value="Add to Cart">
		</cfoutput>
	</form>
	</td>
	</tr>
<cfif variables.DisplayUpsell EQ 1>
 <!--- If there are upsell products associsted with this Product, display them. --->
  <cfif rsGetupsell.RecordCount NEQ 0>
	<tr>
	  <td>&nbsp;</td>
	  <td><br /><cfif rsGetupsell.RecordCount GT 1>
	You may also be interested in these products:<br />
	<cfelse>
	You may also be interested in this product:<br />
	</cfif>
	<cfset imageType = 4><!--- Output small image if found --->
	<cfoutput query="rsGetupsell">#cwDisplayImage(rsGetupsell.upsell_RelProdID, imageType, rsGetupsell.product_Name, "")#<br/>
	<a href="#request.ThisPage#?ProdID=#rsGetupsell.upsell_relProdID#">#rsGetupsell.product_Name#</a><cfif (rsGetupsell.RecordCount GT 1) AND (rsGetupsell.RecordCount NEQ CurrentRow)><br /><br /></cfif>
	</cfoutput>
	  </td>
    </tr>
 </cfif><!--- END IF - rsGetupsell.RecordCount NEQ 0 --->
</cfif><!--- END IF - rsGetupsell.RecordCount NEQ 0 --->

<cfif request.showDiscount EQ true>
	<cfset discountDescription = cwGetDiscountDescription(session.currentDiscount)>
	<cfif discountDescription NEQ "">
	<tr>
		<td colspan="2"><cfoutput>#discountDescription#</cfoutput></td>
	</tr>
	</cfif><!--- END IF - discountDescription NEQ "" --->
</cfif><!--- END IF - request.showDiscount EQ true --->
</table>
<!--- [ END ] DISPLAY PRODUCT --->
<cfelse>
	<p>No product selected.</p>
</cfif>
<!--- End Check for Product ID --->
</cfprocessingdirective>