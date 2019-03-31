function cwSameShipping(obj){
	//Is the checkboxed checked or not?
	var retVal = (!obj.checked)? true : false;
	var i,j,curObj;
	//Create a list of common fields minus their cst and cstShp prefixes respectively
	var arrCommonFields = new Array('Address1','Address2','City','Zip');
	var arrCommonFields_length = arrCommonFields.length;
	//Create a list of special fields that have need other work done before they can have a value set or be enabled/disabled
	var arrSpecialFields = new Array('Name','Country','StateProv');
	//An array of all fields, both common and special for the purpose of enabling/disabling the fields
	var arrAllFields = arrCommonFields.concat(arrSpecialFields);
	var arrAllFields_length = arrAllFields.length;
	//Loop through common fields and set the shipping fields to the customer values
	for(i=0; i<arrCommonFields_length;i++){
		findObj('cstShp'+arrCommonFields[i]).value = findObj('cst'+arrCommonFields[i]).value;
	}
	//Combine the First & Last Name fields for the Full name field used in the Shipping Form
	findObj('cstShpName').value = findObj('cstFirstName').value + " " + findObj('cstLastName').value;
	//Set the Ship Country, then populate the state/prov list before setting its selected index.	
	findObj('cstShpCountry').selectedIndex = findObj('cstCountry').selectedIndex;
	setDynaList(arrDL2);
	findObj('cstShpStateProv').selectedIndex = findObj('cstStateProv').selectedIndex;
	//Loop through all fields and disable them if the box is checked, otherwise enable the fields.
	for(j=0; j<arrAllFields_length;j++){
		curObj = findObj('cstShp'+arrAllFields[j]);
		if(curObj){			
			if(!retVal){curObj.setAttribute("disabled","disabled");}
			else{curObj.removeAttribute("disabled");}
		}
	}
return retVal;
}

function setDynaList(arrDL){
 var theForm = findObj(arrDL[2]);var theForm2 = findObj(arrDL[4]);var oList1 = theForm.elements[arrDL[1]];
 var oList2 = theForm2.elements[arrDL[3]];var arrList = arrDL[5];clearDynaList(oList2);
 if (oList1.selectedIndex == -1){oList1.selectedIndex = 0;}
 populateDynaList(oList2, oList1[oList1.selectedIndex].value, arrList);return true;
}
 
function clearDynaList(oList){
 for (var i = oList.options.length; i >= 0; i--){oList.options[i] = null;}oList.selectedIndex = -1;
}
 
function populateDynaList(oList, nIndex, aArray){
 for (var i = 0; i < aArray.length; i= i + 3){
  if (aArray[i] == nIndex){oList.options[oList.options.length] = new Option(aArray[i + 1], aArray[i + 2]);}}
 if (oList.options.length == 0){oList.options[oList.options.length] = new Option("[none available]",0);}oList.selectedIndex = 0;
}

function findObj(theObj, theDoc){
  var p, i, foundObj;if(!theDoc) theDoc = document;if( (p = theObj.indexOf("?")) > 0 && parent.frames.length)
  {theDoc = parent.frames[theObj.substring(p+1)].document;theObj = theObj.substring(0,p);}
  if(!(foundObj = theDoc[theObj]) && theDoc.all) foundObj = theDoc.all[theObj];
  for (i=0; !foundObj && i < theDoc.forms.length; i++)foundObj = theDoc.forms[i][theObj];
  for(i=0; !foundObj && theDoc.layers && i < theDoc.layers.length; i++)foundObj = findObj(theObj,theDoc.layers[i].document);
  if(!foundObj && document.getElementById) foundObj = document.getElementById(theObj);return foundObj;
}

