<cfsilent>
<!--- 
================================================================
Application Info: Cartweaver© 2002 - 2007, All Rights Reserved.
Developer Info: Application Dynamics Inc.
                1560 NE 10th
                East Wenatchee, WA 98802
Support Info: http://www.cartweaver.com/go/cfhelp
				
Cartweaver Version: 3.0.6  -  Date: 5/21/2007
================================================================
Name: ShipRange.cfm
Description: Here we set the From - To ranges and shipping 
cost for each range. This data is used in calculating the shipping 
cost.
================================================================
--->
<!--- Set location for highlighting in Nav Menu --->
<cfset strSelectNav = "ShippingTax">

<!--- ADD Record --->
<cfif IsDefined("FORM.AddRecord")>
  <cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
  INSERT INTO tbl_shipranges (ship_range_Method_ID, ship_range_From,
  ship_range_To, ship_range_Amount) VALUES ( #FORM.ship_range_Method_ID#,
  #FORM.ship_range_From#, #FORM.ship_range_To#, #makeSQLSafeNumber(FORM.ship_range_Amount)#
  )
  </cfquery>
	<cflocation url="#request.ThisPage#" addtoken="no">
</cfif>

<!--- Update Ranges --->
<cfif IsDefined("UpdateRanges")>
	<cfparam name="FORM.deleteRange" default="">
	<cfloop from="1" to="#FORM.rangeCounter#" index="id">
		<cfif ListFind(FORM.deleteRange,Evaluate("FORM.ship_range_ID#id#"))>
			<!--- Delete Record --->
			<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
			DELETE FROM tbl_shipranges WHERE ship_range_ID = #Evaluate("FORM.ship_range_ID#id#")#
			</cfquery>
			
			<cfelse>
			<!--- Update Redocrd --->
			<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
			UPDATE tbl_shipranges SET ship_range_From = #Evaluate("FORM.ship_range_From#id#")#, 
			ship_range_To = #Evaluate("FORM.ship_range_To#id#")#,
			ship_range_Amount = #makeSQLSafeNumber(Evaluate("FORM.ship_range_Amount#id#"))#
			WHERE ship_range_ID = #Evaluate("FORM.ship_range_ID#id#")#
			</cfquery>
			
		</cfif>
	</cfloop>
	<cflocation url="#Request.ThisPage#" addtoken="no">
</cfif>

<!--- Get Record --->
<cfquery name="rsGetWtRange" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
SELECT tbl_shipranges.*, tbl_shipmethod.shipmeth_Name, tbl_list_countries.country_Name
FROM tbl_shipranges INNER JOIN ((tbl_shipmethcntry_rel INNER JOIN tbl_list_countries ON tbl_shipmethcntry_rel.shpmet_cntry_Country_ID = tbl_list_countries.country_ID) INNER JOIN tbl_shipmethod ON tbl_shipmethcntry_rel.shpmet_cntry_Meth_ID = tbl_shipmethod.shipmeth_ID) ON tbl_shipranges.ship_range_Method_ID = tbl_shipmethod.shipmeth_ID
ORDER BY tbl_list_countries.country_Sort, tbl_list_countries.country_Name, tbl_shipmethod.shipmeth_Sort, tbl_shipmethod.shipmeth_Name, tbl_shipranges.ship_range_From, tbl_shipranges.ship_range_To;
</cfquery>

<!--- Get Shipping Method List --->
<cfquery name="rsGetMethod" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
SELECT tbl_shipmethod.shipmeth_name, tbl_shipmethod.shipmeth_id, tbl_list_countries.country_Name, tbl_list_countries.country_ID
FROM (tbl_shipmethod INNER JOIN tbl_shipmethcntry_rel ON tbl_shipmethod.shipmeth_ID
= tbl_shipmethcntry_rel.shpmet_cntry_Meth_ID) INNER JOIN tbl_list_countries ON
tbl_shipmethcntry_rel.shpmet_cntry_Country_ID = tbl_list_countries.country_ID
WHERE shipmeth_archive = 0 ORDER BY tbl_list_countries.country_Sort,
tbl_list_countries.country_Name, tbl_shipmethod.shipmeth_Sort, tbl_shipmethod.shipmeth_Name
</cfquery>
</cfsilent>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>CW Admin: Shipping Weight, Ranges &amp; Rates</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="assets/admin.css" rel="stylesheet" type="text/css">
</head>
<body> 
<!--- Include Admin Navigation Menu---> 
<cfinclude template="CWIncNav.cfm"> 
<div id="divMainContent"> 
	<h1>Shipping Ranges &amp; Rates based on <cfoutput>#Application.ChargeShipBy#</cfoutput>
 
