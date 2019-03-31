<cfsilent>
<!---
==========================================================
Application: Cartweaver 4 ColdFusion
Copyright 2002 - 2012, All Rights Reserved
Developer: Application Dynamics, Inc. | Cartweaver.com
Licensing: http://www.cartweaver.com/eula
Support: http://www.cartweaver.com/support
==========================================================
File: cw-mod-productpreview.cfm
File Date: 2012-02-01
Description: shows product details for 'preview' view
NOTES:
See attributes for options - product title and image can be arranged above or below,
and other elements can be shown or hidden
Form height for modal options popup is set based on number of options and can be adjusted.
==========================================================
--->

<!--- id of product to show: required if sku_id not provided --->
<cfparam name="attributes.product_id" default="0">
<!--- show add to cart option in preview --->
<cfparam name="attributes.add_to_cart" default="false">
<!--- if using add to cart (with single sku), show quantity selector --->
<cfparam name="attributes.show_qty" default="true">
<!--- if using add to cart, specify any sku to skip option selection --->
<cfparam name="attributes.sku_id" default="0">
<!--- show price in preview --->
<cfparam name="attributes.show_price" default="true">
<!--- show discount price (if applicable) --->
<cfparam name="attributes.show_discount" default="true">
<!--- show msrp price (if applicable) --->
<cfparam name="attributes.show_alt" default="#application.cw.adminProductAltPriceEnabled#">
<!--- show preview description --->
<cfparam name="attributes.show_description" default="false">
<!--- show image --->
<cfparam name="attributes.show_image" default="true">
<!--- image type (identifier for size to be used) --->
<cfparam name="attributes.image_type" default="1">
<!--- class for product image --->
<cfparam name="attributes.image_class" default="CWimage">
<!--- image above or below text elements --->
<cfparam name="attributes.image_position" default="above">
<!--- title (product name) above or below image --->
<cfparam name="attributes.title_position" default="above">
<!--- details page: blank '' = no links --->
<cfparam name="attributes.details_page" default="#request.cwpage.urlDetails#">
<!--- details link text --->
<cfparam name="attributes.details_link_text" default="&raquo; details">
<!--- options display type --->
<cfparam name="attributes.option_display_type" default="#application.cw.appDisplayOptionView#" type="string">
<!--- show alt price y/n --->
<cfparam name="request.cwpage.useAltPrice" default="#attributes.show_alt#">
<cfparam name="request.cwpage.altPriceLabel" default="#application.cw.adminLabelProductAltPrice#">
<cfparam name="request.cwpage.intQty" default="1">
<cfparam name="request.cwpage.qtyMax" default="99">
<!--- optionselect window url --->
<cfparam name="request.cw.assetSrcDir" default="#application.cw.appCwContentDir#">
<cfparam name="request.cwpage.formWindowBaseUrl" default="#request.cw.assetSrcDir#cwapp/inc/cw-inc-optionselect.cfm">
<!--- default client location variables --->
<cfparam name="session.cwclient.cwTaxCountryID" default="0">
<cfparam name="session.cwclient.cwTaxRegionID" default="0">
<!--- global functions --->
<cfinclude template="../inc/cw-inc-functions.cfm">
<!--- clean up form and url variables --->
<cfinclude template="../inc/cw-inc-sanitize.cfm">
<!--- if only a sku_id provided, get product ID --->
<cfif attributes.product_id is 0 AND isNumeric(attributes.sku_id) AND attributes.sku_id gt 0>
	<cfset lookupID = CWgetProductBySKU(attributes.sku_id)>
<cfelse>
	<cfset lookupID = attributes.product_ID>
