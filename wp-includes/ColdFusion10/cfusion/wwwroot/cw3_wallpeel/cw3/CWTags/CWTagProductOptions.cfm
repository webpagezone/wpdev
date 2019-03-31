<cfprocessingdirective suppresswhitespace="yes">
<!---
================================================================
Application Info: Cartweaver© 2002 - 2007, All Rights Reserved.
Developer Info: Application Dynamics Inc.
                1560 NE 10th
                East Wenatchee, WA 98802
Support Info: http://www.cartweaver.com/go/cfhelp

Cartweaver Version: 3.0.13  -  Date: 7/25/2008
================================================================
Name: CWTagProductOptions
Description:
	Use the CWTagProductOptions custom tag to add cross tab tables
	or list menus for individual product options. If DetailsDisplay
	is set to "Tables", a crosstab table is displayed with
	every possible combination of options, making it easy for a
	customer to find what they're looking for. If 2 or more options are
	available, and you've set the Advanced Display option, then
	the list menus will be dependent on one other, making
	sure the user can't select an invalid combination. If you are
	using the "Simple" Display, then the list menus will not be
	dependent on each other, and all checking will be handled once
	the page is submitted. If there	is only one option, then just
	the prices are displayed.

	The custom tag takes 2 arguments.
	product_id: The product ID to display.
		product_id = "#request.Product_ID#"
	fielderror: Any errors passed from the calling page.
		fielderror = "#FieldError#"

	<cfmodule
		template="CWTags/CWTagProductOptions.cfm"
		product_id = "#request.Product_ID#"
		fielderror = "#FieldError#"
	>

================================================================
--->
<cfif Not IsDefined("cwAltRows") OR Not IsCustomFunction(cwAltRows)>
	<cfinclude template="CWIncFunctions.cfm" />
</cfif>
<cfif Not IsDefined("cwGetDiscountObject") OR Not IsCustomFunction(cwGetDiscountObject)>
	<cfinclude template="CWIncDiscountFunctions.cfm">
</cfif>
<cfparam name="fielderror" default="">
<cfparam name="NumOptions" default="0">
<cfparam name="TaxRate" default="" />
<cfquery name="rsGetProductOptions" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
SELECT DISTINCT tbl_prdtoption_rel.optn_rel_OptionType_ID
FROM tbl_products
INNER JOIN tbl_prdtoption_rel
ON tbl_products.product_ID = tbl_prdtoption_rel.optn_rel_Prod_ID
WHERE tbl_prdtoption_rel.optn_rel_Prod_ID = #attributes.Product_ID#
AND tbl_products.product_Archive = 0
</cfquery>
<cfset intOptionCount = rsGetProductOptions.recordcount>

<!--- Determine if we're going to use advanced display --->
<cfif rsGetProductOptions.recordcount EQ 0>
	<cfquery name="rsCWGetSKUs" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
	SELECT tbl_skus.SKU_ID, tbl_skus.SKU_MerchSKUID, tbl_skus.SKU_Price, tbl_skus.SKU_ProductID
	FROM tbl_skus WHERE tbl_skus.SKU_ProductID = <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.Product_ID#" />
	<cfif application.AllowBackOrders EQ 0>
		AND tbl_skus.SKU_Stock > 0
	</cfif>
	 AND SKU_ShowWeb = 1 ORDER BY SKU_Sort
	 </cfquery>
	<cfif rsCWGetSKUs.RecordCount NEQ 0>
		Qty:
		<input name="qty" type="text" value="1" size="2">
		<input name="skuid" type="hidden" value="<cfoutput>#rsCWGetSKUs.SKU_ID#</cfoutput>">
		<br />
		<cfelse>
		<p>This product is currently out of stock.</p>
	</cfif>

