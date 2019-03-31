// JavaScript Document
$(document).ready(function () {
    // var settings
    var $window = $(window);
    var lables = new Array();
    var captions = new Array();
    var count = 0;
    var clickCount = 0;
    var maxCount;
    var restCount;
    var timestamp;
    var lastMotive = true;
    // set button visuals at first, the next will appera if all images loaded
    $("#previous").css({
        opacity: 0.5
    });
    $("#next").css({
        opacity: 0.5
    });
    $("#previous").css({
        cursor: 'default'
    });
    $("#next").css({
        cursor: 'default'
    });
    $("#motiveContainer").hide();
    //
    $(document).ready(function () {
        $.ajax({
            type: "GET",
            url: "xml/motives.xml",
            dataType: "xml",
            success: parseXml
        });
    });
    // loas images from xml file	
    function parseXml(xml) {
        $(xml).find("image").each(function () {
            
            lables[count] = $(this).attr("name");
            //captions[count] = $(this).attr("decription");
            count++;
            
            if (count == $(xml).find("image").length) {
                loadImages(lables);
            }
        })
    }
    // load all images into motiveContainer
    function loadImages(lables) {
        for (var i = 0; i < lables.length; i++) {
            $("#motiveContainer").append('<img id="' + i + '" style="width:50px; height:50px; display:block; float:left; cursor:pointer;" src=' + lables[i] + '>');
            $('#' + i).click(function (e) {
                fabric.Image.fromURL(e.target.src, function(img) {
                    var oImg = img.set({ left: 280, top: 260})
                    if(isFront){
                        var _scaleY = designCanvasFront.height / oImg.width;
                        var _scaleX = designCanvasFront.width / oImg.width;
                        if(oImg.width>designCanvasFront.width*0.5){
                            oImg.set('scaleY', _scaleY*0.4);
                            oImg.set('scaleX', _scaleX*0.4);
                        }
                        designCanvasFront.add(oImg);
                        designCanvasFront.renderAll();
                        designCanvasFront.calcOffset();
                        totalPrice = parseFloat(totalPrice)+parseFloat(window.motivePrice);
                        $('#priceView').text(totalPrice.toFixed(2)+currencySign); 
                    }
                    if(isBack){
                        var _scaleY = designCanvasBack.height / oImg.width;
                        var _scaleX = designCanvasBack.width / oImg.width;                        
                        if(oImg.width>designCanvasBack.width*0.5){
                            oImg.set('scaleY', _scaleY*0.4);
                            oImg.set('scaleX', _scaleX*0.4);
                        }                       
                        designCanvasBack.add(oImg);
                        designCanvasBack.renderAll();
                        designCanvasBack.calcOffset();
                        totalPrice = parseFloat(totalPrice)+parseFloat(window.motivePrice);
                        $('#priceView').text(totalPrice.toFixed(2)+currencySign);                         
                    }                    
                    activeMode();
                    isDesign = true;                    
                }); 
            });
            if (i == lables.length - 1) {
                $('#motiveContainer').css({
                    width: 50 * lables.length
                });
                if(lables.length>4){
                    $("#navNumber").text( 4 + '/' + lables.length);
                }else{
                    $("#navNumber").text( lables.length + '/' + lables.length);
                }
                $("#motiveContainer").fadeIn(300);
                maxCount = Math.floor(lables.length / 4);
                restCount = lables.length % 4;
            }
            if (lables.length > 4) {
                $("#next").css({
                    opacity: 1
                });
                $("#next").css({
                    cursor: 'pointer'
                });
            }
        }
    }
    // Nav Button function
    $("#next").click(function () {
        nextImg();
    });
    $("#previous").click(function () {
        previousImg();
    });

    function activeMode(){
        $('#saveBtn').css('opacity','1');
        $('#saveBtn').css('cursor', 'pointer');        
        $('#deleteDesign').css('opacity','1');
        $('#deleteDesign').css('cursor', 'pointer'); 
        $('#previewBtn').css('opacity','1');
        $('#previewBtn').css('cursor', 'pointer');
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
        $('#formBtn').css('opacity','0.5');
        $('#formBtn').css('cursor', 'default');                   
    }

	function nextImg(){
		if(restCount===0){
            if(clickCount<maxCount-1){
    			clickCount++;
    			$("#previous").css({opacity: 1});
    		    $("#next").css({opacity: 1});
    		    $("#previous").css({cursor: 'pointer'});
    		    $("#next").css({cursor: 'pointer'});
    		    $("#navNumber").text((clickCount + 1) * 4 + '/' + lables.length);
                moveLeft();
    		}
            if(clickCount === maxCount-1){
    			if(lastMotive){
                    $("#navNumber").text((clickCount + 1) * 4 +restCount+ '/' + lables.length);
    				lastMotive = false;
    				//console.log("even finished");
    				$("#previous").css({opacity: 1});
    			    $("#next").css({opacity: 0.5});
    			    $("#previous").css({cursor: 'pointer'});
    			    $("#next").css({cursor: 'default'});
    			}
    		}
        }

        if((restCount>0)&&(restCount != lables.length)){
            if(clickCount<maxCount){
                clickCount++;
                $("#previous").css({opacity: 1});
                $("#next").css({opacity: 1});
                $("#previous").css({cursor: 'pointer'});
                $("#next").css({cursor: 'pointer'});
                $("#navNumber").text((clickCount + 1) * 4 + '/' + lables.length);
                moveLeft();
            }
            if(clickCount === maxCount){
                if(lastMotive){
                    $("#navNumber").text( clickCount * 4 +restCount+ '/' + lables.length);
                    lastMotive = false;
                    //console.log("even finished");
                    $("#previous").css({opacity: 1});
                    $("#next").css({opacity: 0.5});
                    $("#previous").css({cursor: 'pointer'});
                    $("#next").css({cursor: 'default'});
                    
                }
            }
        }

	}

    function resetMotiveBorder() {
        for (i = 0; i < _nhd_motives.length; i++) {
            $('#' + _nhd_motives[i]).css("border", "none");
        }
    }

    function previousImg() {
        if(restCount===0){
            lastMotive = true;
    		if(clickCount>0){
    			clickCount--;
    			$("#previous").css({opacity: 1});
    		    $("#next").css({opacity: 1});
    		    $("#previous").css({cursor: 'pointer'});
    		    $("#next").css({cursor: 'pointer'});
                $("#navNumber").text((clickCount + 1) * 4 +restCount+ '/' + lables.length);
                moveRight();
    		}
    		if(clickCount===0){
    			//console.log("even start");
    			$("#previous").css({opacity: 0.5});
    		    $("#next").css({opacity: 1});
    		    $("#previous").css({cursor: 'default'});
    		    $("#next").css({cursor: 'pointer'});			
    		}
        }

        if((restCount>0)&&(restCount != lables.length)){
            lastMotive = true;
            if(clickCount>0){
                clickCount--;
                $("#previous").css({opacity: 1});
                $("#next").css({opacity: 1});
                $("#previous").css({cursor: 'pointer'});
                $("#next").css({cursor: 'pointer'});
                $("#navNumber").text((clickCount + 1) * 4 + '/' + lables.length); 
                moveRight();       
            }
            if(clickCount===0){
                //console.log("even start");
                $("#previous").css({opacity: 0.5});
                $("#next").css({opacity: 1});
                $("#previous").css({cursor: 'default'});
                $("#next").css({cursor: 'pointer'});            
            }
        }
    }

    function moveLeft(){
        $('#motiveContainer').animate({left: '-=200px'},400);
    }

    function moveRight(){
        $('#motiveContainer').animate({left: '+=200px'},400);
    }

    positionGallery(); //Reposition the Gallery to center it in the window when the script loads

    $window.resize(function () { //if the user resizes the window...
        positionGallery(); //reposition the Gallery again
    });

    function positionGallery() {
        var windowWidth = $window.width(); //get the height of the window
        var windowHeight = $window.height(); //get the height of the window
        var galleryWidth = $('#motiveMainContainer').width() / 2;
        var galleryHeight = $('#motiveMainContainer').height() / 2;
        var windowWCenter = (windowWidth / 2);
        var windowHCenter = (windowHeight / 2);
        var newLeft = windowWCenter - galleryWidth;
        var newTop = windowHCenter - galleryHeight;
        $('#motiveMainContainer').css({
            "left": newLeft
        });
        $('#motiveMainContainer').css({
            "top": newTop
        });
    }
});