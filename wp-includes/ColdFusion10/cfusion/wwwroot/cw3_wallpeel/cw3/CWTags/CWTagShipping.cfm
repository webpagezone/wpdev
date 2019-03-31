<!--- 
================================================================
Application Info: Cartweaver© 2002 - 2007, All Rights Reserved.
Developer Info: Application Dynamics Inc.
                1560 NE 10th
                East Wenatchee, WA 98802
Support Info: http://www.cartweaver.com/go/cfhelp
				
Cartweaver Version: 3.0.7  -  Date: 7/8/2007
================================================================
Name:  CWTagShipping.cfm
Description: Calculate shipping - 
There are three possible variables used for calculating shipping; 
a base shipping fee, shipping by range, and a shipping 
extension by location.  Shipping charges can be a result of any 
one of there or a combination. This criteria is set in the admin 
section on the Company Information Page. 
================================================================
............................................................................
Attributes: 
    shiptype = "localcalc"  -  ( Default )
		localcalc = Calculate shipping localy using shipping data in database
		This is the only option available at this time.
		
		mode = "ShipList" - (Default)
			ShipList - Return a query (rsGetShipMethods) with a list of valid shipping
			methods. Return Request.ShipPref with the chose valid shipping
			methods. Return Client.ShipPref with the chose valid shipping
				method
			Calculation - Perform the shipping calculation and set Client.ShipTotal
				to the final shipping total for the customer.
............................................................................
--->

