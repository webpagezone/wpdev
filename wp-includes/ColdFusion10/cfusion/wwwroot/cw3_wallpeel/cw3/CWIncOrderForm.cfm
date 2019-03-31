<cfsilent>
<!--- 
================================================================
Application Info: Cartweaver© 2002 - 2007, All Rights Reserved.
Developer Info: Application Dynamics Inc.
                1560 NE 10th
                East Wenatchee, WA 98802
Support Info: http://www.cartweaver.com/go/cfhelp
				
Cartweaver Version: 3.0.9  -  Date: 2/18/2008 
================================================================
Name: CWIncOrderForm.cfm
Description: This page allows the user to register for the site
	and enter shipping and billing information. This is the first
	step before credit card details are entered.
================================================================
---> 
<!--- Set Headers to prevent browser cache issues ---> 
<cfset gmt=gettimezoneinfo()> 
<cfset gmt=gmt.utcHourOffset> 
<cfif gmt EQ 0> 
	<cfset gmt=""> 
	<cfelseif gmt GT 0> 
	<cfset gmt="+"&gmt> 
</cfif> 
<cfheader name="Expires" value="#DateFormat(now(), 'ddd, dd mmm yyyy')# #TimeFormat(now(), 'HH:mm:ss')# GMT#gmt#"> 
<cfheader name="Pragma" value="no-cache"> 
<cfheader name="Cache-Control" value="no-cache, no-store, proxy-revalidate, must-revalidate"> 
<!--- Set page variable defaults ---> 
<cfparam name="ThisBillStateID" default="0"> 
<cfparam name="ThisShipStateID" default="0"> 
<cfparam name="ThisBillCountryID" default="0"> 
<cfparam name="ThisShipCountryID" default="0"> 
<cfparam name="request.FieldInvalid" default="NO"> 
<cfparam name="Client.CustomerID" default="0">

<cfparam name="Session.OrderComments" default="">
<cfparam name="Application.ShowShippingInfo" default="true" />
<cfset ShowShippingInfo = Application.ShowShippingInfo />

<!--- If the order form has been submitted process the customer data and move 
      on to the final "Show Invoice" page. ---> 
<cfif IsDefined ('FORM.OrderFormNext')> 
	<!--- Vailidate form field entries --->
	<cfset Session.OrderComments = Form.cstComments>
	<cfmodule template="CWTags/CWTagValidateOrderForm.cfm"> 
	<!--- If there are no errors ---> 
	<cfif request.FieldInvalid NEQ "Yes"> 
		<!--- If this is a new customer --->
		<cfif client.CustomerID EQ 0> 
			<!--- Add a new user --->
			<cfmodule template="CWTags/CWTagCustomerAction.cfm" action = "New" >
		<cfelse> 
			<!--- Update a returning customer --->
			<cfmodule template="CWTags/CWTagCustomerAction.cfm" action = "Return" >
		</cfif> 
	<cfelse>
		<!--- We don't have a user, don't allow the user to checkout. Delete the checkingout client variable --->
		<cfset DeleteClientVariable("CheckingOut")> 
	</cfif> 
</cfif> 
<!--- Get states for select menus ---> 
<cfquery name="rsGetStates" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
SELECT tbl_list_countries.country_ID, tbl_stateprov.stprv_ID, tbl_list_countries.country_Name, tbl_stateprov.stprv_Name, tbl_list_countries.country_DefaultCountry
FROM tbl_list_countries INNER JOIN tbl_stateprov ON tbl_list_countries.country_ID = tbl_stateprov.stprv_Country_ID
WHERE tbl_list_countries.country_Archive = 0 AND tbl_stateprov.stprv_Archive = 0
ORDER BY tbl_list_countries.country_Sort, tbl_list_countries.country_Name, tbl_stateprov.stprv_Name
</cfquery> 
<!--- ///////////// Get Customer Data //////////////////  ---> 
<!--- get customer information ---> 
<cfquery name="rsGetCustomerData" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
SELECT *
FROM tbl_customers
WHERE cst_ID = '#Client.CustomerID#' 
</cfquery> 

