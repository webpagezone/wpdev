

	<!--- if order has been placed, but not cleared from client scope,
		  hide cart/customer links on processing pages --->
	<cfif NOT (
				(request.cw.thisPage eq listLast(request.cwpage.urlCheckout,'/') or request.cw.thisPage eq listLast(request.cwpage.urlConfirmOrder,'/'))
				AND isDefined('session.cwclient.cwCompleteOrderID')
				AND session.cwclient.cwCompleteOrderID neq '0'
			)>



<!--- message for checkout page --->
	<cfelseif request.cw.thisPage eq listLast(request.cwpage.urlCheckout,'/')>
		<p>Additional information or payment may be required. Complete the checkout process below</p>
	<cfelseif request.cw.thisPage eq listLast(request.cwpage.urlConfirmOrder,'/')>
		<!--- message for confirmation page may be shown here --->
	</cfif>
	<!--- /end hide content --->


	<!--- if order has been placed, but not cleared from client scope,
		  hide cart/customer links on processing pages --->
	<cfif NOT (
				(request.cw.thisPage eq listLast(request.cwpage.urlCheckout,'/') or request.cw.thisPage eq listLast(request.cwpage.urlConfirmOrder,'/'))
				AND isDefined('session.cwclient.cwCompleteOrderID')
				AND session.cwclient.cwCompleteOrderID neq '0'
			)>

	<!--- determine whether cart total includes tax --->
		<cfif application.cw.taxDisplayOnProduct>
			<cfset request.cwpage.totals_tax_type = application.cw.taxCalctype>
		<cfelse>
			<cfset request.cwpage.totals_tax_type = 'none'>
		</cfif>
		<!--- cart links --->

		<cfmodule template="../mod/cw-mod-customerlinks_cart_cust.cfm"
				  return_url="#request.cwpage.returnUrl#"
					  show_item_count="true"
					  show_cart_total="true"
					  show_view_cart="true"
					  show_loggedinas="false"
					  show_account="false"
					  show_checkout="true"
					  element_id="CWcartLinks"
					  tax_calc_method="#request.cwpage.totals_tax_type#"
				  	>

<!--- message for checkout page --->
	<cfelseif request.cw.thisPage eq listLast(request.cwpage.urlCheckout,'/')>
		<p>Additional information or payment may be required. Complete the checkout process below</p>
	<cfelseif request.cw.thisPage eq listLast(request.cwpage.urlConfirmOrder,'/')>
		<!--- message for confirmation page may be shown here --->
	</cfif>
	<!--- /end hide content --->

