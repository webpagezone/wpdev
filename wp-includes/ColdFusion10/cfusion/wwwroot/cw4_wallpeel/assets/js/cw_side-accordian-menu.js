/*
/* CSS Document 
==========================================================
Application: Cartweaver 4 ColdFusion
Copyright (C)2002 - 2012, All Rights Reserved
Developer: Application Dynamics, Inc. | Cartweaver.com
Licensing: http://www.cartweaver.com/eula
Support: http://www.cartweaver.com/support
==========================================================
File: cw_side-accordian-menu.js
File Date: 03-01-2012
Description: jQuery for Cartweaver 4 accordian side product menu
==========================================================
*/ 


jQuery(document).ready(function(){
// show/hide function for horizontal menu
	jQuery('#nav1 > li').hover(
		function() { jQuery('ul', this).css('display','none').slideDown(5).css('display', 'block'); },
		function() { jQuery('ul', this).slideUp(5).css('display','none'); }
	);
 // show/hide function for nested vertical menu
 jQuery('.cwVerticalSlide ul#nav2 li ul').hide().parent('li').children('a').prepend('» ').click(function(){
	jQuery(this).parent('li').children('ul').show(500);
	jQuery(this).parent('li').siblings('li').children('ul').hide(500);
	return false;
 });
	// trigger click to open menu to current page
	jQuery('.cwVerticalSlide ul#nav2 > li > ul > li > a').parents('.cwVerticalSlide ul.CWnav > li ').children('a.currentLink').trigger('click').removeClass('currentLink');
	// create nav anchors for this page to match h3 section headings
	jQuery('.cwVerticalSlide h3').each(function(){
		var linkBox = jQuery('#searchNav');
		var linkText = jQuery(this).text();
		var linkCount = jQuery(this).parents('.cwVerticalSlide').prevAll('.cwVerticalSlide').length;
		jQuery(linkBox).append('<a href="#link' + linkCount + '" class="CWlink">' + linkText + '</a><br><br>');
		jQuery(this).parents('.cwVerticalSlide').before('<a name="link' + linkCount + '"></a>');
	});
});