<cfif rsGetCustomerData.RecordCount NEQ 0> 
	<!--- get customer Bill To state ID ---> 
	<cfquery name="rsBillStateProv" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
	SELECT tbl_custstate.CustSt_StPrv_ID, tbl_list_countries.country_ID
	FROM (tbl_list_countries INNER JOIN tbl_stateprov ON tbl_list_countries.country_ID = tbl_stateprov.stprv_Country_ID) 
	INNER JOIN tbl_custstate ON tbl_stateprov.stprv_ID = tbl_custstate.CustSt_StPrv_ID
	WHERE tbl_custstate.CustSt_Cust_ID = '#Client.CustomerID#' AND tbl_custstate.CustSt_Destination = 'BillTo'
	</cfquery> 
	<cfset ThisBillStateID = rsBillStateProv.CustSt_StPrv_ID>
	<cfset ThisBillCountryID = rsBillStateProv.country_ID>
	<!--- get customer Bill To state ID ---> 
	<cfquery name="rsShipStateProv" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
	SELECT tbl_custstate.CustSt_StPrv_ID, tbl_list_countries.country_ID
	FROM (tbl_list_countries INNER JOIN tbl_stateprov ON tbl_list_countries.country_ID = tbl_stateprov.stprv_Country_ID) 
	INNER JOIN tbl_custstate ON tbl_stateprov.stprv_ID = tbl_custstate.CustSt_StPrv_ID
	WHERE tbl_custstate.CustSt_Cust_ID = '#Client.CustomerID#' AND tbl_custstate.CustSt_Destination = 'ShipTo'
	</cfquery> 
	<cfset ThisShipStateID = rsShipStateProv.CustSt_StPrv_ID> 
	<cfset ThisShipCountryID = rsShipStateProv.country_ID>
	<cfif IsDefined("Application.ChargeTaxBasedOn") AND Application.ChargeTaxBasedOn EQ "Billing">
		<cfset Client.TaxStateID = ThisBillStateID />
		<cfset Client.TaxCountryID = ThisBillCountryID />
	<cfelse>
		<cfset Client.TaxStateID = ThisShipStateID />
		<cfset Client.TaxCountryID = ThisShipCountryID />
	</cfif>
</cfif>

