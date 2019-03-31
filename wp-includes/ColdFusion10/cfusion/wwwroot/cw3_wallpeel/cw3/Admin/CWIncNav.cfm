<script language="JavaScript" type="text/javascript" src="assets/global.js"></script>
<div id="divHelp" style="float: right; margin-right: 10px;">
	<a href="helpfiles/AdminHelp.cfm?HelpFileName=<cfoutput>#request.ThisPage#</cfoutput>" target="_blank"> <img src="assets/images/cwContextHelp.gif" alt="Get Help" width="16" height="16" align="absmiddle"></a>
</div>
<div id="leftNav">
<div id="divLogo"><a href="AdminHome.cfm"><img src="assets/images/logo.gif" alt="Cartweaver Logo" width="168" height="87" border="0" id="imgLogo" /></a></div>
	<a href="javascript:;" id="lnProducts" onClick="dwfaq_ToggleOMaticClass(this,'lnProducts','leftNavOpen');dwfaq_ToggleOMaticDisplay(this,'lnSubProducts');return document.MM_returnValue" class="leftNav">Products</a>
	<div id="lnSubProducts" class="lnSubMenu" style="display: none;">
		<a href="ProductForm.cfm">&#8211;Add New</a>
		<a href="ProductActive.cfm">&#8211;Active Products</a>
		<a href="ProductArchive.cfm">&#8211;Archived Products</a>
	</div>
	
	<a href="javascript:;" class="leftNav" id="lnOrders" onClick="dwfaq_ToggleOMaticClass(this,'lnOrders','leftNavOpen');dwfaq_ToggleOMaticDisplay(this,'lnSubOrders');return document.MM_returnValue">Orders</a>
	<div id="lnSubOrders" class="lnSubMenu" style="display: none;">
		<a href="Orders.cfm">&#8211;Search By Date</a>
		<cfoutput>#Application.ShipStatusMenu#</cfoutput>
	</div>
	
	<a href="javascript:;" class="leftNav" id="lnCustomers" onClick="dwfaq_ToggleOMaticClass(this,'lnCustomers','leftNavOpen');dwfaq_ToggleOMaticDisplay(this,'lnSubCustomers');return document.MM_returnValue">Customers</a>
 	<div id="lnSubCustomers" class="lnSubMenu" style="display: none;">
		<a href="Customers.cfm">&#8211;Customer Search</a>
	</div>
	
	<a href="javascript:;" class="leftNav" id="lnCategories" onClick="dwfaq_ToggleOMaticClass(this,'lnCategories','leftNavOpen');dwfaq_ToggleOMaticDisplay(this,'lnSubCategories');return document.MM_returnValue">Categories</a>
 	<div id="lnSubCategories" class="lnSubMenu" style="display: none;">
		<a href="ListCategories.cfm">&#8211;Main</a>
		<a href="ListScndCategories.cfm">&#8211;Secondary</a>
	</div>
	
	<a href="javascript:;" class="leftNav" id="lnOptions" onClick="dwfaq_ToggleOMaticClass(this,'lnOptions','leftNavOpen');dwfaq_ToggleOMaticDisplay(this,'lnSubOptions');return document.MM_returnValue">Options</a>
	<div id="lnSubOptions" class="lnSubMenu" style="display: none;">
		<a href="Options.cfm">&#8211;Add New</a>
		<cfoutput>#Application.OptionsMenu#</cfoutput>
	</div>
	
	<a href="javascript:;" class="leftNav" id="lnDiscounts" onClick="dwfaq_ToggleOMaticClass(this,'lnDiscounts','leftNavOpen');dwfaq_ToggleOMaticDisplay(this,'lnSubDiscounts');return document.MM_returnValue">Discounts</a>
 	<div id="lnSubDiscounts" class="lnSubMenu" style="display: none;">
		<a href="DiscountDetails.cfm">&#8211;Add Discount</a>
		<a href="ListDiscounts.cfm?DiscountView=1">&#8211;Active Discounts</a>
		<a href="ListDiscounts.cfm?DiscountView=0">&#8211;Archived Discounts</a>
	</div>
	
	<a href="javascript:;" class="leftNav" id="lnShippingTax" onClick="dwfaq_ToggleOMaticClass(this,'lnShippingTax','leftNavOpen');dwfaq_ToggleOMaticDisplay(this,'lnSubShippingTax');return document.MM_returnValue">Shipping/Tax</a>
	<div id="lnSubShippingTax" class="lnSubMenu" style="display: none;">
		<!---<a href="ShipSettings.cfm">&#8211;Settings</a>--->
		<a href="ShipMethods.cfm">&#8211;Methods</a>
		<a href="ShipRange.cfm">&#8211;Range</a>
		<cfif Application.TaxSystem NEQ "Groups">
		<a href="ShipStateProv.cfm">&#8211;Tax/Ship Extension</a>
		<cfelse>
		<a href="ShipStateProv.cfm">&#8211;Ship Extension</a>
		<a href="ListTaxGroups.cfm">&#8211;Tax Groups</a>
		<a href="ListTaxRegions.cfm">&#8211;Tax Regions</a>
		</cfif>
	</div>
	
	<a href="javascript:;" class="leftNav" id="lnSettings" onClick="dwfaq_ToggleOMaticClass(this,'lnSettings','leftNavOpen');dwfaq_ToggleOMaticDisplay(this,'lnSubSettings');return document.MM_returnValue">Store Settings</a>
	<div id="lnSubSettings" class="lnSubMenu" style="display: none;">
		<a href="ListAdminUsers.cfm">&#8211;Admin Users</a>
		<a href="ListCountry.cfm">&#8211;Countries</a>
		<a href="ListCreditCard.cfm">&#8211;Credit Cards</a>
		<a href="ListShipStatus.cfm">&#8211;Ship/Order Status</a>
		<cfif IsDefined('Session.AccessLevel') AND Session.AccessLevel EQ 'superadmin'>
			<!--- Show the config list page --->
			<a href="ListConfigGroups.cfm">&#8211;Config Groups</a>
		</cfif>
		<cfquery name="rsNavConfigGroups" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
		SELECT configgroup_name, configgroup_id 
		FROM tbl_configgroup 
		<cfif Not IsDefined('Session.AccessLevel') OR Session.AccessLevel NEQ 'superadmin'>
			WHERE configgroup_showmerchant = 1
		</cfif>
		ORDER BY configgroup_sort, configgroup_name
		</cfquery>
		<cfoutput query="rsNavConfigGroups">
			<a href="Config.cfm?id=#configgroup_id#">&##8211;#configgroup_name#</a>
		</cfoutput>
		<cfif IsDefined('Session.AccessLevel') AND Session.AccessLevel EQ 'superadmin' AND Application.EnableDebugging EQ "True">
			<cfset cwQueryString = cgi.QUERY_STRING>
			<cfif cwQueryString NEQ "">
				<cfset tempPos = ListContainsNoCase(cwQueryString, "debug=","&")>
				<cfif tempPos NEQ 0>
					<cfset cwQueryString =ListDeleteAt(cwQueryString,tempPos,"&")>
				</cfif>
				<cfset cwQueryString = Replace(cwQueryString,"&","&amp;","all")>
			</cfif>
			<cfoutput><a href="#request.thisPage#?debug=#Application.StorePassword#&amp;#cwQueryString#">&##8211;Debugging #Session.DebugStatus#</a></cfoutput>
		</cfif>
	</div>

	<cfif Application.companyemail EQ "support@cartweaver.com">
	<p class="smallprint"><strong>Please change your <a href="Config.cfm?id=3">company
	      email</a>. It is currently
	    set to the Cartweaver default value.</strong></p>
	</cfif>
	<p class="smallprint"><a href="<cfoutput>#Application.SiteRoot#</cfoutput>">Back to store</a></p>
<div id="logOut">
<form name="theFrom" method="post" action="Logout.cfm">
  <input type="submit" name="Submit" value="Log Out" class="formButton">
</form>
</div>
</div>
<cfif IsDefined("strSelectNav")>
<script type="text/javascript">
<!--
<cfoutput>
dwfaq_ToggleOMaticClass(this,'ln#strSelectNav#','leftNavOpen');
dwfaq_ToggleOMaticDisplay(this,'lnSub#strSelectNav#');
</cfoutput>
-->
</script>
</cfif>
