<cfsilent>
	<!---
		================================================================
		Application Info: Cartweaver© 2002 - 2007, All Rights Reserved.
		Developer Info: Application Dynamics Inc.
		1560 NE 10th
		East Wenatchee, WA 98802
		Support Info: http://www.cartweaver.com/go/cfhelp
		Cartweaver Version: 3.0.6  -  Date: 5/21/2007
		================================================================
		Name: Cartweaver Search Custom Tag
		Description: Provides several choicees of search types.
		======================================================================================
		--->
	<!--- Default URL Variables for search selections --->
	<cfparam name="URL.keywords" default="">
	<cfparam name="URL.category" default="">
	<cfparam name="URL.secondary" default="0">
	<!--- Determines the type of search to display. Valid values are "Links" or "Form" --->
	<cfparam name="attributes.searchtype" default="Form">
	<!--- Variables for Links search types. --->
	<!--- The separator is placed between all category links --->
	<cfparam name="attributes.separator" default=" | ">
	<!--- This tag is placed before the currently selected category's link --->
	<cfparam name="attributes.selectedStart" default="<strong>">
	<!--- This tag is placed after the currently selected category's link --->
	<cfparam name="attributes.selectedEnd" default="</strong>">
	<!--- This is the label used for the All Cateogries link --->
	<cfparam name="attributes.allcategorieslabel" default="All">
	<!--- Variables for Form searches --->
	<!--- The formid is applied to the actual <form> tag for the search --->
	<cfparam name="attributes.formid" default="Search">
	<!--- "Yes" or "No", determines if a keyword field is displayed --->
	<cfparam name="attributes.keywords" default="No">
	<!--- This is the default text entered in the keyword search field --->
	<cfparam name="attributes.keywordslabel" default="#URL.keywords#">
	<!--- "Yes" or "No", determines if a category list is shown --->
	<cfparam name="attributes.category" default="No">
	<!--- This is the text for the first entry in the category list. It will display
		all categories --->
	<cfparam name="attributes.categorylabel" default="All categories">
	<!--- "Yes" or "No", determines if a secondary category list is shown --->
	<cfparam name="attributes.secondary" default="No">
	<!--- This is the text for the first entry in the category list. It will display
		all secondary categories --->
	<cfparam name="attributes.secondarylabel" default="All secondary categories">
	<!--- This is the text to be used for the search button --->
	<cfparam name="attributes.buttonlabel" default="Search">
	<!--- Set the default action page to the defined results page in application.cfm --->
	<cfparam name="attributes.actionpage" default="#request.targetResults#">
	<!--- If the form has been submitted and it's not the default text,
		then set the value for the keywordslabel to the submitted value --->
	<cfif URL.keywords NEQ "">
		<cfset attributes.keywordslabel = URL.keywords>
	</cfif>
	<!--- If no value was supplied for the buttonlabel, then set it to Search --->
	<cfif attributes.buttonlabel EQ "">
		<cfset attributes.buttonlabel = "Search">
	</cfif>
	<!--- Clean up &lt; and &gt;. We have to do this for Dreamweaver's sake... --->
	<cfset CWFindList = "&lt;,&gt;">
	<cfset CWReplaceList = "<,>">
	<cfset attributes.separator = ReplaceList(attributes.separator, CWFindList, CWReplaceList)>
	<cfset attributes.selectedStart = ReplaceList(attributes.selectedStart, CWFindList, CWReplaceList)>
	<cfset attributes.selectedEnd = ReplaceList(attributes.selectedEnd, CWFindList, CWReplaceList)>
	<!--- Set local flag for relating secondaries --->
	<cflock timeout="8" throwontimeout="no" type="exclusive" scope="application">
		<cfset RelateCategoriesSecondaries = false>
		<cfif Application.RelateCategoriesSecondaries EQ 1 And attributes.secondary EQ "Yes">
			<cfset RelateCategoriesSecondaries = true>
		</cfif>
	</cflock>
	<!--- If we're displaying links or the category search field, then get a category list --->
	<cfif attributes.searchtype EQ "Links" OR attributes.category EQ "Yes" OR  attributes.searchtype EQ "boot_list">
		<cfquery name="rsGetCategories" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
	  SELECT category_ID, category_Name
		FROM tbl_prdtcategories
		WHERE category_archive = 0
		ORDER BY category_sortorder, category_Name
	</cfquery>
	</cfif>
	<!--- If we're displaying secondary categories, then get a secondary category list --->
	<cfif attributes.secondary EQ "Yes">
		<cfif RelateCategoriesSecondaries>
			<cfquery name="rsSecondaryCategories" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
		SELECT DISTINCT c.category_Name, s.scndctgry_Name, c.category_ID, s.scndctgry_ID, c.category_Sortorder, s.scndctgry_Sort
		FROM tbl_prdtscndcats s
		INNER JOIN (tbl_prdtcategories c
		INNER JOIN (tbl_prdtcat_rel pr
		INNER JOIN tbl_prdtscndcat_rel sr
		ON pr.prdt_cat_rel_Product_ID = sr.prdt_scnd_rel_Product_ID)
		ON c.category_ID = pr.prdt_cat_rel_Cat_ID)
		ON s.scndctgry_ID = sr.prdt_scnd_rel_ScndCat_ID
		WHERE s.scndctgry_Archive = 0
		AND category_Archive = 0
		ORDER BY c.category_Sortorder, c.category_Name, s.scndctgry_Sort, s.scndctgry_Name
		</cfquery>
		<cfelse>
			<cfquery name="rsSecondaryCategories" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
		SELECT scndctgry_ID, scndctgry_Name
		FROM tbl_prdtscndcats
		WHERE scndctgry_Archive = 0
		ORDER BY scndctgry_Sort, scndctgry_Name
		</cfquery>
		</cfif>
	</cfif>
