<cfsilent>
<!--- 
================================================================
Application Info: Cartweaver© 2002 - 2007, All Rights Reserved.
Developer Info: Application Dynamics Inc.
                1560 NE 10th
                East Wenatchee, WA 98802
Support Info: http://www.cartweaver.com/go/cfhelp
				
Cartweaver Version: 3.0.0  -  Date: 4/21/2007
================================================================
Name: Validate Product Form
Description: Here we validate the data submitted in the product form. 
If the data fits the required parameters we send continue on with 
the transaction. If not we halt the transaction and pass back error 
messages to be displayed by the calling template.
================================================================
--->

<!--- We either updated or added a new product --->

<cfif IsDefined("FORM.Action")>
	<cfif (IsDefined("FORM.Action") and Form.Action EQ "AddProduct") AND FORM.product_MerchantProductID EQ "">
		<cfset request.AddProductError = ListAppend(request.AddProductError,"Product ID is required.")>
	</cfif>
	<cfif FORM.product_Name EQ "">
		<cfset request.AddProductError = ListAppend(request.AddProductError,"Product Name is required.")>
	</cfif>
	<cfif NOT IsNumeric(FORM.product_Sort)>
		<cfset FORM.product_Sort = 0>
	</cfif>
	<cfif FORM.product_ShortDescription EQ "">
		<cfset request.AddProductError = ListAppend(request.AddProductError,"A Short Description is required.")>
	</cfif>
	<cfif FORM.product_Description EQ "">
		<cfset request.AddProductError = ListAppend(request.AddProductError,"A Long Description is required..")>
	</cfif>
</cfif>

<!--- If we're adding a new sku --->
<cfif IsDefined("FORM.AddSKU")>
	<cfif FORM.SKU_MerchSKUID EQ "">
		<cfset request.AddSKUError = ListAppend(request.AddSKUError,"A SKU is required.")>
	</cfif> 
	<cfif NOT IsNumeric(FORM.SKU_Price)>
		<cfset request.AddSKUError = ListAppend(request.AddSKUError,"A valid price is required.")>
	</cfif> 
	<cfif NOT IsNumeric(FORM.SKU_Sort)>
		<cfset FORM.SKU_Sort = 0>
	</cfif>
	<cfif NOT IsNumeric(FORM.SKU_Weight)>
		<cfset FORM.SKU_Weight = 0>
	</cfif>
	<cfif NOT IsNumeric(FORM.SKU_Stock)>
		<cfset FORM.SKU_Stock = 0>
	</cfif>
</cfif>
</cfsilent>