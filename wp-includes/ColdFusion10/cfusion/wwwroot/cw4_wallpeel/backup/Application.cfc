<cfcomponent>
<!---
==========================================================
Application: Cartweaver 4 ColdFusion
Copyright 2002 - 2013, All Rights Reserved
Developer: Application Dynamics, Inc. | Cartweaver.com
Licensing: http://www.cartweaver.com/eula
Support: http://www.cartweaver.com/support
==========================================================
File: Application.cfc
File Date: 2012-02-01
Description: controls application variables and global functions
Note: includes global settings via cw-config.cfm
==========================================================
--->
<!--- //////////// --->
<!--- datasource connection values --->
<!--- NOTE: open cw-config.cfm to change site settings --->
<!--- //////////// --->
<cfinclude template="cw4/cwconfig/cw-config.cfm">

<!--- /////////////////////////////// --->
<!--- NO NEED TO EDIT BELOW THIS LINE --->
<!--- /////////////////////////////// --->

<!--- global application settings --->
<cfinclude template="cw4/cwapp/appcfc/cw-app-cfcstart.cfm">

<!--- // ---------- REQUEST START ---------- // --->
<cffunction name="onRequestStart">
	<!--- cartweaver inititalization --->
	<cfinclude template="cw4/cwapp/appcfc/cw-app-onrequeststart.cfm">
	<!--- error handling --->
	<cfif application.cw.debugHandleErrors is true>
		<!--- capture errors or exceptions --->
		<cferror type="exception" template="cw-error-exception.cfm" mailto="#application.cw.developerEmail#">
		<!--- if exception handler fails, this is shown --->
		<cferror type="request" template="cw-error-request.cfm" mailto="#application.cw.developerEmail#">
	</cfif>
</cffunction>
<!--- /END REQUEST START --->

<!--- // ---------- ERROR ---------- // --->
<cffunction name="onError" returntype="void" output="false">
		<cfargument name="exception" required="true">
		<cfargument name="eventName" type="string" required="true">
	<!--- throw back to <cferror> in request start --->
	<cfthrow object="#arguments.exception#">
</cffunction>
<!--- /END ERROR --->

</cfcomponent>