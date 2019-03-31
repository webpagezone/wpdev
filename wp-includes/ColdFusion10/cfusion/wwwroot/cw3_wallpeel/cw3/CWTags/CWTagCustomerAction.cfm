<cfsilent>
<!--- 
================================================================
Application Info: Cartweaver© 2002 - 2007, All Rights Reserved.
Developer Info: Application Dynamics Inc.
                1560 NE 10th
                East Wenatchee, WA 98802
Support Info: http://www.cartweaver.com/go/cfhelp
				
Cartweaver Version: 3.0.7  -  Date: 7/8/2007
================================================================
Name: Customer Action Tag
Description: 
	This custom tag handles logging in customers, adding new 
	customers and updating existing customers.

Attributes:
	Action (required): Determines the action to be taken inside 
		the Customer Action Custom Tag. Valid values are:

		*	Login: Login a user. If you use this action you must also 
			pass the Username, Password and Redirect attributes.

		*	New: Create a new user. This action adds a new user based 
			on the form fields submitted from CWIncOrderForm.cfm. No 
			other attributes are required, but your form must have 
			all the same fields as CWIncOrderForm.cfm.

		*	Return: Update an existing customer. This action updates 
			an existing customer based on the form fields submitted 
			from CWIncOrderForm.cfm. No other attributes are required, 
			but your form must have all the same fields as CWIncOrderForm.cfm.

	Username: The username that you wish to log in to the site. 
		This will normally be passed from a form field.

	Password: The password for the username you want to log in to the 
		site, as specified in the Username attribute. This will normally 
		be passed from a form field.

	Redirect: The page a successfully logged in user should be redirected 
		to. The default is request.targetGoToCart, which is defined in the 
		Application.cfm file.
================================================================
--->
<cfparam name="attributes.Action" default="Login">
<cfparam name="ThisCustomerID" default="0">
<cfparam name="attributes.Redirect" default="#request.targetGoToCart#">

<cfinclude template="CWIncDiscountFunctions.cfm">
<!--- Check to see which action is to be taken --->
<cfswitch expression="#attributes.Action#">
	<!--- Process a user login. The username and password should be passed via attributes in the <cfmodule> call --->
	<cfcase value="Login">
		<!--- Query the database for the username and password --->
		<cfquery name="rsGetCustomer" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
		SELECT cst_ID, cst_ShpCity 
		FROM tbl_customers 
		WHERE cst_Username = '#attributes.Username#' AND
		cst_Password = '#attributes.Password#' 
		</cfquery> 
		<!--- If a match was found Set the Customer ID Client variable ---> 
		<cfif rsGetCustomer.RecordCount IS 1> 
			<cfset Client.CustomerID = rsGetCustomer.cst_ID> 
			<!--- Remove discounts that have already been used to their limit by this customer --->
			<cfset session.availableDiscounts = cwRemoveDiscountsWithLimits(session.availableDiscounts, Client.CustomerID)>
		<cfelse>
			<!--- The user's login failed. Set an error --->			
			<cfset attributes.Redirect = "#attributes.Redirect#?LoginError=#URLEncodedFormat("We're sorry, but your username and password are incorrect.")#">
			<cfset DeleteClientVariable("CheckingOut")> 
		</cfif> 
	</cfcase>
	<!--- End Login --->
	<!--- Add a new customer --->
	<cfcase value="New">
		<cfset ShipName = '#FORM.cstFirstName# #FORM.cstLastName#'>
		<!--- Create a new Unique Customer ID --->
		<cfset IDstring = CreateUUID()>
		<cfset ThisCustomerID = Left(IDstring,9)&LSDateFormat(Now(),'MM-DD-YY')>
		<!--- INSERT NEW CUSTOMER DATA --->
		<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
		INSERT INTO tbl_customers (cst_ID,cst_FirstName, cst_LastName, cst_Address1,
		cst_Address2, cst_City, cst_Zip, cst_ShpName, cst_ShpAddress1, cst_ShpAddress2,
		cst_ShpCity, cst_ShpZip, cst_Phone, cst_Email, cst_Username, cst_Password,cst_Type_ID)
		VALUES	
		('#ThisCustomerID#','#FORM.cstFirstName#','#FORM.cstLastName#','#FORM.cstAddress1#',
		'#FORM.cstAddress2#','#FORM.cstCity#','#FORM.cstZip#',
		<cfif IsDefined("FORM.ShipSame")>'#ShipName#'<cfelse>'#FORM.cstShpName#'</cfif>
		,
		<cfif IsDefined("FORM.ShipSame")>'#FORM.cstAddress1#'<cfelse>'#FORM.cstShpAddress1#'</cfif>
		,
		<cfif IsDefined("FORM.ShipSame")>'#FORM.cstAddress2#'<cfelse>'#FORM.cstShpAddress2#'</cfif>
		,
		<cfif IsDefined("FORM.ShipSame")>'#FORM.cstCity#'<cfelse>'#FORM.cstShpCity#'</cfif>
		,
		<cfif IsDefined("FORM.ShipSame")>'#FORM.cstZip#'<cfelse>'#FORM.cstShpZip#'</cfif>
		,'#FORM.cstPhone#','#FORM.cstEmail#','#FORM.cstUsername#','#FORM.cstPassword#',1	)
		</cfquery>
