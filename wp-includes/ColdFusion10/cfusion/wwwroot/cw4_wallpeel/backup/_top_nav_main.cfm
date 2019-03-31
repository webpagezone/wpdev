
<div class="navbar-wrapper">
  	<!---<nav class="navbar navbar-inverse navbar-static-top roundCorner boxShadow" role="navigation">--->
      <nav class="navbar <!--- navbar-inverse --->navbar-default <!--- boxShadow --->" role="navigation">
             <div class="navbar-header">
                  <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                      <span class="sr-only">Toggle navigation</span>
                      <span class="icon-bar"></span>
                      <span class="icon-bar"></span>
                      <span class="icon-bar"></span>
                  </button>

              </div>
              <div id="navbar" class="navbar-collapse collapse">

               <cfmodule template="cw4/cwapp/mod/cw-mod-searchnav-cust.cfm"
					search_type="boot_list"
					show_empty="0"
					all_categories_label=""
					all_secondaries_label=""
					show_secondary="1"
					show_product_count="0"
					menu_id="topnav"
					menu_class="nav navbar-nav"
					>
                <!---   <ul class="nav navbar-nav">
                 		<li><a href="index.cfm">home</a></li>

                      <!--- STORE NAVIGATION --->

				 <li>
					<!--- category navigation --->
					<cfmodule template="cw4/cwapp/mod/cw-mod-searchnav.cfm"
					search_type="links"
					show_empty="0"
					show_secondary="1"
					show_product_count="0"
					relate_cats="#application.cw.appEnableCatsRelated#"
					all_categories_label=""
					all_secondaries_label="All"
					>

                      </li>

                  </ul> --->


                <!--- <ul class="nav navbar-nav navbar-right">
                        	<li>

                             </li>

                      <li>&nbsp;</li>
                  </ul> --->
             </div>
      </nav>
  </div>