<cfset intListCounter = 0>
<cfsavecontent variable="headcontent">
<script language="JavaScript" src="cw3/assets/scripts/dropdowns.js" type="text/javascript"></script>
<script language="JavaScript" type="text/javascript">
	var arrDynaList = new Array();
	var arrDL1 = new Array();
	var arrDL2 = new Array();
	<cfparam name="rowCounter" default="1">
	arrDL1[1] = "cstCountry";
	arrDL1[2] = "PlaceOrder";
	arrDL1[3] = "cstStateProv";
	arrDL1[4] = "PlaceOrder";
	arrDL1[5] = arrDynaList;
	arrDL2[1] = "cstShpCountry";
	arrDL2[2] = "PlaceOrder";
	arrDL2[3] = "cstShpStateProv";
	arrDL2[4] = "PlaceOrder";
	arrDL2[5] = arrDynaList;
	//Explanation:
	//Element 1: Parent relationship
	//Element 2: Child Label
	//Element 3: Child Value
 <cfoutput query="rsGetStates">
	arrDynaList[#intListCounter#] = "#country_ID#";
	<cfset intListCounter = IncrementValue(intListCounter)>
	arrDynaList[#intListCounter#] = "#stprv_Name#";
	<cfset intListCounter = IncrementValue(intListCounter)>
	arrDynaList[#intListCounter#] = "#stprv_ID#";
	<cfset intListCounter = IncrementValue(intListCounter)>
 </cfoutput> 
</script> 

</cfsavecontent>
<cfhtmlhead text="#headcontent#">
</cfsilent>
<cfprocessingdirective suppresswhitespace="yes"> 
<cfif client.CustomerID NEQ 0> 
	<h1>Welcome back <cfoutput>#rsGetCustomerData.cst_FirstName# #rsGetCustomerData.cst_LastName#</cfoutput>! <span class="smallprint">[<a href="<cfoutput>#request.ThisPage#</cfoutput>?logout=yes">Not <cfoutput>#rsGetCustomerData.cst_FirstName#</cfoutput>?</a>]</span></h1> 
	<cfelse> 
	<cfinclude template="CWIncLoginForm.cfm">
</cfif> 
<cfif request.FieldInvalid EQ "Yes">
	<p><strong>* Please be sure to fill in all Required fields.</strong></p> 
</cfif> 
<form name="PlaceOrder" method="post" action="<cfoutput>#request.ThisPage#</cfoutput>"> 
	<p> * Required fields</p> 
	<cfif IsDefined ('request.UserError')>
		<p class="errorMessage"><cfoutput>#request.UserError#</cfoutput></p>
	</cfif>
	<cfif IsDefined ('request.EmailError')>
		<p class="errorMessage"><cfoutput>#request.EmailError#</cfoutput></p>
	</cfif>
	<table class="tabularData">
	<tr>
		<th colspan="2">Customer Information</th>
	  </tr>
	<tr class="altRowEven" >
		<td align="right"><cfif IsDefined ('request.CST_COUNTRY_ERROR')>
			<span class="errorMessage">Country</span>
			<cfelse>
			Country
		  </cfif>
	  </td>
		<td><cfparam name="FORM.cstCountry" default="#ThisBillCountryID#">
		<cfparam name="FORM.cstCountry" default="0">
		<select name="cstCountry" onChange="setDynaList(arrDL1)">
			<option value="forgot" selected="selected">Choose Country</option>
			<cfoutput query="rsGetStates" group="country_Name">
			<option value="#country_ID#"<cfif country_ID EQ FORM.cstCountry OR (FORM.cstCountry EQ 0 AND country_DefaultCountry EQ 1)> selected</cfif>>#country_Name#</option>
		  </cfoutput>
		  </select>
		* </td>
	  </tr>
	<tr class="altRowOdd" >
		<td align="right"><cfif IsDefined ('request.CST_FIRSTNAME_ERROR')>
			<span class="errorMessage">First Name</span>
			<cfelse>
			First Name
		  </cfif>
	  </td>
		<td><cfparam name="FORM.cstFirstName" default="#rsGetCustomerData.cst_FirstName#">
		<input name="cstFirstName" type="text" value="<cfoutput>#FORM.cstFirstName#</cfoutput>" >
		* </td>
	  </tr>
	<tr class="altRowEven" >
		<td align="right"><cfif IsDefined ('request.CST_LASTNAME_ERROR')>
			<span class="errorMessage">Last Name</span>
			<cfelse>
			Last Name
		  </cfif>
	  </td>
		<td><cfparam name="FORM.cstLastName" default="#rsGetCustomerData.cst_LastName#">
		<input name="cstLastName" type="text" value="<cfoutput>#FORM.cstLastName#</cfoutput>">
		* </td>
	  </tr>
	<tr class="altRowOdd" >
		<td align="right"><cfif IsDefined ('request.CST_ADDRESS1_ERROR')>
			<span class="errorMessage">Address 1</span>
			<cfelse>
			Address 1
		  </cfif>
	  </td>
		<td><cfparam name="FORM.cstAddress1" default="#rsGetCustomerData.cst_Address1#">
		<input name="cstAddress1" type="text" value="<cfoutput>#FORM.cstAddress1#</cfoutput>">
		* </td>
	  </tr>
	<tr class="altRowEven" >
		<td align="right"><cfif IsDefined ('request.CST_ADDRESS2_ERROR')>
			<span class="errorMessage">Address 2</span>
			<cfelse>
			Address 2
		  </cfif>
	  </td>
		<td><cfparam name="FORM.cstAddress2" default="#rsGetCustomerData.cst_Address2#">
		<input name="cstAddress2" type="text" value="<cfoutput>#FORM.cstAddress2#</cfoutput>">
	  </td>
	  </tr>
	<tr class="altRowOdd" >
		<td align="right"><cfif IsDefined ('request.CST_CITY_ERROR')>
			<span class="errorMessage">City</span>
			<cfelse>
			City
		  </cfif>
	  </td>
		<td><cfparam name="FORM.cstCity" default="#rsGetCustomerData.cst_City#">
		<input name="cstCity" type="text" value="<cfoutput>#FORM.cstCity#</cfoutput>">
		* </td>
	  </tr>
	<tr class="altRowEven" >
		<td align="right"><cfif IsDefined ('request.CST_STATEPROV_ERROR')>
			<span class="errorMessage">State or Province</span>
			<cfelse>
			State or Province
		  </cfif>
	  </td>
		<td><cfparam name="FORM.cstStateProv" default="#ThisBillStateID#">
		<select name="cstStateProv">
			<option value="forgot" selected="selected">Choose a State or Province</option>
			<cfoutput query="rsGetStates" group="country_Name">
			<option value="forgot">----- #country_Name#</option>
			<cfoutput>
				<option value="#stprv_ID#"<cfif FORM.cstStateProv EQ rsGetStates.stprv_ID> selected="selected"</cfif>>#stprv_Name#</option>
			</cfoutput></cfoutput>
		  </select>
		* </td>
	  </tr>
	<tr class="altRowOdd" >
		<td align="right"><cfif IsDefined ('request.CST_ZIP_ERROR')>
			<span class="errorMessage">Zip or Postal Code</span>
			<cfelse>
			Zip or Postal Code
		  </cfif>
	  </td>
		<td><cfparam name="FORM.cstZip" default="#rsGetCustomerData.cst_Zip#">
		<input name="cstZip" type="text" value="<cfoutput>#FORM.cstZip#</cfoutput>">
		* </td>
	  </tr>
	<tr class="altRowEven" >
		<td align="right"><cfif IsDefined ('request.CST_PHONE_ERROR')>
			<span class="errorMessage">Phone</span>
			<cfelse>
			Phone
		  </cfif>
	  </td>
		<td><cfparam name="FORM.cstPhone" default="#rsGetCustomerData.cst_Phone#">
		<input name="cstPhone" type="text" value="<cfoutput>#FORM.cstPhone#</cfoutput>">
		* </td>
	  </tr>
	<tr class="altRowOdd" >
		<td align="right"><cfif IsDefined ('request.CST_EMAIL_ERROR')>
			<span class="errorMessage">Email Address</span>
			<cfelse>
			Email Address
		  </cfif>
	  </td>
		<td><cfparam name="FORM.cstEmail" default="#rsGetCustomerData.cst_Email#">
		<input name="cstEmail" type="text" value="<cfoutput>#FORM.cstEmail#</cfoutput>">
		* </td>
	  </tr>
	<tr class="altRowEven" >
		<td align="right"><cfif IsDefined ('request.CST_USERNAME_ERROR')>
			<span class="errorMessage">Username</span>
			<cfelse>
			Username
		  </cfif>
	  </td>
		<td><cfparam name="FORM.cstUsername" default="#rsGetCustomerData.cst_Username#">
		<input name="cstUsername" type="text" value="<cfoutput>#FORM.cstUsername#</cfoutput>">
		* </td>
	  </tr>
	<tr class="altRowOdd" >
		<td align="right"><cfif IsDefined ('request.CST_PASSWORD_ERROR')>
			<span class="errorMessage">Password</span>
			<cfelse>
			Password
		  </cfif>
	  </td>
		<td><cfparam name="FORM.cstPassword" default="#rsGetCustomerData.cst_Password#">
		<input name="cstPassword" type="password" value="<cfoutput>#FORM.cstPassword#</cfoutput>">
		* </td>
	  </tr>
	<tr class="altRowEven" >
		<td align="right"><cfif IsDefined ('request.CST_PASSWORD_ERROR')>
			<span class="errorMessage">Confirm Password</span>
			<cfelse>
			Confirm Password
		  </cfif>
	  </td>
		<td><cfparam name="FORM.cstPasswordConfirm" default="#rsGetCustomerData.cst_Password#">
		<input name="cstPasswordConfirm" type="password" value="<cfoutput>#FORM.cstPasswordConfirm#</cfoutput>">
		* </td>
	  </tr>
	  <cfif ShowShippingInfo>
	<tr >
		<th colspan="2"><strong>Shipping Address</strong></th>
	  </tr>
	<tr class="altRowOdd" >
		<td colspan="2" align="center"><input name="ShipSame" type="checkbox" class="formCheckbox" onClick="cwSameShipping(this);" value="Same"<cfif IsDefined('FORM.ShipSame')> checked</cfif>>
		Same <strong> **required if shipping is different</strong></td>
	  </tr>
	<tr class="altRowEven" >
		<td align="right"><cfif IsDefined ('request.CST_SHPCOUNTRY_ERROR')>
			<span class="errorMessage">Country</span>
			<cfelse>
			Country
		  </cfif>
	  </td>
		<td><cfparam name="FORM.cstShpCountry" default="#ThisShipCountryID#">
		<cfset setLists = true>
		<cfparam name="FORM.cstCountry" default="0">
		<select name="cstShpCountry" onChange="setDynaList(arrDL2)">
			<option value="forgot" selected="selected">Choose Country</option>
			<cfoutput query="rsGetStates" group="country_Name">
			<option value="#country_ID#"<cfif country_ID EQ FORM.cstShpCountry OR (FORM.cstShpCountry EQ 0 AND country_DefaultCountry EQ 1)> selected="selected"</cfif>>#country_Name#</option>
		  </cfoutput>
		  </select>
		**</td>
	  </tr>
	<tr class="altRowOdd" >
		<td align="right"><cfif IsDefined ('request.CST_SHPNAME_ERROR')>
			<span class="errorMessage">Shipping Name</span>
			<cfelse>
			Shipping Name
		  </cfif>
	  </td>
		<td><cfparam name="FORM.cstShpName" default="#rsGetCustomerData.cst_ShpName#">
		<input name="cstShpName" type="text" value="<cfoutput>#FORM.cstShpName#</cfoutput>">
		** </td>
	  </tr>
	<tr class="altRowEven" >
		<td align="right"><cfif IsDefined ('request.CST_SHPADDRESS1_ERROR')>
			<span class="errorMessage">Address 1</span>
			<cfelse>
			Address 1
		  </cfif>
	  </td>
		<td><cfparam name="FORM.cstShpAddress1" default="#rsGetCustomerData.cst_ShpAddress1#">
		<input name="cstShpAddress1" type="text" value="<cfoutput>#FORM.cstShpAddress1#</cfoutput>">
		** </td>
	  </tr>
	<tr class="altRowOdd" >
		<td align="right"><cfif IsDefined ('request.CST_SHPADDRESS2_ERROR')>
			<span class="errorMessage">Address 2</span>
			<cfelse>
			Address 2
		  </cfif>
	  </td>
		<td><cfparam name="FORM.cstShpAddress2" default="#rsGetCustomerData.cst_ShpAddress2#">
		<input name="cstShpAddress2" type="text" value="<cfoutput>#FORM.cstShpAddress2#</cfoutput>">
	  </td>
	  </tr>
	<tr class="altRowEven" >
		<td align="right"><cfif IsDefined ('request.CST_SHPCITY_ERROR')>
			<span class="errorMessage">City</span>
			<cfelse>
			City
		  </cfif>
	  </td>
		<td><cfparam name="FORM.cstShpCity" default="#rsGetCustomerData.cst_ShpCity#">
		<input name="cstShpCity" type="text" value="<cfoutput>#FORM.cstShpCity#</cfoutput>">
		** </td>
	  </tr>
	<tr class="altRowOdd" >
		<td align="right"><cfif IsDefined ('request.CST_SHPSTATEPROV_ERROR')>
			<span class="errorMessage">State or Province</span>
			<cfelse>
			State or Province
		  </cfif>
	  </td>
		<td><cfparam name="FORM.cstShpStateProv" default="#ThisShipStateID#">
		<select name="cstShpStateProv">
			<option value="forgot" selected="selected">Choose a State or Province</option>
			<cfoutput query="rsGetStates" group="country_Name">
			<option value="forgot">----- #country_Name#</option>
			<cfoutput>
				<option value="#stprv_ID#"<cfif FORM.cstShpStateProv EQ rsGetStates.stprv_ID> selected="selected"</cfif>>#stprv_Name#</option>
			</cfoutput></cfoutput>
		  </select>
		**</td>
	  </tr>
		<tr class="altRowEven">
			<td align="right"><cfif IsDefined ('request.CST_SHPZIP_ERROR')>
			<span class="errorMessage">Zip or Postal Code</span>
			<cfelse>
			Zip or Postal Code
			</cfif>
			</td>
			<td><cfparam name="FORM.cstShpZip" default="#rsGetCustomerData.cst_ShpZip#">
			<input name="cstShpZip" type="text" value="<cfoutput>#FORM.cstShpZip#</cfoutput>">** </td>
		</tr>
		<cfelse>
			<input type="hidden" name="ShipSame" value="Same" />
		</cfif>
		<tr class="altRowOdd">
		   <td align="right">Comments</td>
		   <td><textarea name="cstComments" cols="60" rows="5"><cfoutput>#Session.OrderComments#</cfoutput></textarea></td>
		</tr>
  </table>
    <input name="OrderFormNext" type="submit" class="formButton" value="NEXT &raquo;"> 
</form>
<cfif isDefined("form.cstStateProv") AND FORM.cstStateProv EQ 0>
<script language="JavaScript" type="text/javascript">setDynaList(arrDL1);
<cfif IsDefined("setLists")>
setDynaList(arrDL2);
</cfif>
</script></cfif>
</cfprocessingdirective> 
