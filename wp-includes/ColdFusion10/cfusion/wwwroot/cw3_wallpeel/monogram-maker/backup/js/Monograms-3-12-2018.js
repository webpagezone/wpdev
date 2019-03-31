
$(function () {


    window.designCanvasFront = new fabric.Canvas('canvasFront');
    
    //window.designCanvasFront = new fabric.Canvas('canvasFront', { preserveObjectStacking:true });
    //window.appURL = "http://localhost:8500/Monogram/";
    window.appURL = "http://localhost:8500/Monogram/";
    var _curFonts = "";

    //fabric.Object.prototype.transparentCorners = false;

    //*******************************************************************************
    //default values 
    window.items_len = 0;

    var numLetters = 3;
    
    var selectedFont = 'Circle';

    // var textA_2 = '';
    // canvas text element
    var textBoxA_3;
    var textBoxB_3;
    var textBoxC_3;
    // input text box values
    var textBoxAval_3 = '';
    var textBoxBval_3 = '';
    var textBoxCval_3 = '';
    
    
    
    var textBox_3;
    var textBoxVal_3 = ''; 
    
    var fontFamily_3 = '';
    var fontFamily_3_Url = '';
    var fontFamily_3_fontSize = 0;
    var fontFamily_3_toptPx = 0;
    var fontFamily_3_leftPx = 0;
    
    var textBox_2;
    var textBoxVal_2 = ''; 
    
    var fontFamily_2 = '';
    var fontFamily_2_Url = '';
    var fontFamily_2_fontSize = 0;
    var fontFamily_2_toptPx = 0;
    var fontFamily_2_leftPx = 0;
    
    var textBoxA_1;
    var textBoxAval_1 = '';
    
    var fontFamily_1 = '';
    var fontFamily_1_Url = '';
    var fontFamily_1_fontSize = 0;
    var fontFamily_1_toptPx = 0;
    var fontFamily_1_leftPx = 0;
    
    
    var textBoxFrame = '';
    var fontFamily_frame = '0';
    var fontFamily_frame_Url = '0';
    var fontFamily_frame_fontSize = 0;
    var fontFamily_frame_toptPx = 0;
    var fontFamily_frame_leftPx = 0;
    

    var fontFamily_3_1 = '';
    var fontFamily_3_1_Url = '';
    var fontFamily_3_1_fontSize = 0;
    var fontFamily_3_1_toptPx = 0;
    var fontFamily_3_1_leftPx = 0;

    var fontFamily_3_2 = '';
    var fontFamily_3_2_Url = '';
    var fontFamily_3_2_fontSize = 0;
    var fontFamily_3_2_toptPx = 0;
    var fontFamily_3_2_leftPx = 0;

    var fontFamily_3_3 = '0';
    var fontFamily_3_3_Url = '0';
    var fontFamily_3_3_fontSize = 0;
    var fontFamily_3_3_toptPx = 0;
    var fontFamily_3_3_leftPx = 0;


    var obj = designCanvasFront.getActiveObject();

    //var textGroup;
    //*******************************************************************************
    //on load functions

    //AddFrameToCanvas();

    //Left Menu show Num of letters
    
    //Left Menu show font styles for num of fonts
    ShowRowFontStyles(numLetters);

    //put letters on canvas
    GetFontInfo(selectedFont);

    AddFontsToCanvas_3();
    //remove test
    //testCircle();



    //*******************************************************************************
    //****             Clicks                             **********
    //*******************************************************************************


    //*******************************************************************************
    // Num of Letters selected
   
    $('#btnLetters_3').click(function () {

        numLetters = 3;

        ShowRowFontStyles(numLetters);

        selectedFont = 'Circle';
        GetFontInfo(selectedFont);

        CleanCanvas();
        AddFontsToCanvas_3();

    });

    $('#btnLetters_2').click(function () {

        numLetters = 2;

        ShowRowFontStyles(numLetters);

        selectedFont = '2Circle';
        
        GetFontInfo(selectedFont);

        CleanCanvas();
        AddFontsToCanvas_2();

    });

    $('#btnLetters_1').click(function () {
        numLetters = 1;

        ShowRowFontStyles(numLetters);

        selectedFont = 'FISHTAIL';
        GetFontInfo(selectedFont);

        CleanCanvas();
        AddFontsToCanvas_1();

        //remove test
        //testCircle();
    });

    //*******************************************************************************
    //on click change 'Font Family'

    $('#3_Circle').click(function () {
        numLetters = 3;
        selectedFont = 'Circle';

        GetFontInfo(selectedFont);

        CleanCanvas();

        //put letters on canvas
        AddFontsToCanvas_3();

        //remove test
        //testCircle();

    });

    $('#3_Scalloped').click(function () {

        selectedFont = 'Scalloped';
        //console.log(selectedFont);

        GetFontInfo(selectedFont);

        CleanCanvas();

        //put letters on canvas
        AddFontsToCanvas_3();

        //remove test
        //testCircle();

    });

    $('#2_Circle').click(function () {
        
        numLetters = 2;

        selectedFont = '2Circle';
        
        GetFontInfo(selectedFont);

        CleanCanvas();
        AddFontsToCanvas_2();

    });

    $('#1_FishTail').click(function () {

        selectedFont = 'FISHTAIL';
        //console.log(selectedFont);
        GetFontInfo(selectedFont);

        CleanCanvas();

        //put letters on canvas
        AddFontsToCanvas_1();

        //remove test
        //testCircle();

    });

    //*******************************************************************************
    // Text box clicks

    $('#textBoxA_3').keyup(function (e) {
        //var obj = designCanvasFront.getActiveObject();
        if (textA_3 && textA_3.get('type') === 'text') {
            textA_3.set({
                text: $('#textBoxA_3').val()
            });
            //designCanvasFront.setActiveObject(designCanvasFront.item(0));
            designCanvasFront.renderAll();
        }
    });

    $('#textBoxB_3').keyup(function (e) {
        //var obj = designCanvasFront.getActiveObject();
        if (textB_3 && textB_3.get('type') === 'text') {
            textB_3.set({
                text: $('#textBoxB_3').val()
            });
            //designCanvasFront.setActiveObject(designCanvasFront.item(1));
            designCanvasFront.renderAll();
            //designCanvasFront.setActiveObject(designCanvasFront.item(designCanvasFront.getObjects().length-1));
        }
    });

    $('#textBoxC_3').keyup(function (e) {

        //var obj = designCanvasFront.getActiveObject();
        if (textC_3 && textC_3.get('type') === 'text') {
            textC_3.set({
                text: $('#textBoxC_3').val()
            });
            //designCanvasFront.setActiveObject(designCanvasFront.item(2));
            designCanvasFront.renderAll();
            //designCanvasFront.setActiveObject(designCanvasFront.item(designCanvasFront.getObjects().length-1));
        }
    });

    $('#textBox_2').keyup(function (e) {

        if (text_2 && text_2.get('type') === 'text') {  
            
            var changeChar2 = ChangeChar_2();
    
            text_2.set({ 
                text: changeChar2
            });
            
            //designCanvasFront.renderAll();
        } 
    });
    
    
    $('#textBoxA_1').keyup(function (e) {
        var textUpper = $('#textBoxA_1').val();
        var textUpper2 = textUpper.toUpperCase();

        //var obj = designCanvasFront.getActiveObject();
        if (textA_1 && textA_1.get('type') === 'text') {
            textA_1.set({
                //text: $('#textBoxA_1').val()
                text: textUpper2
            });
            //designCanvasFront.setActiveObject(designCanvasFront.item(0));
            designCanvasFront.renderAll();
        }
    });
    
    //
    //*******************************************************************************
    // Pattern Background   clicks
    $('#Aloha-Cream').click(function (e) {

        loadPattern('/Monogram/images/bgPatterns/Aloha-Cream.jpg');
        //designCanvasFront.renderAll();
    });

    $('#Galaxy').click(function (e) {
        loadPattern('/Monogram/images/bgPatterns/Galaxy.jpg');
    });

    $('#Mermaid-Scales').click(function (e) {
        loadPattern('/Monogram/images/bgPatterns/Mermaid-Scales.jpg');
    });

    //*******************************************************************************
    // Frames click
    
    $('.frames').click(function (event) { 

        var id=$(this).attr('id');
      /*  
        fontFamily_frame = id;
        fontFamily_frame_Url = 'url(fonts/'+id+'.ttf)';
        fontFamily_frame_fontSize = 400;
        fontFamily_frame_toptPx = 285;
        fontFamily_frame_leftPx = 200;
        textBoxAval_frame = 'A';
       */
        fontFamily_frame = id;
        fontFamily_frame_Url = 'url(fonts/'+id+'.ttf)';
        fontFamily_frame_fontSize = 200;
        fontFamily_frame_toptPx = 0;
        fontFamily_frame_leftPx = 0;
        textBoxAval_frame = 'A';

        frame = CanvasAddMonogramLetter(fontFamily_frame_fontSize, textBoxAval_frame, fontFamily_frame_leftPx, fontFamily_frame_toptPx,
                fontFamily_frame, fontFamily_frame_Url);
        console.log(fontFamily_frame);
        designCanvasFront.add(frame);
       
                //AddFrameToCanvas();
        
designCanvasFront.renderAll();
    });
    
    $('#A').click(function (e) {

        fontFamily_frame = 'frames2';
        fontFamily_frame_Url = 'url("fonts/frames2.ttf")';
        fontFamily_frame_fontSize = 400;
        fontFamily_frame_toptPx = 285;
        fontFamily_frame_leftPx = 200;
        textBoxAval_frame = 'A';

        textBoxFrame = CanvasAddMonogramLetter(fontFamily_frame_fontSize, textBoxAval_frame, fontFamily_frame_leftPx, fontFamily_frame_toptPx,
                fontFamily_frame, fontFamily_frame_Url);

        designCanvasFront.add(textBoxFrame);
        designCanvasFront.renderAll();
        
        

    });

    $('#C').click(function (e) {

        fontFamily_frame = 'frames_test';
        fontFamily_frame_Url = 'url("fonts/frames_test.woff")';
        fontFamily_frame_fontSize = 300;
        fontFamily_frame_toptPx = 285;
        fontFamily_frame_leftPx = 200;
        textBoxAval_frame = 'C';

        textBoxFrame = CanvasAddMonogramLetter(fontFamily_frame_fontSize, textBoxAval_frame, fontFamily_frame_leftPx, fontFamily_frame_toptPx,
                fontFamily_frame, fontFamily_frame_Url);

        designCanvasFront.add(textBoxFrame);

    });

    $('#deleteElement').click(function () {

        //var obj = designCanvasFront.getActiveObject();
        //if(obj){
        //designCanvasFront.remove(designCanvasFront.getActiveObject());
        //designCanvasFront.getActiveObject().remove();
        //items_len -= 1;
        //console.log(items_len);

        //designJson = JSON.stringify(designCanvasFront);
        //alert('go');
        //}
        //designCanvasFront.getActiveObject().remove();
        //designCanvasFront.remove(designCanvasFront.getActiveObject());
        //designCanvasFront.getActiveObject().remove();
        //designCanvasFront.renderAll();


        obj = designCanvasFront.getActiveObject();
        if (obj) {
            //remove(designCanvasFront.getActiveObject());


            designCanvasFront.remove(obj);

            //alert('del');
        }
    });

    //*******************************************************************************
    //****            Functions                            **********
    //*******************************************************************************

    function ShowRowFontStyles(numL) {


        $('#RowNumLetters_3').hide();
        $('#RowNumLetters_2').hide();
        $('#RowNumLetters_1').hide();

        $('#RowFontStyles_1').hide();
        $('#RowFontStyles_2').hide();
        $('#RowFontStyles_3').hide();

        $('#btnLetters_1').removeClass("selectedNumLetters");
        $('#btnLetters_2').removeClass("selectedNumLetters");
        $('#btnLetters_3').removeClass("selectedNumLetters");


        if (numL === 3) {
            
            //alert(numL);
            $('#btnLetters_3').addClass("selectedNumLetters");
            $('#RowFontStyles_3').show();
            $('#RowNumLetters_3').show();
        }
        if (numL === 2) {
            $('#btnLetters_2').addClass("selectedNumLetters");
            $('#RowFontStyles_2').show();
            $('#RowNumLetters_2').show();
        }
        if (numL === 1) {
            $('#btnLetters_1').addClass("selectedNumLetters");
            $('#RowFontStyles_1').show();
            $('#RowNumLetters_1').show();
        }
    }
    
    function AddFontsToCanvas_3_w() {

        textBoxVal_3 = ChangeChar_2();
        
        text_2 = CanvasAddMonogramLetter(fontFamily_2_fontSize, textBoxVal_2, fontFamily_2_leftPx, fontFamily_2_toptPx, fontFamily_2, fontFamily_2_Url);
        designCanvasFront.add(text_2);
        
        //var obj = canvas.getActiveObject();
        
        //text_2.center();
        //text_2.setCoords();
        designCanvasFront.renderAll();
    }
    

    function AddFontsToCanvas_3() {

        textBoxAval_3 = $('#textBoxA_3').val();
        textBoxBval_3 = $('#textBoxB_3').val();
        textBoxCval_3 = $('#textBoxC_3').val();
        
        console.log('textBoxAval_3 ' + $('#textBoxA_3').val());
        console.log('textBoxBval_3 ' + textBoxBval_3);
        console.log('textBoxCval_3 ' + textBoxCval_3); 

        textA_3 = CanvasAddMonogramLetter(fontFamily_3_1_fontSize, textBoxAval_3, fontFamily_3_1_leftPx, fontFamily_3_1_toptPx, fontFamily_3_1, fontFamily_3_1_Url);
        textB_3 = CanvasAddMonogramLetter(fontFamily_3_2_fontSize, textBoxBval_3, fontFamily_3_2_leftPx, fontFamily_3_2_toptPx, fontFamily_3_2, fontFamily_3_2_Url);
        textC_3 = CanvasAddMonogramLetter(fontFamily_3_3_fontSize, textBoxCval_3, fontFamily_3_3_leftPx, fontFamily_3_3_toptPx, fontFamily_3_3, fontFamily_3_3_Url);

        designCanvasFront.add(textA_3);
        designCanvasFront.add(textB_3);       
        designCanvasFront.add(textC_3);
    }

    function ChangeChar_2(){
        var textInField = $('#textBox_2').val();   
        if (textInField.length === 2) {
            var firstChar = textInField.charAt(0).toUpperCase();
            var secondChar = textInField.charAt(1).toLowerCase();
            textInField = firstChar + secondChar;
        }
        
        return textInField;
    }

    function AddFontsToCanvas_2() {

        textBoxVal_2 = ChangeChar_2();
        
        text_2 = CanvasAddMonogramLetter(fontFamily_2_fontSize, textBoxVal_2, fontFamily_2_leftPx, fontFamily_2_toptPx, fontFamily_2, fontFamily_2_Url);
        designCanvasFront.add(text_2);
        
        //var obj = canvas.getActiveObject();
        
        //text_2.center();
        //text_2.setCoords();
        designCanvasFront.renderAll();
    }
   
    function AddFontsToCanvas_1() {

        var textUpper = $('#textBoxA_1').val();
        textBoxAval_1 = textUpper.toUpperCase();

        textA_1 = CanvasAddMonogramLetter(fontFamily_1_fontSize, textBoxAval_1, fontFamily_1_leftPx, fontFamily_1_toptPx, fontFamily_1, fontFamily_1_Url);

        designCanvasFront.add(textA_1);
        
        //textA_1.center();
        //textA_1.setCoords();
        designCanvasFront.renderAll();
       

    }

    function AddFrameToCanvas() {
        //alert('hi');
        fontFamily_frame = 'frames_test';
        fontFamily_frame_Url = 'url("fonts/frames_test.woff")';
        fontFamily_frame_fontSize = 200;
        fontFamily_frame_toptPx = 0;
        fontFamily_frame_leftPx = 0;
        textBoxAval_frame = 'D';

        frame = CanvasAddMonogramLetter(fontFamily_frame_fontSize, textBoxAval_frame, fontFamily_frame_leftPx, fontFamily_frame_toptPx,
                fontFamily_frame, fontFamily_frame_Url);

        designCanvasFront.add(frame);
        
        //frame.center();
        //frame.setCoords();
        //designCanvasFront.renderAll();

    }

    function GetFontInfo(style) {

        fontFamily_3_1 = '';
        fontFamily_3_1_Url = '';
        fontFamily_3_1_fontSize = 0;
        fontFamily_3_1_toptPx = 0;
        fontFamily_3_1_leftPx = 0;

        fontFamily_3_2 = '';
        fontFamily_3_2_Url = '';
        fontFamily_3_2_fontSize = 0;
        fontFamily_3_2_toptPx = 0;
        fontFamily_3_2_leftPx = 0;

        fontFamily_3_3 = '0';
        fontFamily_3_3_Url = '0';
        fontFamily_3_3_fontSize = 0;
        fontFamily_3_3_toptPx = 0;
        fontFamily_3_3_leftPx = 0;

        console.log('numLetters ' + numLetters + ' style ' + style);

        if (numLetters === 3) {
            if (style === 'Circle') {

                fontFamily_3_1 = 'Circle Monogram Left';
                fontFamily_3_1_Url = 'url("fonts/CircleMonogramLeft-Regular.ttf")';
                fontFamily_3_1_fontSize = 300;
                fontFamily_3_1_leftPx = 244;
                fontFamily_3_1_toptPx = 240;

                fontFamily_3_2 = 'Circle Monogram Mid';
                fontFamily_3_2_Url = 'url("fonts/CircleMonogramMid-Regular.ttf")';
                fontFamily_3_2_fontSize = 300;
                fontFamily_3_2_leftPx = 317;
                fontFamily_3_2_toptPx = 240;

                fontFamily_3_3 = 'Circle Monogram Right';
                fontFamily_3_3_Url = 'url("fonts/CircleMonogramRight-Regular.ttf")';
                fontFamily_3_3_fontSize = 300;
                fontFamily_3_3_leftPx = 396;
                fontFamily_3_3_toptPx = 240;
            }

            if (style === 'Scalloped') {
                fontFamily_3_1 = 'Scalloped Left';
                fontFamily_3_1_Url = 'url("fonts/Scalloped Left Left.ttf")';
                fontFamily_3_1_fontSize = 220;
                fontFamily_3_1_leftPx = 240;
                fontFamily_3_1_toptPx = 273;

                fontFamily_3_2 = 'Scalloped Mid';
                fontFamily_3_2_Url = 'url("fonts/Scalloped Mid Mid.ttf")';
                fontFamily_3_2_fontSize = 220;
                fontFamily_3_2_leftPx = 317;
                fontFamily_3_2_toptPx = 273;

                fontFamily_3_3 = 'Scalloped Right';
                fontFamily_3_3_Url = 'url("fonts/Scalloped Right Right.ttf")';
                fontFamily_3_3_fontSize = 220;
                fontFamily_3_3_leftPx = 400;
                fontFamily_3_3_toptPx = 273;
            }
        }
        if (numLetters === 2) {

            if (style === '2Circle') {
                fontFamily_2 = 'Two Letter Circle Monogram';
                fontFamily_2_Url = 'url("fonts/Two Letter Circle Monogram.ttf")';
                fontFamily_2_fontSize = 300;
                fontFamily_2_leftPx = 240;
                fontFamily_2_toptPx = 240;
                
            }
            
            
            
        }
        if (numLetters === 1) {

            if (style === 'FISHTAIL') {
                fontFamily_1 = 'FISHTAIL FONT';
                fontFamily_1_Url = 'url("fonts/FISHTAIL FONT.ttf")';
                fontFamily_1_fontSize = 300;
                fontFamily_1_leftPx = 100;
                fontFamily_1_toptPx = 250;
            }
            
            if (style === 'CircleAll') {
                fontFamily_1 = 'FISHTAIL FONT';
                fontFamily_1_Url = 'url("fonts/FISHTAIL FONT.ttf")';
                fontFamily_1_fontSize = 300;
                fontFamily_1_leftPx = 100;
                fontFamily_1_toptPx = 250;
            }
        }

        //console.log('style ' + style + '== ' + fontFamily_3_1 + ' ' + fontFamily_3_1_Url  + fontFamily_3_2 + ' ' + fontFamily_3_2_Url);

    }


    //*******************************************************************************
    // get NUM fonts

    function CanvasAddMonogramLetter(fontSize, letter, leftPx, topPx, fontFamilyName, urlName) {
        
        console.log('CanvasAddMonogramLetter: ' + letter);
        var textABC = new fabric.Text(letter, {
            fontSize: fontSize,
            left: leftPx,
            top: topPx,
            lineHeight: 1,
            originX: 'left',
            fontFamily: fontFamilyName,
            src: urlName,
            fontWeight: 'normal',
            statefullCache: true,
            scaleX: 1,
            scaleY: 1
        });

        return textABC;       
    }

    function CleanCanvas() {

        designCanvasFront.getObjects().concat().forEach(function (obj) {
            designCanvasFront.remove(obj);
        });

       
    }

    /*function GroupLetters() {
     
     var group = new fabric.Group([textA, textB, textC]);
     designCanvasFront.add(group);
     designCanvasFront.setActiveObject(group);
     }
     */

    function canvasChange() {
        designCanvasFront.forEachObject(function (obj) {
            console.log(obj);
        })
    }

    function loadPattern(url) {
        
        obj = designCanvasFront.getActiveObject();
            if (!obj){
                alert('Please Make a Selection.');
            }
            
            if (obj) {
                
                //if (obj.type === 'text') {
                //console.log('obj is text ');
                fabric.util.loadImage(url, function (img) {
                    obj.set('fill', new fabric.Pattern({
                        source: img,
                        repeat: 'repeat'
                    }));

                    designCanvasFront.renderAll();
                });
            //}
        }  
    }

    function testCircle() {
        fabric.Image.fromURL('images/frames/simpleRound.svg', function (img) {
            var oImg = img.set({left: 200, top: 250});
            oImg.scale(1);
            designCanvasFront.add(oImg);

        });
    }


});