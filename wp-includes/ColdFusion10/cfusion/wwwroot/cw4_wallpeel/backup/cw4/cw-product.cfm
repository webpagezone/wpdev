<cfsilent>
<!---
==========================================================
Application: Cartweaver 4 ColdFusion
Copyright 2002 - 2013, All Rights Reserved
Developer: Application Dynamics, Inc. | Cartweaver.com
Licensing: http://www.cartweaver.com/eula
Support: http://www.cartweaver.com/support
==========================================================
File: cw-product.cfm
File Date: 2013-04-17
Description: shows product details based on product ID
with additional content including recent views, related products
Handles add to cart via included functions
NOTES:
Product options are shown as a series of select boxes or a table
(can be overridden per product by setting request.cwpage.optionDisplayType to select|table)
Add To Cart submission is managed by passing the submitted form variables to cw-mod-cartweaver.cfm
(For custom use of cw-mod-cartweaver, variables can come from any scope as long as the required values are present)
==========================================================
--->
<!--- default url variables --->
<cfparam name="url.category" default="0">
<cfparam name="url.secondary" default="0">
<cfparam name="url.product" default="0">
<!--- default page variables --->
<cfparam name="request.cwpage.productID" default="#url.product#">
<cfparam name="request.cwpage.productname" default="">
<cfparam name="request.cwpage.categoryID" default="#url.category#">
<cfparam name="request.cwpage.categoryName" default="">
<cfparam name="request.cwpage.secondaryID" default="#url.secondary#">
<cfparam name="request.cwpage.secondaryName" default="">
<cfparam name="request.cwpage.hasDiscount" default="false">
<cfparam name="request.cwpage.stockOK" default="true">
<cfparam name="request.cwpage.optionDisplayType" default="#application.cw.appDisplayOptionView#">
<cfparam name="request.cwpage.cartAction" default="#application.cw.appActionAddToCart#">
<cfparam name="request.cwpage.addToCartUrl" default="">
<cfparam name="request.cwpage.returnUrl" default="">
<cfparam name="request.cwpage.productTaxRate" default="">
<cfparam name="application.cw.appThumbsPerRow" default="5">
<cfparam name="application.cw.appThumbsPosition" default="below">
<!--- default client location variables --->
<cfparam name="session.cwclient.cwTaxCountryID" default="0">
<cfparam name="session.cwclient.cwTaxRegionID" default="0">
<!--- page alerts and errors --->
<cfparam name="request.cwpage.cartAlert" default="">
<cfparam name="request.cwpage.cartconfirm" default="">
<!--- clean up form and url variables --->
<cfinclude template="cwapp/inc/cw-inc-sanitize.cfm">
<!--- CARTWEAVER REQUIRED FUNCTIONS --->
<cfinclude template="cwapp/inc/cw-inc-functions.cfm">
<!--- form and link actions --->
<cfparam name="request.cwpage.hrefUrl" default="#CWtrailingChar(trim(application.cw.appCwStoreRoot))##request.cw.thisPage#">
<cfparam name="request.cwpage.adminUrlPrefix" default="">
<!--- if values were passed in session, put into page scope --->
<cfif isDefined('session.cw.cartAlert')>
	<cfset request.cwpage.cartAlert = session.cw.cartAlert>
	<cfset structDelete(session.cw,'cartAlert')>
</cfif>
<cfif isDefined('session.cw.cartConfirm')>
	<cfset request.cwpage.cartConfirm = session.cw.cartConfirm>
	<cfset structDelete(session.cw,'cartConfirm')>
</cfif>
<!--- initial quantity --->
<cfif isDefined('form.qty') and form.qty gt 0>
	<cfset request.cwpage.intQty = form.qty>
<cfelse>
	<cfset request.cwpage.intQty = 1>
</cfif>
<!--- form product id overrides--->
<cfif isDefined('form.productID') and isNumeric(form.productID)>
	<cfset request.cwpage.productID = form.productID>
