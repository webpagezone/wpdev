<!---
================================================================
Application Info: 
Cartweaver© 2002 - 2007, All Rights Reserved.
Developer Info: 
	Application Dynamics Inc.
	1560 NE 10th
	East Wenatchee, WA 98802
	Support Info: http://www.cartweaver.com/go/cfhelp

Cartweaver Version: 3.0.7  -  Date: 7/8/2007
================================================================
Name: ListDiscounts.cfm
Description: List and administer discounts
================================================================
--->

<!--- Set location for highlighting in Nav Menu --->
<cfset strSelectNav = "Discounts">
<cfset endLoop = false>
<!--- Set Page Archive Status --->
<cfparam name="Session.DiscountView" default="1">

<cfif(IsDefined("Url.DiscountView"))>
	<cfset Session.DiscountView = Url.DiscountView>
</cfif>

<!--- Set local variable for currently viewed status to limit hits to Client scope --->
<cfif(Session.DiscountView EQ "1")>
	<cfset currentStatus = "Active">
<cfelse>
	<cfset currentStatus = "Archived">
</cfif>

<!--- ARCHIVE Record --->
<cfif(IsDefined("Form.UpdateDiscounts"))>
	<!--- DELETE Record --->
	<cfif(IsDefined("Form.deleteDiscount"))>
		<cfset deletedDiscounts = Form.deleteDiscount>
		<cfquery name="rsCW" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
		DELETE FROM tbl_discounts 
		WHERE discount_id 
		IN (#deletedDiscounts#)
		</cfquery>
	</cfif>
	
	<cfif(IsDefined("Form.discount_archive"))>
		<cfset archivedDiscounts = Form.discount_archive>
		<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
		UPDATE tbl_discounts 
		SET	discount_archive = #Session.DiscountView#
		WHERE discount_id IN (#archivedDiscounts#)
		</cfquery>
	</cfif>
</cfif>

<!--- Get Record --->
<cfquery name="rsCWDiscountList" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
SELECT d.discount_id, 
d.discount_applyType, 
d.discount_name, 
d.discount_startDate, 
d.discount_endDate, 
d.discount_archive,
d.discount_promotionalCode,
t.discountApplyType_desc
FROM tbl_discounts d
INNER JOIN tbl_discount_apply_types t
ON d.discount_applyType = t.discountApplyType_id
WHERE d.discount_archive <> #Session.DiscountView#
ORDER BY d.discount_applyType ASC, 
d.discount_endDate DESC
</cfquery>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>CW Admin: Discounts</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="assets/admin.css" rel="stylesheet" type="text/css">
</head>
<body>
<cfinclude template="CWIncNav.cfm">
<div id="divMainContent">
  <h1>Discounts</h1>
  <p>
    <cfif (currentStatus EQ "Active")>
     	<a href="<cfoutput>#request.thisPage#</cfoutput>?DiscountView=0">View Archived</a>
    <cfelse>
      	<a href="<cfoutput>#request.thisPage#</cfoutput>?DiscountView=1">View Active</a>
    </cfif>
  </p>
  <cfif (rsCWDiscountList.RecordCount GT 0)>
  <form action="<cfoutput>#request.thisPage#</cfoutput>" method="post" name="frmDiscount">
  
<cfoutput query="rsCWDiscountList" group="discount_applyType">
<cfset RowsOutput = 0>
	<table>
      <caption>
      Discounts on #rsCWDiscountList.discountApplyType_desc#
      </caption>
      <tr>
        <th align="center">Discount</th>
        <th align="center">Start Date </th>
        <th align="center">End Date </th>
        <th align="center">Delete</th>
        <th align="center"><cfif (currentStatus EQ "Active")>Archive<cfelse>Activate</cfif></th>
        <th align="center">Edit</th>
      </tr>
	<cfoutput>
	<cfset RowsOutput = RowsOutput + 1>
      <tr class="#cwAltRows(RowsOutput)#"> 
        <td nowrap="nowrap">#RowsOutput#
          <input type="hidden" name="discount_id" value="#rsCWDiscountList.discount_id#">
         <a href="DiscountDetails.cfm?discount_id=#rsCWDiscountList.discount_id#">#rsCWDiscountList.discount_name#</a><!---<cfif rsCWDiscountList.discount_PromotionalCode NEQ ""><cfset requiresPromo = true>**</cfif>--->
        </td>
        <td align="center">
          <div align="right">#DateFormat(rsCWDiscountList.discount_startDate, request.dateMask)#</div>
        </td>
        <td align="center">
          <div align="right"><cfif IsDate(rsCWDiscountList.discount_endDate)>
		  <cfif DateDiff("d",rsCWDiscountList.discount_endDate, now()) GT 0>
		  <cfset endDatePassed = true><span style="color:red">*#DateFormat(rsCWDiscountList.discount_endDate, request.dateMask)#</span>
		  <cfelse>#DateFormat(rsCWDiscountList.discount_endDate, request.dateMask)#
		  </cfif></cfif></div>
        </td>
        <td align="center">
          <input type="checkbox" class="formCheckbox" name="deleteDiscount" value="#rsCWDiscountList.discount_id#"/>
        </td>
        <td align="center">
          <input type="checkbox" class="formCheckbox" name="discount_archive" value="#rsCWDiscountList.discount_id#"/>
        </td>
        <td align="center"><a href="DiscountDetails.cfm?discount_id=#rsCWDiscountList.discount_id#"><img src="assets/images/edit.gif" alt="Edit One Option Product" width="15" height="15" border="0"></a></td>
	</cfoutput>
	</table>
</cfoutput>
<cfif isdefined("endDatePassed")><p>* End date has passed. Discount is no longer valid.</p></cfif>
<!---<cfif isdefined("requiresPromo")><p>** Requires a promotional code.</p></cfif>--->
    <p>
      <input type="hidden" name="DiscountCounter" value="2">
      <input type="submit" name="UpdateDiscounts" value="Update Discounts" class="formButton">
    </p>
  </form>
  <cfelse>
	<cfif (currentStatus EQ "Active")>
		No Active Discounts
	<cfelse>
		No Archived Discounts
	</cfif>
  
 </cfif> <!--- if(rsCWDiscountList.RecordCount GT 0) --->
</div>
</body>
</html>