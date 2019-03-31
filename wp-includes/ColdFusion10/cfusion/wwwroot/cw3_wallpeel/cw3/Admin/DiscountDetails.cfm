<!---


================================================================
Application Info: 
Cartweaver© 2002 - 2007, All Rights Reserved.
Developer Info: 
	Application Dynamics Inc.
	1560 NE 10th
	East Wenatchee, WA 98802
	Support Info: http://www.cartweaver.com/go/cfhelp

Cartweaver Version: 3.0.7  -  Date: 7/8/2007
================================================================
Name: ShipMethods.cfm
Description: Here we add details about a new or existing discount
================================================================

--->
<cfscript>
//default is last week
if(NOT IsDefined("Form.StartDate") OR Not IsDate(form.StartDate)) {
	Form.StartDate = LSDateFormat(DateAdd("d","-7",Now()), #request.dateMask#);
}else{
	Form.StartDate = LSDateFormat(Form.StartDate, #request.dateMask#);
}

if(NOT IsDefined("Form.EndDate") OR Not IsDate(form.EndDate)) {
	Form.EndDate = LSDateFormat(Now(),#request.dateMask#);
} else{
	Form.EndDate = LSDateFormat(Form.EndDate, #request.dateMask#);
}
</cfscript>
<cfparam name="url.discount_id" default="0">
<cfparam name="form.discount_id" default="#url.discount_id#">
<cfparam name="url.nextpage" default="1">
<cfparam name="Form.nextpage" default="#url.nextpage#">
<cfparam name="Form.skulist" default="0">
<cfparam name="Form.productlist" default="0">
<cfparam name="Form.deleteProductID" default="">
<cfparam name="Form.discountType" default="1">
<cfparam name="Form.deleteSkuID" default="">
<cfparam name="skulist" default="#form.skulist#">
<cfparam name="productlist" default="#form.productlist#">
<cfparam name="form.discount_limit" default="0">
<cfparam name="discount_Categories" default="">
<cfparam name="discount_Secondaries" default="">
<cfparam name="discount_Customers" default="">
<cfparam name="discount_Shipmethods" default="">

<cfif form.discount_limit GT 1>
	<cfset discountLimit = form.intLimit>
<cfelse>
	<cfset discountLimit = form.discount_limit>
</cfif>

<cfif IsDefined("form.discountType") AND form.discountType EQ 1><!--- If type of discount is flat rate, zero the minimum qty and amounts --->
	<cfset form.intMinQty = 0>
	<cfset form.minAmount = 0>
</cfif>


<cfif isdefined("url.archive")>
	<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
	UPDATE tbl_discounts 
	SET	discount_archive = #val(url.archive)#
	WHERE discount_id = #val(url.discount_id)#
	</cfquery>
</cfif>

<cfquery name="rsCWDiscountList" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
SELECT d.discount_id, 
d.discount_name
FROM tbl_discounts d
WHERE d.discount_archive = 0
ORDER BY d.discount_name
</cfquery>

<cfquery name="rsCWDiscountTypes" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
SELECT discountType_id, discountType_desc 
FROM tbl_discount_types
WHERE discountType_archive = 0
ORDER BY discountType_id
</cfquery>

<cfquery name="rsCWDiscountAppliesTo" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
SELECT discountApplyType_desc, discountApplyType_id 
FROM tbl_discount_apply_types
WHERE discountApplyType_archive = 0
ORDER BY discountApplyType_id
</cfquery>

<cfif (IsDefined("Form.updateDiscount"))>
	<!--- Update record --->
	<cfparam name="Form.discount_showDesc" default="0">
	<cfparam name="Form.discount_archive" default="1">

	<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
	UPDATE tbl_discounts
	SET	discount_applyType=#val(form.discount_applyType)#, 
	discount_applyTo='#form.selApplyTo#',
	discount_reference_id='#form.discount_reference_id#', 
	discount_name='#form.discount_name#', 
	discount_startDate='#LSDateFormat(LSParseDateTime(form.StartDate),"yyyy-mm-dd")#',
	discount_endDate='#LSDateFormat(LSParseDateTime(form.EndDate),"yyyy-mm-dd")#',
	discount_showDesc=#val(form.discount_showDesc)#, 
	discount_description='#form.discount_description#',
	discount_limit=#discountLimit#,
	discount_promotionalCode='#form.discount_promotionalCode#',
	discount_type = #val(form.discountType)#,
	discount_archive=#val(form.discount_archive)#
	WHERE discount_id = #val(form.discount_id)#
	</cfquery>	

	<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
	UPDATE tbl_discount_amounts
	SET	
	discountAmount_minimumAmount = <cfqueryparam cfsqltype="cf_sql_float" value="#makeSQLSafeNumber(form.minAmount)#">, 
	discountAmount_discount = <cfqueryparam cfsqltype="cf_sql_float" value="#makeSQLSafeNumber(form.discountRate)#">, 
	discountAmount_minimumQty = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.intMinQty#">,
	discountAmount_rateType = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.txtDiscountRateType#">
	WHERE discountAmount_discount_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#val(form.discount_id)#">
	</cfquery>

</cfif>

<cfif (IsDefined("Form.addDiscount"))>
	<cfparam name="Form.discount_showDesc" default="0">
	<cfparam name="Form.discount_archive" default="0">
	<!---<cfdump var="#form#"><cfabort>--->
	<!--- Insert record --->
	<cftry>
	<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">INSERT INTO tbl_discounts
	(discount_applyType, 
	discount_applyTo,
	discount_reference_id, 
	discount_name, 
	discount_startDate, 
	discount_endDate, 
	discount_showDesc, 
	discount_description,
	discount_limit,
	discount_promotionalCode,
	discount_type,
	discount_archive)
	VALUES(
	#val(Form.discount_applyType)#,
	'#Form.selApplyTo#',
	'#Form.discount_reference_id#',
	'#form.discount_name#',
	'#LSDateFormat(LSParseDateTime(form.StartDate),"yyyy-mm-dd")#',
	'#LSDateFormat(LSParseDateTime(form.EndDate),"yyyy-mm-dd")#',
	#val(form.discount_showDesc)#,
	'#form.discount_description#',
	#discountLimit#,
	'#form.discount_promotionalCode#',
	#val(form.discountType)#,
	#val(form.discount_archive)#
	)
	</cfquery>
	<Cfcatch>
	<cfdump var="#cfcatch#">
	<cfdump var="#variables#">
	</Cfcatch>
	</cftry>
	<cfquery name="rsCWGetDiscountId" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
	SELECT MAX(discount_id) as maxdiscount_id 
	FROM tbl_discounts
	</cfquery>
	<cfset Url.discount_id = rsCWGetDiscountId.maxdiscount_id>
	<cfset form.discount_id = url.discount_id>

	
	<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
	INSERT INTO tbl_discount_amounts
	(discountAmount_minimumAmount, 
	discountAmount_discount, 
	discountAmount_minimumQty,
	discountAmount_discount_id,
	discountAmount_rateType)
	VALUES
	(<cfqueryparam cfsqltype="cf_sql_integer" value="#form.minAmount#">, 
	<cfqueryparam cfsqltype="cf_sql_integer" value="#form.discountRate#">, 
	<cfqueryparam cfsqltype="cf_sql_integer" value="#form.intMinQty#">,
	<cfqueryparam cfsqltype="cf_sql_integer" value="#form.discount_id#">,
	<cfqueryparam cfsqltype="cf_sql_integer" value="#form.txtDiscountRateType#">)
	</cfquery>
</cfif>

<cfif (IsDefined("Form.selApplyTo"))>
	<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
	DELETE FROM 
	tbl_discounts_products_rel
	WHERE discounts_products_rel_discount_id = 
	<cfqueryparam cfsqltype="cf_sql_integer" value="#form.discount_id#">
	</cfquery>
	
	<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
	DELETE FROM 
	tbl_discounts_skus_rel
	WHERE discounts_skus_rel_discount_id = 
	<cfqueryparam cfsqltype="cf_sql_integer" value="#form.discount_id#">
	</cfquery>
	
	<cfif Form.selApplyTo NEQ "all">
		<cfloop list="#form.productlist#" index="value">		
			<cfif val(value) NEQ 0 AND NOT ListFind(form.deleteProductID, value)>
				<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
				INSERT INTO
				tbl_discounts_products_rel 
				(discounts_products_rel_discount_id, discounts_products_rel_prod_id)
				VALUES
				(<cfqueryparam cfsqltype="cf_sql_integer" value="#form.discount_id#">,
				<cfqueryparam cfsqltype="cf_sql_integer" value="#value#">)
				</cfquery>
			</cfif>
		</cfloop>
		
		<cfloop list="#form.skulist#" index="value">
			<cfif val(value) NEQ 0 AND NOT ListFind(form.deleteSkuID, value)>
				<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
				INSERT INTO
				tbl_discounts_skus_rel 
				(discounts_skus_rel_discount_id, discounts_skus_rel_sku_id)
				VALUES
				(<cfqueryparam cfsqltype="cf_sql_integer" value="#form.discount_id#">,
				<cfqueryparam cfsqltype="cf_sql_integer" value="#value#">)
				</cfquery>
			</cfif>
		</cfloop>
	</cfif>
	<!--- Get all products for this discount --->	
	<cfquery name="rsCWDiscountProductList" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
	SELECT discounts_products_rel_prod_id
	FROM tbl_discounts_products_rel
	WHERE discounts_products_rel_discount_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.discount_id#">
	</cfquery>
	<!--- Get all skus for this discount --->	
	<cfquery name="rsCWDiscountSkuList" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
	SELECT discounts_skus_rel_sku_id
	FROM tbl_discounts_skus_rel
	WHERE discounts_skus_rel_discount_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.discount_id#">
	</cfquery>
	<cfif rsCWDiscountSkuList.RecordCount EQ 0 AND rsCWDiscountProductList.RecordCount EQ 0>
		<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
		UPDATE tbl_discounts SET discount_applyTo = 'all'
		WHERE discount_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.discount_id#">
		</cfquery>
	<cfelse>
		<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
		UPDATE tbl_discounts SET discount_applyTo = 'specific'
		WHERE discount_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.discount_id#">
		</cfquery>
	</cfif>
</cfif>

<cfif (IsDefined("Form.updateDiscount") OR IsDefined("form.addDiscount"))>
	<cfset update="">
	<cfif isdefined("form.updateDiscount")><cfset update = "&update=true"></cfif>
	<cflocation url="DiscountDetails.cfm?discount_id=#form.discount_id##update#">
</cfif>

<cfparam name="rsCWDiscount.RecordCount" default="0">
<cfif (IsDefined("Url.discount_id"))>
	<cfquery name="rsCWDiscount" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
	SELECT d.discount_id, 
	d.discount_applyType, 
	d.discount_applyTo, 
	d.discount_type, 
	d.discount_reference_id, 
	d.discount_name, 
	d.discount_startDate, 
	d.discount_endDate, 
	d.discount_showDesc, 
	d.discount_description,
	d.discount_limit,
	d.discount_promotionalCode,
	d.discount_archive
	FROM tbl_discounts d
	WHERE d.discount_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#val(form.discount_id)#">
	</cfquery>
	
	<!--- Get all products for this discount --->	
	<cfquery name="rsCWDiscountProductList" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
	SELECT discounts_products_rel_prod_id
	FROM tbl_discounts_products_rel
	WHERE discounts_products_rel_discount_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.discount_id#">
	</cfquery>
	
	<cfif rsCWDiscountProductList.RecordCount GT 0>
		<cfset productList = valueList(rsCWDiscountProductList.discounts_products_rel_prod_id)>
	<cfelse>
		<cfset productList = "">
	</cfif>
	
	<!--- Get all skus for this discount --->	
	<cfquery name="rsCWDiscountSkuList" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
	SELECT discounts_skus_rel_sku_id
	FROM tbl_discounts_skus_rel
	WHERE discounts_skus_rel_discount_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.discount_id#">
	</cfquery>
	<cfif rsCWDiscountSkuList.RecordCount GT 0>
		<cfset skuList = valueList(rsCWDiscountSkuList.discounts_skus_rel_sku_id)>
	<cfelse>
		<cfset skuList = "">
	</cfif>
	
	<!--- Get all discount amounts for this discount --->
	<cfquery name="rsCWDiscountAmounts" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
	SELECT *
	FROM tbl_discount_amounts
	WHERE discountAmount_discount_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.discount_id#">
	</cfquery>
</cfif>
<cfparam name="discount_id" default="">
<cfparam name="discount_applyType" default="">
<cfparam name="discount_applyTo" default="">
<cfparam name="discount_type" default="">
<cfparam name="discount_reference_id" default="">
<cfparam name="discount_name" default="">
<cfparam name="discount_name" default="">
<cfparam name="discount_startDate" default="#Form.StartDate#">
<cfparam name="discount_endDate" default="#Form.EndDate#">
<cfparam name="discount_archive" default="0">
<cfparam name="discount_description" default="">
<cfparam name="discount_showDesc" default="0">
<cfparam name="discount_limit" default="1">
<cfparam name="discount_promotionalCode" default="">
<cfparam name="discount_amount" default="0">
<cfparam name="discount_rateType" default="0">


<cfif rsCWDiscount.RecordCount NEQ 0>
	<cfset discount_id = rsCWDiscount.discount_id>
	<cfset discount_applyType = rsCWDiscount.discount_applyType>
	<cfset discount_applyTo =  rsCWDiscount.discount_applyTo>
	<cfset discount_type =  rsCWDiscount.discount_type>
	<cfset discount_reference_id =  rsCWDiscount.discount_reference_id>
	<cfset discount_name =  rsCWDiscount.discount_name>
	<cfset discount_startDate =  LSDateFormat(rsCWDiscount.discount_startDate, #request.dateMask#)>
	<cfset discount_endDate =  LSDateFormat(rsCWDiscount.discount_endDate, #request.dateMask#)>
	<cfset discount_archive =  rsCWDiscount.discount_archive>
	<cfset discount_description =  rsCWDiscount.discount_description>
	<cfset discount_showDesc =  rsCWDiscount.discount_showDesc>
	<cfset discount_limit =  rsCWDiscount.discount_limit>
	<cfset discount_promotionalCode =  rsCWDiscount.discount_promotionalCode>
	<cfset discount_amount =  rsCWDiscountAmounts.discountAmount_discount>
	<cfset discount_rateType =  rsCWDiscountAmounts.discountAmount_rateType>
</cfif>


<!--- Set location for highlighting in Nav Menu --->
<cfset strSelectNav = "Discounts">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>CW Admin: Add New Discount</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="assets/admin.css" rel="stylesheet" type="text/css">
<link href="assets/tabs.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="assets/discounts.js"></script>
<script type="text/javascript" src="assets/tabs.js"></script>
<script language="JavaScript" type="text/javascript" src="assets/global.js"></script>

<script>


<!--- Date Pop Up --->
// function to load the calendar window.
function ShowCalendar(FormName, FieldName) {
	var curValue = eval("document."+FormName+"."+FieldName+".value");
	window.open("DatePopup.cfm?getDate="+ curValue + "&FormName=" + FormName + "&FieldName=" + FieldName, "CalendarWindow", "width=250,height=200");
}
<!--- Product list Pop Up --->
// function to load the product list window.
function cw_ShowProductList(FormName, ProductField, SkuField) {
	var productFieldValue = eval("document."+FormName+"."+ProductField+".value");
	var skuFieldValue = eval("document."+FormName+"."+SkuField+".value");
	window.open("DiscountProductList.cfm?productlist="+ productFieldValue + "&skulist=" + skuFieldValue + "&FormName=" + FormName + "&ProductField=" + ProductField + "&SkuField=" + SkuField, "productList", "width=650,height=600,scrollbars=yes,resizable=yes,");
}

// function to load the product list window with one product.
function cw_ShowProduct(FormName, ProductField, SkuField, productid) {
	window.open("DiscountProductList.cfm?searchBy=prodID&matchType=anyMatch&find="+ productid + "&FormName=" + FormName + "&ProductField=" + ProductField + "&SkuField=" + SkuField, "productList", "width=650,height=600,scrollbars=yes,resizable=yes,");
}

function showProductLink(option) {
	document.getElementById('addProducts').style.display = (option != 'all') ? 'block' : 'none';
	document.getElementById('productlist').disabled = (option != 'all') ? false : true;
	document.getElementById('skulist').disabled = (option != 'all')? false : true;
}

//Function to clear default text. Function name must stay all lowercase!
function cw_cleardefault(theField){
	if(theField.value == theField.defaultValue){theField.value = '';}
}

function validateDiscount() {
	var valid = (document.getElementById('discount_reference_id').value != '' && document.getElementById('discount_name').value != '');
	if(!valid) alert("Must enter a friendly name and reference id for the discount before continuing");
	return valid;
}


//-->
</script>
</head>
<body onload="<cfoutput>showProductLink('#discount_applyTo#');</cfoutput>">

<cfinclude template="CWIncNav.cfm">
<div id="divMainContent">
	<h1><cfif val(discount_id) EQ 0>Add New<cfelse>Update</cfif> Discount</h1>
<cfif val(discount_id) NEQ 0>
	<cfif val(rsCWDiscount.discount_archive) EQ 0>
	<p>This discount is active. 
	<a href="DiscountDetails.cfm?archive=1&amp;discount_id=<cfoutput>#discount_id#</cfoutput>">Archive</a></p>
	<cfelse>
	<p>This discount is archived. <a href="DiscountDetails.cfm?archive=0&amp;discount_id=<cfoutput>#discount_id#</cfoutput>">Activate</a></p>
	</cfif>
<cfelse><br />
</cfif>
<cfif isDefined("url.update")><p><strong>Discount Updated.</strong></p></cfif>
<form method="post" name="formDiscounts" action="" onsubmit="return validateDiscount()">	
	<input type="hidden" name="discount_applyType" value="<cfoutput>#rsCWDiscountAppliesTo.discountApplyType_id#</cfoutput>">
		<div id="divWrapper">
			<div id="divPages">
				<div id="page1">
				<table>
					<tr>
						<th align="right">Reference ID: </th>
						<td nowrap="nowrap">
					  <input name="discount_reference_id" type="text" id="discount_reference_id" value="<cfoutput>#discount_reference_id#</cfoutput>"/></td>
					</tr>
					<tr>
						<th align="right">User Friendly Name: </th>
						<td nowrap="nowrap">
					  <input name="discount_name" type="text" id="discount_name" value="<cfoutput>#discount_name#</cfoutput>"/></td>
					</tr>
					<tr>
                      <th align="right">Start Date: </th>
					  <td nowrap="nowrap">
					    <input name="StartDate" type="text" required="yes"  value="<cfoutput>#discount_startDate#</cfoutput>" size="10" passthrough="onFocus=""cw_cleardefault(this);""">
                      <a href="javascript:ShowCalendar('formDiscounts', 'StartDate')"><img src="assets/images/calendar.gif" alt="Click to Select Date" width="16" height="16"></a></td>
				  </tr>
					<tr>
                      <th align="right">End Date: </th>
					  <td nowrap="nowrap">
					    <input  name="EndDate" type="text" required="yes"  value="<cfoutput>#discount_endDate#</cfoutput>" size="10" passthrough="onFocus=""cw_cleardefault(this);""">
						
                      <a href="javascript:ShowCalendar('formDiscounts', 'EndDate')"><img src="assets/images/calendar.gif" width="16" height="16" style="margin-bottom:0px;" alt="Click to Select Date"></a>
					  <cfif DateDiff("d",discount_endDate, now()) GT 0><span style="color:red">End date has passed.</span></cfif></td>
				  </tr>
					
					<tr>
						<th align="right">Description<br />(250 characters or less): </th>
						<td nowrap="nowrap">
						  <textarea name="discount_description" cols="50" rows="5" id="discount_description"><cfoutput>#discount_description#</cfoutput></textarea>
						<input type="hidden" name="discount_showDesc" value="1" >
						<input type="hidden" name="discount_description_cfformmaxlength" value="250">
					  </td>
					</tr>
					
					<tr>
						<th align="right">Active: </th>
						<td nowrap="nowrap">
					  <input name="discount_archive" type="checkbox" class="formCheckbox" value="0" <cfif discount_archive EQ 0>checked="checked"</cfif>></td>
					</tr>
					<tr>
						<th align="right">Promotional Code: </th>
						<td><input name="discount_promotionalCode" type="text" id="discount_promotionalCode" size="25" value="<cfoutput>#discount_promotionalCode#</cfoutput>" /> 
							<br />
						Optional. If left blank a promotional code will not be required at checkout. </td>
					</tr>
					<tr>
						<th align="right">Take: </th>
						<td><input type="hidden" name="" value="<cfoutput>#rsCWDiscountTypes.discountType_id#</cfoutput>">
							<input name="discountRate" type="text" id="discountRate" size="10" value="<cfoutput>#LSNumberFormat(discount_amount, '9.99')#</cfoutput>">
							<select name="txtDiscountRateType" id="txtDiscountRateType">
								<option value="0"<cfif discount_rateType EQ 0> selected="selected"</cfif>>Percent</option>
								<option value="1"<cfif discount_rateType EQ 1> selected="selected"</cfif>>Amount in currency</option>
							</select> Off</td>
					</tr>
					</table>
					<div id="products" <cfif val(discount_id) EQ 0>style="display:none"</cfif>>
					<p><label> Apply to:
						<select name="selApplyTo" id="selApplyTo" onChange="showProductLink(this.options[this.selectedIndex].value)">
							<option value="all"<cfif discount_applyTo EQ 'all'> selected="selected"</cfif>>All Products</option>
							<option value="specific"<cfif discount_applyTo EQ 'specific'>selected="selected"</cfif>>Specific Product(s) Only:</option>
						</select>
						</label>
					</p>
					<div id="addProducts" style="display: none;">
						[ <a href="javascript:;" onclick="cw_ShowProductList('formDiscounts','productlist','skulist')">Add Products</a> ]
					
					<input type="hidden" name="productlist" id="productlist" value="<cfoutput>#productList#</cfoutput>"/>
					<input type="hidden" name="discountType" id="discountType" value="<cfoutput>#form.discountType#</cfoutput>"/>
					<input type="hidden" name="skulist" id="skulist" value="<cfoutput>#skuList#</cfoutput>"/>
					<div id="productListDisplay"><cfinclude template="CWDiscountQuery.cfm"></div></div></div>
				</div>
			</div>
		</div>
		<div><cfif VAL(discount_id) NEQ 0>
			<input type="hidden" name="discount_id" value="<cfoutput>#discount_id#</cfoutput>"/>
			<input name="updateDiscount" id="discount_submit" type="submit" class="formButton" value="Update Discount">
			<cfelse>
			<input name="addDiscount" type="submit" id="discount_submit" class="formButton" value="Continue &raquo;">
			</cfif></div>
			<input type="hidden" name="nextpage" id="nextpage" value="1"/>
	</form>
</body>
</html>