</cfif>
<!--- other form values --->
<cfparam name="form.customInfo" default="">
<!--- page variables - request scope can be overridden per product as needed
params w/ default values are in application.cfc --->
<cfset request.cwpage.useAltPrice = application.cw.adminProductAltPriceEnabled>
<cfset request.cwpage.altPriceLabel = application.cw.adminLabelProductAltPrice>
<cfset request.cwpage.imageZoom = application.cw.appEnableImageZoom>
<cfset request.cwpage.thumbsPerRow = application.cw.appThumbsPerRow>
<cfset request.cwpage.thumbsPos = application.cw.appThumbsPosition>
<cfset request.cwpage.continueShopping = application.cw.appActionContinueShopping>
<cfif not listFindNoCase('above,below,first',request.cwpage.thumbsPos)>
	<cfset request.cwpage.thumbsPos = 'above'>
</cfif>
<!--- if not defined in url, request can override --->
<cfif url.product eq 0 and request.cwpage.productId neq 0>
	<cfset url.product = request.cwpage.productID>
</cfif>
<!--- if no valid url id provided, redirect to listings page --->
<cfset request.cwpage.relocateUrl = request.cwpage.urlResults>
<cfif not (isDefined('url.product') and isNumeric(url.product) and url.product gt 0)>
	<cflocation url="#request.cwpage.relocateUrl#" addtoken="no">
</cfif>
<!--- return to store link --->
<cfif not len(trim(request.cwpage.returnUrl))>
<cfswitch expression="#request.cwpage.continueShopping#">
	<cfcase value="results">
		<!--- get the most recent results page view  --->
		<cfloop list="#session.cw.pageViews#" index="vv">
			<cfif vv contains listLast(request.cwpage.urlResults,'/')>
				<cfset request.cwpage.returnUrl = trim(vv)>
				<cfbreak>
			</cfif>
		</cfloop>
		<cfif not len(trim(request.cwpage.returnUrl))>
			<cfset request.cwpage.returnUrl = request.cwpage.urlResults & '?category=#request.cwpage.categoryID#&secondary=#request.cwpage.secondaryID#'>
		</cfif>
	</cfcase>
	<cfcase value="details">
		<!--- get the most recent details page view --->
		<cfloop list="#session.cw.pageViews#" index="vv">
			<cfif vv contains listLast(request.cwpage.urlDetails,'/')
				AND NOT vv contains 'product=#request.cwpage.productID#'>
				<cfset request.cwpage.returnUrl = trim(vv)>
				<cfbreak>
			</cfif>
		</cfloop>
		<cfif not len(trim(request.cwpage.returnUrl))>
			<cfset request.cwpage.returnUrl = request.cwpage.urlDetails & '?product=#request.cwpage.productID#&category=#request.cwpage.categoryID#&secondary=#request.cwpage.secondaryID#'>
		</cfif>
	</cfcase>
	<cfcase value="home">
		<cfset request.cwpage.returnUrl = application.cw.appSiteUrlHttp>
	</cfcase>
</cfswitch>
</cfif>
<!--- PRODUCT DETAILS --->
<cfset product = CWgetProduct(product_id=request.cwpage.productID,info_type='complex')>
<!--- if product has no skus, or is archived, send user back to listings page --->
<cfif (not (isDefined('product.sku_ids') and len(trim(product.sku_ids))))
	or (isDefined('product.product_archive') and product.product_archive eq 1)>
	<cflocation url="#request.cwpage.relocateUrl#" addtoken="no">
</cfif>
<!--- if backorders are allowed, set max qty, check stock --->
<cfif application.cw.appEnableBackOrders>
	<cfset request.cwpage.qtymax = 99>
	<!--- if out of stock message is set, verify stock even for backorders --->
	<cfif len(trim(product.product_out_of_stock_message)) and product.qty_max lte 0>
		<cfset request.cwpage.stockok = false>
	<cfelse>
		<cfset request.cwpage.stockok = true>
	</cfif>
<!--- if backorders are not allowed, set actual quantity --->
<cfelse>
	<cfset request.cwpage.qtymax = min(99,product.qty_max)>
	<!--- in stock? --->
	<cfif request.cwpage.qtymax lte 0>
		<cfset request.cwpage.stockok = false>
	</cfif>
	<!--- display type if only one sku, no table view available --->
	<cfif listLen(product.sku_ids) lte 1>
		<cfset request.cwpage.optionDisplayType = 'select'>
	</cfif>
