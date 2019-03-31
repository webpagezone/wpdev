$(function () {
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
    
   
    
    $('#curveSliderHolder').hide();
    $('#svgTextarea').hide();
    
    //for test
   //$('#testfont').fontselect();

    $('#myFonts').change(function () {
        _nhd_curFontType = this.value;
        if(isFront){
            var obj = designCanvasFront.getActiveObject();
            if(obj){
                designCanvasFront.getActiveObject().set("fontFamily", _nhd_curFontType);
                designCanvasFront.renderAll();  
                designJson = JSON.stringify(designCanvasFront);
            }
        }
                
    });
        
    

  
    $('#saveBtntoSVG').click(function (e) {
    	
    	var mydesign = designCanvasFront.toSVG();
    	console.log(mydesign);
    	$("#svgTextarea").html(mydesign);
    	document.lettering_form.submit();
    });
	
	 $('#previewSVG').click(function (e) {9
    	
    	var myimage = designCanvasFront.toDataURL("image/png");
		console.log(myimage);
		
		$('#i').append($('<img/>', { src : dataURL }));
    });
	
	
    
    $('#addBtn').click(function () {
    	
        _nhd_curFontSize = 30;
        var text = $('#panelTextField').val();
        var normalText =  new fabric.Text(text, {
            fontFamily: 'Tahoma',
            fontSize: _nhd_curFontSize,
            left:150,
            top:50
        });
        
        if(isFront){
            designCanvasFront.add(normalText);
            designCanvasFront.renderAll();
            designCanvasFront.calcOffset();           
        }

        isDesign = true;
    });
    


    designCanvasFront.on('mouse:down', function(options) {        
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



  

    $('#addCurveBtn').click(function (e) {
    	//alert('is curver ' + _isCurved);
    	
        if(isFront){
            var props = {};
            var obj = designCanvasFront.getActiveObject();
            if(obj && obj.get('type')!= 'image'){
                _isCurved = _isCurved ? false : true;
                
                if(!_isCurved) {

                	props = obj.toObject();
                    delete props['type'];
                    var textSample = new fabric.Text(obj.getText(), props);
                    $('#'+e.currentTarget.id).text('Change To Curve');
                    $('#reverseCurveTextIcon').css('opacity','0.5');
                    $('#reverseCurveTextIcon').css('cursor', 'default');
                    $('#curveSliderHolder').hide(); 
                
                }else{
                	
                    props = obj.toObject();
                    delete props['type'];
                    props['textAlign'] = 'center';
                    props['radius'] = 100;
                    props['spacing'] = 20;
                    var textSample = new fabric.Curvedtext(obj.getText(), props);
                    $('#'+e.currentTarget.id).text('Change To Normal');
                    $('#reverseCurveTextIcon').css('opacity','1');
                    $('#reverseCurveTextIcon').css('cursor', 'pointer');
                    //alert('is curver ' + _isCurved);
                    $('#curveSliderHolder').show();  
                    
                }
                designCanvasFront.remove(obj);
                designCanvasFront.add(textSample).renderAll();
                designCanvasFront.setActiveObject(designCanvasFront.item(designCanvasFront.getObjects().length-1));
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
                designJson = JSON.stringify(designCanvasFront);
                if(obj.get('type')!= 'image'){
                    window.totalPrice = parseFloat(window.totalPrice)-parseFloat(window.textPrice);
                    $('#priceView').text(totalPrice.toFixed(2)+currencySign);  
                }else{
                    window.totalPrice = parseFloat(window.totalPrice)-parseFloat(window.motivePrice);
                    $('#priceView').text(totalPrice.toFixed(2)+currencySign);  
                }
            }
        }
        if(isBack){
            var obj = designCanvasBack.getActiveObject();
            if(obj){
                designCanvasBack.remove(designCanvasBack.getActiveObject());
                designJson = JSON.stringify(designCanvasBack);
                if(obj.get('type')!= 'image'){
                    totalPrice = parseFloat(window.totalPrice)-parseFloat(window.textPrice);
                    $('#priceView').text(window.totalPrice.toFixed(2)+currencySign);  
                }else{
                    totalPrice = parseFloat(window.totalPrice)-parseFloat(window.motivePrice);
                    $('#priceView').text(window.totalPrice.toFixed(2)+currencySign);  
                }
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

    function removeGrid(){
        if(isFront){
            var canObject = new Array();
            canObject = designCanvasFront.getObjects();
            while(true){
                for(var i = 0;i<canObject.length;i++){
                   if(designCanvasFront.item(i).type == 'line'){
                        designCanvasFront.item(i).remove();
                     designCanvasFront.renderAll();
                    }
                }
                designCanvasFront.renderAll();
                canObject = designCanvasFront.getObjects();
                var lineStatus = false;
                for(var i = 0;i<canObject.length;i++){
                    if(designCanvasFront.item(i).type == 'line'){
                    lineStatus = true;
                    }
                }
                if(lineStatus){
                    canObject = designCanvasFront.getObjects();
                    continue;
                }else{
                    break;
                }       
            }
        }
        if(isBack){
            var canObject = new Array();
            canObject = designCanvasBack.getObjects();
            while(true){
                for(var i = 0;i<canObject.length;i++){
                   if(designCanvasBack.item(i).type == 'line'){
                        designCanvasBack.item(i).remove();
                     designCanvasBack.renderAll();
                    }
                }
                designCanvasBack.renderAll();
                canObject = designCanvasBack.getObjects();
                var lineStatus = false;
                for(var i = 0;i<canObject.length;i++){
                    if(designCanvasBack.item(i).type == 'line'){
                    lineStatus = true;
                    }
                }
                if(lineStatus){
                    canObject = designCanvasBack.getObjects();
                    continue;
                }else{
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
        if(isBack){
            var obj = designCanvasBack.getActiveObject();
            if(obj && obj.get('type') === 'text'){
                obj.set({ text: $('#panelTextField').val() }); 
                designCanvasBack.renderAll();
            }
            if(obj && obj.get('type') === 'Curvedtext'){
                obj.setText($('#panelTextField').val());
                designCanvasBack.renderAll();
            } 
        }               
    });
});