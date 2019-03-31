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
Name: ListShipStatus.cfm
Description: allow for setting the order in which shipping staus records appier.
================================================================
--->
<!--- Set location for highlighting in Nav Menu --->
<cfset strSelectNav = "Settings">

<!--- Use parameter to check and see if nav should be updated --->
<cfparam name="UpdateStatus" default="0">

<!--- Update Record --->
<cfif IsDefined("FORM.UpdateRecords")>
  <cfloop from="1" to="#FORM.statusCount#" index="id">
		<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
		UPDATE tbl_list_shipstatus SET shipstatus_Sort=#Evaluate("FORM.shipstatus_Sort#id#")#, shipstatus_Name='#Evaluate("FORM.shipstatus_Name#id#")#' WHERE shipstatus_ID=#Evaluate("FORM.shipstatus_ID#id#")#
		</cfquery>
	</cfloop>
	<cflock timeout="5" throwontimeout="no" type="exclusive" scope="Application">
		<cfset StructDelete(Application, "ShipStatusMenu") >
	</cflock>
  <cflocation url="#request.ThisPage#" addtoken="no">
</cfif>

<!--- Get Records --->
<cfquery name="rsShipStatus" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
SELECT * FROM tbl_list_shipstatus ORDER BY shipstatus_Sort ASC
</cfquery>

</cfsilent>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Order Status Codes Administration</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="assets/admin.css" rel="stylesheet" type="text/css">
</head>
<body> 
<!--- Include Admin Navigation Menu---> 
<cfinclude template="CWIncNav.cfm"> 
<div id="divMainContent"> 
  <h1> Order Status Codes</h1> 
  <!--- Only show table if we have records ---> 
  <cfif rsShipStatus.RecordCount NEQ 0> 
    <cfform action="#request.ThisPage#" method="POST" name="Update"> 
      <table> 
        <caption>
         Order Status Codes
        </caption> 
        <tr> 
          <th align="center">Status Name</th> 
          <th align="center">Sort</th> 
        </tr> 
        <cfoutput query="rsShipStatus"> 
          <tr class="#IIF(CurrentRow MOD 2, DE('altRowEven'), DE('altRowOdd'))#"> 
            <td> <input name="shipstatus_ID#CurrentRow#" type="hidden" value="#rsShipStatus.shipstatus_ID#"> 
              <input name="shipstatus_Name#CurrentRow#" type="hidden" value="#rsShipStatus.shipstatus_Name#"> 
              #rsShipStatus.shipstatus_Name#</td> 
            <td align="center"> <cfinput name="shipstatus_Sort#CurrentRow#" type="text" value="#rsShipStatus.shipstatus_Sort#" size="3" required="yes" message="Sort Must Be a Numeric Value"> </td> 
          </tr> 
        </cfoutput> 
      </table> 
      <input type="hidden" name="statusCount" value="<cfoutput>#rsShipStatus.RecordCount#</cfoutput>"> 
      <input name="UpdateRecords" type="submit" class="formButton" id="UpdateRecords" value="Update Ship Status"> 
    </cfform> 
    <cfelse> 
    <p>There are no Order Status Codes.</p> 
  </cfif> 
</div> 
</body>
</html>
