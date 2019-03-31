<!--- 
================================================================
Application Info: Cartweaver© 2002 - 2007, All Rights Reserved.
Developer Info: Application Dynamics Inc.
                1560 NE 10th
                East Wenatchee, WA 98802
Support Info: http://www.cartweaver.com/go/cfhelp
				
Cartweaver Version: 3.0.0  -  Date: 4/21/2007
================================================================
Name: Logout.cfm
Description: clears all sessions and returns use to the log on screen
================================================================
--->

<cfscript>structClear(Session);</cfscript>
<cflocation url="index.cfm" addtoken="no">