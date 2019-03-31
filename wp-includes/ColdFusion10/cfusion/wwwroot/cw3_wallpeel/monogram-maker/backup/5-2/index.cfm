<!---List all files in a directory--->
<cfdirectory action="list" directory="#expandPath("./images/bgPatterns/")#" recurse="false"
name="bgPatterns">

<cfdump var="#bgPatterns#">


<cfoutput query="bgPatterns">
	#listfirst(name,".")#<br>
	#name#

	<br/></cfoutput>

<cfparam name="cfm_numLetters" default="3">

<cfparam name="cfm_selectedFont" default="CircleSimple">
<cfparam name="cfm_textPatternUrl" default="images/bgPatterns/Aloha-Cream.jpg">

<cfparam name="cfm_selectedFrame" default="FrameCircleOneRing">
<cfparam name="cfm_framePatternUrl" default="images/bgPatterns/Aloha-Cream.jpg">

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
        <meta name="description" content="">
        <meta name="author" content="">

        <link rel="icon" href="../../favicon.ico">

        <title> </title>

        <script src="js/jquery-2.1.0.js"></script>
        <script src="js/jquery.fontselect.js"></script>
        <script src="js/jquery-ui.js"></script>

        <script src="js/fabric.min.js"></script>

        <!-- Bootstrap -->
        <!-- Latest compiled and minified CSS -->
        <link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap-theme.min.css">

        <script src="bootstrap/js/bootstrap.min.js"></script>
        <!--additionalcss files -->
        <link rel="stylesheet" type="text/css" href="bootstrap/font_awesome/css/font-awesome.min.css">

        <!-- additional additional JS files for this page -->
        <link rel="stylesheet" type="text/css" href="css/style.css">
        <link href="css/Monograms.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" type="text/css" href="css/jquery-ui.css">


        <script  language="javascript">

          numLetters = <cfoutput>#cfm_numLetters#</cfoutput>;
          selectedFont = "<cfoutput>#cfm_selectedFont#</cfoutput>";
          textPatternUrl = "<cfoutput>#cfm_textPatternUrl#</cfoutput>";

          selectedFrame = "<cfoutput>#cfm_selectedFrame#</cfoutput>";
          framePatternUrl = "<cfoutput>#cfm_framePatternUrl#</cfoutput>";

        </script>

        <META HTTP-EQUIV="Pragma" CONTENT="no-cache">

	<META HTTP-EQUIV="Expires" CONTENT="-1">

    </head>
    <body>

        <cfinclude template="monogram.html" >

        <script src="http://rawgit.com/bramstein/fontfaceobserver/master/fontfaceobserver.js" ></script>

		<script src="js/Monograms_cfm.js"></script>

    </body>
</html>

