
$(function () {


    window.canvas = new fabric.Canvas('canvasFront');

    window.canvas = new fabric.Canvas('canvasFront', {preserveObjectStacking: true});
    //window.appURL = "http://webpagezone.com/Monogram/";
    //window.appURL = "http://localhost:8500/Monogram/";
    var _curFonts = "";


    //fabric.Object.prototype.transparentCorners = false;

    //*******************************************************************************
    //default values 
    window.items_len = 0;

    var numLetters = 3;

    var selectedFont = 'Circle';


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


    var obj = canvas.getActiveObject();

    //var textGroup;
    //*******************************************************************************
    //on load functions

    //AddFrameToCanvas();

    //Left Menu show Num of letters

    //Left Menu show font styles for num of fonts
    ShowMonogramFontStyle(numLetters);

    //put letters on canvas
    GetFontInfo(selectedFont);

    testCircle();

    AddFontsToCanvas_3();
    //remove test





    //*******************************************************************************
    //****             Clicks                             **********
    //*******************************************************************************


    //*******************************************************************************
    // Num of Letters selected

    $('#btnLetters_3').click(function () {

        numLetters = 3;

        ShowMonogramFontStyle(numLetters);

        selectedFont = 'Circle';
        GetFontInfo(selectedFont);

        ChangeFontStyle();
        AddFontsToCanvas_3();

    });

    $('#btnLetters_2').click(function () {

        numLetters = 2;

        ShowMonogramFontStyle(numLetters);

        selectedFont = '2Circle';

        GetFontInfo(selectedFont);

        ChangeFontStyle();
        AddFontsToCanvas_2();

    });

    $('#btnLetters_1').click(function () {
        numLetters = 1;

        ShowMonogramFontStyle(numLetters);

        selectedFont = 'FISHTAIL';
        GetFontInfo(selectedFont);

        ChangeFontStyle();
        AddFontsToCanvas_1();

        //remove test
        //testCircle();
    });

    //*******************************************************************************
    //on click change 'Font Family'


    $('input[name=FontStyle]:radio').on('change', function (e) {

        numLetters = 3;
        selectedFont = $('input[name=FontStyle]:checked').val();
        console.log(selectedFont);
        //selectedFont = 'Scalloped';
        //console.log(selectedFont);

        GetFontInfo(selectedFont);

        ChangeFontStyle();

        //put letters on canvas
        AddFontsToCanvas_3();

        //remove test
        //testCircle();

    });
    /*
     $('#3_Circle').click(function () {
     numLetters = 3;
     selectedFont = 'Circle';
     
     GetFontInfo(selectedFont);
     
     ChangeFontStyle();
     
     AddFontsToCanvas_3();
     
     });
     
     $('#3_Scalloped').click(function () {
     
     selectedFont = 'Scalloped';
     
     GetFontInfo(selectedFont);
     
     ChangeFontStyle();
     
     AddFontsToCanvas_3();
     
     });
     */
    $('#2_Circle').click(function () {

        //numLetters = 2;

        selectedFont = '2Circle';

        GetFontInfo(selectedFont);

        ChangeFontStyle();
        AddFontsToCanvas_2();

    });

    $('#1_FishTail').click(function () {

        selectedFont = 'FISHTAIL';
        //console.log(selectedFont);
        GetFontInfo(selectedFont);

        ChangeFontStyle();

        //put letters on canvas
        AddFontsToCanvas_1();


        //remove test
        //testCircle();
        //testCircle();
    });

    $('#1_ARHERMANN').click(function () {

        selectedFont = 'ARHERMANN';
        //console.log(selectedFont);
        GetFontInfo(selectedFont);

        ChangeFontStyle();

        //put letters on canvas
        AddFontsToCanvas_1();

        //remove test
        testCircle();

    });


    //*******************************************************************************
    // Text box clicks

    $('#textBoxA_3').keyup(function (e) {
        if (textA_3 && textA_3.get('type') === 'text') {
            var textUpper = $('#textBoxA_3').val().toUpperCase();
            textA_3.set({
                text: textUpper
            });
            canvas.renderAll();
        }
    });

    $('#textBoxB_3').keyup(function (e) {
        if (textB_3 && textB_3.get('type') === 'text') {
            var textLower = $('#textBoxB_3').val().toLowerCase();
            textB_3.set({
                text: textLower
            });
            canvas.renderAll();
        }
    });

    $('#textBoxC_3').keyup(function (e) {

        //var obj = canvas.getActiveObject();
        if (textC_3 && textC_3.get('type') === 'text') {
            textC_3.set({
                text: $('#textBoxC_3').val()
            });
            //canvas.setActiveObject(canvas.item(2));
            canvas.renderAll();
            //canvas.setActiveObject(canvas.item(canvas.getObjects().length-1));
        }
    });

    $('#textBox_2').keyup(function (e) {

        if (text_2 && text_2.get('type') === 'text') {

            var changeChar2 = ChangeChar_2();

            text_2.set({
                text: changeChar2
            });

            //canvas.renderAll();
        }
    });


    $('#textBoxA_1').keyup(function (e) {
        var textUpper = $('#textBoxA_1').val();
        var textUpper2 = textUpper.toUpperCase();

        //var obj = canvas.getActiveObject();
        if (textA_1 && textA_1.get('type') === 'text') {
            textA_1.set({
                //text: $('#textBoxA_1').val()
                text: textUpper2
            });
            //canvas.setActiveObject(canvas.item(0));
            canvas.renderAll();
        }
    });

    //
    //*******************************************************************************
    // Pattern Background   clicks
    //$('input:radio[name=sex]:checked').val());



    $("#bgColorDiv input[name='bgPattern']").click(function () {

        var id = $("input[name='bgPattern']:checked").val();
        var patternUrl = "../Monogram/images/bgPatterns/" + id + ".jpg";

        console.log(patternUrl);
        loadPattern(patternUrl);
    });


    //$("#inline_content input[name='type']").click(function(){
    //alert('You clicked radio!');

    /* $('#Aloha-Cream').click(function (e) {
     
     loadPattern('/Monogram/images/bgPatterns/Aloha-Cream.jpg');
     //canvas.renderAll();
     });
     
     $('#Galaxy').click(function (e) {
     loadPattern('/Monogram/images/bgPatterns/Galaxy.jpg');
     });
     
     $('#Mermaid-Scales').click(function (e) {
     loadPattern('/Monogram/images/bgPatterns/Mermaid-Scales.jpg');
     });
     */

    //*******************************************************************************
    // Frames click

    $('.frames').click(function (event) {

        var id = $(this).attr('id');
        console.log(id);
        var svgUrl = "../Monogram/images/frames/" + id + ".svg";
        var leftpx = 240;
        var toppx = 240;

        if (id === 'FrameCircle') {
            leftpx = 217;
            toppx = 265;
        }

        if (id === 'Frame_crab_circle' || id === 'Frame_crab_full') {
            leftpx = 52;
            toppx = 43;
        }

        fabric.loadSVGFromURL(svgUrl, function (objects, options) {
            var obj = fabric.util.groupSVGElements(objects, options);
            obj.set({
                left: leftpx,
                top: toppx
            });
            canvas.add(obj).renderAll();
        });

        var objects = canvas.getObjects();
        console.log(objects.length);

        //canvas.setActiveObject(canvas.item(objects.length));

    });

    $('#deleteElement').click(function () {

        obj = canvas.getActiveObject();
        if (obj) {
            canvas.remove(obj);
        }

    });

    $('#moveBack').click(function () {

        var obj = canvas.getActiveObject();
        if (obj) {
            canvas.sendToBack(obj);

        }
        canvas.renderAll();
    });

    //canvas.on('object:selected', function(event) {
    //    var object = event.target;
    //    canvas.sendToBack(object);
    //object.sendToBack();
    //     console.log("Selected");
    //});

    //canvas.bringToFront(object) 
//canvas.bringForward(object)
//canvas.sendToBack(object)
//canvas.sendBackwards(object)


    //*******************************************************************************
    //****            Functions                            **********
    //*******************************************************************************

    function ShowMonogramFontStyle(numL) {



        $('#EditInitials_3').hide();
        $('#EditInitials_2').hide();
        $('#EditInitials_1').hide();

        $('#MonogramFontStyle_1').hide();
        $('#MonogramFontStyle_2').hide();
        $('#MonogramFontStyle_3').hide();

        $('#btnLetters_1').removeClass("selectedNumLetters");
        $('#btnLetters_2').removeClass("selectedNumLetters");
        $('#btnLetters_3').removeClass("selectedNumLetters");


        if (numL === 3) {

            $('#btnLetters_3').addClass("selectedNumLetters");
            $('#MonogramFontStyle_3').show();
            $('#EditInitials_3').show();
        }
        if (numL === 2) {
            $('#btnLetters_2').addClass("selectedNumLetters");
            $('#MonogramFontStyle_2').show();
            $('#EditInitials_2').show();
        }
        if (numL === 1) {
            $('#btnLetters_1').addClass("selectedNumLetters");
            $('#MonogramFontStyle_1').show();
            $('#EditInitials_1').show();
        }

    }

    function AddFontsToCanvas_3() {

        textBoxAval_3 = $('#textBoxA_3').val();
        textBoxBval_3 = $('#textBoxB_3').val();
        textBoxCval_3 = $('#textBoxC_3').val();

        console.log('textBoxAval_3 ' + $('#textBoxA_3').val() + ' ' + fontFamily_3_1_Url);
        console.log('textBoxBval_3 ' + textBoxBval_3);
        console.log('textBoxCval_3 ' + textBoxCval_3);

        textA_3 = CanvasAddMonogramLetter(fontFamily_3_1_fontSize, textBoxAval_3, fontFamily_3_1_leftPx, fontFamily_3_1_toptPx, fontFamily_3_1, fontFamily_3_1_Url);
        textB_3 = CanvasAddMonogramLetter(fontFamily_3_2_fontSize, textBoxBval_3, fontFamily_3_2_leftPx, fontFamily_3_2_toptPx, fontFamily_3_2, fontFamily_3_2_Url);
        textC_3 = CanvasAddMonogramLetter(fontFamily_3_3_fontSize, textBoxCval_3, fontFamily_3_3_leftPx, fontFamily_3_3_toptPx, fontFamily_3_3, fontFamily_3_3_Url);

        //canvas.add(textA_3);
        // canvas.add(textB_3);       
        //canvas.add(textC_3);

        canvas.add(new fabric.Group([textA_3, textB_3, textC_3]));
    }

    function ChangeChar_2() {
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
        canvas.add(text_2);

        //var obj = canvas.getActiveObject();

        //text_2.center();
        //text_2.setCoords();
        canvas.renderAll();
    }

    function AddFontsToCanvas_1() {

        var textUpper = $('#textBoxA_1').val();
        textBoxAval_1 = textUpper.toUpperCase();

        textA_1 = CanvasAddMonogramLetter(fontFamily_1_fontSize, textBoxAval_1, fontFamily_1_leftPx, fontFamily_1_toptPx, fontFamily_1, fontFamily_1_Url);

        canvas.add(textA_1);

        //textA_1.center();
        //textA_1.setCoords();
        canvas.renderAll();


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

            /*
             if (style === 'Circle') {
             
             fontFamily_3_1 = 'CircleMonogramAll';
             fontFamily_3_1_Url = 'url("fonts/CircleMonogramAll.ttf")';
             fontFamily_3_1_fontSize = 300;
             fontFamily_3_1_leftPx = 244;
             fontFamily_3_1_toptPx = 240;
             
             fontFamily_3_2 = 'CircleMonogramAll';
             fontFamily_3_2_Url = 'url("fonts/CircleMonogramAll.ttf")';
             fontFamily_3_2_fontSize = 300;
             fontFamily_3_2_leftPx = 317;
             fontFamily_3_2_toptPx = 240;
             
             fontFamily_3_3 = 'CircleMonogramAll';
             fontFamily_3_3_Url = 'url("fonts/CircleMonogramAll.ttf")';
             fontFamily_3_3_fontSize = 300;
             fontFamily_3_3_leftPx = 396;
             fontFamily_3_3_toptPx = 240;
             }
             */
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
                fontFamily_1_fontSize = 240;
                fontFamily_1_leftPx = 295;
                fontFamily_1_toptPx = 250;
            }
        }

        //console.log('style ' + style + '== ' + fontFamily_3_1 + ' ' + fontFamily_3_1_Url  + fontFamily_3_2 + ' ' + fontFamily_3_2_Url);

    }


    //*******************************************************************************
    // get NUM fonts

    function CanvasAddMonogramLetter(fontSize, letter, leftPx, topPx, fontFamilyName, urlName) {

        //console.log('CanvasAddMonogramLetter: ' + letter);
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

    function ChangeFontStyle() {
        canvas.getObjects().concat().forEach(function (obj) {
            if (obj.type === 'text') {
                canvas.remove(obj);
            }
        });
    }

    function remove_object() {

        if (canvas.getActiveGroup())
        {
            canvas.getActiveGroup().forEachObject(function (o) {
                canvas.remove(o);
            });
            canvas.discardActiveGroup();
        }
        else
        {
            canvas.remove(canvas.getActiveObject());
            canvas.discardActiveObject();
        }
        canvas.renderAll();
        canvas.calcOffset();
    }

    /*obj.getObjects().forEach(function (o) {
     o.set('fill', new fabric.Pattern({
     source: img,
     repeat: 'repeat'
     }));
     canvas.renderAll();
     });
     }*/

    function CleanCanvas() {

        canvas.getObjects().concat().forEach(function (obj) {
            canvas.remove(obj);
        });
    }

    // delete key selected
    /* $(document).keydown(function (e) {
     var keyPressed = String.fromCharCode(e.which);
     
     console.log();
     if (e.which == 46) //delete
     {
     var obj = canvas.getActiveObject();
     canvas.remove(obj);
     }
     });
     */


    function loadPattern(patternUrl) {
        console.log(canvas.toSVG());
        var obj = canvas.getActiveObject();

        var pattern = new fabric.Pattern({
            source: patternUrl,
            repeat: 'repeat'});

        if (!obj) {
            alert('Please Make a Selection.');
        }

        if (obj == null) {
            console.log('obj.type ' + obj.type);
            return;
        }


        //text group
        if (obj.type === 'group') {
            console.log('obj.type ' + obj.type);
            obj.getObjects().forEach(function (o) {

                if (o.type === 'text') {
                    console.log(' obj.type ' + o.type);
                    //if (obj.type === 'text') {
                    //console.log('obj is text ');
                    fabric.util.loadImage(patternUrl, function () {
                        o.set('fill', pattern);
                        canvas.renderAll();
                    });
                }
            });
        }

        else {

            console.log('obj.type ' + obj.type);

            fabric.util.loadImage(patternUrl, function () {
                obj.set('fill', pattern);

                canvas.renderAll();
            });
        }
    }

    function testCircle() {
        var svgUrl = "../Monogram/images/frames/FrameCircle.svg";

        fabric.loadSVGFromURL(svgUrl, function (objects, options) {
            var obj = fabric.util.groupSVGElements(objects, options);
            obj.set({
                left: 217,
                top: 265

            });
            canvas.add(obj).renderAll();
        });
    }

    function FrameEmpty() {
        var svgUrl = "../Monogram/images/frames/FrameEmpty.svg";

        fabric.loadSVGFromURL(svgUrl, function (objects, options) {
            var obj = fabric.util.groupSVGElements(objects, options);
            obj.set({
                left: 218,
                top: 266

            });
            canvas.add(obj).renderAll();
        });
    }

});


  