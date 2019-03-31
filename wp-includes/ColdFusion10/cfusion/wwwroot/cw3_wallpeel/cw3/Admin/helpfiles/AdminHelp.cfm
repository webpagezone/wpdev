<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Cartweaver Admin Help</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../assets/help.css" rel="stylesheet" type="text/css">
</head>
<body>
<!--- Header Include --->
<cfinclude template="inc_HelpHeader.cfm">
<cfparam name="URL.HelpFileName" default="AdminHome.cfm">
<!--- Help Navigation --->
<cfinclude template="inc_HelpNav.cfm">
<div id="content"> 
<!--- Help File Body Include, populated by url.HelpFileName variable --->
<cfinclude template="help_#URL.HelpFileName#">
</div> 
<!--- Footer Include --->
<cfinclude template="inc_HelpFooter.cfm">
</body>
</html>