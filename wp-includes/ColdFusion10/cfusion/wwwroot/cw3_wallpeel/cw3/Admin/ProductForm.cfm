<cfsilent>
<!--- 
================================================================
Application Info: Cartweaver© 2002 - 2007, All Rights Reserved.
Developer Info: Application Dynamics Inc.
                1560 NE 10th
                East Wenatchee, WA 98802
Support Info: http://www.cartweaver.com/go/cfhelp
				
Cartweaver Version: 3.0.13  -  Date: 7/25/2008
================================================================
Name: ProductForm.cfm
Description: Displays details and administers SKUs for the selected product.
================================================================
--->
<!--- Set location for highlighting in Nav Menu --->
<cfset strSelectNav = "Products">
<cfparam name="url.nextpage" default="1">
<cfparam name="form.nextpage" default="#url.nextpage#">
<cflock timeout="8" throwontimeout="no" type="exclusive" scope="application">
  <cfset variables.DisplayUpSell = application.showupsell>
</cflock>

<!--- ===== ARCHIVE PRODUCT ===== --->
<!--- [ START ] Archive Product --->

<cfif IsDefined("url.ArchiveProduct")>
	<cfquery name="archiveProduct" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
	 UPDATE tbl_products
		SET product_Archive = '1'
		WHERE product_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.product_ID#" />
	</cfquery>
	<cflocation url="ProductArchive.cfm" addtoken="no">
</cfif>

<!--- ===[ START ]====  Product Action  ========================= --->
<!---  
  Include contains all the action queries for Adding, Updating, 
  and Deleteing Product and SKU records
--->
<cfparam name="request.AddProductError" default=""> 
<cfparam name="request.AddSKUError" default=""> 
<cfmodule template="CWTagValidateProduct.cfm">
<cfif request.AddProductError EQ "" AND request.AddSKUError EQ "">
	<cfinclude template="CWTagProductAction.cfm">
</cfif>
<!--- ===[ END ]=====  Product Action  ========================== --->
<!--- Set Product_ID paramiters --->
<cfparam name="URL.product_ID" default="0">

<!--- Set default params for the entire page --->
<cfparam name="SKUList" default="0">
<cfparam name="HasOrders" default="0">
<cfparam name="ProductHasOrders" default="0">
<cfparam name="DisabledText" default="">
<cfparam name="FormFocus" default="'productform','product_Name'">

<cfif URL.product_id EQ 0>
	<cfset FormFocus = "'productform','product_MerchantProductID'">
	<cfelseif IsDefined("URL.ADDSKU")>
	<cfset FormFocus = "'addSKU','SKU_MerchSKUID'">
</cfif>


<!--- Get Product Data --->
<cfquery name="rsGetProduct" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
SELECT * FROM tbl_products WHERE product_ID = #URL.product_ID#
</cfquery>
<!--- All Available Options --->
<cfquery name="rsAllAvailOptions" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
SELECT tbl_list_optiontypes.optiontype_ID, tbl_list_optiontypes.optiontype_Name, tbl_skuoptions.option_Name, tbl_skuoptions.option_Sort, tbl_skuoptions.option_ID FROM tbl_list_optiontypes INNER JOIN tbl_skuoptions ON tbl_list_optiontypes.optiontype_ID = tbl_skuoptions.option_Type_ID WHERE tbl_list_optiontypes.optiontype_Archive = 0 AND tbl_skuoptions.option_Archive = 0 ORDER BY tbl_list_optiontypes.optiontype_Name, tbl_skuoptions.option_ID
</cfquery>
<!--- Get Distinct Product Options --->
<cfquery name="rsProductOptions" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
SELECT DISTINCT optiontype_ID, optiontype_Name FROM tbl_list_optiontypes WHERE optiontype_Archive<>1 ORDER BY optiontype_Name
</cfquery>
<!--- Get Selected Product Options --->
<cfquery name="rsRelProductOptions" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
SELECT DISTINCT 
	tbl_list_optiontypes.optiontype_ID, 
	tbl_list_optiontypes.optiontype_Name, 
	tbl_skuoptions.option_ID, 
	tbl_skuoptions.option_Name, 
	tbl_skuoptions.option_Sort
FROM tbl_products 
	INNER JOIN (( tbl_list_optiontypes 
	INNER JOIN tbl_skuoptions ON tbl_list_optiontypes.optiontype_ID = tbl_skuoptions.option_Type_ID) 
	INNER JOIN tbl_prdtoption_rel ON tbl_list_optiontypes.optiontype_ID = tbl_prdtoption_rel.optn_rel_OptionType_ID) ON tbl_products.product_ID = tbl_prdtoption_rel.optn_rel_Prod_ID 
WHERE tbl_products.product_ID= #URL.product_ID# AND tbl_skuoptions.option_Archive = 0
ORDER BY 
	tbl_list_optiontypes.optiontype_Name, 
	tbl_skuoptions.option_Sort
