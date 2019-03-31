<cfsilent>
<!---
==========================================================
Application: Cartweaver 4 ColdFusion
Copyright 2002 - 2013, All Rights Reserved
Developer: Application Dynamics, Inc. | Cartweaver.com
Licensing: http://www.cartweaver.com/eula
Support: http://www.cartweaver.com/support
==========================================================
File: cw-inc-cartlinks.cfm
File Date: 2012-09-10
Description: shows cart and customer account links on cart-related pages
NOTES:
cw-mod-customerlinks is called twice with varying options to
create the left/right link grouping. This can be modified at will.
The returnUrl attribute is passed through to the cart,
for continue shopping link on cart page.
==========================================================
--->
</cfsilent>


<!--- log in / logged in as - not shown on confirmation page --->
		<cfif application.cw.customerAccountEnabled
		AND NOT request.cw.thisPage eq listLast(request.cwpage.urlConfirmOrder,'/')>

			<!--- user links --->

			<cfmodule template="../mod/cw-mod-customerlinks_user_cust.cfm"
					  show_login="true"
					  show_logout="true"
					  logout_url="#request.cwpage.logoutUrl#"
					  show_loggedinas="true"
				      show_account="true"
					  element_id="CWaccountLinks"
					  	>



		</cfif>

