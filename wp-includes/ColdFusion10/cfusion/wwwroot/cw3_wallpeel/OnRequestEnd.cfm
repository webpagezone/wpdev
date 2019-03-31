<cfif IsDefined("session.debug") and session.debug EQ "true">
<div></div>
<cfhtmlhead text="
<style type='text/css'>
##forceBottom  *{font-size:14px;text-align:left; color:##000}
</style>
">
<div id="forceBottom" style="position:absolute; top:0; left:0;width:800px">
<cfif ListLen(Request.ThisPageQS, "?") EQ 1>
	<cfset redirectDebug = Request.ThisPageQS & "?debug=#application.StorePassword#">
<cfelse>
	<cfset redirectDebug = Request.ThisPageQS & "&debug=#application.StorePassword#">
</cfif>

<div id="debugOff"><a href="<cfoutput>#redirectDebug#</cfoutput>">Turn Off Debugging</a></div>
<div id="jsstuff"></div>
<cfif isdefined("Application.ShowLocal") and Application.ShowLocal EQ true>
<h1>Variables</h1>
<cfdump var=#variables# />
<br /><br /></cfif>
<cfif isdefined("Application.ShowSession") and Application.ShowSession EQ true>
<h1>Session</h1>
<cfdump var=#session# />
<br /><br /></cfif>
<cfif isdefined("Application.ShowApplication") and Application.ShowApplication EQ true>
<h1>Application</h1>
<cfdump var=#application# />
<br /><br /></cfif>
<cfif isdefined("Application.ShowForm") and Application.ShowForm EQ true>
<h1>Form</h1>
<cfdump var=#form# />
<br /><br /></cfif>
<cfif isdefined("Application.ShowURL") and Application.ShowURL EQ true>
<h1>URL</h1>
<cfdump var=#url# />
<br /><br /></cfif>
<cfif isdefined("Application.ShowRequest") and Application.ShowRequest EQ true>
<h1>Request</h1>
<cfdump var=#request# />
<br /><br /></cfif>
<cfif isdefined("Application.ShowCookies") and Application.ShowCookies EQ true>
<h1>Cookies</h1>
<cfdump var=#cookie# />
<br /><br /></cfif>
<cfif isdefined("Application.ShowCGI") and Application.ShowCGI EQ true>
<h1>CGI</h1>
<cfdump var=#CGI# />
<br /><br /></cfif>
<cfif isdefined("Application.ShowServer") and Application.ShowServer EQ true>
<h1>Server</h1>
<cfdump var=#Server# />
<br /><br /></cfif>
<cfif isdefined("Application.ShowClient") and Application.ShowClient EQ true>
<h1>Client</h1>
<cfdump var=#Client# />
<br /><br /></cfif>
</div>

<script type="text/javascript">
var allDivs = document.getElementsByTagName("div");
var maxBottom = 0;
var divBottom;
for(var i=0; i<allDivs.length; i++) {
	if(allDivs[i].id != "forceBottom") {
		divBottom = allDivs[i].offsetTop + allDivs[i].offsetHeight;
		if (divBottom > maxBottom){
			maxBottom = divBottom;
		}
	}
}
maxBottom += 50;
if(maxBottom < 500) maxBottom = 500;

function expandJs(obj) {
	for(var i in obj) {
		js += typeof(obj[i]) + ":";
		if(typeof(obj[i]) == "object" || typeof(obj[i]) == "array") {
			js += i +  "<br />";
			js += "&nbsp;";
			expandJs(obj[i]);
		}else{
			js += i +  ": " + obj[i] + "<br />";
		}
	}
}

try{
document.getElementById('jsstuff').innerHTML = js;
}catch(e){
	// no js defined
}
document.getElementById("forceBottom").style.top = maxBottom + "px";


</script></cfif>