</cfsilent>
<cfprocessingdirective suppresswhitespace="yes">
	<!--- ///   BEGIN SEARCH TYPE SELECTION  ///  --->
	<cfswitch expression="#attributes.searchtype#">
		<!--- ///   SEARCH BY CATEGORY - TEXT LINKS  ///  --->
		<cfcase value="boot_list">
			<ul class="nav navbar-nav">
				<cfoutput >
					<cfloop query="rsGetCategories">
						<!--- <li class="dropdown">
							<a href="#attributes.actionpage#?category=#rsGetCategories.category_ID#"
							class="dropdown-toggle" data-toggle="dropdown">
							#rsGetCategories.category_Name#
							<!---<span class="caret"></span>--->
						</a> </li> --->
						<li >
							<a href="#attributes.actionpage#?category=#rsGetCategories.category_ID#">
								#rsGetCategories.category_Name#
								<!---<span class="caret"></span>--->
							</a>
						</li>
					</cfloop>
				</cfoutput>
			</ul>
		</cfcase>
		<cfcase value="Links">
			<cfoutput>
				<cfif attributes.allcategorieslabel NEQ "">
					<cfif URL.category EQ 0>
						#attributes.selectedStart#
					</cfif>
					<a href="#attributes.actionpage#?category=0">
						#attributes.allcategorieslabel#
					</a>
					<cfif URL.category EQ 0>
						#attributes.selectedEnd#
					</cfif>
				</cfif>
				<cfloop query="rsGetCategories">
					<cfif attributes.allcategorieslabel NEQ "" OR CurrentRow GT 1>
						#attributes.separator#
					</cfif>
					<cfif URL.category EQ rsGetCategories.category_ID>
						#attributes.selectedStart#
					</cfif>
					<a href="#attributes.actionpage#?category=#rsGetCategories.category_ID#">
						#rsGetCategories.category_Name#
					</a>
					<cfif URL.category EQ rsGetCategories.category_ID>
						#attributes.selectedEnd#
					</cfif>
				</cfloop>
			</cfoutput>
		</cfcase>
		<!--- SEARCH BY FORM --->
		<cfcase value="Form">
			<div id="search-div-top">
				<form name="<cfoutput>#attributes.formid#</cfoutput>"
					class="form-inline" role="form"
					id="<cfoutput>#attributes.formid#</cfoutput>" method="get"
					action="<cfoutput>#attributes.actionpage#</cfoutput>">
					<!--- keywords --->
					<cfif attributes.keywords EQ "Yes">
						<input name="keywords"
							class="form-control"
							id="<cfoutput>#attributes.formid#</cfoutput>-keywords"
							type="text"
							value="<cfoutput>#attributes.keywordslabel#</cfoutput>"
							onFocus="if(this.value == defaultValue){this.value=''}">
					</cfif>
					<cfif attributes.category EQ "Yes">
						<select name="category" id="
						<cfoutput>
							#attributes.formid#
						</cfoutput>
						-category"
						<cfif RelateCategoriesSecondaries>
							onchange="setChild(this, '
							<cfoutput>
								#attributes.formid#
							</cfoutput>
							-secondary','
							<cfoutput>
								#attributes.formid#
							</cfoutput>
							','
							<cfoutput>
								#attributes.secondarylabel#
							</cfoutput>
							');"
						</cfif>
						>
						<cfif attributes.categorylabel NEQ "">
							<option value="0">
								<cfoutput>
									#attributes.categorylabel#
								</cfoutput>
							</option>
						</cfif>
						<!--- //Populate Dropdown with results of rsGetCategories query // --->
						<cfoutput query="rsGetCategories">
							<option value="#rsGetCategories.category_ID#"
							<cfif (isDefined("URL.category") AND rsGetCategories.category_ID EQ URL.category)>
								selected="selected"
							</cfif>
							>#rsGetCategories.category_Name#</option>
						</cfoutput>
						</select>
					</cfif>
					<cfif attributes.secondary EQ "Yes">
						<select name="secondary" id="<cfoutput>#attributes.formid#</cfoutput>-secondary">
							<cfif attributes.secondarylabel NEQ "">
								<option value="0" selected="selected">
									<cfoutput>
										#attributes.secondarylabel#
									</cfoutput>
								</option>
							</cfif>
							<!--- //Populate Dropdown with results of rsSecondaryCategories query // --->
							<cfif not RelateCategoriesSecondaries>
								<cfoutput query="rsSecondaryCategories">
									<cfif rsSecondaryCategories.scndctgry_ID NEQ 1>
										<option value="#rsSecondaryCategories.scndctgry_ID#"
										<cfif (isDefined("URL.secondary") AND rsSecondaryCategories.scndctgry_ID EQ URL.secondary)>
											selected="selected"
										</cfif>
										>#rsSecondaryCategories.scndctgry_Name#</option>
									</cfif>
								</cfoutput>
							</cfif>
						</select>
					</cfif>
					<!---<input name="Submit" type="submit" class="formButton" value="<cfoutput>#attributes.buttonlabel#</cfoutput>"> --->
					<button name="Submit" type="submit"
						class="btn btn-default" title="<cfoutput>#attributes.buttonlabel#</cfoutput>"
						>
						<i class="fa fa-search">
						</i>
					</button>
				</form>
			</div>
			<cfif RelateCategoriesSecondaries AND Not IsDefined("Request.ProductCategoriesJS")>
				<cfsavecontent variable="Request.ProductCategoriesJS">
