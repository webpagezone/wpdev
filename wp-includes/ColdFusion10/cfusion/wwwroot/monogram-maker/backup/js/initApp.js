$(function () {
    var _curID;
    var _noSize=false;
    var _noBackSide=false;
   
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

    
    
    
    var _curFonts="";
    
    $.ajax({
        url: "xml/fonts.xml",
        type: "GET",
        dataType:"text xml",
        success: function(xml) {
            $('#fontRender').empty();
            $('#myFonts').empty();
            $(xml).find('font').each(function(e, i)
            {
                _curFonts = _curFonts +"|"+ $(i).attr("name");
                $('#fontRender').append('<span style="font-family:'+$(i).attr("family")+'">Text Render</span>');
                //$('#myFonts').append('<option value="'+$(i).attr("family")+'">'+$(i).attr("label")+'</option>');
                $('#myFonts').append('<option value="'+$(i).attr("family")+'" style="font-family: '+$(i).attr("family")+'">'+$(i).attr("label")+'</option>');
            });
            $("head").append('<link href="https://fonts.googleapis.com/css?family=' + _curFonts.substring(1) + '" rel="stylesheet" type="text/css">');
        }    
    });
});


/*Fontselect.prototype.updateSelected = function(){
    
    var font = this.$original.val();
    $('span', this.$element).text(this.toReadable(font)).css(this.toStyle(font));
  };*/