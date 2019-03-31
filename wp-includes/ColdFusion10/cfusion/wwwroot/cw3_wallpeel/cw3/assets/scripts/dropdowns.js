
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
	setValue(findObj('cstShpCountry'), findObj('cstCountry').options[findObj('cstCountry').selectedIndex].value);
	setDynaList(arrDL2);
	setValue(findObj('cstShpStateProv'), findObj('cstStateProv').options[findObj('cstStateProv').selectedIndex].value);
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

function setValue(list, value) {
	for(var i=0; i<list.length; i++){
		if(list.options[i].value == value) list.selectedIndex = i;
	}
}

function cwSetDependentList(objCurrentList, listNumber){
	var arSelOptions = new Array();
	var arNextListOptions = new Array();
	var arMatchedOptions = new Array();
	var lastList = false;
	var finalOptionPos = -1;
	var objList = "";
	var i, j, k

	//Determine if this is the first list in the group
	if(listNumber > 0){
		//This is not the first list in the group, so loop through all lists and get their current selected values
		for(i=0; i<=listNumber; i++){
			//Get the current list as an object
			objList = document.getElementById("sel" + i);			
			//Get the current lists value and tack it to the end of the selected options array
			arSelOptions[i] = objList.options[objList.selectedIndex].value;
		}
	}
	else{
		//This is the first list in the group
		arSelOptions[0] = objCurrentList.options[objCurrentList.selectedIndex].value;
	}
	//Search through the options array to find all matches.
	if(!document.getElementById("sel" + (listNumber + 1))){
		lastList = true;
	}

	k = 0;
	var arOptions_length = arOptions.length;
	var arSelOptions_length = arSelOptions.length;
	for(i=0; i<arOptions_length; i++){
		for(j=0; j<arSelOptions_length; j++){
			//If there's a mismatched option, exit the loop
			if(arOptions[i]["optionIDs"][j] != arSelOptions[j]){break;}
			//We survived the if statement and matched all items, so we have a match
			if(j == arSelOptions_length - 1){
				if(lastList){
					//If this is the last list selected, then specify the final SKU selected
					finalOptionPos = i;
					break;
				}
				else{
					//We're not done yet, so just collect additional options
					//If we haven't already added the next option to the list, add it now.
					if(cwIndexInArray(arMatchedOptions, arOptions[i]["optionIDs"][j+1]) == -1){
						arNextListOptions[k] = Array(arOptions[i]["optionIDs"][j+1], arOptions[i]["optionNames"][j+1]);
						arMatchedOptions[k] = arOptions[i]["optionIDs"][j+1];
						k = k + 1;
					}
				}
			}
		}
		//If we've already specified the final SKU selected, break out of the parent for loop
		if(finalOptionPos != -1){break;}
	}

	if(lastList){
		var objDiv = document.getElementById("divPrice");
		//This is the last list, set the price div's value appropriately
		if(objDiv){
			if(finalOptionPos != -1){
				objDiv.innerHTML = arOptions[finalOptionPos]["price"];
			}
			else{
				objDiv.innerHTML = objDiv.getAttribute("title");
			}
		}
	}
	else{
		//We have the options for the next list, fill it up
		var nextList = document.getElementById("sel" + (listNumber + 1));
		cwClearList(nextList);
		cwPopulateList(nextList, arNextListOptions);
		cwSetDependentList(nextList, listNumber + 1)
	}
}
function cwIndexInArray(ar,str){
	for(var i=0; i<ar.length; i++){if(ar[i] == str){return i;}}
	return -1;
}
function cwClearList(objList){
	for(var i = objList.options.length; i >= 0; i--){objList.options[i] = null;}
	objList.selectedIndex = -1;
}

function cwPopulateList(objList, arr){
	var arr_length = arr.length;
	for(var i=0; i<arr_length; i++){objList.options[objList.options.length] = new Option(arr[i][1], arr[i][0]);}
	if(objList.options.length == 0){objList.options[objList.options.length] = new Option("No options available...",0);}
	objList.selectedIndex = 0;
}
