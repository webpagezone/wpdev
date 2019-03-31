<cfsilent>
<!---
==========================================================
Application: Cartweaver 4 ColdFusion
Copyright 2002 - 2013, All Rights Reserved
Developer: Application Dynamics Inc. | Cartweaver.com
Licensing: http://www.cartweaver.com/eula
Support: http://www.cartweaver.com/support
==========================================================
File: cw-auth-authorizenet.cfm
File Date: 2012-02-16
Description: Authorize.net payment processing.

NOTE: Setting up accounts and integrating with third party processors is not
a supported feature of Cartweaver. For information and support concerning
payment processors contact the appropriate processor tech support web site or
personnel. Cartweaver includes this integration code as a courtesy with no
guarantee or warranty expressed or implied. Payment processors may make changes
to their protocols or practices that may affect the code provided here.
If so, updates and modifications are the sole responsibility of the user.
================================================================
RETURN VARIABLES: paymenttransid, paymenttransresponse, paymentstatus
Values: Transaction ID, Gateway Response Message, Payment Status (approved|denied|none(no response))
These are returned to the containing page or template
in the request.trans scope, e.g. 'request.trans.paymentTransID'
API: http://developer.authorize.net/guides/AIM/
EXPLANATION OF FIELDS: http://developer.authorize.net/guides/AIM/Appendix_B/Appendix_B_Alphabetized_List_of_API_Fields.htm
 --->
<!--- /// CONFIGURATION / SETUP /// --->
<!--- CWauth Payment Configuration --->

<!--- USER SETTINGS  [ START ] ==================================================== --->
<!--- ============================================================================= --->
	<!--- AUTHORIZE.NET SETTINGS --->
		
		<!--- Enter API Login ID: --->
		<cfset settings.authNetLogin = "xxxxxxxxxxxx">
		
		<!--- Enter Transaction Key: --->
		<cfset settings.transactionKey = "xxxxxxxxxxxx">
		
		<!--- Test Mode - set to false for live transactions, or if using developer URL below: --->
		<cfset settings.testMode = "True">
		
		<!--- URL to Post To --->
			<!--- LIVE ACCOUNTS URL (use for standard authorize.net account in active OR test mode) --->
			<cfset settings.authurl = 'https://secure.authorize.net/gateway/transact.dll'>
			<!--- DEVELOPER URL (use for authorize.net developer accounts only) --->
			<!--- <cfset settings.authurl = 'https://test.authorize.net/gateway/transact.dll'> --->
		
		<!--- OPTIONAL PAYMENT METHOD VARIABLES --->
		<!--- method image: an optional logo url (relative or full url) associated with this payment option at checkout
			  e.g. /images/mylogo.jpg or https://www.example.com/images/mylogo.jpg
			  Note: be sure to use https prefix if linking to remote image  --->
		<cfset settings.methodImg = ''>
		<!--- shippay message: optional message shown to customer on shipping selection --->
		<cfset settings.methodSelectMessage = 'Pay with your credit card using Authorize.net'>
		<!--- submit message: optional message shown to customer before payment submission --->
		<cfset settings.methodSubmitMessage = 'Click to pay with Authorize.net'>
		<!--- confirm message: optional message shown to customer after order is approved --->
		<cfset settings.methodConfirmMessage = 'Transaction authorized'>
		<!--- send errors: email notice of processing issues (blank = disabled) --->
		<cfset settings.errorEmail = '#application.cw.developerEmail#'>
<!--- ============================================================================ --->
<!--- USER SETTINGS [ END ] ====================================================== --->

<!--- METHOD SETTINGS : do not change --->
		<!--- method name: the user-friendly name shown for this payment option at checkout --->
		<cfset settings.methodName = 'Authorize.net'>
		<!--- method type: processor (off-site processing), gateway (integrated credit card form) --->
		<cfset settings.methodType = 'gateway'>
		<!--- mail functions --->
		<cfif not isDefined('variables.CWsendMail')>
			<cfinclude template="../func/cw-func-mail.cfm">
		</cfif>