</cfif>
<!--- tax rate --->
<cfif application.cw.taxDisplayOnProduct>
	<cfset request.cwpage.producttaxrate = cwGetProductTax(product_id=val(request.cwpage.productID), region_id=val(session.cwclient.cwTaxRegionID), country_id=val(session.cwclient.cwTaxCountryID))>
<cfelse>
	<cfset request.cwpage.producttaxrate = ''>
</cfif>
<!--- discounts --->
<cfif application.cw.discountsenabled AND
	((isDefined('product.price_disc_low') and product.price_disc_low neq product.price_low) OR (isDefined('product.price_disc_high') and product.price_disc_high neq product.price_high))>
	<cfset request.cwpage.hasDiscount = true>
<cfelse>
	<cfset request.cwpage.hasDiscount = false>
</cfif>
<!--- ADD TO CART / FORM SUBMISSION --->
<!--- if productID field is defined, and equal to ID in url --->
<cfif isDefined('form.productID') AND form.productID eq request.cwpage.productID>
	<!--- verify quantity --->
	<cfif isDefined('form.qty') and not isNumeric(form.qty)>
		<cfset form.qty = 1>
	</cfif>
	<!--- pass all form variables to cartweaver tag --->
	<cfset formStruct = form>
	<!--- redirect after cart action --->
	<cfif request.cwpage.cartAction eq 'goTo' and not len(trim(request.cwpage.addToCartUrl))>
		<cfset request.cwpage.addToCartUrl = trim(request.cwpage.urlShowCart)>
	<cfelse>
		<cfset request.cwpage.addToCartUrl = request.cw.thisPage>
	</cfif>
	<!--- reset stored ship cost, since cart may have changed --->
	<cfset session.cwclient.cwShipTotal = 0>
	<cfset session.cw.confirmShip = false>
	<cfset structDelete(session.cw,'confirmShipID')>
	<cfset structDelete(session.cw,'confirmShipName')>
	<cfmodule
	template="cwapp/mod/cw-mod-cartweaver.cfm"
	product_id = "#form.productID#"
	form_values="#formstruct#"
	redirect="#request.cwpage.addToCartUrl#"
	sku_custom_info="#form.customInfo#"
	>
</cfif>
<!--- get product image --->
<cfset product.productImgMain = CWgetImage(product_id=request.cwpage.productID,image_type=2,default_image=application.cw.appImageDefault)>
<cfif len(product.productImgMain)>
	<cfset request.cwpage.imgDir = left(product.productImgMain,len(product.productImgMain)-len(listLast(product.productImgMain,'/')))>
<cfelse>
	<cfset request.cwpage.imgDir = ''>
</cfif>
<!--- get product zoom image --->
<cfset product.productImgZoom = CWgetImage(product_id=request.cwpage.productID,image_type=3,default_image='')>
<cfif len(product.productImgZoom)>
	<cfset request.cwpage.zoomDir = left(product.productImgZoom,len(product.productImgZoom)-len(listLast(product.productImgZoom,'/')))>
<cfelse>
	<cfset request.cwpage.zoomDir = ''>
</cfif>
<!--- get product initial thumbnail --->
<cfset product.productImgThumb = CWgetImage(product_id=request.cwpage.productID,image_type=6,default_image='')>
<cfif len(product.productImgThumb)>
	<cfset request.cwpage.thumbDir = left(product.productImgThumb,len(product.productImgThumb)-len(listLast(product.productImgThumb,'/')))>
<cfelse>
	<cfset request.cwpage.thumbDir = ''>
</cfif>
<!--- count thumbnails --->
<cfset request.cwpage.imagethumbs = listLen(product.image_thumbnails)>
<!--- only show thumbs if main image is ok --->
<cfif len(trim(product.productImgMain)) eq 0 or request.cwpage.thumbsPerRow eq 0 or len(request.cwpage.thumbDir) eq 0>
	<cfset request.cwpage.imagethumbs = 0>
</cfif>
<!--- make sure file exists for zoom link (avoid broken links) --->
<cfif not len(trim(product.productImgZoom))>
	<cfset request.cwpage.imagezoom = 0>
