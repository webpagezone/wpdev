$(function () {
    var _curID;
    var _noSize=false;
    var _noBackSide=false;
    var _curFonts="";
    window.productPrice;
    var _curHeight;
    window.isChecking = true;    
    window.appURL = "localhost:8500/PrintDesigner/main/";
    window.textPrice = "3.00"; // Price for each Text will be add to Design
    window.motivePrice = "5.00"; // Price for each Motive or Upload Images on Designs
    window.backgroundImagePrice = "8.00"; // Price for BusinessCard Background Image
    window.backgroundColorPrice = "2.00"; // Price for BusinessCard Background Color
    window.fbackgroundImagePrice = "10.00"; // Price for Flyer Background Image
    window.fbackgroundColorPrice = "5.00"; // Price for Flyer Background Color     
    window.googleFontsCustom = true; // true shows Custom fonts from xml/fonts.xml list | false will show All GoogleFonts with Preview
    window.currencySign="$"; // Currency Sign that will use Overall

    $.ajax({
        url: "xml/products.xml",
        type: "POST",
        dataType:"text xml",
        success: function(xml) {
            $('#productsHolder').empty();
            $(xml).find('product').each(function(e, i)
            {
                if($(i).attr("backImage") != undefined){ 
                    $('#productsHolder').append('<div class="productHolder" name = "'+$(i).attr("name")+'" price="'+$(i).attr("price")+'" category="'+$(i).attr("category")+'" id="'+$(i).attr("id")+'" format="'+$(i).attr("productFormat")+'"><img width="150" src="'+$(i).attr("thumbImage")+'" front="'+$(i).attr("frontImage")+'" back="'+$(i).attr("backImage")+'"></img><p>'+$(i).attr("name")+'</p><span class="productPrice">'+$(i).attr("price")+currencySign+'</span></div>');
                }else{
                    $('#productsHolder').append('<div class="productHolder" name = "'+$(i).attr("name")+'" price="'+$(i).attr("price")+'" category="'+$(i).attr("category")+'" id="'+$(i).attr("id")+'" format="'+$(i).attr("productFormat")+'"><img width="150" src="'+$(i).attr("thumbImage")+'" front="'+$(i).attr("frontImage")+'"></img><p>'+$(i).attr("name")+'</p><span class="productPrice">'+$(i).attr("price")+currencySign+'</span></div>')
                }
            });
            
            _curHeight = $('#productsHolder').height();
            $('#container').css('height',Number(_curHeight)+300+'px');
            // Fix for Chrome 
            setTimeout(function() { 
                _curHeight = $('#productsHolder').height(); 
                if(_curHeight>650){
                    $('#container').css('height',Number(_curHeight)+300+'px');
                }
            }, 500);
            $('.usernameHolder').empty();
            $('.usernameHolder').append('<h2>Enter your Design Name</h2><div class="inputHolder"><input type="text" id="curDesignName"></div>');
            
            $('#productsHolder').find('div').click(function(event){
            if($( window ).height()<660){
                $('#container').css('height','660px');
            }else{
                $('#container').css('height',Number(_curHeight)+300+'px');
            }
            
            window.productName = $('#'+event.currentTarget.id).attr('name');
            window.productCategory = $('#'+event.currentTarget.id).attr('category');
            window.productFormat = $('#'+event.currentTarget.id).attr('format');
            window.productImageFront = $('#'+event.currentTarget.id).find('img').attr('front');
            
            if($('#'+event.currentTarget.id).find('img').attr('back') !== undefined){
                window.productImageBack = $('#'+event.currentTarget.id).find('img').attr('back');
            }else{
                window.productImageBack = "";
            }
            
            if(window.productCategory === "BusinessCard"){
                $('#colorBackgroundHolder').show();
                if(window.productFormat === "V"){
                    $('#backgroundsVHolder').show();
                    $('#backgroundsHHolder').hide();
                }else{
                    $('#backgroundsHHolder').show();
                    $('#backgroundsVHolder').hide();
                }
            }else{
                $('#colorBackgroundHolder').hide();
                $('#backgroundsHolder').hide();
            }
            
            if(window.productCategory === "Flyer"){
                $('#colorBackgroundHolder').show();
                $('#backgroundsFHolder').show();
                $('#backgroundsHHolder').hide();
                $('#backgroundsVHolder').hide();
            }
            
            var _frontImage = $('#'+event.currentTarget.id).find('img').attr('front');
            var _backImage = $('#'+event.currentTarget.id).find('img').attr('back');
            _curID = event.currentTarget.id;
            productPrice = $('#'+event.currentTarget.id).attr('price');
            if(_backImage === undefined){
                _noBackSide = true;
            }else{
                _noBackSide = false;
            }

            if($('#curDesignName').val() !== ""){
                $('.usernameHolder').hide();
                $('#tc').prop('checked', false);
                $('#qrSize').val($("#qrSize option:first").val());
                window.currentName = $('#curDesignName').val();
                $('#productsHolder').hide();
                $('#loadAppStart').hide();
                if(isChecking){
                    startApp();
                }
            }else{
                $('#curDesignName').addClass('error');
                isChecking = true;
            }
        })
        }    
    });
    
    $.ajax({
        url: "xml/fonts.xml",
        type: "POST",
        dataType:"text xml",
        success: function(xml) {
            $('#fontRender').empty();
            //$('#myFonts').empty();
            $(xml).find('font').each(function(e, i)
            {
                _curFonts = _curFonts +"|"+ $(i).attr("name");
                $('#fontRender').append('<span style="font-family:'+$(i).attr("family")+'">Text Render</span>');
                $('#myFonts').append('<option value="'+$(i).attr("family")+'">'+$(i).attr("label")+'</option>');
                
            });
            $("head").append('<link href="http://fonts.googleapis.com/css?family='+_curFonts.substring(1)+'" rel="stylesheet" type="text/css">');
        }    
    });

    $('#loadAppStart').click(function (e) { 
        $('#startBtn').text('Load Design');
        $('.username').empty();
        $('.username').append('<h2>Enter the DesignCode, you have recieved per Email</h2><input type="text" id="curLoadDesignName">');
        $('#logInPanel').fadeIn();
        $('#loadAppStart').hide();
        $('#productsHolder').hide();
        loadedDesign = true;
        $('#container').css('height','100%');
        $('.usernameHolder').hide();
    })

    $('#backBtn').click(function (e) { 
            if(_curHeight>650){
                $('#container').css('height',Number(_curHeight)+300+'px');
            }
            $('#productsHolder').css('height','100%');
            $('#productsHolder').show();
            $('#logInPanel').hide();
            loadedDesign = false;
            $('#loadAppStart').show();
            $('.usernameHolder').show();
            $('#curDesignName').removeClass('error');
    })

    $('#backBtnProductDesign').click(function (e) { 
        window.location = window.appURL+'index.php';         
    }) 

});