</cfquery>
<!--- Get SKU Data --->
<cfquery name="rsGetSKUs" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
SELECT * FROM tbl_skus WHERE SKU_ProductID = #URL.product_ID# ORDER BY SKU_Sort
</cfquery>
<!--- Get Categories --->
<cfquery name="rsCategories" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
SELECT *
FROM tbl_prdtcategories
ORDER BY category_sortorder, category_Name 
</cfquery>
<!--- Get Secondary Categories --->
<cfquery name="rsScndCategories" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
SELECT * FROM tbl_prdtscndcats
ORDER BY scndctgry_Sort, scndctgry_Name
</cfquery>
<!--- Get Related Categories --->
<cfquery name="rsRelCategories" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
SELECT prdt_cat_rel_Cat_ID FROM tbl_prdtcat_rel WHERE prdt_cat_rel_Product_ID = #URL.product_ID#
</cfquery>
<!--- Get Related Secondary Categories --->
<cfquery name="rsRelScndCategories" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
SELECT prdt_scnd_rel_ScndCat_ID FROM tbl_prdtscndcat_rel WHERE prdt_scnd_rel_Product_ID = #URL.product_ID#
</cfquery>

<!--- Get Product Images --->
<cfquery name="rsGetImages" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
SELECT *
FROM tbl_prdtimages
WHERE prdctImage_ProductID = <cfqueryparam cfsqltype="cf_sql_integer" value="#URL.product_ID#" />
</cfquery> 

<!--- Get Image Types --->
<cfquery name="rsGetImageTypes" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
SELECT * FROM tbl_list_imagetypes
ORDER BY imgType_SortOrder, imgType_Name
</cfquery>

<!--- Variable for checking if a sku or product has previous orders --->
<cfif rsGetSKUs.recordcount NEQ 0>
	<cfset SKUList = ValueList(rsGetSKUs.SKU_ID)>
</cfif>

