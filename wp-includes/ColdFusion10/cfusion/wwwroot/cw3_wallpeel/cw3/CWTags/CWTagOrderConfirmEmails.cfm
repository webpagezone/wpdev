<cfsilent>
<!--- 
================================================================
Application Info: Cartweaver© 2002 - 2007, All Rights Reserved.
Developer Info: Application Dynamics Inc.
                1560 NE 10th
                East Wenatchee, WA 98802
Support Info: http://www.cartweaver.com/go/cfhelp
    
Cartweaver Version: 3.0.3  -  Date: 5/5/2007

================================================================
Name: Order Confirmation
Description: This page sends both confirmation emails to the 
customer and the store merchant.
================================================================
--->

<!--- Email confirmation notice to customer --->
<cflock timeout="10" throwontimeout="no" type="readonly" scope="application">
  <cfset variables.MailServer = application.mailserver>
  <cfset variables.subject = "Your Order From #application.companyname#">
  <cfset variables.CompanyEmail = application.companyemail>
  <cfset variables.Company = application.companyname>
</cflock>
<cfparam name="attributes.EmailContents" default="">
<cfparam name="attributes.CustomerEmail" default="">
<!--- If you're using a payment gateway --->
<cfif request.PaymentAuthType EQ "Gateway">

<cfmail to="#attributes.CustomerEmail#"
	from="#variables.CompanyEmail#"
	subject="#variables.subject#"
	server="#variables.MailServer#">
	Your order has been received and will be shipped to you shortly! Your details are as follows.

	#attributes.EmailContents#	
	Thank you!
</cfmail>

<!--- If you're using anything other than a payment gateway --->
<cfelse>

<cfmail to="#attributes.CustomerEmail#"
	from="#variables.CompanyEmail#"
	subject="#variables.subject#"
	server="#variables.MailServer#">
	Your order has been received.
	As soon as your payment is verified you will receive a confirmation notice and your order will be shipped! Your order details are as follows.
	
#attributes.EmailContents#	
	Thank you!
</cfmail>

</cfif>


<!--- "You have an order" Notification sent to Merchant --->
<cfmail to="#variables.CompanyEmail#"
	from="#variables.CompanyEmail#"
	subject="#variables.subject# - Merchant Order Notification"
	server="#variables.MailServer#">
	You have just received an order. The order details are as follows:

#attributes.EmailContents#	
</cfmail>
</cfsilent>