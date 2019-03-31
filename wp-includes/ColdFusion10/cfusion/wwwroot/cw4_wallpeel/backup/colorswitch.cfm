
<!DOCTYPE html>
<html dir="ltr" lang="en">
<head>
<meta charset="UTF-8" />
<title>test</title>
<base href="http://127.0.0.1/oc/" />
<link href="http://127.0.0.1/oc/image/data/cart.png" rel="icon" />
<link href="http://127.0.0.1/oc/index.php?route=product/product&amp;product_id=50" rel="canonical" />
<link rel="stylesheet" type="text/css" href="catalog/view/theme/default/stylesheet/stylesheet.css" />
<link rel="stylesheet" type="text/css" href="catalog/view/javascript/jquery/colorbox/colorbox.css" media="screen" />
<script type="text/javascript" src="catalog/view/javascript/jquery/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="catalog/view/javascript/jquery/ui/jquery-ui-1.8.16.custom.min.js"></script>
<link rel="stylesheet" type="text/css" href="catalog/view/javascript/jquery/ui/themes/ui-lightness/jquery-ui-1.8.16.custom.css" />
<script type="text/javascript" src="catalog/view/javascript/common.js"></script>
<script type="text/javascript" src="catalog/view/javascript/jquery/tabs.js"></script>
<script type="text/javascript" src="catalog/view/javascript/jquery/colorbox/jquery.colorbox-min.js"></script>
<!--[if IE 7]>
<link rel="stylesheet" type="text/css" href="catalog/view/theme/default/stylesheet/ie7.css" />
<![endif]-->
<!--[if lt IE 7]>
<link rel="stylesheet" type="text/css" href="catalog/view/theme/default/stylesheet/ie6.css" />
<script type="text/javascript" src="catalog/view/javascript/DD_belatedPNG_0.0.8a-min.js"></script>
<script type="text/javascript">
DD_belatedPNG.fix('#logo img');
</script>
<![endif]-->
</head>
<body>
<div id="container">
<div id="header">
    <div id="logo"><a href="http://127.0.0.1/oc/index.php?route=common/home"><img src="http://127.0.0.1/oc/image/data/logo.png" title="Your Store" alt="Your Store" /></a></div>
      <form action="http://127.0.0.1/oc/index.php?route=module/currency" method="post" enctype="multipart/form-data">
  <div id="currency">Currency<br />
                <a title="Euro" onclick="$('input[name=\'currency_code\']').attr('value', 'EUR'); $(this).parent().parent().submit();">€</a>
                        <a title="Pound Sterling" onclick="$('input[name=\'currency_code\']').attr('value', 'GBP'); $(this).parent().parent().submit();">£</a>
                        <a title="US Dollar"><b>$</b></a>
                <input type="hidden" name="currency_code" value="" />
    <input type="hidden" name="redirect" value="http://127.0.0.1/oc/index.php?route=product/product&amp;path=59&amp;product_id=50" />
  </div>
</form>
  <div id="cart">
  <div class="heading">
    <h4>Shopping Cart</h4>
    <a><span id="cart-total">0 item(s) - $0.00</span></a></div>
  <div class="content">
        <div class="empty">Your shopping cart is empty!</div>
      </div>
</div>  <div id="search">
    <div class="button-search"></div>
    <input type="text" name="search" placeholder="Search" value="" />
  </div>
  <div id="welcome">
        Welcome visitor you can <a href="http://127.0.0.1/oc/index.php?route=account/login">login</a> or <a href="http://127.0.0.1/oc/index.php?route=account/register">create an account</a>.      </div>
  <div class="links"><a href="http://127.0.0.1/oc/index.php?route=common/home">Home</a><a href="http://127.0.0.1/oc/index.php?route=account/wishlist" id="wishlist-total">Wish List (0)</a><a href="http://127.0.0.1/oc/index.php?route=account/account">My Account</a><a href="http://127.0.0.1/oc/index.php?route=checkout/cart">Shopping Cart</a><a href="http://127.0.0.1/oc/index.php?route=checkout/checkout">Checkout</a></div>
