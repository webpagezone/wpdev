<!--- cart links --->
<!---
<header class="navbar navbar-static-top bs-docs-nav" id="top" role="banner">
  <div class="container">
    <div class="navbar-header">
      <button class="navbar-toggle collapsed" type="button" data-toggle="collapse" data-target=".bs-navbar-collapse">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a href="../" class="navbar-brand">Home</a>
    </div>

    <nav class="collapse navbar-collapse bs-navbar-collapse" role="navigation">

	 <ul class="nav navbar-nav">
        <li class="active">
          <a href="../getting-started/">Getting started</a>
        </li>
        <li>
          <a href="../css/">CSS</a>
        </li>
        <li>
          <a href="../components/">Components</a>
        </li>
        <li>
          <a href="../javascript/">JavaScript</a>
        </li>
        <li>
          <a href="../customize/">Customize</a>
        </li>
      </ul>


      <ul class="nav navbar-nav navbar-right">
        <li><a href="http://expo.getbootstrap.com" onclick="ga('send', 'event', 'Navbar', 'Community links', 'Expo');">Expo</a></li>
        <li><a href="http://blog.getbootstrap.com" onclick="ga('send', 'event', 'Navbar', 'Community links', 'Blog');">Blog</a></li>
      </ul>



    </nav>

  </div>
</header>
 --->


<div class="top_nav">
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
       <!--- cart links --->
		<cfinclude template="_top_user.cfm">
       </div>
     </div>
</div>





            <div id="topbar">
                <div class="container">
                    <div class="show-desktop">
                        <div class="quick-access pull-left  hidden-sm hidden-xs">
                            <div class="login links link-active">
                                                                <a href="http://demopavothemes.com/pav_megashop/default/index.php?route=account/register">Register</a> or
                                <a href="http://demopavothemes.com/pav_megashop/default/index.php?route=account/login">Login</a>
                                                            </div>
                        </div>
                        <!--Button -->
                        <div class="quick-top-link  links pull-right">
                            <!-- language -->
                            <div class="btn-group box-language">
                                <div class="pull-left">
<form action="http://demopavothemes.com/pav_megashop/default/index.php?route=common/language/language" method="post" enctype="multipart/form-data" id="language">
  <div class="btn-groups">
    <div data-toggle="dropdown" class="dropdown-toggle">
                        <img src="image/flags/gb.png" alt="English" title="English">
                                        <span>Language</span> <i class="fa fa-angle-down"></i>
    </div>
    <ul class="dropdown-menu">
            <li><a href="en"><img src="image/flags/gb.png" alt="English" title="English" /> English</a></li>
            <li><a href="ar"><img src="image/flags/ar.png" alt="Arabic" title="Arabic" /> Arabic</a></li>
          </ul>
  </div>


  <input type="hidden" name="code" value="" />
  <input type="hidden" name="redirect" value="http://demopavothemes.com/pav_megashop/default/index.php?route=account/login" />
</form>
</div>
                            </div>
                            <!-- currency -->
                            <div class="btn-group box-currency">
                                <div class="quick-access">
<form action="http://demopavothemes.com/pav_megashop/default/index.php?route=common/currency/currency" method="post" enctype="multipart/form-data" id="currency">
  <div class="btn-groups">
    <div class="dropdown-toggle" data-toggle="dropdown">
                            <span>$</span>
                <span>Currency</span>
        <i class="fa fa-angle-down"></i>
    </div>
    <div class="dropdown-menu ">
        <div class="box-currency inner">
                                              <a class="currency-select" id="EUR">
                      €                  </a>
                                                            <a class="currency-select" id="GBP">
                      £                  </a>
                                                            <a class="currency-select" id="USD">
                      $                  </a>
                                    </div>
    </div>
  </div>
  <input type="hidden" name="code" value="" />
  <input type="hidden" name="redirect" value="http://demopavothemes.com/pav_megashop/default/index.php?route=account/login" />
</form>
</div>
                            </div>
                            <!-- user-->
                            <div class="btn-group box-user">
                                <div data-toggle="dropdown">
                                    <span>My Account</span>
                                    <i class="fa fa-angle-down "></i>
                                </div>

                                <ul class="dropdown-menu setting-menu">
                                    <li id="wishlist">
                                        <a href="http://demopavothemes.com/pav_megashop/default/index.php?route=account/wishlist" id="wishlist-total"><i class="fa fa-list-alt"></i>&nbsp;&nbsp;Wish List (0)</a>
                                    </li>
                                    <li class="acount">
                                        <a href="http://demopavothemes.com/pav_megashop/default/index.php?route=account/account"><i class="fa fa-user"></i>&nbsp;&nbsp;My Account</a>
                                    </li>
                                    <li class="shopping-cart">
                                        <a href="http://demopavothemes.com/pav_megashop/default/index.php?route=checkout/cart"><i class="fa fa-bookmark"></i>&nbsp;&nbsp;Shopping Cart</a>
                                    </li>
                                    <li class="checkout">
                                        <a class="last" href="http://demopavothemes.com/pav_megashop/default/index.php?route=checkout/checkout"><i class="fa fa-share"></i>&nbsp;&nbsp;Checkout</a>
                                    </li>
                                </ul>

                            </div>
                        </div>

                    </div>
                </div>
            </div>
            <!-- header -->