<script type="text/javascript">
function setChild (parent, childid, formid, label) {
	var objForm = document.getElementById(formid);
	var objChild = document.getElementById(childid);

   	objChild.disabled = false;
	objChild.options.length = 0;
	objChild.options[0] = new Option(label,"0", false, false);
	for (i = 0; i < ChildArray.length; i++) {
		if (ChildArray[i].category_ID == parent.value)
         objChild.options[objChild.options.length] = new Option(ChildArray[i].scndctgry_Name, ChildArray[i].scndctgry_ID,false,false);
	}
}

var ChildArray = new Array;
<cfset i=0>
<cfoutput query="rsSecondaryCategories">
ChildArray[#i#] = {scndctgry_ID: #scndctgry_ID#, scndctgry_Name: "#scndctgry_Name#", category_ID: #category_ID#};<cfset i=i+1></cfoutput>
</script>
</cfsavecontent>
				<cfhtmlhead text="#Request.ProductCategoriesJS#">
			</cfif>
			<cfif RelateCategoriesSecondaries>
				<cfoutput>
					<script type="text/javascript">setChild(document.getElementById('#attributes.formid#-category'), '#attributes.formid#-secondary','#attributes.formid#','#attributes.secondarylabel#');</script>
				</cfoutput>
			</cfif>
		</cfcase>
	</cfswitch>
</cfprocessingdirective>
