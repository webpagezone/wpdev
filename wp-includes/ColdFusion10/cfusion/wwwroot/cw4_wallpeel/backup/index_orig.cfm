<cfsilent>
<!---
==========================================================
Application: Cartweaver 4 ColdFusion
Copyright 2002 - 2013, All Rights Reserved
Developer: Application Dynamics, Inc. | Cartweaver.com
Licensing: http://www.cartweaver.com/eula
Support: http://www.cartweaver.com/support
==========================================================
File: index.cfm
File Date: 2012-08-18
Description: shows samples of product search / store navigation
default cartweaver installation temporary home page
==========================================================
--->
<!--- default cat/subcat for demo purpose --->
<cfif not isDefined('url.category') or not isNumeric('url.category')>
	<cfset url.category = 0>
</cfif>
<cfif not isDefined('url.secondary') or not isNumeric('url.secondary')>
	<cfset url.secondary = 0>
</cfif>
<!--- clean up form and url variables --->
<cfinclude template="cw4/cwapp/inc/cw-inc-sanitize.cfm">
<!--- CARTWEAVER REQUIRED FUNCTIONS --->
<cfinclude template="cw4/cwapp/inc/cw-inc-functions.cfm">
<cfset request.cwpage.categoryID = url.category>
<cfset request.cwpage.secondaryID = url.secondary>
</cfsilent>
<!DOCTYPE html>
<html>
	<head>
		<title>Cartweaver Sample Search | <cfoutput>#request.cwpage.title#</cfoutput></title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<meta name="Description" content="">
		<!--- CARTWEAVER CSS --->
		<link href="cw4/css/cw-core.css" rel="stylesheet" type="text/css">
		<!--- sample menu css--->
		<style type="text/css">
		html{
			min-height:100.01%;
			overflow-y:scroll;
			}
		#CWfoot{
			min-height:130px;
			margin-top:29px;
		}
		/* ------- search forms -------*/
		div.searchSample{
			border-bottom:1px solid #D7D6DB;
			margin:12px 12px 6px 0;
			padding:9px 0 36px;
			clear:both;
		}
		div.searchSample form{
			margin:10px 0;
		}
		div.searchSample form input,
		div.searchSample form select{
			margin-right:8px;
		}
		div.searchSample textarea.codeSample{
			display:block;
			width:482px;
			height:255px;
			margin:12px 12px 6px 0;
			padding:9px;
			clear:both;
		}
		div.searchSample form#search1 select,
		div.searchSample form#search2 select{
			width:175px;
		}
		#searchNav select{
			font-size:13px;
			}
		p,div{
			font-size:12px;
			}
		p + h2{
			margin-top:29px !important;
			}
		h2 + div, h2 + p + div{
			padding:12px 0 18px;
			}
		a.showSample{
			float:left;
			clear:both;
			width:150px;
			display:block;
			margin-bottom:8px;
		}
		a.showSample + *{
			clear:both;
		}
		/* ------- a few custom heights -------*/
		#navG{
		min-height:120px;
		}
		#navH{
		min-height:210px;
		}
		.CWbreadcrumb{
		min-height:45px;
		}
		.CWlinksNav{
			min-height:60px;
		}
		/* ------- horizontal top nav menu -------*/
		#nav1{
		min-height:140px;
		}
		.searchSample ul#nav1 li a.currentLink {
		font-weight:900;
		background-color: #EEF3FA !important;
		color:#DF772E !important;
		}
		.searchSample ul#nav1,
		.searchSample ul#nav1 ul {
		list-style: none;
		font-size:11px;
		}
		.searchSample ul#nav1,
		.searchSample ul#nav1 * {
		padding: 0;
		margin: 0;
		}
		.searchSample ul#nav1 li a span{
		font-size:9px;
		}
		.searchSample ul#nav1 li a:link,
		.searchSample ul#nav1 li a:visited,
		.searchSample ul#nav1 li a:active{
		background-color: #61B9E7;
		color:#FFF;
		}
		.searchSample ul#nav1 li a:hover {
		background-color: #FFF;
		color:#DF772E;
		}
		/* top level links */
		.searchSample ul#nav1 > li {
		width: 150px;
		float: left;
		margin-left: -1px;
		border: 1px black solid;
		background-color: #EEF3FA;
		text-align: center;
		}
		.searchSample ul#nav1 > li a {
		display: block;
		padding: 3px 4px;
		text-decoration:none;
		}
		/* second level dropdowns  */
		.searchSample ul#nav1 > li ul {
		display: none;
		border-top: 1px black solid;
		text-align: left;
		font-size:10px;
		}
		.searchSample ul#nav1 > li:hover ul {
		display: block;
		}
		.searchSample ul#nav1 > li ul li a {
		padding: 3px 1px 3px 15px;
		height: 17px;
		text-decoration:none;
		}
		/* ------- vertical side nav menu -------*/
		.searchSample ul#nav2{
		min-height:210px;
		}
		.searchSample ul#nav2 li,
		.searchSample ul#nav2 ul,
		.searchSample ul#nav2 ul li {
			font-size:13px;
			list-style:none;
		}
		.searchSample ul#nav2 li{
			list-style:none;
		}
		.searchSample ul#nav2 li a{
			width:160px;
			display:block;
			text-decoration:none;
			padding-left:3px;
			/* background color helps with IE anti-aliasing */
			background-color:#FFF;
		}
		.searchSample ul#nav2 li a:hover{

		}
		.searchSample ul#nav2 li ul li a{
			padding-left:13px;
		}
		.searchSample ul#nav2 li a.currentLink{
			font-weight:900;
		}

		</style>
		<!--- list menu javacript --->
		<script type="text/javascript" src="cw4/js/jquery-1.7.1.min.js"></script>
		<script type="text/javascript">
			jQuery(document).ready(function(){
			// show/hide function for horizontal menu
				jQuery('#nav1 > li').hover(
					function() { jQuery('ul', this).css('display','none').slideDown(5).css('display', 'block'); },
					function() { jQuery('ul', this).slideUp(5).css('display','none'); }
				);
			 // show/hide function for nested vertical menu
			 jQuery('.searchSample ul#nav2 li ul').hide().parent('li').children('a').prepend('&raquo;&nbsp;').click(function(){
			 	jQuery(this).parent('li').children('ul').show(500);
			 	jQuery(this).parent('li').siblings('li').children('ul').hide(500);
			 	return false;
			 });
				// trigger click to open menu to current page
				jQuery('.searchSample ul#nav2 > li > ul > li > a').parents('.searchSample ul.CWnav > li ').children('a.currentLink').trigger('click').removeClass('currentLink');
				var linkBox = jQuery('#searchNav');
				var searchSelect = '<select id="cwSearchNavSelect" name="cwSearchNavSelect"></select>';
				jQuery(linkBox).append(searchSelect);
				// create dropdown selector for this page to match h3 section headings
				jQuery('.searchSample h3').each(function(){
					var linkText = jQuery(this).text();
					var linkCount = jQuery(this).parents('.searchSample').prevAll('.searchSample').length;
					jQuery('#cwSearchNavSelect').append('<option value="link' + linkCount + '" class="CWselect">' + linkText + '</option>');
					jQuery(this).parents('.searchSample').addClass('link' + linkCount).hide();
				});
				// show selected nav example
				var $showNav = function(navClass){
					jQuery('div.searchSample').hide();
					jQuery('div.' + navClass).show();
				};
				// show selected content on page load
				jQuery('#cwSearchNavSelect').change(function(){
					$showNav(jQuery(this).find('option:selected').attr('value'));
				});
				// also run on page load
				$showNav(jQuery('#cwSearchNavSelect').find('option:selected').attr('value'));
				// show/hide links for code samples
				jQuery('.searchSample .codeSample').each(function(){
					jQuery(this).before('<a href="#" class="showSample">Show Code</a>');
					jQuery(this).hide();
					});
				jQuery('a.showSample').click(function(){
					jQuery(this).next('textarea').toggle();
					return false;
					});
			});
		</script>
	</head>
	<body class="cw">
		<!--- cart links, log in links, alerts --->
		<cfinclude template="cw4/cwapp/inc/cw-inc-pagestart.cfm">
		<div class="CWcontent">
			<h1><strong>Sample Home Page</strong></h1>
			<p><strong>Replace this with your site's home page.</strong></p>
			<h2>Cartweaver Search and Navigation Options</h2>
			<p>Sample navigation and search elements are provided here. Copy the code and modify settings to fit your site design.</p>
			<!--- jQuery puts nav selector here: --->
			<div><strong>Select Navigation Type: </strong><span id="searchNav"></span></div>
			<!--- form - all options, related categories --->
			<div class="searchSample">
				<h3>Standard Search Form (all options)</h3>
				<p>Keywords, Categories and Secondary Categories are all enabled.
				<br>Relation of categories and secondaries is enabled. (Select a main category to narrow down available secondary categories).
				<br>Empty categories (no products available) are not included, and the number of products available in each category is shown.
				<br>Default options (All Categories, All Subcategories) are provided.<br>
				</p>
				<cfmodule template="cw4/cwapp/mod/cw-mod-searchnav.cfm"
				search_type="form"
				show_empty="false"
				form_keywords="true"
				form_keywords_text="Search Our Store"
				form_category="true"
				form_category_label="All Categories"
				form_secondary="true"
				form_secondary_label="All Subcategories"
				show_product_count="true"
				relate_cats="true"
				form_id="search1"
				>