<!--- CONFIG DATA : These variables are returned to the calling page in the "CWauthMethod" scope --->
<!--- if called as a cfmodule in 'config mode', provide configuration data as a ColdFusion struct --->
<cfif isDefined('attributes.auth_mode') and attributes.auth_mode is 'config'>
	<!--- clear scope from previous file operations (in case of multiple payment methods in use) --->
	<cfset caller.CWauthMethod = structNew()>
	<cfset caller.CWauthMethod.methodName = settings.methodName>
	<cfset caller.CWauthMethod.methodType = settings.methodType>
	<cfset caller.CWauthMethod.methodImg = settings.methodImg>
	<cfset caller.CWauthMethod.methodSelectMessage = settings.methodSelectMessage>
	<cfset caller.CWauthMethod.methodSubmitMessage = settings.methodSubmitMessage>
	<cfset caller.CWauthMethod.methodConfirmMessage = settings.methodConfirmMessage>

<!--- PROCESS ORDER --->
<!--- if called as cfmodule in 'process' mode, process order --->
<cfelseif isDefined('attributes.auth_mode') and attributes.auth_mode is 'process'>
	<cfparam name="attributes.trans_data" default="">
	<!--- verify transaction data is ok --->
	<cfif not isStruct(attributes.trans_data)>
		<cfset request.trans.errorMessage = 'Payment Data Incomplete'>
	<!--- if data is ok, run processing --->
	<cfelse>
		<!--- simplify to 'tdata' struct --->
		<cfset tdata = attributes.trans_data>
		<!--- DEFAULTS FOR TRANSACTION DATA --->
		<!--- card data --->
		<cfparam name="tdata.cardtype" default="" type="string">
		<cfparam name="tdata.cardname" default="" type="string">
		<cfparam name="tdata.cardnumber" default="" type="numeric">
		<cfparam name="tdata.cardccv" default="" type="numeric">
		<cfparam name="tdata.cardexpm" default="" type="numeric">
		<cfparam name="tdata.cardexpy" default="" type="numeric">
		<!--- customer --->
		<cfparam name="tdata.customerid" default="" type="string">
		<cfparam name="tdata.customercompany" default="" type="string">
		<cfparam name="tdata.customeremail" default="" type="string">
		<cfparam name="tdata.customerphone" default="" type="string">
		<cfparam name="tdata.customeraddress1" default="" type="string">
		<cfparam name="tdata.customeraddress2" default="" type="string">
		<cfparam name="tdata.customercity" default="" type="string">
		<cfparam name="tdata.customerstate" default="" type="string">
		<cfparam name="tdata.customerzip" default="" type="string">
		<cfparam name="tdata.customercountry" default="" type="string">
		<!--- order/payment --->
		<cfparam name="tdata.orderid" default="" type="string">
		<cfparam name="tdata.paymentamount" default="0" type="numeric">
		<!--- shipping details --->
		<cfparam name="tdata.customershipcompany" default="" type="string">
		<cfparam name="tdata.customershipaddress1" default="" type="string">
		<cfparam name="tdata.customershipaddress2" default="" type="string">
		<cfparam name="tdata.customershipcity" default="" type="string">
		<cfparam name="tdata.customershipstate" default="" type="string">
		<cfparam name="tdata.customershipzip" default="" type="string">
		<cfparam name="tdata.customershipcountry" default="" type="string">
	<!--- PASS TRANSACTION TO GATEWAY --->
	<cftry>
   		<cfhttp url="#settings.authurl#" method="post">
			<!--- authorize.net form fields --->
			<cfhttpparam type="formField" name="x_login" value="#settings.authNetLogin#">
	   		<cfhttpparam type="formField" name="x_tran_key" value="#settings.transactionKey#">
			<cfhttpparam type="formField" name="x_test_request" value="#settings.testMode#">
			<cfhttpparam type="formField" name="x_version" value="3.0">
			<cfhttpparam type="formField" name="x_type" value="AUTH_CAPTURE">
			<cfhttpparam type="formField" name="x_method" value="CC">
			<cfhttpparam type="formfield" name="x_delim_data" value="TRUE">
			<cfhttpparam type="formfield" name="x_delim_char" value=",">
			<cfhttpparam type="formField" name="x_invoice_num" value="#tdata.orderid#">
			<cfhttpparam type="formField" name="x_relay_response" value="false">
			<!--- payment data --->
			<cfhttpparam type="formField" name="x_amount" value="#numberFormat(tdata.paymentamount,'999999999.99')#">
			<cfhttpparam type="formField" name="x_card_num" value="#tdata.cardnumber#">
			<cfhttpparam type="formField" name="x_exp_date" value="#tdata.cardexpm##tdata.cardexpy#">
			<cfhttpparam type="formField" name="x_card_code" value="#tdata.cardccv#">
			<!--- customer data --->
			<cfhttpparam type="formField" name="x_first_name" value="#listFirst(left(tdata.cardname,50),' ')#">
			<cfhttpparam type="formField" name="x_last_name" value="#listRest(left(tdata.cardname,50),' ')#">
			<cfhttpparam type="formField" name="x_company" value="#left(tdata.customercompany,50)#">
			<cfhttpparam type="formField" name="x_address" value="#left(tdata.customeraddress1,60)#">
			<cfhttpparam type="formField" name="x_city" value="#left(tdata.customercity,40)#">
			<cfhttpparam type="formField" name="x_state" value="#left(tdata.customerstate,40)#">
			<cfhttpparam type="formField" name="x_zip" value="#left(tdata.customerzip,20)#">
			<cfhttpparam type="formField" name="x_country" value="#left(tdata.customercountry,60)#">
			<cfhttpparam type="formField" name="x_phone" value="#left(tdata.customerphone,25)#">
			<cfhttpparam type="formField" name="x_email" value="#left(tdata.customeremail,255)#">
			<cfhttpparam type="formField" name="x_cust_id" value="#left(tdata.customerid,20)#">
			<cfhttpparam type="formField" name="x_customer_ip" value="#cgi.remote_addr#">
			<!--- shipping data --->
			<cfhttpparam type="formField" name="x_ship_to_company" value="#left(tdata.customershipcompany,50)#">
			<cfhttpparam type="formField" name="x_ship_to_address" value="#left(tdata.customershipaddress1,50)#">
			<cfhttpparam type="formField" name="x_ship_to_city" value="#left(tdata.customershipcity,50)#">
			<cfhttpparam type="formField" name="x_ship_to_state" value="#left(tdata.customershipstate,50)#">
			<cfhttpparam type="formField" name="x_ship_to_zip" value="#left(tdata.customershipzip,50)#">
			<cfhttpparam type="formField" name="x_ship_to_country" value="#left(tdata.customershipcountry,50)#">
		</cfhttp>
		<!--- PROCESS RESULT --->
        <cfset request.trans.httpResponse = cfhttp.fileContent>
		<cfset request.trans.paymenttransstatus = val(listFirst(cfhttp.fileContent))>
		<cfset request.trans.paymentTransID = listGetAt(cfhttp.filecontent,'7')>
		<cfset request.trans.paymentTransResponse = listGetAt(cfhttp.filecontent,'4')>
		<!--- transfer auth.net numeric status to our values (approved|denied|none)  --->
		<cfif request.trans.paymenttransstatus is 1>
			<cfset request.trans.paymentStatus = 'approved'>
		<cfelse>
			<cfset request.trans.paymentStatus = 'denied'>
			<cfset request.trans.errorMessage = listAppend(request.trans.errorMessage, request.trans.paymentTransResponse)>
		</cfif>
	<cfcatch>
       	<cfset request.trans.paymentStatus = 'denied'>
		<cfset request.trans.errorMessage = 'Data Error - Payment Not Processed'>
        <cfsavecontent variable="request.trans.errorTrace">
        <cfoutput>Error Details:#chr(13)#
		#cfcatch.Detail##chr(13)#
        #cfcatch.Message##chr(13)#
        Error Trace:#chr(13)#
        <cfloop from="1" to="#arrayLen(cfcatch.tagContext)#" index="i"><cfset tag = cfcatch.tagContext[i]>Error in file #tag.template#, line #tag.line##chr(13)#</cfloop>
		</cfoutput>
        </cfsavecontent>
	</cfcatch>
	</cftry>
