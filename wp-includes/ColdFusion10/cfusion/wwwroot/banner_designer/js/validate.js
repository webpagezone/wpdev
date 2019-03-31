
function formatPhone(obj){
	if (obj.value.length == 3){
		formattedPhone = obj.value + "-"
		obj.value = formattedPhone			
	}
	
	if (obj.value.length == 7){
		formattedPhone = obj.value + "-"
		obj.value = formattedPhone			
	}		
}

function dollarFormat(field){
	var myAmount = field.value
	// first check for a .
	if (myAmount.indexOf('.') == -1){
		var myAmount = new Number(field.value)
		//var testrslt = myAmount.toFixed(2)
		field.value = myAmount.toFixed(2)
	}
}

function cleanNumber(vNumber){
	regexp = /\$/g
	regexp2 = /\,/g
	
	intNumber = vNumber.replace(regexp,"")	
	intNumber = intNumber.replace(regexp2,"")	
	intNumber = trim(intNumber)
	
	return intNumber
	
}

function isNumeric(strString) {
    if(strString == parseInt(strString)){
   		return true
	} else {
		return false
	}
 }

 
function isNotNumeric(strString) {
    if(strString != parseInt(strString)){
   		return true
	} else {
		return false
	}
 }
 
function isFloat(strString) {
    if(strString == parseFloat(strString)){
   		return true
	} else {
		return false
	}
 }

 
function isNotFloat(strString) {
    if(strString != parseFloat(strString)){
   		return true
	} else {
		return false
	}
 }

 
function addCommas(nStr) {
	nStr += ''
	x = nStr.split('.')
	x1 = x[0]
	x2 = x.length > 1 ? '.' + x[1] : ''
	var rgx = /(\d+)(\d{3})/
	while (rgx.test(x1)) {
		x1 = x1.replace(rgx, '$1' + ',' + '$2')
	}
	return x1 + x2
}

function left(str, n){
	if (n <= 0)
	    return ""
	else if (n > String(str).length)
	    return str
	else
	    return String(str).substring(0,n)
}

function right(str, n){
    if (n <= 0)
       return ""
    else if (n > String(str).length)
       return str
    else {
       var iLen = String(str).length
       return String(str).substring(iLen, iLen - n)
    }
}
	
function trim(str){
	while(str.charAt(0) == (" ") ){  
		str = str.substring(1)
	}
	
	while(str.charAt(str.length-1) == " " ){
		str = str.substring(0,str.length-1)
	}
	return str
}
	
function validateNotEmpty(strValue){
	/************************************************
	 DESCRIPTION: Validates that a string is not all
	 blank (whitespace) characters.
	 
	 PARAMETERS:
	 strValue - String to be tested for validity
	 
	 RETURNS:
	 True if valid, otherwise false.
	 *************************************************/
	var strTemp = strValue
	strTemp = trim(strTemp)
	if (strTemp.length > 0) {
		return true
	}
	return false
}
 
// ********************** validate date functions *******************
// Date Validation
/**
 * DHTML date validation script. Courtesy of SmartWebby.com (http://www.smartwebby.com/dhtml/)
 */
// Declaring valid date character, minimum year and maximum year
var dtCh= "/";
var minYear=1900;
var maxYear=2100;

function isInteger(s){
	var i;
    for (i = 0; i < s.length; i++){   
        // Check that current character is number.
        var c = s.charAt(i);
        if (((c < "0") || (c > "9"))) return false;
    }
    // All characters are numbers.
    return true;
}

function stripCharsInBag(s, bag){
	var i;
    var returnString = "";
    // Search through string's characters one by one.
    // If character is not in bag, append to returnString.
    for (i = 0; i < s.length; i++){   
        var c = s.charAt(i);
        if (bag.indexOf(c) == -1) returnString += c;
    }
    return returnString;
}

function daysInFebruary (year){
	// February has 29 days in any year evenly divisible by four,
    // EXCEPT for centurial years which are not also divisible by 400.
    return (((year % 4 == 0) && ( (!(year % 100 == 0)) || (year % 400 == 0))) ? 29 : 28 );
}
function DaysArray(n) {
	for (var i = 1; i <= n; i++) {
		this[i] = 31
		if (i==4 || i==6 || i==9 || i==11) {this[i] = 30}
		if (i==2) {this[i] = 29}
   } 
   return this
}

function isDate(dtStr){
	var daysInMonth = DaysArray(12)
	var pos1=dtStr.indexOf(dtCh)
	var pos2=dtStr.indexOf(dtCh,pos1+1)
	var strMonth=dtStr.substring(0,pos1)
	var strDay=dtStr.substring(pos1+1,pos2)
	var strYear=dtStr.substring(pos2+1)
	strYr=strYear
	if (strDay.charAt(0)=="0" && strDay.length>1) strDay=strDay.substring(1)
	if (strMonth.charAt(0)=="0" && strMonth.length>1) strMonth=strMonth.substring(1)
	for (var i = 1; i <= 3; i++) {
		if (strYr.charAt(0)=="0" && strYr.length>1) strYr=strYr.substring(1)
	}
	month=parseInt(strMonth)
	day=parseInt(strDay)
	year=parseInt(strYr)
	
	if (pos1==-1 || pos2==-1){
		//alert("The date format should be : mm/dd/yyyy")
		return false
	}
	if (strMonth.length<1 || month<1 || month>12){
		//alert("Please enter a valid month")
		return false
	}
	if (strDay.length<1 || day<1 || day>31 || (month==2 && day>daysInFebruary(year)) || day > daysInMonth[month]){
		//alert("Please enter a valid day")
		return false
	}
	//if 2 digit year was entered, convert to 4 digit year
	if (strYear.length == 2){
		if (year > 50) {
			strYear = "19" + strYear
			year = year + 1900
		} else {
			strYear = "20" + strYear
			year += 2000
		}
	}
	
	if (strYear.length !=4 || year==0 || year<minYear || year>maxYear){
		//alert("Please enter a valid  year between "+minYear+" and "+maxYear)
		return false
	}
	if (dtStr.indexOf(dtCh,pos2+1)!=-1 || isInteger(stripCharsInBag(dtStr, dtCh))==false){
		//alert("Please enter a valid date")
		return false
	}
return true
}

function isMilitaryTime (timeStr){
	var valid = (timeStr.search(/^\d{2}:\d{2}:\d{2}$/) != -1) && (timeStr.substr(0,2) >= 0 && timeStr.substr(0,2) <= 24) && (timeStr.substr(3,2) >= 0 && timeStr.substr(3,2) <= 59) && (timeStr.substr(6,2) >= 0 && timeStr.substr(6,2) <= 59);
}

function isMilitaryShort (timeStr){
	var valid = (timeStr.search(/^\d{2}:\d{2}$/) != -1) && (timeStr.substr(0,2) >= 0 && timeStr.substr(0,2) <= 24) && (timeStr.substr(3,2) >= 0 && timeStr.substr(3,2) <= 59);
	return valid;
	}
