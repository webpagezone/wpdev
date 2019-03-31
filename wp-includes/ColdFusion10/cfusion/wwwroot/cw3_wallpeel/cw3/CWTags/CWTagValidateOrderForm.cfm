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
Name: Validate Order Form Data
Description: Here we validate the data submitted in the order form. 
If the data fits the required parameters we send continue on with 
the transaction. If not we halt the transaction and pass back error 
messages to be displayed by the calling template.
================================================================
--->
<cfparam name="request.FieldInvalid" default="NO">
<cfif isdefined("form.fieldnames")>
	<cfloop list=#form.fieldnames# index="i">
		<cfset form[i] = request.makeHtmlSafe(form[i])>
	</cfloop>
</cfif>
<cfif IsDefined ('FORM.SHIPSAME')>
	<cfset ShipAddress = "SAME">
	<!--- Set shipping form fields to billing form fields --->
	<cfset FORM.cstShpName = FORM.cstFirstName & " " & FORM.cstLastName>
	<cfset FORM.cstShpAddress1 = FORM.cstAddress1>
	<cfset FORM.cstShpAddress2 = FORM.cstAddress2>
	<cfset FORM.cstShpCity = FORM.cstCity>
	<cfset FORM.cstShpCountry = FORM.cstCountry>	
	<cfset FORM.cstShpStateProv = FORM.cstStateProv>
	<cfset FORM.cstShpZip = FORM.cstZip>
	<cfelse>
	<cfset ShipAddress = "NotSAME">
</cfif>
	<cfscript>
// Check First Name
if (FORM.cstFirstName eq "")
  { request.CST_FIRSTNAME_ERROR = "YES";
    request.FieldInvalid = "YES";
}

// Check Last Name
if (FORM.cstLastName eq "")
  { request.CST_LASTNAME_ERROR = "YES";
   request.FieldInvalid = "YES";
}

// Check Address 1
if (FORM.cstAddress1 eq "")
  { request.CST_ADDRESS1_ERROR = "YES";
   request.FieldInvalid = "YES";
}

// Check Bill to City
if (FORM.cstCity eq "")
  { request.CST_CITY_ERROR = "YES";
   request.FieldInvalid = "YES";
}

// Check Bill to State Prov
if (FORM.cstStateProv eq "forgot")
  { request.CST_STATEPROV_ERROR = "YES";
   request.FieldInvalid = "YES";
}

// Check Bill to Zip Code
BillToZip= FORM.cstZip;
if (Len(BillToZip) LT "5")
	 {request.CST_ZIP_ERROR = "YES";
	 request.FieldInvalid = "YES";
}

// Check Phone	 
if (FORM.cstPHONE eq "")
  { request.CST_PHONE_ERROR = "YES";
}

// Check Email
thisEmail= FORM.cstEmail;

if (ListContainsNoCase(thisEmail, "@") EQ "0" OR ListContainsNoCase(thisEmail, ".") EQ "0")
  {request.CST_EMAIL_ERROR = "YES";
   request.FieldInvalid = "YES";
}

// Check Username
if (FORM.cstUsername eq "")
  { request.CST_USERNAME_ERROR = "YES";
   request.FieldInvalid = "YES";
}

// Check Password
if (FORM.cstPassword eq "" OR FORM.cstPassword NEQ FORM.cstPasswordConfirm)
  { request.CST_PASSWORD_ERROR = "YES";
   request.FieldInvalid = "YES";
}

// If Ship Same is not selected, validate Shipping Address data
if (ShipAddress eq "NotSAME")
{
	if (FORM.cstShpName eq "")
	  { request.CST_SHPNAME_ERROR = "YES";
	   request.FieldInvalid = "YES";
	}
	if (FORM.cstShpAddress1 eq "")
	  { request.CST_SHPADDRESS1_ERROR = "YES";
	   request.FieldInvalid = "YES";
	}
	if (FORM.cstShpCity eq "")
	  { request.CST_SHPCITY_ERROR = "YES";
	   request.FieldInvalid = "YES";
	}
	if (FORM.cstShpStateProv eq "forgot")
	  { request.CST_SHPSTATEPROV_ERROR = "YES";
	   request.FieldInvalid = "YES";
	}
	
	// Check Bill to Zip Code
	ShipToZip= FORM.cstShpZip;
	if (Len(ShipToZip) LT "5")
		 {request.CST_SHPZIP_ERROR = "YES";
		 request.FieldInvalid = "YES";
		 }
// END SHIP SAME
}

</cfscript>
<!--- Check for duplicate email addresses --->
<cfquery name="rsCheckForDupEmail" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
SELECT Count(cst_Email) as EmailCount FROM tbl_customers WHERE cst_ID <> '#client.CustomerID#' AND cst_Email = '#FORM.cstEmail#'
</cfquery>
<!--- If there is a duplicate email address and it's not for the current username, throw an error --->
<cfif rsCheckForDupEmail.EmailCount GT 0>
		<cfset request.FieldInvalid = "YES">
		<cfset request.EmailError = "The requested email address is already in use for another account. Please enter a new email address, or complete the Forgotten Password form.">
</cfif>
<!--- Check for duplicate usernames --->
<!--- Select records with matching usernames --->
<cfquery name="rsCheckForDup" datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
SELECT Count(cst_Username) as UsernameCount 
FROM tbl_customers 
WHERE 
	cst_Username = '#FORM.cstUsername#' 
	<!--- The user is changing their username, check for everything but the current customer ID for duplicates --->
	<cfif client.CustomerID NEQ 0>
		AND cst_ID <> '#client.CustomerID#'
	</cfif>
</cfquery>
<cfif rsCheckForDup.UsernameCount GT 0>
	<cfset request.FieldInvalid = "YES">
	<cfset request.UserError = "The requested username is already taken. Please choose a new username.">
</cfif>
</cfsilent>
