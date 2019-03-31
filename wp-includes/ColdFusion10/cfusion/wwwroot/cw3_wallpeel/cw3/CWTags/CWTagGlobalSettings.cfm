<cfsilent>
<!---
================================================================
Application Info: Cartweaver© 2002 - 2007, All Rights Reserved.
Developer Info: Application Dynamics Inc.
                1560 NE 10th
                East Wenatchee, WA 98802
Support Info: http://www.cartweaver.com/go/cfhelp

Cartweaver Version: 3.0.14  -  Date: 08/07/2009
================================================================
Name: CWTagGlobalSettings.cfm
Description:
	Sets all of the global variables used throughout the
	cartweaver application, including DSNs and
	company information. This Custom Tag is called from the
	Application.cfm file via a <cfmodule> tag.
================================================================
--->
<cfset request.VersionNumber = "3.0.14">
<cfif Not IsDefined("cwAltRows") OR Not IsCustomFunction(cwAltRows)>
	<cfinclude template="CWIncFunctions.cfm" />
</cfif>
<!--- ..................................................................... --->
<!--- Set Default attributes --->

<!--- When someone clicks a "ViewCart" link they will be taken to this page.
      Default file name is ShowCart.cfm --->
<cfparam name="attributes.goToCart" default="ShowCart.cfm">
<!--- When someone clicks "CheckOut" on the Show Cart page they will be taken to this page.
      Default file name is OrderForm.cfm --->
<cfparam name="attributes.checkout" default="OrderForm.cfm">
<!--- After an order is placed/submited they will be taken to this Confirmation page.
      Default file name is Confirmation.cfm --->
<cfparam name="attributes.confirmOrder" default="Confirmation.cfm">
<!--- When someone Searches for a product they will be taken to this page.
      Default file name is Results.cfm --->
<cfparam name="attributes.results" default="Results.cfm">
<!--- When someone links from Search Results to Display Product Details they will be taken to this page.
      Default file name is Details.cfm --->
<cfparam name="attributes.details" default="Details.cfm">
<!--- Set the number of records we want to show at a time on the Search Results page--->
<cfparam name="attributes.recordsAtATime" default="10">
<!--- [ OnSubmitAction ]
  Set what to do after adding the item to the cart.
  The Choices are "GoTo" and "Confirm" ...
  "GoTo" will take us to the "request.targetGoToCart"
  "Confirm" will display a confirmation - This is the Default.
 --->
<cfparam name="attributes.onSubmitAction" default="Confirm">
<!--- // Set "Location" for currency and date formatting  //  --->
<!--- Here are some of your choices:
	  English(Australian), English(Canadian), English (New Zealand), English(UK), English(US),
	  French(Belgian), French(Canadian), French (Standard), French(Swiss),
	  German(Austrian), German (Standard), German (Swiss),
	  Italian(Standard), Italian(Swiss),
	  Japanese, Korean,
	  Norwegian (Bokmal), Norwegian (Nynorsk),
	  Portuguese(Brazilian), Portuguese(Standard),
	  Spanish(Standard), Spanish(Modern), Swedish  --->
<cfparam name="attributes.cwLocale" default="English (US)">
<!--- Now we set out Data Source Name for the application. After setting it
	  here, to edit you recordsets in DWMX, go to the "Bindings Panel, choose
	  choose "Data Source Name Variable", put "request.dsn" as value and select
	  "myDsn" from the Data Source's drop down menu.  --->
<cfparam name="attributes.dataSource" default="">
<cfparam name="attributes.dataSourceUsername" default="">
<cfparam name="attributes.dataSourcePassword" default="">

<!--- Set URLs for the store pages. The websiteSSLURL variable determines where
		secure pages should be loaded. These should be absolute paths, including the
		trailing slash. --->
<cfparam name="attributes.websiteURL" default="">
<cfparam name="attributes.websiteSSLURL" default="#attributes.websiteURL#">

<!--- Application.Variable Settings ........................................... --->
<!--- This is the mail server your application will use to send emails. --->
<cfparam name="attributes.mailServer" default="localhost">
<!--- These two parameters determine the type of payment processing to handle, and
      the filename for the custom tag that will handle the processing.
	  Set both to NONE for testing purposes. --->