<textarea class="codeSample"><cfoutput>#trim(htmlEditFormat('
<cfmodule template="cw4/cwapp/mod/cw-mod-searchnav.cfm"
search_type="form"
show_empty="false"
form_keywords="true"
form_keywords_text="Search Our Store"
form_category="true"
form_category_label="All Categories"
form_secondary="true"
form_secondary_label="All Subcategories"
show_product_count="true"
relate_cats="true"
form_id="search1"
>
'))#</cfoutput></textarea>
			</div>
			<!--- category form --->
			<div class="searchSample">
				<h3>Category Search Form</h3>
				<p>Categories and Secondary Categories are enabled, Keywords field is disabled.
				<br>Relation of categories and secondaries is disabled, and default options (e.g. All Categories) are not provided.
				<br>Empty categories with no products available are included, and the number of products available in each category is not shown.<br>
				</p>
				<cfmodule template="cw4/cwapp/mod/cw-mod-searchnav.cfm"
				search_type="form"
				show_empty="true"
				form_keywords="false"
				form_category="true"
				form_category_label=""
				form_secondary="true"
				form_secondary_label=""
				show_product_count="false"
				relate_cats="true"
				form_id="search2"
				>
<textarea class="codeSample"><cfoutput>#trim(htmlEditFormat('
<cfmodule template="cw4/cwapp/mod/cw-mod-searchnav.cfm"
search_type="form"
show_empty="true"
form_keywords="false"
form_category="true"
form_category_label=""
form_secondary="true"
form_secondary_label=""
show_product_count="false"
relate_cats="true"
form_id="search2"
>
'))#</cfoutput></textarea>
			</div>
			<!--- form - keywords only --->
			<div class="searchSample">
				<h3>Keyword Search Form</h3>
				<p>Categories and subcategories are disabled. A custom phrase is defined for the initial text in the search box.<br>
				</p>
				<cfmodule template="cw4/cwapp/mod/cw-mod-searchnav.cfm"
				search_type="form"
				show_empty="true"
				form_keywords="true"
				form_keywords_text="Find Instantly"
				form_category="false"
				form_secondary="false"
				form_id="search3"
				>