<!--- IF ERRORS: notify admin of any errors --->
<cfif len(trim(request.trans.errorMessage))>
	<!--- list of values not included in email message --->
	<cfset secureVals = 'CARDNUMBER,CARDCCV,CARDEXPM,CARDEXPY,CARDNAME,CUSTOMER_CARDNAME,CUSTOMER_CARDNUMBER,CUSTOMER_CARDEXPM,CUSTOMER_CARDEXPY,CUSTOMER_CARDCCV'>
	<!--- set up mail content --->
	<cfsavecontent variable="mailContent">
	<cfoutput>
One or more problems were reported by Authorize.net
while attempting to process a transaction:#chr(13)#
<cfif isDefined('request.trans.paymentStatus') and request.trans.paymentStatus is 'approved'>
Authorize.net reported a payment with status 'approved', but other errors may have occurred.
<cfelseif isDefined('request.trans.paymentStatus')>
A status of '#request.trans.paymentstatus#' was reported while attempting to process a payment.
</cfif>
Details of the transaction are below.#chr(13)#
===#chr(13)#
Transaction Error Details:#chr(13)#
<cfloop list="#request.trans.errorMessage#" index="ee">#ee##chr(13)#</cfloop>
<cfif isDefined('request.trans.httpResponse')>===#chr(13)#
Auth.net Response:#chr(13)#
#request.trans.httpResponse#</cfif>
<cfif isDefined('request.trans.paymentTransResponse')>===#chr(13)#
Transaction Response:#chr(13)#
#request.trans.paymentTransResponse#</cfif>
===#chr(13)#
<cfif isDefined('tdata')>Transaction Data:
===#chr(13)#
<cfloop collection="#tdata#" item="colItem">#htmlEditFormat(colItem)#=<cfif not(listFindNoCase(secureVals,colItem))>#htmleditformat(tdata[colItem])#<cfelse>x</cfif>#chr(13)#</cfloop></cfif>
===#chr(13)#
Form Values:#chr(13)#
<cfloop collection="#form#" item="colItem">#htmlEditFormat(colItem)#=<cfif not(listFindNoCase(secureVals,colItem))>#htmleditformat(form[colItem])#<cfelse>x</cfif>#chr(13)#</cfloop>
===#chr(13)#
<cfif isDefined('request.trans.errorTrace')>Error Details:#chr(13)#
#request.trans.errorTrace#
</cfif>
Order: #request.trans.orderID##chr(13)#
Transaction ID:#request.trans.paymentTransID##chr(13)#
===#chr(13)#
Order Details:#chr(13)#
#CWtextOrderDetails(request.trans.orderID)#
	</cfoutput>
	</cfsavecontent>
	<!--- if enabled, send the error message to the site admin --->
	<cfif isDefined('settings.errorEmail') and isValid('email',settings.errorEmail)>
		<cfset confirmationResponse = CWsendMail(mailContent, 'Authorize.net Processing Error',settings.errorEmail)>
	</cfif>
</cfif>
<!--- /end if errors --->
    	<!--- CLEAR TRANSACTION DATA --->
		<cfset structClear(settings)>
		<cfset structClear(tdata)>
	</cfif>
	<!--- /end if transaction data is ok --->
<!--- /END PROCESS ORDER MODE --->
</cfif>
<!--- /END MODE SELECTION --->
</cfsilent>