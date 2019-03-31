<cfsilent>
<!--- 
==========================================================
Application Info: Cartweaver© 2002 - 2007 All Rights Reserved.
Developer Info: Application Dynamics Inc.
				support@cartweaver.com
				1560 NE 10th
				East Wenatchee, WA 98802
				
Cartweaver Version: 3.0.7  -  Date: 7/8/2007
================================================================
Name: CWIncLoginForm.cfm
Description: This page allows the user to login from any page
	on the site.
================================================================
--->
<cfparam name="Client.CustomerID" default="0">
<cfif isdefined("form.fieldnames")>
	<cfloop list=#form.fieldnames# index="i">
		<cfset form[i] = makeHtmlSafe(form[i])>
	</cfloop>
</cfif>
<!--- If the Forgot Password form has been submitted, call the "find password" custom tag. --->
<cfif IsDefined ('FORM.forgotemailaddress')>
	<cfmodule template="CWTags/CWTagFindPassword.cfm" emailaddress="#FORM.forgotemailaddress#">
</cfif>
<!--- If the customer log in form has been submitted, try to find a match --->
<cfif IsDefined ('FORM.retcustomer')>
	<cfmodule template="CWTags/CWTagCustomerAction.cfm"
		action = "Login"
		username = "#FORM.username#"
		password = "#FORM.password#"
		redirect = "#request.ThisPage#"
		>
</cfif>
</cfsilent>
<cfif client.CustomerID EQ 0>
	<!--- ///////////// Get Customer Data //////////////////  --->
	<!--- get customer information --->
	<p>If you are a returning customer, please log in.</p>
	<cfif IsDefined('url.LoginError')>
		<p class="errorMessage"><cfoutput>#url.LoginError#</cfoutput></p>
	</cfif>
	<form name="login" method="post" action="<cfoutput>#request.ThisPage#</cfoutput>">
		<input name="retcustomer" type="hidden" value="yes">
		<table class="tabularData">
			<tr>
				<th align="right"><label for="username">Username:</label></th>
				<td class="altRowOdd"><input name="username" id="username" type="text">
				</td>
			</tr>
			<tr>
				<th align="right"><label for="password">Password:</label></th>
				<td class="altRowEven"><input name="password" id="password" type="password">
				</td>
			</tr>
		</table>
		<input name="Submit" type="submit" class="formButton" value="Log In">
	</form>
	<!--- Forgot Username and pass word form --->
	<!--- If the find password form has been submited and a match was found, display the "PWFound" message --->
	<cfif IsDefined ('request.PWFound')>
		<p><strong><cfoutput>#request.PWFound#</cfoutput></strong></p>
	</cfif>
	<!--- Display the Forgot Password form. --->
	<cfif NOT IsDefined ('request.PWFound')>
		<cfif IsDefined ('request.PWNotFound')>
			<!--- If the find password form has been submited and a match was NOT found, 
			      display the "PWNotFound" message --->
			<p class="errorMessage"><cfoutput>#request.PWNotFound#</cfoutput></p>
			<cfelse>
			<p>Did you forget your password?</p>
		</cfif>
		<!--- Forgotten password form --->
		<form action="<cfoutput>#request.ThisPage#</cfoutput>" method="post" name="getForgotPW">
			<table border="0" class="tabularData">
				<tr>
					<th align="right"><label for="forgotemailaddress">Email Address:</label></th>
					<td class="altRowOdd"><input name="forgotemailaddress" type="text" id="forgotemailaddress">
					</td>
				</tr>
			</table>
			<input name="forgot" type="submit" class="formButton" id="forgot" value="Send Password">
		</form>
	</cfif>
</cfif>
