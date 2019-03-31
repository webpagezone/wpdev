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
<!--- determine which items are shown in this instance of the cartlinks display --->
<cfparam name="attributes.show_item_count" default="false">
<cfparam name="attributes.show_cart_total" default="false">
<cfparam name="attributes.tax_calc_method" default="none">
<cfparam name="attributes.show_view_cart" default="false">
<cfparam name="attributes.show_checkout" default="false">
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


<!--- <cfset  session.cwclient.cwCartID = 0> --->


<!--- cartlinks set up as delimited list, shown at end with single loop of list --->
<cfset cartlinks = ''>
	<!--- global functions --->
	<cfinclude template="../inc/cw-inc-functions.cfm">
	<!--- clean up form and url variables --->
	<cfinclude template="../inc/cw-inc-sanitize.cfm">
<!--- get cart count, cart total from cart if not provided in attributes --->
<cfif isDefined('session.cwclient.cwCartID')>
	<cfif attributes.cart_quantity eq 0>
		<cfset attributes.cart_quantity = LSNumberFormat(CWgetCartCount(cart_id=session.cwclient.cwCartID), ',999,999')>
	</cfif>
	<cfif attributes.cart_total eq 0>
		<cfset attributes.cart_total = CWgetCartTotal(cart_id=session.cwclient.cwCartID,tax_calc_method=attributes.tax_calc_method)>
	</cfif>
</cfif>

<!--- ITEM COUNT--->
<cfif attributes.show_item_count>
	<!--- set up link --->
	<cfif val(attributes.cart_quantity) gt 0>
		<!--- single vs. plural --->
		<cfif attributes.cart_quantity is not 1>
			<cfset itemLabel = 'Items'>
		<cfelse>
			<cfset itemLabel = 'Item'>
		</cfif>
		<cfset itemCountText = '<span class="small-grey-text">' & attributes.cart_quantity & ' ' & itemLabel & '</span>'>
	<cfelse>
		<cfset itemCountText = '<span class="small-grey-text">(Empty)</span>'>
	</cfif>
	<cfset cartlinks = listAppend(cartlinks,'<a href="##" class="nav-text">#itemCountText#</a>','|')>
</cfif>
<!--- /end item count --->


<!--- CART TOTAL --->
<cfif attributes.show_cart_total and attributes.cart_total gt 0>
	<cfset cartlinks = listAppend(cartlinks,'<a href="##" class="nav-text">#lsCurrencyFormat(attributes.cart_total,'local')#</a>','|')>
</cfif>
<!--- /end cart total --->

<!--- VIEW CART --->
<cfif attributes.show_view_cart>
	<cfif not request.cw.thisPage is listLast(request.cwpage.urlShowCart,'/')>
		<cfset viewCartLink = '<a  href="#request.cwpage.urlShowCart#?returnurl=#urlEncodedFormat(attributes.return_url)#"> Cart </a>'>
		<cfset cartlinks = listAppend(cartlinks,viewCartLink,'|')>
	</cfif>
</cfif>
<!--- /end view cart --->


<!--- CHECK OUT --->
<cfparam name="request.cwpage.checkoutHref" default="#request.cwpage.urlCheckout#">
<cfif attributes.show_checkout and attributes.cart_quantity gt 0>
	<cfif not request.cw.thisPage is listLast(request.cwpage.urlCheckOut,'/')>
	<cfset checkOutLink = '<a  href="#request.cwpage.checkoutHref#">Check Out</a>'>
	<cfset cartlinks = listAppend(cartlinks,checkOutLink,'|')>
	</cfif>
</cfif>
<!--- /end check out --->
<!--- LOG IN / MY ACCOUNT --->
<!--- if not logged in --->
<cfif not (isDefined('session.cwclient.cwCustomerID') and session.cwclient.cwCustomerID neq '0')
		or (isDefined('session.cwclient.cwCustomerCheckout') and session.cwclient.cwCustomerCheckout eq 'guest')>
	<!--- log in --->
	<cfif attributes.show_login>
		<cfset loginLink = '<a  href="#request.cwpage.urlAccount#">Log In</a>'>
		<cfset cartlinks = listAppend(cartlinks,loginLink,'|')>
	</cfif>