function dwfaq_getCSSPropertyValue(obj,cP,jP){//v1.1 
//Copyright © 2004-2005 Angela C. Buraglia & DWfaq.com
//All Rights Reserved. Not for distribution. support@dwfaq.com
//Support Newsgroup: news://support.dwfaq.com/support
	if(typeof(obj)!='object'){var obj=document.getElementById(obj);}
	if(typeof(obj.currentStyle)!='object'){
		return (typeof(document.defaultView) == 'object' && document.defaultView.getComputedStyle(obj,''))?
		document.defaultView.getComputedStyle(obj,'').getPropertyValue(cP):
		obj.style.getPropertyValue(cP);}
	else{
		return (navigator.appVersion.indexOf('Mac')!=-1)?
		obj.currentStyle.getPropertyValue(cP):
		obj.currentStyle.getAttribute((jP)?jP:cP);}
}

function dwfaq_ToggleOMaticDisplay(){//v1.0
//Copyright © 2004 Angela C. Buraglia & DWfaq.com
//All Rights Reserved. Not for distribution. support@dwfaq.com
//Support Newsgroup: news://support.dwfaq.com/support
	var obj,cS,args=dwfaq_ToggleOMaticDisplay.arguments;document.MM_returnValue=(typeof(args[0].href)!='string')?true:false;
	for(var i=1;i<args.length;i++){obj=document.getElementById(args[i]);
		if(obj){cS=dwfaq_getCSSPropertyValue(obj,'display');
			if(!obj.dwfaq_OD){obj.dwfaq_OD=(cS!='none'&&cS!='')?cS:(obj.tagName.toUpperCase()=='TR' && cS!=='none')?'':
			(obj.tagName.toUpperCase()=='TR' && typeof(obj.currentStyle)!='object')?'table-row':'block';}
			obj.style.display=(cS!='none')?'none':obj.dwfaq_OD}}
}

function dwfaq_ToggleOMaticClass(){//v1.1
//Copyright © 2004-2005 Angela C. Buraglia & DWfaq.com
//All Rights Reserved. Not for distribution. support@dwfaq.com
//Support Newsgroup: news://support.dwfaq.com/support
	var obj,args=dwfaq_ToggleOMaticClass.arguments;document.MM_returnValue=(typeof(args[0].href)!='string')?true:false;
	for(var i=1;i<args.length-1;i+=2){obj=document.getElementById(args[i]);
		if(obj){if(!obj.dwfaq_OC){obj.dwfaq_OC=(obj.className=='')?true:obj.className;}
			if(obj.dwfaq_OC&&obj.className==args[i+1]){
				(obj.dwfaq_OC==true)?obj.className='':obj.className=obj.dwfaq_OC;}
			else{obj.className=args[i+1];}}}
}

function cwShowProductImage(imageURL,imageTitle){
	imgWindow = window.open('','imgWindow','scrollbars=no,width=500,height=500,left=100,top=100');
	with (imgWindow.document){
		writeln('<html><head><title>Loading...</title><style type="text/css">body{margin:0px;}</style>');
		writeln('<sc'+'ript>');
		writeln('var isNN,isIE;');
		writeln('if (parseInt(navigator.appVersion.charAt(0))>=4){');
			writeln('isNN=(navigator.appName=="Netscape")?1:0;');
			writeln('isIE=(navigator.appName.indexOf("Microsoft")!=-1)?1:0;}');
		writeln('function fitToImage(){');
			writeln('var img = document.getElementById("imgProduct");');
			writeln('var imgWidth = img.width;');
			writeln('var imgHeight = img.height;');
			writeln('if(isIE){');
				writeln('var windowWidth = document.body.clientWidth;');
				writeln('var windowHeight = document.body.clientHeight;}');
			writeln('if(isNN){');
				writeln('var windowWidth = window.innerWidth;');
				writeln('var windowHeight = window.innerHeight;');
			writeln('}');
			writeln('window.resizeBy((windowWidth - imgWidth)*-1, (windowHeight - imgHeight)*-1);}'); 
		writeln('function updateTitle(){document.title = "'+imageTitle+'";}');
		writeln('</sc'+'ript>');
		writeln('</head><body onload="fitToImage();updateTitle();self.focus()" onblur="self.close()">');
		writeln('<div align="center"><img id="imgProduct" src="'+imageURL+'"></div></body></html>');
		close();
	}
	return false;
}