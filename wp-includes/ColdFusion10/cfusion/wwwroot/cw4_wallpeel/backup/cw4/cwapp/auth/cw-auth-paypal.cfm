<cfsilent>
<!---
==========================================================
Application: Cartweaver 4 ColdFusion
Copyright 2002 - 2013, All Rights Reserved
Developer: Application Dynamics Inc. | Cartweaver.com
Licensing: http://www.cartweaver.com/eula
Support: http://www.cartweaver.com/support
==========================================================
File: cw-auth-paypal.cfm
File Date: 2013-01-25
Description: PayPal payment processing

NOTE: Setting up accounts and integrating with third party processors is not
a supported feature of Cartweaver. For information and support concerning
payment processors contact the appropriate processor tech support web site or
personnel. Cartweaver includes this integration code as a courtesy with no
guarantee or warranty expressed or implied. Payment processors may make changes
to their protocols or practices that may affect the code provided here.
If so, updates and modifications are the sole responsibility of the user.

Additional PayPal options:
(at the time of this revision, the PayPal transaction variables are listed here)
https://www.paypal.com/cgi-bin/webscr?cmd=p/pdn/howto_checkout-outside#methodone
================================================================
RETURN VARIABLES: paymenttransid, paymenttransresponse, paymentstatus
Values: Transaction ID, Gateway Response Message, Payment Status (approved|denied|none(no response))
These are returned to the containing page or template
in the request.trans scope, e.g. 'request.trans.paymentTransID'
--->

<!--- /// CONFIGURATION / SETUP /// --->
<!--- CWauth Payment Configuration --->

<!--- USER SETTINGS  [ START ] ==================================================== --->
<!--- ============================================================================= --->
	<!--- PAYPAL SETTINGS --->
		<!--- Enter Paypal Login (email address) --->
		<cfset settings.paypalLogin = 'xxxxxxxxxxxx'>
		<!--- <cfset settings.paypalLogin = 'youraddress@yoursitehere.com'> --->
		<!--- Enter Currency Code (USD, AUD, CAD, EUR, GBP, JPY)--->
		<cfset settings.currencyCode = 'USD'>
		<!--- Transaction Title (Name for purchase shown to PayPal user) --->
		<cfset settings.transactionTitle = application.cw.companyName & ' Purchase'>
		<!--- URL to Post To --->
			<!--- paypal LIVE URL --->
			<!---
			<cfset settings.authUrl = 'https://www.paypal.com/cgi-bin/webscr'>
			 --->
			<!--- paypal SANDBOX/TESTING URL --->
			<cfset settings.authUrl = 'https://www.sandbox.paypal.com/cgi-bin/webscr'>
	<!--- OPTIONAL PAYMENT METHOD VARIABLES --->
		<!--- method image: an optional logo url (relative or full url) associated with this payment option at checkout
			  e.g. /images/mylogo.jpg or https://www.example.com/images/mylogo.jpg
			  Note: be sure to use https prefix if linking to remote image  --->
		<cfset settings.methodImg = ''>
		<!--- shippay message: optional message shown to customer on shipping selection --->
		<cfset settings.methodSelectMessage = 'Pay with PayPal'>
		<!--- submit message: optional message shown to customer on final order submission --->
		<cfset settings.methodSubmitMessage = 'Click to pay with PayPal'>
		<!--- confirm message: optional message shown to customer after order is approved --->
		<cfset settings.methodConfirmMessage = 'PayPal transaction complete'>
		<!--- send errors: email notice of processing issues (blank = disabled) --->
		<cfset settings.errorEmail = '#application.cw.developerEmail#'>
	<!--- SUBMIT TEXT --->
		<!--- submit button value --->
		<cfset settings.submitText = '&raquo;&nbsp;Click to Pay with PayPal'>
		<!--- processing/loading message --->
		<cfset settings.loadingText = 'Submitting to PayPal...'>
<!--- ============================================================================ --->
<!--- USER SETTINGS [ END ] ====================================================== --->

