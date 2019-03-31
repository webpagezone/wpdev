<cfsilent>
<!---
================================================================
Application Info: Cartweaver© 2002 - 2007, All Rights Reserved.
Developer Info: Application Dynamics Inc.
                1560 NE 10th
                East Wenatchee, WA 98802
Support Info: http://www.cartweaver.com/go/cfhelp

Cartweaver Version: 3.0.8  -  Date: 12/9/2007

================================================================
Name: PayPal Custom Tag
Description: PayPal payment processing. This tag both displays the
	submission form on the Confirmation page of the Cartweaver application
	and takes the submission from PayPal and updates the customer records
	accordingly. Email notifications are sent to the store contact email
	address with the results of the transaction (Completed or potential
	fraud).

NOTE: Setting up accounts and integrating with third party processors is not
a supported feature of Cartweaver. For information and support concerning
payment processors contact the appropriate processor tech support web site or
personnel. Cartweaver includes this integration code as a courtesy with no
guarantee or warranty expressed or implied. Payment processors may make changes
to their protocols or practices that may affect the code provided here.
If so, updates and modifications are the sole responsibility of the user.
================================================================
--->
<!--- USER SETTING  [ START ] ==================================================== --->
<!--- Variables for paypal processing. These must be manually defined --->
<!--- This is the email address used for your paypal account. --->
<cfset paypalAccount = "tundi0000@gmail.com.com">
<cfset currencyCode = "USD" />
<!--- Other PayPal supported currency codes
AUD, CAD, EUR, GBP, JPY
--->
<!--- USER SETTING  [ END ] ====================================================== --->


<!--- DO NOT EDIT BELOW THIS LINE --->
<!--- =================================================================== --->
<!--- Set URLs for the user to be returned to when they either complete
	or cancel an order --->
<cfset returnURL = "https://" & CGI.SERVER_NAME & CGI.PATH_INFO & "?mode=return">
<cfset cancelURL = "https://" & CGI.SERVER_NAME & CGI.PATH_INFO & "?mode=cancel">
<cfset ipnURL = "https://" & CGI.SERVER_NAME & CGI.PATH_INFO>

<!--- Email confirmation notice to customer --->
<cflock timeout="10" throwontimeout="no" type="readonly" scope="application">
  <cfset variables.MailServer = application.mailserver>
  <cfset variables.CompanyEmail = application.companyemail>
  <cfset variables.DeveloperEmail = application.DeveloperEmail>
  <cfset variables.Company = application.companyname>
</cflock>

<!--- Set this value to yes to receive debugging emails for each paypal hit to your IPN script --->
<cfset DebugEmails = "No">

<!--- Set the FieldNames to blank as a default so we can check for valid fieldnames later --->
<cfparam name="Form.FieldNames" default="">
</cfsilent>
<!--- If the page has recieved a form post and it's not a return from paypal then process the paypal information --->
<cfif Form.FieldNames NEQ "" AND cgi.query_string EQ "" AND IsDefined("FORM.txn_id")>
<cfif DebugEmails EQ "Yes">
<cfmail to="#variables.DeveloperEmail#"
from="#variables.Company#<#variables.CompanyEmail#>"
subject="Testing - Inside Paypal Processing"
server="#variables.MailServer#">
Inside Paypal Processing.
</cfmail>
</cfif>
	<cfsilent>
<!--- read post from PayPal system and add 'cmd' --->
<cfset str="cmd=_notify-validate">
<cfloop index="TheField" list="#Form.FieldNames#">
	<cfset str = str & "&#LCase(TheField)#=#URLEncodedFormat(Evaluate(TheField))#">
</cfloop>
<cfif IsDefined("FORM.payment_date")>
	<cfset str = str & "&payment_date=#URLEncodedFormat(Form.payment_date)#">
</cfif>

<!--- post back to PayPal system to validate
https://ipnpb.sandbox.paypal.com/cgi-bin/webscr--->
<cfhttp url="https://www.paypal.com/cgi-bin/webscr?#str#" method="GET" resolveurl="false"></cfhttp>

<!--- To prevent errors, set null values for missing form.variables --->
<cfparam name="FORM.txn_type" default="">
<cfparam name="FORM.invoice" default="">
<cfparam name="FORM.mc_gross" default="">
<cfparam name="FORM.payment_status" default="">
<cfparam name="FORM.pending_reason" default="">
<cfparam name="FORM.payment_type" default="">

