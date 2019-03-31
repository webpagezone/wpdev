<cfsilent>
<!--- 
================================================================
Application Info: Cartweaver© 2002 - 2007, All Rights Reserved.
Developer Info: Application Dynamics Inc.
                1560 NE 10th
                East Wenatchee, WA 98802
Support Info: http://www.cartweaver.com/go/cfhelp
				
Cartweaver Version: 3.0.0  -  Date: 4/21/2007
================================================================
Name: Application.cfm
Description: This flie pulls the general settings from the main 
site Application file, then checks to see if the user is logged 
in corectly and ifso it sets the Admin spacific settings and variables.
================================================================
--->

<!--- Get general Application settings from site Application.cfm file --->
<cfinclude template="../../Application.cfm">

<!--- If Custom Error pages are to be displayed --->
<cfif Application.enableErrorHandling EQ "True">
  <!--- Set files to be called in case of an error --->   
	 <cferror type="request" template="CWErrorRequestAdmin.cfm" mailto="#application.developerEmail#">
	 <cferror type="exception" template="CWErrorExceptionAdmin.cfm" mailto="#application.developerEmail#">
</cfif>

<!--- Verify the user is logged in. --->
<cflock scope="Session" type="exclusive" timeout="5">
	<cfif request.ThisPage NEQ "index.cfm" AND NOT IsDefined("Session.LoggedIn")>
		<cfset strURL="#cgi.script_name#?#cgi.query_string#">
		<cfif Find("helpfiles",CGI.SCRIPT_NAME) NEQ 0>
			<cflocation url="../index.cfm?accessdenied=#URLEncodedFormat(strURL)#" addtoken="no">
		<cfelse>
			<cflocation url="index.cfm?accessdenied=#URLEncodedFormat(strURL)#" addtoken="no">
		</cfif>
	</cfif>
</cflock> 

<!--- Now Set Amin Specific Settings --->

<!--- 
Queries used in Navigation menu 
Since these queries are on all pages we can reuse them elsewhere in the admin 
by keeping them in the application.cfm. Load the navs if the application variables
are not defined, or if updates are made to the options menus or ship statuses.
--->
<!--- Options and Order Status Menu --->
<cfif NOT IsDefined("Application.OptionsMenu")>
	<cfquery datasource="#request.dsn#" name="rsOptionsNav" username="#request.dsnUsername#" password="#request.dsnPassword#">
	SELECT optiontype_ID, optiontype_Name
	FROM tbl_list_optiontypes
	ORDER BY optiontype_Name
	</cfquery>
	<cflock scope="application" type="exclusive" throwontimeout="no" timeout="5">
		<cfset Application.OptionsMenu = "">
		<cfloop query="rsOptionsNav">
			<cfset Application.OptionsMenu = Application.OptionsMenu & "<a href=""Options.cfm?optionID=" & rsOptionsNav.optiontype_ID & """>&##8211;" & rsOptionsNav.optiontype_Name & "</a>">
		</cfloop>
	</cflock>
</cfif>
<cfif NOT IsDefined("Application.ShipStatusMenu")>
	<cfquery datasource="#request.dsn#" name="rsShipStatusTypes" username="#request.dsnUsername#" password="#request.dsnPassword#">
	SELECT *
	FROM tbl_list_shipstatus
	ORDER BY shipstatus_Sort ASC
	</cfquery>
	<cflock scope="application" type="exclusive" throwontimeout="no" timeout="5">
		<cfset Application.ShipStatusMenu = "">
		<cfloop query="rsShipStatusTypes">
			<cfset Application.ShipStatusMenu = Application.ShipStatusMenu & "<a href=""Orders.cfm?SearchBy=" & rsShipStatusTypes.shipstatus_id & """>&##8211;" & rsShipStatusTypes.shipstatus_Name & "</a>">
		</cfloop>
	</cflock>
</cfif>

</cfsilent>