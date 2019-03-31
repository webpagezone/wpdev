+$(function () {
    var _curveSpaceSlider = $('#curveSpaceSlider');
    //var designSaved = false;
    //var isPrint = true;
    var _curDesignName;
    var _curFrontDesignURL;
    //var _curBackDesignURL;    
    var curName;
    var _normalInit = false;    
    var _hcardRedLine;
    var _hcardGreenLine;
    var _vcardRedLine;
    var _vcardGreenLine;
    var _flyerGreenLine; 
    
    window.appURL = "http://localhost:4418/print_designer/";
    window._nhd_lastColor = '#000000';
    window._isStroke = false;
    window._isUnderLine = false; 
    window._isBold = false;
    window._isReversed = false;                      
    window._strokeLine = 1;
    window._isRounded = false;
    window._isGrid = false;
    window._isCurved = false;           
    window.isDesign = false;
    window.isMotiveDesign = false;
    window.isTextDesign = false;
    window.isCurveTextDesign = false;
    window.designJson;
    window.designCanvasFront = new fabric.Canvas('canvasFront');
    window.designCanvasBack = new fabric.Canvas('canvasBack');

    designCanvasBack.controlsAboveOverlay = true;
    
   
    fabric.Object.prototype.set({
        transparentCorners: true,
        borderColor: '#ABEA37',
        cornerColor: '#0000805+'
    });


    window.designExist=false;
    window.saveTime;    
    window.productColor;
    window.productSize;
    window.productImageFront;
    window.productImageBack;
    window.productName; 
    
    window.isFront = true;
    window.isBack = false; 
    window.loadedDesign = false;
    window.totalPrice;
    window.currentName;
    window.productCategory;
    window.productformat;
    window.fdesignGroupLeft;
    window.fdesignGroupTop;
    window.bdesignGroupLeft;
    window.bdesignGroupTop; 
    window.backgroundColorFrontIS = false;
    window.backgroundColorBackIS = false;  
    window.fbackgroundColorFrontIS = false;
    
    //window.id = 0;

    //get the items length  created on your canvas 
    window.items_len = 0;

    
    $('#curveSliderHolder').hide();
    $('#svgTextarea').hide();
    $('#fontOptions').hide();
    $('#textArea').hide();
    $('#imgArea').hide(); 6
    $('#curveOptions').hide();

    $('#addBtn').click(function () {

        _nhd_curFontSize = 30;
        var text = $('#panelTextField').val();
        var normalText = new fabric.Text(text, {
            fontFamily: 'Tahoma',
            fontSize: _nhd_curFontSize,
            left: 150,
            top: 50
        });

        if (isFront) {

            designCanvasFront.add(normalText);

            // get num of items on canvas

            items_len += 1;

                //designCanvasFront.item.length;
            console.log(items_len);
            var len = items_len;
            designCanvasFront.setActiveObject(designCanvasFront.item(len - 1));
    
            designCanvasFront.renderAll();
            designCanvasFront.calcOffset();
        }

        isDesign = true;
        $('#fontOptions').show();
        $('#curveOptions').show();

    });

    $('#showtextArea').click(function (e) {
        $('#textArea').slideToggle();
        $('#imgArea').hide();
    });

    $('#showimgArea').click(function (e) {
        $('#imgArea').slideToggle();
        $('#textArea').hide();
    });
    
    if (googleFontsCustom) {
        $('#googleFontsCustom').show();
        $('#googleFontsComplete').hide();
        $('#myFonts').change(function () {
            _nhd_curFontType = this.value;
            if (isFront) {
                var obj = designCanvasFront.getActiveObject();
                if (obj) {
                    designCanvasFront.getActiveObject().set("fontFamily", _nhd_curFontType);
                    designCanvasFront.renderAll();
                    designJson = JSON.stringify(designCanvasFront);
                }
            }
            
        })
    } else {
        $('#googleFontsCustom').hide();
        $('#googleFontsComplete').show();

        //Use Complete GoogleFonts with Preview
        $('#font').fontselect().change(function () {
                // replace + signs with spaces for css
                var font = $(this).val().replace(/\+/g, ' ');
                font = font.split(':');
                if (isFront) {
                    var obj = designCanvasFront.getActiveObject();
                    if (obj) {
                        designCanvasFront.getActiveObject().set("fontFamily", font[0]);
                        designCanvasFront.renderAll();
                        designJson = JSON.stringify(designCanvasFront);
                    }
                }
            
            });
    }
        
    $('#downloadPreview').click(function (e) {
    	
    	var mydesign = designCanvasFront.toSVG();
    	console.log(mydesign);
    	$("#svgTextarea").html(mydesign);
		
        //location.href = "action.cfm";
	
		document.lettering_form.target = "myActionWin";
		window.open("","myActionWin","width=500,height=300,toolbar=0");
		document.lettering_form.submit();
    });
	
  //var _canvasObject = new fabric.Canvas('canvas');
    //link.href = designCanvasFront.toDataURL({ format: 'png', multiplier: 4 });

    //document.getElementById("downloadPreview").addEventListener('click', downloadCanvas, false);



    //var downloadCanvas = function () {

    //    var link = document.createElement("a");

    //    link.href = designCanvasFront.toDataURL({
    //        format: 'png',
    //        left: br.left,
    //        top: br.top,
    //        width: br.width,
    //        height: br.height
    //    });

        
    //    link.download = "helloWorld.png";
    //    link.click();
    //}



//$('#previewSVG').click(function (e) {


//    window.open(canvas.toDataURL('png');
//}

    $('#previewSVG_w').click(function (e) {
        alert('hi');
        window.open(canvas.toDataURL('png'));
    });

    $('#previewSVG').click(function (e) {

        // make a new group
        var myGroup = new fabric.Group();
        designCanvasFront.add(myGroup);


        // hide borders so they don't show up on render
        fabric.Object.prototype.hasBorders = false;

        myGroup.set({
            originX: 'center',
            originY: 'center'
        });

        // put canvas things in new group
        var i = designCanvasFront.getObjects().length;
        while (i--) {
            var objType = designCanvasFront.item(i).get('type');
            if (objType === "image" || objType === "text" || objType === "itext" || objType === "rect") { // to ensure 'group' type is excluded..
                var clone = fabric.util.object.clone(designCanvasFront.item(i));
                myGroup.addWithUpdate(clone).setCoords();
                designCanvasFront.remove(designCanvasFront.item(i));
            }
        }

        // get bounding rect for new group
        var i = designCanvasFront.getObjects().length;
        while (i--) {
            var objType = designCanvasFront.item(i).get('type');
            if (objType === "group") {
                var br = designCanvasFront.item(i).getBoundingRect();
                console.log(br);
            }
        }

        fabric.log(br);

        var img = designCanvasFront.toDataURL({
            format: 'png',
            left: br.left,
            top: br.top,
            width: br.width,
            height: br.height
        });

        $("#previewImageDiv").css('width', br.width + 'px');
        $("#previewImageDiv").css('height', br.height + 'px');
        $("#previewImageDiv").html('<img src="' + img + '" style="border: 1px solid red;"/>');


        

        //window.open(canvas.toDataURL('png'));
        //window.open(img);
        
        designCanvasFront.renderAll();
    });

    
    //document.getElementById("downloadPreview").addEventListener('click', downloadCanvas, false);

    //var downloadCanvas = function () {

    //    var link = document.createElement("a");

    //    link.href = designCanvasFront.toDataURL({ format: 'png', multiplier: 4 });
    //    link.download = "helloWorld.png";
    //    link.click();
    //};

	$('#previewSVG1111').click(function (e) {
    	
		//var canvas = document.getElementById("mycanvas");
		designCanvasFront.deactivateAll().renderAll();
		var img = designCanvasFront.toDataURL("image/png");
		//create image
		$("#i").html('<img src="'+img+'"/>');
		
		//alert(img);
		//document.write('<img src="'+image+'"/>');
		//window.location.href = image;
		
    	//var myimage = designCanvasFront.toDataURL("image/png");
		//console.log(myimage);
		
		//$('#i').append($('<img/>', { src : dataURL }));
		
			/*function dlCanvas() {
			var dt = canvas.toDataURL('image/png');
			this.href = dt;
		};
		dl.addEventListener('click', dlCanvas, false);
		
		
		function download(url,name){
		// make the link. set the href and download. emulate dom click
		  $('<a>').attr({href:url,download:name})[0].click();
		}
		function downloadFabric(canvas,name){
		//  convert the canvas to a data url and download it.
		  download(canvas.toDataURL(),name+'.png');
		}
		
		*/
    });
    
    $('#addCurveBtn').click(function (e) {
    	alert('is curver ' + _isCurved);
    	
        if(isFront){
            var props = {};
            var obj = designCanvasFront.getActiveObject();
            if(obj && obj.get('type')!= 'image'){
                _isCurved = _isCurved ? false : true;
                
                if(!_isCurved) {
                    alert('not false');

                    props = obj.toObject();
                    delete props['type'];
                    var textSample = new fabric.Text(obj.getText(), props);
                    $('#'+e.currentTarget.id).text('Change To Curve');
                    $('#reverseCurveTextIcon').css('opacity','0.5');
                    $('#reverseCurveTextIcon').css('cursor', 'default');
                    $('#curveSliderHolder').hide(); 
                
                }else{
                    //curve is false
                    alert('is false');props = obj.toObject();
                    delete props['type'];
                    props['textAlign'] = 'center';
                    props['radius'] = 100;
                    props['spacing'] = 20;
                    var textSample = new fabric.Curvedtext(obj.getText(), props);
                    $('#'+e.currentTarget.id).text('Change To Normal');
                    $('#reverseCurveTextIcon').css('opacity','1');
                    $('#reverseCurveTextIcon').css('cursor', 'pointer');
                    alert('is curver ' + _isCurved);
                    $('#curveSliderHolder').show();  
                    
                }
                designCanvasFront.remove(obj);
                designCanvasFront.add(textSample).renderAll();
                designCanvasFront.setActiveObject(designCanvasFront.item(designCanvasFront.getObjects().length-1));
            }
        }
       
         
    })
    

    designCanvasFront.on('mouse:down', function(options) {  
	      //alert('hiii');
        var obj = designCanvasFront.getActiveObject();

        if(obj && obj.get('type') === 'text'){
            $('#panelTextField').val(obj.text);
            $('#addCurveBtn').text('Change To Curve');
            _isCurved = false;
            $('#reverseCurveTextIcon').css('opacity','0.5');
            $('#reverseCurveTextIcon').css('cursor', 'default');
            $('#curveSliderHolder').hide();  
        }
        if(obj && obj.get('type') === 'Curvedtext'){
            $('#panelTextField').val(obj.text);
            $('#addCurveBtn').text('Change To Normal');
            _isCurved = true;
            $('#reverseCurveTextIcon').css('opacity','1');
            $('#reverseCurveTextIcon').css('cursor', 'pointer');
            $('#curveSliderHolder').show();
            _curveSpaceSlider.slider('value',obj.spacing);
        }
    });
    


    _curveSpaceSlider.slider({
        //Config
        range: "min",
        min: 6,
        value: 20,
        max: 26,
        //Slider Event
        slide: function (event, ui) { //When the slider is sliding
            var value = _curveSpaceSlider.slider('value');
            if(isFront){
                var obj = designCanvasFront.getActiveObject();
                if(obj){
                  obj.set('spacing', value); 
                }
                designCanvasFront.renderAll();
            }
            if(isBack){
                var obj = designCanvasBack.getActiveObject();
                if(obj){
                  obj.set('spacing', value); 
                }
                designCanvasBack.renderAll();
            }            
        }
    })



    $('#resetBtn').click(function (e) {
        if(isFront){
            var obj = designCanvasFront.getActiveObject();
            if(obj){
                obj.set('scaleX','1');
                obj.set('scaleY','1');
                obj.set('angle','0');
                designCanvasFront.renderAll();
                designCanvasFront.calcOffset();           
            }
        }
             
    })

    $('#reverseCurveTextIcon').click(function (e) {
        _isReversed = _isReversed ? false : true;
        if(isFront){
            var obj = designCanvasFront.getActiveObject();
            if(obj){
               if(_isReversed){
                    obj.set('reverse',true); 
                    designCanvasFront.renderAll(); 
               }else{
                    obj.set('reverse',false); 
                    designCanvasFront.renderAll(); 
               } 
            }
        }
            
    })


    $('#strokeIcon').click(function (e) {
        _isStroke = _isStroke ? false : true;
        if(isFront){
            var obj = designCanvasFront.getActiveObject();
            if(obj){
                if(_isStroke){
                    designCanvasFront.getActiveObject().set('fill', 'transparent');
                    designCanvasFront.getActiveObject().set('stroke', _nhd_lastColor);
                    designCanvasFront.getActiveObject().set('strokeWidth', 1);
                    designCanvasFront.renderAll();  
                    designJson = JSON.stringify(designCanvasFront);
                }else{
                    designCanvasFront.getActiveObject().set('fill', _nhd_lastColor);
                    designCanvasFront.getActiveObject().set('stroke', '');
                    designCanvasFront.renderAll();  
                    designJson = JSON.stringify(designCanvasFront);
                }    
            }    
        }
        if(isBack){
            var obj = designCanvasBack.getActiveObject();
            if(obj){
                if(_isStroke){
                    designCanvasBack.getActiveObject().set('fill', 'transparent');
                    designCanvasBack.getActiveObject().set('stroke', _nhd_lastColor);
                    designCanvasBack.getActiveObject().set('strokeWidth', 1);
                    designCanvasBack.renderAll();  
                    designJson = JSON.stringify(designCanvasBack);
                }else{
                    designCanvasBack.getActiveObject().set('fill', _nhd_lastColor);
                    designCanvasBack.getActiveObject().set('stroke', '');
                    designCanvasBack.renderAll();  
                    designJson = JSON.stringify(designCanvasBack);
                }    
            }    
        }        
    })

    $('#underlineIcon').click(function (e) {
        _isUnderLine = _isUnderLine ? false : true;
        if(isFront){
            var obj = designCanvasFront.getActiveObject();
            if(obj){
                if(_isUnderLine){         
                    designCanvasFront.getActiveObject().set("textDecoration", "underline");                              
                    designCanvasFront.renderAll();  
                    designJson = JSON.stringify(designCanvasFront);     
                }else{
                    designCanvasFront.getActiveObject().set("textDecoration", "none");               
                    designCanvasFront.renderAll();  
                    designJson = JSON.stringify(designCanvasFront);
                }  

            }
        }
        if(isBack){
            var obj = designCanvasBack.getActiveObject();
            if(obj){
                if(_isUnderLine){         
                    designCanvasBack.getActiveObject().set("textDecoration", "underline");                              
                    designCanvasBack.renderAll();  
                    designJson = JSON.stringify(designCanvasBack);     
                }else{
                    designCanvasBack.getActiveObject().set("textDecoration", "none");               
                    designCanvasBack.renderAll();  
                    designJson = JSON.stringify(designCanvasBack);
                }  

            }
        }          
    })

    $('#boldIcon').click(function (e) {
        _isBold = _isBold ? false : true;
        if(isFront){
            var obj = designCanvasFront.getActiveObject();
            if(obj){
                if(_isBold){         
                    designCanvasFront.getActiveObject().set("fontWeight", "bold");                              
                    designCanvasFront.renderAll();  
                    designJson = JSON.stringify(designCanvasFront);
                }else{
                    designCanvasFront.getActiveObject().set("fontWeight", "normal");               
                    designCanvasFront.renderAll();  
                    designJson = JSON.stringify(designCanvasFront);
                }  

            } 
        }
        if(isBack){
            var obj = designCanvasBack.getActiveObject();
            if(obj){
                if(_isBold){         
                    designCanvasBack.getActiveObject().set("fontWeight", "bold");                              
                    designCanvasBack.renderAll();  
                    designJson = JSON.stringify(designCanvasBack);
                }else{
                    designCanvasBack.getActiveObject().set("fontWeight", "normal");               
                    designCanvasBack.renderAll();  
                    designJson = JSON.stringify(designCanvasBack);
                }  

            } 
        }            
    })

    $('#deleteElementBtn').click(function () {
        if(isFront){
            var obj = designCanvasFront.getActiveObject();
            if(obj){
                designCanvasFront.remove(designCanvasFront.getActiveObject());

                items_len -= 1;
                console.log(items_len);
               


                designJson = JSON.stringify(designCanvasFront);
               
            }
        }    
    })
    
    $('#deleteDesign').click(function (e) {
        if(confirm("Are you sure to delete all Designs?")){
            designCanvasFront.clear();                      
            designJson = JSON.stringify(designCanvasFront);
            designCanvasBack.clear();                  
            if(window.productImageFront != ""){
                designCanvasFront.setBackgroundImage(window.productImageFront, designCanvasFront.renderAll.bind(designCanvasFront));
            }
            if(window.productImageBack != ""){
                designCanvasBack.setBackgroundImage(window.productImageBack, designCanvasBack.renderAll.bind(designCanvasBack));
            }
            window.backgroundImageFrontIS = false;
            window.backgroundImageBackIS = false;  
            window.backgroundColorFrontIS = false;
            window.backgroundColorBackIS = false; 
            window.fbackgroundImageFrontIS = false;
            window.fbackgroundColorFrontIS = false;           
            $('#deleteBackgroundImage').hide();
            designJson = JSON.stringify(designCanvasBack);    
            $('#priceView').text(Number(productPrice).toFixed(2)+window.currencySign);
            window.totalPrice = window.productPrice;
            
            initProductImage();   
        }else{
            // do nothing
        }

    })

    $('#gridBtn').click(function (e) {
        _isGrid = _isGrid ? false : true;
        var grid = 20;
        if(_isGrid){
            createGrid();
        }else{
            removeGrid();
        }    
    })

    function createGrid(){
        if(isFront){
            var width = designCanvasFront.width;
            var height = designCanvasFront.height;
        }
        if(isBack){
            var width = designCanvasBack.width;
            var height = designCanvasBack.height;
        }            
        var j = 0;
        var line = null;
        var rect = [];
        var size = 20;
        for (var i = 0; i < Math.ceil(width / 20); ++i) {
            rect[0] = i * size;
            rect[1] = 0;
            rect[2] = i * size;
            rect[3] = height;
            line = null;
            line = new fabric.Line(rect, {
                stroke: '#eaeaea'
            });
            line.selectable = false;
            if(isFront){
                designCanvasFront.add(line);
            }
            if(isBack){
                designCanvasBack.add(line);
            } 
            line.sendToBack();
        }
        for (i = 0; i < Math.ceil(height / 20); ++i) {
            rect[0] = 0;
            rect[1] = i * size;
            rect[2] = width;
            rect[3] = i * size;
            line = null;
            line = new fabric.Line(rect, {
                stroke: '#eaeaea'
            });
            line.selectable = false;
            if(isFront){
                designCanvasFront.add(line);
            }
            if(isBack){
                designCanvasBack.add(line);
            }            
            line.sendToBack();
        } 
        if(isFront){
            designCanvasFront.renderAll();
        }
        if(isBack){
            designCanvasBack.renderAll();
        }         
    }

    function removeGrid() {
        if (isFront) {
            var canObject = new Array();
            canObject = designCanvasFront.getObjects();
            while (true) {
                for (var i = 0; i < canObject.length; i++) {
                    if (designCanvasFront.item(i).type == 'line') {
                        designCanvasFront.item(i).remove();
                        designCanvasFront.renderAll();
                    }
                }
                designCanvasFront.renderAll();
                canObject = designCanvasFront.getObjects();
                var lineStatus = false;
                for (var i = 0; i < canObject.length; i++) {
                    if (designCanvasFront.item(i).type == 'line') {
                        lineStatus = true;
                    }
                }
                if (lineStatus) {
                    canObject = designCanvasFront.getObjects();
                    continue;
                } else {
                    break;
                }
            }
        }
        
    }


    $('#colorIcon').click(function () {
        _nhd_move = false;
        $('#colorTextHolder').show();
    })

    $('#colorTextHolder').mouseover(function () {
        _nhd_changeBG = false;
    })

    $('#increaseZIndex').click(function () {
        var value = _curveSpaceSlider.slider('value');
        if(isFront){
            var obj = designCanvasFront.getActiveObject();
            if(obj){
              obj.bringToFront();
            }
            designCanvasFront.renderAll();            
        }
        if(isBack){
            var obj = designCanvasBack.getActiveObject();
            if(obj){
              obj.bringToFront();
            }
            designCanvasBack.renderAll();            
        }        
    })

    $('#decreaseZIndex').click(function () {
        var value = _curveSpaceSlider.slider('value');
        if(isFront){
            var obj = designCanvasFront.getActiveObject();
            if(obj){
              obj.sendBackwards();
            }
            designCanvasFront.renderAll();
        }
        if(isBack){
            var obj = designCanvasBack.getActiveObject();
            if(obj){
              obj.sendBackwards();
            }
            designCanvasBack.renderAll();
        }        
    })

    $('.TextColorPicker').TextColorPicker();

    $('.BackgroundColorPicker').BackgroundColorPicker();

    $('#startBtn').click(function () {
        $('#tc').prop('checked', false); 
        if($('#curLoadDesignName').val() !== ""){
            window.currentName = $('#curLoadDesignName').val();
            if(isChecking){
                startApp();
            }
        }else{
            $('#curLoadDesignName').addClass('error');
            isChecking = true;
        }
    })
   
    $('.appStart, .loadAppStart').click(function () {
        //$('#curDesignName').val('');
    });

    $('#tc').change(function(e){
        if(this.checked){
            $('#uploadMotiveInput').css('width','100%');
            $('#uploadMotiveInput').css('height','100%');
            $('#uploadMotive').css('opacity','1');
        }else{
            $('#uploadMotiveInput').css('width','1px');
            $('#uploadMotiveInput').css('height','1px');
            $('#uploadMotive').css('opacity','0.5');
        }
    });

    $('#panelTextField').keyup(function (e) {
        if(isFront){
            var obj = designCanvasFront.getActiveObject();
            if(obj && obj.get('type') === 'text'){
                obj.set({ text: $('#panelTextField').val() }); 
                designCanvasFront.renderAll();
            }
            if(obj && obj.get('type') === 'Curvedtext'){
                obj.setText($('#panelTextField').val());
                designCanvasFront.renderAll();
            } 
        } 
                      
    });




});


