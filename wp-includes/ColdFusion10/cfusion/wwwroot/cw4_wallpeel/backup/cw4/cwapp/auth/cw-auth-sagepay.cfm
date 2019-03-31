<cfsilent>
<!---
==========================================================
Application: Cartweaver 4 ColdFusion
Copyright 2002 - 2013, All Rights Reserved
Developer: Application Dynamics Inc. | Cartweaver.com
Licensing: http://www.cartweaver.com/eula
Support: http://www.cartweaver.com/support
==========================================================
File: cw-auth-sagepay.cfm
File Date: 2012-09-05
Description: SagePay payment processing

NOTE: Setting up accounts and integrating with third party processors is not
a supported feature of Cartweaver. For information and support concerning
payment processors contact the appropriate processor tech support web site or
personnel. Cartweaver includes this integration code as a courtesy with no
guarantee or warranty expressed or implied. Payment processors may make changes
to their protocols or practices that may affect the code provided here.
If so, updates and modifications are the sole responsibility of the user.

SAGEPAY OPTIONS are documented in the Form Protocol And Integration Guidelines from SagePay
SAGEPAY ENCODING FUNCTIONS courtesy CloudSpotting UK:
http://blog.cloudspotting.co.uk/2010/06/11/integrating-sage-pay-with-coldfusion/
================================================================
RETURN VARIABLES: paymenttransid, paymenttransresponse, paymentstatus
Values: Transaction ID, Gateway Response Message, Payment Status (approved|denied|none(no response))
These are returned to the containing page or template
in the request.trans scope, e.g. 'request.trans.paymenttransid'
--->

<!--- /// CONFIGURATION / SETUP /// --->
<!--- CWauth Payment Configuration --->

<!--- USER SETTINGS  [ START ] ==================================================== --->
<!--- ============================================================================= --->
	<!--- SAGEPAY SETTINGS --->
		<!--- Enter SagePay Vendor Name--->
		<cfset settings.sagepayVendorName = "xxxxxxxxxxxx">
		<!--- Enter Encryption Key --->
		<cfset settings.encryptionPassword = "xxxxxxxxxxxx">
		<!--- Select Transaction Mode (simulator|test| live) --->
		<cfset settings.transactionMode = 'test'>
		<!--- Enter SagePay Simulator Vendor Name (optional) --->
		<cfset settings.sagepaySimulatorVendorName = "xxxxxxxxxxxx">
		<!--- Enter SagePay Simulator Encryption Key (optional) --->
		<cfset settings.simulatorEncryptionPassword = "xxxxxxxxxxxx">
		<!--- Description of Transaction shown to customer on SagePay site --->
		<cfset settings.transactionDescription = application.cw.companyName & ' Purchase'>
		<!--- Send SagePay Transaction Emails (0 = none, 1 = customer & vendor, 2 = vendor only) --->
		<cfset settings.transactionEmail = '1'>
		<!--- Message to customer inserted into successful transaction emails --->
		<cfset settings.emailHeader = 'Thank you for your order. Contact #application.cw.companyName# at #application.cw.companyEmail# if you have any questions about this order.'>
		<!--- Select Currency (GBP|EUR|USD) --->
		<cfset settings.currency = 'GBP'>
		<!--- Auto Submit SagePay form (turn off for debugging form values) --->
		<cfset settings.autoSubmit = 'true'>
		<!--- SagePay AVS/CV2, default 0 (0|1|2|3) --->
		<cfset settings.AVSmode = '0'>
		<!--- SagePay 3DSecure, default 0 (0|1|2|3)--->
		<cfset settings.3DsecureMode = '0'>
		<!--- SagePay Simulator/Test/Live URLS --->
		<cfif settings.transactionMode is 'simulator'>
			<cfset settings.authURL = 'https://test.sagepay.com/Simulator/VSPFormGateway.asp'>
			<cfset settings.sagepayVendorName = settings.sagepaySimulatorVendorname>
			<cfset settings.encryptionPassword = settings.simulatorEncryptionPassword>
		<cfelseif settings.transactionMode is 'test'>
			<cfset settings.authURL = 'https://test.sagepay.com/gateway/service/vspform-register.vsp'>
		<cfelse>
			<cfset settings.authURL = 'https://live.sagepay.com/gateway/service/vspform-register.vsp'>
		</cfif>
	<!--- OPTIONAL PAYMENT METHOD VARIABLES --->
		<!--- method image: an optional logo url (relative or full url) associated with this payment option at checkout
			  e.g. /images/mylogo.jpg or https://www.example.com/images/mylogo.jpg
			  Note: be sure to use https prefix if linking to remote image  --->
		<cfset settings.methodImg = ''>
		<!--- shippay message: optional message shown to customer on shipping selection --->
		<cfset settings.methodSelectMessage = 'Pay with SagePay'>
		<!--- submit message: optional message shown to customer on final order submission --->
		<cfset settings.methodSubmitMessage = 'Click to pay with SagePay'>
		<!--- confirm message: optioal message shown to customer after order is approved --->
		<cfset settings.methodConfirmMessage = 'SagePay transaction complete'>
	<!--- SUBMIT TEXT --->
		<!--- submit button value --->
		<cfset settings.submitText = '&raquo;&nbsp;Click to Pay with SagePay'>
		<!--- processing/loading message --->
		<cfset settings.loadingText = 'Submitting to SagePay...'>
