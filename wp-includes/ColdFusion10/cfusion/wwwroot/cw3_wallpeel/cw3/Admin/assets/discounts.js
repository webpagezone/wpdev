function cw_discountType(opt){
	var showString = "table-row";
/*@cc_on @*/
/*@if (true)
showString = "block";
@*/
/*@end @*/
	switch(opt){	
		case "1":
		document.getElementById('rowMinQty').style.display = "none";
		document.getElementById('rowMinAmount').style.display = "none";
		break;
		case "2":
		document.getElementById('rowMinQty').style.display = showString;
		document.getElementById('rowMinAmount').style.display = "none";
		break;
		case "3": 
		document.getElementById('rowMinQty').style.display = "none";
		document.getElementById('rowMinAmount').style.display = showString;
		break;
	}
}


function showSKUdivs(obj,toggleclass){
	var thedivs = document.getElementsByTagName('div');
	var show;
	for(var i=0; i<thedivs.length; i++) {
		if(thedivs[i].className == toggleclass) {
			show = (thedivs[i].style.display == "block")?'none':'block'; 
			thedivs[i].style.display = show;
		}
	}
	obj.src = (show == 'block')?'assets/images/dark-expand.gif' :'assets/images/dark-inactive.gif';
}

function MM_goToURL() { //v3.0
  var i, args=MM_goToURL.arguments; document.MM_returnValue = false;
  for (i=0; i<(args.length-1); i+=2) eval(args[i]+".location='"+args[i+1]+"'");
}