<!--- Create a variable with a pretty list of name/value pairs from Paypal for store records --->
<cfparam name="formValues" default="">
<cfloop index="X" list="#Form.FieldNames#" delimiters=",">
	<cfset formValues = formValues & X & " = " & evaluate("Form." & X) & Chr(13)>
</cfloop>
<cfif DebugEmails EQ "Yes">
<cfmail to="#variables.DeveloperEmail#"
from="#variables.Company#<#variables.CompanyEmail#>"
subject="Testing - #FORM.invoice# - 1 - Got Forms"
server="#variables.MailServer#">
cfhttp.FileContent: #cfhttp.FileContent#
FormValues = #formValues#
</cfmail>
</cfif>
<!--- Start processing --->
<cfswitch expression="#cfhttp.FileContent#">
	<cfcase value="VERIFIED">
<cfif DebugEmails EQ "Yes">
<cfmail to="#variables.DeveloperEmail#"
from="#variables.Company#<#variables.CompanyEmail#>"
subject="Testing - #FORM.invoice# - 2 - Verified"
server="#variables.MailServer#">
cfcase value="verified"
</cfmail>
</cfif>
<!--- If the txn_type is not from a web_accept, then don't process --->
<cfif Form.txn_type EQ "web_accept">
<cfif DebugEmails EQ "Yes">
<cfmail to="#variables.DeveloperEmail#"
from="#variables.Company#<#variables.CompanyEmail#>"
subject="Testing - #FORM.invoice# - 3 - txn_type = web_accept"
server="#variables.MailServer#">
Form.txn_type EQ "web_accept"
</cfmail>
</cfif>
<cfswitch expression="#FORM.payment_status#">
	<cfcase value="Completed">
<cfif DebugEmails EQ "Yes">
<cfmail to="#variables.DeveloperEmail#"
from="#variables.Company#<#variables.CompanyEmail#>"
subject="Testing - #FORM.invoice# - 4 - cfcase FORM.payment_status value=Completed"
server="#variables.MailServer#">
cfcase FORM.payment_status value="Completed"
</cfmail>
</cfif>
	<!--- Do all the wonderful stuff, including price fraud check. --->

	<!--- Check for duplicate transaction --->
	<cfquery name="rsCheckForDupTxn" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
	SELECT order_TransactionID FROM tbl_orders WHERE order_TransactionID = '#FORM.txn_id#'
	</cfquery>
	<cfif rsCheckForDupTxn.RecordCount NEQ 0>
	<!--- Duplicate order, throw error and send email. --->
<cfmail to="#variables.DeveloperEmail#"
from="#variables.Company#<#variables.CompanyEmail#>"
subject="Testing - #FORM.invoice# - 5 - Duplicate order"
server="#variables.MailServer#">
There was a duplicate transaction posted by PayPal to the store.
The status has been left pending.
Duplicate Transaction ID: #FORM.txn_id#
Order ID: #FORM.invoice#
=======================================

#formValues#
</cfmail>

<cfabort>
<cfelse>
<cfif DebugEmails EQ "Yes">
<cfmail to="#variables.DeveloperEmail#"
from="#variables.Company#<#variables.CompanyEmail#>"
subject="Testing - #FORM.invoice# - 6 - No duplicate order"
server="#variables.MailServer#">
rsCheckForDupTxn.RecordCount EQ 0
</cfmail>
</cfif>
<!--- This is a new payment, continue processing. --->

<cfquery name="rsGetOrder" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
SELECT order_ID, order_Total, order_Notes, cst_Email
FROM tbl_orders o
INNER JOIN tbl_customers c
ON o.order_CustomerID = c.cst_ID
WHERE order_ID = '#FORM.invoice#'
</cfquery>
<!--- Ensure we have a record --->
<cfif rsGetOrder.RecordCount NEQ 0>
<cfif DebugEmails EQ "Yes">
<cfmail to="#variables.DeveloperEmail#"
from="#variables.Company#<#variables.CompanyEmail#>"
subject="Testing - #FORM.invoice# - 7 - rsGetOrder.RecordCount NEQ 0"
server="#variables.MailServer#">
rsGetOrder.RecordCount NEQ 0
</cfmail>
</cfif>

