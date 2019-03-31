<!--- 
================================================================
Application Info: Cartweaver© 2002 - 2007, All Rights Reserved.
Developer Info: Application Dynamics Inc.
                1560 NE 10th
                East Wenatchee, WA 98802
Support Info: http://www.cartweaver.com/go/cfhelp
				
Cartweaver Version: 3.0.0  -  Date: 4/21/2007
================================================================
Name: DatePopup.cfm
Description: This is the calander used by the Order Search By Date form.
================================================================
--->
<cfparam name="URL.formName" default="">
<cfparam name="URL.fieldName" default="">
<cfparam name="URL.getdate" default="">
<cfparam name="dteDate" default="#URL.getdate#">
<cfif NOT IsDate(dteDate)>
	<cfset dteDate = LSDateFormat(Now(), Request.dateMask)>
</cfif>
<cfset dteDate = LSParseDateTime(dteDate)>
<cfsilent>
</cfsilent>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Select Date</title>
<link href="assets/admin.css" rel="stylesheet" type="text/css" />
<style type="text/css">
/*Calendar styles*/
body {
	text-align: center;
}
table {
	width: 200px;
}
#calHead, #calHead td {
	border: none;
	padding: 4px;
}
#calDetails td {
	text-align: center;
}
.caltitle {
	text-align: center;
	font-weight: bold;
}
.caltitler {
	text-decoration: none;
	text-align: right;
}
.caltitlel {
	text-decoration: none;
	text-align: left;
}
#divMainContent {
	margin: 0px;
}
td.calForeignMonth {
	color: #CCCCCC;
}
td.selectedDate {
	background-color: #D3D3E2;
}
</style>
<script language="JavaScript">
<!--

// function to populate the date on the form and to close this window. --->
function ShowDate(DayOfMonth) {
    var FormName="<cfoutput>#URL.FormName#</cfoutput>";
    var FieldName="<cfoutput>#URL.FieldName#</cfoutput>";
    eval("self.opener.document." + FormName + "." + FieldName + ".value='"+DayOfMonth+"'");
    window.close();
}

//-->
</script>
</head>

<body>
<div id="divMainContent">
<table id="calHead" class="calHead">
		<tr> 
		  <td class="caltitlel"><cfoutput><a href="?getdate=#LSDateFormat(DateAdd("m",-1,dteDate),request.dateMask)#&FormName=#URLEncodedFormat(URL.FormName)#&FieldName=#URLEncodedFormat(URL.FieldName)#">&laquo;</a></cfoutput></td>
		  <td class="caltitle"><cfoutput>#LSDateFormat(dteDate,"mmmm yyyy")#</cfoutput></td>
		  <td class="caltitler"><cfoutput><a href="?getdate=#LSDateFormat(DateAdd("m",1,dteDate),request.dateMask)#&FormName=#URLEncodedFormat(URL.FormName)#&FieldName=#URLEncodedFormat(URL.FieldName)#">&raquo;</a></cfoutput></td>
		</tr>
</table>
	  <table id="calDetails">
		<tr> 
		  <th scope="col">Su</th>
		  <th scope="col">M</th>
		  <th scope="col">T</th>
		  <th scope="col">W</th>
		  <th scope="col">Th</th>
		  <th scope="col">F</th>
		  <th scope="col">Sa</th>
		</tr>
<cfscript>
	//days in month
	intDim = DaysInMonth(dteDate);
	//Date of week that month starts on 
	intDOW = DayOfWeek(LSParseDateTime(LSDateFormat(CreateDate(Year(dteDate),Month(dteDate),"1"),request.dateMask)));
	//Write spacer cells at beginning of first row if month doesn't start on a Sunday.
	dKeeper = DaysInMonth(DateAdd("m",-1,dteDate));
	if(intDOW NEQ 1){
		writeoutput("<tr>");
		intPosition = 1;
		while(intposition LT intDOW){
			writeoutput("<td class=""calForeignMonth"">" & dKeeper - (intDOW - intPosition - 1) & "</td>");
			intPosition = IncrementValue(intPosition);
		}
	}
	//Write days of month in proper day slots
	intCurrentDay = 1;
	intPosition = intDOW;
	while(intCurrentDay LTE intDIM){
		//If we're at the begginning of a row then write TR
		if(intPosition EQ 1){writeoutput("<tr>");}
		curDate = LSDateFormat(CreateDate(Year(dteDate),Month(dteDate),intCurrentDay),request.dateMask);
		tdClass = "";
		if(curDate EQ LSDateFormat(dteDate,request.dateMask)){tdClass = " class=""selectedDate""";}

		writeoutput("<td" & tdClass & "><a href=""javascript:ShowDate('" & curDate & "');"">" & intCurrentDay & "</a></td>");
		
		//If we're at the endof a row then write /TR
		if(intPosition EQ 7){
			writeoutput("</tr>");
			intPosition = 0;
		}
		
		//Increment variables
		intCurrentDay = IncrementValue(intCurrentDay);
		intPosition = IncrementValue(intPosition);
	}

	//Write spacer cells at end of last row if month doesn't end on a Saturday.
	//Use dKeeper to get how many cells we're going to output
	dKeeper = intPosition - 1;
	if(intPosition NEQ 1){
		while(intPosition LTE 7){
			writeoutput("<td class=""calForeignMonth"">");
			if(intPosition EQ 8){
				writeoutput("&nbsp;");
			}else{
				writeoutput(intPosition - dKeeper);
			}
			writeoutput("</td>");
			intPosition = IncrementValue(intPosition);
		}
		writeoutput("</tr>");
	}
</cfscript>
	  </table>
</div>
</body>
</html>
