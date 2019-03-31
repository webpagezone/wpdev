// JavaScript Document
$(document).ready(function () {
    // var settings
    var $window = $(window);
    var bvlables = new Array();
    var captions = new Array();
    var count = 0;
    var clickCount = 0;
    var maxCount;
    var restCount;
    var timestamp;
    var lastMotive = true;
    window.backgroundImageFrontIS = false;
    window.backgroundImageBackIS = false;      
    // set button visuals at first, the next will appera if all images loaded
    $("#bvprevious").css({
        opacity: 0.5
    });
    $("#bvnext").css({
        opacity: 0.5
    });
    $("#bvprevious").css({
        cursor: 'default'
    });
    $("#bvnext").css({
        cursor: 'default'
    });
    $("#backgroundVContainer").hide();
    //
    $(document).ready(function () {
        $.ajax({
            type: "GET",
            url: "xml/backgroundsV.xml",
            dataType: "xml",
            success: parseXml
        });
    });
    // loas images from xml file    
    function parseXml(xml) {
        $(xml).find("image").each(function () {
            bvlables[count] = $(this).attr("name");
            //captions[count] = $(this).attr("decription");
            count++;
            
            if (count == $(xml).find("image").length) {
                loadbvImages(bvlables);
            }
        })
    }
    // load all images into backgroundContainer
    function loadbvImages(lables) {
        for (var i = 0; i < bvlables.length; i++) {
            $("#backgroundVContainer").append('<img id="bv' + i + '" style="width:50px; height:46px; display:block; float:left; padding-top:2px; cursor:pointer;" src=' + bvlables[i] + '>');
            $('#bv' + i).click(function (e) {
                $('#deleteBackgroundImage').show();
                if(isFront && backgroundColorFrontIS){
                    totalPrice = parseFloat(totalPrice)-parseFloat(window.backgroundColorPrice);
                    $('#priceView').text(totalPrice.toFixed(2)+currencySign); 
                }
                if(isBack && backgroundColorBackIS){
                    totalPrice = parseFloat(totalPrice)-parseFloat(window.backgroundColorPrice);
                    $('#priceView').text(totalPrice.toFixed(2)+currencySign); 
                }                 
                if(isFront && !backgroundImageFrontIS){
                    totalPrice = parseFloat(totalPrice)+parseFloat(window.backgroundImagePrice);
                    $('#priceView').text(totalPrice.toFixed(2)+currencySign); 
                }
                if(isBack && !backgroundImageBackIS){
                    totalPrice = parseFloat(totalPrice)+parseFloat(window.backgroundImagePrice);
                    $('#priceView').text(totalPrice.toFixed(2)+currencySign);  
                }                
                if(isFront){
                    designCanvasFront.setBackgroundImage(e.target.src, designCanvasFront.renderAll.bind(designCanvasFront));
                    backgroundImageFrontIS = true;
                    backgroundColorFrontIS = false;
                }
                if(isBack){
                    designCanvasBack.setBackgroundImage(e.target.src, designCanvasBack.renderAll.bind(designCanvasBack));
                    backgroundImageBackIS = true;
                    backgroundColorBackIS = false;
                }                    
                activeMode();
                isDesign = true;                    
            });
            if (i == bvlables.length - 1) {
                $('#backgroundVContainer').css({
                    width: 50 * bvlables.length
                });
                if(bvlables.length>4){
                    $("#bvnavNumber").text( 4 + '/' + bvlables.length);
                }else{
                    $("#bvnavNumber").text( bvlables.length + '/' + bvlables.length);
                }
                $("#backgroundVContainer").fadeIn(300);
                maxCount = Math.floor(bvlables.length / 4);
                restCount = bvlables.length % 4;
            }
            if (bvlables.length > 4) {
                $("#bvnext").css({
                    opacity: 1
                });
                $("#bvnext").css({
                    cursor: 'pointer'
                });
            }
        }
    }
    $('#deleteBackgroundImage').click(function () {
        if(isFront && backgroundImageFrontIS){
            designCanvasFront.setBackgroundImage(window.productImageFront, designCanvasFront.renderAll.bind(designCanvasFront));
            backgroundImageFrontIS = false;
            window.totalPrice = parseFloat(window.totalPrice)-parseFloat(window.backgroundImagePrice);
            $('#priceView').text(totalPrice.toFixed(2)+currencySign); 
        }
        if(isBack && backgroundImageBackIS){
            designCanvasBack.setBackgroundImage(window.productImageBack, designCanvasBack.renderAll.bind(designCanvasBack));
            backgroundImageBackIS = false;
            window.totalPrice = parseFloat(window.totalPrice)-parseFloat(window.backgroundImagePrice);
            $('#priceView').text(totalPrice.toFixed(2)+currencySign);            
        }
        if(!backgroundColorFrontIS && !backgroundColorBackIS && !backgroundImageFrontIS && !backgroundImageBackIS){
            $('#deleteBackgroundImage').hide();          
        }
    })    
    // Nav Button function
    $("#bvnext").click(function () {
        nextImg();
    });
    $("#bvprevious").click(function () {
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
                $("#bvprevious").css({opacity: 1});
                $("#bvnext").css({opacity: 1});
                $("#bvprevious").css({cursor: 'pointer'});
                $("#bvnext").css({cursor: 'pointer'});
                $("#bvnavNumber").text((clickCount + 1) * 4 + '/' + bvlables.length);
                moveLeft();
            }
            if(clickCount === maxCount-1){
                if(lastMotive){
                    $("#bvnavNumber").text((clickCount + 1) * 4 +restCount+ '/' + bvlables.length);
                    lastMotive = false;
                    //console.log("even finished");
                    $("#bvprevious").css({opacity: 1});
                    $("#bvnext").css({opacity: 0.5});
                    $("#bvprevious").css({cursor: 'pointer'});
                    $("#bvnext").css({cursor: 'default'});
                }
            }
        }

        if((restCount>0)&&(restCount != bvlables.length)){
            if(clickCount<maxCount){
                clickCount++;
                $("#bvprevious").css({opacity: 1});
                $("#bvnext").css({opacity: 1});
                $("#bvprevious").css({cursor: 'pointer'});
                $("#bvnext").css({cursor: 'pointer'});
                $("#bvnavNumber").text((clickCount + 1) * 4 + '/' + bvlables.length);
                moveLeft();
            }
            if(clickCount === maxCount){
                if(lastMotive){
                    $("#bvnavNumber").text( clickCount * 4 +restCount+ '/' + bvlables.length);
                    lastMotive = false;
                    //console.log("even finished");
                    $("#bvprevious").css({opacity: 1});
                    $("#bvnext").css({opacity: 0.5});
                    $("#bvprevious").css({cursor: 'pointer'});
                    $("#bvnext").css({cursor: 'default'});
                    
                }
            }
        }

    }

    function previousImg() {
        if(restCount===0){
            lastMotive = true;
            if(clickCount>0){
                clickCount--;
                $("#bvprevious").css({opacity: 1});
                $("#bvnext").css({opacity: 1});
                $("#bvprevious").css({cursor: 'pointer'});
                $("#bvnext").css({cursor: 'pointer'});
                $("#bvnavNumber").text((clickCount + 1) * 4 +restCount+ '/' + bvlables.length);
                moveRight();
            }
            if(clickCount===0){
                //console.log("even start");
                $("#bvprevious").css({opacity: 0.5});
                $("#bvnext").css({opacity: 1});
                $("#bvprevious").css({cursor: 'default'});
                $("#bvnext").css({cursor: 'pointer'});            
            }
        }

        if((restCount>0)&&(restCount != bvlables.length)){
            lastMotive = true;
            if(clickCount>0){
                clickCount--;
                $("#bvprevious").css({opacity: 1});
                $("#bvnext").css({opacity: 1});
                $("#bvprevious").css({cursor: 'pointer'});
                $("#bvnext").css({cursor: 'pointer'});
                $("#bvnavNumber").text((clickCount + 1) * 4 + '/' + bvlables.length); 
                moveRight();       
            }
            if(clickCount===0){
                //console.log("even start");
                $("#bvprevious").css({opacity: 0.5});
                $("#bvnext").css({opacity: 1});
                $("#bvprevious").css({cursor: 'default'});
                $("#bvnext").css({cursor: 'pointer'});            
            }
        }
    }

    function moveLeft(){
        $('#backgroundVContainer').animate({left: '-=200px'},400);
    }

    function moveRight(){
        $('#backgroundVContainer').animate({left: '+=200px'},400);
    }

    positionGallery(); //Reposition the Gallery to center it in the window when the script loads

    $window.resize(function () { //if the user resizes the window...
        positionGallery(); //reposition the Gallery again
    });

    function positionGallery() {
        var windowWidth = $window.width(); //get the height of the window
        var windowHeight = $window.height(); //get the height of the window
        var galleryWidth = $('#backgroundVMainContainer').width() / 2;
        var galleryHeight = $('#backgroundVMainContainer').height() / 2;
        var windowWCenter = (windowWidth / 2);
        var windowHCenter = (windowHeight / 2);
        var newLeft = windowWCenter - galleryWidth;
        var newTop = windowHCenter - galleryHeight;
        $('#backgroundVMainContainer').css({
            "left": newLeft
        });
        $('#backgroundVMainContainer').css({
            "top": newTop
        });
    }
});