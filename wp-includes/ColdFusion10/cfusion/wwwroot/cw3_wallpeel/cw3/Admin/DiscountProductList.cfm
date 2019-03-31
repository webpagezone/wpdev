<!--- 
================================================================
Application Info: 
Cartweaver© 2002 - 2007, All Rights Reserved.
Developer Info: 
	Application Dynamics Inc.
	1560 NE 10th
	East Wenatchee, WA 98802
	Support Info: http://www.cartweaver.com/go/cfhelp

Cartweaver Version: 3.0.10  -  Date: 4/27/2008
================================================================
Name: CWIncProductSearch.cfm
Description: Product Search form used on the product list and product details pages.
================================================================
--->
<cfparam name="Url.searchBy" default="prodID">
<cfparam name="Url.matchType" default="anyMatch">
<cfparam name="Url.find" default="">
<cfparam name="Url.productids" default="">
<cfparam name="Url.searchMode" default="simple">


<cfscript>
if(NOT IsDefined("Url.showcolumns")) {
	Url.showcolumns = "product_MerchantProductID";
}
showColumns = Url.showcolumns;

function showColumn(column) {
	return(IsDefined("Url.showcolumns") AND ListFind(Url.showcolumns,column));
}

queryFind = "";
if (Url.find NEQ "") {
	queryFind = Url.find;
}
</cfscript>

<cfquery name="rsCWProductsSearch" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
SELECT DISTINCT
	p.product_ID, 
	product_MerchantProductID,
	product_Name
FROM tbl_products p
LEFT OUTER JOIN tbl_prdtimages i
ON p.product_ID = i.prdctImage_ProductID
WHERE p.product_Archive = 0
<cfif (Url.searchBy EQ "prodID")>
AND p.product_MerchantProductID
<cfelse>
AND p.product_Name
</cfif>
<cfif (Url.matchType EQ "exactMatch" OR Url.find EQ "")>
     = '#queryFind#'
<cfelse>
     LIKE '%#queryFind#%'
</cfif>