<cfparam name="attributes.paymentAuthType" default="NONE">
<cfparam name="attributes.paymentAuthName" default="NONE">
<!--- Debug password --->
<cfparam name="attributes.debugPassword" default="test">
<!--- ..................................................................... --->

<cfparam name="URL.cart" default="">
<cfparam name="Client.CartID" default="#URL.cart#">
<cfif Val(url.cart) NEQ 0>
	<cfset Client.CartID = val(url.cart) />
<cfelseif Val(Client.CartID) EQ 0>
	<cfset Client.CartID = Client.CFID + RandRange(1000000,5000000)>
</cfif>

<!--- Now process all attributes values into variables to be used by Cartweaver --->
<cfset request.targetGoToCart = attributes.GoToCart & "?cart=" & Client.CartID>
<cfset request.targetCheckOut = attributes.CheckOut & "?cart=" & Client.CartID>
<cfset request.targetConfirmOrder = attributes.ConfirmOrder>
<cfset request.targetResults = attributes.Results>
<cfset request.targetDetails = attributes.Details>
<cfset request.OnSubmitAction = attributes.onSubmitAction>
<cfset SetLocale("#attributes.cwLocale#")>
<cfset request.dsn = attributes.dataSource>
<cfset request.dsnUsername = attributes.DataSourceUsername>
<cfset request.dsnPassword = attributes.DataSourcePassword>
<cfset request.PaymentAuthType = attributes.PaymentAuthType>
<cfset request.PaymentAuthName = attributes.PaymentAuthName>

<cfset request.dateMask = cwDateFormat("mask")>
<cfset request.dateValidate = cwDateFormat("validate")>

<!--- Clean up URL variables --->
<cfif Len(attributes.websiteSSLURL) NEQ 0 AND Right(attributes.websiteSSLURL,1) NEQ "/">
	<cfset attributes.websiteSSLURL = attributes.websiteSSLURL & "/">
</cfif>
<cfif Len(attributes.websiteURL) NEQ 0 AND Right(attributes.websiteURL,1) NEQ "/">
	<cfset attributes.websiteURL = attributes.websiteURL & "/">
</cfif>

<cfset request.websiteURL = attributes.websiteURL />
<cfset request.websiteSSLURL = attributes.websiteSSLURL />

<!--- Add the relevant SSL information to the target URLs --->
<cfif attributes.websiteSSLURL NEQ "">
	<cfif REFindNoCase("http[s]?\:\/\/",request.targetCheckOut) EQ 0>
		<cfset request.targetCheckOut = attributes.websiteSSLURL & request.targetCheckOut>
	</cfif>
	<cfif REFindNoCase("http[s]?\:\/\/",request.targetGoToCart) EQ 0>
		<cfset request.targetGoToCart = attributes.websiteSSLURL & request.targetGoToCart>
	</cfif>
	<cfif REFindNoCase("http[s]?\:\/\/",request.targetConfirmOrder) EQ 0>
		<cfset request.targetConfirmOrder = attributes.websiteSSLURL & request.targetConfirmOrder>
	</cfif>
</cfif>
<cfif attributes.websiteURL NEQ "">
	<cfif REFindNoCase("http[s]?\:\/\/",request.targetGoToCart) EQ 0>
		<cfset request.targetGoToCart = attributes.websiteURL & request.targetGoToCart>
	</cfif>
	<cfif REFindNoCase("http[s]?\:\/\/",request.targetResults) EQ 0>
		<cfset request.targetResults = attributes.websiteURL & request.targetResults>
	</cfif>
	<cfif REFindNoCase("http[s]?\:\/\/",request.targetDetails) EQ 0>
		<cfset request.targetDetails = attributes.websiteURL & request.targetDetails>
	</cfif>
</cfif>

<!--- [ request.ThisPage ] Set "request.ThisPage"  variable for application. "request.ThisPage" is used to
      create a link or form action that links back to the current file. --->
<cfset request.ThisPage = GetFileFromPath(GetTemplatePath())>
<!--- Add the query string --->
<cfif CGI.QUERY_STRING NEQ "">
	<cfset request.ThisPageQS = "#request.ThisPage#?#cgi.query_string#">
	<cfelse>
	<cfset request.ThisPageQS = request.ThisPage>
