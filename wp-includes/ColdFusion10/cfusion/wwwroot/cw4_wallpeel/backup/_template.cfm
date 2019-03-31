<cfsilent>
<!---
==========================================================
Application: Cartweaver 4 ColdFusion
Copyright 2002 - 2013, All Rights Reserved
Developer: Application Dynamics, Inc. | Cartweaver.com
Licensing: http://www.cartweaver.com/eula
Support: http://www.cartweaver.com/support
==========================================================
File: _template.cfm
File Date: 2014-12-14
Description: container page for index
==========================================================
--->
</cfsilent>

<!DOCTYPE html>
<html>
<head>
	<cfinclude template="_css_js.cfm">
</head>
<body>

<div class="row" >
	<div class="container">
		<div class="col-lg-3 ">
		    <!--- logo links --->
			<cfinclude template="_logo.cfm">
		</div>
		<div class="col-lg-3 ">
		    <!--- cart links --->

		</div>
		<div class="col-lg-3 ">
		    <!--- cart links --->
		    <cfinclude template="_top_user.cfm">

		</div>
		<div class="col-lg-3 ">
		    <!--- cart links --->
		    <cfinclude template="_top_cart.cfm">
		</div>
	</div>
</div>
<div class="row">
	<div class="container">
    	<div class="col-lg-12">
			<!--- menu --->
			<cfinclude template="_top_nav_main.cfm">
		</div>
	</div>
</div>

<div class="container">
	<div class="row">
		<div class="col-sm-12">
	    	<!--- page alerts --->
			<cfinclude template="cw4/cwapp/inc/cw-inc-alerts.cfm">
	    </div>
	</div>
</div>

<div class="row">
	<div class="container">
		<div class="col-lg-12 ">


		</div>
	</div>
</div>
<div class="footer">
	<div class="container">
		<cfinclude template="_sticky_footer.cfm">
	</div>
</div>
</body>
</html>