<!--- METHOD SETTINGS : do not change --->
	<!--- method name: the user-friendly name shown for this payment option at checkout --->
	<cfset settings.methodName = 'PayPal'>
	<!--- method type: processor (off-site processing), gateway (integrated credit card form) --->
	<cfset settings.methodType = 'processor'>
	<!--- key field: transaction variable specific to this payment method --->
	<cfset settings.methodTransKeyField = "form.txn_id">
	<!--- notification URLs (ipn / paypal transactions) --->
	<cfset settings.ipnUrl = application.cw.appPageConfirmOrderUrl>
	<cfset settings.cancelUrl = application.cw.appPageConfirmOrderUrl & '?mode=cancel'>
	<cfset settings.returnUrl = application.cw.appPageConfirmOrderUrl & '?mode=return'>
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
	<cfparam name="request.trans.errorMessage" default="">
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
		<!--- order/payment --->
		<cfparam name="tdata.orderid" default="" type="string">
		<cfparam name="tdata.paymentamount" default="0" type="numeric">

	</cfif>
	<!--- /end if data ok --->
	<!--- paypal transaction form with hidden inputs --->
	<cfoutput>
		<form action="#trim(settings.authUrl)#" id="CWformPaypalProcess" method="post">
			<div>
				<input type="hidden" name="cmd" value="_xclick">
				<input type="hidden" name="business" value="#settings.paypalLogin#">
				<input type="hidden" name="notify_url" value="#settings.ipnUrl#">
				<input type="hidden" name="return" value="#settings.returnUrl#&amp;orderid=#tdata.orderid#">
				<input type="hidden" name="cancel_return" value="#settings.cancelUrl#&amp;orderid=#tdata.orderid#">
				<!--- cart details --->
				<input type="hidden" name="item_name" value="#settings.transactionTitle#">
				<input type="hidden" name="quantity" value="1">
				<input type="hidden" name="amount" value="#numberFormat(tdata.paymentAmount,'_.__')#">
				<input type="hidden" name="invoice" value="#tdata.orderID#">
				<!--- override customer's stored paypal info with order data --->
				<input type="hidden" name="address_override" value="1">
				<!--- customer info fields --->
				<input type="hidden" name="first_name" value="#tdata.customerNameFirst#">
				<input type="hidden" name="last_name" value="#tdata.customerNameLast#">
				<input type="hidden" name="address1" value="#tdata.customerAddress1#">
				<input type="hidden" name="city" value="#tdata.customerCity#">
				<input type="hidden" name="state" value="#tdata.customerState#">
				<input type="hidden" name="zip" value="#tdata.customerZip#">
				<input type="hidden" name="country" value="#tdata.customerCountry#">
				<input type="hidden" name="currency_code" value="#settings.currencyCode#">
				<!--- paypal defaults --->
				<input type="hidden" name="no_shipping" value="1">
				<input type="hidden" name="no_note" value="1">
			</div>
			<div>
				<!--- submit button --->
				<div class="center top40 bottom40">
				<input name="submit" id="paypal_submit" type="submit" class="CWformButton" value="<cfoutput>#settings.submitText#</cfoutput>">
				<!--- submit link : javascript replaces button with this link --->
				<a style="display:none;" href="##" class="CWcheckoutLink" id="CWlinkAuthSubmit">#settings.submitText#</a>
				<br>
					<div style="display:none;" id="ppLoading">
						<img style="margin-top:35px;" src="#request.cw.assetSrcDir#css/theme/cw-loading-wide.gif" height="15" width="128">
					</div>
				</div>
			</div>
		</form>
	</cfoutput>
	<!--- javascript for form display & function --->
	<cfsavecontent variable="ppFormjs">
	<script type="text/javascript">
	jQuery(document).ready(function(){
		// hide standard button
		jQuery('#paypal_submit').hide();
		// show link, change text
		jQuery('#CWlinkAuthSubmit').text('<cfoutput>#settings.loadingText#</cfoutput>').show();
		// add loading graphic below button
		jQuery('#ppLoading').show();
		// clicking link submits form
		jQuery('#CWlinkAuthSubmit').click(function(){
			jQuery('#paypal_submit').trigger('click');
		});
		// auto submit the form by triggering a click of the submit button
		jQuery('#paypal_submit').delay('300').trigger('click');
	});
	</script>
	</cfsavecontent>
	<cfhtmlhead text="#ppFormjs#">
	<!--- /end CAPTURE mode --->
