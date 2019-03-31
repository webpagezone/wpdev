<div id="helpNav"> 
    <h3>Help by Page Name</h3> 
<cfset callingPage = #request.ThisPage#>
<!--- Declare each page, text link on a line by line basis for easier reading --->
<cfset helpNavLinks =
"AdminHome.cfm,Admin Home,
ListAdminUsers.cfm,Admin Users,
ListCategories.cfm,Categories,
CompanyInfo.cfm,Company Information,
ListConfigGroups.cfm,Configuration,
ConfigGroup.cfm,Configuration Group,
ConfigItem.cfm,Configuration Item,
ListCountry.cfm,Countries,
ListCreditCard.cfm,Credit Cards,
CustomerDetails.cfm,Customer Details,
ListDiscounts.cfm,List Discounts,
DiscountDetails.cfm, Discount Details,
Customers.cfm,Customers,
Options.cfm,Options,
Orders.cfm,Orders,
OrderDetails.cfm,Orders Details,
ProductActive.cfm,Products-Active,
ProductArchive.cfm,Products-Archived,
ProductForm.cfm,Product Details,
ProductImageUpload.cfm,Product Image Upload,
ListShipStatus.cfm,Ship/Order Status,
ShipMethods.cfm,Shipping Methods,
ShipSettings.cfm,Shipping Settings,
ShipRange.cfm,Shipping Ranges,
ShipStateProv.cfm,Tax/Extension,
ListTaxGroups.cfm,Tax Groups,
TaxGroup.cfm,Tax Group,
TaxGroupProducts.cfm,Tax Group Products,
ListTaxRegions.cfm,Tax Regions,
TaxRegion.cfm,Tax Region"
>
<!--- Strip out line breaks to form a continuous string for the help navigation list. --->
<cfset helpNavLinks = Replace(helpNavLinks,","&Chr(10),",","ALL")>
<cfloop from="1" to="#ListLen(helpNavLinks)#" index="i" step="2">
  <cfoutput>
	<a<cfif URL.HelpFileName EQ ListGetAt(helpNavLinks,i)> class="current"</cfif> href="#callingPage#?HelpFileName=#ListGetAt(helpNavLinks,i)#">#ListGetAt(helpNavLinks,i+1)#</a>
  </cfoutput>
</cfloop>
</div> 