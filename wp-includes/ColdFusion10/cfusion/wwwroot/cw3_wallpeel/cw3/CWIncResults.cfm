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
		Name: CWIncResults.cfm
		Description: Displays all results from a search in a repeating
		table.
		================================================================
		--->
	<!--- ////////// [ START - Cartweaver Search Results Custom Tag Call ] ////////// --->
	<!--- All the search querys are contained in the CWTagSearchAction.cfm file --->
	<cfparam name="URL.category" default="0">
	<cfparam name="URL.secondary" default="0">
	<cfparam name="URL.keywords" default="">
	<cfparam name="URL.PageNum_Results" default="1">
	<cfif NOT IsNumeric(URL.PageNum_Results)>
		<cfset URL.PageNum_Results = 1 />
	</cfif>
	<cfif Not IsDefined("Application.PriceFormatString")>
		<cfset PriceFormatString = "@@beforeDiscountPrice@@ @@currentPrice@@ (@@priceWithTax@@ including @@tax@@% tax)" />
	<cfelse>
		<cfset PriceFormatString = Application.PriceFormatString />
	</cfif>
	<cfmodule template="CWTags/CWTagSearchAction.cfm"
		category="#URL.category#"
		secondary="#URL.secondary#"
		keywords="#URL.keywords#"
		startpage="#URL.PageNum_Results#"
		maxrows="6">
	<!--- ////////// [ END ] Cartweaver Search Results Custom Tag Call ] ////////// --->
	<!--- Variables for manipulating product images --->
	<cfparam name="ImagePath" default="">
	<cfparam name="ImageSRC" default="">
	<!--- Set defaults for paging --->
	<cfparam name="PagingCategory" default="">
	<cfparam name="PagingSecondary" default="">
	<cfparam name="PagingKeywords" default="">
	<cfset PagingCategory = "&amp;category=" & URL.category>
	<cfset PagingSecondary = "&amp;secondary=" & URL.secondary>
	<cfif URL.keywords NEQ "" AND URL.keywords NEQ "Enter Keywords">
		<cfset PagingKeywords = "&amp;keywords=" & URLEncodedFormat(URL.keywords)>
	</cfif>
	<cfset URLVars = PagingCategory & PagingSecondary & PagingKeywords>
	<!--- Columnar display variables --->
	<cfset NumberOfColumns = 3 />
	<cfset ColsOutput = 0 />
	<cfset RecordsOutput = 0 />
	<cfset RowsOutput = 0 />
	<cfset ColWidth = Fix(100/NumberOfColumns) />
	<!--- START -  Display Results --->
	<!--- //  Display number of matching records  // --->
</cfsilent>
<cfprocessingdirective suppresswhitespace="yes">
	<p>
		<strong>
			Total Search Results:
		</strong>
		[
		<cfoutput>
			#ResultCount#
		</cfoutput>
		]
	</p>
	<!--- RecordSet Paging --->
	<div class="col-lg-12">
		<cfmodule
			template="CWTags/CWTagPaging.cfm"
			AddlURLVars="#URLVars#"
			ResultsPerPage="6"
			TotalRecords="#ResultCount#"
			>
	</div>
	<!--- //  Display the following based on search results  // --->
	<cfif ResultCount IS 0>
		<p align="center">
			Sorry, no records that match your search criteria were found.
			<br />
			Please refine or change your search and try again.
		</p>
		<p align="center">
			<strong>
				Thank You!
			</strong>
		</p>
	<cfelse>
		<cfoutput>
			<cfdump var="#Results.RecordCount#">
			<cfloop query="Results">
				<cfset ImageSRC = cwGetImage(Results.product_ID, 1) />
				<div class="col-lg-4">
					<h1>
						#product_Name#
					</h1>
					<p>
						<cfif ImageSRC NEQ "">
							<a href="#request.targetDetails#?ProdID=#product_ID#&amp;category=#URL.category#">
								<img src="#ImageSRC#" alt="#product_Name#" border="0">
							</a>
							<br />
						</cfif>
						#Results.product_ShortDescription#
						<br />
						<!--- Get the current product tax rate if the merchant has elected to show prices including taxes --->
						<cfif Application.DisplayTaxOnProduct EQ "True">
							<cfset taxRate = cwGetTotalProductTaxRate(product_ID, Client.TaxStateID, Client.TaxCountryID) />
						<cfelse>
							<cfset taxRate = "" />
						</cfif>
						<cfmodule template="CWTags/CWTagPriceList.cfm"
							Product_ID="#Results.product_ID#"
							CurrentRecord="#Results.CurrentRow#"
							TaxRate="#taxRate#"
							ShowMax = "true"
							PriceFormat = "#PriceFormatString#">
						<br />
						<a href="#request.targetDetails#?ProdID=#product_ID#&amp;category=#URL.category#">
							More Info &raquo;
						</a>
					</p>
					</td>
				</div>
			</cfloop>
		</cfoutput>
	</cfif>
	<!--- END IF  - ResultCount IS 0 --->
	<!--- RecordSet Paging --->
	<div class="col-lg-12">
		<cfmodule
			template="CWTags/CWTagPaging.cfm"
			AddlURLVars="#URLVars#"
			ResultsPerPage="#Application.ResultsPerPage#"
			TotalRecords="#ResultCount#"
			>
	</div>
	<cfset cwDisplayDiscountDescriptions()>
</cfprocessingdirective>
