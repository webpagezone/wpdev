<!--- <?php include('xml.php'); ?> --->
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Print-Designer</title>



<link rel="stylesheet" type="text/css" href="css/style.css">
<link rel="stylesheet" type="text/css" href="css/jquery-ui.css" />
<script src="js/jquery-2.1.0.js"></script>
<script src="js/jquery.qrcode.min.js"></script>
<!--- <script src="js/initApp_cfm.js"></script> --->
<script src="js/designer.js"></script>
<script src="js/jquery.fontselect.js"></script>
<script src="js/fabric.all.js"></script>
<script src="js/jquery-ui.js"></script>

</head>
<body>
<div id="fontRender"></div>
<div id="qrHolder"></div>
<div id="container">
	<!--- <div id="header">
		<div id="loadAppStart" class="green">Load My Design</div>
		<div id="logoHolder"></div>
	</div> --->
	<div class="usernameHolder"></div>
	<div id="productsHolder"></div>
	<div id="footer">Print-Designer @ 2014</div>
	<div id="printResult"></div>
	<!--- <div id="blockArea"></div> --->
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
			<div class="elementHolder" id="panelTextFieldHolder"><input id="panelTextField" type="text" value="Enter Your Text"></input></div>
			<div class="elementHolder" id="addBtn">Add Text</div>
			<div class="elementHolder" id="addCurveBtn">Change To Curve</div>
			<div class="elementHolder" id="addQRBtn">Add Text as QR-Code</div>
			<div class="elementIconHolder">
				<div id="strokeIcon"></div>
				<div id="underlineIcon"></div>
				<div id="boldIcon"></div>
				<div id="reverseCurveTextIcon"></div>
				<div class="delElementIcon" id="deleteElementBtn"></div>
				<div class="layerUpIcon" id="increaseZIndex"></div>
				<div class="layerDownIcon" id="decreaseZIndex"></div>
				<div class="resetIcon" id="resetBtn"></div>
			</div>
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
				<div id="googleFontsComplete" class="fontHolder"><input id="font" type="text" /></div>
			</div>
			<div id="motivesHolder">
				<div id="previous"></div>Select Your Motive
				<div id="navNumber"></div>
				<div id="next"></div>
				<div id="motiveMainContainer">
					<div id="motiveContainerMask">
						<div id="motiveContainer"></div>
					</div>
				</div>
			</div>
			<div id="backgroundsVHolder" class="hidden">
				<div id="bvprevious"></div>Select Your Background
				<div id="bvnavNumber"></div>
				<div id="bvnext"></div>
				<div id="backgroundVMainContainer">
					<div id="backgroundVContainerMask">
						<div id="backgroundVContainer"></div>
					</div>
				</div>
			</div>
			<div id="backgroundsHHolder" class="hidden">
				<div id="bhprevious"></div>Select Your Background
				<div id="bhnavNumber"></div>
				<div id="bhnext"></div>
				<div id="backgroundHMainContainer">
					<div id="backgroundHContainerMask">
						<div id="backgroundHContainer"></div>
					</div>
				</div>
			</div>
			<div id="backgroundsFHolder" class="hidden">
				<div id="bfprevious"></div>Select Your Background
				<div id="bfnavNumber"></div>
				<div id="bfnext"></div>
				<div id="backgroundFMainContainer">
					<div id="backgroundFContainerMask">
						<div id="backgroundFContainer"></div>
					</div>
				</div>
			</div>
			<div id="colorBackgroundHolder" class="elementHolder panelElements">Background Color: <div class="BackgroundColorPicker" style="background-color: rgb(0, 0, 0);"></div></div>
			<div id="deleteBackgroundImage" class="elementHolder orange hidden">Delete Background</div>
			<div class="checkBoxHolder"><input id="tc" name="tc" type="checkbox"/><label for="tc">I accept Terms and Conditions</label></div>
			<div class="choose_file elementHolder green" id="uploadMotive">
				<span class="infoText">Upload an Image</span><div id="uploadIcon"></div>
				<input id="uploadMotiveInput" type="file"/>
			</div>
			<div id="backBtnProductDesign" class="orange">Back</div>
		</div>
	</div>
</div>
<script src="js/html2canvas.js"></script>
<script src="js/jquery.plugin.html2canvas.js"></script>
<script src="js/textColorPicker.js"></script>
<script src="js/backgroundColorPicker.js"></script>
<script src="js/motives.js"></script>
<script src="js/backgroundsH.js"></script>
<script src="js/backgroundsV.js"></script>
<script src="js/backgroundsF.js"></script>
<script src="js/upload.js"></script>
<script src="js/printThis.js"></script>
</body>
</html>