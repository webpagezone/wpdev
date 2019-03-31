$(document).ready(function () {

    // FabricJS scripts
    var font = new FontFaceObserver('CircleSimple');

        font.load().then(function () {
           console.log('CircleSimple has loaded.');
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
        
        var patternUrl = "";
        

        //var textGroup;
        //*******************************************************************************
        //on load functions

        //Left Menu show Num of letters

        //Left Menu show font styles for num of fonts
        ShowEditInitials(numLetters);

        //put letters on canvas
        GetFontInfo(selectedFont);

        RemoveText();

        setTimeout(function() {
        	
			if(numLetters === 3){
	                    AddFontsToCanvas_3();
	                }
	                if(numLetters === 2){
	                    AddFontsToCanvas_2();
	                }
	                if(numLetters === 1){
	                    AddFontsToCanvas_1();
	                }
	
	        var patternUrl = textPatternUrl;
	
	                loadPattern(patternUrl);
	
		},100);
        
        
        AddFrameToCanvas(selectedFrame);
        
        patternUrl = framePatternUrl;

        loadPattern(patternUrl);

	

        //*******************************************************************************
        //****             Clicks                             **********
        //*******************************************************************************


        //*******************************************************************************
        // Text box clicks

        $('#textBox_3').keyup(function (e) {
            if (text_3 && text_3.get('type') === 'text') {
                var text = $('#textBox_3').val();
                text_3.set({
                    text: text
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
            alert(id);
            var patternUrl = "../Monogram/images/bgPatterns/" + id + ".jpg";

            loadPattern(patternUrl);
            
        });

        //*******************************************************************************
        // Frames click


        $("#bgFrameDiv input[name='bgFrame']").click(function () {
            var id = $("input[name='bgFrame']:checked").val();
            
            AddFrameToCanvas(id);
            

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

        function AddFontsToCanvas_3() {

            textBoxVal_3 = $('#textBox_3').val();
            console.log('add fonts ' + fontFamily_3);

            text_3 = CanvasAddMonogramLetter(fontFamily_3_fontSize, textBoxVal_3, fontFamily_3_leftPx, fontFamily_3_toptPx, fontFamily_3, fontFamily_3_Url);

            //canvas.add(text_3).setActiveObject(text_3);
            canvas.add(text_3);

            canvas.setActiveObject(text_3);
            //loadAndUse(fontFamily_3);

            canvas.renderAll();

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

            var textUpper = $('#textBoxA_1').val();
            textBoxAval_1 = textUpper.toUpperCase();

            text_1 = CanvasAddMonogramLetter(fontFamily_1_fontSize, textBoxAval_1, fontFamily_1_leftPx, fontFamily_1_toptPx, fontFamily_1, fontFamily_1_Url);

            canvas.add(text_1);
            canvas.setActiveObject(text_1);
            loadAndUse(fontFamily_3);
            canvas.renderAll();
            //canvas.add(obj).renderAll();
            //text_1.center();
            //text_1.setCoords();
            //canvas.renderAll();


        }

        function GetFontInfo(style) {


            console.log('Get Info: numLetters ' + numLetters + ' style ' + style);

            if (numLetters === 3) {

                if (style === 'CircleSimple') {

                    fontFamily_3 = 'CircleSimple';
                    fontFamily_3_Url = 'url("fonts/CircleSimple.ttf")';
                    fontFamily_3_fontSize = 300;
                    fontFamily_3_leftPx = 244;
                    fontFamily_3_toptPx = 240;

                }

                if (style === 'CircleScalloped') {

                    fontFamily_3 = 'CircleScalloped';
                    fontFamily_3_Url = 'url("fonts/CircleScalloped.ttf")';
                    fontFamily_3_fontSize = 220;
                    fontFamily_3_leftPx = 240;
                    fontFamily_3_toptPx = 273;

                }

            }

            if (numLetters === 2) {

                if (style === 'CircleTwoLetter') {
                    fontFamily_2 = 'CircleTwoLetter';
                    fontFamily_2_Url = 'url("fonts/CircleTwoLetter.ttf")';
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

        function AddFrameToCanvas(sFrame){
            
            var id = sFrame;
            console.log('id: '+id);
            var svgUrl = "../Monogram/images/frames/" + id + ".svg";
            
            var leftpx = 215;
            var toppx = 262;

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

                canvas.add(obj);
                canvas.setActiveObject(obj);
                canvas.renderAll();

            });
            
            canvas.getObjects().concat().forEach(function (obj) {
                canvas.setActiveObject(obj);
            });

            //var objects = canvas.getObjects();
            //canvas.setActiveObject(objects);
            //console.log('objects.length ' +objects.length);
            
            
        }
        
        function RemoveText() {
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

        function CleanCanvas() {

            canvas.getObjects().concat().forEach(function (obj) {
                canvas.remove(obj);
            });
        }

        function loadPattern(patternUrl) {
            //alert(patternUrl);
            //console.log(patternUrl);
            //console.log(canvas.toSVG());
            
            var obj = canvas.getActiveObject();
            
            pattern = new fabric.Pattern({
                source: patternUrl,
                repeat: 'repeat'});

            if (!obj) {
                alert('Please Make a Selection.');
            }

            if (obj === null) {
                console.log('return obj.type ' + obj.type);
                return;
            }

            //text group
            if (obj.type === 'group') {
                
                obj.getObjects().forEach(function (o) {

                    if (o.type === 'text') {
                        console.log(' obj.type ' + o.type);
                        //if (obj.type === 'text') {
                        //console.log('obj is text ');
                        fabric.util.loadImage(patternUrl, function () {
                            o.set('fill', pattern);
                            canvas.setActiveObject(o);
                            canvas.renderAll();
                        });
                    }
                    else {
                        fabric.util.loadImage(patternUrl, function () {
                            o.set('fill', pattern);
                            canvas.setActiveObject(o);
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
                    canvas.setActiveObject(obj);
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

        function loadAndUse(font) {
            var myfont = new FontFaceObserver(font)
            myfont.load()
                    .then(function () {
                        // when font is loaded, use it.
                        canvas.getActiveObject().set("fontFamily", font);
                        canvas.requestRenderAll();
                    }).catch(function (e) {
                console.log(e)
                alert('font loading failed ' + font);
            });
        }

    });

});
  