<!--- ============================================================================ --->
<!--- USER SETTINGS [ END ] ====================================================== --->

<!--- METHOD SETTINGS : do not change --->
	<!--- method name: the user-friendly name shown for this payment option at checkout --->
	<cfset settings.methodName = 'SagePay UK'>
	<!--- method type: processor (off-site processing), gateway (integrated credit card form) --->
	<cfset settings.methodType = 'processor'>
	<!--- key field: transaction variable specific to this payment method --->
	<cfset settings.methodTransKeyField = "url.crypt">
	<!--- notification URLs (callback transactions) --->
	<cfset settings.cancelURL = application.cw.appPageConfirmOrderUrl & '?mode=cancel'>
	<cfset settings.confirmURL = application.cw.appPageConfirmOrderUrl & '?mode=confirm'>
	<cfset settings.returnURL = application.cw.appPageConfirmOrderUrl & '?mode=return'>
	<!--- default processing values --->
	<cfparam name="form.fieldNames" default="">
	<!--- order functions --->
	<cfif not isDefined('variables.CWsaveOrder')>
		<cfinclude template="../func/cw-func-order.cfm">
	</cfif>
	<!--- mail functions --->
	<cfif not isDefined('variables.CWsendMail')>
		<cfinclude template="../func/cw-func-mail.cfm">
	</cfif>
	<!--- formatting functions --->
	<cfif not isDefined('variables.CWtime')>
		<cfinclude template="../func/cw-func-global.cfm">
	</cfif>
	<!--- clean up form and url variables --->
	<cfinclude template="../inc/cw-inc-sanitize.cfm">
	<!--- defaults for processing below --->
	<cfparam name="attributes.trans_data" default="">
	<cfparam name="attributes.auth_mode" default="">
	<cfparam name="request.trans.errormessage" default="">
	<!--- crypt functions for encryption/decryption of order data --->
	<cfif attributes.auth_mode is 'capture' OR attributes.auth_mode is 'process'>
	<cfscript>
	function simpleXor(crypt, key) {
	    var keyList = ArrayNew(1);
	    var output = "";
	    var result = "";
	    var i = "";
	    for(i = 1; i LTE Len(arguments.key); i=i+1)
	        keyList[i] = Asc(Mid(arguments.key, i, 1));
	    for(i = 0; i LTE  Len(arguments.crypt)-1; i=i+1){
	        result = (bitXor((Asc(Mid(arguments.crypt, i+1,1))),(keyList[(i MOD Len(arguments.key))+1])));
	        if (result eq 0)
	            output = output & URLDecode("%00");
	        else
	            output = output & Chr(result);
	    }
	    return output;
	}
	function base64Decode(scrambled) {
	   return toString(toBinary(Replace(arguments.scrambled," ","+","all")));;
	}
	</cfscript>
	</cfif>
