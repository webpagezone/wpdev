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
<nav class="<!--- navbar ---> navbar-default navbar-fixed-top">
      <div class="container">
        <div class="navbar-header">
          <!--- <a href="../" class="navbar-brand">Bootswatch</a> --->
          <button class="navbar-toggle" type="button" data-toggle="collapse" data-target="#navbar-main">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
        </div>
        <div class="navbar-collapse collapse" id="navbar-main">

          <!--- <ul class="nav navbar-nav">
            <li class="dropdown">
              <a class="dropdown-toggle" data-toggle="dropdown" href="#" id="themes">Themes <span class="caret"></span></a>
              <ul class="dropdown-menu" aria-labelledby="themes">
                <li><a href="../default/">Default</a></li>
                <li class="divider"></li>
                <li><a href="../cerulean/">Cerulean</a></li>
                <li><a href="../cosmo/">Cosmo</a></li>
                <li><a href="../cyborg/">Cyborg</a></li>
                <li><a href="../darkly/">Darkly</a></li>
                <li><a href="../flatly/">Flatly</a></li>
                <li><a href="../journal/">Journal</a></li>
                <li><a href="../lumen/">Lumen</a></li>
                <li><a href="../paper/">Paper</a></li>
                <li><a href="../readable/">Readable</a></li>
                <li><a href="../sandstone/">Sandstone</a></li>
                <li><a href="../simplex/">Simplex</a></li>
                <li><a href="../slate/">Slate</a></li>
                <li><a href="../spacelab/">Spacelab</a></li>
                <li><a href="../superhero/">Superhero</a></li>
                <li><a href="../united/">United</a></li>
                <li><a href="../yeti/">Yeti</a></li>
              </ul>
            </li>
            <li>
              <a href="../help/">Help</a>
            </li>
            <li>
              <a href="http://news.bootswatch.com">Blog</a>
            </li>
            <li class="dropdown">
              <a class="dropdown-toggle" data-toggle="dropdown" href="#" id="download">Download <span class="caret"></span></a>
              <ul class="dropdown-menu" aria-labelledby="download">
                <li><a href="./bootstrap.min.css">bootstrap.min.css</a></li>
                <li><a href="./bootstrap.css">bootstrap.css</a></li>
                <li class="divider"></li>
                <li><a href="./variables.less">variables.less</a></li>
                <li><a href="./bootswatch.less">bootswatch.less</a></li>
                <li class="divider"></li>
                <li><a href="./_variables.scss">_variables.scss</a></li>
                <li><a href="./_bootswatch.scss">_bootswatch.scss</a></li>
              </ul>
            </li>
          </ul> --->

           <!--- cart links --->
				 <cfinclude template="_top_user.cfm">

           <!--- cart links --->
				    <cfinclude template="_top_cart.cfm">


        </div>
      </div>
    </nav>

<div class="row" >
	<div class="container">
		<div class="col-lg-3">
		    <!--- logo links --->
			<cfinclude template="_logo.cfm">
		</div>
		<div class="col-lg-2">

		</div>
		<div class="col-lg-3">


		</div>
		<div class="col-lg-4">

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