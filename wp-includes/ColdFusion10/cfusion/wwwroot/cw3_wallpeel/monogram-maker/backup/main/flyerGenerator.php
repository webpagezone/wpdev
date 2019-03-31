<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Product HQ Design Generator</title>
<link rel="stylesheet" type="text/css" href="css/style.css">
<link rel="stylesheet" type="text/css" href="css/jquery-ui.css" />
<style type="text/css">
body { overflow-x:visible; }
#HQblockArea{
	width: 2480px;
	height:2600px;
}
</style>
<script src="js/jquery-2.1.0.js"></script>
<script src="js/fabric.all.js"></script>
<script src="js/jquery-ui.js"></script>
<script src="js/html2canvas.js"></script>
<script src="js/jquery.plugin.html2canvas.js"></script>
<script type="text/javascript">

$( document ).ready(function() {
	var _currentName = $('#designName').val();
	var _HQCanvasWidth = $('#canvasFront').width();
	var _HQCanvasHeight = $('#canvasFront').height();
	var _fdesignGroupLeft;
	var _fdesignGroupTop;	
	var _scale = _HQCanvasWidth/600;
	var _fHQLeft;
	var _fHQTop;
	var _bHQLeft;
	var _bHQTop;
	var _activeSide;
    var _curFonts="";  
	var _designCanvasFront = new fabric.Canvas('canvasFront');
	var _designCanvasBack = new fabric.Canvas('canvasBack');

	$('#HQDesign').css('width',_HQCanvasWidth+'px');
	$('#HQDesign').css('height',_HQCanvasHeight+'px');
	$('#saveFrontDesign').hide();
	$('#alert').text('');

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

	$('#loadFrontDesign').click(function(){
		$('#alert').text('');
		if($('#designName').val() !== ""){
			$('#canvasFront').css('opacity',0);
			$('#saveFrontDesign').hide();
			$('#HQblockArea').fadeIn();
			var _curFrontDesignURL = '../orders/'+_currentName+'/'+_currentName+'_front.json';    
			$('#designName').removeClass('error');
			$.ajax({
	            type : 'POST',
	            url : 'checkFiles/checkFrontDesign.php',     
	            data: {
	                dfurl : _curFrontDesignURL
	            },
	            success:function (data) {
	                if(data === 'true'){
	                	$.ajax({
						    url: "./orders/"+_currentName+"/infos.xml",
						    type: "POST",
						    dataType:"text xml",
						    success: function(xml) {
						        $(xml).find('info').each(function(e, i)
						        {
						            _fdesignGroupLeft = $(i).attr("fdesignLeft");
						            _fdesignGroupTop = $(i).attr("fdesignTop");  
						            _fHQLeft = Math.floor(_HQCanvasWidth*_fdesignGroupLeft/600);
						            _fHQTop = Math.floor(_HQCanvasHeight*_fdesignGroupTop/600);			
						            //console.log(_fHQLeft,_fHQTop)			            								
								    $.ajax({
								        dataType: 'json',
								        success: function(data) {
								           _designCanvasFront.loadFromJSON(data);
								           $('#saveFrontDesign').show();
								           setTimeout(function() { loadfHQDesign(); }, 5000);
								    	},
								        url: './orders/'+_currentName+'/'+_currentName+'_front.json'
								    })
						        })
						    }    
						})
	                }
	            }
    		})
		}else{
			$('#designName').addClass('error');
		}
	})

	$('#saveFrontDesign').click(function(){
		_activeSide = "Front";
		saveHQDesign();
	})

	function loadfHQDesign(){
		_designCanvasFront.setActiveGroup(new fabric.Group(_designCanvasFront.getObjects(),{scaleX:_scale, scaleY:_scale, left:_fHQLeft, top:_fHQTop})).renderAll();
		_designCanvasFront.forEachObject(function(o) {
		  o.selectable = false;
		});
		_designCanvasFront.deactivateAll().renderAll();
		_designCanvasFront.calcOffset();
		$('#canvasFront').css('opacity',1);
		$('#HQblockArea').fadeOut();
	}

	function saveHQDesign(){
		$('#HQblockArea').fadeIn();
		$('#HQDesign').html2canvas({
                onrendered: function (canvas) {
                    var img = canvas.toDataURL("image/png");                     
                    $.ajax({
                        url: 'saveFiles/saveHQ.php',
                        type: "POST",
                        data: ({
                            data: img,
                            curDesignName: _currentName,
                            curSide: _activeSide
                        }),
                        success: function (data) {
                            $('#HQblockArea').fadeOut();
                        }
                    })
                }
            })      
	}

})        
</script>
</head>
<body>
<div id="HQblockArea"></div>  
<div id="adminPanel">
<h2>Enter the DesignCode</h2>
<input id="designName" type="text">
<div id="loadFrontDesign" class="elementHolder orange">Load HQ Design</div>
<div id="saveFrontDesign" class="elementHolder green hidden">Save HQ Design</div>
<div id="alert"></div>
</div>
<div id="HQDesign">
	<canvas id="canvasFront" width="2480" height="2480" style='border:0px solid #ccc; opacity:0;'></canvas>
</div>	
</body>
</html>