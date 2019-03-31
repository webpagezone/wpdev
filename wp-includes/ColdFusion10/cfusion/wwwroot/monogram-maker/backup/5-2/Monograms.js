$(document).ready(function () {
    // FabricJS scripts
    var fontCircleSimple = new FontFaceObserver('CircleSimple');

    fontCircleSimple.load().then(function () {
        console.log('CircleSimple has loaded.');
    });
    
    var fontCircleScalloped = new FontFaceObserver('CircleScalloped');

    fontCircleScalloped.load().then(function () {
        console.log('CircleScalloped has loaded.');
    });
    
    var fontCircleTwoLetter = new FontFaceObserver('CircleTwoLetter');

    fontCircleTwoLetter.load().then(function () {
        console.log('CircleTwoLetter has loaded.');
    });

    $(function () {

        //window.canvas = new fabric.Canvas('canvasFront');

        window.canvas = new fabric.Canvas('canvasFront', {preserveObjectStacking: true});

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

        var textBox_1;
        var textBoxVal_1 = '';

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


        var obj = canvas.getActiveObject();

        //var textGroup;
        //*******************************************************************************
        //on load functions

        //Left Menu show Num of letters

        //Left Menu show font styles for num of fonts
        ShowEditInitials(numLetters);

        //put letters on canvas
        GetFontInfo(selectedFont);

        setTimeout(function () {

            AddFontsToCanvas_3();

        }, 1000);

testCircle();
        //*******************************************************************************
        //****             Clicks                             **********
        //*******************************************************************************

//RowFontStyle
//RowEditInitials
//RowGbPatterns
//RowFrames

        $("#bgFontStyleDiv input[name='bgFontStyle']").click(function () {

            var id = $("input[name='bgFontStyle']:checked").val();

            if (id === 'CircleSimple') {
                numLetters = 3;
                ShowEditInitials(numLetters);
                GetFontInfo(id);
                RemoveText();

                AddFontsToCanvas_3();
            }

            if (id === 'CircleScalloped') {
                numLetters = 3;
                ShowEditInitials(numLetters);
                GetFontInfo(id);

                RemoveText();

                AddFontsToCanvas_3();
            }

            if (id === 'CircleTwoLetter') {
                numLetters = 2;
                ShowEditInitials(numLetters);
                GetFontInfo(id);
                RemoveText();
                AddFontsToCanvas_2();
            }

             if (id === 'Vine') {
                numLetters = 1;
                ShowEditInitials(numLetters);
                GetFontInfo(id);
                RemoveText();
                AddFontsToCanvas_1();
            }
        });



        //*******************************************************************************
        // Text box clicks

        $('#textBox_3').keyup(function (e) {
            if (text_3 && text_3.get('type') === 'text') {

                changeChar3 = ChangeChar_3();

                text_3.set({
                    //text: $('#text_3').val()
                    text: changeChar3
                });
                canvas.renderAll();


            }
        });


        $('#textBox_2').keyup(function (e) {

            if (text_2 && text_2.get('type') === 'text') {

                var changeChar2 = ChangeChar_2();

                text_2.set({
                    text: changeChar2
                });

                canvas.renderAll();
            }
        });


        $('#textBox_1').keyup(function (e) {
            var textUpper = $('#textBox_1').val();
            var textUpper2 = textUpper.toUpperCase();

            //var obj = canvas.getActiveObject();
            if (text_1 && text_1.get('type') === 'text') {
                text_1.set({
                    //text: $('#textBox_1').val()
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
            //alert(id);
            var patternUrl = "../monogram-maker/images/bgPatterns/" + id + ".jpg";

            //console.log(patternUrl);
            loadPattern(patternUrl);
        });

        //*******************************************************************************
        // Frames click

        $('#fontLayer').click(function () {

            var objects = canvas.getObjects(); //return Array<objects>

            objects.forEach(function (o) {

                //console.log(o.type);
                if (o.type === "text") {

                    canvas.setActiveObject(o);
                    canvas.renderAll();
                }
            });
        });

        $('#frameLayer').click(function () {
            var objects = canvas.getObjects(); //return Array<objects>

            objects.forEach(function (o) {

                //console.log(o.type);
                if (o.type != "text") {

                    canvas.setActiveObject(o);
                    canvas.renderAll();
                }

            });

        });

        $("#bgFrameDiv input[name='bgFrame']").click(function () {

            RemoveFrame();
            
            var id = $("input[name='bgFrame']:checked").val();
            //console.log(id);
            var svgUrl = "../monogram-maker/images/frames/" + id + ".svg";

            var leftpx = 215;
            var toppx = 262;

            if (id === 'Frame-001a-Circle') {
                leftpx = 217;
                toppx = 265;
                width = 100;
            }

            if (id === 'Frame_crab_circle' || id === 'Frame_crab_full') {
                leftpx = 30;
                toppx = -10;
            }

            fabric.loadSVGFromURL(svgUrl, function (objects, options) {
                var obj = fabric.util.groupSVGElements(objects, options);

                /*obj.set({
                    left: leftpx,
                    top: toppx
                });*/
                canvas.add(obj);

                obj.center();
                obj.setCoords();

                canvas.setActiveObject(obj);
                canvas.sendToBack(obj);
                canvas.renderAll();

            });

        });

        $('#deleteElement').click(function () {
            //alert('delete');
            obj = canvas.getActiveObject();
            if (obj) {
                canvas.remove(obj);
            }
            canvas.renderAll();
        });

        $('#moveBack').click(function () {
            //alert('move back');
            obj = canvas.getActiveObject();
            if (obj) {
                canvas.sendToBack(obj);
            }
            canvas.renderAll();
        });

        $('#downloadPng').click(function () {

            canvas.discardActiveObject().renderAll();
            //canvas.deactivateAll().renderAll();
            $("#canvasFront").get(0).toBlob(function (blob) {
                saveAs(blob, "myMonogram.png");
            });

        });
        //*******************************************************************************
        //****            Functions                            **********
        //*******************************************************************************

        function ShowEditInitials(numL) {

            $('#EditInitials_3').hide();
            $('#EditInitials_2').hide();
            $('#EditInitials_1').hide();

            if (numL === 3) {
                $('#EditInitials_3').show();
            }
            if (numL === 2) {
                $('#EditInitials_2').show();
            }
            if (numL === 1) {
                $('#EditInitials_1').show();
            }
        }

        function ChangeChar_3() {

            var textInField = $('#textBox_3').val();

            console.log('textInField lenght ' + textInField.length);
            
            if (textInField.length === 3) {
                var i;
                for (i = 0; i < 3; i++) {
                    if (i === 0) {
                        var firstChar = textInField.charAt(0).toUpperCase();
                    }
                    if (i === 1) {
                        var secondChar = textInField.charAt(1).toLowerCase();
                    }
                    if (i === 2) {
                        var thirdChar = textInField.charAt(2).toUpperCase();
                    }



                }

                console.log(firstChar + secondChar + thirdChar);

                switch (secondChar) {

                    case "A":
                        secondChar = "a";
                        break;

                    case "B":
                        secondChar = "b";
                        break;
                    case "C":
                        secondChar = "c";
                        break;
                    case "D":
                        secondChar = "d";
                        break;
                    case "E":
                        secondChar = "e";
                        break;
                    case "F":
                        secondChar = "F";
                        break;
                    case "G":
                        secondChar = "G";
                        break;
                    case "H":
                        secondChar = "h";
                        break;
                    case "I":
                        secondChar = "i";
                        break;
                    case "J":
                        secondChar = "j";
                        break;
                    case "K":
                        secondChar = "k";
                        break;
                    case "L":
                        secondChar = "l";
                        break;
                    case "M":
                        secondChar = "m";
                        break;
                    case "N":
                        secondChar = "n";
                        break;
                    case "O":
                        secondChar = "o";
                        break;
                    case "P":
                        secondChar = "p";
                        break;
                    case "Q":
                        secondChar = "q";
                        break;
                    case "R":
                        secondChar = "r";
                        break;
                    case "S":
                        secondChar = "s";
                        break;
                    case "T":
                        secondChar = "t";
                        break;

                    case "U":
                        secondChar = "u";
                        break;
                    case "V":
                        secondChar = "v";
                        break;
                    case "W":
                        secondChar = "w";
                        break;
                    case "X":
                        secondChar = "x";
                        break;
                    case "Y":
                        secondChar = "y";
                        break;
                    case "Z":
                        secondChar = "z";
                        break;
                }


                switch (thirdChar) {
                    case "A":

                        thirdChar = "#";
                        break;
                    case "B":
                        thirdChar = "$";
                        break;
                    case "C":
                        thirdChar = "%";
                        break;
                    case "D":
                        thirdChar = "&";
                        break;
                    case "E":
                        thirdChar = "'";
                        break;
                    case "F":
                        thirdChar = "(";
                        break;
                    case "G":
                        thirdChar = ")";
                        break;
                    case "H":
                        thirdChar = "*";
                        break;
                    case "I":
                        thirdChar = "+";
                        break;
                    case "J":
                        thirdChar = ",";
                        break;
                    case "K":
                        thirdChar = "-";
                        break;
                    case "L":
                        thirdChar = ".";
                        break;
                    case "M":
                        thirdChar = "/";
                        break;
                    case "N":
                        thirdChar = "0";
                        break;
                    case "O":
                        thirdChar = "1";
                        break;
                    case "P":
                        thirdChar = "2";
                        break;
                    case "Q":
                        thirdChar = "3";
                        break;
                    case "R":
                        thirdChar = "4";
                        break;
                    case "S":
                        thirdChar = "5";
                        break;
                    case "T":
                        thirdChar = "6";
                        break;
                    case "U":
                        thirdChar = "7";
                        break;
                    case "V":
                        thirdChar = "8";
                        break;
                    case "W":
                        thirdChar = "9";
                        break;
                    case "X":
                        thirdChar = ":";
                        break;
                    case "Y":
                        thirdChar = ";";
                        break;
                    case "Z":
                        thirdChar = "<";
                        break;
                }
            }
           

            textInField = firstChar + secondChar + thirdChar;

            return textInField;
        }

        function AddFontsToCanvas_3() {

            //textBoxVal_3 = $('#textBox_3').val();
            //console.log('add fonts ' + fontFamily_3);

            textBoxVal_3 = ChangeChar_3();

            text_3 = CanvasAddMonogramLetter(fontFamily_3_fontSize, textBoxVal_3, fontFamily_3_leftPx, fontFamily_3_toptPx, fontFamily_3, fontFamily_3_Url);

            //canvas.add(text_3).setActiveObject(text_3);
            canvas.add(text_3);
            //text_3.center();
            //text_3.setCoords();

            canvas.setActiveObject(text_3);
            loadAndUse(fontFamily_3);

            canvas.renderAll();
            //canvas.add(textbox).setActiveObject(textbox);

            //canvas.add(new fabric.Group([textA_3, textB_3, textC_3]));
        }

        function ChangeChar_2() {
            var textInField = $('#textBox_2').val();

            console.log('textInField ' + textInField);
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

            canvas.add(text_2)
            canvas.setActiveObject(text_2);
            loadAndUse(fontFamily_2);
            canvas.renderAll();

            //var obj = canvas.getActiveObject();

            //text_2.center();
            //text_2.setCoords();
            //canvas.renderAll();
        }

        function AddFontsToCanvas_1() {

            var textUpper = $('#textBox_1').val();
            textBoxVal_1 = textUpper.toUpperCase();

            text_1 = CanvasAddMonogramLetter(fontFamily_1_fontSize, textBoxVal_1, fontFamily_1_leftPx, fontFamily_1_toptPx, fontFamily_1, fontFamily_1_Url);

            canvas.add(text_1);
            canvas.setActiveObject(text_1);
            loadAndUse(fontFamily_1);
            //canvas.renderAll();
            //canvas.add(obj).renderAll();
            text_1.center();
            text_1.setCoords();
            canvas.renderAll();


        }

        function GetFontInfo(style) {


            console.log('Get Info: numLetters ' + numLetters + ' style ' + style);

            if (numLetters === 3) {

                if (style === 'CircleSimple') {

                    fontFamily_3 = 'CircleSimple';
                    fontFamily_3_Url = 'url("fonts/CircleSimple.ttf")';
                    fontFamily_3_fontSize = 300;
                    fontFamily_3_leftPx = 218;
                    fontFamily_3_toptPx = 190;

                }

                if (style === 'CircleScalloped') {

                    fontFamily_3 = 'CircleScalloped';
                    fontFamily_3_Url = 'url("fonts/CircleScalloped.ttf")';
                    fontFamily_3_fontSize = 220;
                    fontFamily_3_leftPx = 214;
                    fontFamily_3_toptPx = 222;
                }

            }

            if (numLetters === 2) {

                if (style === 'CircleTwoLetter') {
                    fontFamily_2 = 'CircleTwoLetter';
                    fontFamily_2_Url = 'url("fonts/CircleTwoLetter.ttf")';
                    fontFamily_2_fontSize = 300;
                    fontFamily_2_leftPx = 218;
                    fontFamily_2
                    _toptPx = 190;

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

                if (style === 'Vine') {
                    fontFamily_1 = 'Vine';
                    fontFamily_1_Url = 'url("fonts/Vine.ttf")';
                    fontFamily_1_fontSize = 200;
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

        function RemoveText() {
            canvas.getObjects().concat().forEach(function (obj) {
                if (obj.type === 'text') {
                    canvas.remove(obj);
                }
            });
        }
        
        function RemoveFrame() {
            canvas.getObjects().concat().forEach(function (obj) {
                if (obj.type != 'text') {
                    canvas.remove(obj);
                }
            });
        }

        function remove_object() {

            if (+canvas.getActiveGroup())
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

        function loadPattern(patternUrl) {

            //var imgUrl = patternUrl.scaleToWidth(20);

            //console.log(canvas.toSVG());
            var obj = canvas.getActiveObject();

            

            //var imgScaled = patternUrl.scaleToWidth(50);


    
/*

    var patternSourceCanvas = new fabric.StaticCanvas();
    patternSourceCanvas.add(patternUrl);

    patternSourceCanvas.renderAll();

    var myPattern = new fabric.Pattern({

        source: function() {
            patternSourceCanvas.setDimensions({
              width: 2000,
              height: 2000
            });
        },
        repeat: 'repeat'
    });
*/




            var pattern = new fabric.Pattern({
               source: patternUrl,
               repeat: 'repeat'
                
            });


            if (!obj) {patternUrl
                alert('Please Make a Selection.');
            }

            if (obj == null) {
                console.log('obj.type ' + obj.type);
                return;
            }

            console.log('obj.type ' + obj.type);

            //text group
            if (obj.type === 'group') {
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
                    else {
                        fabric.util.loadImage(patternUrl, function () {
                            o.set('fill', pattern);

                            //                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              o.set('scaleX', 0.3);
                            canvas.renderAll();
                        });
                    }
                });
            }

            else {

                //console.log('obj.type ' + obj.type);

                fabric.util.loadImage(patternUrl, function () {
                    obj.set('fill', pattern);
                    canvas.renderAll();
                });
            }
        }

        function testCircle() {
            var svgUrl = "../monogram-maker/images/frames/FrameCircle.svg";

            fabric.loadSVGFromURL(svgUrl, function (objects, options) {
                var obj = fabric.util.groupSVGElements(objects, options);
                obj.set({
                    left: 217,
                    top: 265

                });
                canvas.add(obj);
                obj.center();
                obj.setCoords();    
                canvas.renderAll();
            });
        }
        
        function FrameEmpty() {
            var svgUrl = "../monogram-maker/images/frames/FrameEmpty.svg";

            fabric.loadSVGFromURL(svgUrl, function (objects, options) {
                var obj = fabric.util.groupSVGElements(objects, options);
                obj.set({
                    left: 218,
                    top: 266

                });
                canvas.add(obj).renderAll();
            });
        }

        function loadAndUse(font) {
            var myfont = new FontFaceObserver(font)
            myfont.load()
                    .then(function () {
                        // when font is loaded, use it.
                        canvas.getActiveObject().set("fontFamily", font);
                        canvas.requestRenderAll();
                    }).catch(function (e) {
                console.log(e)
                //alert('font loading failed ' + font);
            });
        }

    });

});
  