</cfif>


<!--- ..................................................................... --->
<!--- Set Store/Company information in Application Variables --->
<cflock type="exclusive" scope="application" timeout="10" throwontimeout="no">
	<cfparam name="URL.ResetApplication" default="">
<!--- If the companyname application variable isn't set or the user has
      requested to reset the application variables --->
	<cfif NOT IsDefined ('application.companyname') OR URL.ResetApplication EQ Attributes.DebugPassword>
		<!--- Clear the current application scope --->
		<cfset StructClear(Application) />
		<cftry>
			<cfscript>
			factory = CreateObject("JAVA","coldfusion.server.ServiceFactory");
			sqlexecutive = factory.getDataSourceService();
			datasources = sqlexecutive.datasources;
			dbType = Evaluate("datasources.#Request.DSN#.Driver");
			</cfscript>
			<cfif dbtype EQ "com.mysql.jdbc.Driver">
				<cfset dbtype = "MySQL">
			</cfif>
			<cfcatch>
			<p>There was a problem initializing the cart. Please set the database type manually in CWTagGlobalSettings.cfm.</p>
			<!--- If you have a host who disallows CreateObject, set the DBType manually in the following line ---->
			<cfset dbType = "MySQL" /><!--- Accepted types are: MSAccess,MSAccessJet,MSSQLServer,MySQL --->
			</cfcatch>
		</cftry>
		<cfswitch expression="#dbType#">
			<cfcase value="MSAccess,MSAccessJet,MSSQLServer,MySQL">
				<cfset Application.DBType = dbType>
			</cfcase>
			<cfdefaultcase>
				<cfset Application.DBType = "MySQL">
			</cfdefaultcase>
		</cfswitch>
		<cfset application.mailserver = attributes.MailServer>
		<!---
		Set the shipping calculation type preferance. Default is "localcalc"
		--->
		<cfset application.ShipCalcType = "localcalc">

		<!--- Get all configuration settings from the database --->
		<cfquery name="rsConfig" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
		SELECT config_variable, config_value FROM tbl_config
		</cfquery>

		<!--- Set all configuration options --->
		<cfloop query="rsConfig">
			<cfset Application[rsConfig.config_variable] = rsConfig.config_value />
		</cfloop>

		<!--- Declare variables for image display --->
		<cfset Application.SiteRoot = CGI.SCRIPT_NAME />
		<cfset Application.SiteRoot = Left(Application.SiteRoot,Len(Application.SiteRoot) - Len(ListLast(Application.SiteRoot,"/"))) />
		<!--- Remove /cw3/admin if application variables are reset in the admin --->
		<cfset Application.SiteRoot = ReplaceNoCase(Application.SiteRoot, "/cw3/admin", "") />
		<cfset Application.SiteRoot = ReplaceNoCase(Application.SiteRoot, "\cw3\admin", "") />


		<!--- Set the cartweaver version for support purposes --->
		<cfif Application.VersionNumber NEQ Request.VersionNumber>
			<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
			UPDATE tbl_config SET config_value = '#request.VersionNumber#'
			WHERE config_variable = 'VersionNumber'
			</cfquery>
			<cfset Application.VersionNumber = Request.VersionNumber>
		</cfif>
		<cfif Application.DeveloperEmail EQ ''>
			<cfset Application.DeveloperEmail = Application.CompanyEmail>
		</cfif>
		<!--- Set default country value --->
		<cfquery name="rsCWDefaultCountry" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
		SELECT country_id FROM tbl_list_countries WHERE country_DefaultCountry = 1
		</cfquery>


		<cfif rsCWDefaultCountry.recordCount GT 0>
			<cfset Application.DefaultCountryID = rsCWDefaultCountry.country_id>
		<cfelse>


			<cfset Application.DefaultCountryID = 0>
		</cfif>
	</cfif>
</cflock>

<cfparam name="Client.TaxStateID" default="0" />
<cfparam name="Client.TaxCountryID" default="#Application.DefaultCountryID#" />


