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
Name: Cart Links Custom Tag
Description: This tag displays a "View Cart" link, along with
	the number of items contained in the user's cart.

Attributes:
Returnurl (optional): The returnurl variable is the page that will
	be used for the Continue Shopping link on your View Cart target
	page. If no value is provided for this attribute, the Results
	target page (#request.targetResults#) is used.

================================================================
--->
<cfparam name="attributes.ReturnURL" default="#request.targetResults#">
<cfparam name="CartQuantity" default="0">
<cfset cwCartLinks = "">
<cfif IsDefined ('Client.CartID')>
<cfquery name="rsGetCartCount" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
SELECT SUM(cart_sku_qty) AS CartCount, cart_custcart_ID
FROM tbl_cart
GROUP BY cart_custcart_ID
HAVING cart_custcart_ID = '#Client.CartID#'
</cfquery>
<cfset CartQuantity = LSNumberFormat(rsGetCartCount.CartCount,',999,999')>
<cfset cwCartLinks = "You have <strong>#CartQuantity#</strong> item">
<cfif CartQuantity GT 1 OR CartQuantity EQ 0><cfset cwCartLinks = "#cwCartLinks#s"></cfif>
<cfset cwCartLinks = '<!---#cwCartLinks# in your cart.--->
<a href="#request.targetGoToCart#&amp;returnurl=#URLEncodedFormat(attributes.ReturnURL)#" class="btn btn-danger"><i class="fa fa-shopping-cart"></i>
View Cart
</a> <!---|
<a href="#request.targetCheckOut#">Go to Checkout</a>--->'>
<cfif IsDefined("Application.EnableDebugging")
	AND Application.EnableDebugging EQ true AND isdefined("Application.ShowDebugLink") and Application.ShowDebugLink EQ true>
	<cfset cwQueryString = cgi.QUERY_STRING>
	<cfif cwQueryString NEQ "">
		<cfset tempPos = ListContainsNoCase(cwQueryString, "debug=","&")>
		<cfif tempPos NEQ 0>
			<cfset cwQueryString =ListDeleteAt(cwQueryString,tempPos,"&")>
		</cfif>
		<cfset cwQueryString = Replace(cwQueryString,"&","&amp;","all")>
	</cfif>
	<cfset cwCartLinks = '#cwCartLinks# | <a href="#request.thisPage#?debug=#Application.StorePassword#
	'
	>
	<cfif cwQueryString NEQ ""><cfset cwCartLinks = '#cwCartLinks#&amp;#cwQueryString#'></cfif>
	<cfset cwCartLinks = '#cwCartLinks#">Debugger #Session.DebugStatus#</a>'>
	</cfif>
</cfif>
</cfsilent>




<div id="cart-div-top" class="pull-right">
	<div class="btn-group" id="">

    <cfoutput>#cwCartLinks#</cfoutput>



	<!---  <a href='<cfoutput>#request.cwpage.urlShowCart#?returnurl=#urlEncodedFormat(attributes.return_url)#</cfoutput>'
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
		</cfif>--->
	</div>
</div>