<cfelse>
	<!--- get discount information currently available --->
	<cfset discount = cwGetDiscountObject()>
	<cfset cwGetDiscounts()>
	<cfswitch expression="#Application.DetailsDisplay#">
		<cfcase value="Advanced">
			<cfsilent>
				<cfquery name="rsOptionList" datasource="#request.dsn#" username="#request.dsnusername#" password="#request.dsnpassword#">
				SELECT tbl_skus.SKU_ID, tbl_skus.SKU_Price, tbl_skuoptions.option_ID, tbl_skus.SKU_MerchSKUID, tbl_list_optiontypes.optiontype_Name,
				tbl_skuoptions.option_Name
				FROM tbl_list_optiontypes
				INNER JOIN (tbl_skuoptions
				INNER JOIN (tbl_skus
				INNER JOIN tbl_skuoption_rel
				ON tbl_skus.SKU_ID = tbl_skuoption_rel.optn_rel_SKU_ID)
				ON tbl_skuoptions.option_ID = tbl_skuoption_rel.optn_rel_Option_ID)
				ON tbl_list_optiontypes.optiontype_ID = tbl_skuoptions.option_Type_ID
				WHERE tbl_skus.SKU_ProductID = <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.Product_ID#" />
				<cfif application.AllowBackOrders EQ 0>
				AND tbl_skus.SKU_Stock > 0
				</cfif>
				ORDER BY tbl_skus.SKU_Sort, tbl_skus.SKU_MerchSKUID, tbl_list_optiontypes.optiontype_Name, tbl_skuoptions.option_Sort, tbl_skuoptions.option_Name;
				</cfquery>

				<cfquery name="rsSelectBuild" datasource="#request.dsn#" username="#request.dsnusername#" password="#request.dsnpassword#">
				SELECT tbl_skuoptions.option_ID, tbl_list_optiontypes.optiontype_Name, tbl_skuoptions.option_Sort, tbl_skuoptions.option_Name
				FROM tbl_skus
				INNER JOIN ((tbl_list_optiontypes
				INNER JOIN tbl_skuoptions
				ON tbl_list_optiontypes.optiontype_ID = tbl_skuoptions.option_Type_ID)
				INNER JOIN tbl_skuoption_rel
				ON tbl_skuoptions.option_ID = tbl_skuoption_rel.optn_rel_Option_ID)
				ON tbl_skus.SKU_ID = tbl_skuoption_rel.optn_rel_SKU_ID
				WHERE tbl_skus.SKU_ProductID = <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.Product_ID#" />
				<cfif application.AllowBackOrders EQ 0>
					AND tbl_skus.SKU_Stock > 0
				</cfif>
				GROUP BY tbl_skus.SKU_ProductID, tbl_skuoptions.option_ID, tbl_list_optiontypes.optiontype_Name,
				tbl_skuoptions.option_Sort, tbl_skuoptions.option_Name
				ORDER BY tbl_list_optiontypes.optiontype_Name, tbl_skuoptions.option_Sort, tbl_skuoptions.option_Name
				</cfquery>

				<cfif attributes.FieldError NEQ "">
					<cfset intQuantity = FORM.qty>
				<cfelse>
					<cfset intQuantity = 1>
				</cfif>

				<cfset arCounter = 0 />
			</cfsilent>
	<cfsavecontent variable="productOptionsJS">
	<script language="JavaScript" src="cw3/assets/scripts/dropdowns.js" type="text/javascript"></script>
	<script type="text/javascript">
	//<![CDATA[
	var arOptions = new Array();
	<cfoutput query="rsOptionList" group="SKU_ID">
		<cfsilent>
			<cfset listOptionIDs = "" />
			<cfset listOptionNames = "" />
			<cfoutput>
				<cfset listOptionIDs = ListAppend(listOptionIDs, option_ID) />
				<cfset listOptionNames = ListAppend(listOptionNames, '"#JSStringFormat(option_Name)#"') />
			</cfoutput>
			<cfset listOptionIDs = ListQualify(listOptionIDs, """") />
		</cfsilent>
	arOptions[#arCounter#] = new Array();
	<!--- set up price display, including discount info for sku --->
	<cfset currentPrice = SKU_Price>
	<cfif ListLen(session.availableDiscounts) GT 0>
		<cfset discount = cwGetDiscountProduct(Attributes.Product_ID)>
	</cfif>
	<cfset request.showDiscount = false>
	<cfif cwGetNewPrice(discount, currentPrice) NEQ currentPrice>
		<cfset request.showDiscount = true>
	</cfif>
	<cfset displayPrice = #LSCurrencyFormat(SKU_Price)#>
	<cfif IsStruct(Attributes.TaxRate) AND Attributes.TaxRate.CalcTax NEQ 0>
		<cfset displayPrice = "#displayPrice# (#LSCurrencyFormat(decimalRound(SKU_Price*Attributes.TaxRate.CalcTax))# including #Attributes.TaxRate.DisplayTax#% tax)">
	</cfif>
	<cfif request.showDiscount>
		<cfset displayPrice = cwDisplayOldPrice(displayPrice, discount.discountid)>
		<cfset displayPrice = Replace(displayPrice, "</", "<' + '/", "all")>
		<cfif IsStruct(Attributes.TaxRate) AND Attributes.TaxRate.CalcTax NEQ 0>
			<cfset displayPrice =  "#displayPrice# #LSCurrencyFormat(cwGetNewPrice(discount,currentPrice))# (#LSCurrencyFormat(cwGetNewPrice(discount,decimalRound(SKU_Price*Attributes.TaxRate.CalcTax)))# including #Attributes.TaxRate.DisplayTax#% tax)">
		<cfelse>
			<cfset displayPrice = "#displayPrice# #LSCurrencyFormat(cwGetNewPrice(discount,currentPrice))#">
		</cfif>
	</cfif>
	<!--- end of price setup --->
	arOptions[#arCounter#]["price"] = '#displayPrice#';
	arOptions[#arCounter#]["optionIDs"] = new Array(#listOptionIDs#);
	arOptions[#arCounter#]["optionNames"] = new Array(#listOptionNames#);
				<cfset arCounter = arCounter + 1 />
		</cfoutput>// ]]>
	</script>
	</cfsavecontent>
	<cfhtmlhead text="#productOptionsJS#">
				<table>
				<cfset i = 0 />
				<cfoutput query="rsSelectBuild" group="optiontype_Name">
					<tr>
						<td>#optiontype_Name#: </td>
						<td><select name="sel" id="sel#i#" onchange="cwSetDependentList(this, #i#);">
							<option value="0">Choose #optiontype_Name#...</option>
							<cfoutput><option value="#option_id#">#option_Name#</option></cfoutput>
						</select></td>
					</tr>
					<cfset i = i + 1 />
				</cfoutput>
					<tr>
						<td>Qty: </td>
						<td><input name="qty" type="text" value="<cfoutput>#intQuantity#</cfoutput>" size="2"></td>
					</tr>
				</table>
		</cfcase>

		<cfcase value="Tables">
			<cfsilent>
				<!--- Get all of the product information for building our options lists. --->
				<cfquery name="rsCFTable" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
				SELECT
					tbl_list_optiontypes.optiontype_Name,
					tbl_skus.SKU_ID, tbl_skus.SKU_MerchSKUID,
					tbl_skus.SKU_Price,
					tbl_skuoptions.option_Name,
					tbl_skuoptions.option_Sort,
					tbl_skus.SKU_Stock,
					tbl_skuoptions.option_ID
				FROM tbl_skus INNER JOIN ((tbl_list_optiontypes
					INNER JOIN tbl_skuoptions ON tbl_list_optiontypes.optiontype_ID = tbl_skuoptions.option_Type_ID)
					INNER JOIN tbl_skuoption_rel ON tbl_skuoptions.option_ID = tbl_skuoption_rel.optn_rel_Option_ID) ON tbl_skus.SKU_ID = tbl_skuoption_rel.optn_rel_SKU_ID
				WHERE
					tbl_skus.SKU_ProductID = <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.Product_ID#" />
					AND tbl_skus.SKU_ShowWeb = 1
					<cfif application.AllowBackOrders EQ 0>
						AND tbl_skus.SKU_Stock > 0
					</cfif>
				ORDER BY tbl_skus.SKU_Sort, tbl_skus.SKU_MerchSKUID, tbl_skuoptions.option_Sort
				</cfquery>
				<!--- Get all of the distinct options for the product --->
				<cfquery dbtype="query" name="rsAllOptions">
				SELECT DISTINCT optiontype_Name FROM rsCFTable
				</cfquery>
				<!--- Break our options up into arrays for crosstabbing later --->
				<cfif rsAllOptions.RecordCount GT 0>
					<cfset OptionNames = ValueList(rsAllOptions.optiontype_Name)>
					<cfset OptionHeaders = ListToArray(OptionNames)>
					<cfset NumOptions = ArrayLen(OptionHeaders)>
					<cfset OptionArray = ArrayNew(1)>
				</cfif>
				<cfset productCounter = 0 />

			</cfsilent>

			<table class="tabularData">
				 <caption>
				 Product Prices
				</caption>
				 <tr>
					<th>SKU</th>
					<!--- Output the headers for each column --->
					<cfloop index="i" from="1" to="#NumOptions#">
						 <th><cfoutput>#OptionHeaders[i]#</cfoutput></th>
					 </cfloop>
					<th>Price</th>
					<cfif IsArray(Attributes.TaxRate) AND Attributes.TaxRate[1] NEQ 0>
						<th>Inc. <cfoutput>#Attributes.TaxRate[1]#</cfoutput>% tax</th>
					</cfif>
					<th>Qty.</th>
				</tr>
				 <!--- Output all of the SKUs --->
				 <cfoutput query="rsCFTable" group="SKU_MerchSKUID">
					<cfset productCounter = productCounter + 1 />
					<tr class="#IIF(CurrentRow MOD 2, DE('altRowEven'), DE('altRowOdd'))#">
						 <th>#SKU_MerchSKUID#</th>
						 <!--- Set all options to "None" --->
						 <cfset temp = ArraySet(OptionArray, 1, NumOptions, "None")>
						 <cfoutput>
							<!--- Find the current option in the OptionNames list --->
							<cfset i = ListFind(OptionNames, rsCFTable.optiontype_Name)>
							<!--- Set the array to the option name --->
							<cfset temp = ArraySet(OptionArray, i, i, rsCFTable.option_Name)>
						</cfoutput>
						 <!--- Output each option for this sku --->
						 <cfloop index="j" from="1" to="#NumOptions#">
							<td>#OptionArray[j]#</td>
						</cfloop>
						<!--- set up price display, including discount info for sku --->
	<cfset currentPrice = SKU_Price>
	<cfif ListLen(session.availableDiscounts) GT 0>
		<cfset discount = cwGetDiscountProduct(Attributes.Product_ID)>
	</cfif>
	<cfset request.showDiscount = false>
	<cfif cwGetNewPrice(discount, currentPrice) NEQ currentPrice>
		<cfset request.showDiscount = true>
	</cfif>
	<cfset displayPrice = #LSCurrencyFormat(SKU_Price)#>
	<cfif IsStruct(Attributes.TaxRate) AND Attributes.TaxRate.CalcTax NEQ 0>
		<cfset displayPrice = "#displayPrice# (#LSCurrencyFormat(decimalRound(SKU_Price*Attributes.TaxRate.CalcTax))# including #Attributes.TaxRate.DisplayTax#% tax)">
	</cfif>
	<cfif request.showDiscount>
		<cfset displayPrice = cwDisplayOldPrice(displayPrice, discount.discountid)>
		<cfif IsStruct(Attributes.TaxRate) AND Attributes.TaxRate.CalcTax NEQ 0>
			<cfset displayPrice =  "#displayPrice# #LSCurrencyFormat(cwGetNewPrice(discount,currentPrice))# (#LSCurrencyFormat(cwGetNewPrice(discount,decimalRound(SKU_Price*Attributes.TaxRate.CalcTax)))# including #Attributes.TaxRate.DisplayTax#% tax)">
		<cfelse>
			<cfset displayPrice = "#displayPrice# #LSCurrencyFormat(cwGetNewPrice(discount,currentPrice))#">
		</cfif>
	</cfif>
                        <td>#displayPrice#</td>
						 <cfif IsArray(Attributes.TaxRate) AND Attributes.TaxRate[1] NEQ 0>
						 	<td>#LSCurrencyFormat(decimalRound(SKU_Price*Attributes.TaxRate[2]))#</td>
						 </cfif>
						 <td align="center"><input name="qty#productCounter#" type="text" value="0" size="2">
							<input name="skuID#productCounter#" type="hidden" value="#rsCFTable.SKU_ID#"> </td>
					 </tr>
				</cfoutput>
			 </table>
			 <input type="hidden" name="addSkus" value="<cfoutput>#productCounter#</cfoutput>" />
		</cfcase>
		<cfcase value="Simple">
			<cfif attributes.FieldError NEQ "">
				<cfset intQuantity = FORM.qty>
			<cfelse>
				<cfset intQuantity = 1>
			</cfif>
			<cfquery name="rsSelectBuild" datasource="#request.dsn#" username="#request.dsnusername#" password="#request.dsnpassword#">
				SELECT
				tbl_skuoptions.option_ID,
				tbl_skuoptions.option_FileName,
				tbl_skuoptions.option_Hex,
				tbl_list_optiontypes.optiontype_ID,
				tbl_list_optiontypes.optiontype_Name,
				tbl_skuoptions.option_Sort,
				tbl_skuoptions.option_Name
				FROM tbl_skus
				INNER JOIN ((tbl_list_optiontypes
				INNER JOIN tbl_skuoptions
				ON tbl_list_optiontypes.optiontype_ID = tbl_skuoptions.option_Type_ID)
				INNER JOIN tbl_skuoption_rel
				ON tbl_skuoptions.option_ID = tbl_skuoption_rel.optn_rel_Option_ID)
				ON tbl_skus.SKU_ID = tbl_skuoption_rel.optn_rel_SKU_ID
				WHERE tbl_skus.SKU_ProductID = <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.Product_ID#" />
				<cfif application.AllowBackOrders EQ 0>
					AND tbl_skus.SKU_Stock > 0
				</cfif>
				GROUP BY tbl_skus.SKU_ProductID, tbl_skuoptions.option_ID, tbl_list_optiontypes.optiontype_Name,
				tbl_skuoptions.option_Sort, tbl_skuoptions.option_Name
				ORDER BY tbl_list_optiontypes.optiontype_Name, tbl_skuoptions.option_Sort, tbl_skuoptions.option_Name
				</cfquery>

				<cfdump var="#rsSelectBuild#">
			<table>
			<cfset i = 0 />
			<cfoutput query="rsSelectBuild" group="optiontype_Name">
				<tr>
					<td>#optiontype_Name#: </td>
					<td>
						<cfif rsSelectBuild.optiontype_ID EQ 5>
							<select name="sel" id="sel#i#">
							<option value="0">Choose #optiontype_Name#...</option>
							<cfoutput><option value="#option_id#" style="background:#option_Hex#">#option_Name#</option></cfoutput>
							</select>

						<cfelse>
							<select name="sel" id="sel#i#">
							<option value="0">Choose #optiontype_Name#...</option>
							<cfoutput><option value="#option_id#">#option_Name#</option></cfoutput>
							</select>

						</cfif>

					</td>
				</tr>
				<cfset i = i + 1 />
			</cfoutput>
				<tr>
					<td>Qty: </td>
					<td><input name="qty" type="text" value="<cfoutput>#intQuantity#</cfoutput>" size="2"></td>
				</tr>
			</table>
		</cfcase>
	</cfswitch>
</cfif>
</cfprocessingdirective>