<!--- 
================================================================
Application Info: Cartweaver© 2002 - 2007, All Rights Reserved.
Developer Info: Application Dynamics Inc.
                1560 NE 10th
                East Wenatchee, WA 98802
Support Info: http://www.cartweaver.com/go/cfhelp
				
Cartweaver Version: 3.0.7  -  Date: 7/8/2007
================================================================
Name: CWDiscountQuery.cfm
Description: Executes query for DiscountDetails.cfm.
================================================================
--->

<cfsavecontent variable="selectAllJavascript">
<script type="text/javascript">
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
</script>
</cfsavecontent>
<cfhtmlhead text="#selectAllJavascript#">
<cfif productList & skuList NEQ "">
<cfif Application.DBType EQ "MSAccess" OR Application.DBType EQ "MSAccessJet">
<cfquery name="rsCWAffectedProductDisplay" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">

<cfif skuList NEQ "">
SELECT DISTINCTROW p.product_ID as product_ID, p.product_Name, p.product_MerchantProductID, 
s.SKU_MerchSKUID, s.SKU_ID as SKU_ID
FROM tbl_products p 
INNER JOIN tbl_skus s 
ON p.product_ID = s.SKU_ProductID 
WHERE s.SKU_ID IN (#skuList#)<cfif productList NEQ ""> AND s.SKU_ProductID NOT IN (#productList#)</cfif>
</cfif>
<cfif productList NEQ "" AND skuList NEQ "">
UNION </cfif>
<cfif productList NEQ "">
SELECT DISTINCTROW p.product_ID as product_ID, p.product_Name, p.product_MerchantProductID, 
'All SKUs' as SKU_MerchSKUID, 0 as SKU_ID
FROM tbl_products p 
INNER JOIN tbl_skus s 
ON p.product_ID = s.SKU_ProductID 
WHERE p.product_ID IN (#productList#) 
</cfif>
ORDER BY product_ID ASC, SKU_ID ASC
</cfquery>
<cfelse>
<cfif skuList EQ ""><cfset skuList = "0"></cfif>
<cfif productList EQ ""><cfset productList = "0"></cfif>
<cfquery name="rsCWAffectedProductDisplay" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
SELECT DISTINCT p.product_ID, 
p.product_Name, 
p.product_MerchantProductID,
CASE WHEN p.product_ID IN (#productList#) THEN 'All SKUs' ELSE 
s.SKU_MerchSKUID END as SKU_MerchSKUID,
CASE WHEN p.product_ID IN (#productList#) THEN 0 ELSE 
s.SKU_ID END as SKU_ID
FROM tbl_products p
INNER JOIN tbl_skus s
ON p.product_ID = s.SKU_ProductID
WHERE p.product_ID IN (#productList#) 
OR s.SKU_ID IN (#skuList#)
ORDER BY p.product_ID
</cfquery>
</cfif>
<cfelse>
	<cfparam name="rsCWAffectedProductDisplay.recordCount" default="0">
</cfif>

<cfif rsCWAffectedProductDisplay.recordCount GT 0>

<table>
  <caption>
   Products
  </caption>
    <tr class="tabularData">
      <th>Product ID</th>
      <th>Product Name<br />
        SKUs </th>
      <th>Active<br />
          <input type="checkbox" value="1" name="allarchiveProductID" id="allarchiveProductID" onclick="selectAll('formDiscounts','archiveProductID',this.checked)" class="formCheckbox" />
      </th>
      <th>Delete<br />
          <input type="checkbox" value="1" name="alldeleteProductID" id="alldeleteProductID" onclick="selectAll('formDiscounts','deleteProductID',this.checked)" class="formCheckbox" />
      </th>
    </tr>
	<cfset RowsOutput=0>
	<cfparam name="lastTFM_nest" default="">
	
	<cfoutput query="rsCWAffectedProductDisplay">
		<cfset AffectedProductID = 	rsCWAffectedProductDisplay.product_ID>
		<cfif rsCWAffectedProductDisplay.SKU_MerchSKUID NEQ "All SKUs">	
			<cfquery name="rsSkuCount" dbtype="query">
			SELECT COUNT(sku_id) as skus 
			FROM rsCWAffectedProductDisplay 
			WHERE product_ID = #rsCWAffectedProductDisplay.product_ID#
			</cfquery>
			<cfset skuRowSpan = rsSkuCount.skus + 1>
			
			<cfquery name="rsCWGetOptions" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
			SELECT SO.option_Name, OT.optiontype_Name
			FROM (tbl_list_optiontypes OT
			INNER JOIN tbl_skuoptions SO
			ON OT.optiontype_ID = SO.option_Type_ID) 
			INNER JOIN tbl_skuoption_rel SR
			ON SO.option_ID = SR.optn_rel_Option_ID
			WHERE SR.optn_rel_SKU_ID = #rsCWAffectedProductDisplay.SKU_ID#
			ORDER BY OT.optiontype_Name, 
			SO.option_Sort
			</cfquery>

	<cfset TFM_nest = AffectedProductID>
	<cfif lastTFM_nest NEQ TFM_nest>
		<cfset lastTFM_nest = TFM_nest>
	<tr class="#cwAltRows(RowsOutput)#">
		<td rowspan="#skuRowSpan#"><a href="javascript:;" onclick="cw_ShowProduct('formDiscounts','productlist','skulist', '#rsCWAffectedProductDisplay.product_MerchantProductID#')"><img title="Search For Product SKUs" height="15" alt="Search For Product SKUs" src="assets/images/viewskus.gif" width="15" /></a>#rsCWAffectedProductDisplay.product_MerchantProductID#</td>
		<td><div style="float: right;"><img src="assets/images/dark-inactive.gif" alt="Show SKU Options" name="imgShowSkus" width="11" height="11" id="imgShowSkus" onclick="showSKUdivs(this,'skuOptions#AffectedProductID#')"></div>#rsCWAffectedProductDisplay.product_Name#</td>
		<td>
		  <div align="center">
		    <input type="checkbox" value="#AffectedProductID#" name="archiveProductID" class="formCheckbox" />
		      </div>
		</td>
		<td>
		  <div align="center">
		    <input type="checkbox" value="#AffectedProductID#" name="deleteProductID" class="formCheckbox" />
		      </div>
		</td>
	</tr>
	</cfif>
	<tr>
		<td>
		#rsCWAffectedProductDisplay.SKU_MerchSKUID#<div style="display:none" class="skuOptions#AffectedProductID#">
		<cfloop query="rsCWGetOptions"><!--- Output the individual sku options --->			
                <strong style="margin-left: 10px;">#rsCWGetOptions.optiontype_Name#</strong>: #rsCWGetOptions.option_Name#<br />
                </cfloop><!--- End CW Repeat rsCWGetOptions --->
              </div></td>
		<td><div align="center">
		<input type="checkbox" value="#rsCWAffectedProductDisplay.SKU_ID#" name="archiveSkuID" class="formCheckbox" />
		</div>
		</td>
		<td><div align="center">
		<input type="checkbox" value="#rsCWAffectedProductDisplay.SKU_ID#" name="deleteSkuID" class="formCheckbox" />
		</div>
		</td>
	</tr>

<cfelse>
	<tr class="#cwAltRows(RowsOutput)#">
      <td><a href="javascript:;" onclick="cw_ShowProduct('formDiscounts','productlist','skulist', '#rsCWAffectedProductDisplay.product_MerchantProductID#')"><img title="Search For Product SKUs" height="15" alt="Search For Product SKUs" src="assets/images/viewskus.gif" width="15" /></a>#rsCWAffectedProductDisplay.product_MerchantProductID#</td>
      <td>#rsCWAffectedProductDisplay.product_Name#: #rsCWAffectedProductDisplay.SKU_MerchSKUID#</td>
      <td><div align="center">
        <input type="checkbox" value="#AffectedProductID#" name="archiveProductID" class="formCheckbox" />
		</div>
      </td>
      <td><div align="center">
        <input type="checkbox" value="#AffectedProductID#" name="deleteProductID" class="formCheckbox" />
		</div>
      </td>
    </tr>
	
	
	</cfif>
	<cfset RowsOutput = RowsOutput + 1>
</cfoutput>
</table>
</cfif> <!---END if rsCWAffectedProductDisplay.recordCount GT 0 --->