</cfif>
<!--- set up details url --->
<cfset detailsUrl = attributes.details_page & '?product=' & lookupId>
<!--- get the product by ID --->
<cfif isNumeric(lookupId) and lookupId gt 0>
	<cfset product = CWgetProduct(product_id=lookupId)>
	<!--- tax rate --->
	<cfif application.cw.taxDisplayOnProduct>
	<cfset product.taxrate = cwGetProductTax(product_id=val(lookupID), region_id=val(session.cwclient.cwTaxRegionID), country_id=val(session.cwclient.cwTaxCountryID))>
	<cfelse>
	<cfset product.taxrate = ''>
	</cfif>
	<!--- discounts --->
	<cfif application.cw.discountsenabled AND attributes.show_discount AND
			((isDefined('product.price_disc_low') and product.price_disc_low neq product.price_low) OR (isDefined('product.price_disc_high') and product.price_disc_high neq product.price_high))>
		<cfset product.hasDiscount = true>
	<cfelse>
		<cfset product.hasDiscount = false>
	</cfif>
	<!--- if only one sku --->
	<cfif (isNumeric(attributes.sku_id) AND attributes.sku_id gt 0)
			OR listLen(product.sku_ids) eq 1>
		<cfif isNumeric(attributes.sku_id) AND attributes.sku_id gt 0>
			<cfset lookupSku = attributes.sku_id>
		<cfelseif isNumeric(listFirst(product.sku_ids))>
			<cfset lookupSku = listFirst(product.sku_ids)>
		</cfif>
		<!--- QUERY: get sku details --->
		<cfset skuQuery = CWquerySkuDetails(lookupSku)>
		<cfset product.sku_ids = attributes.sku_id>
		<cfset product.price_alt_high = skuQuery.sku_alt_price>
		<cfset product.price_alt_low = skuQuery.sku_alt_price>
		<cfset product.price_high = skuQuery.sku_price>
		<cfset product.price_low = skuQuery.sku_price>
		<cfset product.qty_max = skuQuery.sku_stock>
	</cfif>
	<!--- set up product image url and file --->
	<cfset productImg = CWgetImage(product_id=lookupId,image_type=attributes.image_type,default_image=application.cw.appImageDefault)>
	<cfset imgFile = expandPath(productImg)>

