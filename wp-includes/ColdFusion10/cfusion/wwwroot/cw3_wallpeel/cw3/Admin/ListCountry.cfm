<cfsilent>
<!--- 
======================================================================
Application Info: Cartweaver© 2002 - 2007, All Rights Reserved.
Developer Info: Application Dynamics Inc.
                1560 NE 10th
                East Wenatchee, WA 98802
Support Info: http://www.cartweaver.com/go/cfhelp
				
Cartweaver Version: 3.0.10  -  Date: 4/27/2008
================================================================
Name: ListCountry.cfm
Description: List countries
================================================================
--->
<!--- Set location for highlighting in Nav Menu --->
<cfset strSelectNav = "Settings">

<!--- Set Page Archive Status --->
<cfparam name="URL.CountryView" default="0">
<!--- Set local variable for currently viewed status to limit hits to Client scopt --->
<cfparam name="CurrentStatus" default="Active">
<cfif URL.CountryView NEQ 0>
  <cfset CurrentStatus = "Archived">
</cfif>

<!--- ADD Record --->
<cfif IsDefined("FORM.AddRecord")>
	<cfif FORM.stprv_country EQ 0>
		<!--- Add a new country --->
		<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
		INSERT INTO tbl_list_countries (country_Name, country_Code, country_Sort) 
		VALUES ('#FORM.country_Name#' ,'#FORM.country_Code#' ,#FORM.country_Sort# )
		</cfquery>
	
		<!--- Add a phantom state for countries without states --->
		<!--- Get the newly created country ID --->
		<cfquery name="rsNewCountry" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
		SELECT country_ID FROM tbl_list_countries 
		WHERE country_Name = '#FORM.country_Name#' 
		AND country_Code = '#FORM.country_Code#'
		</cfquery>
	
		<!--- Insert the phantom record --->
		<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
		INSERT INTO tbl_stateprov (stprv_Code, stprv_Name, stprv_Country_ID) 
		VALUES ('None','None',#rsNewCountry.country_ID#)
		</cfquery>

		<cfelse>
		<!--- Add a new state --->
		<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
		INSERT INTO tbl_stateprov (stprv_Code, stprv_Name, stprv_Country_ID) 
		VALUES ('#FORM.country_Code#','#FORM.country_Name#',#FORM.stprv_country#)
		</cfquery>

		<!--- Archive any phantom records for this country --->
		<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
		UPDATE tbl_stateprov SET stprv_Archive = 1 
		WHERE stprv_Code = 'None' AND stprv_Country_ID = #FORM.stprv_country#
		</cfquery>
		
	</cfif>
  <cflocation url="#request.ThisPageQS#" addtoken="no">
</cfif>

<!--- Process Updates, Deletes and Archives --->
<cfif IsDefined("FORM.UpdateCountries")>
	<!--- Loop through all of the submitted states --->
	<cfloop from="1" to="#FORM.stateCounter#" index="id">
		<cfset stateID = Evaluate("FORM.stprv_ID#id#")>
		<cfif IsDefined(Evaluate(DE("FORM.stprv_Delete#id#")))>
			<!--- Delete associated tax regions --->						
			<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
			DELETE FROM tbl_taxregions 
			WHERE taxregion_stateid = #stateID#
			</cfquery>
			<!--- Delete the state --->
			<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
			DELETE FROM tbl_stateprov WHERE stprv_ID = #stateID#
			</cfquery>

		<cfelse>
			<!--- Update the country --->
			<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
			UPDATE tbl_stateprov 
				SET 
					stprv_Code = '#Evaluate("FORM.stprv_Code#id#")#', 
					stprv_Name = '#Evaluate("FORM.stprv_Name#id#")#', 
					<cfif IsDefined(Evaluate(DE("FORM.stprv_Archive#id#")))>
						stprv_Archive = 1
						<cfelse>
						stprv_Archive = 0
					</cfif>
			WHERE stprv_ID=#stateID#
			</cfquery>
		</cfif>
	</cfloop>

	<!--- Loop through all of the submitted countries --->
	<cfloop from="1" to="#FORM.countryCounter#" index="id">
		<cfset countryID = Evaluate("FORM.country_ID#id#")>
		<cfif IsDefined(Evaluate(DE("FORM.country_Delete#id#")))>
			<!--- Delete the country --->
			
			<!--- First, delete tax regions. Grab list of states --->
			<cfquery name="rsCWStateList" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">			
			SELECT stprv_ID
			FROM tbl_stateprov 
			WHERE stprv_Country_ID = #countryID#
			</cfquery>
			
			<cfif rsCWStateList.recordCount GT 0>
				<cfset deleteStates = valueList(rsCWStateList.stprv_ID)>
				<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
				DELETE FROM tbl_taxregions 
				WHERE taxregion_stateid IN (#deleteStates#)
				</cfquery>
			</cfif>
			
			<!--- Next, delete tax regions associated with deleted countries --->
			<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
			DELETE FROM tbl_taxregions 
			WHERE taxregion_countryid = #countryID#
			</cfquery>
			<!--- Delete any states, including phantom states --->
			<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
			DELETE FROM tbl_stateprov 
			WHERE stprv_Country_ID = #countryID#
			</cfquery>
			<!--- Delete any shipmethods for country --->
			<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
			DELETE FROM tbl_shipmethcntry_rel
			WHERE shpmet_cntry_Country_ID = #countryID#
			</cfquery>
			
			<!---Delete any ranges for shipping methods in the country.--->
			<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
			DELETE FROM tbl_shipranges 
			WHERE ship_range_Method_ID IN 
			(SELECT shpmet_cntry_Meth_ID 
			FROM tbl_shipmethcntry_rel 
			WHERE shpmet_cntry_Country_ID = #countryID#)
			</cfquery>
			
			<!---Delete actual ship methods themselves --->
			<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
			DELETE FROM tbl_shipmethod 
			WHERE shipmeth_ID IN
			(SELECT shpmet_cntry_Meth_ID 
			FROM tbl_shipmethcntry_rel 
			WHERE shpmet_cntry_Country_ID = #countryID#)
			</cfquery>	
			
			<!--- Delete the actual country --->
			<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
			DELETE FROM tbl_list_countries WHERE country_ID = #countryID#
			</cfquery>

		<cfelse>
			<!--- Update the country --->
			<cfparam name="FORM.country_Archive#id#" default="#URL.CountryView#">
			<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
			UPDATE tbl_list_countries 
				SET 
					country_Sort = #Evaluate("FORM.country_Sort#id#")#, 
					country_Code = '#Evaluate("FORM.country_Code#id#")#', 
					country_Name = '#Evaluate("FORM.country_Name#id#")#', 
					country_Archive = #Evaluate("FORM.country_Archive#id#")#, 
					<cfif IsDefined("FORM.defCountry") AND FORM.defCountry EQ countryID>
						country_DefaultCountry = 1
						<cfelse>
						country_DefaultCountry = 0
					</cfif>
			WHERE country_ID = #countryID#
			</cfquery>
			<cfif IsDefined("FORM.defCountry") AND FORM.defCountry EQ countryID>
				<cfset Application.DefaultCountryID = countryID />
			</cfif>
		</cfif>
	</cfloop>
	
	<!--- If all states for a country are archived or deleted, unarchive the phantom state --->
	<cfquery name="rsCheckActive" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
	SELECT DISTINCT c.country_ID
	FROM tbl_list_countries c
	INNER JOIN tbl_stateprov s
	ON c.country_ID = s.stprv_Country_ID
	WHERE s.stprv_Archive = 0 AND s.stprv_Code <> 'None'
	</cfquery>
	
	<!--- Unarchive phantom states --->
	<cfquery name="rsCheckPhantom" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
	UPDATE tbl_stateprov SET stprv_Archive = 0 
	WHERE stprv_Code = 'None' 
	AND stprv_Country_ID NOT IN (#ValueList(rsCheckActive.country_ID)#)
	</cfquery>
	
	<!--- Archive phantom states --->
	<cfquery name="rsCheckPhantom" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
	UPDATE tbl_stateprov SET stprv_Archive = 1 
	WHERE stprv_Code = 'None' 
	AND stprv_Country_ID IN (#ValueList(rsCheckActive.country_ID)#)
	</cfquery>

  <cflocation url="#request.ThisPageQS#" addtoken="no">
</cfif>

<!--- Get Records --->
<!--- Query for Location drop down for new adds --->
<cfquery name="rsGetCountries" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
SELECT country_ID, country_Name 
FROM tbl_list_countries 
WHERE country_Archive = #URL.CountryView# 
ORDER BY country_Sort, country_Name
</cfquery>

<!--- List to display all countries and states --->
<cfquery name="rsCountryList" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
SELECT c.country_ID, 
c.country_Code, 
c.country_Sort, 
c.country_Name, 
c.country_Archive, 
c.country_DefaultCountry, 
s.stprv_Ship_Ext, 
s.stprv_ID, 
s.stprv_Code, 
s.stprv_Name, 
s.stprv_Archive 
FROM tbl_list_countries c
LEFT JOIN tbl_stateprov s
ON c.country_ID = s.stprv_Country_ID 
WHERE c.country_Archive = #URL.CountryView# 
ORDER BY c.country_Sort, 
c.country_Name, 
s.stprv_Name
</cfquery>

<!--- Set defaults in event of empty lists --->
<cfparam name="UsedStateList" default="0">
<cfparam name="UsedShippingMethodList" default="0">
<cfparam name="UsedCountryList" default="0">
<cfparam name="CustomerCountryList" default="0">
<cfparam name="CustomerStateList" default="0">
<!--- Create a query with all of customer related states to check for deletion
Use ListFind against UseStateList to check for deletion --->
<cfquery name="rsUsedStateList" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
SELECT DISTINCT CustSt_StPrv_ID 
FROM tbl_custstate
</cfquery>
<cfif rsUsedStateList.recordCount GT 0>
	<cfset UsedStateList = ValueList(rsUsedStateList.CustSt_StPrv_ID)>
</cfif>
<!--- 
Check shipping methods for country relation
    if not exist, allow delete of country, else
        check orders
           if not exist, allow delete of shipping method and country, else
               allow only archive of shipping method and country
--->

<!--- Check orders for shipping method --->
<cfquery name="rsUsedShippingMethodList" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
SELECT DISTINCT order_ShipMeth_ID FROM tbl_orders
</cfquery>
<cfif rsUsedShippingMethodList.RecordCount GT 0>
	<cfset UsedShippingMethodList = ValueList(rsUsedShippingMethodList.order_ShipMeth_ID)>
</cfif>

<!--- Check shipping methods for countries where shipping method has orders --->
<cfquery name="rsUsedCountryList" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
SELECT DISTINCT shpmet_cntry_Country_ID 
FROM tbl_shipmethcntry_rel
WHERE shpmet_cntry_Meth_ID
NOT IN (#UsedShippingMethodList#)
</cfquery>
<cfif rsUsedCountryList.RecordCount GT 0>
	<cfset UsedCountryList = ValueList(rsUsedCountryList.shpmet_cntry_Country_ID)>
</cfif>

<!--- Check customer table for countries/states where customer resides --->
<cfquery name="rsCustomerCountryList" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
SELECT DISTINCT
c.CustSt_StPrv_ID,
s.stprv_Country_ID
FROM tbl_custstate c
INNER JOIN tbl_stateprov s
ON s.stprv_ID = c.CustSt_StPrv_ID
</cfquery>
<cfif rsCustomerCountryList.RecordCount GT 0>
	<cfset CustomerCountryList = ValueList(rsCustomerCountryList.stprv_Country_ID)>
    <cfset CustomerStateList = ValueList(rsCustomerCountryList.CustSt_StPrv_ID)>
</cfif>
</cfsilent>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>CW Admin: Countries/Regions</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="assets/admin.css" rel="stylesheet" type="text/css">
</head>
<body> 
<!--- Include Admin Navigation Menu---> 
<cfinclude template="CWIncNav.cfm"> 
<div id="divMainContent"> 
  <h1><cfoutput>#CurrentStatus#</cfoutput> Countries/Regions</h1> 
  <p> 
    <cfif CurrentStatus EQ "Active"> 
      <a href="<cfoutput>#request.ThisPage#</cfoutput>?CountryView=1">View Archived</a> 
      <cfelse> 
      <a href="<cfoutput>#request.ThisPage#</cfoutput>?CountryView=0">View Active</a> 
    </cfif> 
  </p> 
  <cfif CurrentStatus EQ "Active"> 
    <cfform name="Add" method="POST" action="#request.ThisPage#"> 
      <table> 
        <caption>
         Add Country / Region / State
        </caption> 
         
        <tr class="altRowEven">
        	<th align="right">Location: </th>
        	<td><select name="stprv_country" id="stprv_country">
							<option value="0">-- New Country --</option>
							<cfoutput query="rsGetCountries">
								<option value="#country_ID#">#country_Name#</option>
							</cfoutput>
					</select></td>
       	</tr>
        <tr class="altRowEven">
					<th align="right">Name: </th>
        	<td><cfinput name="country_Name" required="yes" type="text"  message="Name is Required" size="25"></td>
       	</tr>
        <tr class="altRowEven">
        	<th align="right">Code: </th>
        	<td><cfinput name="country_Code" type="text" size="8" required="yes" message="Code is Required"></td>
       	</tr>
        <tr class="altRowEven">
					<th align="right">Sort: </th>
        	<td><cfinput name="country_Sort" type="text" value="0" size="3" required="yes"  message="Sort is Required and must be a Numeric Value" validate="float"></td>
       	</tr>
      </table> 
    	<p>
    		<input name="AddRecord" type="submit" class="formButton" id="AddRecord" value="Add">
   			</p>
    </cfform> 
  </cfif> 
  <!--- END IF - CurrentStatus EQ "Active" ---> 
  <!--- Only show table if we have records ---> 
  <cfif rsCountryList.RecordCount NEQ 0> 
		<cfset iCountryList = ValueList(rsCountryList.country_ID)>
    <cfform action="#request.ThisPageQS#" method="POST" name="Update"> 
			<cfquery name="CheckStates" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
			 SELECT DISTINCT stprv_Country_ID FROM tbl_stateprov WHERE stprv_Code <> 'None'
			</cfquery>
			<cfset CheckStateList = ValueList(CheckStates.stprv_Country_ID)>
      <table> 
        <caption> 
        <cfoutput>#CurrentStatus#</cfoutput> Countries/Regions
        </caption> 
        <tr> 
          <th align="center">Code</th> 
          <th align="center">Name</th> 
          <th align="center">Sort</th> 
          <th align="center">Default</th>
          <th align="center">Delete</th> 
          <th align="center">
						<cfif CurrentStatus EQ "Active">
               Archive
              <cfelse> 
              Activate
            </cfif></th> 
        </tr> 
        <cfset countryCounter = 0> 
        <cfset stateCounter = 0> 
        <cfoutput query="rsCountryList" group="country_ID"> 
          <cfset countryCounter = IncrementValue(countryCounter)> 
          <tr class="#IIF(countryCounter MOD 2, DE('altRowEven'), DE('altRowOdd'))#"> 
            <td rowspan="2" align="right">#countryCounter#.
              <input name="country_ID#countryCounter#" type="hidden" size="2" id="country_ID#countryCounter#" value="#country_ID#"> 
            <cfinput type="text" name="country_Code#countryCounter#" value="#country_Code#" required="yes" message="Country Code is required for country number #countryCounter#" size="8"></td> 
            <td><cfinput type="text" name="country_Name#countryCounter#" value="#country_Name#" required="yes" message="Country name is required country number #countryCounter#" size="25"></td> 
            <td align="center"><cfinput name="country_Sort#countryCounter#" type="text" value="#country_Sort#" size="3" required="yes" message="Sort Must Be a Numeric Value for country number #countryCounter#"> </td> 
            <td align="center"><input name="defCountry" type="radio" class="formRadio" value="#country_ID#"<cfif country_DefaultCountry EQ 1> checked</cfif>></td>
            <td align="center"><input name="country_Delete#countryCounter#" value="1" type="checkbox" class="formCheckbox"<cfif ListFind(CheckStateList,country_ID) NEQ 0 
			OR ListFind(UsedCountryList,country_ID) NEQ 0
			OR ListFind(CustomerCountryList,country_ID) NEQ 0> disabled="disabled"</cfif>> </td> 
            <td align="center"><input name="country_Archive#countryCounter#" value="<cfif URL.CountryView EQ 1>0<cfelse>1</cfif>" type="checkbox" class="formCheckbox"
			<cfif ListFind(CustomerCountryList,country_ID) NEQ 0>onclick="if(this.checked) return confirm('This country has customers associated with it. Are you sure you want to archive?')"</cfif>></td> 
          </tr> 
          <tr class="#IIF(countryCounter MOD 2, DE('altRowEven'), DE('altRowOdd'))#"> 
            <td colspan="5">
								<cfset haveActiveState = False>
								<cfset stateTable = "">
                <cfif ListValueCount(iCountryList,country_ID) GT 1>
									<cfsavecontent variable="stateTable">
									<table> 
										<tr> 
											<th>Code</th> 
											<th>Name</th>
											<th>Ship Ext</th>
											<th>Delete</th> 
											<th>Archive</th> 
										</tr> 
										<cfoutput>
											<cfif stprv_Code NEQ "None">
												<cfif stprv_Archive NEQ 1 AND haveActiveState EQ False>
													<cfset haveActiveState = True>
												</cfif>
												<cfset stateCounter = IncrementValue(stateCounter)>
												<tr> 
													<td align="right"><input type="hidden" name="stprv_ID#stateCounter#" value="#stprv_ID#">
														#stateCounter#.<cfinput type="text" name="stprv_Code#stateCounter#" value="#stprv_Code#" required="yes" message="State Code is required for state number #stateCounter#" size="3"></td> 
													<td><cfinput type="text" name="stprv_Name#stateCounter#" value="#stprv_Name#" required="yes" message="State Name is required for state number #stateCounter#" size="18"></td> 
													<td>#stprv_Ship_Ext#%</td>
													<td align="center"><input type="checkbox" class="formCheckbox" name="stprv_Delete#stateCounter#" value="1"<cfif ListFind(UsedStateList,stprv_ID) NEQ 0 OR ListFind(CustomerStateList,stprv_ID)> disabled="disabled"</cfif>
													></td> 
													<td align="center"><input type="checkbox" class="formCheckbox" name="stprv_Archive#stateCounter#" value="1"<cfif stprv_Archive EQ 1> checked="checked"</cfif>
													<cfif ListFind(CustomerStateList,stprv_ID) NEQ 0>onclick="if(this.checked) return confirm('This state has customers associated with it. Are you sure you want to archive?')"</cfif>></td> 
												</tr> 
											</cfif>
										</cfoutput> 
									</table> 
									</cfsavecontent>
								</cfif>
								<cfif NOT haveActiveState>
									There are no active states for this country
								</cfif>
								#stateTable#
               </td> 
          </tr> 
        </cfoutput> 
      </table> 
			<input type="hidden" name="countryCounter" value="<cfoutput>#countryCounter#</cfoutput>">
			<input type="hidden" name="stateCounter" value="<cfoutput>#stateCounter#</cfoutput>">
      <input type="submit" name="UpdateCountries" value="Update Countries" class="formButton"> 
    </cfform> 
    <cfelse> 
    <p>There are no <cfoutput>#CurrentStatus#</cfoutput> countries/regions.</p> 
  </cfif> 
</div> 
</body>
</html>
