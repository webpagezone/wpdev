// JavaScript Document


var currentPage;
function tab(blah) {
	var links = document.getElementById('divTabs').getElementsByTagName('a');
	for(var i=1; i <= links.length; i++) {
		links[i-1].className = (i==blah) ? 'current' : '';
		eval("document.getElementById('page" + i + "').style.display='" + ((i==blah) ? "block" : "none") + "'");
	}
	currentPage = blah;
}
function setSubmit(submitbutton){
	var links = document.getElementById('divTabs').getElementsByTagName('a');
	document.getElementById(submitbutton).value = 
		(document.getElementById('page' + links.length).style.display=='block') ? 'Finish' : 'Next »';
}

function nextPage() { // for submit button
	var links = document.getElementById('divTabs').getElementsByTagName('a');
	document.getElementById('nextpage').value = (currentPage == links.length) ? 1 : currentPage + 1;
}

function hideTab(tab){
	document.getElementById('tab' + tab).style.visibility='hidden';
	document.getElementById('page' + tab).style.display='none';
}

function showTab(tab) {
	document.getElementById('tab' + tab).style.visibility='visible';
}


function showTabs(){
	var allDivs = document.getElementsByTagName("div");
	for(var i=0; i<allDivs.length; i++) {
		if(allDivs[i].className == 'noJS')
			allDivs[i].style.display = 'block';
	}
}