<textarea class="codeSample"><cfoutput>#trim(htmlEditFormat('
<cfmodule template="cw4/cwapp/mod/cw-mod-searchnav.cfm"
search_type="form"
show_empty="true"
form_keywords="true"
form_keywords_text="Find Instantly"
form_category="false"
form_secondary="false"
form_id="search3"
>
'))#</cfoutput></textarea>
			</div>
			<!--- links - all defaults --->
			<div class="searchSample">
				<h3>Category Links with All Defaults</h3>
				<p>Search links are created automatically for all top-level and secondary categories.
				<br>Secondary categories are related, and categories with no products are not shown.<br>
				<em>For demo purposes, a category has been preselected to activate the second row.</em>
				</p>
				<cfif not request.cwpage.categoryID gt 0>
					<cfset request.cwpage.categoryID = 55>
				</cfif>
				<cfmodule template="cw4/cwapp/mod/cw-mod-searchnav.cfm"
				search_type="links"
				all_secondaries_label=""
				>
				<cfset request.cwpage.categoryID = url.category>
<textarea class="codeSample"><cfoutput>#trim(htmlEditFormat('
<cfmodule template="cw4/cwapp/mod/cw-mod-searchnav.cfm"
search_type="links"
all_secondaries_label=""
>
'))#</cfoutput></textarea>
			</div>
			<!--- links - top level only --->
			<div class="searchSample">
				<h3>Top Level Categories with Custom Links &amp; Delimiter</h3>
				<p>Search links are created automatically for all top-level categories.
				<br>Secondary links are disabled, and categories with no products are not shown.
				<br>The default link ('All Products') is provided, custom links (Home, Contact Us) are inserted, and a custom delimiter (&bull;) is used.<br>
				</p>
				<cfmodule template="cw4/cwapp/mod/cw-mod-searchnav.cfm"
				search_type="links"
				show_empty="false"
				show_product_count="false"
				show_secondary="false"
				separator=" &bull; "
				prepend_links="1|index.cfm|Home,1|contact.cfm|Contact Us"
				>
