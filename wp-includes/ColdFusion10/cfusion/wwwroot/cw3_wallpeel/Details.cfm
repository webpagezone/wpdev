

<!DOCTYPE html>
<html>
<head>
	<cfinclude template="_css_js.cfm">
</head>
<body>

<!---<nav class="top_nav">
     <div class="container">
		<div>
	        <!--- user links --->
			<cfinclude template="_top_user.cfm">
       </div>
     </div>
</nav>--->
<div class="container top-logo-search">
<div class="row" >

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
<div class="container">
<div class="row">

    	<div class="col-lg-12">
			<!--- menu --->
			<cfinclude template="_top_nav_main.cfm">
		</div>
	</div>
</div>


<div class="container">
<div class="row">


		<cfinclude template="cw3/CWIncDetails.cfm">
		</div>
	</div>
</div>
<div class="container">
<div class="footer">

		<cfinclude template="_sticky_footer.cfm">
	</div>
</div>


</body>
</html>
