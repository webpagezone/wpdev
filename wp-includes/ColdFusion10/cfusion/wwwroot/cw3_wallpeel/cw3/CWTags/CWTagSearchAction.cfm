<!--- 
================================================================
Application Info: Cartweaver© 2002 - 2007, All Rights Reserved.
Developer Info: Application Dynamics Inc.
                1560 NE 10th
                East Wenatchee, WA 98802
Support Info: http://www.cartweaver.com/go/cfhelp
				
Cartweaver Version: 3.0.0  -  Date: 4/21/2007
==========================================================
Name: Cartweaver Search Action Custom Tag
Description: Provides search queries based on type of search.

Tag synax:
===========================================================
<cfmodule template="CWTags/CWTagSearchAction.cfm">
	
========================================================================================  --->


<!--- ------------------   START  Set Default Attributes  ----------------------------   --->
<cfparam name="Attributes.Category" default="0">
<cfparam name="Attributes.Secondary" default="0">
<cfparam name="Attributes.Keywords" default="">
<cfparam name="Attributes.StartPage" default="1" />
<cfparam name="Attributes.MaxRows" default="10" />
<!--- ------------------   END   Set Default Attributes  -----------------------------   --->
<!--- ================================================================================== --->

<cfif Attributes.Keywords IS "Enter Keywords">
	<cfset Attributes.Keywords = "">
</cfif>

<cfset Attributes.StartRow = (Attributes.StartPage * Attributes.MaxRows) - Attributes.MaxRows + 1 />
<cfset Attributes.EndRow = Attributes.StartRow + Attributes.MaxRows - 1 />

<!--- Check to make sure the category and secondary are valid numeric values --->
<cfif NOT IsNumeric(Attributes.Category)>
	<cfset Attributes.Category = 0 />
</cfif>

<cfif NOT IsNumeric(Attributes.Secondary)>
	<cfset Attributes.Secondary = 0 />
</cfif>

<cfquery name="rsGetResults" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
SELECT DISTINCT p.product_ID, p.product_Sort, p.product_Name 
FROM 
 <cfif Attributes.Secondary NEQ 0>(</cfif>
	(tbl_products p
	INNER JOIN tbl_skus s
	ON p.product_ID = s.SKU_ProductID) 
<cfif Attributes.Secondary NEQ 0>
	LEFT JOIN tbl_prdtscndcat_rel c
	ON p.product_ID = c.prdt_scnd_rel_Product_ID)
</cfif>
<cfif Attributes.category NEQ 0 AND Attributes.category NEQ "">
	LEFT JOIN tbl_prdtcat_rel pc
	ON p.product_ID = pc.prdt_cat_rel_Product_ID 
</cfif>
WHERE 
	p.product_OnWeb = 1
	AND p.product_Archive = 0
	<cfif application.allowbackorders EQ 0>
		AND s.SKU_Stock > 0
	</cfif>
	<cfif Attributes.Keywords NEQ "">
		AND (1=0
		<cfloop index="searchTerm" list="#Attributes.Keywords#">
			OR p.product_Name LIKE '%#searchTerm#%'
		</cfloop>
		<cfloop index="searchTerm" list="#Attributes.Keywords#">
			OR p.product_ShortDescription LIKE '%#searchTerm#%'
		</cfloop>
		<cfloop index="searchTerm" list="#Attributes.Keywords#">
			OR p.product_Description LIKE '%#searchTerm#%'
		</cfloop>
		)
	</cfif>
	<cfif Attributes.category NEQ 0 AND Attributes.category NEQ "">
		AND pc.prdt_cat_rel_Cat_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#Attributes.category#" />
	</cfif>
	<cfif Attributes.Secondary NEQ 0>
		AND c.prdt_scnd_rel_ScndCat_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#Attributes.Secondary#" />
	</cfif>
	AND s.SKU_ShowWeb = 1
	ORDER BY
		p.product_Sort, 
		p.product_Name
</cfquery>

<cfset Caller.ResultCount = rsGetResults.RecordCount>

<cfif rsGetResults.RecordCount NEQ 0>
	<!--- Slice out the records to return --->
	<cfset AllIDs = ValueList(rsGetResults.product_ID) />
	<cfset IDList = "" />
	<cfif Attributes.EndRow GT rsGetResults.RecordCount>
		<cfset Attributes.EndRow = rsGetResults.RecordCount />
	</cfif>
	<cfif Attributes.StartRow GT rsGetResults.RecordCount>
		<cfset Attributes.StartRow = Fix(rsGetResults.RecordCount/Attributes.MaxRows) * Attributes.MaxRows + 1 />
	</cfif>
	<cfloop from="#Attributes.StartRow#" to="#Attributes.EndRow#" index="index">
		<cfset IDList = ListAppend(IDList, ListGetAt(AllIDs, index)) />
	</cfloop>
	<cfif IDList EQ "">
		<cfset IDList = 0 />
	</cfif>
	<cfquery name="rsGetResults" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
	SELECT
		product_ID, 
		product_Name, 
		product_ShortDescription
	FROM
		tbl_products
	WHERE 
		product_ID IN (#IDList#)
	ORDER BY
		product_Sort, 
		product_Name
	</cfquery>
</cfif>
<!--- return query results to calling page --->
<cfset Caller.Results = rsGetResults>