</cfif>
<!--- put required scripting into page head --->
<cfsavecontent variable="headcontent">
<!--- fancybox: image zoom / add to cart options for related products --->
<script type="text/javascript">
	jQuery(document).ready(function(){
	// set filename on any image element
	var $setSrc = function(triggerEl,targetEl){
			var triggerSrc = jQuery(triggerEl).attr('src');
			var triggerIndex = triggerSrc.lastIndexOf("/") + 1;
			var newFn = triggerSrc.substr(triggerIndex);
			var targetSrc = jQuery(targetEl).attr('src');
			var targetIndex = targetSrc.lastIndexOf("/") + 1;
			var oldFn = targetSrc.substr(targetIndex);
			var targetDir = targetSrc.replace(oldFn,'');
			var newSrc = targetDir + newFn;
			targetEl.attr('src',newSrc);
		};
	// set href on any link
	var $setHref = function(triggerEl,targetEl){
			var triggerHref = jQuery(triggerEl).attr('href');
			var triggerIndex = triggerHref.lastIndexOf("/") + 1;
			var newFn = triggerHref.substr(triggerIndex);
			var targetHref = jQuery(targetEl).attr('href');
			var targetIndex = targetHref.lastIndexOf("/") + 1;
			var oldFn = targetHref.substr(targetIndex);
			var targetDir = targetHref.replace(oldFn,'');
			var newHref = targetDir + newFn;
			targetEl.attr('href',newHref);
		};
	<!--- if showing thumbnails --->
	<cfif request.cwpage.imagethumbs neq 0>
		jQuery('img.CWthumb').hover(function(){
			$setSrc(jQuery(this),jQuery('#CWproductImgMain'));
			<cfif request.cwpage.imageZoom neq 0>
			$setHref(jQuery(this).parent('a'),jQuery('#CWproduct<cfoutput>#product.product_id#</cfoutput>imgLink'));
			$setHref(jQuery(this).parent('a'),jQuery('#CWproduct<cfoutput>#product.product_id#</cfoutput>zoomLink'));
			</cfif>
			});
	</cfif>
	<!--- if showing zoom image --->
	<cfif request.cwpage.imagezoom neq 0>
		<!--- settings apply to any link with class 'CWimageZoomLink' --->
		jQuery('a.CWimageZoomLink').each(function(){
			jQuery(this).fancybox({
			'titlePosition': 'over',
			'padding': 0,
			'margin' : 0,
			'overlayShow': true,
			'showCloseButton': true,
			'hideOnOverlayClick':true,
			'hideOnContentClick': true,
			'autoDimensions': true,
			'centerOnScroll': true,
			'showNavArrows':true,
			'cyclic':true
			});
		});
		jQuery('a.CWtriggerZoomLink').click(function(){
			var zoomHref = jQuery(this).attr('href');
			jQuery('a.CWimageZoomLink[href="' + zoomHref + '"]').trigger('click');
			return false;
			});
		// fancybox - see http://fancybox.net/api for available options
	</cfif>
	});
</script>
</cfsavecontent>
<cfhtmlhead text="#headcontent#">
<!--- CREATE THUMBNAILS for various placements --->
<cfsavecontent variable="request.cwpage.thumbsHtml">
<cfoutput>
	<cfif request.cwpage.imagethumbs gt 1>
	<div class="CWproductThumbs">
		<cfset loopCt = 1>
		<cfloop list="#product.image_thumbnails#" index="i">
				<cfif request.cwpage.imageZoom>
					<!--- show the image with zoom link --->
					<a href="#request.cwpage.zoomDir##i#" class="CWimageZoomLink CWlink" title="#product.product_name#" rel="CWproduct"><img class="CWthumb" src="#request.cwpage.thumbDir##i#" alt="#product.product_name#"></a>
				<cfelse>
					<!--- show only the image, no link, no zoom --->
					<img class="CWthumb" src="#request.cwpage.thumbDir##i#" alt="#product.product_name#">
				</cfif>
		<cfif loopCt mod request.cwpage.thumbsPerRow eq 0>
			</div><div class="CWproductThumbs">
		</cfif>
		<cfset loopCt = loopCt + 1>
		</cfloop>
	</div>
	</cfif>
