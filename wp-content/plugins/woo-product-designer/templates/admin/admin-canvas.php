<?php
/**
 * this is to show uploaded canvas in order
 * */
 
 global $nm_wcpd;
  //pa_nm_wcpd($woodesign_metas);
    echo '<link rel="stylesheet" type="text/css" href="'.$nm_wcpd->plugin_meta['url'].'css/grid/simplegrid.css" />';
    $canSize = ($this->get_option('_canvas_size') != '') ? $this->get_option('_canvas_size') : '500' ;
?>
<?php add_thickbox(); ?>
<div id="content-details" style="display:none;">
    <table id="obdetails" style="width: 100%;text-align: left;padding: 10px;">
    	
    </table>
</div>



<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/angular.js/1.1.5/angular.js"></script>
<script type="text/javascript" src="<?php echo $nm_wcpd-> plugin_meta['url']; ?>/templates/js/fabric.min.js"></script>

<?php if(is_array($woodesign_metas)){ ?>
<div class="toolbar nm-toolbar" style="text-align:center;">
	<button class="button button-secondary reset-canvas"><?php _e( 'Reset Canvas', 'nm-wcpd' ); ?></button>
	<button class="button button-secondary download-selected"><?php _e( 'Download Object', 'nm-wcpd' ); ?></button>
	<button class="button button-secondary download-canvas"><?php _e( 'Download Canvas', 'nm-wcpd' ); ?></button>
	<a href="#TB_inline?width=300&height=350&inlineId=content-details" class="thickbox button button-secondary"><?php _e('Details', 'nm-wcpd') ?></a>
</div>
<?php } ?>

<?php
	// Taking All attached canvases separately and merging them into one JSON
	$all_canvases = array();
	if(is_array($woodesign_metas)){
		foreach ($woodesign_metas as $canvas_key => $woodesign_meta) {
			$dec = json_decode($woodesign_meta);
			
			foreach ($dec as $canvas) {
				$all_canvases[] = $canvas;
			}
		}
		
	}
	
	$all_canvases_json = json_encode($all_canvases, JSON_HEX_APOS);
?>
<div class="nm-canvas-wrap grid">
	<div class="insert-canvases" class="col-12-12"></div>
</div>

<script type="text/javascript">
<!--
jQuery(document).ready(function($) {
	var templates = [];
	var canvases = {};
	var selectedObject = {};
	var activeCanvas = '';
	var pluginUrl = '<?php echo $this->plugin_meta['url']; ?>';
	
	var woo_canvas_meta = '<?php echo $all_canvases_json; ?>';
	// var woo_canvas_meta = <?=$all_canvases_json?>;
	
	var canvas_meta  = jQuery.parseJSON(woo_canvas_meta);
	
	$.each(canvas_meta, function(index, meta) {
		$('.insert-canvases').append('<canvas id="c'+index+'" width="<?php echo $canSize; ?>" height="<?php echo $canSize; ?>" style="border: 1px solid #ccc;"></canvas>');
		templates.push({id: 'c'+index, canvas_json: meta});
	});
	
	$.each(templates, function(i, canvas) {
		canvases[canvas.id] = window._canvas = new fabric.Canvas(canvas.id);
		canvases[canvas.id].loadFromJSON(canvas.canvas_json, canvases[canvas.id].renderAll.bind(canvases[canvas.id]), function(o, object) {
			//fabric.log(o, object);
		});
		canvases[canvas.id].setWidth('500px', {cssOnly: true});
		canvases[canvas.id].setHeight('500px', {cssOnly: true});
		canvases[canvas.id].renderAll();
	});
	
	$('.reset-canvas').click(function(e){
		e.preventDefault();
		$('.insert-canvases').html('');
		$.each(canvas_meta, function(index, meta) {
			$('.insert-canvases').append('<canvas id="c'+index+'" width="<?php echo $canSize; ?>" height="<?php echo $canSize; ?>" style="border: 1px solid #ccc;"></canvas>');
			templates.push({id: 'c'+index, canvas_json: meta});
		});
		
		$.each(templates, function(i, canvas) {
			canvases[canvas.id] = window._canvas = new fabric.Canvas(canvas.id);
			canvases[canvas.id].loadFromJSON(canvas.canvas_json, canvases[canvas.id].renderAll.bind(canvases[canvas.id]), function(o, object) {
				//fabric.log(o, object);
			});
			canvases[canvas.id].setWidth('500px', {cssOnly: true});
			canvases[canvas.id].setHeight('500px', {cssOnly: true});
			canvases[canvas.id].renderAll();
		});
	});
	
	$('.insert-canvases').on('click', '.canvas-container', function() {
		var activeCan = jQuery(this).find('canvas').attr('id'); 
		if (activeCanvas != '' && activeCanvas != activeCan) {
			canvases[activeCanvas].discardActiveObject();
		}
		if(canvases[activeCan].getActiveObject() != null){
			activeCanvas =  activeCan;
			selectedObject = canvases[activeCan].getActiveObject();
			$("table#obdetails").html('');
			$.each(selectedObject, function(key, value) {
				if(typeof value == 'string' || typeof value == 'number'){
					$("table#obdetails").append("<tr><td>" + key + "</td><td>" + value + "</td></tr>");
				}
			});			
		}
		// console.log(selectedObject);
	});
	
	
	$('.download-selected').click(function(e){
		e.preventDefault();
		if(canvases[activeCanvas].getActiveObject() != null){
			window.open(canvases[activeCanvas].getActiveObject().src);
		}
		else {
			alert('Please Select Object to Download!');
		}
	});
	
	$('.download-canvas').click(function(e){
		e.preventDefault();
		if(canvases[activeCanvas].getActiveObject() != null){
			canvases[activeCanvas].overlayImage = null;
			canvases[activeCanvas].discardActiveObject();
			canvases[activeCanvas].renderAll.bind(canvases[activeCanvas]);
			var dataURL = canvases[activeCanvas].toDataURL({
			  format: 'png',
			});

			window.open(dataURL);
			canvases[activeCanvas].setOverlayImage(pluginUrl + 'images/grid.png',
				canvases[activeCanvas].renderAll.bind(canvases[activeCanvas]
			));
		}
		else {
			alert('Please Select Canvas to Download!');
		}
	});
	
	jQuery(window).scroll(stick_object_info);
	stick_object_info();	
});
function stick_object_info() {
    var window_top = jQuery(window).scrollTop();
    var div_top = jQuery('.insert-canvases').offset().top;
    if (window_top > div_top) {
        jQuery('.nm-toolbar').addClass('stick-btns');
    } else {
        jQuery('.nm-toolbar').removeClass('stick-btns');
    }
}
//--></script>
<style type="text/css">
	.canvas-container { margin: 10px auto; }
	.stick-btns {
	    position: fixed;
	    bottom: 0;
	    z-index: 999;
	    left: 28%;
	    background-color: #ccc;
	    padding: 5px 25px;
	    border: 1px solid blue;
	}
</style>