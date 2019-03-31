// JavaScript Document
$(document).ready(function () {
    // var settings
    var $window = $(window);
    var bhlables = new Array();
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
    $("#bhprevious").css({
        opacity: 0.5
    });
    $("#bhnext").css({
        opacity: 0.5
    });
    $("#bhprevious").css({
        cursor: 'default'
    });
    $("#bhnext").css({
        cursor: 'default'
    });
    $("#backgroundHContainer").hide();
    //
    $(document).ready(function () {
        $.ajax({
            type: "GET",
            url: "xml/backgroundsH.xml",
            dataType: "xml",
            success: parseXml
        });
    });
    // loas images from xml file    
    function parseXml(xml) {
        $(xml).find("image").each(function () {
            bhlables[count] = $(this).attr("name");
            //captions[count] = $(this).attr("decription");
            count++;
            
            if (count == $(xml).find("image").length) {
                loadbhImages(bhlables);
            }
        })
    }
    // load all images into backgroundContainer
    function loadbhImages(lables) {
        for (var i = 0; i < bhlables.length; i++) {
            $("#backgroundHContainer").append('<img id="bh' + i + '" style="width:50px; height:46px; display:block; float:left; padding-top:2px; cursor:pointer;" src=' + bhlables[i] + '>');
            $('#bh' + i).click(function (e) {
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
            if (i == bhlables.length - 1) {
                $('#backgroundHContainer').css({
                    width: 50 * bhlables.length
                });
                if(bhlables.length>4){
                    $("#bhnavNumber").text( 4 + '/' + bhlables.length);
                }else{
                    $("#bhnavNumber").text( bhlables.length + '/' + bhlables.length);
                }
                $("#backgroundHContainer").fadeIn(300);
                maxCount = Math.floor(bhlables.length / 4);
                restCount = bhlables.length % 4;
            }
            if (bhlables.length > 4) {
                $("#bhnext").css({
                    opacity: 1
                });
                $("#bhnext").css({
                    cursor: 'pointer'
                });
            }
        }
    }

    $('#deleteBackgroundImage').click(function () {
        if(isFront && backgroundImageFrontIS){
            designCanvasFront.setBackgroundImage(window.productImageFront, designCanvasFront.renderAll.bind(designCanvasFront));
            backgroundImageFrontIS = false;
            totalPrice = parseFloat(totalPrice)-parseFloat(window.backgroundImagePrice);
            $('#priceView').text(totalPrice.toFixed(2)+currencySign); 
        }
        if(isBack && backgroundImageBackIS){
            designCanvasBack.setBackgroundImage(window.productImageBack, designCanvasBack.renderAll.bind(designCanvasBack));
            backgroundImageBackIS = false;
            totalPrice = parseFloat(totalPrice)-parseFloat(window.backgroundImagePrice);
            $('#priceView').text(totalPrice.toFixed(2)+currencySign);          
        }
        if(!backgroundColorFrontIS && !backgroundColorBackIS && !backgroundImageFrontIS && !backgroundImageBackIS){
            $('#deleteBackgroundImage').hide();
        }
    })
    // Nav Button function
    $("#bhnext").click(function () {
        nextImg();
    });
    $("#bhprevious").click(function () {
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
                $("#bhprevious").css({opacity: 1});
                $("#bhnext").css({opacity: 1});
                $("#bhprevious").css({cursor: 'pointer'});
                $("#bhnext").css({cursor: 'pointer'});
                $("#bhnavNumber").text((clickCount + 1) * 4 + '/' + bhlables.length);
                moveLeft();
            }
            if(clickCount === maxCount-1){
                if(lastMotive){
                    $("#bhnavNumber").text((clickCount + 1) * 4 +restCount+ '/' + bhlables.length);
                    lastMotive = false;
                    //console.log("even finished");
                    $("#bhprevious").css({opacity: 1});
                    $("#bhnext").css({opacity: 0.5});
                    $("#bhprevious").css({cursor: 'pointer'});
                    $("#bhnext").css({cursor: 'default'});
                }
            }
        }

        if((restCount>0)&&(restCount != bhlables.length)){
            if(clickCount<maxCount){
                clickCount++;
                $("#bhprevious").css({opacity: 1});
                $("#bhnext").css({opacity: 1});
                $("#bhprevious").css({cursor: 'pointer'});
                $("#bhnext").css({cursor: 'pointer'});
                $("#bhnavNumber").text((clickCount + 1) * 4 + '/' + bhlables.length);
                moveLeft();
            }
            if(clickCount === maxCount){
                if(lastMotive){
                    $("#bhnavNumber").text( clickCount * 4 +restCount+ '/' + bhlables.length);
                    lastMotive = false;
                    //console.log("even finished");
                    $("#bhprevious").css({opacity: 1});
                    $("#bhnext").css({opacity: 0.5});
                    $("#bhprevious").css({cursor: 'pointer'});
                    $("#bhnext").css({cursor: 'default'});
                    
                }
            }
        }

    }

    function previousImg() {
        if(restCount===0){
            lastMotive = true;
            if(clickCount>0){
                clickCount--;
                $("#bhprevious").css({opacity: 1});
                $("#bhnext").css({opacity: 1});
                $("#bhprevious").css({cursor: 'pointer'});
                $("#bhnext").css({cursor: 'pointer'});
                $("#bhnavNumber").text((clickCount + 1) * 4 +restCount+ '/' + bhlables.length);
                moveRight();
            }
            if(clickCount===0){
                //console.log("even start");
                $("#bhprevious").css({opacity: 0.5});
                $("#bhnext").css({opacity: 1});
                $("#bhprevious").css({cursor: 'default'});
                $("#bhnext").css({cursor: 'pointer'});            
            }
        }

        if((restCount>0)&&(restCount != bhlables.length)){
            lastMotive = true;
            if(clickCount>0){
                clickCount--;
                $("#bhprevious").css({opacity: 1});
                $("#bhnext").css({opacity: 1});
                $("#bhprevious").css({cursor: 'pointer'});
                $("#bhnext").css({cursor: 'pointer'});
                $("#bhnavNumber").text((clickCount + 1) * 4 + '/' + bhlables.length); 
                moveRight();       
            }
            if(clickCount===0){
                //console.log("even start");
                $("#bhprevious").css({opacity: 0.5});
                $("#bhnext").css({opacity: 1});
                $("#bhprevious").css({cursor: 'default'});
                $("#bhnext").css({cursor: 'pointer'});            
            }
        }
    }

    function moveLeft(){
        $('#backgroundHContainer').animate({left: '-=200px'},400);
    }

    function moveRight(){
        $('#backgroundHContainer').animate({left: '+=200px'},400);
    }

    positionGallery(); //Reposition the Gallery to center it in the window when the script loads

    $window.resize(function () { //if the user resizes the window...
        positionGallery(); //reposition the Gallery again
    });

    function positionGallery() {
        var windowWidth = $window.width(); //get the height of the window
        var windowHeight = $window.height(); //get the height of the window
        var galleryWidth = $('#backgroundHMainContainer').width() / 2;
        var galleryHeight = $('#backgroundHMainContainer').height() / 2;
        var windowWCenter = (windowWidth / 2);
        var windowHCenter = (windowHeight / 2);
        var newLeft = windowWCenter - galleryWidth;
        var newTop = windowHCenter - galleryHeight;
        $('#backgroundHMainContainer').css({
            "left": newLeft
        });
        $('#backgroundHMainContainer').css({
            "top": newTop
        });
    }
});