</cfsilent>
<!--- CONFIG MODE --->
<!--- CONFIG DATA : Auth_Mode "config" --->
<!--- CONFIG MODE --->
<!--- if called as a cfmodule in 'config mode', provide configuration data as 'CWauthMethod' struct --->
<cfif isDefined('attributes.auth_mode') and attributes.auth_mode is 'config'>
	<!--- clear scope from previous file operations (in case of multiple payment methods in use) --->
	<cfset caller.CWauthMethod = structNew()>
	<!--- these values get parsed into application.cw.authMethodData (add more here to have them available sitewide) --->
	<cfset caller.CWauthMethod.methodName = settings.methodName>
	<cfset caller.CWauthMethod.methodType = settings.methodType>
	<cfset caller.CWauthMethod.methodImg = settings.methodImg>
	<cfset caller.CWauthMethod.methodSelectMessage = settings.methodSelectMessage>
	<cfset caller.CWauthMethod.methodSubmitMessage = settings.methodSubmitMessage>
	<cfset caller.CWauthMethod.methodConfirmMessage = settings.methodConfirmMessage>
	<cfset caller.CWauthMethod.methodTransKeyField = settings.methodTransKeyField>
<!--- CAPTURE MODE --->
<!--- CAPTURE MODE : Auth_Mode "capture" : Form for submission to off-site processor --->
<!--- CAPTURE MODE --->
<!--- if called as cfmodule in 'process' mode, process order --->
<cfelseif isDefined('attributes.auth_mode') and attributes.auth_mode is 'capture'>
	<!--- verify transaction data is ok --->
	<cfif not isStruct(attributes.trans_data)>
		<cfset request.trans.errorMessage = listAppend(request.trans.errorMessage,'Payment Data Incomplete')>
	<!--- if data is ok, run processing --->
	<cfelse>
		<!--- simplify to 'tdata' struct --->
		<cfset tdata = attributes.trans_data>
		<!--- defaults for transaction data --->
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
		<cfparam name="tdata.customershipcompany" default="" type="string">
		<cfparam name="tdata.customershipaddress1" default="" type="string">
		<cfparam name="tdata.customershipaddress2" default="" type="string">
		<cfparam name="tdata.customershipcity" default="" type="string">
		<cfparam name="tdata.customershipstate" default="" type="string">
		<cfparam name="tdata.customershipzip" default="" type="string">
		<cfparam name="tdata.customershipcountry" default="" type="string">
		<!--- order/payment --->
		<cfparam name="tdata.orderid" default="" type="string">
		<cfparam name="tdata.paymentamount" default="0" type="numeric">
		<!--- SagePay 'crypt' combines all data into a single field --->
		<cfset tdata.combined = 'VendorTxCode=' & tdata.orderID>
		<cfset tdata.combined = tdata.combined & '&Amount=' & trim(numberFormat(tdata.paymentamount,'_.__'))>
		<cfset tdata.combined = tdata.combined & '&Currency=' & settings.currency>
		<cfset tdata.combined = tdata.combined & '&Description=' & settings.transactionDescription>
		<cfset tdata.combined = tdata.combined & '&SuccessURL=' & settings.confirmURL>
		<cfset tdata.combined = tdata.combined & '&FailureURL=' & settings.cancelURL>
		<cfset tdata.combined = tdata.combined & '&CustomerName=' & tdata.customernamefirst & ' ' & tdata.customernamelast>
		<cfset tdata.combined = tdata.combined & '&CustomerEmail=' & tdata.customeremail>
		<cfset tdata.combined = tdata.combined & '&VendorEmail=' & application.cw.companyEmail>
		<cfset tdata.combined = tdata.combined & '&SendEmail=' & settings.transactionEmail>
		<cfset tdata.combined = tdata.combined & '&eMailMessage=' & settings.emailHeader>
		<cfset tdata.combined = tdata.combined & '&BillingSurname=' & tdata.customernamelast>
		<cfset tdata.combined = tdata.combined & '&BillingFirstNames=' & tdata.customernamefirst>
		<cfset tdata.combined = tdata.combined & '&BillingAddress1=' & tdata.customeraddress1>
		<cfset tdata.combined = tdata.combined & '&BillingAddress2=' & tdata.customeraddress2>
		<cfset tdata.combined = tdata.combined & '&BillingCity=' & tdata.customercity>
		<cfset tdata.combined = tdata.combined & '&BillingPostCode=' & tdata.customerzip>
		<cfset tdata.combined = tdata.combined & '&BillingCountry=' & tdata.customercountry>
		<!--- us orders must have state appended --->
		<cfif tdata.customercountry is 'US'>
			<cfset tdata.combined = tdata.combined & '&BillingState=' & tdata.customerstate>	
		</cfif>
		<cfset tdata.combined = tdata.combined & '&BillingPhone=' & tdata.customerphone>
		<cfset tdata.combined = tdata.combined & '&DeliverySurname=' & tdata.customernamelast>
		<cfset tdata.combined = tdata.combined & '&DeliveryFirstNames=' & tdata.customernamefirst>
		<cfset tdata.combined = tdata.combined & '&DeliveryAddress1=' & tdata.customershipaddress1>
		<cfset tdata.combined = tdata.combined & '&DeliveryAddress2=' & tdata.customershipaddress2>
		<cfset tdata.combined = tdata.combined & '&DeliveryCity=' & tdata.customershipcity>
		<cfset tdata.combined = tdata.combined & '&DeliveryPostCode=' & tdata.customershipzip>
		<cfset tdata.combined = tdata.combined & '&DeliveryCountry=' & tdata.customershipcountry>
		<cfset tdata.combined = tdata.combined & '&ApplyAVSCV2=' & settings.AVSmode>
		<cfset tdata.combined = tdata.combined & '&Apply3DSecure=' & settings.3DsecureMode>
		<cfset tdata.crypt = simpleXor(tdata.combined,settings.encryptionPassword)>
	</cfif>
	<!--- /end if data ok --->
	<!--- sagepay transaction form with hidden inputs --->
	<cfoutput>
		<form action="#trim(settings.authUrl)#" id="CWformSagePayProcess" method="post">
			<div>
				<input type="hidden" name="VPSProtocol" value="2.23">
				<input type="hidden" name="TxType" value="PAYMENT">
				<input type="hidden" name="Vendor" value="#settings.SagepayVendorName#">
				<input type="hidden" name="Crypt" value="#ToBase64(tdata.crypt)#">
			</div>
			<div>
				<!--- submit button --->
				<div class="center top40 bottom40">
				<input name="submit" id="sagepay_submit" type="submit" class="CWformButton" value="<cfoutput>#settings.submitText#</cfoutput>">
				<!--- submit link : javascript replaces button with this link --->
				<a style="display:none;" href="##" class="CWcheckoutLink" id="CWlinkAuthSubmit">#settings.submitText#</a>
				<br>
					<div style="display:none;" id="spLoading">
						<img style="margin-top:35px;" src="#request.cw.assetSrcDir#theme/cw-loading-wide.gif" height="15" width="128">
					</div>
				</div>
			</div>
		</form>
	</cfoutput>
	<!--- javascript for form display & function --->
	<cfsavecontent variable="spFormjs">
	<script type="text/javascript">
	jQuery(document).ready(function(){
		// hide standard button
		jQuery('#sagepay_submit').hide();
		// show link, change text
		jQuery('#CWlinkAuthSubmit').text('<cfoutput>#settings.loadingText#</cfoutput>').show();
		// add loading graphic below button
		jQuery('#spLoading').show();
		// clicking link submits form
		jQuery('#CWlinkAuthSubmit').click(function(){
			jQuery('#sagepay_submit').trigger('click');
		});
		// auto submit the form by triggering a click of the submit button
		<cfif settings.autoSubmit eq 'true'>
		jQuery('#sagepay_submit').delay('300').trigger('click');
		</cfif>
	});
	</script>
	</cfsavecontent>
	<cfhtmlhead text="#spFormjs#">
	<!--- /end CAPTURE mode --->