<!--- Set up debugging preferences --->
<cfif IsDefined("Application.EnableDebugging") AND Application.EnableDebugging EQ true>
	<cfif Not IsDefined("Application.StorePassword")>
		<cfset Application.StorePassword = attributes.debugPassword>
	</cfif>
	<cfif NOT IsDefined("Session.Debug")>
		<cfset Session.Debug = False />
		<cfset Session.DebugStatus = "ON" />
	</cfif>

	<cfif IsDefined("URL.Debug")>
		<cfif URL.Debug EQ Application.StorePassword AND Session.Debug EQ False>
			<cfset Session.Debug = True />
			<cfset Session.DebugStatus = "OFF" />
		<cfelse>
			<cfset Session.Debug = False />
			<cfset Session.DebugStatus = "ON" />
		</cfif>
		<cflocation url="#Request.thisPage#?#cwKeepURL('debug')#" addtoken="no" />
	</cfif>

	<cfif not IsDefined("session.cwDebuggerItems")>
		<cfset session.cwDebuggerItems = ArrayNew(1)>
	</cfif>
<cfelse>
	<cfset Session.Debug = False />
	<cfset Session.DebugStatus = "ON" />
</cfif>
<!--- Added to clean numeric url vars --->
<cfloop list="prodid,category,secondary,skuid" index="i">
	<cfif IsDefined("form.#i#") and Not IsNumeric(form[i])>
		<cfset form[i] = val(form[i]) />
	</cfif>
	<cfif IsDefined("url.#i#") and Not IsNumeric(url[i])>
		<cfset url[i] = val(url[i]) />
	</cfif>
</cfloop>
<!--- If the user has chosen to logout, clear the client ID --->
<cfif IsDefined('URL.logout')>
	<cfset DeleteClientVariable("CustomerID")>
	<cfset DeleteClientVariable("CheckingOut")>
	<cfset DeleteClientVariable("TaxStateID")>
	<cfset DeleteClientVariable("TaxCountryID")>
	<cfset StructDelete(session, "availableDiscounts")>
	<cfset StructDelete(session, "currentDiscount")>
	<cfset StructDelete(session, "discountDescriptions")>
	<cflocation url="#request.ThisPage#" addtoken="no">
</cfif>

<!--- IF Custom error pages to be shown  --->
<cfif Application.EnableErrorHandling EQ "True">
	<!--- Set Custom error pages to be shown  --->
		<cferror type="request" template="../../CWErrorRequest.cfm" mailto="#application.developerEmail#">
		<cferror type="exception" template="../../CWErrorException.cfm" mailto="#application.developerEmail#">
</cfif>

<cfscript>
function cwDateFormat(retValue){
	//This function determines the locale-specific validate mode for <cfinput>s and masks for LSDateFormat
	//retValue:
	//	"mask": Returns a string representing the short date format for a date
	//	"validate": Returns either "date" or "eurodate" for use in the validate attribute of <cfinput> tags
	//	"array": Returns a 2 item array containing both the mask and the validate value

	var listEuroLocales = "Spanish (Modern),German (Swiss),Spanish (Standard),Dutch (Belgian),French (Swiss),Dutch (Standard),English (UK),Chinese (China),Norwegian (Bokmal),French (Standard),Portuguese (Standard),French (Belgian),English (Australian),German (Austrian),Italian (Standard),Spanish (Mexican),Portuguese (Brazilian),English (New Zealand),English (Canadian),Italian (Swiss),German (Standard),Norwegian (Nynorsk)";
	var mask = "mm/dd/yyyy";
	var validate = "date";
	if(ListFind(listEuroLocales,GetLocale())){
		mask = "dd/mm/yyyy";
		validate = "eurodate";
	}
	switch(retValue){
		case "mask": return mask; break;
		case "validate": return validate; break;
		default: return ListToArray("#mask#,#validate#");
	}
}
</cfscript>

<cfif NOT IsDefined("session.availableDiscounts")>
	<cfinclude template="CWIncDiscountFunctions.cfm">
	<cfset cwGetDiscounts()>
	<cfset session.currentDiscount = "">
</cfif>
<cfset request.showDiscount = false>
<cfset request.discountDescriptions = ArrayNew(1)>
<cfset request.discounts = "">
<cfset request.shippingDiscount = "">
<cfset request.promocodeApplied = false>

</cfsilent>