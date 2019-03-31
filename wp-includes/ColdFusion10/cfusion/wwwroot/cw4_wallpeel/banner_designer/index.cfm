  <!DOCTYPE html>
  <html lang="en">
    <head>
      <meta charset="utf-8">
      <meta http-equiv="X-UA-Compatible" content="IE=edge">
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <title>Webpagezone</title>


  <cfinclude template="include_top.cfm">

  </head>

  <body>
  <!---<div id="fontRender"></div>--->


  <form  class="form" style="background:#fff" name="lettering_form" id="lettering_form" action="index_action.cfm" method="post">
  <div class="row">
  	<div class="col-xs-12 test">

    </div>
  </div>
  <div class="row">
      <div class="container test" style="border:1px solid red">

          <div class="col-xs-7 test">
              <canvas id="canvasFront" width="500" height="200" style="border:3px solid grey;">
                  <div id="curveTextHolder"></div>
                  <div class="preloader"></div>
                  <div id="textisizer"></div>
              </canvas>

          </div>
          <div class="col-xs-5 test">
              <div class="row">
                  <div class="col-xs-12 test">
                      <div id="text_pannel">

                          <div class="row">
                              <div class="col-xs-12 tesst">Text</div>
                          </div>

                          <div class="row">
                              <div class="col-xs-8 test"><input id="panelTextField" type="text" class="form-control" value="Enter Your Text"></div>
                              <div class="col-xs-4 test"><button type="button" id="addBtn" class="btn btn-default btn-sm">Add Text</button>

                              <!--- <div class="elementHolder" id="addBtn">Add Text</div> ---></div>
                          </div>
                          <div class="row">
                                  <div class="col-xs-8 test">
                                      <div id="curveSliderHolder">
                                      	Change Curve Spacing:
                                      	<div id="curveSpaceSlider"></div>
                                      </div>
                                  </div>
                                  <div class="col-xs-4 test">
                                      <button type="button" id="addCurveBtn"  class="btn btn-default btn-sm">Change To Curve</button>
                                  </div>
                          </div>

                          <div class="row">
                              <div class="col-xs-8 test">

                                  <!--- Select Font:
                                      <select id="myFonts" name="myFonts">
                                         <option value="'Tahoma'">Tahoma</option>
                                      </select> --->

                                      <div id="googleFontsCustom">Select Font:
                                      <select id="myFonts">
                                         <option value="'Tahoma'">Tahoma</option>
                                      </select>
                                      </div>
                                     <!--- <input id="testfont" type="text" />--->
                              </div>
                              <div class="col-xs-4 test"></div>
                          </div>

						 <div class="row">
                              <div class="col-xs-8 test">
			                        <div id="colorTextHolder" class="elementHolder panelElements">Change Color:
									<div class="TextColorPicker" style="background-color: rgb(0, 0, 0);"></div>
									</div>
                              </div>
                              <div class="col-xs-4 test"></div>
                          </div>








                          <div class="row">


                              <div class="col-xs-6 test">
                              <button type="button"
                                    name="previewSVG"
                                    id="previewSVG"
                                    class="btn btn-default"
                                    ><i class="fa fa-th-list"></i>
                                    Preview Design
                                </button>
                                </div>
                              <div class="col-xs-6 test">
                                  <button type="submit"
                                        name="saveBtntoSVG"
                                        id="saveBtntoSVG"
                                        class="btn btn-default"
                                        ><i class="fa fa-th-list"></i>
                                        Save Design
                                   </button>
                               </div>
                          </div>

                          <div class="row">
                              <div class="col-xs-8 test"></div>
                              <div class="col-xs-4 test"></div>
                          </div>

                      </div>
                  </div>
              </div>
          </div>

      </div>
  </div>

  <textarea id="svgTextarea" name="svgTextarea">
  </textarea>

  <!---<a id="dl" download="Canvas.png">Download Canvas</a>--->
  <!---<a href="##" onClick="downloadFabric('canvasFront','Canvas.png');">Download Canvas</a>--->

  </form>

  <div id="previewImageDiv" class="boxShadow img-border"></div>

  </div>




  </body>
  </html>