<cffunction name="getShippingRates">
	<cfargument name="Mode" default="ShipList" />
	<cfargument name="ShipType" default="#Application.ShipCalcType#" />
	<cfargument name="ShipToCountryID" default="0" />
	<cfargument name="CartWeight" default="0" />
	<cfargument name="CartTotal" default="0" />
	
	<!--- Determine by what Criteria shipping cost will be calculated as set in the application scope--->
	<cflock timeout="8" throwontimeout="no" type="exclusive" scope="application">
		<cfset ShipBase = application.ChargeShipBase>
		<cfset ShipByRange = False>
		<!---<cfset ShipByWeight = application.ChargeShipByWeight>--->
		<cfset ShipExt = application.ChargeShipExtension>
		<cfset ShipEnabled = application.EnableShipping>
		<cfset ChargeShipBy = Application.ChargeShipBy>
	</cflock>
	
	<!--- Determine whether to charge by weight, cost, or neither --->
	<cfif ChargeShipBy NEQ "None">
		<cfset ShipByRange = True>
		<cfif ChargeShipBy EQ "Subtotal">
			<cfset rangeValue = CartTotal>
		<cfelseif ChargeShipBy EQ "Weight">
			<cfset rangeValue = CartWeight>
		</cfif>
	</cfif>
	
	<!--- If shipping is enabled continue through the custom tag, otherwise don't do anything --->
	<cfif ShipEnabled EQ 1>
		<cfswitch expression="#Arguments.mode#">
			<cfcase value="ShipList">
				<cfif ShipByRange EQ False>
					<cfquery name="rsShippingMethods" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
					SELECT * 
					FROM tbl_shipmethod, tbl_shipmethcntry_rel 
					WHERE 
						shpmet_cntry_Country_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#Arguments.ShipToCountryID#" /> 
						AND shpmet_cntry_Meth_ID = shipmeth_ID 
						AND shipmeth_archive = 0 
					ORDER BY
						shipmeth_Sort ASC
					</cfquery>
				<cfelse>
					
					<!--- If you're charging by weight, then only show those shipping methods that are available
					for the weight in the cart --->
					<cfquery name="rsShippingMethods" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
						SELECT 
							Min(r.ship_range_From) AS MinOfship_range_From,
							Max(r.ship_range_To) AS MaxOfship_range_To, 
							m.shipmeth_ID,
							m.shipmeth_Name, 
							c.shpmet_cntry_Country_ID, 
							m.shipmeth_Sort,
							m.shipmeth_Archive
						FROM 
							(tbl_shipmethcntry_rel c
							INNER JOIN tbl_shipmethod m
							ON c.shpmet_cntry_Meth_ID = m.shipmeth_ID) 
							INNER JOIN tbl_shipranges r
							ON m.shipmeth_ID = r.ship_range_Method_ID 
						GROUP BY 
							m.shipmeth_ID,
							m.shipmeth_Name, 
							c.shpmet_cntry_Country_ID, 
							m.shipmeth_Sort,
							m.shipmeth_archive
						HAVING 
							(Min(r.ship_range_From) <= <cfqueryparam cfsqltype="cf_sql_float" value="#rangeValue#" />)
							AND (Max(r.ship_range_To) >= <cfqueryparam cfsqltype="cf_sql_float" value="#rangeValue#" />)
							AND (c.shpmet_cntry_Country_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#Arguments.ShipToCountryID#" />)
							AND (m.shipmeth_archive = 0)
						ORDER BY 
							m.shipmeth_Sort
					</cfquery>
				</cfif>
				<cfif rsShippingMethods.recordcount EQ 0>
					<!--- There are no shipping methods for the user's locale --->
					<!--- Set the shipping preference to 0 for use on CWIncShowCart.cfm --->
					<cfset Client.ShipPref = 0>
				<cfelse>
					<!--- We have at least one shipping method --->
					<!--- Since we've already got our shipping list, go ahead and set the user's current selection. --->
					<cfset ShipList = ValueList(rsShippingMethods.shipmeth_ID)>

					<!--- If the currently selected ship preference is no longer valid, set the default. --->
					<cfif ListFind(ShipList,Client.ShipPref) IS 0>
						<!--- Set default for the current ship-to country --->
						<cfset Client.ShipPref = ListFirst(ShipList)>
					</cfif>
					<!---
					<cfmodule template="CWTagShipping.cfm" mode="Calculate">
					--->
				</cfif>
				<!--- rsShippingMethods.recordcount EQ 0 --->
				<cfreturn rsShippingMethods />
			</cfcase>
			<!--- value="ShipList" --->
			<cfcase value="Calculate">
				<cfswitch expression="#Arguments.shiptype#">
					<cfcase value="localcalc">
						<!--- Perform local shipping calculation --->
						<cfif Client.ShipPref EQ 0>
							<!--- Customer has not made a valid shipping selection, so don't calculate totals --->
							<cfreturn 0 />
						<cfelse>
							<!--- Client.ShipPref NEQ 0 --->
							<!--- Get all customer's products that charge shipping. --->
							<cfquery name="rsCheckShipCharge" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
							SELECT 
								p.product_shipchrg 
							FROM tbl_cart c
								INNER JOIN (tbl_products p
									INNER JOIN tbl_skus s
									ON p.product_ID = s.SKU_ProductID) 
								ON c.cart_sku_ID = s.SKU_ID
							WHERE 
								c.cart_custcart_ID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Client.CartID#" /> 
								AND p.product_shipchrg = 1
							</cfquery>
		
							<!--- Set default values for base and weight charges --->
							<cfparam name="BaseShipRate" default="0">
							<cfparam name="RangeRate" default="0">
				
							<!--- If we have products that require shipping --->
							<cfif rsCheckShipCharge.recordcount NEQ 0>
		
								<!--- Get the base shipping rate for the users shipping preference --->
								<cfif ShipBase EQ 1>
									<cfquery name="rsGetShipRate" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
									SELECT 
										shipmeth_Rate, 
										shipmeth_ID, 
										shipmeth_Name 
									FROM tbl_shipmethod 
									WHERE 
										shipmeth_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#Client.ShipPref#" /> 
										AND shipmeth_archive = 0
									</cfquery>
									<cfif rsGetShipRate.recordcount NEQ 0>
										<cfset BaseShipRate = rsGetShipRate.shipmeth_Rate>
									</cfif>
								</cfif>
								<!--- ShipBase EQ 1 --->
								
								<!--- If Weight Range Rate rate is being charged --->
								<cfif ShipByRange EQ True>
									<cfquery name="rsGetWeightRate" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
									SELECT ship_range_Amount 
									FROM tbl_shipranges	
									WHERE 
										ship_range_Method_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#Client.ShipPref#" />
										AND ship_range_From <= <cfqueryparam cfsqltype="cf_sql_float" value="#rangeValue#" /> 
										AND ship_range_To >= <cfqueryparam cfsqltype="cf_sql_float" value="#rangeValue#" />
									</cfquery>
									<!--- If the selected shipping rate doesn't have the correct weight range, choose the first that does --->
									<cfif rsGetWeightRate.RecordCount NEQ 0>
										<cfset RangeRate = rsGetWeightRate.ship_range_Amount >
									</cfif>
								</cfif>
								<!--- ShipByWeight EQ 1 --->
	
								<!--- Set Shipping sub total prior to Extension calculation --->
								<cfset ShipSubTotal = 0>
								<cfset ShipSubTotal =  ShipSubTotal + (BaseShipRate + RangeRate)>
								<!--- Calculate Shipping Total --->
								<!--- If the shipping extension is to be factored in do so, otherwise Tally shipping without it. --->
								<cfif ShipExt EQ 1>
									<cfset ShipSubTotal = ShipSubTotal + (ShipSubTotal * request.ShipExtension) >
								</cfif>
								<!---<cfdump var="#variables#"><cfabort>--->
								<cfreturn decimalRound(ShipSubTotal) />
							<cfelse>
								<!--- rsCheckShipCharge.recordcount EQ 0 --->
								<cfreturn 0 />
							</cfif>
							<!--- rsCheckShipCharge.recordcount NEQ 0 --->
						</cfif>
						<!--- Client.ShipPref EQ 0 --->
					</cfcase>
					<!--- value="localcalc" --->
				</cfswitch>
				<!--- expression="Arguments.shiptype" --->
			</cfcase>
			<!--- value="Calculate" --->
		</cfswitch>
		<!--- expression="#Arguments.mode#" --->
	<cfelse>
		<!--- shippingEnabled EQ False --->
		<cfset Client.ShipPref = 0>
		<cfreturn 0 />
	</cfif>
	<!--- shippingEnabled EQ True --->
</cffunction>