<!--- Check to ensure that the payed amount is the same as the order amount --->
<cfif rsGetOrder.order_Total EQ FORM.mc_gross>
<cfif DebugEmails EQ "Yes">
<cfmail to="#variables.DeveloperEmail#"
from="#variables.Company#<#variables.CompanyEmail#>"
subject="Testing - #FORM.invoice# - 8 - rsGetOrder.order_Total EQ FORM.mc_gross"
server="#variables.MailServer#">
#rsGetOrder.order_Total# EQ #FORM.mc_gross#
</cfmail>
</cfif>
		<!--- Order is good, update appropriately --->
		<!--- Set notes variable to append any paypal notes --->
		<cfset orderNotes = rsGetOrder.order_Notes & Chr(13) & Chr(13) & "PayPal Form Values" & Chr(13) &  "=====" & Chr(13) & formValues>
		<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
		UPDATE tbl_orders SET
			order_Status = 2,
			order_TransactionID = '#FORM.txn_id#',
			order_Notes = '#orderNotes#'
		WHERE
			order_ID = '#FORM.invoice#'
		</cfquery>
<cfmail
to="#variables.CompanyEmail#"
from="#variables.Company#<#variables.CompanyEmail#>"
subject="Payment Verified"
server="#variables.MailServer#">
The following order has received a payment from paypal. The order has been marked Verified.
Order ID: #FORM.invoice#
=======================================

#formValues#
</cfmail>
<!--- Send confirmation emails --->
<cfinclude template="../CWFunOrderConfirmEmails.cfm">
<cfset EmailContents = cwBuildConfirmationEmail(FORM.invoice)>
<cfset cwOrderConfirmEmails(EmailContents, rsGetOrder.cst_Email)>


		<cfelse>
		<!--- Payment doesn't match total, fraud --->
		<cfset orderNotes = rsGetOrder.order_Notes & Chr(13) & "Nonmatching Payment Totals" & Chr(13) & formValues>
		<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
		UPDATE tbl_orders SET
			order_TransactionID = '#FORM.txn_id#',
			order_Notes = '#orderNotes#'
		WHERE
			order_ID = '#rsGetOrder.order_ID#'
		</cfquery>
<cfmail
to="#variables.CompanyEmail#"
from="#variables.Company#<#variables.CompanyEmail#>"
subject="Incorrect Payment Total"
server="#variables.MailServer#">
The following order received a PayPal payment that doesn't match the order's total.
The status has been left Pending.
Transaction ID: #FORM.txn_id#
Order ID: #FORM.invoice#
=======================================

#formValues#
</cfmail>
			<cfabort>
		</cfif>
		<!--- End rsGetOrder.order_Total EQ FORM.mc_gross --->
		<cfelse>
		<!--- No order, more fraud --->
<cfmail
to="#variables.CompanyEmail#"
from="#variables.Company#<#variables.CompanyEmail#>"
subject="Payment without order"
server="#variables.MailServer#">
The following payment was received from PayPal but there is no matching order.
Transaction ID: #FORM.txn_id#
=======================================

#formValues#
</cfmail>
<cfabort>
</cfif>
<!--- End rsGetOrder.RecordCount NEQ 0 --->
</cfif>
<!--- End rsCheckForDupTxn.RecordCount NEQ 0 --->
</cfcase>

</cfswitch>
<!--- End Switch expression="#FORM.payment_status#" --->
<cfelse>
<!--- A transaction was posted to the IPN that does not relate to the store. Abort. --->
<cfmail to="#variables.CompanyEmail#"
from="#variables.Company#<#variables.CompanyEmail#>"
subject="Testing - txn_type <> web_accept - #FORM.invoice#"
server="#variables.MailServer#">
Form.txn_type NEQ "web_accept"
</cfmail>
<cfabort>
</cfif>
<!--- End Form.txn_type EQ "web_accept" --->
</cfcase>

<cfcase value="INVALID">
<!--- Payment failed, act accordingly --->
<cfmail to="#variables.CompanyEmail#"
from="#variables.Company#<#variables.CompanyEmail#>"
subject="Payment without order"
server="#variables.MailServer#">
The following post was received from PayPal with an Invalid status.
Transaction ID: #FORM.txn_id#
=======================================

#formValues#
</cfmail>
<cfabort>
</cfcase>

<cfdefaultcase>
<!--- PayPal processing error, act accordingly --->
<cfmail to="#variables.CompanyEmail#"
from="#variables.Company#<#variables.CompanyEmail#>"
subject="Payment without order"
server="#variables.MailServer#">
The following post was received from PayPal with a status other than Complete or Invalid.
Transaction ID: #FORM.txn_id#
=======================================

