<cfsilent>
<!---
==========================================================
Application: Cartweaver 4 ColdFusion
Copyright 2002 - 2012, All Rights Reserved
Developer: Application Dynamics, Inc. | Cartweaver.com
Licensing: http://www.cartweaver.com/eula
Support: http://www.cartweaver.com/support
==========================================================
File: cw-mod-productoptions.cfm
File Date: 2012-07-07
Description: displays product options for selection as part of the 'add to cart' form,
and adds javascript to page for function of dropdowns and form validation.
Options can be shown as related select lists, or as a table where multiple skus
can be selected at once.

NOTES:
To reset the dropdown selections, we restore options from a hidden copy of each select list, created onload with $clone()

// ATTRIBUTES
- product_id: id of the product to show
- display_type: optional - the type of options display being shown (table|select)
- product_options: optional - struct (from getproduct function)
- product_option_list: optional - list of product ids
- int_qty: optional - quantity shown by default
- max_qty: optional - max number of items available in qty dropdowns
- tax_rate: optional - a structure of tax info returned by the cwGetProductTax() function
			(if not provided, a lookup is attempted within this routine, based on product ID)

==========================================================
--->

<!--- id of product to show options for --->
<cfparam name="attributes.product_id" default="0" type="numeric">
<!--- display type --->
<cfparam name="attributes.display_type" default="#application.cw.appDisplayOptionView#" type="string">
<!--- list of option type ids --->
<cfparam name="attributes.product_options" default="" type="string">
<!--- defaults for quantity --->
<cfparam name="application.cw.appDisplayProductQtyType" default="text" type="string">
<cfparam name="attributes.int_qty" default="1" type="string">
<cfparam name="attributes.max_qty" default="100" type="string">
<!--- id of the parent form --->
<cfparam name="attributes.form_id" default="CWformAddToCart" type="string">
<!--- id of the pricing area for this selection --->
<cfparam name="attributes.price_id" default="CWproductPrices" type="string">
<!--- tax rate: passed in as a structure from calling page --->
<cfparam name="attributes.tax_rate" default="">
<cfparam name="attributes.tax_calc_type" default="#application.cw.taxCalctype#">
<!--- customer id: used for getting customer-specific discounts --->
<cfparam name="session.cwclient.cwCustomerID" default="0">
<cfparam name="attributes.customer_id" default="#session.cwclient.cwCustomerID#">
<!--- promo code: used for getting customer-applied discounts --->
<cfparam name="session.cwclient.discountPromoCode" default="">
<cfparam name="attributes.promo_code" default="#session.cwclient.discountPromoCode#">
<!--- clean up form and url variables --->
<cfinclude template="../inc/cw-inc-sanitize.cfm">
<!--- global functions --->
<cfinclude template="../inc/cw-inc-functions.cfm">
<!--- look up tax rate if not provided (only if using local calc) --->
<cfif application.cw.taxDisplayOnProduct and attributes.tax_calc_type is 'localtax'>
	<cfif (not isStruct(attributes.tax_rate)) and isDefined('session.cwclient.cwTaxRegionID') and session.cwclient.cwTaxRegionID gt 0>
	<cfset attributes.tax_rate = cwGetProductTax(product_id=val(attributes.product_id), region_id=val(session.cwclient.cwTaxRegionID), country_id=val(session.cwclient.cwTaxCountryID))>
	</cfif>
<cfelse>
	<cfset attributes.tax_rate = ''>
</cfif>
<!--- if we have a list, use it --->
<cfif len(trim(attributes.product_options)) AND isNumeric(trim(listFirst(attributes.product_options)))>
	<cfset optiondata.idlist = trim(attributes.product_options)>
<!--- if no list, get from query based on product id --->
<cfelse>
	<cfset optiontypesquery = CWquerySelectOptionTypes(attributes.product_id)>
	<cfset optiondata.idlist = ''>
	<cfoutput query="optiontypesquery" group="optiontype_id">
		<cfset optiondata.idlist = listAppend(optiondata.idlist,'#optiontype_id#')>
	</cfoutput>
</cfif>
<!--- query for all product skus and prices --->
<cfset skusQuery = CWquerySelectSkus(attributes.product_id)>
	<!--- get product data for building option lists --->
	<cfset skuTableQuery = CWquerySelectSkuOptions(attributes.product_id)>
	<!--- get options for this product --->
	<cfif not isDefined('optiontypesquery')>
		<cfset optiontypesquery = CWquerySelectOptionTypes(attributes.product_id)>
	</cfif>
	<!--- only show table if we have valid options --->
	<cfif skuTableQuery.recordCount lt 1 OR optionTypesQuery.recordCount lt 1>
		<cfset attributes.display_type = 'select'>
	</cfif>