<!--- Are there any orders? --->
<cfquery name="rsCheckForOrders" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
SELECT Count(ordersku_id) as AreThereSkus 
FROM tbl_orderskus 
WHERE orderSKU_SKU IN(#SKUList#)
</cfquery>

<cfif rsCheckForOrders.AreThereSkus NEQ 0>
	<cfset ProductHasOrders = 1>
	<cfset DisabledText = " disabled=""disabled""">
</cfif>

<!--- Get Cross Sell List --->
<cfquery name="rsGetUpsell" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
SELECT p.product_ID, 
p.product_MerchantProductID, 
p.product_Name, 
u.upsell_ID
FROM tbl_products p
INNER JOIN tbl_prdtupsell u
ON p.product_ID = u.upsell_RelProdID
WHERE u.upsell_ProdID = #URL.product_ID#
ORDER BY p.product_Name, p.product_MerchantProductID
</cfquery>

<!--- Get Tax Groups --->
<cfquery name="rsTaxgroups" datasource="#request.dsn#" username="#request.dsnusername#" password="#request.dsnpassword#">
SELECT *
FROM tbl_taxgroups
ORDER BY taxgroup_name ASC
</cfquery>

<!--- Set default form values --->
<cfparam name="FORM.product_MerchantProductID" default="">
<cfparam name="FORM.product_Name" default="#rsGetProduct.product_Name#">
<cfparam name="FORM.product_Sort" default="#rsGetProduct.product_Sort#">
<cfparam name="FORM.product_OnWeb" default="#rsGetProduct.product_OnWeb#">
<cfparam name="FORM.product_shipchrg" default="#rsGetProduct.product_shipchrg#">
<cfset lstProductOptions = ""> 
<cfif IsDefined("FORM.product_options")> 
	<cfset lstProductOptions = FORM.product_options> 
	<cfelse> 
	<cfset lstProductOptions = ValueList(rsRelProductOptions.optiontype_ID)> 
</cfif>
<!--- Create a list of assigned categories for the select menus --->
<cfset lstRelCats = "">
<cfif IsDefined("FORM.product_Category_ID")>
	<cfset lstRelCats = FORM.product_Category_ID>
	<cfelse>
	<cfset lstRelCats = ValueList(rsRelCategories.prdt_cat_rel_Cat_ID)>
</cfif>
<!--- Create a list of assigned secondary categories for the select menus --->
<cfset lstRelScndCats = "">
<cfif IsDefined("FORM.scndctgry_ID")>
	<cfset lstRelScndCats = FORM.scndctgry_ID>
	<cfelse>
	<cfset lstRelScndCats = ValueList(rsRelScndCategories.prdt_scnd_rel_ScndCat_ID)>
</cfif>
<cfparam name="FORM.product_ShortDescription" default="#rsGetProduct.product_ShortDescription#">
<cfparam name="FORM.product_Description" default="#rsGetProduct.product_Description#">


</cfsilent>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>CW Admin: Product Data</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="assets/admin.css" rel="stylesheet" type="text/css">
<link href="assets/tabs.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
function setfocus(myForm,myField)
{
	eval("document."+myForm+"."+myField+".focus()");
}
function showUpload(obj) {
	window.open(obj.href, "imageUploadWindow", "width=700,height=500,scrollbars=yes,resizable=yes");
}
function updateImagePreview(imgType,imageSRC) {
	var obj = eval("document.productform.image"+imgType);
	obj.src = imageSRC;
	obj.alt = 'Image path: '+imageSRC;
	obj.style.display = 'inline';
}

function doFormAction() {
	if(currentPage == 3) {
		document.getElementById('productform').submit();
	}else{
		var links = document.getElementById('divTabs').getElementsByTagName('a');
		document.getElementById('nextpage').value = (currentPage == links.length) ? 1 : currentPage + 1;
		tab(currentPage + 1);
		setSubmit("AddProduct");
	}
}

</script>
<script type="text/javascript" src="assets/tabs.js"></script>
<!--- Set proper tab on error --->
<cfif request.AddProductError NEQ "">
	<cfset form.nextpage = 1>
	<cfif FindNoCase("Description is required", ListFirst(request.AddProductError))>
		<cfset form.nextpage = 2>
	</cfif>
<cfelse>
	<cfif request.AddSKUError NEQ "">
		<cfset form.nextpage = 4>
	</cfif>
</cfif>
<cfif isDefined("rsGetNewProdID.RecordCount") AND rsGetNewProdID.RecordCount GT 0>
	<cfset form.nextpage = 4>
</cfif>
</head>
<body onLoad="showTabs();
<cfif val(url.product_ID) EQ 0>setSubmit('AddProduct');</cfif>
tab(<cfoutput>#form.nextpage#</cfoutput>);<!---setfocus(<cfoutput>#FormFocus#</cfoutput>)--->"> 
<cfprocessingdirective suppresswhitespace="yes"> 

<!--- Include Admin Navigation Menu--->
<cfinclude template="CWIncNav.cfm"> 
<div id="divMainContent"> 
	<h1>Product Data<cfif rsGetProduct.RecordCount NEQ 0>: <cfoutput>#FORM.product_Name#</cfoutput></cfif></h1>
	<!--- Place our product search form with this include tag --->
	<cfinclude template="CWIncProductSearch.cfm">
	<div id="divTabs" class="noJS">	
	<a href="javascript:;" onclick="tab(1); <cfif val(url.product_ID) EQ 0>setSubmit('AddProduct'); </cfif>document.getElementById('submitProduct').style.display='block';" class="current" id="tab1" title="Click here to view the General information">General Info</a>
	<a href="javascript:;" onclick="tab(2); <cfif val(url.product_ID) EQ 0>setSubmit('AddProduct'); </cfif>document.getElementById('submitProduct').style.display='block';" id="tab2" title="Click here to view the Descriptions">Descriptions</a>
	<a href="javascript:;" onclick="tab(3); <cfif val(url.product_ID) EQ 0>setSubmit('AddProduct'); </cfif>document.getElementById('submitProduct').style.display='block';" id="tab3" title="Click here to view the Product info">Photos</a>
	<cfif rsGetProduct.RecordCount NEQ 0><!--- show upsell and skus after product exists --->
	<a href="javascript:;" onclick="tab(4); document.getElementById('submitProduct').style.display='none';" id="tab4" title="Click here to view the Product SKU info">SKUs</a>
	<a href="javascript:;" onclick="tab(5); document.getElementById('submitProduct').style.display='none';" id="tab5" title="Click here to view the upsell info">Up-sell</a>
	</cfif>
	</div>
	<div id="divWrapper">
		<div id="divPages">
			<!--- display errors --->
			<cfif request.AddProductError NEQ ""> 
				<p><strong>There were errors adding/updating this product.</strong></p>
				<ul><cfloop list="#request.AddProductError#" index="error">
					<li><cfoutput>#error#</cfoutput></li></cfloop>
				</ul>
			</cfif> 
			<cfif request.AddSKUError NEQ ""> 
				<p><strong>There was an error adding the new sku</strong></p> 
				<ul>
				<cfloop list="#request.AddSKUError#" index="error">
				<li><cfoutput>#error#</cfoutput></li>
				</cfloop>
				</ul>
			</cfif> 
			<form method="post" id="productform" name="productform" action="<cfoutput>#request.ThisPageQS#</cfoutput>" onsubmit="document.getElementById('nextpage').value = currentPage"> 
				<div id="page1">					
					<!--- Product General Info table --->
					<table> 
						<tr> 
							<th align="right">ID:</th> 
							<td><cfif rsGetProduct.RecordCount IS 0>
									<input name="product_MerchantProductID" type="text" id="product_MerchantProductID" tabindex="1" value="<cfoutput>#FORM.product_MerchantProductID#</cfoutput>" size="25">
									<cfelse> 
									<cfoutput>#rsGetProduct.product_MerchantProductID#</cfoutput> 
									<input name="product_ID" type="hidden" value="<cfoutput>#rsGetProduct.product_ID#</cfoutput>"> 
								</cfif></td> 
						</tr>
						<tr> 
							<th align="right">Name:</th> 
							<td>
							<input name="product_Name" type="text" value="<cfoutput>#HTMLEditFormat(FORM.product_Name)#</cfoutput>" size="30" tabindex="2"> </td> 
						</tr> 
						<tr> 
							<th align="right">Sort:</th> 
							<td>
							<input name="product_Sort" type="text" value="<cfoutput>#FORM.product_Sort#</cfoutput>" size="5" tabindex="3"></td> 
						</tr> 
						<tr> 
							<th align="right">OnWeb:</th> 
							<td>
							<select name="product_OnWeb" tabindex="4"> 
									<cfif FORM.product_OnWeb EQ "1" OR FORM.product_OnWeb EQ ""> 
										<option value="1" selected="selected">Yes
										<option value="0">No
										<cfelse> 
										<option value="1" >Yes
										<option value="0" selected="selected">No
									</cfif> 
								</select></td> 
						</tr> 
						<tr> 
							<th align="right">Charge Shipping: </th> 
							<td><select name="product_shipchrg" tabindex="5"> 
									<cfif FORM.product_shipchrg EQ "1"> 
										<option value="1" selected >Yes
										<option value="0">No
										<cfelse> 
										<option value="1">Yes
										<option value="0" selected >No
									</cfif> 
								</select></td> 
						</tr> 
						<cfif IsDefined("Application.TaxSystem") AND Application.TaxSystem EQ "Groups">
						<tr>
							<th align="right">Tax Group: </th>
							<td><select name="product_taxgroupid" tabindex="6">
								<option value="0">Non-taxable</option>
								<cfoutput query="rsTaxGroups"><option value="#rsTaxgroups.taxgroup_id#" <cfif rsGetProduct.product_taxgroupid EQ rsTaxgroups.taxgroup_id> selected="selected"</cfif>>#rsTaxgroups.taxgroup_name#</option></cfoutput>
							</select></td>
						</tr>
						<cfelse><input type="hidden" name="product_taxgroupid" value="0" />
						</cfif>
						<tr>
							<th align="right">Categories:</th>
							<td><select name="product_Category_ID" tabindex="7" size="7" multiple="multiple">
									<cfoutput query="rsCategories">
										<option <cfif rsCategories.category_archive EQ 1>style="color:##999;" </cfif>value="#rsCategories.category_ID#"<cfif ListFind(lstRelCats,rsCategories.category_ID,",") NEQ 0> selected="selected"</cfif>>#rsCategories.category_Name#</option>
									</cfoutput>
								</select>
								<br />
								<span class="smallprint">Archived categories are displayed in <span style="color: #999;">gray</span>.</span></td>
						</tr>
						<tr>
							<th align="right">Secondary<br />
								Categories:</th>
							<td><select name="scndctgry_ID" size="7" multiple="multiple" tabindex="8">
									<cfoutput query="rsScndCategories">
										<option <cfif rsScndCategories.scndctgry_Archive EQ 1>style="color:##999;" </cfif>value="#rsScndCategories.scndctgry_ID#"<cfif ListFind(lstRelScndCats,rsScndCategories.scndctgry_ID,",") NEQ 0> selected="selected"</cfif>>#rsScndCategories.scndctgry_Name#</option>
									</cfoutput>
								</select>
								<br />
								<span class="smallprint">Archived secondary categories are displayed in <span style="color: #999;">gray</span>.</span></td>
						</tr>
						<tr> 
							<th align="right">Product Options: </th> 
							<td>
								<select name="product_options" size="5" tabindex="9" multiple<cfoutput>#DisabledText#</cfoutput>> 
									<cfoutput query="rsProductOptions"> 
										<option value="#rsProductOptions.optiontype_ID#"<cfif ListFind(lstProductOptions,rsProductOptions.optiontype_ID,",") NEQ 0> selected="selected"</cfif>>#rsProductOptions.optiontype_Name#</option> 
									</cfoutput> 
								</select> 
								<cfif ProductHasOrders EQ 1> 
									<span class="smallprint"><br /> 
									Orders placed, no changes allowed </span> 
								</cfif></td> 
						</tr> 
					</table>
				</div>
				<div id="page2">
					<table> 
						<caption>
						Descriptions
						</caption> 
						<tr> 
							<th align="right">Short:</th> 
							<td> <textarea name="product_ShortDescription" cols="60" rows="5" tabindex="9"><cfoutput>#FORM.product_ShortDescription#</cfoutput></textarea> </td> 
						</tr> 
						<tr> 
							<th align="right">Long: </th> 
							<td> <textarea name="product_Description" cols="60" rows="10" tabindex="10"><cfoutput>#FORM.product_Description#</cfoutput></textarea> </td> 
						</tr> 
					</table>
				</div>
				<div id="page3">
					<!--- Product images --->
					<table>
						<caption>
						Photo Management:
						</caption>
						<cfoutput query="rsGetImageTypes">
						<cfsilent>
							<cfquery name="rsCurrentImage" dbtype="query">
							SELECT * FROM rsGetImages
							WHERE prdctImage_imgTypeID =
							<cfqueryparam cfsqltype="cf_sql_integer" value="#rsGetImageTypes.imgType_ID#" />
							</cfquery>
							<cfset ImageFieldName = "Image" & rsGetImageTypes.imgType_ID />
							<cfset ImageFolder = Application.SiteRoot & rsGetImageTypes.imgType_Folder />
						</cfsilent>
						<tr>
							<cfparam name="FORM.#ImageFieldName#" default="#rsCurrentImage.prdctImage_FileName#">
							<cfset ImageSRC = ImageFolder & FORM[ImageFieldName]>
							<th align="right">#rsGetImageTypes.imgType_Name#:</th>
							<td><input name="#ImageFieldName#" id="#ImageFieldName#" type="text" tabindex="11" value="#FORM[ImageFieldName]#" size="25" onblur="updateImagePreview('#rsGetImageTypes.imgType_ID#','#ImageFolder#'+this.value);">
								<a href="ProductImageUpload.cfm?type=#rsGetImageTypes.imgType_ID#&nextpage=3" title="Upload/Manage Images" onclick="showUpload(this); return false;"><img src="assets/images/folder.gif" width="16" height="16" border="0" /></a>
								<img src="assets/images/delete.gif" title="Remove image from product" onclick="document.getElementById('#ImageFieldName#').value=''">
								<input name="ImageID#CurrentRow#" type="hidden" value="#rsCurrentImage.prdctImage_ID#">
								<input name="ImageType#CurrentRow#" type="hidden" value="#rsGetImageTypes.imgType_ID#" />
								<br />
								<cfif FORM[ImageFieldName] EQ "">
									<img id="image#rsGetImageTypes.imgType_ID#" src="" style="display: none;">
								<cfelse>
									<img src="#ImageSRC#" alt="Image path: #ImageSRC#" id="image#rsGetImageTypes.imgType_ID#">
								</cfif></td>
						</tr>
						</cfoutput>
					</table>		
				</div>
				<input type="hidden" name="ImageCount" value="<cfoutput>#rsGetImageTypes.RecordCount#</cfoutput>" />
				<input name="HasOrders" type="hidden" id="HasOrders" value="<cfoutput>#ProductHasOrders#</cfoutput>">
				<input type="hidden" name="nextpage" value="1" id="nextpage" >
				<input type="hidden" name="Action" value="<cfif val(url.product_ID) EQ 0>AddProduct<cfelse>UpdateProduct</cfif>">
			</form>
			<cfif rsGetProduct.recordcount NEQ 0>
			<div id="page4">		
			<!---<cfif IsDefined ('URL.AddSKU')> --->
				<cfparam name="FORM.SKU_MerchSKUID" default="">
				<cfparam name="FORM.SKU_Price" default="">
				<cfparam name="FORM.SKU_Sort" default="0">
				<cfparam name="FORM.SKU_Weight" default="0">
				<cfparam name="FORM.SKU_Stock" default="0">
				<cfparam name="request.AddSKUError" default=""> 
				<cfif (lstProductOptions NEQ "" OR (lstProductOptions EQ "" AND rsGetSKUs.recordCount LT 1))>
					<cfif NOT IsDefined ('URL.AddSKU')>
					<p id="pAddSKU">SKU Data:[ <a href="javascript:;" onclick="document.getElementById('addSKU').style.display='block';document.getElementById('pAddSKU').style.display='none'">Add SKU</a>]</p> 
					</cfif>
				<form name="addSKU" id="addSKU" method="post" action="<cfoutput>#request.ThisPageQS#</cfoutput>#AddSKU"<cfif not isdefined("url.AddSKU")> style="display:none"</cfif>> 
					<cfif rsGetSKUs.RecordCount GT 0>
					<p>[ <a href="javascript:;" onclick="document.getElementById('addSKU').style.display='none';document.getElementById('pAddSKU').style.display='block'">Hide Add SKU Form </a>]</p> 
					</cfif>
					<fieldset> 
					<legend><a name="addsku">Add New SKU</a></legend> 
					<table> 
						<tr> 
							<th>SKU</th> 
							<th>On Web </th> 
							<th valign="top">Price</th> 
							<th valign="top">Sort</th> 
							<th valign="top">Weight</th> 
							<th valign="top">Stock</th> 
						</tr> 
						<tr> 
							<td><input name="SKU_MerchSKUID" type="text" value="<cfoutput>#FORM.SKU_MerchSKUID#</cfoutput>" tabindex="14"></td> 
							<td>
								<select name="sku_showweb" id="sku_showweb" tabindex="14"> 
									<option value="1" #iif(isdefined('form.sku_showweb') and eq 1,de('selected'),de(''))#>Yes</option> 
									<option value="0" #iif(isdefined('form.sku_showweb') and eq 0,de('selected'),de(''))#>No</option> 
								</select> </td> 
							<td valign="top"><input name="SKU_Price" type="text" value="<cfoutput>#FORM.SKU_Price#</cfoutput>" size="10" tabindex="14"></td> 
							<td valign="top"><input name="SKU_Sort" type="text" value="<cfoutput>#FORM.SKU_Sort#</cfoutput>" size="5" tabindex="14"></td> 
							<td valign="top"><input name="SKU_Weight" type="text" value="<cfoutput>#FORM.SKU_Weight#</cfoutput>" size="5" tabindex="14"></td> 
							<td valign="top"><input name="SKU_Stock" type="text" value="<cfoutput>#FORM.SKU_Stock#</cfoutput>" size="5" tabindex="14"></td> 
						</tr> 
					</table> 
				
				<cfif rsRelProductOptions.recordcount GT 0> 
					<table> 
						<caption> 
						<span class="tabularData"> SKU Options </span> 
						</caption> 
						<cfoutput query="rsRelProductOptions" group="optiontype_name"> 
							<tr> 
								<th align="right" class="tabularData">#optiontype_name#: </th> 
								<td><cfsilent> 
									<cfparam name="intChosenOption" default="0"> 
									<!--- Get options from form submission if there is one. ---> 
									<cfif IsDefined('FORM.sku_id')> 
										<cfloop collection="#FORM#" item="FormItem"> 
											<cfif FormItem EQ "selOption" & currentRow> 
												<cfset intChosenOption = FORM[FormItem]> 
												<cfbreak> 
											</cfif> 
										</cfloop> 
									</cfif> 
									</cfsilent><select name="selOption#currentRow#" tabindex="14"> 
										<cfoutput> 
											<option value="#rsRelProductOptions.option_ID#"#IIf(intChosenOption EQ rsRelProductOptions.option_ID,DE(' selected'),DE(''))#>#rsRelProductOptions.option_name#</option> 
										</cfoutput> 
									</select></td> 
							</tr> 
						</cfoutput> 
					</table> 
				<cfelse> 
					<span class="smallprint">No SKU Options available for this product.</span> 
				</cfif> 
				<input name="Product_ID" type="hidden" id="Product_ID" value="<cfoutput>#URL.product_ID#</cfoutput>"> 
				<input name="AddSKU" type="submit" class="formButton" tabindex="14" value="Add New SKU"> 
				</fieldset> 
				<input type="hidden" name="nextpage" id="nextpage2" value="4">
				
			</form> 
			<hr> 
			<cfelse> 
				<span class="smallprint">Only one sku allowed for this product -- no options available.</span> 
			</cfif>
		<!---</cfif> --->
		<cfif URL.Product_ID NEQ "0"> 
			<table class="noBorders"> 
			<cfloop query="rsGetSKUs"> 
				<cfsilent> 
				
				<!--- Get SKU Option ---> 
				<cfquery name="rsSkuOptions" datasource="#request.dsn#" username="#request.dsnusername#" password="#request.dsnpassword#">
				SELECT DISTINCT tbl_skuoption_rel.optn_rel_ID, tbl_skuoptions.option_Type_ID, tbl_skuoption_rel.optn_rel_Option_ID FROM tbl_skuoptions INNER JOIN tbl_skuoption_rel ON tbl_skuoptions.option_ID = tbl_skuoption_rel.optn_rel_Option_ID WHERE tbl_skuoption_rel.optn_rel_SKU_ID= #rsGetSKUs.SKU_ID#
				</cfquery> 
				<cfset lstSKUOptions = ""> 
				<cfloop query="rsSkuOptions"> 
					<cfset lstSKUOptions = ListAppend(lstSKUOptions, rsSkuOptions.optn_rel_Option_ID)> 
				</cfloop>
				<!--- Are there any orders? --->
				<cfquery name="rsCheckForOrders" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
				SELECT Count(ordersku_id) as AreThereSkus 
				FROM tbl_orderskus 
				WHERE orderSKU_SKU = #rsGetSKUs.SKU_ID#
				</cfquery>
				
				<cfif rsCheckForOrders.AreThereSkus NEQ 0>
					<cfset HasOrders = 1>
					<cfset DisabledText = " disabled=""disabled""">
				<cfelse>
					<cfset HasOrders = 0>
					<cfset DisabledText = "">
				</cfif>
				</cfsilent> 
				<tr class="<cfoutput>#IIF(CurrentRow MOD 2, DE('altRowEven'), DE('altRowOdd'))#</cfoutput>"> 
					<td><form method="post" name="updateSKU" action="<cfoutput>#request.ThisPage#?Product_ID=#URL.Product_ID#</cfoutput>"> 
						<fieldset> 
						<legend><cfoutput> 
							<cfif HasOrders EQ 0 > 
								<a href="#request.ThisPage#?delete_sku_id=#rsGetSKUs.SKU_ID#&product_ID=#rsGetProduct.product_ID#&nextpage=4" onClick="return confirm('Are you SURE you want to DELETE this SKU?')"><img src="assets/images/delete.gif" alt="Delete SKU" name="delete" width="14" height="17" align="middle"></a> 
								<cfelse> 
								<a href="javascript:alert('Cannot Delete This SKU - It has associated orders');"><img src="assets/images/delete-fade.gif" alt="You cannot delete this SKU" name="delete" width="14" height="17" align="middle"></a> 
							</cfif> 
							<a name="#rsGetSKUs.SKU_ID#">#rsGetSKUs.SKU_MerchSKUID#</a></cfoutput></legend> 
						<cfif IsDefined ('CantDeleteSKU')> 
							<cfif URL.delete_sku_id EQ "#rsGetSKUs.SKU_ID#"> 
								<p><strong><cfoutput>#request.CantDeleteSKU#</strong></cfoutput></p> 
							</cfif> 
						</cfif> 
						<table class="tabularData"> 
							<tr> 
								<th>On Web </th> 
								<th>Price </th> 
								<th>Sort</th> 
								<th>Weight</th> 
								<th>Stock</th> 
							</tr> 
							<tr> 
								<td><select name="SKU_ShowWeb" id="SKU_ShowWeb" tabindex="14"> 
										<cfif rsGetSKUs.SKU_ShowWeb IS 1> 
											<option value="1" selected="selected">Yes
											<option value="0">No
											<cfelse> 
											<option value="1" >Yes
											<option value="0" selected="selected">No
										</cfif> 
									</select></td> 
								<td><input name="SKU_Price" type="text" value="<cfoutput>#LSNumberFormat(rsGetSKUs.SKU_Price, "9.99")#</cfoutput>" size="10" tabindex="14"> </td> 
								<td><input name="SKU_Sort" type="text" value="<cfoutput>#rsGetSKUs.SKU_Sort#</cfoutput>" size="5" tabindex="14"></td> 
								<td><input name="SKU_Weight" type="text" value="<cfoutput>#rsGetSKUs.SKU_Weight#</cfoutput>" size="5" tabindex="14"></td> 
								<td><input name="SKU_Stock" type="text" value="<cfoutput>#rsGetSKUs.SKU_Stock#</cfoutput>" size="5" tabindex="14"></td> 
							</tr> 
						</table> 
							<cfif rsRelProductOptions.recordcount GT 0> 
								<table class="tabularData"> 
									<caption>
									SKU Options
									</caption> 
									<cfif HasOrders EQ 0> 
										<cfoutput query="rsRelProductOptions" group="optiontype_name"> 
											<tr> 
												<th align="right">#optiontype_name#: </th> 
												<td> <select name="selOption#currentRow#" tabindex="14"#DisabledText#> 
														<cfoutput> 
															<cfif ListFind(lstSKUOptions,rsRelProductOptions.option_ID,",") NEQ 0> 
																<option value="#rsRelProductOptions.option_ID#" selected="selected">#rsRelProductOptions.option_name#</option> 
																<cfelse> 
																<option value="#rsRelProductOptions.option_ID#">#rsRelProductOptions.option_name#</option> 
															</cfif> 
														</cfoutput> 
													</select> </td> 
											</tr> 
										</cfoutput> 
										<cfelse> 
										<cfoutput query="rsRelProductOptions" group="optiontype_name"> 
											<tr> 
												<th align="right">#optiontype_name#: </th> 
												<td> <cfoutput> 
														<cfif ListFind(lstSKUOptions,rsRelProductOptions.option_ID,",") NEQ 0> 
															#rsRelProductOptions.option_name# 
															<input type="hidden" value="#rsRelProductOptions.option_ID#" name="selOption#currentRow#" id="selOption#currentRow#"> 
														</cfif> 
													</cfoutput> </td> 
											</tr> 
										</cfoutput> 
									</cfif> 
								</table> 
								<cfelse> 
								<div class="smallprint">No SKU Options available for this product.</div> 
							</cfif> 
							<cfif HasOrders EQ 1> 
								<div class="smallprint">Orders placed, no Option changes allowed</div> 
							</cfif> 
							<input name="UpdateSKU" type="submit" class="formButton" id="UpdateSKU" tabindex="15" value="Update This SKU"> 
							<input name="SKU_ProductID" type="hidden" id="SKU_ProductID" value="<cfoutput>#rsGetSKUs.SKU_ProductID#</cfoutput>"> 
							<input name="sku_id" type="hidden" id="sku_id" value="<cfoutput>#rsGetSKUs.SKU_ID#</cfoutput>"> 
							</fieldset> 
							<input type="hidden" name="nextpage" id="nextpage4" value="4">
						</form></td> 
						</tr>
					</cfloop>
				</table>
			</cfif>
			</div>
			<div id="page5">
				<cfif URL.Product_ID NEQ "0">
				<!--- Up-sell --->
				<cfif variables.DisplayUpSell EQ 1>
					<cfquery name="rsUpsellProducts" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
					SELECT tbl_products.product_ID, tbl_products.product_Name
					FROM tbl_products
					ORDER BY tbl_products.product_Name
					</cfquery>
					<!--- Add Up-sell Form ---> 
					<form name="frmAddUpSell" method="POST" action="<cfoutput>#request.ThisPageQS#</cfoutput>"> 
						<fieldset> 
						<legend>Up-sell Admin</legend> 
						<table class="noBorders"> 
							<tr> 
								<td><select name="UpSellProduct_ID">
								<cfoutput query="rsUpsellProducts">
									<option value="#product_ID#">#product_Name#</option>
								</cfoutput>
								</select>
								</td> 
								<td><input name="ADDUpsell" type="submit" class="formButton" id="ADDUpsell" value="Add Up-sell Product"></td> 
							</tr> 
						</table> 
						<input name="product_ID" type="hidden" value="<cfoutput>#URL.product_ID#</cfoutput>"> 
						<!--- Display an Up-sell error if one exist ---> 
						<cfif IsDefined ("variables.UpSellProductIDError")> 
							<div class="smallprint"> 
								<p><strong>**<cfoutput>#variables.UpSellProductIDError#</cfoutput></strong></p> 
							</div> 
						</cfif> 
						<!--- Display Up-sell items if there are any ---> 
						<cfif rsGetUpsell.RecordCount NEQ 0> 
							<table class="tabularData"> 
								<tr> 
									<th>Related Product </th> 
									<th>Delete</th> 
								</tr> 
								<cfoutput query="rsGetUpsell"> 
									<tr> 
										<td><div style="float:left">#cwDisplayImage(rsGetUpsell.Product_ID, 4, rsGetUpsell.product_Name, "")#</div>#rsGetUpsell.product_Name# (#rsGetUpsell.product_MerchantProductID#) </td> 
										<td style="text-align: center;"><a href="#request.ThisPage#?delupsell_id=#rsGetUpsell.upsell_id#&product_ID=#URL.product_ID#&nextpage=5"><img src="assets/images/delete.gif" width="14" height="17" border="0"></a></td> 
									</tr> 
								</cfoutput> 
							</table> 
						</cfif> 
						</fieldset>
						<input type="hidden" name="nextpage" id="nextpage5" value="5">
					</form>
				<cfelse>
					<p>Up-sells turned off.</p>
				</cfif><!--- END IF - variables.DisplayUpSell EQ 1 --->
			</cfif><!--- END IF - URL.Product_ID NEQ "0" --->
			</div><!--- END div id="page5" --->
			</cfif><!--- END <cfif Val(url.product_ID) NEQ 0> --->
		</div><!--- END div id="divPages" --->
	</div><!--- END div id="divWrapper" --->
	<!--- Submit buttons for pages 1-3 --->
	<div id="submitProduct">		
		<cfif URL.product_ID NEQ '0'> 
		<form name="formactions" action="<cfoutput>#request.ThisPageQS#</cfoutput>" method="post">
			<input name="UpdateProduct" type="button" class="formButton" id="UpdateProduct" value="Update Product" onclick="document.getElementById('productform').submit();">
			<input type="hidden" name="product_ID" value="<cfoutput>#url.product_ID#</cfoutput>">
			
			<cfif ProductHasOrders NEQ 0> 
				<input name="ArchiveProduct" type="submit" class="formButton" onClick="return confirm('Are you SURE you want to ARCHIVE this Product and all associated SKUs AND REMOVE IT FROM THE WEB.?')" value="Archive Product"> 
				<p>*Note: You may not delete this product because there have already been
				orders placed for this product. You may archive the product instead, by
				clicking the Archive Product button</p>
				<cfelse>
				<input name="DeleteProduct" type="submit" class="formButton" id="DeleteProduct" tabindex="13" onClick="return confirm('Are you SURE you want to DELETE this Product? All related SKUs will also be deleted. This action cannot be undone.')" value="Delete Product"> 
				<p><a href="<cfoutput>#request.ThisPageQS#</cfoutput>&ArchiveProduct=true" onclick="return confirm('Are you SURE you want to ARCHIVE this Product and all associated SKUs AND REMOVE IT FROM THE WEB.?')">Archive Product</a>
			</cfif> 
		</form>
		<cfelse> 			
			<input name="AddProduct" type="button" class="formButton" id="AddProduct" tabindex="13" value="Add Product" onclick="doFormAction()" />
		</cfif> 
		
	</div>					
</div><!--- END div id="divMainContent" --->
</cfprocessingdirective> 
</body>
</html>
