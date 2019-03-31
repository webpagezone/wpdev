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
Name: ShipStateProv.cfm
Description: Here we set the states and or province as well as 
set a “Shipping extension” for each. A shipping  extension is a 
multiplier by which the shipping cost is multiplied. The 
resulting amount is then add onto the shipping cost. This “loads” 
or “weights” the state with an addition cost thus allowing us to 
set shipping “zones” based on destination.
================================================================
--->
<!--- Set location for highlighting in Nav Menu --->
<cfset strSelectNav = "ShippingTax">
<!--- Set Page Archive Status --->
<cfparam name="URL.StateView" default="0">

<!--- Update Record --->
<cfif IsDefined("FORM.UpdateTaxes")>
	<cfloop from="1" to="#FORM.TaxCounter#" index="id">
		<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
		UPDATE tbl_stateprov 
		SET stprv_Ship_Ext = #makeSQLSafeNumber(Evaluate("FORM.stprv_Ship_Ext#id#"))#
		<cfif Application.TaxSystem NEQ "Groups">, stprv_Tax = #makeSQLSafeNumber(Evaluate("FORM.stprv_Tax#id#"))# </cfif>
		WHERE stprv_ID = #Evaluate("FORM.stprv_ID#id#")#
		</cfquery>
	</cfloop>
  <cflocation url="#request.ThisPageQS#" addtoken="no">
</cfif>

<!--- Get Records  --->
<cfquery name="rsGetStProvs" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
SELECT tbl_stateprov.*, tbl_list_countries.country_Name, tbl_list_countries.country_ID FROM tbl_list_countries INNER JOIN tbl_stateprov ON tbl_list_countries.country_ID = tbl_stateprov.stprv_Country_ID WHERE stprv_Archive = #URL.StateView# AND tbl_list_countries.country_Archive = 0 ORDER BY tbl_list_countries.country_Sort, tbl_list_countries.country_Name, tbl_stateprov.stprv_Name
</cfquery>
</cfsilent>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>CW Admin: Tax &amp; Shipping Extension</title>
<link href="assets/admin.css" rel="stylesheet" type="text/css">
</head>
<body> 
<!--- Include Admin Navigation Menu---> 
<cfinclude template="CWIncNav.cfm"> 
<div id="divMainContent"> 
  <h1> 
    Tax &amp; Shipping Extension </h1> 
  <!--- Only show table if we have records --->
<cfif rsGetStProvs.RecordCount NEQ 0> 
    <cfform action="#request.ThisPageQS#" method="POST" name="Update"> 
      <cfoutput query="rsGetStProvs" group="country_ID"> 
        <cfset StateCounter = 0>
				<h2>#country_Name#</h2> 
        <table> 
          <tr> 
            <cfif stprv_Code NEQ "None">
						<th align="center">Code</th> 
            <th align="center">Name</th> 
						</cfif>
            <th align="center">Tax%</th> 
            <th align="center">Ship/Ext%</th> 
          </tr> 
          <cfoutput>
						<cfset StateCounter = IncrementValue(StateCounter)>
            <cfif stprv_Code EQ "None"> 
              <cfset CurrentState = country_Name> 
              <cfelse> 
              <cfset CurrentState = stprv_Name> 
            </cfif> 
            <tr class="#IIF(StateCounter MOD 2, DE('altRowEven'), DE('altRowOdd'))#"> 
              <cfif stprv_Code NEQ "None">
							<td>#stprv_Code#</td> 
              <td>#stprv_Name#</td> 
							</cfif>
              <td align="center"><input name="stprv_ID#CurrentRow#" type="hidden" id="stprv_ID#CurrentRow#" value="#stprv_ID#">
			  <cfif Application.TaxSystem NEQ "Groups">
			  <cfinput name="stprv_Tax#CurrentRow#" type="text" validate="float" value="#LSNumberFormat(stprv_Tax,'9.9999')#" size="6">
			  <cfelse><input type="text" style="background-color:##ccc" readonly="readonly" onclick="alert('Taxes disabled here -- set using Tax Groups')" size="6">
			  </cfif> </td> 
              <td align="center"><cfinput name="stprv_Ship_Ext#CurrentRow#" type="text" required="yes" validate="float" message="Ship Extension required for #CurrentState# - Must be Numeric Value" value="#LSNumberFormat(stprv_Ship_Ext,'9.999')#" size="6"> </td> 
            </tr> 
          </cfoutput> 
        </table>
        <input name="UpdateTaxes" type="submit" class="formButton" id="UpdateTaxes" value="Update Tax & Shipping">
      </cfoutput> 
			<input name="TaxCounter" type="hidden" value="<cfoutput>#rsGetStProvs.RecordCount#</cfoutput>">
    </cfform> 
    <cfelse> 
    <p>There are no
       
      shipping locations.</p> 
  </cfif> 
</div> 
</body>
</html>
