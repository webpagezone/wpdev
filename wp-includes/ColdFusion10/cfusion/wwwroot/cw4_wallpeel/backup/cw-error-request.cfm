<!---
==========================================================
Application: Cartweaver 4 ColdFusion
Copyright 2002 - 2013, All Rights Reserved
Developer: Application Dynamics, Inc. | Cartweaver.com
Licensing: http://www.cartweaver.com/eula
Support: http://www.cartweaver.com/support
==========================================================
File: cw-error-request.cfm
File Date: 2012-02-01
Description: handles exception errors via cferror in cw-app-onrequeststart
Note: html only, no CF processing in request handling page content
==========================================================
--->
<!DOCTYPE html>
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
		<div class="col-lg-2 ">


		</div>
		<div class="col-lg-3 ">
		    <!--- cart links --->
		    <cfinclude template="_top_user.cfm">

		</div>
		<div class="col-lg-4 ">
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

			<!-- Page Content Area -->
			<div style="text-align:center;">
				<div style="padding:200px 0;margin:0 auto;width:370px;">
					<h1 style="text-align:center;">An error has occurred</h1>
					<p>&nbsp;</p>
					<p>&nbsp;</p>
					<p style="text-align:center;">
					Please go <a href="javascript:history.back()">back</a> and try another option.</p>
					<p>&nbsp;</p>
					<p style="text-align:center;">If the problem persists, <a href='mailto:#error.mailto#?subject=Error on Page #error.template#&body=Message: #error.diagnostics# | Error on Page: #error.template# | Referring Page: #error.httpreferer# | Query String:#error.querystring# | Date Time: #error.dateTime#'>contact the site administrator</a>.</p>
				</div>
			</div>
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