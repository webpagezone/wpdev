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
Name: ShipMethods.cfm
Description: Here we set available shipping methods, the country 
they are associated with and a base charge, if any, for each. 
Base charge is elective, if no base charge is desired the vale 
should be 0. Bas charge can be used as a flat rate or as a base 
on which to add by weight shipping and shipping extensions.
================================================================
--->
<!--- Set location for highlighting in Nav Menu --->
<cfset strSelectNav = "ShippingTax">
<!--- Set Page Archive Status --->
<cfparam name="URL.MethodView" default="0">

<!--- ADD Record --->
<cfif IsDefined("FORM.AddRecord")>
	<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
	INSERT INTO tbl_shipmethod (shipmeth_Sort, shipmeth_Name, shipmeth_Rate,shipmeth_Archive) 
	VALUES (#FORM.shipmeth_Sort#, '#FORM.shipmeth_Name#', #makeSQLSafeNumber(FORM.shipmeth_Rate)#, 0)
	</cfquery>
	<!--- get the new method id we just added --->
	<cfquery name="getNewMethID" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
	SELECT shipmeth_ID AS newID FROM tbl_shipmethod ORDER BY shipmeth_ID DESC
	</cfquery>
	<!--- now add country / method relationship --->
	<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
	INSERT INTO tbl_shipmethcntry_rel (shpmet_cntry_Meth_ID,shpmet_cntry_Country_ID)
	VALUES (#getNewMethID.newID#, #FORM.country_ID#)
	</cfquery>
	<cflocation url="#request.ThisPage#?MethodView=#URL.MethodView#" addtoken="no">
</cfif>

<!--- Update Shipping Methods --->
<cfif IsDefined("UpdateMethods")>
	<cfparam name="FORM.deleteMethod" default="">
	<cfloop from="1" to="#FORM.MethodCounter#" index="id">
		<cfif ListFind(FORM.deleteMethod,Evaluate("FORM.shipmeth_ID#id#"))>
			<!--- Delete Record --->
			<!--- DELETE Country Relationship --->
			<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
			DELETE FROM tbl_shipmethcntry_rel WHERE shpmet_cntry_Meth_ID = #Evaluate("FORM.shipmeth_ID#id#")#
			</cfquery>
			<!--- DELETE Method --->
			<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
			DELETE FROM tbl_shipmethod WHERE shipmeth_ID = #Evaluate("FORM.shipmeth_ID#id#")#
			</cfquery>
			
			<cfelse>
			<!--- Update Redocrd --->
			<cfparam name="FORM.shipmeth_Archive#id#" default="#URL.methodView#">
			<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
			UPDATE tbl_shipmethod 
			SET shipmeth_Rate = #makeSQLSafeNumber(Evaluate("FORM.shipmeth_Rate#id#"))#,
			shipmeth_Archive = #Evaluate("FORM.shipmeth_Archive#id#")#,
			shipmeth_Sort = #Evaluate("FORM.shipmeth_Sort#id#")#
			WHERE shipmeth_ID = #Evaluate("FORM.shipmeth_ID#id#")#
			</cfquery>
			
		</cfif>
	</cfloop>
	<cflocation url="#Request.ThisPageQS#" addtoken="no">
</cfif>

<!--- GET Record --->
<cfquery name="rsGetShipping" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
SELECT tbl_shipmethod.*, tbl_list_countries.country_Name, tbl_list_countries.country_ID
FROM (tbl_shipmethod INNER JOIN tbl_shipmethcntry_rel ON tbl_shipmethod.shipmeth_ID
= tbl_shipmethcntry_rel.shpmet_cntry_Meth_ID) INNER JOIN tbl_list_countries ON
tbl_shipmethcntry_rel.shpmet_cntry_Country_ID = tbl_list_countries.country_ID
WHERE shipmeth_archive = #URL.Methodview# ORDER BY tbl_list_countries.country_Sort,
tbl_list_countries.country_Name, tbl_shipmethod.shipmeth_Sort, tbl_shipmethod.shipmeth_Name
</cfquery>

<!--- Get Countries to populate Select Fields --->
<cfquery name="rsGetCountry" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
SELECT country_ID, country_Name FROM tbl_list_countries ORDER BY country_Name
</cfquery>
</cfsilent>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>CW Admin: Shipping Methods</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="assets/admin.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
function checkRates(num) {
	for(var i=1; i<=document.getElementById('totalMethods').value; i++) {
		if(i!=num && document.getElementById('shipmeth_ID'+i).value == document.getElementById('shipmeth_ID'+num).value) {
			document.getElementById('shipmeth_Rate'+i).value = document.getElementById('shipmeth_Rate'+num).value;
		}
	}
}
</script>
</head>
<body> 
<!--- Include Admin Navigation Menu---> 
<cfinclude template="CWIncNav.cfm"> 
<div id="divMainContent"> 
	<h1> 
		<cfif URL.MethodView EQ "0">
 			Active
			<cfelse> 
			Archived
		</cfif> 
		Shipping Methods View </h1> 
	<p> 
		<cfif URL.MethodView EQ "0"> 
			<a href="<cfoutput>#request.ThisPage#</cfoutput>?MethodView=1">View Archived</a> 
			<cfelse> 
			<a href="<cfoutput>#request.ThisPage#</cfoutput>?MethodView=0">View Active</a> 
		</cfif> 
	</p> 
	<cfif URL.MethodView EQ "0"> 
		<cfform action="#request.ThisPage#" method="POST" name="AddRecord"> 
			<table> 
				<caption>
 				Add Ship Method
				</caption> 
				<tr> 
					<th>Method</th> 
					<th>Country</th> 
					<th>Rate</th> 
					<th>Sort</th> 
					<th>Add</th> 
				</tr> 
				<tr class="altRowEven"> 
					<td align="center"><cfinput name="shipmeth_Name" type="text" size="25" required="yes" message="Ship Method Required" id="ship_method"> </td> 
					<td align="center"><select name="country_ID"> 
							<cfoutput query="rsGetCountry"> 
								<option value="#rsGetCountry.country_ID#">#rsGetCountry.country_Name#</option> 
							</cfoutput> 
						</select> </td> 
					<td align="center"><cfinput name="shipmeth_Rate" type="text" size="6" required="yes" message="Rate must be Numeric Only - no $ or ," validate="float" id="ship_rate"> </td> 
					<td align="center"><cfinput name="shipmeth_Sort" type="text" id="ship_sort" size="2" required="yes" validate="integer" message="Sort must be Numeric Only - no $ or ,"></td> 
					<td align="center"><input name="AddRecord" type="submit" class="formButton" id="AddRecord" value="Add"> </td> 
				</tr> 
			</table> 
		</cfform> 
	</cfif> 
	<!--- Only show table if we have records ---> 
	<cfif rsGetShipping.RecordCount NEQ 0> 
		<cfform name="EditRecord" method="POST" action="#request.ThisPageQS#"> 
			<cfoutput query="rsGetShipping" group="country_ID"> 
				<h2>#country_Name#</h2> 
				<table> 
					<tr> 
						<th>Method</th> 
						<th>Rate</th> 
						<th>Sort</th> 
						<th>Delete</th> 
						<th> <cfif URL.MethodView EQ "0">
 								Archive
								<cfelse> 
								Activate
							</cfif> </th> 
					</tr> 
					<cfoutput> 
						<cfquery name="CheckOrder" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
 						SELECT order_ID FROM tbl_orders WHERE order_ShipMeth_ID = #rsGetShipping.shipmeth_ID# 
						</cfquery> 
						<cfquery name="CheckRange" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
 						SELECT ship_range_ID FROM tbl_shipranges WHERE ship_range_Method_ID
 						= #rsGetShipping.shipmeth_ID# 
						</cfquery> 
						<!--- Get Country ---> 
						<cfquery name="getThisCountry" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
 						SELECT shpmet_cntry_Country_ID FROM tbl_shipmethcntry_rel WHERE shpmet_cntry_Meth_ID
 						= #rsGetShipping.shipmeth_ID# 
						</cfquery> 
						<tr class="#IIF(CurrentRow MOD 2, DE('altRowEven'), DE('altRowOdd'))#"> 
							<td align="right">#CurrentRow#.
								<cfinput name="shipmeth_Name#CurrentRow#" id="shipmeth_Name#CurrentRow#" size="25" required="yes" message="Shipping method name is required for method #CurrentRow#" value="#rsGetShipping.shipmeth_Name#"> 
								<input name="shipmeth_ID#CurrentRow#" type="hidden" id="shipmeth_ID#CurrentRow#" value="#rsGetShipping.shipmeth_ID#"> </td> 
							<td align="center"><cfinput name="shipmeth_Rate#CurrentRow#" id="shipmeth_Rate#CurrentRow#" type="text" value="#LSNumberFormat(rsGetShipping.shipmeth_Rate,'.99')#" size="6" required="yes" message="Rate must be numeric only for method #CurrentRow# - no $ or ," validate="float" onblur="checkRates(#CurrentRow#)"> </td> 
							<td align="center"><cfinput name="shipmeth_Sort#CurrentRow#" type="text" value="#rsGetShipping.shipmeth_Sort#" size="2" required="yes" message="Sort is required for method #CurrentRow# - should be numeric" validate="float"> </td> 
							<td align="center"><input type="checkbox" value="#shipmeth_ID#" class="formCheckbox" name="deleteMethod"<cfif CheckOrder.RecordCount NEQ 0 OR CheckRange.RecordCount NEQ 0> disabled</cfif>> </td> 
							<td align="center"><input type="checkbox" value="<cfif URL.MethodView EQ 0>1<cfelse>0</cfif>" class="formCheckbox" name="shipmeth_Archive#CurrentRow#"> </td> 
						</tr>
						<cfset lastRecord = CurrentRow>
					</cfoutput> 
				</table> 
			</cfoutput> 
				<input type="hidden" name="totalMethods" id="totalMethods" value="<cfoutput>#lastRecord#</cfoutput>"/>
				<input type="hidden" value="<cfoutput>#rsGetShipping.RecordCount#</cfoutput>" name="methodCounter">
				<input type="submit" value="Update Methods" name="UpdateMethods" class="formButton"> 
		</cfform> 
		<cfelse> 
		<p>There are no
			<cfif URL.MethodView EQ "0">
 				active
				<cfelse> 
				archived
			</cfif> 
			ship methods.</p> 
	</cfif> 
</div> 
</body>
</html>
