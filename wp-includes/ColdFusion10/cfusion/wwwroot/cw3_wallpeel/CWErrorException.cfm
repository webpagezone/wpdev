<cfsilent>
<!---
================================================================
Application Info: Cartweaver© 2002 - 2007, All Rights Reserved.
Developer Info: Application Dynamics Inc.
                1560 NE 10th
                East Wenatchee, WA 98802
Support Info: http://www.cartweaver.com/go/cfhelp

Cartweaver Version: 3.0.0  -  Date: 4/21/2007
=============================================================
Name: Custom Error Page.
Description: CF will display an error on this page instead of the 
default CF Error file. 
Design this to look like the rest of your site.
The only restriction is that you must use standard HTML 
code only.
==========================================================
--->
</cfsilent>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Cartweaver Error Notice</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="css/cartweaver.css" rel="stylesheet" type="text/css">
</head>
<body>
<h1>Cartweaver&copy; - ERROR NOTICE! </h1>
<p><strong>An Exception Error has occurred !</strong> </p>
<hr>
<p>An email has been sent to the <a href="mailto:<cfoutput>#error.MailTo#</cfoutput>">Site Administrator</a>.</p>
<cfmail to="#error.MailTo#" 
from="#error.MailTo#" 
subject="#application.companyname# - Exception Error Occured on #error.Template#" 
server="#application.mailserver#"
type="html">
<p>Your online store for #application.companyname# has generated an Exception error.</p>
<p>The error occurred on http://#CGI.SERVER_NAME##error.Template#<br/>
User's Browser: #error.Browser#<br/>
Error Date/Time: #error.DateTime#<br/>
Previous Page: #error.HTTPReferer#<br/>
URL Parameters: #error.QueryString#<br/>
Message: #error.Message#<br/>
Root Cause: #error.RootCause#<br/>
Tag Context: <cfdump var="#error.TagContext#"><br/>
--------------------------------------</p>
<div>#error.Diagnostics#</div>

</cfmail>
<p><a href="index.cfm">HOME</a></p>
</body>
</html>