</div>
<div id="menu">
  <ul>
        <li><a href="http://127.0.0.1/oc/index.php?route=product/category&amp;path=59">svg</a>
          </li>
      </ul>
</div>
<div id="notification"></div>
<div id="column-left">
    <div class="box">
  <div class="box-heading">Categories</div>
  <div class="box-content">
    <ul class="box-category">
            <li>
                <a href="http://127.0.0.1/oc/index.php?route=product/category&amp;path=59" class="active">svg (1)</a>
                      </li>
          </ul>
  </div>
</div>
  </div>

<script type="text/javascript"><!--
                			$(document).ready(function(){
				$('select[name="option[228]"]').change(function() {
					poiChangeSelect($(this));
				});
			});
                        			$(document).ready(function(){
				$('select[name="option[227]"]').change(function() {
					poiChangeSelect($(this));
				});
			});
                		function poiChangeSelect(selectObj)
		{
			$selectedOption = selectObj.find("option:selected");
			var newImg = $selectedOption.attr('src');
			var newImgColorBox = $selectedOption.attr('src-colorbox');
			if(newImg != 'NA')
			{
				poiChangeImage(newImg, newImgColorBox);
			}
			return true;
		}
		function poiChangeImage(newImageSrc, newImageColorBoxSrc)
		{
			$('#image, #zoom1 img, #ma-zoom1 img, #main-image, div.image a.colorbox-product img, div.image #wrap a img, .zoomPad > img, .product-info .image > img').attr('src', newImageSrc);

			if(newImageColorBoxSrc != null)
			{
				//ElevateZoom
				if($('.zoomWindow').length > 0)
				{
					$('.zoomWindow').css('background-image', 'url("' + newImageColorBoxSrc + '")');
				}

				//CloudZoom
				if($('.mousetrap').length > 0)
				{
					$('.mousetrap').on('mouseenter', this, function (event) {
						$('#cloud-zoom-big').css('background-image', 'url("' + newImageColorBoxSrc + '")');
					});
				}

				//ColorBox
				if($('.image .colorbox').length > 0)
				{
					$('.image .colorbox').attr('href', newImageColorBoxSrc);
				}

				//jQueryZoom
				if($('.zoomWrapperImage > img').length > 0)
				{
					$('.zoomWrapperImage > img').attr('src', newImageColorBoxSrc);
				}

				//Lightbox
				if($('a[rel="lightbox[thumb]"]').length > 0)
				{
					$('a[rel="lightbox[thumb]"]').attr('href', newImageColorBoxSrc);
				}

				//MagicZoom
				if($('.MagicZoomBigImageCont img').length > 0)
				{
					$('.MagicToolboxContainer img').attr('src', newImageSrc);
					$('.MagicZoomBigImageCont img').attr('src', newImageColorBoxSrc);
				}

				//zoomLens
				if($('.zoomLens img').length > 0)
				{
					$('.zoomLens > img').attr('src', newImageColorBoxSrc);
					$('#image').data('elevateZoom').swaptheimage(newImageColorBoxSrc, newImageColorBoxSrc);
				}
			}
		}
        //--></script>
