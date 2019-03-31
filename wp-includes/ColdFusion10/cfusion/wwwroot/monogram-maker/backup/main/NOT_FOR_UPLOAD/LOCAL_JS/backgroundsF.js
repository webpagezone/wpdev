// JavaScript Document
$(document).ready(function () {
    // var settings
    var $window = $(window);
    var bflables = new Array();
    var captions = new Array();
    var count = 0;
    var clickCount = 0;
    var maxCount;
    var restCount;
    var timestamp;
    var lastMotive = true;
    window.fbackgroundImageFrontIS = false;
    window.fbackgroundImageBackIS = false;    
    // set button visuals at first, the next will appera if all images loaded
    $("#bfprevious").css({
        opacity: 0.5
    });
    $("#bfnext").css({
        opacity: 0.5
    });
    $("#bfprevious").css({
        cursor: 'default'
    });
    $("#bfnext").css({
        cursor: 'default'
    });
    $("#backgroundFContainer").hide();
    //
    $(document).ready(function () {
        $.ajax({
            type: "GET",
            url: "xml/backgroundsFlyers.xml",
            dataType: "xml",
            success: parseXml
        });
    });
    // loas images from xml file    
    function parseXml(xml) {
        $(xml).find("image").each(function () {
            bflables[count] = $(this).attr("name");
            //captions[count] = $(this).attr("decription");
            count++;
            
            if (count == $(xml).find("image").length) {
                loadbfImages(bflables);
            }
        })
    }
    // load all images into backgroundContainer
    function loadbfImages(lables) {
        for (var i = 0; i < bflables.length; i++) {
            $("#backgroundFContainer").append('<img id="bf' + i + '" style="width:50px; height:46px; display:block; float:left; padding-top:2px; cursor:pointer;" src=' + bflables[i] + '>');
            $('#bf' + i).click(function (e) {
                $('#deleteBackgroundImage').show();
                if(isFront && fbackgroundColorFrontIS){
                    totalPrice = parseFloat(totalPrice)-parseFloat(window.fbackgroundColorPrice);
                    $('#priceView').text(totalPrice.toFixed(2)+currencySign);
                }              
                if(isFront && !fbackgroundImageFrontIS){
                    totalPrice = parseFloat(totalPrice)+parseFloat(window.fbackgroundImagePrice);
                    $('#priceView').text(totalPrice.toFixed(2)+currencySign);
                }
                if(isFront){
                    designCanvasFront.setBackgroundImage(e.target.src, designCanvasFront.renderAll.bind(designCanvasFront));
                    fbackgroundImageFrontIS = true;
                    fbackgroundColorFrontIS = false;
                }               
                activeMode();
                isDesign = true;                    
            });
            if (i == bflables.length - 1) {
                $('#backgroundFContainer').css({
                    width: 50 * bflables.length
                });
                if(bflables.length>4){
                    $("#bfnavNumber").text( 4 + '/' + bflables.length);
                }else{
                    $("#bfnavNumber").text( bflables.length + '/' + bflables.length);
                }
                $("#backgroundFContainer").fadeIn(300);
                maxCount = Math.floor(bflables.length / 4);
                restCount = bflables.length % 4;
            }
            if (bflables.length > 4) {
                $("#bfnext").css({
                    opacity: 1
                });
                $("#bfnext").css({
                    cursor: 'pointer'
                });
            }
        }
    }

    $('#deleteBackgroundImage').click(function () {
        if(isFront && fbackgroundImageFrontIS){
            designCanvasFront.setBackgroundImage(window.productImageFront, designCanvasFront.renderAll.bind(designCanvasFront));
            fbackgroundImageFrontIS = false;
            totalPrice = parseFloat(totalPrice)-parseFloat(window.fbackgroundImagePrice);
            $('#priceView').text(totalPrice.toFixed(2)+currencySign); 
        }
        if(!fbackgroundColorFrontIS && !fbackgroundImageFrontIS){
            $('#deleteBackgroundImage').hide();
        }
    })
    // Nav Button function
    $("#bfnext").click(function () {
        nextImg();
    });
    $("#bfprevious").click(function () {
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
                $("#bfprevious").css({opacity: 1});
                $("#bfnext").css({opacity: 1});
                $("#bfprevious").css({cursor: 'pointer'});
                $("#bfnext").css({cursor: 'pointer'});
                $("#bfnavNumber").text((clickCount + 1) * 4 + '/' + bflables.length);
                moveLeft();
            }
            if(clickCount === maxCount-1){
                if(lastMotive){
                    $("#bfnavNumber").text((clickCount + 1) * 4 +restCount+ '/' + bflables.length);
                    lastMotive = false;
                    //console.log("even finished");
                    $("#bfprevious").css({opacity: 1});
                    $("#bfnext").css({opacity: 0.5});
                    $("#bfprevious").css({cursor: 'pointer'});
                    $("#bfnext").css({cursor: 'default'});
                }
            }
        }

        if((restCount>0)&&(restCount != bflables.length)){
            if(clickCount<maxCount){
                clickCount++;
                $("#bfprevious").css({opacity: 1});
                $("#bfnext").css({opacity: 1});
                $("#bfprevious").css({cursor: 'pointer'});
                $("#bfnext").css({cursor: 'pointer'});
                $("#bfnavNumber").text((clickCount + 1) * 4 + '/' + bflables.length);
                moveLeft();
            }
            if(clickCount === maxCount){
                if(lastMotive){
                    $("#bfnavNumber").text( clickCount * 4 +restCount+ '/' + bflables.length);
                    lastMotive = false;
                    //console.log("even finished");
                    $("#bfprevious").css({opacity: 1});
                    $("#bfnext").css({opacity: 0.5});
                    $("#bfprevious").css({cursor: 'pointer'});
                    $("#bfnext").css({cursor: 'default'});
                    
                }
            }
        }

    }

    function previousImg() {
        if(restCount===0){
            lastMotive = true;
            if(clickCount>0){
                clickCount--;
                $("#bfprevious").css({opacity: 1});
                $("#bfnext").css({opacity: 1});
                $("#bfprevious").css({cursor: 'pointer'});
                $("#bfnext").css({cursor: 'pointer'});
                $("#bfnavNumber").text((clickCount + 1) * 4 +restCount+ '/' + bflables.length);
                moveRight();
            }
            if(clickCount===0){
                //console.log("even start");
                $("#bfprevious").css({opacity: 0.5});
                $("#bfnext").css({opacity: 1});
                $("#bfprevious").css({cursor: 'default'});
                $("#bfnext").css({cursor: 'pointer'});            
            }
        }

        if((restCount>0)&&(restCount != bflables.length)){
            lastMotive = true;
            if(clickCount>0){
                clickCount--;
                $("#bfprevious").css({opacity: 1});
                $("#bfnext").css({opacity: 1});
                $("#bfprevious").css({cursor: 'pointer'});
                $("#bfnext").css({cursor: 'pointer'});
                $("#bfnavNumber").text((clickCount + 1) * 4 + '/' + bflables.length); 
                moveRight();       
            }
            if(clickCount===0){
                //console.log("even start");
                $("#bfprevious").css({opacity: 0.5});
                $("#bfnext").css({opacity: 1});
                $("#bfprevious").css({cursor: 'default'});
                $("#bfnext").css({cursor: 'pointer'});            
            }
        }
    }

    function moveLeft(){
        $('#backgroundFContainer').animate({left: '-=200px'},400);
    }

    function moveRight(){
        $('#backgroundFContainer').animate({left: '+=200px'},400);
    }

    positionGallery(); //Reposition the Gallery to center it in the window when the script loads

    $window.resize(function () { //if the user resizes the window...
        positionGallery(); //reposition the Gallery again
    });

    function positionGallery() {
        var windowWidth = $window.width(); //get the height of the window
        var windowHeight = $window.height(); //get the height of the window
        var galleryWidth = $('#backgroundFMainContainer').width() / 2;
        var galleryHeight = $('#backgroundFMainContainer').height() / 2;
        var windowWCenter = (windowWidth / 2);
        var windowHCenter = (windowHeight / 2);
        var newLeft = windowWCenter - galleryWidth;
        var newTop = windowHCenter - galleryHeight;
        $('#backgroundFMainContainer').css({
            "left": newLeft
        });
        $('#backgroundFMainContainer').css({
            "top": newTop
        });
    }
});