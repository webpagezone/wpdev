<!--- 
================================================================
Application Info: Cartweaver© 2002 - 2007, All Rights Reserved.
Developer Info: Application Dynamics Inc.
                1560 NE 10th
                East Wenatchee, WA 98802
Support Info: http://www.cartweaver.com/go/cfhelp
				
Cartweaver Version: 3.0.0  -  Date: 4/21/2007
================================================================
Name: CWIncProductSearch.cfm
Description: Product Search form used on the product list and product details pages.
================================================================
--->

<cfparam name="URL.searchby" default="prodID">
<cfparam name="URL.matchtype" default="anyMatch">
<cfparam name="URL.find" default="">
<cfparam name="QueryFind" default="%">
<cfif URL.find NEQ "">
	<cfset QueryFind = URL.find>
</cfif>
<cfquery name="rsProductsSearch" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
SELECT 
	tbl_products.product_ID, 
	tbl_products.product_Name, 
	tbl_products.product_OnWeb, 
	tbl_products.product_MerchantProductID
FROM tbl_products 
WHERE 
	tbl_products.product_Archive = 0
  <cfif URL.searchBy EQ "prodID">
    AND tbl_products.product_MerchantProductID
    <cfelse>
    AND tbl_products.product_Name
  </cfif>
  <cfif URL.matchType EQ "exactMatch">
    = '#QueryFind#'
    <cfelse>
    LIKE '%#QueryFind#%'
  </cfif>
ORDER BY tbl_products.product_Name, tbl_products.product_MerchantProductID
</cfquery>

<form name="theForm" method="get" action="ProductActive.cfm">
	<label for="Find">Find</label>
	<input name="Find" type="text" id="Find" value="<cfoutput>#URL.Find#</cfoutput>">
	<label for="searchBy">by</label>
	<select name="searchBy" id="searchBy">
		<option value="prodID" <cfif URL.searchby EQ "prodID">selected</cfif>>ID</option>
		<option value="prodName" <cfif URL.searchby EQ "prodName">selected</cfif>>Name</option>
	</select>
	<label for="matchType">match</label>
	<select name="matchType" id="matchType">
		<option value="anyMatch" <cfif URL.matchType EQ "anyMatch">selected</cfif>>Any</option>
		<option value="exactMatch" <cfif URL.matchType EQ "exactMatch">selected</cfif>>Exact</option>
	</select>
	<input name="Search" type="submit" class="formButton" id="Search" value="Search" style="margin-bottom: 2px;">
</form>
<cfsilent>
<!--- Set Variables for recordset Paging  --->
<cfparam name="PageNum_Results" default="1">
<cfset MaxRows_Results=10>
<cfset StartRow_Results=Min((PageNum_Results-1)*MaxRows_Results+1,Max(rsProductsSearch.RecordCount,1))>
<cfset EndRow_Results=Min(StartRow_Results+MaxRows_Results-1,rsProductsSearch.RecordCount)>
<cfset TotalPages_Results=Ceiling(rsProductsSearch.RecordCount/MaxRows_Results)>
<cfset PagingURL = "&searchby=" & URL.searchby & "&matchtype=" & URL.matchtype & "&find=" & URL.find>

<cfsavecontent variable="PagingLinks">
<p class="pagingLinks">Page <cfoutput>#PageNum_Results#</cfoutput> of <cfoutput>#TotalPages_Results#</cfoutput><br />
<cfif PageNum_Results GT 1> 
<a href="<cfoutput>#request.ThisPage#?PageNum_Results=1&#PagingURL#</cfoutput>">First</a> | <a href="<cfoutput>#request.ThisPage#?PageNum_Results=#Max(DecrementValue(PageNum_Results),1)#</cfoutput><cfoutput>#PagingURL#</cfoutput>">Previous</a>  | 
<cfelse>
First | Previous |
</cfif> 
<cfif PageNum_Results LT TotalPages_Results> 
<a href="<cfoutput>#request.ThisPage#?PageNum_Results=#Min(IncrementValue(PageNum_Results),TotalPages_Results)#</cfoutput><cfoutput>#PagingURL#</cfoutput>">Next</a> | <a href="<cfoutput>#request.ThisPage#?PageNum_Results=#TotalPages_Results#</cfoutput><cfoutput>#PagingURL#</cfoutput>">Last</a> 
<cfelse>
Next | Last
</cfif> 
</p> 
</cfsavecontent>

</cfsilent>