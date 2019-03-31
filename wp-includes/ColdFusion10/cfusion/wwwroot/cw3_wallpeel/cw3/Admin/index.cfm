<!--- 
================================================================
Application Info: Cartweaver© 2002 - 2007, All Rights Reserved.
Developer Info: Application Dynamics Inc.
                1560 NE 10th
                East Wenatchee, WA 98802
Support Info: http://www.cartweaver.com/go/cfhelp
				
Cartweaver Version: 3.0.5  -  Date: 5/13/2007
================================================================
Name: index.cfm -
Description: Admin log on page
================================================================
--->
<cfsilent>
<cfquery name="getUsers" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
SELECT * FROM tbl_adminusers WHERE (admin_Username = 'admin' OR admin_Username = 'sa') and admin_Password = 'admin'
</cfquery>
<cfif IsDefined("FORM.adminUsername")>
  <!--- Query the database to see if the user is registered --->
  <cfquery name="getLogOn" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
  SELECT * FROM tbl_adminusers WHERE admin_UserName ='#FORM.adminUsername#'AND admin_Password ='#FORM.adminPassword#'
  </cfquery>
	<cfparam name="LastLogin" default="#getLogOn.admin_LoginDate#">
	
	<cfif (LastLogin IS "") OR (NOT IsDate(LastLogin))>
		<cfset LastLogin=CreateODBCDateTime("2002-01-01 01:00:00")>
	<cfelse>
		<cfset LastLogin=CreateODBCDateTime(LastLogin)>
	</cfif>

  <!--- Record found, login  --->
  <cfif getLogOn.RecordCount NEQ 0>
    <cflock timeout="5" throwontimeout="no" type="exclusive">
      <!--- Set the session vars --->
      <cfset Session.LoggedIn = 1>
      <!--- This session store the username --->
		<cfset Session.LoggedUser="#getLogOn.admin_UserName#">
		<cfset Session.LastLogin = LastLogin>
		<cfset Session.AccessLevel = getLogOn.admin_AccessLevel>
    </cflock>
    <!--- Store username inside a cookie if required --->
    <cfif isDefined("FORM.remember_me")>
      <cfcookie name="CWAdminUsername" value="#FORM.adminUsername#" expires="never">
      <!--- Else, clean any existing cookie --->
      <cfelse>
      <cfcookie name="CWAdminUsername" value="" expires="now">
    </cfif>
		<!--- Update user logon date --->
		<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
		UPDATE tbl_adminusers SET admin_LastLogin = #LastLogin#, admin_LoginDate = #CreateODBCDateTime(Now())# WHERE admin_UserName = '#Session.LoggedUser#'
		</cfquery>
    <!--- If the user requested a specific page, redirect there --->
    <cfif IsDefined("FORM.redirect_to")>
      <cflocation addtoken="no" url="#URLDecode(FORM.redirect_to)#">
      <cfelse>
      <cflocation addtoken="no" url="AdminHome.cfm">
    </cfif>
    <!--- Login failed --->
    <cfelse>
    <!--- Display an error message --->
    <cfset LogOnError="Log on unsuccessful. No match was found. Please try again or contact administrator.">
  </cfif>
</cfif>
<cfif not isdefined("cookie.CWAdminUsername")>
  <cfcookie name="CWAdminUsername" value="">
</cfif>
</cfsilent>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>CW Admin: Log In</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="assets/admin.css" rel="stylesheet" type="text/css">
</head>
<body onLoad="document.login.<cfif cookie.CWAdminUsername EQ "">adminUsername<cfelse>adminPassword</cfif>.focus();">
<div id="divMainContent" style="margin:20px;"> 
  <cfif IsDefined("LogOnError")> 
    <p><strong><cfoutput>#LogOnError#</cfoutput></strong></p> 
  </cfif>
<cfoutput>   
  <form action="#request.ThisPage#" method="post" name="login" id="login"> 
    <h1>Cartweaver&copy; Administration Log In</h1> 
    <table> 
      <tr> 
        <th align="right">Username:</th> 
		<td><input name="adminUsername" type="text" id="adminUsername" value="#cookie.CWAdminUsername#"> </td> 
      </tr> 
      <tr> 
        <th align="right">Password:</th> 
		<td><input name="adminPassword" type="password" id="adminPassword"> 
          <input name="remember_me" type="checkbox" class="formCheckbox" value="1"<cfif cookie.CWAdminUsername NEQ ""> checked</cfif>> 
          Remember me </td> 
      </tr> 
    </table> 
    <input name="Submit" type="submit" class="formButton" value="Log In"> 
    <!--- Store the path to the requested page inside an hidden field ---> 
    <cfif IsDefined("URL.accessdenied")> 
      <input type="hidden" name="redirect_to" value="#URLEncodedFormat(URL.accessdenied)#"> 
    </cfif> 
  </form> 
</cfoutput>
<cfif getUsers.recordCount GT 0>
<p>For testing use admin and admin.</p>
<p class="smallprint">Super admin use sa and admin. For security reasons, please <a href="ListAdminUsers.cfm">change login passwords</a>.</p>
</cfif>
</div> 
</body>
</html>