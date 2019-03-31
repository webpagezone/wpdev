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
Name: ListAdminUsers.cfm
Description: Administer users with access to admin section
================================================================
--->

<!--- Set location for highlighting in Nav Menu --->
<cfset strSelectNav = "Settings">

<!--- ADD Record --->
<cfif IsDefined("FORM.AddRecord")>
	<!--- Check to see if User is already in use --->
	<cfquery name="checkUsername" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
	SELECT * FROM tbl_adminusers 
	WHERE admin_Username = '#FORM.admin_Username#'	
	</cfquery>
	<!---  If not, enter record, if it is, generate error --->
	<cfif checkUsername.RecordCount IS "0">
		<cfif (Not IsDefined('Session.AccessLevel') OR Session.AccessLevel NEQ 'superadmin')
			AND Evaluate("FORM.admin_AccessLevel") EQ "superadmin">
			<cfset AdminUserError = "SuperAdmin is not an allowed access level">
		</cfif>
		<cfif not IsDefined("AdminUserError")>
			<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
			INSERT INTO tbl_adminusers (admin_User, admin_UserName, admin_Password, admin_AccessLevel) VALUES
			('#FORM.admin_User#', '#FORM.admin_UserName#', '#FORM.admin_Password#', '#FORM.admin_AccessLevel#')
			</cfquery>
		</cfif>
		<cflocation url="#request.ThisPage#" addtoken="no">
	<cfelse>
		<cfset AdminUserError = "User already exists, please choose another User Identification">
	</cfif>
</cfif>

<!--- Update all admin users --->
<cfif IsDefined("FORM.updateUsers")>
	<cfloop from="1" to="#FORM.userCount#" index="id">
		<!--- Update Records --->
		<cfif (Not IsDefined('Session.AccessLevel') OR Session.AccessLevel NEQ 'superadmin')
			AND Evaluate("FORM.admin_AccessLevel#id#") EQ "superadmin">
			<cfset AdminUserError = "SuperAdmin is not an allowed access level">
		</cfif>
		<cfif Not IsDefined("AdminUserError")>
			<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
			UPDATE tbl_adminusers SET 
			admin_Password = '#Evaluate("FORM.admin_Password#id#")#',
			admin_AccessLevel = '#Evaluate("FORM.admin_AccessLevel#id#")#'
			WHERE admin_UserID = #Evaluate("FORM.admin_UserID#id#")#
			</cfquery>
		</cfif>	
	</cfloop>
	<cfif not isdefined("AdminUserError")>
	<cflocation url="#request.ThisPage#" addtoken="no">
	</cfif>
</cfif>

<!--- DELETE Record --->
<cfif IsDefined("URL.DeleteRecord")>
	<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
	DELETE FROM tbl_adminusers WHERE admin_UserID=#URL.DeleteRecord#
	</cfquery>
	<cflocation url="#request.ThisPage#" addtoken="no">
</cfif>

<!--- Get Admin Records --->
<cfquery name="getAdminUsers" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
SELECT *
FROM tbl_adminusers
<cfif (Not IsDefined('Session.AccessLevel') OR Session.AccessLevel NEQ 'superadmin')>
WHERE admin_AccessLevel <> 'superadmin'
</cfif>
</cfquery>

<!--- Set default value for form fields, and fill it with previous data if form has posted --->
<cfparam name="frmUserName" default="">
<cfparam name="frmPassword" default="">
<cfparam name="frmAccessLevel" default="admin">
<cfif IsDefined ('AdminUserError') And IsDefined("form.admin_UserName")>
	<cfset frmUserName = FORM.admin_UserName>
	<cfset frmPassword = FORM.admin_Password>
	<cfset frmAccessLevel = FORM.admin_AccessLevel>
</cfif>
</cfsilent>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>CW Admin: Administrators</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="assets/admin.css" rel="stylesheet" type="text/css">
</head>
<body>

<!--- Include Admin Navigation Menu--->
<cfinclude template="CWIncNav.cfm">

<div id="divMainContent">
  <h1>Administrators</h1>
  <!---If there is an error, display it --->
  <cfif IsDefined ('AdminUserError')>
    <p><strong><cfoutput>#AdminUserError#</cfoutput></strong></p>
  </cfif>
  <table>
    <caption>
    Add User
    </caption>
    <cfform name="Add" method="POST" action="#request.ThisPage#">
      <tr>
        <th align="center">User</th>
        <th align="center">Username</th>
        <th align="center">Password</th>
        <th align="center">Access Level</th>
        <th align="center">Add</th>
      </tr>
      <tr class="altRowEven">
        <td>
          <cfinput type="text" name="admin_User" required="yes" message="User Required">
        </td>
        <td>
          <cfinput name="admin_UserName" type="text" value="#frmUserName#" required="yes" message="Username Required" size="10">
        </td>
        <td>
          <cfinput name="admin_Password" type="text" required="yes" value="#frmPassword#" message="Password Required" size="10">
        </td>
        <td>
          <cfinput name="admin_AccessLevel" type="text" required="yes" value="#frmAccessLevel#" message="Access Level Required" size="10">
        </td>
        <td align="center"><input name="AddRecord" type="submit" class="formButton" id="AddRecord" value="Add">
        </td>
      </tr>
    </cfform>
  </table>
	<cfform name="frmUpdate" action="#Request.ThisPage#" method="post">
	<table>
		<caption>
		Current Users
		</caption>
		<tr>
			<th align="center">User</th>
			<th align="center">Username</th>
			<th align="center">Password</th>
			<th align="center">Access Level</th>
			<th align="center">Delete</th>
		</tr>
		<cfset userCount = 0>
		<cfoutput query="getAdminUsers">
			<cfif getAdminUsers.admin_AccessLevel NEQ 'superadmin' OR (IsDefined('Session.AccessLevel') AND Session.AccessLevel EQ 'superadmin')>
			<cfset userCount = userCount + 1>
		<tr class="#IIF(CurrentRow MOD 2, DE('altRowEven'), DE('altRowOdd'))#">
			<td>#admin_User#</td>
			<td>#admin_UserName#</td>
			<td><cfinput name="admin_Password#userCount#" type="text" size="15" value="#admin_Password#" required="yes" message="A password is required for user #admin_User#"></td>
			<td><cfinput name="admin_AccessLevel#userCount#" type="text" size="15" value="#admin_AccessLevel#" required="yes" message="An access level is required for user #admin_User#"></td>
			<td align="center">
			<input type="hidden" name="admin_UserID#userCount#" value="#admin_UserID#" />
			<cfif getAdminUsers.RecordCount GT "1">
				<cfif admin_Username NEQ "sa">
				<a href="#request.ThisPage#?DeleteRecord=#admin_UserID#" onclick="return confirm('Are you SURE you want to DELETE this record?')"><img src="assets/images/delete.gif" alt="Delete this record" width="14" height="17"></a>
				<cfelse>
					<a href="javascript:;" onClick="return alert('Cannot DELETE sa User record!')"><img src="assets/images/delete-fade.gif" alt="Cannot delete sa admin user record" width="14" height="17"></a>
				</cfif>			
			<cfelse>
			<a href="javascript:;" onClick="return alert('Cannot DELETE Last Admin User record!')"><img src="assets/images/delete-fade.gif" alt="Cannot delete last admin user record" width="14" height="17"></a>
			</cfif>
			</td>
		</tr>
		</cfif>
		</cfoutput>
	</table>
	<input type="submit" name="updateUsers" value="Update Users" class="formButton" />
	<input type="hidden" name="userCount" value="<cfoutput>#userCount#</cfoutput>" />
	</cfform>
</div>
</body>
</html>