<div id="content">  <div class="breadcrumb">
        <a href="http://127.0.0.1/oc/index.php?route=common/home">Home</a>
         &raquo; <a href="http://127.0.0.1/oc/index.php?route=product/category&amp;path=59">svg</a>
         &raquo; <a href="http://127.0.0.1/oc/index.php?route=product/product&amp;path=59&amp;product_id=50">test</a>
      </div>
  <h1>test</h1>
  <div class="product-info">
        <div class="left">
      <!--BOF PICW-->
						<div class="image gteie9">
				<iframe name="svgFrame" id="svgFrame" src="index.php?route=product/product_svg&product_id=50" style="padding:0; margin: 0; display: block; width: 228px; height: 228px;" frameborder="no" scrolling="no"></iframe>
			</div>
						<script type="text/javascript" src="catalog/view/javascript/picw/picw.js"></script>
			<!--[if lt IE 9]>
									<div class="image"><a href="http://127.0.0.1/oc/image/cache/data/trees-deers-600x600-500x500.png" title="test" class="colorbox" rel="colorbox"><img src="http://127.0.0.1/oc/image/cache/data/trees-deers-600x600-228x228.png" title="test" alt="test" id="image" /></a></div>
								<style>
					.gteie9
					{
						display: none;
					}
				</style>
			<![endif]-->
			<div style="clear:both;"></div>
			          </div>
        <div class="right">
      <div class="description">
                <span>Product Code:</span> 1234test<br />
                <span>Availability:</span> In Stock</div>
            <div class="price">Price:                $0.00                <br />
                <span class="price-tax">Ex Tax: $0.00</span><br />
                              </div>
                        <div class="options">
        <h2>Available Options</h2>
        <br />
        <!--BOF Product Color Option-->
						<div rel="14" id="option-228" class="option">
			  			  <span class="required">*</span>
			  			  <b>color boxes 2:</b><br />
			  				<a class="color-option "
				id="color-option-19"
				option-value="19"
				option-text-id="option-text-228"
				style="background-color: #f20e69"
				title="red "></a>
			  				<a class="color-option "
				id="color-option-20"
				option-value="20"
				option-text-id="option-text-228"
				style="background-color: #fae664"
				title="yellow "></a>
			  			  <span id="option-text-228"></span>
			  <div class="hidden">
			  <select name="option[228]">
				<option value=""> --- Please Select --- </option>
								<option src="NA" src-colorbox="NA" value="19">red								</option>
								<option src="NA" src-colorbox="NA" value="20">yellow								</option>
							  </select>
			  </div>
			</div>
			<br />
						<!--EOF Product Color Option-->
                                                                                        <!--BOF Product Color Option-->




<div rel="13" id="option-227" class="option">
		<span class="required">*</span>
		<b>color boxes 1:</b><br />

		<a class="color-option "
		id="color-option-17"
		option-value="17"
		option-text-id="option-text-227"
		style="background-color: #000000"
		title="black "></a>

	  				<a class="color-option "
		id="color-option-18"
		option-value="18"
		option-text-id="option-text-227"
		style="background-color: #cccccc"
		title="grey "></a>
	  			  <span id="option-text-227"></span>

	<div class="hidden">

	<select name="option[227]">
					<option value=""> --- Please Select --- </option>
					<option src="NA" src-colorbox="NA" value="17">black	</option>
					<option src="NA" src-colorbox="NA" value="18">grey	</option>
	</select>


	</div>