<!--- PROCESS MODE --->
<!--- PROCESS MODE (form post from PayPal IPN) --->
<!--- PROCESS MODE --->
<!--- verify form post with txn_id from paypal, and no variables in url --->
<cfelseif isDefined('attributes.auth_mode') and attributes.auth_mode is 'process'>
		<!--- read post from PayPal, add "cmd" variable to string, and post back (no other changes allowed) --->
		<cfset str="cmd=_notify-validate">
		<cfloop list="#form.fieldNames#" index="ff">
			<!--- date gets handled separately --->
			<cfif ff neq "payment_date">
				<cfset str = str & "&#lCase(ff)#=#URLEncodedFormat(evaluate(ff))#">
			</cfif>
		</cfloop>
			<!--- encode and add date here if given --->
			<cfif isDefined("form.payment_date")>
				<cfset str = str & "&payment_date=#URLEncodedFormat(form.payment_date)#">
			</cfif>
	<!--- post  back to PayPal system to validate --->
	<cfif settings.authurl contains 'sandbox'>
		<cfset request.trans.hostHeaderUrl = "www.sandbox.paypal.com">
	<cfelse>
		<cfset request.trans.hostHeaderUrl = "www.paypal.com">	
	</cfif>
	<cfhttp url="#trim(settings.authurl)#?#str#" method="get" resolveurl="false">
		<cfhttpparam type="header" name="Host" value="#request.trans.hostHeaderUrl#">
	</cfhttp>
	<!--- default form values (set to null, if not included in content above) --->
	<cfparam name="form.txn_type" default="">
	<cfparam name="form.invoice" default="">
	<cfparam name="form.mc_gross" default="">
	<cfparam name="form.payment_status" default="">
	<cfparam name="form.pending_reason" default="">
	<cfparam name="form.payment_type" default="">
	<!--- create list of form values for response text --->
	<cfset request.trans.paymentTransResponse = "">
	<cfloop list="#form.fieldnames#" index="ff">
		<cfset request.trans.paymentTransResponse = request.trans.paymentTransResponse & ff & '=' & evaluate('form.#ff#') & chr(13)>
	</cfloop>
	<!--- add heading to response data --->
	<cfset request.trans.paymentTransResponse = 'PayPal Form Values: ' & chr(13) & '===' & chr(13) & request.trans.paymentTransResponse>
	<!--- set values into page request --->
	<cfset request.trans.orderID = trim(form.invoice)>
	<cfset request.trans.paymentamount = form.mc_gross>
	<cfset request.trans.paymentTransID = form.txn_id>
	<cfset request.trans.paymentStatus = lcase(trim(form.payment_status))>
	<!--- take action based on response from cfhttp request (VERIFIED|INVALID)--->
	<cfset responseStr = lcase(trim(cfhttp.filecontent))>
	<cfswitch expression="#responseStr#">
		<!--- if order is VERIFIED --->
		<cfcase value="verified">
			<!--- verify form value from paypal is correct --->
			<cfif form.txn_type eq "web_accept">
				<!--- take action based on value of "payment_status" field from paypal --->
				<cfswitch expression="#request.trans.paymentStatus#">
					<!--- COMPLETED status from PayPal --->
					<cfcase value="completed">
						<!--- QUERY: check for duplicate transaction (payment) --->
						<cfset transQuery = CWqueryGetTransaction(request.trans.paymentTransID)>
						<!--- if Duplicate Transaction exists, we have a duplicate post --->
							<cfif transQuery.recordCount gt 0>
							<!--- set error message --->
								<cfset request.trans.errorMessage = listAppend(request.trans.errorMessage, 'Duplicate Payment - Verify Order Balance With Merchant')>
							<!--- if Not a Duplicate --->
							<cfelse>
								<!--- QUERY: Verify Order Exists by ID ('invoice' number from paypal) --->
								<cfset orderQuery = CWquerySelectOrderDetails(order_id=request.trans.orderID)>
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
												payment_trans_id = request.trans.paymentTransID,
												payment_trans_response = request.trans.paymentTransResponse
												)>
												<!--- if an error is returned --->
												<cfif left(insertedPayment,2) eq '0-'>
													<cfset request.trans.errorMessage = listAppend(request.trans.errorMessage, 'Payment Insertion Error: #replace(insertedPayment,'0-','')#')>
												<!--- if no error, update order status, handle remaining balance --->
												<cfelse>
													<!--- get transactions related to this order (including the one just inserted) --->
													<cfset orderPaymentTotal = round(CWorderPaymentTotal(request.trans.orderID)*100)/100>
													<!--- set balance due --->
													<cfset request.trans.orderBalance =  orderQuery.order_total - orderPaymentTotal>
													<!--- if order is paid in full (0 or less) --->
													<cfif request.trans.orderBalance lte 0>
														<!--- QUERY: update order status to paid in full (3) --->
														<cfset updateOrderStatus = CWqueryUpdateOrder(order_id=request.trans.orderID,order_status=3)>

														<!--- SEND EMAIL TO CUSTOMER --->
														<cfif not (isDefined('application.cw.mailSendPaymentCustomer') and application.cw.mailSendPaymentCustomer is false)>
															<!--- build the order details content --->
															<cfset mailBody = CWtextOrderDetails(order_id=request.trans.orderID, show_payments=true)>
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
					<!--- /end Completed Status --->
					<!--- if status is not 'completed' --->
					<cfdefaultcase>
						<cfset request.trans.errorMessage = listAppend(request.trans.errorMessage, 'Invalid Order Status - #request.trans.paymentStatus#')>
					</cfdefaultcase>
					<!--- /end non 'completed' status --->
				</cfswitch>
				<!--- /end switch for payment_status --->
			<!--- if txn_type is not 'web_accept' --->
			<cfelse>
				<cfset request.trans.errorMessage = listAppend(request.trans.errorMessage, 'Invalid Paypal Transaction Type - #form.txn_type#')>
			</cfif>
			<!--- /end txn_type eq 'web_accept' --->
		</cfcase>
		<!--- /end value=verified --->
		<!--- if order is INVALID --->
		<cfcase value="invalid">
				<cfset request.trans.errorMessage = listAppend(request.trans.errorMessage, 'Invalid PayPal Transaction - Payment Not Accepted')>
		</cfcase>
		<!--- /end value=invalid --->
	</cfswitch>
	<!--- /end switch for paypal response (cfhttp filecontent) --->
	<!--- IF ERRORS: notify admin of any errors --->
	<cfif len(trim(request.trans.errorMessage))>