<textarea class="codeSample"><cfoutput>#trim(htmlEditFormat('
<cfmodule template="cw4/cwapp/mod/cw-mod-searchnav.cfm"
search_type="links"
show_empty="false"
show_product_count="false"
show_secondary="false"
separator=" &bull; "
prepend_links="1|index.cfm|Home,1|contact.cfm|Contact Us"
>
'))#</cfoutput></textarea>
			</div>
			<!--- breadcrumb navigation --->
			<div class="searchSample" id="navG">
				<h3>Breadcrumb Navigation</h3>
				<p>Simple breadcrumb serial links with minimal options set.</p>
				<cfmodule template="cw4/cwapp/mod/cw-mod-searchnav.cfm"
				search_type="breadcrumb"
				separator=" &raquo; "
				>
<textarea class="codeSample"><cfoutput>#trim(htmlEditFormat('
<cfmodule template="cw4/cwapp/mod/cw-mod-searchnav.cfm"
search_type="breadcrumb"
separator=" &raquo; "
>
'))#</cfoutput></textarea>
			</div>
			<!--- list - horizontal navigation menu --->
			<div class="searchSample" id="navH">
				<h3>Horizontal Dropdown Navigation Menu</h3>
				<p>Nested links are created automatically for all top-level and secondary categories.
				<br>This method generates pure HTML, which can be used in a number of ways.
				<br>CSS controls the layout, with custom jQuery javascript for the show/hide action.
				<br>The menu ID is user defined for easy selection.
				</p>
				<cfmodule template="cw4/cwapp/mod/cw-mod-searchnav.cfm"
				search_type="list"
				show_empty="false"
				all_categories_label=""
				all_secondaries_label=""
				show_product_count="true"
				menu_id="nav1"
				>
<textarea class="codeSample"><cfoutput>#trim(htmlEditFormat('
<cfmodule template="cw4/cwapp/mod/cw-mod-searchnav.cfm"
search_type="list"
show_empty="false"
all_categories_label=""
all_secondaries_label=""
show_product_count="true"
menu_id="nav1"
>
'))#</cfoutput></textarea>
			</div>
			<!--- list - vertical navigation menu --->
			<div class="searchSample">
				<h3>Vertical Nested Show/Hide Navigation Menu</h3>
				<p>Nested links are created automatically for all top-level and secondary categories.
				<br>This method generates pure HTML, which can be used in a number of ways.
				<br>CSS controls the layout, with custom jQuery javascript for the show/hide action.
				<br>The menu ID is user defined for easy selection.
				</p>
				<p><br><em><strong>Note: this sample and the horizontal menu both use the same Cartweaver menu options.</strong>
				<br>The only difference is the application of CSS and javascript (jQuery).</em><br><br></p>
				<cfmodule template="cw4/cwapp/mod/cw-mod-searchnav.cfm"
				search_type="list"
				show_empty="false"
				show_product_count="true"
				menu_id="nav2"
				>
<textarea class="codeSample"><cfoutput>#trim(htmlEditFormat('
<cfmodule template="cw4/cwapp/mod/cw-mod-searchnav.cfm"
search_type="list"
show_empty="false"
show_product_count="true"
menu_id="nav2"
>
'))#</cfoutput></textarea>
			</div>

			<p>Cartweaver uses a single custom tag for all search forms and navigation links, with options
			for the various types of display. <br>These examples are all output by the same single &lt;cfmodule&gt;, with different options selected.
			<br><em>See the source code of cw-mod-searchnav.cfm and this index page for the available options, and some corresponding css and jQuery javascript examples.</em></p>

			<!--- Cartweaver content --->
			<div id="CWfoot">
				<p><strong>Cartweaver ColdFusion eCommerce</strong></p>
				<p>Support: <a href="http://www.cartweaver.com/support">http://www.cartweaver.com/support</a></p>
				<p>FAQ: <a href="http://www.cartweaver.com/faq">http://www.cartweaver.com/faq</a></p>
				<p>Blog: <a href="http://www.cartweaver.com/blog">http://www.cartweaver.com/blog</a></p>
				<p>Community Forum: <a href="http://www.cartweaver.com/forum">http://www.cartweaver.com/forum</a></p>
			</div>
		</div>
		<!--- /end CWcontent --->
	</body>
</html>