</div>
			<br />
						<!--EOF Product Color Option-->
                                                                                              </div>
            <div class="cart">
        <div>Qty:          <input type="text" name="quantity" size="2" value="1" />
          <input type="hidden" name="product_id" size="2" value="50" />
          &nbsp;
          <input type="button" value="Add to Cart" id="button-cart" class="button" />
          <span>&nbsp;&nbsp;- OR -&nbsp;&nbsp;</span>
          <span class="links"><a onclick="addToWishList('50');">Add to Wish List</a><br />
            <a onclick="addToCompare('50');">Add to Compare</a></span>
        </div>
              </div>
            <div class="review">
        <div><img src="catalog/view/theme/default/image/stars-0.png" alt="0 reviews" />&nbsp;&nbsp;<a onclick="$('a[href=\'#tab-review\']').trigger('click');">0 reviews</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a onclick="$('a[href=\'#tab-review\']').trigger('click');">Write a review</a></div>
        <div class="share"><!-- AddThis Button BEGIN -->
          <div class="addthis_default_style"><a class="addthis_button_compact">Share</a> <a class="addthis_button_email"></a><a class="addthis_button_print"></a> <a class="addthis_button_facebook"></a> <a class="addthis_button_twitter"></a></div>
          <script type="text/javascript" src="//s7.addthis.com/js/250/addthis_widget.js"></script>
          <!-- AddThis Button END -->
        </div>
      </div>
          </div>
  </div>
  <div id="tabs" class="htabs"><a href="#tab-description">Description</a>
            <a href="#tab-review">Reviews (0)</a>
          </div>
  <div id="tab-description" class="tab-content"></div>
      <div id="tab-review" class="tab-content">
    <div id="review"></div>
    <h2 id="review-title">Write a review</h2>
    <b>Your Name:</b><br />
    <input type="text" name="name" value="" />
    <br />
    <br />
    <b>Your Review:</b>
    <textarea name="text" cols="40" rows="8" style="width: 98%;"></textarea>
    <span style="font-size: 11px;"><span style="color: #FF0000;">Note:</span> HTML is not translated!</span><br />
    <br />
    <b>Rating:</b> <span>Bad</span>&nbsp;
    <input type="radio" name="rating" value="1" />
    &nbsp;
    <input type="radio" name="rating" value="2" />
    &nbsp;
    <input type="radio" name="rating" value="3" />
    &nbsp;
    <input type="radio" name="rating" value="4" />
    &nbsp;
    <input type="radio" name="rating" value="5" />
    &nbsp;<span>Good</span><br />
    <br />
    <b>Enter the code in the box below:</b><br />
    <input type="text" name="captcha" value="" />
    <br />
    <img src="index.php?route=product/product/captcha" alt="" id="captcha" /><br />
    <br />
    <div class="buttons">
      <div class="right"><a id="button-review" class="button">Continue</a></div>
    </div>
  </div>
        </div>
<script type="text/javascript"><!--
$(document).ready(function() {
	$('.colorbox').colorbox({
		overlayClose: true,
		opacity: 0.5,
		rel: "colorbox"
	});
});
//--></script>
<script type="text/javascript"><!--

$('select[name="profile_id"], input[name="quantity"]').change(function(){
    $.ajax({
		url: 'index.php?route=product/product/getRecurringDescription',
		type: 'post',
		data: $('input[name="product_id"], input[name="quantity"], select[name="profile_id"]'),
		dataType: 'json',
        beforeSend: function() {
            $('#profile-description').html('');
        },
		success: function(json) {
			$('.success, .warning, .attention, information, .error').remove();

			if (json['success']) {
                $('#profile-description').html(json['success']);
			}
		}
	});
});