#formValues#
</cfmail>
</cfdefaultcase>
</cfswitch>
<!--- End Switch expression="#cfhttp.FileContent#" --->
<cfabort>
</cfsilent>

<cfelse>
	<cfif ProcessorStatus EQ "Form">
		<!--- Get the user's billing information for PayPal --->
		<cfquery name="rsPaypalBilling" datasource="#Request.DSN#" username="#Request.DSNUsername#" password="#Request.DSNPassword#">
		SELECT
			tbl_customers.cst_FirstName,
			tbl_customers.cst_LastName,
			tbl_customers.cst_Address1,
			tbl_customers.cst_Address2,
			tbl_customers.cst_City,
			tbl_customers.cst_Zip,
			tbl_stateprov.stprv_Name,
			tbl_list_countries.country_Name
		FROM (tbl_list_countries INNER JOIN tbl_stateprov ON tbl_list_countries.country_ID = tbl_stateprov.stprv_Country_ID)
			INNER JOIN ((tbl_customers INNER JOIN tbl_orders ON tbl_customers.cst_ID = tbl_orders.order_CustomerID)
			INNER JOIN tbl_custstate ON tbl_customers.cst_ID = tbl_custstate.CustSt_Cust_ID) ON tbl_stateprov.stprv_ID = tbl_custstate.CustSt_StPrv_ID
		WHERE
			tbl_custstate.CustSt_Destination = 'BillTo'
			AND tbl_orders.order_ID = '#rsOrder.order_ID#'
		</cfquery>
		<!--- If no form has been submitted, then display the submission form for the user --->
		<p>In order to complete your purchase you must submit your payment through PayPal.
		Once your payment is received your order will be shipped. Please print this page before
		clicking the Submit to PayPal button.</p>
		<form action="https://www.paypal.com/cgi-bin/webscr" method="post">
			<input type="hidden" name="cmd" value="_ext-enter">
			<input type="hidden" name="redirect_cmd" value="_xclick">
			<input type="hidden" name="business" value="<cfoutput>#paypalAccount#</cfoutput>">
			<input type="hidden" name="notify_url" value="<cfoutput>#ipnURL#</cfoutput>">
			<input type="hidden" name="return" value="<cfoutput>#returnURL#</cfoutput>">
			<input type="hidden" name="cancel_return" value="<cfoutput>#cancelURL#&amp;orderid=#rsOrder.order_ID#</cfoutput>">
			<input type="hidden" name="item_name" value="<cfoutput>#application.companyname#</cfoutput> purchase">
			<input type="hidden" name="amount" value="<cfoutput>#numberFormat(rsOrder.order_Total,'__.__')#</cfoutput>">
			<input type="hidden" name="no_shipping" value="1">
			<input type="hidden" name="no_note" value="1">
			<input type="hidden" name="invoice" value="<cfoutput>#rsOrder.order_ID#</cfoutput>">
			<input type="hidden" name="first_name" value="<cfoutput>#rsPaypalBilling.cst_FirstName#</cfoutput>">
			<input type="hidden" name="last_name" value="<cfoutput>#rsPaypalBilling.cst_LastName#</cfoutput>">
			<input type="hidden" name="address1" value="<cfoutput>#rsPaypalBilling.cst_Address1#</cfoutput>">
			<input type="hidden" name="address2" value="<cfoutput>#rsPaypalBilling.cst_Address2#</cfoutput>">
			<input type="hidden" name="city" value="<cfoutput>#rsPaypalBilling.cst_City#</cfoutput>">
			<input type="hidden" name="state" value="<cfoutput>#rsPaypalBilling.stprv_Name#</cfoutput>">
			<input type="hidden" name="zip" value="<cfoutput>#rsPaypalBilling.cst_Zip#</cfoutput>">
			<input type="hidden" name="address_country" value="<cfoutput>#rsPaypalBilling.country_Name#</cfoutput>">
			<input type="hidden" name="currency_code" value="<cfoutput>#currencyCode#</cfoutput>">
			<input type="submit" name="submit" value="Submit to PayPal for Payment Now" class="formButton">
		</form>
	</cfif>
</cfif>
<!--- End Form.FieldNames NEQ "" AND cgi.query_string EQ "" AND IsDefined("FORM.txn_id") --->