<!--- if logged in --->
<cfelse>
	<!--- logged in as --->
	<cfif attributes.show_loggedinas  and isDefined('session.cwclient.cwCustomerName') and len(trim(session.cwclient.cwCustomerName))>
		<cfif attributes.show_account>
			<cfset displayName = '<a href="#request.cwpage.urlAccount#" >#session.cwclient.cwCustomerName#</a>'>
		<cfelse>
			<cfset displayName = session.cwclient.cwCustomerName>
		</cfif>
		<!--- <cfset loggedInText = 'Logged in as ' & displayName> --->
		<cfset loggedInText = displayName>
		<!--- <cfset cartlinks = listAppend(cartlinks,'<span class="CWloggedInAs">#loggedInText#</span>','|')> --->
		<cfset cartlinks = listAppend(cartlinks,'#loggedInText#','|')>
	</cfif>
	<!--- my account --->
	<cfif attributes.show_account>
		<cfset accountLink = '<a href="#request.cwpage.urlAccount#" >My Account</a>'>
		<cfset cartlinks = listAppend(cartlinks,accountLink,'|')>
	</cfif>
	<!--- log out --->
	<cfif attributes.show_logout>
		<cfset logoutLink = '<a  href="#replace(attributes.logout_url,'?&','?')#">Log Out</a>'>
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
		<cfoutput>#cc#

</cfoutput>
		</li>
	</cfloop>

</cfif> --->
<!--- DISPLAY LINKS --->
<!--- <cfset loopCt = 0>
<cfset totalCt = listLen(cartlinks,'|')>
<cfif totalCt gt 0>
	<ul class="nav navbar-nav navbar-right" <cfif len(trim(attributes.element_id))> id="<cfoutput>#attributes.element_id#</cfoutput>"</cfif>>
	<cfloop list="#cartLinks#" index="cc" delimiters="|">
		<cfset loopCt = loopCt + 1>
		<li><cfoutput>#cc#<!--- <cfif loopCt lt totalCt>#attributes.delimiter#</cfif> ---></cfoutput></li>
	</cfloop>
	</ul>
</cfif> --->
<!--- #itemCountText#

cart_total <a href="##" class="nav-text">#lsCurrencyFormat(attributes.cart_total,'local')#</a>

viewCartLink <a  href="#request.cwpage.urlShowCart#?returnurl=#urlEncodedFormat(attributes.return_url)#">View Cart</a> --->


<div id="cart-div-top" class="pull-right">
	<div class="btn-group" id="">
	  <a href='<cfoutput>#request.cwpage.urlShowCart#?returnurl=#urlEncodedFormat(attributes.return_url)#</cfoutput>'
		class="btn btn-danger"><i class="fa fa-shopping-cart"></i> Cart  <cfoutput>#itemCountText#</cfoutput></a>
	  <a href="#" class="btn btn-danger dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></a>

	  <cfset loopCt = 0>
		<cfset totalCt = listLen(cartlinks,'|')>
		<cfif totalCt gt 0>
			<ul class="dropdown-menu" <cfif len(trim(attributes.element_id))> id="<cfoutput>#attributes.element_id#</cfoutput>"</cfif>>
			<cfloop list="#cartLinks#" index="cc" delimiters="|">
				<cfset loopCt = loopCt + 1>
				<li><cfoutput>#cc#<!--- <cfif loopCt lt totalCt>#attributes.delimiter#</cfif> ---></cfoutput></li>
			</cfloop>
			</ul>
		</cfif>
	</div>
</div>

<!--- DISPLAY LINKS --->
<!--- <cfset loopCt = 0>
<cfset totalCt = listLen(cartlinks,'|')>
<cfif totalCt gt 0>

	<cfloop list="#cartLinks#" index="cc" >
		<li>
		<cfoutput>#cc#</cfoutput>
		</li>
	</cfloop>
</cfif> --->