<cfif url.productids  NEQ "">
	AND product_MerchantProductID IN (#listQualify(url.productids,"'")#)
</cfif>
AND p.product_ID IN (SELECT SKU_ProductID FROM tbl_skus)
ORDER BY p.product_Name, p.product_MerchantProductID
</cfquery>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Product Search</title>
<link href="assets/admin.css" rel="stylesheet" type="text/css" />
<style type="text/css">
body{
	margin:10px;
}
.skuOptions {	margin-left: 1.5em;
	margin-bottom: 1em;
	padding-left: .5em;
	border-left: 1px solid #76685D;
}
.collapsed {display:;}
.tabularData input {background-color:transparent;}
.skus {margin:0;padding:0;border:0}
.skus table {border-collapse:collapse;}
</style>

<script language="JavaScript">
<!--
var removeProducts = new Array();
// function to populate the data on the form and to close this window. 
function cwAddProducts() {
	var theForm = self.opener.document.formDiscounts;
	// first, get existing sku ids and product ids
	var productlist = new Array();
	var skulist = new Array();
	if(theForm.productlist.value != "")
		productlist = theForm.productlist.value.split(",");
    if(theForm.productlist.value != "")
		skulist = theForm.skulist.value.split(",");
	// get all checkboxes
	var checkboxes = document.getElementsByTagName('input');
	var productChecked = "";
	for(var i=0; i<checkboxes.length; i++) {
		if(checkboxes[i].getAttribute('type')=='checkbox' && checkboxes[i].checked) {
			if(checkboxes[i].className == 'productid'){
				// if a sku and checked, add to the array
				productlist.push(checkboxes[i].value);
				// Checkboxes are in order so if product id is checked, don't add skus
				productChecked = checkboxes[i].value;
			}else if (checkboxes[i].className == 'skuid' && 
				checkboxes[i].name != 'skuid_' + productChecked){
				// if a product and checked, add to the array
				skulist.push(checkboxes[i].value);
			}
		}
	}
	for(i = productlist.length-1; i>=0; i--) {
		for(var j=0; j<removeProducts.length; j++) {
			if(removeProducts[j] == productlist[i]) productlist.splice(i,1);
		}
	}
	// sort the arrays
	productlist.sort();
	skulist.sort();
	// set the fields from the calling page to a comma-separated list
    theForm.productlist.value = productlist.join(",");
    theForm.skulist.value = skulist.join(",");
	theForm.nextpage.value = 3; // stay on product list page
	theForm.submit();
	if(document.getElementById('keepopen').checked != true)
    	window.close();
}

function MM_goToURL() { //v3.0
  var i, args=MM_goToURL.arguments; document.MM_returnValue = false;
  for (i=0; i<(args.length-1); i+=2) eval(args[i]+".location='"+args[i+1]+"'");
}

function toggleMode(mode) {
	if(mode == 'simple') {
		document.getElementById('simple').style.display='block';
		document.getElementById('advanced').style.display='none';
		document.getElementById('productids').innerHTML = '';
	}else{
		document.getElementById('advanced').style.display='block';
		document.getElementById('simple').style.display='none';
		document.getElementById('find').value = '';
	}
}

function toggleSkus(e){
	element = document.getElementById(e).style;
	element.display == "" ? element.display = "none" : element.display="";
}

var collapsed = false;
function toggleAll(e){
	var allElements = document.getElementsByTagName("tr");
	for(var i=0; i<allElements.length; i++) {
		if(allElements[i].className == "collapsed") {
			element = allElements[i].style;
			collapsed ? element.display = "" : element.display="none";
		}
	}
	collapsed = (!collapsed);
}
function selectAll(myForm,myBox,allOn){
	var countBoxes = eval("document."+myForm+"['"+myBox+"'].length");
	if(!countBoxes){
		eval("document."+myForm+"['"+myBox+"'].checked =  allOn");
	}
	else{
		for (var i=0; i<countBoxes ;i++){
			eval("document."+myForm+"['"+myBox+"'][" + i + "].checked =  allOn");
		}
	}
	eval("document."+myForm+"['all"+myBox+"'].checked =  allOn");
}

function toggleProduct(productid, checked) {
	if(!checked && !arrayFind(productid, removeProducts)) removeProducts.push(productid);
	var countBoxes = document.form2['productid'].length;
	if(!countBoxes){
		document.form2['productid'].checked = false;
		eval("document.form2['allskuid_" + productid + "'].checked = checked");
	}
	else{
		for (var i=0; i<countBoxes ;i++){
			if(document.form2['productid'][i].value == productid) {
				document.form2['productid'][i].checked = checked;
				eval("document.form2['allskuid_" + productid + "'].checked = checked");
			}
		}
	}
}

function arrayFind(element, array) {
	for(var i=0; i<array.length; i++) {
		if(array[i] == element) return true;
	}
	return false;
}

function addProducts() {
	var theform = document.getElementById('form2');
	var allElements = theform.getElementsByTagName('input')
	for(var i=0; i<allElements.length; i++) {
		if(allElements[i].checked == true && allElements[i].value != '') {	
			eval("self.opener.document.form1.attachment.value='"+filename+"'");  
  			if(!document.getElementById("keepopen").checked) window.close();	
		}
	}
}
//-->
</script>
</head>
<body onload="toggleMode('<cfoutput>#Url.searchMode#</cfoutput>');toggleAll();">
<div id="divProductSearch">
  <form action="<cfoutput>#request.thisPageQS#</cfoutput>" method="get" name="form1">
    <fieldset>
    <legend>Product Search</legend>
	
    <p>
      <label for="searchMode">Search Mode: </label>
      <label>
      <input name="searchMode" type="radio" class="formRadio" onclick="toggleMode('simple')" value="simple" <cfif (Url.searchMode EQ 'simple')>checked="checked"</cfif>/>
      Simple</label>
      <label>
      <input name="searchMode" type="radio" class="formRadio" onclick="toggleMode('advanced')" value="advanced" <cfif (Url.searchMode EQ 'advanced')>checked="checked"</cfif>/>
      Advanced</label>
      <br />
      <label for="showcolumns">Show Columns in Results:
      <input name="showcolumns" type="checkbox" class="formCheckbox" value="product_MerchantProductID" <cfif showColumn("product_MerchantProductID")> checked="checked"</cfif> />
      Product ID
      <input name="showcolumns" type="checkbox" class="formCheckbox" value="product_Name" <cfif showColumn("product_Name")> checked="checked"</cfif>/>
      Product Name
      <input name="showcolumns" type="checkbox" class="formCheckbox" value="prdctImage_FileName" <cfif showColumn("prdctImage_FileName")> checked="checked"</cfif>/>
      Product Thumbnail</label>
    </p>
    <div id="simple">
      <label for="Find">Find</label>
      <input name="find" type="text" id="find" value="<cfoutput>#Url.find#</cfoutput>">
      <label for="searchBy">by</label>
      <select name="searchBy" id="searchBy">
        <option value="prodID" <cfif Url.searchBy EQ "prodID"> selected="selected"</cfif>>ID</option>
        <option value="prodName" <cfif Url.searchBy EQ "prodName">selected="selected"</cfif>>Name</option>
      </select>
      <label for="matchType">match</label>
      <select name="matchType" id="matchType">
        <option value="anyMatch" <cfif Url.matchType EQ "anyMatch">selected="selected"</cfif>>Any</option>
        <option value="exactMatch" <cfif Url.matchType EQ "exactMatch">selected="selected"</cfif>>Exact</option>
      </select>
    </div>
    <div id="advanced" style="display:none"> Enter a comma separated list of Product IDs  below. <br />
      <textarea name="productids" cols="50" rows="5" id="productids"><cfoutput>#Url.productids#</cfoutput></textarea>
    </div>
    <input name="Search" type="submit" class="formButton" id="Search" value="Search" style="margin-bottom: 2px;" />
    </p>
    </fieldset>
  </form>
</div>
<div id="searchResults">
<form name="form2">
  <p>Search Results - <cfoutput>#rsCWProductsSearch.RecordCount#</cfoutput> Match<cfif rsCWProductsSearch.RecordCount NEQ 1>es</cfif></p>
  <cfif(rsCWProductsSearch.RecordCount NEQ 0)>
  <table width="100%" class="tabularData">
    <caption>
    Click the  Show SKUs icon (<img src="assets/images/viewskus.gif" alt="" width="15" height="15" align="absmiddle" />) to view all available SKUs.
    </caption>
    <tr class="tabularData">
      <th>
        <input name="allproductid" type="checkbox" class="formCheckbox" onclick="selectAll('form2','productid',this.checked)" value=""/>
      </th>
      <th><img src="assets/images/viewskus.gif" alt="" width="15" height="15" onclick="toggleAll()"/></th>
      <cfif showColumn("product_MerchantProductID")>
      <th nowrap="nowrap">Product ID</th>
      </cfif>
      <cfif showColumn("product_Name")>
      <th nowrap="nowrap">Product Name</th>
      </cfif>
      <cfif showColumn("prdctImage_FileName")>
      <th nowrap="nowrap">Product Thumb</th>
      </cfif>
    </tr>
	<cfset RowsOutput = 0>
    <cfoutput query="rsCWProductsSearch">
    <tr class="#cwAltRows(RowsOutput)#">
      <td align="center" style="width:5%">
        <input name="productid" type="checkbox" 
		  value="#rsCWProductsSearch.product_ID#" 
		  onclick="selectAll('form2','skuid_#rsCWProductsSearch.product_ID#',this.checked)" class="productid"/>
      </td>
      <td align="center" style="width:5%;"><img src="assets/images/viewskus.gif" alt="" width="15" height="15" 
	  onclick="toggleSkus('skus_#RowsOutput#')"/></td>
      <cfif showColumn("product_MerchantProductID")>
      <td nowrap="nowrap">#rsCWProductsSearch.product_MerchantProductID#</td>
      </cfif>
      <cfif showColumn("product_Name")>
      <td>#rsCWProductsSearch.product_Name#</td>
      </cfif>
      <cfif showColumn("prdctImage_FileName")>
      <td>
	  	<cfset ImageTag = cwDisplayImage(rsCWProductsSearch.product_ID, 1, rsCWProductsSearch.product_Name, "")>
		<cfif ImageTag NEQ "">
		#ImageTag#
		</cfif>
      </td>
      </cfif>
    </tr>
	

<cfset RowsOutput2 = 0>
<!--- Get SKU Data --->
<cfquery name="rsCWGetSKUs" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
SELECT SKU_ID, SKU_MerchSKUID, 
SKU_ProductID, SKU_Price
FROM tbl_skus 
WHERE SKU_ProductID = #rsCWProductsSearch.product_ID#
ORDER BY SKU_Sort
</cfquery>
<cfset CurrentProductID = rsCWProductsSearch.product_ID>
    <tr id="skus_#RowsOutput#" class="collapsed">
      <td>&nbsp;</td>
      <td colspan="#ListLen(Url.showcolumns)+1#" class="skus">
        <table style="width:100%">
          <tr>
            <th>
              <input name="allskuid_#CurrentProductID#" type="checkbox" class="formCheckbox" id="allskuid_#CurrentProductID#" 
				onclick="selectAll('form2','skuid_#CurrentProductID#',this.checked);
				toggleProduct(#CurrentProductID#,this.checked)" value=""/>
            </th>
            <th>Sku ID</th>
          </tr>
          <cfloop query="rsCWGetSKUs">
          <tr class="#RowsOutput2#">
            <td align="center" style="width:5%">
              <input name="skuid_#CurrentProductID#" id="skuid_#CurrentProductID#" 
				type="checkbox" class="skuid" value="#rsCWGetSKUs.SKU_ID#" onclick="toggleProduct(#CurrentProductID#,false)"/>
            </td>
            <td>#rsCWGetSKUs.SKU_MerchSKUID#
              <div class="skuOptions">
                <cfquery name="rsCWGetOptions" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
				SELECT OT.optiontype_Name, SO.option_Name
				FROM (tbl_list_optiontypes OT
				INNER JOIN tbl_skuoptions SO
				ON OT.optiontype_ID = SO.option_Type_ID) 
				INNER JOIN tbl_skuoption_rel SR
				ON SO.option_ID = SR.optn_rel_Option_ID
				WHERE SR.optn_rel_SKU_ID = #rsCWGetSKUs.SKU_ID#
				ORDER BY OT.optiontype_Name, SO.option_Sort
				</cfquery>
			
			<!--- Output the individual sku options --->
			<cfloop query="rsCWGetOptions">
                <strong style="margin-left: 10px;">#rsCWGetOptions.optiontype_Name#</strong>: #rsCWGetOptions.option_Name#<br />
                </cfloop>
              </div>
            </td>
          </tr>
          <cfset RowsOutput2 = RowsOutput2 + 1>
		</cfloop>
        </table>
      </td>
    </tr>
	<cfset RowsOutput = RowsOutput + 1>
	</cfoutput>
  </table>
  <p>

    <input name="addproducts" type="button" 
	  class="formButton" 
	  id="addproducts" 
	  style="margin-bottom: 2px;" 
	  onclick="cwAddProducts()" value="Add Selected Items" />
  </p>
  <p>
    <label>
    <input name="keepopen" type="checkbox" class="formCheckbox" id="keepopen" value="0" />
    Keep this window open after adding checked items?</label>
  </p>
  </cfif>
</form>
</body>
</html>