<!---  Insert new State and Country "BillTo" references --->
		<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
		INSERT INTO tbl_custstate (CustSt_Cust_ID, CustSt_StPrv_ID, CustSt_Destination)
		VALUES ('#ThisCustomerID#',#FORM.cstStateProv#,'BillTo')
		</cfquery>
<!---  Insert new State and Country "BillTo" references --->
		<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
		INSERT INTO tbl_custstate (CustSt_Cust_ID, CustSt_StPrv_ID, CustSt_Destination)
		VALUES ('#ThisCustomerID#',
		<cfif IsDefined("FORM.ShipSame")>#FORM.cstStateProv#<cfelse>#FORM.cstShpStateProv#</cfif>
		,'ShipTo')
		</cfquery>
		<!--- Set Client ID --->
		<cfset Client.CustomerID = ThisCustomerID>
		<cfset Client.CheckingOut = "YES">
	</cfcase>
	<!--- End Add new customer --->
	<!--- Update a returning customer --->
	<cfcase value="Return">
		<!--- Udate Customer data --->
		<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
		UPDATE tbl_customers 
		SET cst_Firstname='#FORM.cstFirstName#', 
		cst_Lastname='#FORM.cstLastName#',
		cst_Address1='#FORM.cstAddress1#', 
		cst_Address2='#FORM.cstAddress2#', 
		cst_City='#FORM.cstCity#',
		cst_Zip='#FORM.cstZip#', 
		cst_Shpname='#FORM.cstShpName#', 
		cst_ShpAddress1='#FORM.cstShpAddress1#',
		cst_ShpAddress2='#FORM.cstShpAddress2#', 
		cst_ShpCity='#FORM.cstShpCity#', 
		cst_ShpZip='#FORM.cstShpZip#',
		cst_Phone='#FORM.cstPhone#', 
		cst_Email='#FORM.cstEmail#', 
		cst_Username='#FORM.cstUsername#',
		cst_Password='#FORM.cstPassword#' 
		WHERE cst_ID='#client.CustomerID#'
		</cfquery>
		<!---  Update State "BillTo" references --->
		<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
		UPDATE tbl_custstate SET CustSt_StPrv_ID = #FORM.cstStateProv# WHERE CustSt_Cust_ID
		='#client.CustomerID#' AND CustSt_Destination ='BillTo'
		</cfquery>
		<!---  Update State "ShipTo" references --->
		<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
		UPDATE tbl_custstate SET CustSt_StPrv_ID = #FORM.cstShpStateProv# WHERE CustSt_Cust_ID
		='#client.CustomerID#' AND CustSt_Destination ='ShipTo'
		</cfquery>
		<cfset Client.CheckingOut = "YES">
	</cfcase>
	<!--- End Update returning customer --->
</cfswitch>

<!--- For all three modes (login, new, return) get customer state and country info for taxes and shipping --->
<cfquery name="rsGetCountryID"  datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
SELECT s.stprv_Country_ID, cs.CustSt_StPrv_ID 
FROM tbl_stateprov s
INNER JOIN (tbl_customers c
INNER JOIN tbl_custstate cs
ON c.cst_ID = cs.CustSt_Cust_ID)
ON s.stprv_ID = cs.CustSt_StPrv_ID 
WHERE cs.CustSt_Destination	= 'ShipTo' AND c.cst_ID = '#Client.CustomerID#' 
</cfquery> 
<!---  Set Client.ShipToCountryID based on query results---> 
<cfset Client.ShipToCountryID = rsGetCountryID.stprv_Country_ID>

<cfif IsDefined("Application.ChargeTaxBasedOn") AND Application.ChargeTaxBasedOn EQ "Billing">
	<cfquery name="rsGetCountryID"  datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
	SELECT s.stprv_Country_ID, cs.CustSt_StPrv_ID 
	FROM tbl_stateprov s
	INNER JOIN (tbl_customers c
	INNER JOIN tbl_custstate cs
	ON c.cst_ID = cs.CustSt_Cust_ID)
	ON s.stprv_ID = cs.CustSt_StPrv_ID 
	WHERE cs.CustSt_Destination	= 'BillTo' AND c.cst_ID = '#Client.CustomerID#' 
	</cfquery> 
</cfif>
<!--- Tax state/country now set to shipping/billing depending on store config --->
<cfif rsGetCountryID.recordCount GT 0>
	<cfset Client.TaxStateID = rsGetCountryID.CustSt_StPrv_ID />
	<cfset Client.TaxCountryID = rsGetCountryID.stprv_Country_ID />
</cfif>


<!--- Redirect back to order form to prevent form reposting --->
<cflocation url="#attributes.Redirect#" addtoken="yes">
</cfsilent>
