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
Name: CWTagClearCart.cfm
Description: Clears all cart information, including temporary
	cart information in the database and all client variables.
================================================================
--->

<!--- [ DELETE CART COMPLETELY ] === START ========== --->
<!--- Delete All Items From "Cart" table --->
<cfquery datasource="#request.dsn#" username="#request.dsnUsername#" password="#request.dsnPassword#">
  DELETE FROM tbl_cart 
  WHERE cart_custcart_ID='#Client.CartID#'
</cfquery>
<!--- Now delete all Client.Variables for this browser. --->
<cfloop index="CV" list="#GetClientVariablesList()#">
	<cfif CV NEQ "CartID">
		<cfset DeleteClientVariable(CV)>
	</cfif>
</cfloop><!--- [ DELETE CART COMPLETELY ] === END ========================= --->
</cfsilent>