<!--- set up product title, to show above/below image --->
	<cfsavecontent variable="titleHTML">
	<cfif len(trim(product.product_name))>
	<cfoutput>
	<div class="CWproductPreviewTitle">
		<!--- if linked --->
		<cfif len(trim(attributes.details_page))>
			<a href="#detailsUrl#" class="CWlink">#product.product_name#</a>
		<!--- not linked --->
		<cfelse>
			#product.product_name#
		</cfif>
	</div>
	</cfoutput>
	</cfif>
	</cfsavecontent>
		<!--- save quantity input as a variable --->
		<cfsavecontent variable="cwqtyinput"><label for="qty">Quantity:</label>
		<cfif application.cw.appDisplayProductQtyType is 'text'>

		<input name="qty" type="number" required
		value="<cfoutput>#request.cwpage.intQty#</cfoutput>"
		class="required qty number" title="Quantity is required"
		size="2" style="width:50px;"
		onkeyup="extractNumeric(this,0,false)"
		>
	<cfelse>
		<select name="qty" class="required"
		title="Quantity">
			<cfloop from="1" to="#request.cwpage.qtymax#" index="ii"><cfoutput><option value="#ii#"<cfif ii eq request.cwpage.intQty> selected="selected"</cfif>>#ii#</option></cfoutput></cfloop></select></cfif></cfsavecontent>
	<!--- set up html for image, to show above/below other text elements --->
	<cfsavecontent variable="imgHtml">
		<cfoutput>
			<cfif attributes.show_image neq false and len(trim(productImg))>
				<!--- linked image, if url provided --->
				<cfif len(trim(attributes.details_page))>
					<a href="#detailsUrl#" class="CWlink" title="#product.product_name#">
						<img src="#productImg#" alt="#product.product_name#" class="#attributes.image_class#">
					</a>
				<!--- image without link --->
				<cfelse>
					<img src="#productImg#" alt="#product.product_name#" class="#attributes.image_class#">
				</cfif>
			</cfif>
		</cfoutput>
	</cfsavecontent>
	<!--- set up html for add to cart form --->
	<cfif attributes.add_to_cart>
	<cfsavecontent variable="cartFormHtml">
		<!--- determine url vars to pass through with cart submission --->
		<cfset formActionVars = ''>
		<cfif isDefined('url.category') and url.category gt 0><cfset formActionVars = listAppend(formActionVars,'category')></cfif>
		<cfif isDefined('url.secondary') and url.secondary gt 0><cfset formActionVars = listAppend(formActionVars,'secondary')></cfif>
			<!--- url for submitting inline form (single sku) --->
				<cfset formActionUrl = CWserializeUrl(formActionVars, request.cwpage.urlDetails) & '&product=#product.product_id#'>
			<cfoutput>
			<!--- if multiple skus--->
			<cfif len(trim(product.optiontype_ids)) and attributes.sku_id eq 0>
				<!--- button triggers option selection window --->
				<!--- height for form based on number of options --->
				<cfif attributes.option_display_type eq 'select'>
				<cfset formHeight = (listLen(product.optiontype_ids) * 45) + 270>
				<cfelse>
				<cfset formHeight = (listLen(product.sku_ids) * 30) + 270>
				</cfif>
				<!--- set up url for option selection window
					  note: intqty must remain last in the querystring,
					  as all trailing data is removed by javascript in some instances --->
				<cfset formWindowUrl = "#request.cwpage.formWindowBaseUrl#?action=#urlEncodedFormat(formActionUrl)#&product=#product.product_id#&optiontype=#attributes.option_display_type#&qty=#attributes.show_qty#&intqty=#request.cwpage.intQty#">
				<!--- link to open option selector window --->
				<script type="text/javascript">
				document.write('<form class="CWqtyForm" id="CWqtyForm-#product.product_id#">');
				<cfif attributes.show_qty>
					document.write('#cwqtyinput#');
				<cfelse>
					document.write('<input name="qty" type="hidden" value="1" class="qty">');
				</cfif>
				document.write('<button name="submit" type="submit" class="btn btn-primary"  id="CWaddButton-#product.product_id#"><i class="fa fa-shopping-cart"></i>&nbsp;&nbsp;Add to Cart&nbsp;&nbsp;</button>');

				<!--- <input type="button" value="Add to Cart&nbsp;&raquo;" class="CWaddButton CWformButton" id="CWaddButton-#product.product_id#"> --->
				document.write('<a style="display:none;" href="#formWindowUrl#" rel="#formHeight#" class="CWbuttonLink selOptions btn btn-primary"><i class="fa fa-shopping-cart"></i>&nbsp;&nbsp;Add to Cart&nbsp;&nbsp;</a>');
				<!--- <a style="display:none;" href="#formWindowUrl#" rel="#formHeight#" class="CWbuttonLink selOptions">Add to Cart&nbsp;&raquo;</a> --->
				document.write('</form>');
				</script>
				<!--- if no javascript, standard link is shown --->
				<noscript>
				<a href="#request.cwpage.urlDetails#?product=#product.product_id#" class="CWbuttonLink selOptions btn btn-primary"><i class="fa fa-shopping-cart"></i>&nbsp;&nbsp;Add to Cart&nbsp;&nbsp;</a>
				<!--- <a href="#request.cwpage.urlDetails#?product=#product.product_id#" class="CWbuttonLink">Add to Cart&nbsp;&raquo;</a> --->
				</noscript>
			<!--- if only one sku, show standard add to cart form, submits to product details page --->
			<cfelse>
				<cfif application.cw.appEnableBackOrders eq 'true' OR product.qty_max gt 0>
			<!-- add to cart form w/ option selections -->
			<form action="#formActionUrl#" method="post" name="addToCart-#product.product_id#" id="addToCart-#product.product_id#" class="CWaddForm">
				<!--- custom input (show here if label provided in admin) --->
				<cfif len(trim(product.product_custom_info_label)) AND application.cw.adminProductCustomInfoEnabled>
					<!-- custom value -->
					<div class="CWcustomInfo">
						<label class="wide" for="customInfo">#trim(product.product_custom_info_label)#:</label>
						<input type="text" name="customInfo" class="custom" size="22" value="">
					</div>
					<cfif isNumeric('attributes.sku_id') and attributes.sku_id gt 0>
					<!-- sku id -->
						<input type="hidden" name="sku_id" value="#attributes.sku_id#">
					</cfif>
				</cfif>
				<!--- if stock is ok --->
				<!-- quantity/submit -->
				<div>
					<!--- dropdowns only (or table with no options): tables method includes its own quantity fields --->
					<cfif attributes.show_qty>
					<!--- quantity input --->
					#cwqtyinput#
					<cfelse>
					<input type="hidden" value="1" name="qty">
					</cfif>
					<!--- / end quantity --->
					<!--- submit button --->
					<button name="submit" type="submit" class="btn btn-primary"><i class="fa fa-shopping-cart"></i>&nbsp;&nbsp;Add to Cart&nbsp;&nbsp;</button>

					<!--- <input name="submit" type="submit" class="btn btn-primary"
					 value="Add to Cart&nbsp;&raquo;"> --->
				</div>
				<!--- hidden values --->
				<input name="productID" type="hidden" value="#product.product_id#">
				</form>
				</cfif>
				<!--- /end if qty ok --->
			</cfif>
			<!--- /end if only one sku --->
		</cfoutput>
		<!-- /end add to cart form-->
	</cfsavecontent>
	</cfif>
