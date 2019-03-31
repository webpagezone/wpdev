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
Name: Find Password Custom Tag
Description: 
	This custom tag finds a customer's password based on their
	first name, last name and zip code. The results are sent to
	their email address on file.

Attributes:
	emailaddress: The email address to find the username and password. 
		The found username and password will be emailed to the same address.

Returns
	request.PWNotFound: If the email address is not found in the database, 
		this request variable will return an error message to the calling page.

	request.PWFound: If the email address is found in the database, this 
		request variable will return a confirmation message to the calling page.

================================================================
--->

<cfquery name="rsGetPw" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
SELECT cst_Email,cst_FirstName,cst_LastName,cst_Username,cst_Password
FROM tbl_customers
WHERE cst_Email = '#attributes.emailaddress#'
</cfquery>
<!--- If there is no matching record display an error --->
<cfif rsGetPw.RecordCount EQ 0>
	<cfset request.PWNotFound = "Sorry, no matching record was found. Please try again.">
	<cfelse>
	<!--- There is a valid record, send an email --->
	<cflock type="readonly" scope="application" timeout="5" throwontimeout="no">
		<cfset variables.mailserver = application.mailserver>
		<cfset variables.Company = application.companyname>
		<cfset variables.CompanyEmail = application.companyemail>
		<cfset variables.Address = application.companyaddress1>
		<cfset variables.City = application.companycity>
		<cfset variables.State = application.companystate>
		<cfset variables.Zip = application.companyzip>
		<cfset variables.Phone = application.companyphone>
	</cflock>
	
	<cfmail to="#rsGetPw.cst_FirstName# #rsGetPw.cst_LastName#<#rsGetPw.cst_Email#>"
		from="#variables.Company#<#variables.CompanyEmail#>"
		subject="Your #variables.Company# log on."
		server="#variables.mailserver#">
		Hello #rsGetPw.cst_FirstName# #rsGetPw.cst_LastName#,
		Here is your username and password...
		
		Username: #rsGetPw.cst_Username#
		Password: #rsGetPw.cst_Password#
		
		Thank you!
		
		Customer Support.
		#variables.Company#
		#variables.Address#
		#variables.City#, #variables.State# #variables.Zip#
		---
		#variables.Phone#
	</cfmail>
	<!--- Let the user know that the password has been found and sent --->	
	<cfset request.PWFound = "Your username and password have been sent to #rsGetPw.cst_Email#.<br />If this email address is no longer accessible you will need to contact customer service.">
</cfif>
</cfsilent>