</cfsilent>
<!--- START OUTPUT --->

<!--BOF Product Color Option-->

<!--- <fieldset class="attribute_fieldset">

<label class="attribute_label" >Color&nbsp;</label>
<div class="attribute_list">

	<ul id="color_to_pick_list" class="clearfix">
		<li class="selected">
			<a href="http://127.0.0.1/ps/index.php?id_product=1&amp;controller=product"
				id="color_13"
				name="Orange"
				class="color_pick selected"
				style="background:#F39C11;" title="Orange">
			</a>
		</li>
		<li>																																																																										<li>
			<a href="http://127.0.0.1/ps/index.php?id_product=1&amp;controller=product"
				id="color_14"
				name="Blue"
				class="color_pick"
				style="background:#5D9CEC;" title="Blue">
			</a>
		</li>
	</ul>
</div> --->

<!--- show options for selected display type --->
<cfswitch expression="#attributes.display_type#">

<!--- TABLES ('table') --->
<cfcase value="table">
	<!--- create array of options --->
	<cfset optionList = ''>
	<cfoutput query="optionTypesQuery" group="optiontype_id">
		<cfset optionList = listAppend(optionList,optionTypesQuery.optionType_Name)>
	</cfoutput>
	<cfset optionLabels = listToArray(optionList)>
	<cfset optionCt = arrayLen(optionLabels)>
	<cfset optionArray = arrayNew(1)>
	<cfset prodCt = 0>
	<table class="CWtable" id="CWoptionsTable">
	<!--- header row --->
	<tr class="headerRow">
	<!--- SKU --->
	<th>SKU</th>
	<!--- OPTION NAMES --->
	<!--- output the headers for each column --->
	<cfloop index="ii" from="1" to="#optionCt#">
	<th><cfoutput>#trim(optionLabels[ii])#</cfoutput></th>
	</cfloop>
	<!--- PRICE --->
	<th>Price</th>
	<!--- QTY --->
	<th>Qty.</th>
	</tr>
	<!--- /end header row --->
	<!--- output product data with qty/add to cart --->
	<cfoutput query="skuTableQuery" group="sku_merchant_sku_id">
	<!--- create a row for each SKU --->
	<cfset prodCt = prodCt + 1>
	<!--- default qty value --->
	<cfset prodQtyField = "form.qty#prodCt#">
	<cfparam name="#prodQtyField#" default="">
	<cfset prodQtyVal = evaluate(prodQtyField)>
	<!--- set up the price --->
	<cfset currentPrice = skuTableQuery.sku_price>
	<cfset displayPrice = lsCurrencyFormat(skuTableQuery.sku_price,'local')>
	<cfset skuCalcPrice = currentPrice>
	<cfset showDiscountTax = false>
	<!--- if showing tax price --->
	<cfif application.cw.taxDisplayOnProduct
		AND isStruct(attributes.tax_rate) and isDefined('attributes.tax_rate.calctax') and attributes.tax_rate.calctax gt 0>
		<cfset skuCalcPrice = round(skuTableQuery.sku_Price*attributes.tax_rate.calctax*100)/100>
		<cfset displayPrice = displayPrice & '<br><span class="smallPrint">(#lsCurrencyFormat(skuCalcPrice,'local')# including #attributes.tax_rate.displaytax#% #application.cw.taxSystemLabel#)</span>'>
		<cfset showDiscountTax = true>
	</cfif>
	<!--- if showing discounts --->
	<cfif application.cw.discountsEnabled>
		<!--- check for discounts applied to each sku --->
		<cfset discountAmount = CWgetSKUDiscountAmount(
				discount_type='sku_cost',
				sku_id=sku_id,
				customer_id=attributes.customer_id,
				promo_code=attributes.promo_code
				)>
		<cfif discountAmount gt 0>
			<cfset discountedPrice = skuCalcPrice - discountAmount>
			<cfif showDiscountTax eq true>
				<cfset discountTaxText = '<span class="smallPrint"> including #attributes.tax_rate.displaytax#% #application.cw.taxSystemLabel#</span>'>
			<cfelse>
				<cfset discountTaxText = ''>
			</cfif>
			<cfset displayPrice = '<span class="CWproductPriceOld">' & displayPrice & '</span>' & '<br><span class="CWproductPriceDisc">' & lsCurrencyFormat(discountedPrice,'local') & discountTaxText & '</span>' >
		</cfif>
	</cfif>
	<tr>
		<!--- sku --->
		<td>#skuTableQuery.sku_merchant_sku_id#</td>
		<!--- option values --->
		<!--- set all options to 'none' --->
		<cfset temp = ArraySet(optionArray,1,optionCt,'none')>
			<!--- nested cfoutput ungroups options --->
			<cfoutput>
				<!--- find the current option in the OptionNames list --->
				<cfset i = listFind(optionList, skuTableQuery.optiontype_name)>
				<!--- Set the array to the option name --->
				<cfset temp = arraySet(optionArray, i, i, skuTableQuery.option_name)>
			</cfoutput>
			<!--- output each option for this sku --->
			<cfloop index="ii" from="1" to="#optionCt#">
				<td>#optionArray[ii]#</td>
			</cfloop>
		<!--- price --->
		<td>#displayPrice#</td>
		<!--- qty --->
		<td class="CWinputCell">
			<cfif application.cw.appDisplayProductQtyType is 'text'>
			<input name="qty#prodCt#" class="qty" type="number" required
			value="#prodQtyVal#"
			size="1" onkeyup="extractNumeric(this,0,false)">
			<cfelse>
			<select name="qty#prodCt#">
			<cfloop from="0" to="#attributes.max_qty#" index="ii"><option value="#ii#"<cfif ii eq 0 or ii eq prodQtyVal> selected="selected"</cfif>>#ii#</option></cfloop>
			</select>
			</cfif>
			<!--- hidden field for sku id --->
			<input name="skuID#prodCt#" type="hidden" value="#skuTableQuery.sku_id#">
		</td>
	</tr>
	</cfoutput>