<!--- PROCESS MODE --->
<!--- PROCESS MODE (url postback from SagePay) --->
<!--- PROCESS MODE --->
<cfelseif isDefined('attributes.auth_mode') and attributes.auth_mode is 'process'>
	<!--- function to parse response --->
	<cffunction name="getSagePayResponse" returntype="Struct" access="private" output="false">
	    <cfargument name="crypt" type="string" required="true">
	    <cfset var r = "">
	    <cfset var structResult =  {}>
	    <cfloop list="#arguments.crypt#" index="r" delimiters="&">
	        <cfset structResult[listFirst(r,"=")] = listLast(r,"=")>
	    </cfloop>
	    <cfreturn structResult>
	</cffunction>
	<!--- read response from SagePay --->
	<cfparam name="url.crypt" default="">
	<cfset request.trans.paymenttransresponse = base64Decode(url.crypt)>
	<!--- add heading to response data --->
	<cfset request.trans.paymenttransresponse = 'SagePay Returned Values: ' & chr(13) & '===' & chr(13) & request.trans.paymenttransresponse>
	<!--- set values into page request --->
	<cfset request.trans.paymentdata = getSagePayResponse(SimpleXor(base64decode(URL.crypt),settings.encryptionPassword))>
	<cfparam name="request.trans.paymentdata.VPSTxId" default="">
	<cfset request.trans.orderid = request.trans.paymentdata.VendorTxCode>
	<cfset request.trans.paymentamount = request.trans.paymentdata.Amount>
	<cfset request.trans.paymenttransid = request.trans.paymentdata.VPSTxId>
	<cfset request.trans.paymentstatus = request.trans.paymentdata.Status>
	<!--- take action based on response from cfhttp request (VERIFIED|INVALID)--->
	<cfset responseStr = request.trans.paymentstatus>
	<cfswitch expression="#responseStr#">
		<!--- if order is OK --->
		<cfcase value="OK">
			<!--- QUERY: check for duplicate transaction (payment) --->
			<cfset transQuery = CWqueryGetTransaction(request.trans.paymenttransid)>
			<!--- if Duplicate Transaction exists, we have a duplicate post --->
				<cfif transQuery.recordCount gt 0>
					<!--- set error message --->
					<cfset request.trans.errorMessage = listAppend(request.trans.errorMessage, 'Duplicate Payment - Verify Order Balance With Merchant')>
				<!--- if Not a Duplicate --->
				<cfelse>
					<!--- QUERY: Verify Order Exists by ID --->
					<cfset orderQuery = CWquerySelectOrderDetails(order_id=request.trans.orderid)>
						<!--- if order is valid --->
						<cfif orderQuery.recordCount>
							<!--- verify payment amount not greater than order total --->
							<cfif orderQuery.order_total gte request.trans.paymentamount>
								<!--- payment is ok, save payment --->
									<cftry>
										<!--- QUERY: insert payment to database,
										returns payment id if successful, or 0-based message if not
										--->
										<cfset insertedPayment = CWsavePayment(
										order_id = request.trans.orderID,
										payment_method = settings.methodname,
										payment_type = settings.methodtype,
										payment_amount = request.trans.paymentamount,
										payment_status = 'approved',
										payment_trans_id = request.trans.paymenttransid,
										payment_trans_response = request.trans.paymenttransresponse
										)>
										<!--- if an error is returned --->
										<cfif left(insertedPayment,2) eq '0-'>
											<cfset request.trans.errorMessage = listAppend(request.trans.errorMessage, 'Payment Insertion Error: #replace(insertedPayment,'0-','')#')>
										<!--- if no error, update order status, handle remaining balance --->
										<cfelse>
											<!--- get transactions related to this order (including the one just inserted) --->
											<cfset orderPaymentTotal = round(CWorderPaymentTotal(request.trans.orderid)*100)/100>
											<!--- set balance due --->
											<cfset request.trans.orderBalance =  orderQuery.order_total - orderPaymentTotal>
											<!--- if order is paid in full (0 or less) --->
											<cfif request.trans.orderBalance lte 0>
												<!--- QUERY: update order status to paid in full (3) --->
												<cfset updateOrderStatus = CWqueryUpdateOrder(order_id=request.trans.orderID,order_status=3)>
												<!--- SEND EMAIL TO CUSTOMER --->
												<cfif not (isDefined('application.cw.mailSendPaymentCustomer') and application.cw.mailSendPaymentCustomer is false)>
													<!--- build the order details content --->
													<cfset mailBody = CWtextOrderDetails(order_id=request.trans.orderid, show_payments=true)>
													<cfsavecontent variable="mailContent">
													<cfoutput>#application.cw.mailDefaultOrderPaidIntro#
													#chr(13)##chr(13)#
													#mailBody#
													#chr(13)##chr(13)#
													#application.cw.mailDefaultOrderPaidEnd#
													</cfoutput>
													</cfsavecontent>
													<!--- send the content to the customer --->
													<cfset confirmationResponse = CWsendMail(mailContent, 'Payment Confirmation',orderQuery.customer_email)>
												</cfif>
												<!--- SEND EMAIL TO MERCHANT --->
												<cfif not (isDefined('application.cw.mailSendPaymentMerchant') and application.cw.mailSendPaymentMerchant is false)>
													<cfsavecontent variable="merchantMailContent">
													<cfoutput>
													An payment has been processed at #application.cw.companyName#
													#chr(10)##chr(13)#
													#mailBody#
													#chr(10)##chr(13)#
													Log in to manage this order and view payment details: #cwTrailingChar(application.cw.appSiteUrlHttp)##cwLeadingChar(application.cw.appCwAdminDir,'remove')#
													</cfoutput>
													</cfsavecontent>
													<!--- send to merchant --->
													<cfset confirmationResponse = CWsendMail(merchantMailContent, 'Payment Notification: #request.trans.orderID#',application.cw.companyEmail)>
												</cfif>
												<!--- /end send email --->
											<!--- if a balance is still owed after a payment was made--->
											<cfelseif request.trans.orderBalance gt 0>
												<!--- QUERY: update order status to partial payment (2) --->
												<cfset updateOrderStatus = CWqueryUpdateOrder(order_id=request.trans.orderID,order_status=2)>
												<cfset request.trans.errorMessage = listAppend(request.trans.errorMessage, 'Balance of #lsCurrencyFormat(request.trans.orderBalance,'local')# due')>
											</cfif>
											<!--- /end balance due check --->
										</cfif>
										<!--- /end insertion error check --->
										<cfcatch>
											<!--- capture any errors from processing --->
											<cfset request.trans.errorMessage = listAppend(request.trans.errorMessage, 'Payment Insertion Error: #cfcatch.detail#')>
										</cfcatch>
									</cftry>
							<!--- /end valid payment --->
							<!--- if payment is over order, we have a mismatch --->
							<cfelse>
								<cfset request.trans.errorMessage = listAppend(request.trans.errorMessage, 'Invalid Payment Amount')>
							</cfif>
							<!--- /end verify payment amount --->
						<!--- if order is invalid (no matching order by ID) --->
						<cfelse>
							<cfset request.trans.errorMessage = listAppend(request.trans.errorMessage, 'Invalid Payment - No Matching Order, Payment Not Applied')>
						</cfif>
						<!--- /end if order is valid --->
				</cfif>
				<!--- /end duplicate yes/no --->
		</cfcase>
		<!--- /end value=OK --->
		<!--- if order is INVALID --->
		<cfdefaultcase>
				<cfset request.trans.errorMessage = listAppend(request.trans.errorMessage, 'Invalid SagePay Transaction - Payment Not Completed')>
		</cfdefaultcase>
		<!--- /end value=invalid --->
	</cfswitch>
	<!--- /end switch for sagepay status --->
	<!--- IF ERRORS: notify admin of any errors --->
	<cfif len(trim(request.trans.errorMessage))>
		<cfsavecontent variable="mailContent">
		<cfoutput>
		The following errors were reported while processing an attempted SagePay payment:#chr(13)#
		===#chr(13)#
		Order: #request.trans.orderid##chr(13)#
		Transaction ID:#request.trans.paymenttransid##chr(13)#
		===#chr(13)#
		<cfloop list="#request.trans.errorMessage#" index="ee">
		#ee##chr(13)#
		</cfloop>
		===#chr(13)#
		#request.trans.paymenttransresponse#
		===#chr(13)#
		Order Details:#chr(13)#
		#CWtextOrderDetails(request.trans.orderid)#
		</cfoutput>
		</cfsavecontent>
		<!--- send the error message to the site admin --->
		<cfif isDefined('application.cw.developerEmail') and isValid('email',application.cw.developerEmail)>
			<cfset confirmationResponse = CWsendMail(mailContent, 'SagePay Processing Error',application.cw.developerEmail)>
		</cfif>
		<!--- /end send email --->
	</cfif>
	<!--- /end if errors --->
	<cflocation url="#settings.returnURL#" addtoken="no">
	<!--- /END PROCESS MODE --->
</cfif>