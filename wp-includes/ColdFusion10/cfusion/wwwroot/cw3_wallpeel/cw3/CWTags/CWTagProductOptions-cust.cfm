
<!---
-------------------------------
tbl_prdtoption_rel -- delete

optn_rel_ID
optn_rel_OptionType_ID
optn_rel_Prod_ID

-------------------------------
tbl_list_optiontypes

optiontype_ID
optiontype_Required
optiontype_Name
optiontype_SortOrder
optiontype_FileName
optiontype_Archive

-------------------------------
tbl_skuoptions

option_ID
option_Type_ID
option_Name
option_FileName
option_Archive
-------------------------------
 --->
<cfprocessingdirective suppresswhitespace="yes">
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

	<cfdump var="#rsGetProductOptions#">

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
			<p>
				This product is currently out of stock.
			</p>
		</cfif>
<cfelse>
	<!--- get discount information currently available --->
		<cfset discount = cwGetDiscountObject()>
		<cfset cwGetDiscounts()>

		<cfoutput>#intOptionCount#</cfoutput>


</cfif>
</cfprocessingdirective>