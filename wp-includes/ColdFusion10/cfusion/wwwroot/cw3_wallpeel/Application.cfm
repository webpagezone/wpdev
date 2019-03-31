<cfsilent><!---
================================================================
Application Info: Cartweaver© 2002 - 2007, All Rights Reserved.
Developer Info: Application Dynamics Inc.
                1560 NE 10th
                East Wenatchee, WA 98802
Support Info: http://www.cartweaver.com/go/cfhelp

Cartweaver Version: 3.0.0  -  Date: 4/21/2007
================================================================
Name: Application.cfm
Description:
	The application.cfm sets all of the global variables used
	throughout the cartweaver application, including DSNs and
	company information.
================================================================
--->
<cfinclude template="cw3/CWTags/CWIncFunctions.cfm">
<cfinclude template="cw3/CWTags/CWIncDiscountFunctions.cfm">
<!--- // Cartweaver uses Client.Variables so we need to enable them // --->
<cfapplication
   name = "cw3_wallpeel"
	clientmanagement="yes"
	sessionmanagement="yes"
	setclientcookies="yes"
	clientstorage="cookie"
	applicationtimeout="#CreateTimeSpan(0,0,20,0)#"
	>
		<cfmodule
	id = "CW3GlobalSettings"
	template = "cw3/CWTags/CWTagGlobalSettings.cfm"
datasource = "cw3_ds"
	datasourceusername = "cw3"
	datasourcepassword= "S@tmar00!"
	websiteURL = "http://localhost:8888/cw3/
	websiteSSLURL = ""
	onsubmitaction = "GoTo"
	results = "Results.cfm"
	details = "Details.cfm"
	gotocart = "ShowCart.cfm"
	checkout = "OrderForm.cfm"
	confirmorder = "Confirmation.cfm"
	cwlocale = "English (US)"
	mailserver = "localhost"
	paymentauthtype = "Processor"
	paymentauthname = "CWIncPayPal.cfm"
	debugPassword="go"
	>
	</cfsilent>
<!--- Call the Global Settings Custom Tag --->
<!---http://localhost:8500/cw3_wallpeel/--->
<!---<cfmodule
	id = "CW3GlobalSettings"
	template = "cw3/CWTags/CWTagGlobalSettings.cfm"
	datasource = "webpage1_cw3wpl_ds"
	datasourceusername = "webpage1_cw3wpl"
	datasourcepassword= "S@tmar00!"
	websiteURL = ""
	websiteSSLURL = ""
	onsubmitaction = "GoTo"
	results = "Results.cfm"
	details = "Details.cfm"
	gotocart = "ShowCart.cfm"
	checkout = "OrderForm.cfm"
	confirmorder = "Confirmation.cfm"
	cwlocale = "English (US)"
	mailserver = "localhost"
	paymentauthtype = "Processor"
	paymentauthname = "CWIncPayPal.cfm"
	debugPassword="go"
	>--->
	
