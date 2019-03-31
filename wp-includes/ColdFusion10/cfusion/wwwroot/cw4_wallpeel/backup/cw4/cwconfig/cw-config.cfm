<cfsilent>
<!---
==========================================================
Application: Cartweaver 4 ColdFusion
Copyright 2002 - 2013, All Rights Reserved
Developer: Application Dynamics Inc. | Cartweaver.com
Licensing: http://www.cartweaver.com/eula
Support: http://www.cartweaver.com/support
==========================================================
File: cw-config.cfm
File Date: 2013-01-28
Description:
Handles Datasource Settings for Application DSN Connection
==========================================================
--->
<!--- //////////// --->
<!--- CARTWEAVER CF DATASOURCE SETTINGS --->
<!--- ENTER THESE VALUES FOR YOUR DSN CONNECTION --->
<!--- //////////// --->

<cfset request.cwapp.datasourcename = "cw4_wallpeel">
<!--- name of your ColdFusion datasource (DSN) --->

<cfset request.cwapp.datasourceusername = "root">
<!--- the username for your DSN (optional if not required by server) --->

<cfset request.cwapp.datasourcepassword= "mysql">
<!--- the password for your DSN (optional if not required by server) --->

<!--- //////////// --->
<!--- END USER SETTINGS --->
<!--- //////////// --->

</cfsilent>