<!--- set up mail content --->
<cfsavecontent variable="mailContent">
<cfoutput>
One or more problems were reported while attempting to process a PayPal transaction:#chr(13)#
<cfif responseStr is 'verified'>
Paypal reported a payment with status 'verified', but other errors may have occurred.
<cfelse>
PayPal returned a status of '#responseStr#' when attempting to verify payment.
</cfif>
Details of the transaction are below.#chr(13)#
===#chr(13)#
Order: #request.trans.orderID##chr(13)#
Transaction ID:#request.trans.paymentTransID##chr(13)#
===#chr(13)#
<cfloop list="#request.trans.errorMessage#" index="ee">
#ee##chr(13)#
</cfloop>
===#chr(13)#
#request.trans.paymentTransResponse#
===#chr(13)#
Order Details:#chr(13)#
#CWtextOrderDetails(request.trans.orderID)#
===#chr(13)#
Posted To: #trim(settings.authurl)#?#str#
</cfoutput>
</cfsavecontent>
		<!--- if enabled, send the error message to the site admin --->
		<cfif isDefined('settings.errorEmail') and isValid('email',settings.errorEmail)>
			<cfset confirmationResponse = CWsendMail(mailContent, 'PayPal Processing Error',settings.errorEmail)>
		</cfif>
		<!--- /end send email --->
	</cfif>
	<!--- /end if errors --->
	<!--- prevent processor from triggering further response from our page --->
	<cfabort>
	<!--- /END PROCESS MODE --->
</cfif>