$('#button-cart').bind('click', function() {

        var mainImg = $('#image, #zoom1 img, #ma-zoom1 img, #main-image, div.image a.colorbox-product img, div.image #wrap a img, .zoomPad > img, .product-info .image > img').attr('src');
        var data = $('.product-info input[type=\'text\'], .product-info input[type=\'hidden\'], .product-info input[type=\'radio\']:checked, .product-info input[type=\'checkbox\']:checked, .product-info select, .product-info textarea');
        data = data.serialize();
	$.ajax({
		url: 'index.php?route=checkout/cart/add',
		type: 'post',
		data: data + '&image=' + mainImg,
		dataType: 'json',
		success: function(json) {
			$('.success, .warning, .attention, information, .error').remove();

			if (json['error']) {
				if (json['error']['option']) {
					for (i in json['error']['option']) {
						$('#option-' + i).after('<span class="error">' + json['error']['option'][i] + '</span>');
					}
				}

                if (json['error']['profile']) {
                    $('select[name="profile_id"]').after('<span class="error">' + json['error']['profile'] + '</span>');
                }
			}

			if (json['success']) {
				$('#notification').html('<div class="success" style="display: none;">' + json['success'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');

				$('.success').fadeIn('slow');

				$('#cart-total').html(json['total']);

				$('html, body').animate({ scrollTop: 0 }, 'slow');
			}
		}
	});
});
//--></script>
<script type="text/javascript" src="catalog/view/javascript/jquery/ajaxupload.js"></script>
<script type="text/javascript"><!--
$('#review .pagination a').live('click', function() {
	$('#review').fadeOut('slow');

	$('#review').load(this.href);

	$('#review').fadeIn('slow');

	return false;
});

$('#review').load('index.php?route=product/product/review&product_id=50');

$('#button-review').bind('click', function() {
	$.ajax({
		url: 'index.php?route=product/product/write&product_id=50',
		type: 'post',
		dataType: 'json',
		data: 'name=' + encodeURIComponent($('input[name=\'name\']').val()) + '&text=' + encodeURIComponent($('textarea[name=\'text\']').val()) + '&rating=' + encodeURIComponent($('input[name=\'rating\']:checked').val() ? $('input[name=\'rating\']:checked').val() : '') + '&captcha=' + encodeURIComponent($('input[name=\'captcha\']').val()),
		beforeSend: function() {
			$('.success, .warning').remove();
			$('#button-review').attr('disabled', true);
			$('#review-title').after('<div class="attention"><img src="catalog/view/theme/default/image/loading.gif" alt="" /> Please Wait!</div>');
		},
		complete: function() {
			$('#button-review').attr('disabled', false);
			$('.attention').remove();
		},
		success: function(data) {
			if (data['error']) {
				$('#review-title').after('<div class="warning">' + data['error'] + '</div>');
			}

			if (data['success']) {
				$('#review-title').after('<div class="success">' + data['success'] + '</div>');

				$('input[name=\'name\']').val('');
				$('textarea[name=\'text\']').val('');
				$('input[name=\'rating\']:checked').attr('checked', '');
				$('input[name=\'captcha\']').val('');
			}
		}
	});
});
//--></script>
<script type="text/javascript"><!--
$('#tabs a').tabs();
//--></script>
<script type="text/javascript" src="catalog/view/javascript/jquery/ui/jquery-ui-timepicker-addon.js"></script>
<script type="text/javascript"><!--
$(document).ready(function() {
	if ($.browser.msie && $.browser.version == 6) {
		$('.date, .datetime, .time').bgIframe();
	}

	$('.date').datepicker({dateFormat: 'yy-mm-dd'});
	$('.datetime').datetimepicker({
		dateFormat: 'yy-mm-dd',
		timeFormat: 'h:m'
	});
	$('.time').timepicker({timeFormat: 'h:m'});
});
//--></script>

		<script type="text/javascript"><!--
			$(document).on("click", ".thumb", function() {
				//for non-select options

				var newImg = $(this).attr('src');
				var newImgColorBox = $(this).attr('src-colorbox');

				if(newImg != 'NA')
				{
					poiChangeImage(newImg, newImgColorBox);
				}
			return true;
			});
			$(document).ready(function()
			{
				$("*[src-colorbox]").each(function(){
					$this = $(this);

					$src = $this.attr('src');
					if($src != 'NA')
					{
						$('<img/>')[0].src = $src; //preload image
					}

					$srcColorbox = $this.attr('src-colorbox');

					if($srcColorbox != 'NA')
					{
						$('<img/>')[0].src = $srcColorbox; //preload image
					}
				});
			});
		//--></script>

			<!--BOF Product Color Option-->
			<style>
			.product-color-options span
			{
				display:inline-block;
				width:12px;
				height:12px;
				margin-right:0px;
				border:2px solid #E7E7E7;
			}

			.image .product-color-options
			{
				display: none;
			}

			a.color-option {
				display:inline-block;
				width:15px;
				height:15px;
				margin: 3px;
				padding: 0;
				border:2px solid #E7E7E7;
				vertical-align: middle;
				cursor: pointer;
				box-sizing: content-box;
			}

			a.color-option.color-active, a.color-option:hover {
				margin: 0;
				padding: 3px;
			}

			.hidden {
				display: none !important;
			}

			/*Oval style*/
			a.color-option.pco-style-oval,
			.product-color-options span.pco-style-oval
			{
				border-radius: 9999px;
			}

			/*Double rectangle style*/
			a.color-option.pco-style-double-rectangle,
			.product-color-options span.pco-style-double-rectangle
			{
				border: 4px double #E7E7E7;
			}

			/*Double oval style*/
			a.color-option.pco-style-double-oval,
			.product-color-options span.pco-style-double-oval
			{
				border-radius: 9999px;
				border: 4px double #E7E7E7;
			}
			</style>
			<script type="text/javascript"><!--
			$("a.color-option").click(function(event)
			{
				$this = $(this);

				// highlight current color box
				$this.parent().find('a.color-option').removeClass('color-active');
				$this.addClass('color-active');

				$('#' + $this.attr('option-text-id')).html($this.attr('title'));

				// trigger selection event on hidden select
				$select = $this.parent().find('select');

				$select.val($this.attr('option-value'));
				$select.trigger('change');

				//option redux
				if(typeof updatePx == 'function') {
					updatePx();
				}

				//option boost
				if(typeof obUpdate == 'function') {
					obUpdate($($this.parent().find('select option:selected')), useSwatch);
				}
				event.preventDefault();
			});

			$("a.color-option").parent('.option').find('.hidden select').change(function()
			{
				$this = $(this);
				var optionValueId = $this.val();
				$colorOption = $('a#color-option-' + optionValueId);
				if(!$colorOption.hasClass('color-active'))
					$colorOption.trigger('click');
			});
			//--></script>
			<!--EOF Product Color Option--><div id="footer">
    <div class="column">
    <h3>Information</h3>
    <ul>
            <li><a href="http://127.0.0.1/oc/index.php?route=information/information&amp;information_id=4">About Us</a></li>
            <li><a href="http://127.0.0.1/oc/index.php?route=information/information&amp;information_id=6">Delivery Information</a></li>
            <li><a href="http://127.0.0.1/oc/index.php?route=information/information&amp;information_id=3">Privacy Policy</a></li>
            <li><a href="http://127.0.0.1/oc/index.php?route=information/information&amp;information_id=5">Terms &amp; Conditions</a></li>
          </ul>
  </div>
    <div class="column">
    <h3>Customer Service</h3>
    <ul>
      <li><a href="http://127.0.0.1/oc/index.php?route=information/contact">Contact Us</a></li>
      <li><a href="http://127.0.0.1/oc/index.php?route=account/return/insert">Returns</a></li>
      <li><a href="http://127.0.0.1/oc/index.php?route=information/sitemap">Site Map</a></li>
    </ul>
  </div>
  <div class="column">
    <h3>Extras</h3>
    <ul>
      <li><a href="http://127.0.0.1/oc/index.php?route=product/manufacturer">Brands</a></li>
      <li><a href="http://127.0.0.1/oc/index.php?route=account/voucher">Gift Vouchers</a></li>
      <li><a href="http://127.0.0.1/oc/index.php?route=affiliate/account">Affiliates</a></li>
      <li><a href="http://127.0.0.1/oc/index.php?route=product/special">Specials</a></li>
    </ul>
  </div>
  <div class="column">
    <h3>My Account</h3>
    <ul>
      <li><a href="http://127.0.0.1/oc/index.php?route=account/account">My Account</a></li>
      <li><a href="http://127.0.0.1/oc/index.php?route=account/order">Order History</a></li>
      <li><a href="http://127.0.0.1/oc/index.php?route=account/wishlist">Wish List</a></li>
      <li><a href="http://127.0.0.1/oc/index.php?route=account/newsletter">Newsletter</a></li>
    </ul>
  </div>
</div>
<!--
OpenCart is open source software and you are free to remove the powered by OpenCart if you want, but its generally accepted practise to make a small donation.
Please donate via PayPal to donate@opencart.com
//-->
<div id="powered">Powered By <a href="http://www.opencart.com">OpenCart</a><br /> Your Store &copy; 2015</div>
<!--
OpenCart is open source software and you are free to remove the powered by OpenCart if you want, but its generally accepted practise to make a small donation.
Please donate via PayPal to donate@opencart.com
//-->
</div>
</body></html>