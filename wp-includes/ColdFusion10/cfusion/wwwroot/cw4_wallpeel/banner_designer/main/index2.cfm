<!DOCTYPE html>
<html lang="en">
<!--- <head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Print-Designer</title>


<link rel="stylesheet" type="text/css" href="/SAMlocal/PrintDesigner/main/css/style.css">
<link rel="stylesheet" type="text/css" href="/SAMlocal/PrintDesigner/main/css/jquery-ui.css" />
<script src="/SAMlocal/PrintDesigner/main/js/jquery-2.1.0.js"></script>
<script src="/SAMlocal/PrintDesigner/main/js/jquery.qrcode.min.js"></script>

<script src="/SAMlocal/PrintDesigner/main/js/designer.js"></script>
<script src="/SAMlocal/PrintDesigner/main/js/jquery.fontselect.js"></script>
<script src="/SAMlocal/PrintDesigner/main/js/fabric.all.js"></script>
<script src="/SAMlocal/PrintDesigner/main/js/jquery-ui.js"></script>

</head> --->
<body>

<div id="fontRender"></div>
<div id="qrHolder"></div>
<div id="container">




	<div id="designArea">
		<canvas id="canvasFront" width="600" height="600" style="border:3px solid #ccc;"></canvas>
		<canvas id="canvasBack" width="600" height="600" style="border:3px solid #ccc;"></canvas>
		<div id="curveTextHolder"></div>
	    <div class="preloader"></div>
	    <div id="textisizer"></div>
	</div>


	<div id="frontView"></div>
	<div id="backView" class="hidden"></div>
	<div id="priceView"></div>
	<div id="controlPanelHolder">
		<div class="delDesignIcon iconHolder" id="deleteDesign"></div>
		<div class="gridIcon iconHolder" id="gridBtn"></div>
		<div class="shareIcon iconHolder" id="shareBtn"></div>
		<div class="printIcon iconHolder" id="printBtn"></div>
		<div class="orderIcon iconHolder" id="formBtn"></div>
	</div>

	<div id="designAreaPanel">
		<div id="panelArea">
			<div class="elementHolder" id="panelTextFieldHolder"><input id="panelTextField" type="text" value="Enter Your Text"></div>
			<div class="elementHolder" id="addBtn">Add Text</div>
			<div class="elementHolder" id="addCurveBtn">Change To Curve</div>

			<div id="curveSliderHolder" class="elementHolder panelElements hidden">
				Change Curve Spacing: <div id="curveSpaceSlider"></div>
			</div>
			<div id="colorTextHolder" class="elementHolder panelElements">Change Color: <div class="TextColorPicker" style="background-color: rgb(0, 0, 0);"></div></div>

			<div id="changeFontHolder" class="elementHolder panelElements">
				<div id="googleFontsCustom">Select Font:
				<select id="myFonts">
				   <option value="'Tahoma'">Tahoma</option>
				</select>
				</div>
				<div id="googleFontsComplete" class="fontHolder"><input id="font" type="text"></div>
			</div>


		</div>
	</div>

</div>

<script src="/SAMlocal/PrintDesigner/main/js/html2canvas.js"></script>
<script src="/SAMlocal/PrintDesigner/main/js/jquery.plugin.html2canvas.js"></script>
<script src="/SAMlocal/PrintDesigner/main/js/textColorPicker.js"></script>
<script src="/SAMlocal/PrintDesigner/main/js/backgroundColorPicker.js"></script>
<script src="/SAMlocal/PrintDesigner/main/js/motives.js"></script>
<script src="/SAMlocal/PrintDesigner/main/js/backgroundsH.js"></script>
<script src="/SAMlocal/PrintDesigner/main/js/backgroundsV.js"></script>
<script src="/SAMlocal/PrintDesigner/main/js/backgroundsF.js"></script>
<script src="/SAMlocal/PrintDesigner/main/js/upload.js"></script>
<script src="/SAMlocal/PrintDesigner/main/js/printThis.js"></script>
</body>
</html>