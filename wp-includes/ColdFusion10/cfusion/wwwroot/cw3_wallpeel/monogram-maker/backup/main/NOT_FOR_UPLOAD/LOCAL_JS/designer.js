$(function () {
    var _curveSpaceSlider = $('#curveSpaceSlider');
    var designSaved = false;
    var isPrint = true;
    var _curDesignName;
    var _curFrontDesignURL;
    var _curBackDesignURL;    
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

    if(googleFontsCustom){
    $('#googleFontsCustom').show();
    $('#googleFontsComplete').hide();
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
        if(isBack){
            var obj = designCanvasBack.getActiveObject();
            if(obj){
                designCanvasBack.getActiveObject().set("fontFamily", _nhd_curFontType);
                designCanvasBack.renderAll();  
                designJson = JSON.stringify(designCanvasBack);
            }
        }        
    })
    }else{
    $('#googleFontsCustom').hide();
    $('#googleFontsComplete').show();        
    //Use Complete GoogleFonts with Preview
    $('#font').fontselect().change(function(){
      // replace + signs with spaces for css
      var font = $(this).val().replace(/\+/g, ' ');
      font = font.split(':');
        if(isFront){
            var obj = designCanvasFront.getActiveObject();
            if(obj){
                designCanvasFront.getActiveObject().set("fontFamily", font[0]);
                designCanvasFront.renderAll();  
                designJson = JSON.stringify(designCanvasFront);
            }
        }
        if(isBack){
            var obj = designCanvasBack.getActiveObject();
            if(obj){
                designCanvasBack.getActiveObject().set("fontFamily", font[0]);
                designCanvasBack.renderAll();  
                designJson = JSON.stringify(designCanvasBack);
            }
        }             
    });
    }
    
    function BusinessCardHLimitLines(){
        _hcardRedLine = new fabric.Rect({ 
            width: 560, 
            height: 320, 
            left: 300, 
            top: 300, 
            fill:'transparent',
            hasBorders:true,
            stroke: '#ff0000',
            strokeWidth : 1,
            selectable:false
        });
        _hcardGreenLine = new fabric.Rect({
            width: 520, 
            height: 280, 
            left: 300, 
            top: 300, 
            fill:'transparent',
            hasBorders:true,
            stroke: '#125906',
            strokeWidth : 1,
            selectable:false
        });

        designCanvasFront.add(_hcardRedLine);
        designCanvasFront.add(_hcardGreenLine);
        designCanvasFront.renderAll();

        designCanvasBack.add(_hcardRedLine);
        designCanvasBack.add(_hcardGreenLine);
        designCanvasBack.renderAll();
    }
    function BusinessCardVLimitLines(){
        _vcardRedLine = new fabric.Rect({ 
            width: 320, 
            height: 560, 
            left: 300, 
            top: 300, 
            fill:'transparent',
            hasBorders:true,
            stroke: '#ff0000',
            strokeWidth : 1,
            selectable:false
        });
        _vcardGreenLine = new fabric.Rect({
            width:280, 
            height: 520, 
            left: 300, 
            top: 300, 
            fill:'transparent',
            hasBorders:true,
            stroke: '#125906',
            strokeWidth : 1,
            selectable:false
        });
        designCanvasFront.add(_vcardRedLine);
        designCanvasFront.add(_vcardGreenLine);
        designCanvasFront.renderAll();
        designCanvasFront.calcOffset();
        designCanvasBack.add(_vcardRedLine);
        designCanvasBack.add(_vcardGreenLine);
        designCanvasBack.renderAll();
        designCanvasBack.calcOffset();
    } 

    function FlyerLimitLines(){
        _flyerGreenLine = new fabric.Rect({
            width:420, 
            height: 594, 
            left: 300, 
            top: 298, 
            fill:'transparent',
            hasBorders:true,
            stroke: '#125906',
            strokeWidth : 1,
            selectable:false
        });
        designCanvasFront.add(_flyerGreenLine);
        designCanvasBack.renderAll();
        designCanvasBack.calcOffset();
    } 

    function initProductImage(){    
        if((window.productCategory === "BusinessCard") && (window.productFormat ==="H")){
            BusinessCardHLimitLines();
        }
        if((window.productCategory === "BusinessCard") && (window.productFormat ==="V")){
            BusinessCardVLimitLines();
        }  
        if(window.productCategory === "Flyer"){
            FlyerLimitLines();
        }        
        if(window.productImageFront != ""){
            designCanvasFront.setBackgroundImage(window.productImageFront, designCanvasFront.renderAll.bind(designCanvasFront));
            $('#frontView').empty();
            $('#frontView').append('<img src="'+window.productImageFront+'" width=70 height=70 />');          
        }
        if(window.productImageBack != ""){
            designCanvasBack.setBackgroundImage(window.productImageBack, designCanvasBack.renderAll.bind(designCanvasBack));
            $('#backView').empty();
            $('#backView').append('<img src="'+window.productImageBack+'" width=70 height=70 />');           
        }
    }

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
    })

    designCanvasBack.on('mouse:down', function(options) {
        var obj = designCanvasBack.getActiveObject();
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
        }
    })

    $('#frontView').click(function () {
        $('#canvasFront').show();
        $('#canvasBack').hide();
        isFront = true;
        isBack = false;
        $(".canvas-container:first").show();
        designCanvasFront.deactivateAll().renderAll();
        designCanvasBack.deactivateAll().renderAll();
        designCanvasFront.calcOffset();
    });

    $('#backView').click(function () {
        designCanvasFront.deactivateAll().renderAll();
        designCanvasBack.deactivateAll().renderAll();
        $('#canvasFront').hide();
        $('#canvasBack').show();
        isFront = false;
        isBack =true;     
        $(".canvas-container:first").hide();
        designCanvasBack.calcOffset();
    })

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

    function loadFrontDesign(){
        $.ajax({
            url: "./orders/"+currentName+"/infos.xml",
            type: "POST",
            dataType:"text xml",
            success: function(xml) {
                $(xml).find('info').each(function(e, i)
                {
                    window.totalPrice = $(i).attr("designPrice");
                    window.productPrice = $(i).attr("productPrice");
                    window.productName = $(i).attr("productName");
                    window.productCategory = $(i).attr("productCategory");
                    window.productFormat = $(i).attr("productFormat");
                    $('#orderName').val($(i).attr("name"));
                    $('#userAddress').val($(i).attr("address"));
                    $('#userEmail').val($(i).attr("email"));
                    $('#priceView').text(Number(window.totalPrice).toFixed(2)+currencySign);  
                    $('#priceView').show();   
                    $('#backBtnProductDesign').hide();  
                    if($(i).attr("productBIMGF") === 'true'){
                        window.backgroundImageFrontIS = true;
                        $('#deleteBackgroundImage').show();
                    }
                    if($(i).attr("productBIMGB") === 'true'){
                        window.backgroundImageBackIS = true;
                        $('#deleteBackgroundImage').show();
                    } 
                    if($(i).attr("productBCF") === 'true'){
                        window.backgroundColorFrontIS = true;
                        $('#deleteBackgroundImage').show();
                    } 
                    if($(i).attr("productBCB") === 'true'){
                        window.backgroundColorBackIS = true;
                        $('#deleteBackgroundImage').show();
                    } 
                    if($(i).attr("productFBCB") === 'true'){
                        window.fbackgroundColorBackIS = true;
                        $('#deleteBackgroundImage').show();
                    }
                    if($(i).attr("productFBIMGB") === 'true'){
                        window.fbackgroundImageFrontIS = true;
                        $('#deleteBackgroundImage').show();
                    }  
                    if($(i).attr("productImageFront") !== ''){
                        window.productImageFront = $(i).attr("productImageFront");
                    } 
                    if($(i).attr("productImageBack") !== ''){
                        window.productImageBack = $(i).attr("productImageBack");
                    }                                                                                   
                    if((window.productCategory === "BusinessCard") || (window.productCategory === "Flyer")){
                        $('#colorBackgroundHolder').show();
                        if(window.productFormat === "V"){
                            $('#backgroundsVHolder').show();
                            $('#backgroundsHHolder').hide();
                        }else{
                            $('#backgroundsHHolder').show();
                            $('#backgroundsVHolder').hide();
                        }
                    }                                                                   
                })
            }    
        })

        $('#frontView').append('<img src="./orders/'+currentName+"/"+currentName+'_front.png" width=70 height=70 />');
        $('#frontView').show();
        $.ajax({
            dataType: 'json',
            success: function(data) {
                $('.preloader').hide();
                designCanvasFront.loadFromJSON(data);
                designCanvasFront.renderAll();
                designCanvasFront.calcOffset();
            },
            url: './orders/'+currentName+'/'+currentName+'_front.json'
        })
    }

    function loadBackDesign(){
        $('#backView').append('<img src="./orders/'+currentName+"/"+currentName+'_back.png" width=70 height=70 />');
        $('#backView').show();
        $.ajax({
            dataType: 'json',
            success: function(data) {
                $('.preloader').hide();
                designCanvasBack.loadFromJSON(data);
                designCanvasBack.renderAll();
                designCanvasBack.calcOffset();
            },
            url: './orders/'+currentName+'/'+currentName+'_back.json'
        })
    }

    $('#addCurveBtn').click(function (e) {
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
                    $('#curveSliderHolder').show();  
                }
                designCanvasFront.remove(obj);
                designCanvasFront.add(textSample).renderAll();
                designCanvasFront.setActiveObject(designCanvasFront.item(designCanvasFront.getObjects().length-1));
            }
        }
        if(isBack){
            var props = {};
            var obj = designCanvasBack.getActiveObject();
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
                    $('#curveSliderHolder').show(); 
                }
                designCanvasBack.remove(obj);
                designCanvasBack.add(textSample).renderAll();
                designCanvasBack.setActiveObject(designCanvasBack.item(designCanvasBack.getObjects().length-1));
            }
        }        
    })

    $('#addQRBtn').click(function () {
        if($('#panelTextField').val() !== ""){
            var text = $('#panelTextField').val();
            var size = 300;
            var side;
            var src; 
            var qrName;
            $('#qrHolder').empty();
            $('#qrHolder').css('left',Math.floor($( window ).width()*0.5)+'px');
            $('#blockArea').fadeIn();
            $('#qrHolder').qrcode({
                render: 'canvas',
                width: size,
                height: size,
                text: text,
                background: 'transparent',
                foreground: _nhd_lastColor
            });
            if(window.saveTime === undefined){
                window.saveTime = $.now();
            }
            if(!designExist){
                curName = currentName+saveTime;
            }else{
                curName = currentName;
            }
            qrName = $.now();
            $('#qrHolder').html2canvas({
                onrendered: function (canvas) {
                    var img = canvas.toDataURL("image/png");
                    //localStorage['lastImgURI'] = canvas.toDataURL("image/png");                      
                    $.ajax({
                        url: 'saveFiles/qr.php',
                        type: "POST",
                        data: ({
                            data: img,
                            curDesignName: curName,
                            curSide : side,
                            curWidth : size,
                            curQRName: qrName
                        }),
                        success: function (data) {
                            src = './orders/'+curName+"/"+qrName+'_QR.png';
                            $('#qrHolder').empty();
                            $('#blockArea').fadeOut();
                            fabric.Image.fromURL(src, function(img) {
                                var oImg = img.set({ left: 300, top: 300, width:280, height:280});
                                if(isFront){
                                    designCanvasFront.add(oImg);  
                                    //oImg.lockScalingX = oImg.lockScalingY = oImg.lockRotation = true;      
                                    designCanvasFront.renderAll();
                                    designCanvasFront.calcOffset();
                                    window.totalPrice = parseFloat(window.totalPrice)+parseFloat(window.motivePrice);
                                    $('#priceView').text(totalPrice.toFixed(2)+currencySign); 
                                }
                                if(isBack){
                                    designCanvasBack.add(oImg);  
                                    //oImg.lockScalingX = oImg.lockScalingY = oImg.lockRotation = true;            
                                    designCanvasBack.renderAll();
                                    designCanvasBack.calcOffset();
                                    window.totalPrice = parseFloat(window.totalPrice)+parseFloat(window.motivePrice);
                                    $('#priceView').text(totalPrice.toFixed(2)+currencySign); 
                                }            
                                activeMode();
                                isDesign = true;         
                            }); 

                        }
                    })
                },
                background: undefined
            })         
        }
    })

    $('#addBtn').click(function () {
            _nhd_curFontSize = 30;
            var text = $('#panelTextField').val();
            var normalText =  new fabric.Text(text, {
                fontFamily: 'Tahoma',
                fontSize: _nhd_curFontSize,
                left:280,
                top:200
            });
            if(isFront){
                designCanvasFront.add(normalText);
                designCanvasFront.renderAll();
                designCanvasFront.calcOffset();
                window.totalPrice = parseFloat(window.totalPrice)+parseFloat(window.textPrice);
                $('#priceView').text(totalPrice.toFixed(2)+currencySign);            
            }
            if(isBack){
                designCanvasBack.add(normalText);
                designCanvasBack.renderAll();
                designCanvasBack.calcOffset();
                window.totalPrice = parseFloat(window.totalPrice)+parseFloat(window.textPrice);
                $('#priceView').text(window.totalPrice.toFixed(2)+currencySign);                                 
            }                   
            activeMode();
            isDesign = true;
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
        if(isBack){
            var obj = designCanvasBack.getActiveObject();
            if(obj){
                obj.set('scaleX','1');
                obj.set('scaleY','1');
                obj.set('angle','0');
                designCanvasBack.renderAll();
                designCanvasBack.calcOffset();           
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
        if(isBack){
            var obj = designCanvasBack.getActiveObject();
            if(obj){
               if(_isReversed){
                    obj.set('reverse',true); 
                    designCanvasBack.renderAll(); 
               }else{
                    obj.set('reverse',false); 
                    designCanvasBack.renderAll(); 
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
            inactiveMode();
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

    function activeMode(){
        $('#saveBtn').css('opacity','1');
        $('#saveBtn').css('cursor', 'pointer');        
        $('#deleteDesign').css('opacity','1');
        $('#deleteDesign').css('cursor', 'pointer'); 
        $('#previewBtn').css('opacity','1');
        $('#previewBtn').css('cursor', 'pointer');
        $('#orderBtn').css('opacity','1');
        $('#orderBtn').css('cursor', 'pointer');
        $('#formBtn').css('opacity','1');
        $('#formBtn').css('cursor', 'pointer');           
    }

    function inactiveMode(){
        $('#saveBtn').css('opacity','0.5');
        $('#saveBtn').css('cursor', 'default');       
        $('#deleteDesign').css('opacity','0.5');
        $('#deleteDesign').css('cursor', 'default'); 
        $('#previewBtn').css('opacity','0.5');
        $('#previewBtn').css('cursor', 'default');
        $('#shareBtn').css('opacity','0.5');
        $('#shareBtn').css('cursor', 'default');
        $('#printBtn').css('opacity','0.5');
        $('#printBtn').css('cursor', 'default');        
        $('#formBtn').css('opacity','0.5');
        $('#formBtn').css('cursor', 'default');                   
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

    window.startApp = function() {
        $('#container').css('height','1000px');   
        isChecking = false;
        isDesign = true;
        $('#productDetailsContainer').hide();
        totalPrice = window.productPrice;
        $('#priceView').text(window.totalPrice+window.currencySign);
        _curFrontDesignURL = '../orders/'+currentName+'/'+currentName+'_front.json';       
        $.ajax({
            type : 'POST',
            url : 'checkFiles/checkFrontDesign.php',     
            data: {
                dfurl : _curFrontDesignURL
            },
            success:function (data) {
                if(data === 'true'){
                    loadFrontDesign();
                    $('.preloader').show();
                    designExist = true;
                    activeMode();
                    designSaved = true;
                    
                    isChecking = true;                 
                    $('#startBtn').hide();     
                    $('#productsHolder').hide();  
                    $('#logInPanel').hide();
                    $('#panelArea').show();
                    $('#addCurveBtn').show();          
                    $('#designArea').show(); 
                    $('#controlPanelHolder').show();
                    $('#motivesHolder').show();
                    $('#uploadMotive').show();        
                    $('#panelArea').show();
                    $('#panelTextFieldHolder').show();
                    $('#productHolder').show();             
                    $('#addBtn').show();
                    $('#shareBtn').css('opacity','1');
                    $('#shareBtn').css('cursor', 'pointer');
                    $('#printBtn').css('opacity','1');
                    $('#printBtn').css('cursor', 'pointer'); 
                    $('#curDesignName').removeClass('error');                            
                    // check for BackSide Design
                    _curBackDesignURL = '../orders/'+currentName+'/'+currentName+'_back.json';       
                    $.ajax({
                        type : 'POST',
                        url : 'checkFiles/checkBackDesign.php',     
                        data: {
                            dburl : _curBackDesignURL
                        },
                        success:function (data) {
                            if(data === 'true'){
                                loadBackDesign();
                            }else{
                                window.productImageBack = "";
                            }
                        }    
                    })                                             
                }else{
                    isChecking = true;
                    if(!loadedDesign){
                        normalInit();
                        _normalInit = true;
                        $('#priceView').show();
                    }else{
                        $('#curDesignName').addClass('error');
                        $('#curLoadDesignName').addClass('error');
                    }
                }
            }
        })
    }

    function normalInit(){
        _curDesignURL = 'orders/'+currentName+'/'+currentName+'.json';     
        initProductImage();       
        $('#frontView').show();
        if(window.productImageBack != ""){
            $('#backView').show(); 
        }else{
            $('#backView').hide(); 
        }
        $('#startBtn').hide();     
        $('#productsHolder').hide();  
        $('#logInPanel').hide();
        $('#panelArea').show();
        $('#addCurveBtn').show();          
        $('#designArea').show(); 
        $('#controlPanelHolder').show();
        $('#motivesHolder').show();
        $('#uploadMotive').show();        
        $('#panelArea').show();
        $('#panelTextFieldHolder').show();
        $('#productHolder').show();             
        $('#addBtn').show();
        $('#shareBtn').css('opacity','0.5');
        $('#shareBtn').css('cursor', 'default');             
    }

    $('#printBtn').click(function (e) {     
        if(designSaved && isPrint){
            isPrint = false;
            $('#blockArea').show();
            designCanvasFront.deactivateAll().renderAll();
            if(window.saveTime === undefined){
                window.saveTime = $.now();
            }
            if(!designExist){
                curName = currentName+saveTime;
            }else{
                curName = currentName;
            }   
            if(_isGrid){
                removeGrid();
            }                   
            $('#designArea').html2canvas({
                onrendered: function (canvas) {
                    var img = canvas.toDataURL("image/png");
                    //localStorage['lastImgURI'] = canvas.toDataURL("image/png");                      
                    $.ajax({
                        url: 'share.php',
                        type: "POST",
                        data: ({
                            data: img,
                            curDesignName: curName
                        }),
                        success: function (data) {
                            $('#printResult').empty();
                            $('#printResult').append('<img width="572" height="603" src="./orders/'+curName+'/fb/'+data+'"/>');
                            $('#printResult').printThis({pageTitle:'JS_Designer_2014'});
                            isPrint = true;
                            $('#blockArea').fadeOut();
                        },
                        error: function (data) {
                            designSaved = false;
                        }
                    })
                }
            })          
        }       
    })

    $('#shareBtn').click(function (e) {     
        if(designSaved){
            $('#blockArea').show();
            designCanvasFront.deactivateAll().renderAll();
            if(window.saveTime === undefined){
                window.saveTime = $.now();
            }
            if(!designExist){
                curName = currentName+saveTime;
            }else{
                curName = currentName;
            }   
            if(_isGrid){
                removeGrid();
            }                   
            $('#designArea').html2canvas({
                onrendered: function (canvas) {
                    var img = canvas.toDataURL("image/png");
                    //localStorage['lastImgURI'] = canvas.toDataURL("image/png");                      
                    $.ajax({
                        url: 'share.php',
                        type: "POST",
                        data: ({
                            data: img,
                            curDesignName: curName
                        }),
                        success: function (data) {
                            var curURL = appURL+'/orders/'+curName+'/fb/'+data.replace('.png','')+'.html';
                            window.open('http://www.facebook.com/sharer.php?u='+curURL, '', 'width=600,height=480');
                            $('#blockArea').fadeOut();
                        },
                        error: function (data) {
                            designSaved = false;
                        }
                    })
                }
            })          
        }       
    })

    $('#formBtn').click(function () {
        saveTempDesign();
        designCanvasFront.deactivateAll().renderAll();
        $('#orderForm').show();
    })

    function saveTempDesign(){
        designCanvasFront.deactivateAll().renderAll();
        if(window.saveTime === undefined){
            window.saveTime = $.now();
        }
        if(!designExist){
            curName = currentName+window.saveTime;
        }else{
            curName = currentName;
        }
        if(_isGrid){
            removeGrid();
        }  
    }

    $('#closeForm').click(function () {
        $('#orderForm').hide();
    })

    $('.appStart, .loadAppStart').click(function () {
        //$('#curDesignName').val('');
    })

    $('#orderBtn, #saveBtn').click(function (e) {
        if(isDesign){
            if ($('#orderName').val() !== "") {
                $('#orderName').removeClass('error');
                if ($('#userAddress').val() !== "") {
                    $('#userAddress').removeClass('error');
                    switch(e.currentTarget.id){
                        case "saveBtn":
                        if(window.productImageBack != ""){
                            saveBothSide('saveFiles/saveBothSideInfos.php',false);
                        }else{
                            saveFrontSide('saveFiles/saveFrontInfos.php',false);
                        }
                        break;
                        case "orderBtn":
                        if(window.productImageBack != ""){
                            saveBothSide('saveFiles/saveBothSideInfos.php',false);
                            saveBothSide('saveFiles/saveBothSidenoEmail.php',true);
                        }else{
                            saveFrontSide('saveFiles/saveFrontInfos.php',false);
                            saveFrontSide('saveFiles/savenoEmailFront.php',true);
                        }
                        break;                        
                    }
                } 
                else {
                    $('#userAddress').addClass('error');
                }
            } else {
                $('#orderName').addClass('error');
            }
        }
    })

    function saveBothSide(_url,_order) {
        if ($('#userEmail').val() != "") {
                if((window.productCategory === "BusinessCard") && (window.productFormat ==="H")){
                    fdesignGroupLeft = 300;
                    fdesignGroupTop = 300;
                    bdesignGroupLeft = 300;
                    bdesignGroupTop = 300;                    
                    //console.log('FLeft: '+fdesignGroupLeft, 'FTop: '+fdesignGroupTop);  
                    //console.log('BLeft: '+bdesignGroupLeft, 'BTop: '+bdesignGroupTop); 
                }
                if((window.productCategory === "BusinessCard") && (window.productFormat ==="V")){
                    fdesignGroupLeft = 300;
                    fdesignGroupTop = 300;
                    bdesignGroupLeft = 300;
                    bdesignGroupTop = 300;  
                    //console.log('FLeft: '+fdesignGroupLeft, 'FTop: '+fdesignGroupTop);  
                    //console.log('BLeft: '+bdesignGroupLeft, 'BTop: '+bdesignGroupTop);                                       
                }                
                $('#userEmail').removeClass('error');
                var input = document.createElement('input');
                input.type='email';
                input.value = document.getElementById('userEmail').value;
                $('#canvasFront').show();
                $('#canvasBack').hide();
                isFront = true;
                isBack = false;
                isDesign = false;
                $(".canvas-container:first").show();
                designCanvasFront.deactivateAll().renderAll();
                designCanvasBack.deactivateAll().renderAll();
                if(input.checkValidity()) {
                $('#curDesignName').removeClass('error'); 
                $('#blockArea').css('z-index','2147483647');    
                $('#blockArea').fadeIn();
                if(window.saveTime === undefined){
                    window.saveTime = $.now();
                }
                if(!designExist){
                    curName = currentName+saveTime;
                }else{
                    curName = currentName;
                }   
                if(_isGrid){
                    removeGrid();
                }  
                $.ajax({
                    url: _url,
                    type: "POST",
                    data: ({
                        jsonFront : JSON.stringify(designCanvasFront),
                        jsonBack : JSON.stringify(designCanvasBack),
                        curDesignName: curName,
                        name : $('#orderName').val(),
                        address : $('#userAddress').val(),
                        email : $('#userEmail').val(),
                        message : $('#userMessage').val(),
                        designPrice : window.totalPrice,
                        productPrice : window.productPrice,
                        shopCurrency :window.currencySign,
                        productName : window.productName,
                        fdesignTopPosition: window.fdesignGroupTop,
                        fdesignLeftPosition: window.fdesignGroupLeft,
                        bdesignTopPosition: window.bdesignGroupTop,
                        bdesignLeftPosition: window.bdesignGroupLeft,
                        productCategory: window.productCategory,
                        productsFormat: window.productFormat,
                        productBIMGF: window.backgroundImageFrontIS,
                        productBIMGB: window.backgroundImageBackIS,
                        productBCF: window.backgroundColorFrontIS,
                        productBCB : window.backgroundColorBackIS,
                        productImageFront: window.productImageFront,
                        productImageBack: window.productImageBack
                    }),
                    success: function (data) {
                        $('#designArea').html2canvas({
                            onrendered: function (canvas) {
                                var img = canvas.toDataURL("image/png");
                                localStorage['lastImgURI'] = canvas.toDataURL("image/png");                      
                                $.ajax({
                                    url: "saveFiles/saveFrontImage.php",
                                    type: "POST",
                                    data: ({
                                        data: img,
                                        curDesignName: curName
                                    }),
                                    success: function (data) {
                                        setTimeout(function() 
                                        {    
                                            designCanvasFront.deactivateAll().renderAll();
                                            designCanvasBack.deactivateAll().renderAll();
                                            $('#canvasFront').hide();
                                            $('#canvasBack').show();
                                            isFront = false;
                                            isBack =true;     
                                            $(".canvas-container:first").hide();
                                            designCanvasBack.calcOffset();
                                            $('#designArea').html2canvas({
                                                onrendered: function (canvas) {
                                                    var img = canvas.toDataURL("image/png");
                                                    localStorage['lastImgURI'] = canvas.toDataURL("image/png");                    
                                                    $.ajax({
                                                        url: "saveFiles/saveBackImage.php",
                                                        type: "POST",
                                                        data: ({
                                                            data: img,
                                                            curDesignName: curName
                                                        }),
                                                        success: function (data) {
                                                            isDesign = true;
                                                            isFront = true;
                                                            isBack =false;  
                                                            $('#canvasFront').show();
                                                            $('#canvasBack').hide();
                                                            $(".canvas-container:first").show(); 
                                                            $('#shareBtn').css('opacity','1');
                                                            $('#shareBtn').css('cursor', 'pointer');
                                                            $('#printBtn').css('opacity','1');
                                                            $('#printBtn').css('cursor', 'pointer');
                                                            if(_order){
                                                                $.ajax({
                                                                    url: "order.php",
                                                                    type: "POST",
                                                                    data: ({
                                                                        jsonFront : JSON.stringify(designCanvasFront),
                                                                        jsonBack : JSON.stringify(designCanvasBack),
                                                                        curDesignName: curName,
                                                                        name : $('#orderName').val(),
                                                                        address : $('#userAddress').val(),
                                                                        email : $('#userEmail').val(),
                                                                        message : $('#userMessage').val(),
                                                                        designPrice : window.totalPrice,
                                                                        productPrice : window.productPrice,
                                                                        shopCurrency :window.currencySign,
                                                                        productName : window.productName
                                                                    }),
                                                                    success: function (data) {
                                                                        designSaved = true; 
                                                                        isDesign = true; 
                                                                        $('#blockArea').fadeOut();
                                                                        $('#blockArea').css('z-index','314748364');   
                                                                        $('#orderForm').fadeOut();
                                                                    }
                                                                });
                                                            }else{
                                                                designSaved = true; 
                                                                $('#blockArea').fadeOut();
                                                                $('#orderForm').fadeOut();
                                                            }
                                                        },
                                                        error: function (data) {
                                                            designSaved = false;
                                                        }
                                                    });
                                                }
                                            });
                                        }, 2000);
                                    },
                                    error: function (data) {
                                        designSaved = false;
                                        $('#shareBtn').css('opacity','0.5');
                                        $('#shareBtn').css('cursor', 'default');
                                        $('#printBtn').css('opacity','0.5');
                                        $('#printBtn').css('cursor', 'default');  
                                    }
                                })
                            }
                        })
                    },
                    error: function (data) {
                        designSaved = false;
                    }
                });   
              } else {
                $('#userEmail').addClass('error');
                isDesign = true;                  
              }
             return false;
        } else {
            $('#userEmail').addClass('error');
            isDesign = true;     
        }
    }

    function saveFrontSide(_url,_order) {
        if ($('#userEmail').val() != "") {
                if((window.productCategory === "BusinessCard") && (window.productFormat ==="H")){
                    fdesignGroupLeft = 300;
                    fdesignGroupTop = 300;
                    //console.log('FLeft: '+fdesignGroupLeft, 'FTop: '+fdesignGroupTop);                         
                }
                if((window.productCategory === "BusinessCard") && (window.productFormat ==="V")){
                    fdesignGroupLeft = 300;
                    fdesignGroupTop = 300; 
                    //console.log('FLeft: '+fdesignGroupLeft, 'FTop: '+fdesignGroupTop);                    
                }    
                if((window.productCategory === "Stamp")||((window.productCategory === "Flyer"))){
                    var _fdesignGroup = new fabric.Group(designCanvasFront.getObjects());
                    designCanvasFront.setActiveGroup(_fdesignGroup).renderAll()
                    designCanvasFront.renderAll();
                    designCanvasFront.calcOffset();
                    fdesignGroupLeft = _fdesignGroup.getLeft();
                    fdesignGroupTop = _fdesignGroup.getTop()
                    //console.log('FLeft: '+_fdesignGroup.getLeft(), 'FTop: '+_fdesignGroup.getTop());  
                }
            $('#userEmail').removeClass('error');
                var input = document.createElement('input');
                input.type='email';
                input.value = document.getElementById('userEmail').value;
                $('#canvasFront').show();
                $('#canvasBack').hide();
                isFront = true;
                isBack = false;
                isDesign = false;
                $(".canvas-container:first").show();
                designCanvasFront.deactivateAll().renderAll();
                designCanvasBack.deactivateAll().renderAll();
                if(input.checkValidity()) {
                $('#curDesignName').removeClass('error');
                $('#blockArea').css('z-index','2147483647');         
                $('#blockArea').fadeIn();
                if(window.saveTime === undefined){
                    window.saveTime = $.now();
                }
                if(!designExist){
                    curName = currentName+saveTime;
                }else{
                    curName = currentName;
                }   
                if(_isGrid){
                    removeGrid();
                }  
                $.ajax({
                    url: _url,
                    type: "POST",
                    data: ({
                        jsonFront : JSON.stringify(designCanvasFront),
                        curDesignName: curName,
                        name : $('#orderName').val(),
                        address : $('#userAddress').val(),
                        email : $('#userEmail').val(),
                        message : $('#userMessage').val(),
                        designPrice : window.totalPrice,
                        productPrice : window.productPrice,
                        shopCurrency :window.currencySign,
                        productName : window.productName,
                        fdesignTopPosition: window.fdesignGroupTop,
                        fdesignLeftPosition: window.fdesignGroupLeft,
                        productCategory: window.productCategory,
                        productsFormat: window.productFormat,
                        productBIMGF: window.backgroundImageFrontIS,
                        productBCF: window.backgroundColorFrontIS,
                        productFBCF: window.fbackgroundColorFrontIS,
                        productFBIMGF: window.fbackgroundImageFrontIS,
                        productImageFront: window.productImageFront                    
                    }),
                    success: function (data) {
                        $('#designArea').html2canvas({
                            onrendered: function (canvas) {
                                var img = canvas.toDataURL("image/png");
                                //localStorage['lastImgURI'] = canvas.toDataURL("image/png");                      
                                $.ajax({
                                    url: "saveFiles/saveFrontImage.php",
                                    type: "POST",
                                    data: ({
                                        data: img,
                                        curDesignName: curName
                                    }),
                                    success: function (data) {
                                        designSaved = true; 
                                        isDesign = true;
                                        $('#blockArea').fadeOut();
                                        $('#blockArea').css('z-index','314748364');  
                                        $('#orderForm').fadeOut();
                                        $('#shareBtn').css('opacity','1');
                                        $('#shareBtn').css('cursor', 'pointer');
                                        $('#printBtn').css('opacity','1');
                                        $('#printBtn').css('cursor', 'pointer');
                                        if(_order){
                                            $.ajax({
                                                url: "orderOneSide.php",
                                                type: "POST",
                                                data: ({
                                                    jsonFront : JSON.stringify(designCanvasFront),
                                                    curDesignName: curName,
                                                    name : $('#orderName').val(),
                                                    address : $('#userAddress').val(),
                                                    email : $('#userEmail').val(),
                                                    message : $('#userMessage').val(),
                                                    designPrice : window.totalPrice,
                                                    productPrice : window.productPrice,
                                                    shopCurrency :window.currencySign,
                                                    productName : window.productName
                                                }),
                                                success: function (data) {
                                                    designSaved = true; 
                                                    isDesign = true; 
                                                    $('#blockArea').fadeOut();
                                                    $('#blockArea').css('z-index','314748364');   
                                                    $('#orderForm').fadeOut();
                                                }
                                            });
                                        }else{
                                            designSaved = true; 
                                            $('#blockArea').fadeOut();
                                            $('#orderForm').fadeOut();
                                        } 
                                    },
                                    error: function (data) {
                                        designSaved = false;
                                    }
                                })
                            }
                        })
                    },
                    error: function (data) {
                        designSaved = false;
                    }
                });   
              } else {
                $('#userEmail').addClass('error'); 
                isDesign = true;                 
              }
             return false;
        } else {
            $('#userEmail').addClass('error'); 
            isDesign = true;         
        }
    }

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
    })

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
    })
})