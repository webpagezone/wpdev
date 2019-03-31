<!--- 
============================================================================
This is the presentation file for the Search Results Page.
============================================================================
--->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Cartweaver 3 Results Page</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="cw3/assets/css/cartweaver.css" rel="stylesheet" type="text/css">
</head>

<body>
<p><cfmodule
id="CWTagSearch"
searchtype="Links"
template="cw3/CWTags/CWTagSearch.cfm"
separator="|"
selectedstart="&lt;strong&gt;"

selectedend="&lt;/strong&gt;"
></p>
<p><cfmodule id="CW3CartLinks" template="cw3/CWTags/CWTagCartLinks.cfm"></p>




<cfinclude template="cw3/CWIncResults.cfm">
</body>
</html>