</h1> 
	<h2>* Note: the first range of any method must start at 0 with a cost
		of 0.00 </h2> 
	<cfform name="Add" method="POST" action="#request.ThisPage#"> 
		<table> 
			<caption>
 			Add Range
			</caption> 
			<tr align="center"> 
				<th>Method</th> 
				<th>From</th> 
				<th>To</th> 
				<th>Rate</th> 
				<th>&nbsp;</th> 
			</tr> 
			<tr align="center" class="altRowEven"> 
				<td> <select name="ship_range_Method_ID"> 
						<cfoutput query="rsGetMethod" group="country_name"> 
							<optgroup label="#country_name#"> <cfoutput> 
								<option value="#rsGetMethod.shipmeth_ID#">#rsGetMethod.shipmeth_Name#</option> 
							</cfoutput> </optgroup> 
						</cfoutput> 
					</select> </td> 
				<td><cfinput name="ship_range_From" required="yes" validate="float" message="From Weight Required - Must be Numeric Value" type="text" size="10"> </td> 
				<td><cfinput name="ship_range_To" required="yes" validate="float" message="To Weight Required - Must be Numeric Value" type="text" size="10"> </td> 
				<td><cfinput name="ship_range_Amount" required="yes" validate="float" message="Rate Required - Must be Numeric Value" type="text" size="10"> </td> 
				<td>
					<input name="AddRecord" type="hidden" value="True">
					<input type="submit" class="formButton" value="Add"> </td> 
			</tr> 
		</table> 
	</cfform> 
	<cfform action="#request.ThisPage#" method="POST" name="Update"> 
		<cfoutput query="rsGetWtRange" group="country_Name"> 
			<h2>#country_Name#</h2> 
			<table> 
				<caption>
 				Current Ranges
				</caption> 
				<tr> 
					<th>Method</th> 
					<th>From</th> 
					<th>To</th> 
					<th>Rate</th> 
					<th>Delete</th> 
				</tr> 
				<cfoutput> 
					<tr  class="#IIF(CurrentRow MOD 2, DE('altRowEven'), DE('altRowOdd'))#"> 
						<td>#CurrentRow#.
							<input name="ship_range_ID#CurrentRow#" type="hidden" value="#ship_range_ID#"> 
							#rsGetWtRange.shipmeth_Name#</td> 
						<td align="center"><cfinput name="ship_range_From#CurrentRow#" type="text" required="yes" validate="float" message="From Range required for range number #CurrentRow# - Must be Numeric Value" value="#rsGetWtRange.ship_range_From#" size="10"></td> 
						<td align="center"><cfinput name="ship_range_To#CurrentRow#" type="text" required="yes" validate="float" message="To Range required for range number #CurrentRow# - Must be Numeric Value" value="#rsGetWtRange.ship_range_To#" size="10"></td> 
						<td align="center"><cfinput name="ship_range_Amount#CurrentRow#" type="text" required="yes" validate="float" message="Rate required for range number #CurrentRow# - Must be Numeric Value" value="#LSNumberFormat(rsGetWtRange.ship_range_Amount,'9.99')#" size="10"></td> 
						<td align="center"><input type="checkbox" class="formCheckbox" name="deleteRange" value="#ship_range_ID#"></td> 
					</tr> 
				</cfoutput> 
			</table>
			<input type="hidden" name="UpdateRanges" value="True">
			<input type="submit" value="Update Ranges" class="formButton"> 
		</cfoutput> 
		<input type="hidden" name="rangeCounter" value="<cfoutput>#rsGetWtRange.RecordCount#</cfoutput>">
	</cfform> 
</div> 
</body>
</html>