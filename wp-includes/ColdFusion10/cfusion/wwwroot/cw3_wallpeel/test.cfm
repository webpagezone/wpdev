<cfset returnURL = "https://" & CGI.SERVER_NAME & CGI.PATH_INFO & "?mode=return">

<cfdump var="#returnURL#">
<cfquery datasource="cw3_ds" name="test1" username="root" password="mysql">
			SELECT category_ID, category_Name
		FROM tbl_prdtcategories
		WHERE category_archive = 0
		ORDER BY category_sortorder, category_Name
		
</cfquery>

			<cfdump var="#test1#">