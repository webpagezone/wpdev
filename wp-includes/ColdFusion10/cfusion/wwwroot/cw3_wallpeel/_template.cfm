

<!DOCTYPE html>
<html>
<head>
	<cfinclude template="_css_js.cfm">
</head>
<body>

<nav class="top_nav">
     <div class="container">
		<div>
	        <!--- user links --->
			<cfinclude template="_top_user.cfm">
       </div>
     </div>
</nav>

<div class="row" >
	<div class="container top-logo-search">
		<div class="col-lg-5">
		    <!--- logo links --->
			<cfinclude template="_logo.cfm">
		</div>
		<div class="col-lg-4">
			 <!--- search --->
			<cfinclude template="_top_search.cfm">
		</div>
		<div class="col-lg-3">
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



<div class="row">
	<div class="container">
		<div class="col-lg-12">
body
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