</cfif>
</cfsilent>




<!--- /////// START OUTPUT /////// --->
<cfsetting enablecfoutputonly="yes">
<!--- if product info was found --->
<cfif isDefined('product.product_ID') AND isNumeric(product.product_ID) and product.product_ID gt 0>
<cfoutput>
<div class="product-list-div">
<!--- anchor link --->
<a name="product-#product.product_id#"></a>

<!--- title above image --->
	<cfif attributes.title_position neq 'below'>
	<h5>#titleHtml#</h5>
	</cfif>
	<!--- if image above product info --->
	<cfif attributes.image_position neq 'below' and len(trim(imgHtml))>

<!--- image --->
		<!--- <div class="product-list-img"> --->
			<cfoutput>#imgHtml#</cfoutput>
		<!--- </div> --->
	</cfif>
	<!--- title below image --->
	<cfif attributes.title_position eq 'below'>
	<h5>#titleHtml#</h5>
	</cfif>

	<!-- price -->
	<cfif attributes.show_price neq false>
		<!-- price range -->
		<div id="CWproductPrices-#product.product_id#" >

			<p class="<!--- CWproductPrice ---><cfif product.hasDiscount eq 'true'> strike</cfif>">
				<!--- Price:
				<span class="CWproductPriceLow">#lsCurrencyFormat(product.price_low,'local')#</span> --->

				<h3 class="text-danger">#lsCurrencyFormat(product.price_low,'local')#</h3>
				<cfif product.price_high gt product.price_low>
					<span class="priceDelim">-</span>
					<span class="CWproductPriceHigh">#lsCurrencyFormat(product.price_high,'local')#</span>
				</cfif>

	<!--- if showing taxes here (no discounts)--->
				<cfif isStruct(product.taxrate) and isDefined('product.taxrate.calctax') and product.taxrate.calctax gt 0
						and not product.hasDiscount>
					<cfset calcrate = product.taxrate.calctax>
					<cfset displayrate = product.taxrate.displayTax>
					<br>
					<span class="smallPrint">
						(<span class="CWproductTaxPriceLow">#lsCurrencyFormat(calcrate*product.price_low,'local')#</span>
						<cfif product.price_high gt product.price_low>
							<span class="priceDelim">-</span>
							<span class="CWproductTaxPriceHigh">#lsCurrencyFormat(calcrate*product.price_high,'local')#</span>
						</cfif>
						including #displayrate#% #application.cw.taxSystemLabel#)
					</span>
				</cfif>
			</p>
	<!--- if showing discounts --->
			<cfif attributes.show_discount and product.hasDiscount eq 'true'>
				<p class="text-warning">
					Reduced:
					<span class="CWproductPriceDiscLow">#lsCurrencyFormat(product.price_disc_low,'local')#</span>
					<cfif product.price_disc_high gt product.price_disc_low>
						<span class="priceDelim">-</span>
						<span class="CWproductPriceDiscHigh">#lsCurrencyFormat(product.price_disc_high,'local')#</span>
					</cfif>
					<!--- if showing taxes here --->
					<cfif isStruct(product.taxrate) and isDefined('product.taxrate.calctax') and product.taxrate.calctax gt 0>
						<cfset calcrate = product.taxrate.calctax>
						<cfset displayrate = product.taxrate.displayTax>
						<br>
						<span class="smallPrint">
							(<span class="CWproductTaxPriceLow">#lsCurrencyFormat(calcrate*product.price_disc_low,'local')#</span>
							<cfif product.price_disc_high gt product.price_disc_low>
								<span class="priceDelim">-</span>
								<span class="CWproductTaxPriceHigh">#lsCurrencyFormat(calcrate*product.price_disc_high,'local')#</span>
							</cfif>
							including #displayrate#% #application.cw.taxSystemLabel#)
						</span>
					</cfif>
				</p>
			</cfif>
<!--- 			<cfif request.cwpage.useAltPrice eq 'true'>
				<div class="CWproductPriceAlt">
					#request.cwpage.altPriceLabel#:
					<span class="CWproductPriceAltLow">#lsCurrencyFormat(product.price_alt_low,'local')#</span>
					<cfif product.price_alt_high gt product.price_alt_low>
						<span class="priceDelim">-</span>
						<span class="CWproductPriceAltHigh">#lsCurrencyFormat(product.price_alt_high,'local')#</span>
					</cfif>
				</div>
			</cfif> --->
	<!--- free shipping message --->
			<cfif application.cw.shipEnabled and product.product_ship_charge is 0 and application.cw.appDisplayFreeShipMessage>
				<p><strong>#trim(application.cw.appFreeShipMessage)#</strong></p>
			</cfif>
		</div>
		<!-- /end price range -->
	</cfif>
	<!-- /end price -->


	<!--- if image above product info --->
	<cfif attributes.image_position eq 'below' and len(trim(imgHtml))>

	<!--- image --->
		<div class="product-list-img">
			<cfoutput>#imgHtml#</cfoutput>
		</div>

	</cfif>


	<!-- product description -->
	<cfif attributes.show_description neq false AND
			len(trim(product.product_preview_description))>
		<div class="CWproductPreviewDescription">#product.product_preview_description#</div>
	</cfif>

	<!-- details link -->
	<!--- TODO :   trim the desciption if longer then the box size--->
	<cfif len(trim(attributes.details_link_text))>
	<span class="CWproductDetailsLink"><a class="CWlink" href="#detailsUrl#">#trim(attributes.details_link_text)#</a></span>
	</cfif>

	<div class="product-div-buttons-div">
		<!-- /end product description -->
		<!-- add to cart -->
		<cfif attributes.add_to_cart>
			<!--- for stock 0, show out of stock message if available --->
			<cfif len(trim(product.product_out_of_stock_message))
					and product.qty_max lte 0>
				<div class="CWalertBox alertText">#product.product_out_of_stock_message#</div>
			<!--- if ok, show add to cart form --->
			<cfelse>
				<cfoutput>#cartFormHtml#</cfoutput>
			</cfif>
		</cfif>
		<!-- /end add to cart -->

	</div>
</div>
<!-- /end CWproduct -->
</cfoutput>
</cfif>
<cfsetting enablecfoutputonly="no">