</cfoutput>
</cfsavecontent>
</cfsilent>
<!--- /////// START OUTPUT /////// --->
<!--- breadcrumb navigation --->
<cfmodule template="cwapp/mod/cw-mod-searchnav.cfm"
search_type="breadcrumb"
separator=" &raquo; "
>
<!--- show product details --->
<div class="CWproduct CWcontent" id="CWdetails">
	<!--- if product is found, and on web = yes --->
	<cfif product.product_on_web eq 'true' and product.product_archive neq 1
			AND (application.cw.appEnableBackOrders OR request.cwpage.stockok)>
		<cfoutput>
		<!--- product name --->
		<h1 class="CWproductName">#product.product_name#</h1>
		<!--- thumbnails 'first' --->
		<cfif request.cwpage.thumbsPos is 'first'>#request.cwpage.thumbsHtml#</cfif>
		<!--- product image --->
		<cfif len(trim(product.productImgMain))>
				<!--- product image wrapper --->
				<div class="CWproductImage">
				<!--- thumbnails 'above' --->
				<cfif request.cwpage.thumbsPos is 'above'>#request.cwpage.thumbsHtml#</cfif>
					<cfif request.cwpage.imageZoom>
						<!--- show the image with zoom link --->
						<a href="#product.productImgZoom#" id="CWproduct#product.product_id#imgLink" class="<cfif request.cwpage.imagethumbs gt 1>CWtriggerZoomLink<cfelse>CWimageZoomLink</cfif> CWlink" title="#product.product_name#"<cfif request.cwpage.imagethumbs lte 1> rel="CWproduct"</cfif>><img src="#product.productImgMain#" alt="#product.product_name#: click to enlarge" id="CWproductImgMain"></a>
						<div>
							<a href="#product.productImgZoom#" id="CWproduct#product.product_id#zoomLink" class="<cfif request.cwpage.imagethumbs gt 1>CWtriggerZoomLink<cfelse>CWimageZoomLink</cfif> CWlink" title="#product.product_name#">Click to Enlarge</a>
						</div>
					<cfelse>
						<!--- show only the image, no link, no zoom --->
						<img src="#product.productImgMain#" alt="#product.product_name#" id="CWproductImgMain">
					</cfif>
				<!--- thumbnails 'below' --->
				<cfif request.cwpage.thumbsPos is 'below'>#request.cwpage.thumbsHtml#</cfif>
				</div>
				<!--- /end product image --->
			</cfif>
			<!--- product info column --->
			<div id="CWproductInfo">
				<!--- anchor for product info on submission --->
				<a name="skus"></a>
				<!--- price range --->
				<div id="CWproductPrices">
					<div class="CWproductPrice<cfif request.cwpage.hasDiscount eq 'true'> strike</cfif>">
						Price:
						<span class="CWproductPriceLow">#lsCurrencyFormat(product.price_low,'local')#</span>
						<cfif product.price_high gt product.price_low>
							<span class="priceDelim">-</span>
							<span class="CWproductPriceHigh">#lsCurrencyFormat(product.price_high,'local')#</span>
						</cfif>
						<!--- if showing taxes here (no discount) --->
						<cfif isStruct(request.cwpage.productTaxRate) and isDefined('request.cwpage.productTaxRate.calctax') and request.cwpage.productTaxRate.calctax gt 0
						and not request.cwpage.hasDiscount>
							<cfset calcrate = request.cwpage.productTaxRate.calctax>
							<cfset displayrate = request.cwpage.productTaxRate.displayTax>
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
					</div>
					<!--- if showing discount price --->
					<cfif request.cwpage.hasDiscount eq 'true'>
						<div class="CWproductPriceDisc alertText">
							Discount Price:
							<span class="CWproductPriceDiscLow">#lsCurrencyFormat(product.price_disc_low,'local')#</span>
							<cfif product.price_disc_high gt product.price_disc_low>
								<span class="priceDelim">-</span>
								<span class="CWproductPriceDiscHigh">#lsCurrencyFormat(product.price_disc_high,'local')#</span>
							</cfif>
						<!--- if showing taxes here --->
						<cfif isStruct(request.cwpage.productTaxRate) and isDefined('request.cwpage.productTaxRate.calctax') and request.cwpage.productTaxRate.calctax gt 0>
							<cfset calcrate = request.cwpage.productTaxRate.calctax>
							<cfset displayrate = request.cwpage.productTaxRate.displayTax>
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
						</div>
					</cfif>
					<!--- alt price (msrp) --->
					<cfif request.cwpage.useAltPrice eq 'true'>
						<div class="CWproductPriceAlt">
							#request.cwpage.altPriceLabel#:
							<span class="CWproductPriceAltLow">#lsCurrencyFormat(product.price_alt_low,'local')#</span>
							<cfif product.price_alt_high gt product.price_alt_low>
								<span class="priceDelim">-</span>
								<span class="CWproductPriceAltHigh">#lsCurrencyFormat(product.price_alt_high,'local')#</span>
							</cfif>
						</div>
					</cfif>
					<!--- free shipping message --->
					<cfif application.cw.shipEnabled and product.product_ship_charge is 0 and application.cw.appDisplayFreeShipMessage>
						<p><strong>#trim(application.cw.appFreeShipMessage)#</strong></p>
					</cfif>
				</div>
				<!--- /end price range --->
				<!--- determine url vars to pass through with cart submission --->
				<cfset formActionVars = 'product'>
				<cfif isDefined('url.category') and url.category gt 0><cfset formActionVars = listAppend(formActionVars,'category')></cfif>
				<cfif isDefined('url.secondary') and url.secondary gt 0><cfset formActionVars = listAppend(formActionVars,'secondary')></cfif>
				<cfset formActionUrl = CWserializeUrl(formActionVars, request.cwpage.hrefUrl)>
				<!--- add to cart form w/ option selections --->
				<form action="#formActionUrl#" class="CWvalidate" method="post" name="AddToCart" id="CWformAddToCart">
					<!--- product options: shows select lists or table based on variable setting for 'display type' --->
					<cfmodule
					template="cwapp/mod/cw-mod-productoptions.cfm"
					product_id="#request.cwpage.productID#"
					product_options="#product.optiontype_ids#"
					display_type="#request.cwpage.optionDisplayType#"
					tax_rate="#request.cwpage.producttaxrate#"
					>
					<!--- custom input (show here if label provided in admin) --->
					<cfif len(trim(product.product_custom_info_label)) AND application.cw.adminProductCustomInfoEnabled>
						<!--- custom value --->
						<div class="CWcustomInfo">
							<label class="wide" for="customInfo">#trim(product.product_custom_info_label)#:</label>
							<input type="text" name="customInfo" class="custom" size="22" value="#form.customInfo#" maxlength="255">
						</div>
					</cfif>
					<!--- if stock is ok --->
					<cfif request.cwpage.stockok eq true>
						<!--- quantity/submit --->
						<div>
							<!--- dropdowns only (or table with no options): tables method includes its own quantity fields --->
							<cfif request.cwpage.optionDisplayType neq 'table' or len(trim(product.optiontype_ids)) lt 1>
								<!--- quantity input --->
								<label for="qty">Quantity:</label>
								<cfif application.cw.appDisplayProductQtyType is 'text'>
									<input name="qty" id="qtyInput" type="text" value="<cfoutput>#request.cwpage.intQty#</cfoutput>" class="{required:true,number:true,min:1} qty" title="Quantity is required" size="2" onkeyup="extractNumeric(this,0,false)">
								<cfelse>
									<select name="qty" class="{required:true,min:1}" title="Quantity">
										<cfloop from="1" to="#request.cwpage.qtymax#" index="ii"><option value="#ii#"<cfif ii eq request.cwpage.intQty> selected="selected"</cfif>>#ii#</option></cfloop>
									</select>
								</cfif>
							</cfif>
							<!--- / end quantity --->
							<!--- submit button --->
							<div class="center CWclear">
								<input name="submit" type="submit" class="CWformButton" value="Add to Cart&nbsp;&raquo;">
							</div>
						</div>
						<!--- if stock is not ok --->
					<cfelse>
						<div class="CWalertBox alertText">#product.product_out_of_stock_message#</div>
					</cfif>
					<!--- confirmation / alerts --->
					<cfif len(trim(request.cwpage.cartconfirm))>
						<!--- list confirmations, add view cart link --->
						<div class="CWconfirmBox confirmText"><div>#replace(request.cwpage.cartconfirm,',','</div><div>','all')#</div><a href="#request.cwpage.urlShowCart#">View Cart</a></div>
						<cfset structDelete(session.cw,'cartConfirm')>
					</cfif>
					<cfif len(trim(request.cwpage.cartAlert))>
						<div class="CWalertBox alertText fadeOut"><div>#replace(request.cwpage.cartAlert,',','</div><div>','all')#</div></div>
						<cfset structDelete(session.cw,'cartAlert')>
					</cfif>
					<!--- hidden values --->
					<input name="productID" type="hidden" value="#request.cwpage.productID#">
				</form>
				<!--- /end add to cart form --->
				<!--- product description --->
				<cfif len(trim(product.product_description))>
					<div class="CWproductDescription">#product.product_description#</div>
					<!--- continue shopping --->
					<cfif isDefined('request.cwpage.returnUrl') and len(trim(request.cwpage.returnUrl))>
						<p class="CWcontShop">&raquo;&nbsp;<a href="<cfoutput>#request.cwpage.returnUrl#</cfoutput>">Continue Shopping</a></p>
					</cfif>
				</cfif>
				<!--- /end product description --->
			<!--- edit product link --->
			<cfif application.cw.adminProductLinksEnabled
				and isDefined('session.cw.loggedIn') and session.cw.loggedIn is '1'
				and isDefined('session.cw.accessLevel') and	listFindNoCase('developer,merchant',session.cw.accessLevel)>
				<cfoutput><p><a href="#request.cwpage.adminUrlPrefix##application.cw.appCwAdminDir#product-details.cfm?productid=#request.cwpage.productID#" title="Edit Product" class="CWeditProductLink"><img src="#request.cwpage.adminUrlPrefix##application.cw.appCwAdminDir#img/cw-edit.gif" alt="Edit Product"></a></p></cfoutput>
			</cfif>
			</div>
			<!--- /end product info --->
			<!--- special description --->
			<cfif len(trim(product.product_special_description))>
				<div class="CWproductSpecialDescription">#product.product_special_description#</div>
			</cfif>
			<!--- /end special description --->
			<!--- related products --->
			<!--- if related products exist for this product --->
			<!--- will be null value if related products turned off in admin --->
			<cfif len(trim(product.related_product_ids))>
				<!--- show all related products in this area --->
				<div class="CWproductRelatedProducts">
					<h3>Related Items:</h3>
					<!--- show related items in random order --->
					<cfset rprodList = CWlistRandom(list_string=product.related_product_ids,max_items=4)>
					<!--- loop the list of related IDs from CWgetProduct above --->
					<cfset loopCt = 0>
					<cfloop list="#rprodList#" index="pp">
						<!--- count output for insertion of breaks or other formatting --->
						<cfset loopCt = loopCt + 1>
						<!--- show the product include --->
						<cfmodule
						template="cwapp/mod/cw-mod-productpreview-cust.cfm"
						product_id="#pp#"
						show_description="false"
						show_image="true"
						show_price="true"
						image_class="CWimgRelated"
						image_position="above"
						title_position="above"
						details_page="#request.cwpage.hrefUrl#"
						details_link_text="&raquo; details"
						add_to_cart="false"
						price_id="CWproductPrices-#pp#"
						>
						<!--- divided every xx products, set in admin --->
						<cfif loopCt mod application.cw.appDisplayUpsellColumns is 0>
							<div class="CWclear upsellDiv"></div>
						</cfif>
					</cfloop>
				</div>
			</cfif>
			<!--- /end related products --->
		</cfoutput>
	<!--- if product not on web, or archived --->
	<cfelse>
		<div class="CWalertBox">
			No Product Selected
			<cfif isDefined('request.cwpage.returnUrl')><a href="<cfoutput>#request.cwpage.returnUrl#</cfoutput>" class="CWlink">Return to Store</a></cfif>
		</div>
	</cfif>
	<!--- clear floated content --->
	<div class="CWclear"></div>
</div>
<!--- / end #CWdetails --->
<!--- recently viewed products --->
<cfinclude template="cwapp/inc/cw-inc-recentview.cfm">
<!--- page end / debug --->
<cfinclude template="cwapp/inc/cw-inc-pageend.cfm">