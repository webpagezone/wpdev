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
Name: Orders.cfm
Description: Dispalys a list of orders filtered by the selected "Order Status"
================================================================
--->

<!--- Set location for highlighting in Nav Menu --->
<cfset strSelectNav = "Orders">

<!--- Set default values for order status and search dates --->
<cfparam name="URL.SearchBy" default="0">
<cfparam name="FORM.StartDate" default="#DateFormat(DateAdd("m",-1,Now()),request.dateMask)#" type="date">
<cfparam name="FORM.EndDate" default="#DateFormat(Now(),request.dateMask)#" type="date">
<cfparam name="FORM.Status" default="0">

<cfif URL.SearchBy NEQ 0>
 <cfset FORM.Status = URL.SearchBy>
</cfif>

<!--- Get a list of ship types --->
<cfquery name="rsShipStatusTypes" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
SELECT *
FROM tbl_list_shipstatus
ORDER BY shipstatus_Sort ASC
</cfquery>

<!--- Get Ship status list --->
<cfquery name="rsCurrentShipStatusType" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
SELECT *
FROM tbl_list_shipstatus
WHERE 1=1
<cfif FORM.Status NEQ 0>AND shipstatus_ID = #FORM.Status#</cfif>
ORDER BY shipstatus_Sort ASC
</cfquery>

<!--- retrieve orders by date --->
<cfquery name="rsByDate" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
SELECT tbl_customers.cst_FirstName, tbl_customers.cst_LastName, tbl_customers.cst_Zip, 
tbl_orders.order_ID, tbl_orders.order_Date
FROM tbl_customers INNER JOIN tbl_orders ON tbl_customers.cst_ID = tbl_orders.order_CustomerID
WHERE tbl_orders.order_Date >= #CreateODBCDate(LSParseDateTime(FORM.StartDate))#
AND tbl_orders.order_Date <= #CreateODBCDateTime(DateAdd("d",1,LSParseDateTime(FORM.EndDate)))#
<cfif FORM.Status NEQ 0>AND order_Status = #FORM.Status#</cfif>
ORDER BY tbl_orders.order_Date DESC
</cfquery>

</cfsilent>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>CW Admin: Orders</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="assets/admin.css" rel="stylesheet" type="text/css">
<!--- Date Pop Up --->
<script language="JavaScript">
<!--

// function to load the calendar window.
function ShowCalendar(FormName, FieldName) {
	var curValue = eval("document."+FormName+"."+FieldName+".value");
	window.open("DatePopup.cfm?getDate="+ curValue + "&FormName=" + FormName + "&FieldName=" + FieldName, "CalendarWindow", "width=250,height=200");
}
//Function to clear default text. Function name must stay all lowercase!
function cw_cleardefault(theField){
 if(theField.value == theField.defaultValue){theField.value = '';}
}
//-->
</script>
</head>
<body>

<!--- Include Admin Navigation Menu--->
<cfinclude template="CWIncNav.cfm">
<div id="divMainContent">
  
<cfform name="DateForm" method="post" action="#request.ThisPage#">
      From
      <cfinput name="StartDate" type="text" required="yes" message="Must be a date - #request.dateMask# format" validate="#request.dateValidate#" value="#FORM.StartDate#" size="10" passthrough="onFocus=""cw_cleardefault(this);""">
      <a href="javascript:ShowCalendar('DateForm', 'StartDate')"><img src="assets/images/calendar.gif" alt="Click to Select Date" width="16" height="16"></a>&nbsp;To
      <cfinput  name="EndDate" type="text" required="yes" validate="#request.dateValidate#" message="Must be a date - #request.dateMask# format" value="#FORM.EndDate#" size="10" passthrough="onFocus=""cw_cleardefault(this);""">
      <a href="javascript:ShowCalendar('DateForm', 'EndDate')"><img src="assets/images/calendar.gif" width="16" height="16" style="margin-bottom:0px;" alt="Click to Select Date"></a>
      <!-- Populate list with same query found in Application.cfm used for the Orders menu. --->
      <select name="Status">
        <option value="0" <cfif (isDefined("URL.SearchBy") AND "Any" EQ URL.SearchBy)>selected</cfif>>Any</option>
       
	    <cfoutput query="rsShipStatusTypes">
          <option value="#rsShipStatusTypes.shipstatus_id#" <cfif rsShipStatusTypes.shipstatus_id EQ FORM.Status>selected</cfif>>#rsShipStatusTypes.shipstatus_Name#</option>
        </cfoutput>
		
      </select>
      <input name="Submit" type="submit" class="formButton" value="Get Orders">
  </cfform>
  <br />
  
  <h1>Orders By Status:
    <!--- If there is a valid status filter --->
	<cfif rsCurrentShipStatusType.RecordCount NEQ "0">
      <cfoutput>#ValueList(rsCurrentShipStatusType.shipstatus_Name, ", ")#</cfoutput>
      <cfelse>
      Any
    </cfif>
  </h1>
  <!--- Results Output table --->
  <cfif rsByDate.RecordCount NEQ "0">
    <table>
      <tr>
        <th>Date</th>
        <th>Order ID</th>
        <th>Customer</th>
        <th>Zip</th>
        <th>View</th>
      </tr>
      <!--- loop through to show all records found --->
      <cfif rsByDate.RecordCount EQ 0>
        <p>No results found.</p>
      </cfif>
			<cfoutput query="rsByDate">
				<tr class="#IIF(CurrentRow MOD 2, DE('altRowEven'), DE('altRowOdd'))#">
					<td style="white-space: nowrap; text-align: right;">#LSDateFormat(order_Date,'MMMM DD, YYYY')#</td>
					<td>#order_ID#</td>
					<td>#cst_FirstName# #cst_LastName#</td>
					<td>#cst_Zip#</td>
					<td align="center"><a href="OrderDetails.cfm?order_ID=#order_ID#"><img src="assets/images/viewdetails.gif" width="15" height="15" alt="View Order Details"></a></td>
				</tr>
			</cfoutput>
    </table>
    <cfelse>
      <p><strong>Sorry, no matching records found.
	<!--- If the user has tried a form search, and there are no results, prompt them to choose different dates --->
	  <cfif IsDefined ('FORM.StartDate')>
        Try different dates. 
      </cfif></strong></p>
  </cfif>
</div>
</body>
</html>
