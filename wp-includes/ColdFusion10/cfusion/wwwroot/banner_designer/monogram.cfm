<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title></title>
    <!-- Bootstrap -->
    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">

    <script language="javascript" src="js/jquery-2.1.0.js"></script>
  
    <!-- Latest compiled and minified JavaScript -->
    <script src="bootstrap/js/bootstrap.min.js"></script>
    <!--additionalcss files -->

    <link href="bootstrap/font_awesome/css/font-awesome.css" rel="stylesheet" />
   

    <!-- additional additional JS files for this page -->

    <link rel="stylesheet" type="text/css" href="css/style.css">
    <link rel="stylesheet" type="text/css" href="css/jquery-ui.css" />


    <script src="js/initApp.js"></script>
    <script src="js/designer.js"></script>
    <script src="js/jquery.fontselect.js"></script>
    
    <script src="js/fabric.all.js"></script>
    <script src="js/jquery-ui.js"></script>

  
</head>
<body>


    <div id="fontRender"></div>

    <form class="form" style="background:#fff" name="lettering_form" id="lettering_form" action="action.cfm" method="post">

    <div class="row">
        <div class="container columnContainer">
            <div class="col-xs-4 leftColumn">
                <div class="row heading-bg">
                    <div class="col-xs-12 heading-bg" id="showtextArea">
                        <button type="button" class="btn " aria-label="Left Align">
                            <span class="glyphicon glyphicon-text-width" aria-hidden="true"></span>&nbsp;&nbsp;Add Text
                        </button>
                    </div>
                </div>
                <div id="textArea" class="leftColumnContentRow">
                    <div class="row">
                        <div class="col-xs-12">

                            <div class="row">
                                <div class="col-xs-8">
                                    <textarea class="form-control" id="panelTextField" rows="1" style="width:100%">Enter Your Text</textarea>
                                </div>
                                <div class="col-xs-4">
                                    <button type="button" id="addBtn" class="btn btn-sm btn-info pull-right">Add Text</button>
                                </div>
                            </div>

                            <div class="row spacer-20" id="fontOptions">
                                <div class="col-xs-8">
                                    Select Font:
                                    <div id="changeFontHolder" class="panelElements">
                                        <div id="googleFontsCustom">
                                            <select id="myFonts">
                                                <option value="'Tahoma'">Tahoma</option>
                                            </select>
                                        </div>
                                        <div id="googleFontsComplete" class="fontHolder"><input id="font" type="text" /></div>
                                    </div>
                                </div>
                                <div class="col-xs-2">
                                    Bold
                                    <button id="boldIcon" aria-hidden="true">
                                        <i class="fa fa-bold" aria-hidden="true"></i>
                                    </button>
                                </div>
                                <div class="col-xs-2">
                                    <div id="colorTextHolder">
                                        Color:
                                        <div class="TextColorPicker" style="background-color: rgb(0, 0, 0);"></div>
                                    </div>
                                </div>
                                <!--Stroke<button id="boldIcon" class="btn btn-sm glyphicon glyphicon-bold" aria-hidden="true"></button>-->


                            </div>

                            <div class="row" id="curveOptions">
                                <div class="col-xs-6 test">
                                    <div id="curveSliderHolder">
                                        Change Curve Spacing:
                                        <div id="curveSpaceSlider"></div>
                                    </div>
                                </div>
                                <div class="col-xs-2 test">
                                    
                                       <a id="reverseCurveTextIcon" href="">Reverse</a> 

                                </div>

                                <div class="col-xs-4 test">
                                <a id="addCurveBtn" href="">Change To Curve</a> 
                                    
                                    
                                </div>
                            </div>




                        </div>
                    </div>
                </div>

                <div class="row heading-bg">
                    <div class="col-xs-12" id="showimgArea">
                        <button type="button" class="btn " aria-label="Left Align">
                            <span class="glyphicon glyphicon-picture" aria-hidden="true"></span>&nbsp;&nbsp;Add Images
                        </button>
                    </div>
                </div>

                <div id="imgArea" class="leftColumnContentRow">
                    
                    <div class="row">
                        <div class="col-xs-10">
                        </div>
                        <div class="col-xs-2">
                            <div id="colorTextHolder">
                                Color:
                                <div class="TextColorPicker" style="background-color: rgb(0, 0, 0);"></div>
                            </div>
                        </div>

                    </div>
                   
                    <div class="row" id="ImagesSelector">
                        <div class="col-xs-4" style="padding-right:0">
                            <ul class="controls" data-bind="foreach: category">
                                <li><a href="#" data-bind="text: Title, click: $root.showCategory(Title), css: { 'active': $root.categoryShown(Title) }">NONE</a></li>
                            </ul>

                        </div>
                        <div class="col-xs-8" style="padding-left:0">
                            <div class="imgContent" content data-bind="foreach: category">
                                <div class="details" data-bind="foreach: image, visible: $root.categoryShown(Title)">
                                    <span>
                                        <img data-bind="attr: { 'src': Url},click: $root.getImage" />

                                    </span>
                                </div>

                            </div>

                        </div>
                    </div>
                </div>


                


                <div class="row heading-bg">
                    <div class="col-xs-12 heading-bg">
                        <button type="button" class="btn " aria-label="Left Align">
                            <span class="glyphicon glyphicon-text-width" aria-hidden="true"></span>&nbsp;&nbsp;Edit/ Delete/ View
                        </button>
                    </div>
                </div>

                <div id="" class="leftColumnContentRow">
                    <div class="row">

                        <div class="col-xs-9">

                            <button id="gridBtn" class="btn btn-sm pull-right" aria-hidden="true">
                                <i class="fa fa-table" aria-hidden="true"></i>
                            </button>
                            &nbsp;
                            <button id="previewSVG_w" class="btn btn-sm pull-right" aria-hidden="true">
                                <i class="fa fa-eye" aria-hidden="true"></i>
                            </button>
                            &nbsp;
                            <button id="downloadPreview" class="btn btn-sm pull-right" aria-hidden="true">
                                <i class="fa fa-download" aria-hidden="true"></i>
                            </button>


                            <a id='downloadPreview' href="javascript:void(0)"> Download Image </a>

                        </div>


                        <div class="col-xs-3">
                            <button id="deleteElementBtn" class="btn btn-sm btn-danger pull-right" aria-hidden="true">
                                <i class="fa fa-trash" aria-hidden="true"></i>
                            </button>
                        </div>

                    </div>
                </div>



                <!--<div class="row heading-bg">
                    <div class="col-xs-12 heading-bg" id="showtextArea">

                    </div>
                </div>
                <div id="" class="leftColumnContentRow">
                    <div class="row">
                        <div class="col-xs-12">


                        </div>
                    </div>

                </div>-->

            </div><!--leftColumn-->

            <div class="col-xs-8 rightColumn">
                <div id="designArea">
                    <div id="curveTextHolder"></div>
                    <div class="preloader"></div>
                    <div id="textisizer"></div>
                    <canvas id="canvasFront" width="720" height="400" style="border:3px solid grey;"></canvas>
                </div>

                <div id="previewImageDiv"></div>
            </div><!--rightColumn-->


        </div><!--columnContainer-->
    </div>


    <textarea id="svgTextarea" name="svgTextarea"></textarea>
    </form>

    <div id="previewImageDiv" class="boxShadow img-border"></div>

    <script src="js/html2canvas.js"></script>
    <script src="js/jquery.plugin.html2canvas.js"></script>
    <script src="js/textColorPicker.js"></script>
    <script src="js/backgroundColorPicker.js"></script>
    <script src="js/motives.js"></script>
    <script src="js/backgroundsH.js"></script>
    <script src="js/backgroundsV.js"></script>
    <script src="js/backgroundsF.js"></script>
    <!--<script src="js/upload.js"></script>-->
    <script src="js/printThis.js"></script>
    <script src="js/fabric.curvedText.js"></script>


    <script src="js/knockout-3.2.0.js"></script>
    <script src="js/knockout-3.2.0.debug.js"></script>
    <script src="js/koscripts.js"></script>

</body>
</html>

