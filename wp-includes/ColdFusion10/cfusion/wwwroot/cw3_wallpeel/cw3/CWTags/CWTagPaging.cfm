<cfsetting enablecfoutputonly="yes" />
<cfparam name="Attributes.PagingURL" default="PageNum_Results" />
<cfparam name="URL.#Attributes.PagingURL#" default="1" />
<cfparam name="Attributes.CurrentPage" default="#URL[Attributes.PagingURL]#" />
<cfparam name="Attributes.PageName" default="#CGI.SCRIPT_NAME#" />
<cfparam name="Attributes.AddlURLVars" default="" />
<cfparam name="Attributes.ResultsPerPage" default="10" />
<cfparam name="Attributes.TotalRecords" default="0" />
<cfparam name="Attributes.ShowPageNumbers" default="true" />
<cfparam name="Attributes.ShowPrevNext" default="true" />
<cfparam name="Attributes.LinkDelimeter" default=" | " />
<cfparam name="Attributes.BeforeCurrentPage" default="<strong>" />
<cfparam name="Attributes.AfterCurrentPage" default="</strong>" />

<cfset TotalPages = Ceiling(Attributes.TotalRecords/Attributes.ResultsPerPage)>

<cfif ThisTag.ExecutionMode EQ "Start">
	<cfif TotalPages NEQ 0>
		<cfoutput><p class="pagingLinks"></cfoutput>
			<cfif Attributes.ShowPrevNext>
				<!--- Display Previous Link --->
				<cfif Attributes.CurrentPage GT 1> 
					<cfoutput><a href="#Attributes.PageName#?#Attributes.PagingURL#=#Max(DecrementValue(Attributes.CurrentPage),1)##Attributes.AddlURLVars#">&laquo; Previous</a>#Attributes.LinkDelimeter#</cfoutput>
				<cfelse>
					<cfoutput>&laquo; Previous#Attributes.LinkDelimeter#</cfoutput>
				</cfif>
			</cfif>
			<cfif Attributes.ShowPageNumbers>
				<!--- Loop through links to provided numbered navigation --->
				<cfloop from="1" to="#TotalPages#" index="PageNum">
					<cfif PageNum EQ Attributes.CurrentPage>
						<cfoutput>#Attributes.BeforeCurrentPage##PageNum##Attributes.AfterCurrentPage#</cfoutput>
					<cfelse>
						<cfoutput><a href="#Attributes.PageName#?#Attributes.PagingURL#=#PageNum##Attributes.AddlURLVars#">#PageNum#</a></cfoutput>
					</cfif>
					<cfif PageNum NEQ TotalPages OR (PageNum EQ TotalPages AND Attributes.ShowPrevNext)>
						<cfoutput>#Attributes.LinkDelimeter#</cfoutput>
					</cfif>
				</cfloop>
			</cfif>
			<cfif Attributes.ShowPrevNext>
				<!--- Display Next link --->
				<cfif Attributes.CurrentPage LT TotalPages> 
					<cfoutput><a href="#Attributes.PageName#?#Attributes.PagingURL#=#Min(IncrementValue(Attributes.CurrentPage),TotalPages)##Attributes.AddlURLVars#">Next &raquo;</a></cfoutput>
				<cfelse>
					<cfoutput>Next &raquo;</cfoutput>
				</cfif> 
			</cfif>
		<cfoutput></p></cfoutput>
	</cfif> 
</cfif>
<cfsetting enablecfoutputonly="no" />