$(function () {
    canvas = new fabric.Canvas('c');
    canvas.on('selection:cleared', onDeSelected);
    canvas.on('object:selected', onSelected);
    canvas.on('selection:created', onSelected);
    var addCurveBtndText = new fabric.CurvedText('CurvedText', {
        //        width: 100,
        //        height: 50,
        left: 100,
        top: 100,
        textAlign: 'center',
        fill: '#0000FF',
        radius: 50,
        fontSize: 20,
        spacing: 20
        //        fontFamily: 'Arial'
    });
    canvas.add(CurvedText).renderAll();
    canvas.setActiveObject(canvas.item(canvas.getObjects().length - 1));
    $('#text').keyup(function () {
        var obj = canvas.getActiveObject();
        if (obj) {
            obj.setText(this.value);
            canvas.renderAll();
        }
    });
    $('#reverse').click(function () {
        var obj = canvas.getActiveObject();
        if (obj) {
            obj.set('reverse', $(this).is(':checked'));
            canvas.renderAll();
        }
    });
    $('#radius, #spacing, #fill').change(function () {
        var obj = canvas.getActiveObject();
        if (obj) {
            obj.set($(this).attr('id'), $(this).val());
        }
        canvas.renderAll();
    });
    $('#radius, #spacing, #effect').change(function () {
        var obj = canvas.getActiveObject();
        if (obj) {
            obj.set($(this).attr('id'), $(this).val());
        }
        canvas.renderAll();
    });
    $('#fill').change(function () {
        var obj = canvas.getActiveObject();
        if (obj) {
            obj.setFill($(this).val());
        }
        canvas.renderAll();
    });
    $('#convert').click(function () {
        var props = {};
        var obj = canvas.getActiveObject();
        if (obj) {
            if (/curvedText/.test(obj.type)) {
                default_text = obj.getText();
                props = obj.toObject();
                delete props['type'];
                var textSample = new fabric.Text(default_text, props);
            } else if (/text/.test(obj.type)) {
                default_text = obj.getText();
                props = obj.toObject();
                delete props['type'];
                props['textAlign'] = 'center';
                props['radius'] = 50;
                props['spacing'] = 20;
                var textSample = new fabric.CurvedText(default_text, props);
            }
            canvas.remove(obj);
            canvas.add(textSample).renderAll();
            canvas.setActiveObject(canvas.item(canvas.getObjects().length - 1));
        }
    });
});
function onSelected() {
    var obj = canvas.getActiveObject();
    $('#text').val(obj.getText());
    $('#reverse').prop('checked', obj.get('reverse'));
    $('#radius').val(obj.get('radius'));
    $('#spacing').val(obj.get('spacing'));
    $('#fill').val(obj.getFill());
    $('#effect').val(obj.getEffect());
}
function onDeSelected() {
    $('#text').val('');
    $('#reverse').prop('checked', false);
    $('#radius').val(50);
    $('#spacing').val(20);
    $('#fill').val('#0000FF');
    $('#effect').val('curved');
}