</table>
<!--- addSkus field contains number of skus being submitted via table options --->
<div>
	<input type="hidden" name="addSkus" value="<cfoutput>#prodCt#</cfoutput>">
	<!--- total qty used for validation of table sums --->
	<input type="hidden" name="totalQty" id="totalQty" value="0">
</div>


<!--- validation script for tables
(uses calculation script called from global scripts)
--->
<!--- <cfset formScriptvar = 'request.#attributes.form_id#FormScript'> --->
<!--- <cfif not isDefined(#formScriptVar#)>
<cfsavecontent variable="#formScriptVar#">
	<script type="text/javascript">
	jQuery(document).ready(function(){
		jQuery('form#CWformAddToCart input.qty').keyup(function(){
			var sumVal = jQuery('form#CWformAddToCart input.qty').sum();
			//alert(sumVal);
			jQuery('form#CWformAddToCart input#totalQty').val(sumVal);
		});
	});
	</script>
</cfsavecontent>
<cfhtmlhead text="#evaluate(formscriptvar)#">
</cfif> --->

</cfcase>
<!--- / END TABLES --->



<!--- SELECT BOXES ('select')--->
<cfdefaultcase>
	<!--- optiondata.idlist: <cfoutput>#optiondata.idlist#</cfoutput>
	<br> --->

<!--- loop the list of option IDs --->
<cfloop list="#optiondata.idlist#" index="ii">

	<!--- <cfoutput>iiii:#ii#<br></cfoutput><br> --->

	<div class="row CWoptionSel" id="opt<cfoutput>#ii#</cfoutput>" style="margin:10px 0 10px 0;">

		<!--- get options for this product with sku ids --->
		<cfset optionQuery = CWquerySelectRelOptions(product_id=attributes.product_id,product_options=ii)>
        <!--- <cfdump var="#optionQuery#"> --->

		<!--- label for select list element --->
		<cfoutput>
			<label for="optionSel#ii#" class="col-lg-4  text-right">#optionQuery.optiontype_name#:</label>
		</cfoutput>

		<!--- select list --->
		<cfset selectName = 'optionSel#ii#'>
		<cfparam name="form.#selectName#" default="">
		<cfset selectVal = evaluate('form.#selectName#')>
		<cfset iscolor = optionQuery.optiontype_iscolor>

		<div class="col-lg-3">

		<cfif iscolor>

			<div id="<cfoutput>#selectName#</cfoutput>" class="options" >

				<cfset colorCount = 0>
				<cfoutput query="optionQuery" group="option_name">

					<a class="color-option <cfif colorCount eq 0> color-active</cfif>"
					id="color-option-#option_id#"

					option-value="#option_id#"
					option-text-id="option-text-<cfoutput>#ii#</cfoutput>"
					style="background-color: #option_hex#"
					title="#trim(option_name)# is requred"
					>
					</a>
					<cfset colorCount =colorCount + 1>
				</cfoutput>

				<div class="hidden">

					<select
					name="<cfoutput>#selectName#</cfoutput>"
					id="<cfoutput>#selectName#</cfoutput>"
					class="form-control selectme" required
					title="<cfoutput>#optionQuery.optiontype_name#</cfoutput> is required">
						<!--- placeholder select option --->
						<!--- <option value="" class="sku0">-- Select --</option> --->
						<!--- output options --->
						<cfoutput query="optionQuery" group="option_name">
							<!--- create list of classes for related scripting, save as variable --->
							<cfsavecontent variable="skuidclasses">
								<!--- nested cfoutput ungroups query results --->
								<cfoutput>sku#sku_id# </cfoutput>
							</cfsavecontent>
							<!--- show option with listed classes --->
							<option
							value="#option_id#"
							class="#trim(skuidclasses)#"<cfif option_id eq selectVal> selected="selected"</cfif>
							>
								#trim(option_name)#
							</option>
						</cfoutput>
					</select>
				</div>
		</div>


		<cfelse>

			<select
			name="<cfoutput>#selectName#</cfoutput>"
			id="<cfoutput>#selectName#</cfoutput>"
			class="form-control selectme" required
			title="<cfoutput>#optionQuery.optiontype_name#</cfoutput> is required" onkeyup="this.blur();this.focus();">
				<!--- placeholder select option --->
				<!--- <option value="" class="sku0">-- Select --</option> --->
				<!--- output options --->
				<cfoutput query="optionQuery" group="option_name">
					<!--- create list of classes for related scripting, save as variable --->
					<cfsavecontent variable="skuidclasses">
						<!--- nested cfoutput ungroups query results --->
						<cfoutput>sku#sku_id# </cfoutput>
					</cfsavecontent>
					<!--- show option with listed classes --->
					<option
					value="#option_id#"
					class="#trim(skuidclasses)#"<cfif option_id eq selectVal> selected="selected"</cfif>>#trim(option_name)#</option>
				</cfoutput>
			</select>
		</cfif>



		</div>
		<div class="col-lg-5">
			<!--- option description text --->
				<cfif len(trim(optionQuery.optiontype_text))>
					<cfoutput><div class="CWoptionText small">#trim(optionQuery.optiontype_text)#</div></cfoutput>
				</cfif>
		</div>

	<!--- hidden clone div, for resetting selections --->
	<div style="display:none;" class="CWoptionRes" id="res<cfoutput>#ii#</cfoutput>"></div>
</div>
</cfloop>
<!--- hidden sku ids placeholder field --->
<div><input type="hidden" value="" name="availSkus" id="availSkus"></div>
</cfdefaultcase>
<!--- / END SELECT BOXES--->
</cfswitch>
<!--- / END OUTPUT --->

<script type="text/javascript">
	<!--
			$("a.color-option").click(function(event)
			{
				$this = $(this);

				// highlight current color box
				$this.parent().find('a.color-option').removeClass('color-active');
				$this.addClass('color-active');

				$('#' + $this.attr('option-text-id')).html($this.attr('title'));

				// trigger selection event on hidden select
				$select = $this.parent().find('select');

				$select.val($this.attr('option-value'));
				$select.trigger('change');

				//option redux
				if(typeof updatePx == 'function') {
					updatePx();
				}

				//option boost
				if(typeof obUpdate == 'function') {
					obUpdate($($this.parent().find('select option:selected')), useSwatch);
				}
				event.preventDefault();
			});

			$("a.color-option").parent('.option').find('.hidden select').change(function()
			{
				$this = $(this);
				var optionValueId = $this.val();
				$colorOption = $('a#color-option-' + optionValueId);
				if(!$colorOption.hasClass('color-active'))
					$colorOption.trigger('click');
			});
			//-->
</script>
			<!--EOF Product Color Option-->

<!---  JAVASCRIPT FOR SELECTION CONTROLS --->
<script>
$("#CWformAddToCart").validate();
</script>


<!--- / END SELECT SCRIPT --->