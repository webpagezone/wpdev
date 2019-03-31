<cfsilent>
<!---
==========================================================
Application: Cartweaver 4 ColdFusion
Copyright 2002 - 2013, All Rights Reserved
Developer: Application Dynamics, Inc. | Cartweaver.com
Licensing: http://www.cartweaver.com/eula
Support: http://www.cartweaver.com/support
==========================================================
File: cw-mod-customerlinks.cfm
File Date: 2014-06-25
Description: displays links for View Cart | Check Out | # of Items in Cart | Log In / My Account | Logged in As
==========================================================
--->

<!--- default attributes: return url is used for 'continue shopping' link  --->
<cfparam name="attributes.return_url" default="#request.cwpage.urlResults#">

<cfparam name="attributes.cart_quantity" default="0">
<cfparam name="attributes.cart_total" default="0">


<cfparam name="attributes.delimiter" default=" | ">
<cfparam name="attributes.element_id" default="">

<!--- <cfparam name="attributes.show_item_count" default="false">
<cfparam name="attributes.show_cart_total" default="false">
<cfparam name="attributes.tax_calc_method" default="none">
<cfparam name="attributes.show_view_cart" default="false">
<cfparam name="attributes.show_checkout" default="false"> --->


<cfparam name="attributes.show_login" default="false">
<cfparam name="attributes.show_logout" default="false">
<cfparam name="attributes.show_account" default="false">
<cfparam name="attributes.show_loggedinas" default="true">
<cfparam name="attributes.logout_url" default="#request.cwpage.urlCheckout#">

<cfif not attributes.logout_url contains '?'>
	<cfset attributes.logout_url = attributes.logout_url & '?logout=1'>
<cfelse>
	<cfset attributes.logout_url = attributes.logout_url & '&logout=1'>
</cfif>
<!--- cartlinks set up as delimited list, shown at end with single loop of list --->
<cfset cartlinks = ''>



<!--- LOG IN / MY ACCOUNT --->
<!--- if not logged in --->
<cfif not (isDefined('session.cwclient.cwCustomerID') and session.cwclient.cwCustomerID neq '0')
		or (isDefined('session.cwclient.cwCustomerCheckout') and session.cwclient.cwCustomerCheckout eq 'guest')>
	<!--- log in --->
	<cfif attributes.show_login>
		<cfset loginLink = '<a class="CWloginLink" href="#request.cwpage.urlAccount#">
		Log In <i class="fa fa-lock fa-lg" title="Log In"></i>
		</a>'>
		<cfset cartlinks = listAppend(cartlinks,loginLink,'|')>
	</cfif>
<!--- if logged in --->

<cfelse>
	<!--- logged in as --->
	<cfif attributes.show_loggedinas  and isDefined('session.cwclient.cwCustomerName') and len(trim(session.cwclient.cwCustomerName))>
		<cfif attributes.show_account>
			<cfset displayName = '<a href="#request.cwpage.urlAccount#"class="welcome">Welcome #session.cwclient.cwCustomerName#</a>'>
		<cfelse>
			<cfset displayName = session.cwclient.cwCustomerName>
		</cfif>

		<cfset cartlinks = listAppend(cartlinks,'#displayName#','|')>
	</cfif>
	<!--- my account --->
	<cfif attributes.show_account>
		<cfset accountLink = '<a href="#request.cwpage.urlAccount#">
		<i class="fa fa-user fa-lg" title="My Account"></i>
		</a>'>
		<cfset cartlinks = listAppend(cartlinks,accountLink,'|')>
	</cfif>
	<!--- log out --->
	<cfif attributes.show_logout>
		<cfset logoutLink = '<a class="CWlogoutLink" href="#replace(attributes.logout_url,'?&','?')#">
		<!--- Log Out --->
		  <i class="fa fa-unlock fa-lg" title="Log Out"></i>
		</a>'>
		<cfset cartlinks = listAppend(cartlinks,logoutLink,'|')>
	</cfif>
</cfif>
<!--- / end login/my account --->
</cfsilent>


<!--- DISPLAY LINKS --->
<!--- <cfset loopCt = 0>
<cfset totalCt = listLen(cartlinks,'|')>
<cfif totalCt gt 0>

	 <cfloop list="#cartLinks#" index="cc" delimiters="|">
		 <li>
		<cfset loopCt = loopCt + 1>
		<cfoutput>#cc# </cfoutput>
		</li>
	</cfloop>

</cfif> --->



<!--- DISPLAY LINKS --->
<cfset loopCt = 0>
<cfset totalCt = listLen(cartlinks,'|')>
<cfif totalCt gt 0>
	<ul class="nav navbar-nav" <cfif len(trim(attributes.element_id))> id="<cfoutput>#attributes.element_id#</cfoutput>"</cfif>>

	<cfloop list="#cartLinks#" index="cc" delimiters="|">
		<cfset loopCt = loopCt + 1>
		<li><cfoutput>#cc#<!--- <cfif loopCt lt totalCt>#attributes.delimiter#</cfif> ---></cfoutput></li>
	</cfloop>
	</ul>
</cfif>

