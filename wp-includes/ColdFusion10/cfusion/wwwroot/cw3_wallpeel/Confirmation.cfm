<!--- 
============================================================================
This is the presentation file for the Order Confirmation Page.
============================================================================
--->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Cartweaver 3 Order Confirmation Page</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="cw3/assets/css/cartweaver.css" rel="stylesheet" type="text/css">
</head>

<body>
<cfmodule
id="CWTagSearch"
searchtype="Links"
template="cw3/CWTags/CWTagSearch.cfm"
separator="|"
selectedstart="&lt;strong&gt;"
selectedend="&lt;/strong&gt;"
>
<br />
<cfmodule id="CW3CartLinks" template="cw3/CWTags/CWTagCartLinks.cfm">
<cfinclude template="cw3/CWIncConfirmation.cfm">
</body>
</html>
