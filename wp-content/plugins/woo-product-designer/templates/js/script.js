	var activeCanvas = 'c0';
	var canvases = {};
	var templates = [];
	var canvas_saved = [];
	var saved_canvas = [];
	var tosmaxwidth=1250
	var tosmaxheight=600
	jQuery(window).on('resize',function() {
		var toswidth = window.innerWidth-50;
		if (toswidth > tosmaxwidth) {
			toswidth=tosmaxwidth;
		}
		var tosheight = window.innerHeight-50;
		if (tosheight > tosmaxheight) {
			tosheight=tosmaxheight;
		}
		var toslink = "#TB_inline?width=" + toswidth +"&height="+ tosheight +"&inlineId=woo-designer-area";
		jQuery(".thickbox").attr("href",toslink);

	  if (jQuery(window).width() < 408) {
	    jQuery('#delete-btn').removeClass('btn-group');
	    jQuery('#delete-btn').addClass('btn-group-vertical btn-block');
	  } else {
	    jQuery('#delete-btn').addClass('btn-group');
	    jQuery('#delete-btn').removeClass('btn-group-vertical btn-block');
	  }		
	});


jQuery(document).ready(function($) {

	jQuery(window).trigger('resize');
	var canSize = jQuery('#cansize').data('cansize');

	$('#templates-container img').each(function(i) {
		$('#insert-canvases').append('<canvas class="resizable-can" id="c'+i+'" width="'+canSize+'" height="'+canSize+'" style="border: 1px solid #ccc;"></canvas>');
		templates.push({id: 'c'+i});

	});


	$.each(templates, function(i, canvas){

		// console.log(canvas.id);
	
		canvases[canvas.id] = new fabric.Canvas(canvas.id),f = fabric.Image.filters;
		canvases[canvas.id].preserveObjectStacking = true;
		// console.log(nm_wcpd_vars);
		if(nm_wcpd_vars.settings.nm_wcpd_disable_grid != 'disable'){
			canvases[canvas.id].setOverlayImage(nm_wcpd_vars.plugin_url+'images/grid.png',
				canvases[canvas.id].renderAll.bind(canvases[canvas.id]
			));
		}


		// canvases[canvas.id].setBackgroundColor({
		//   source: nm_wcpd_vars.plugin_url+'images/grid.png',
		//   repeat: 'repeat',
		// }, canvases[canvas.id].renderAll.bind(canvases[canvas.id]));

		setTimeout(function() {
      		fabric.Image.fromURL($('#templates-container img:eq('+i+')').attr('src'), function(img) {
				// console.log(single_temp);
				img.scaleToWidth(canvases[canvas.id].width - 100);
				canvases[canvas.id].add(img);
				img.lockMovementX = img.lockMovementY = true;
				img.originX = img.originY = 'center';
				img.lockRotation = true;
				img.crossOrigin = "anonymous";
				img.lockUniScaling = true;
				img.centeredScaling = true;
				img.center();
				img.setCoords();
				// canvases[activeCanvas].add(img);
			});
		}, 200);


	});

	$('.designbtn').click(function() {
		setTimeout(function() {
			$.each(canvases, function(id) {
				var wrap_width = $('#insert-canvases').width();
				canvases[id].setWidth(wrap_width+'px', {cssOnly: true});
				canvases[id].setHeight(wrap_width+'px', {cssOnly: true});

				canvases[id].item(0).scaleToWidth(canvases[id].height - 100);
				canvases[id].item(0).originX = canvases[id].item(0).originY = 'center';
				canvases[id].item(0).center();
				canvases[id].renderAll();
			});
		}, 500);		
	});

	//Setting up panels

	$('.text-edit-panel').hide();
	$('.image-edit-panel').hide();
	$("#saving-canvases").find('.progress').hide();

	// Adding Main templates in canvas
	$('#insert-canvases').find('#c0').closest('.canvas-container').siblings().hide();

	$('#templates-container').on('click', 'img', function(event) {
		var image_id = '#' + $(this).attr("data-cid");

		$('#insert-canvases').find(image_id).closest('.canvas-container').show().siblings().hide();

		activeCanvas = $(this).attr("data-cid");

		$('.text-edit-panel').hide();
		$('.image-edit-panel').hide();
		changingValues();

	});


	// Adding shapes in canvas
	
	$('#shapes-container').on('click', 'img', function(event) {
		event.preventDefault();
		fabric.Image.fromURL($(this).attr('src'), function(img) {
			img.scaleToWidth(canvases[activeCanvas].width - 20);
			canvases[activeCanvas].add(img);
			
		});

		changingValues();

	});
	
	// Adding custom image in canvas (Najeeb did it.)
	
	$('.filelist').on('click', 'img', function(event) {
		event.preventDefault();
		fabric.Image.fromURL($(this).attr('data-big'), function(img) {
			img.scaleToWidth(500);
			canvases[activeCanvas].add(img);
			
		});

		changingValues();

	});

	// Adding text in canvas
	
	$('#text-container').on('click', '#insert-text', function(event) {
		event.preventDefault();
		var text = new fabric.IText($('#enter-text').val());
		canvases[activeCanvas].add(text);
		changingValues();
		$('#enter-text').val('');
	});


	changingValues();
		// Deleting Objects
		
		$('#delete-btn').on('click', '#delete-it', function() {

			if(canvases[activeCanvas].getActiveObject() == canvases[activeCanvas].item(0)){
				alert('Sorry, you can not delete templates!');
			}
			else {
				
				if(canvases[activeCanvas].getActiveGroup()){
			      canvases[activeCanvas].getActiveGroup().forEachObject(function(o){ canvases[activeCanvas].remove(o) });
			      canvases[activeCanvas].discardActiveGroup().renderAll();
			    } else {
			      canvases[activeCanvas].remove(canvases[activeCanvas].getActiveObject());
			    }
			}

		});
		
		// Bring to Front
		$('#delete-btn').on('click', '#bring-front-btn', function() {

			if(canvases[activeCanvas].getActiveObject() == canvases[activeCanvas].item(0)){
				alert('Sorry, you can not bring templates on front!');
			}
			else {
				
				if(canvases[activeCanvas].getActiveGroup()){
			      canvases[activeCanvas].getActiveGroup().forEachObject(function(o){ o.bringToFront() });
			      canvases[activeCanvas].discardActiveGroup().renderAll();
			    } else {
			      canvases[activeCanvas].getActiveObject().bringToFront();
			    }
			}

		});

		var resetitng_zoom = canvases[activeCanvas].getZoom();
		var reset_center = canvases[activeCanvas].getCenter();
		$('#reset-zoom').click(function() {
			canvases[activeCanvas].zoomToPoint(new fabric.Point(reset_center.top,reset_center.left), resetitng_zoom);
		});

		// Zoom in out
		$('#zoom-in').click(function() {
			var current_zoom = canvases[activeCanvas].getZoom();
			current_center = canvases[activeCanvas].getCenter();
			canvases[activeCanvas].zoomToPoint(new fabric.Point(current_center.top,current_center.left), current_zoom + 0.1);
		});
		$('#zoom-out').click(function() {
			var current_zoom = canvases[activeCanvas].getZoom();
			current_center = canvases[activeCanvas].getCenter();
			canvases[activeCanvas].zoomToPoint(new fabric.Point(current_center.top,current_center.left), current_zoom - 0.1);
		});

		// Clear Canvas

		$('#clear-canvas').click(function() {

			if (confirm('Are you sure, you want to reset the whole canvas?')) {
			    canvases[activeCanvas].clear();
				var insert_main	= canvases[activeCanvas].lowerCanvasEl.id;
				
	      		fabric.Image.fromURL($('#templates-container img[data-cid="'+insert_main+'"]').attr('src'), function(img) {
	      			// img.set({width: canvases[activeCanvas].width - 50,});
	      			img.scaleToWidth(canvases[activeCanvas].width - 100);
					canvases[activeCanvas].add(img);
					img.lockMovementX = img.lockMovementY = true;
					img.originX = img.originY = 'center';
					img.lockRotation = true;
					img.lockUniScaling = true;
					img.centeredScaling = true;
					img.center();
					img.setCoords();
				});			
			} else {
			    // Do nothing!
			}			
			
		});

		$('#clone-object').click(function() {

			if(canvases[activeCanvas].getActiveObject() == canvases[activeCanvas].item(0)){
				alert('Sorry, you can not clone templates!');
			}
			else {
				
				var ob = fabric.util.object.clone(canvases[activeCanvas].getActiveObject());
				canvases[activeCanvas].discardActiveObject();
				canvases[activeCanvas].add(ob.set({ left: ob.get('left') + 100,}));
				ob.setActiveObject();
				canvases[activeCanvas].renderAll();
			}
		});

		$('#save-image').click(function() {
			canvases[activeCanvas].overlayImage = null;
			canvases[activeCanvas].discardActiveObject();
			canvases[activeCanvas].renderAll.bind(canvases[activeCanvas]);	
			var dataURL = canvases[activeCanvas].toDataURL({
			  format: 'png',
			  multiplier: 1
			});

			$(this).attr('href', dataURL);
			canvases[activeCanvas].setOverlayImage(nm_wcpd_vars.plugin_url+'images/grid.png',
				canvases[activeCanvas].renderAll.bind(canvases[activeCanvas]
			));
		});
		
		$("#proceed").click(function() {

			saved_canvas = [];

			jQuery("#saving-canvases").find('.progress').show();
	   		jQuery("#saving-canvases .progress-bar").width('100%');
		   
	   		 $.each(canvases, function(i, canvas) {
   		 		canvases[i].discardActiveObject();
				canvases[i].overlayImage = null;

		   		saving_canvas(i, canvas.toDataURL());

		   		canvases[i].setOverlayImage(nm_wcpd_vars.plugin_url+'images/grid.png',
					canvases[i].renderAll.bind(canvases[i]
				));	
			});
		});

});

// filters array
var filters = [
    new fabric.Image.filters.Grayscale(),       // grayscale    0
    new fabric.Image.filters.Sepia(),           // sepia        1
	new fabric.Image.filters.Sepia2(),  		// sepia 2 		2
    new fabric.Image.filters.Invert(),          // invert       3

];

fabric.Object.prototype.transparentCorners = false;

function saveToJson(){
	canvas_saved = [];

	jQuery.each(canvases, function(i, canvas) {
		var canvas_json = canvases[i].toJSON();
		canvas_saved.push(canvas_json);			
	});
	// console.log(canvas_saved);
	jQuery("#nm_canvases").val(JSON.stringify(canvas_saved));	
}

function changingValues(){
		//anvases[activeCanvas].on('object:selected', function(options) {
			canvases[activeCanvas].click('object:selected', function(options) {

		  	jQuery('#delete-it, #clone-object').removeClass('disabled');

		  	if (options.target != undefined && options.target.type == 'i-text') {
		  		// console.log(options.target);

		  		// adding selected object values in editor
		  		jQuery('#color-text').val(options.target.fill);
		  		jQuery('#font-famil').val(options.target.fontFamily);
		  		jQuery('#text-decor').val(options.target.textDecoration);
		  		jQuery('#font-size').val(options.target.fontSize);
		  		jQuery('#edit-text').val(options.target.text);

		  		if(options.target.fontWeight == 'bold'){
		  			jQuery('#bold-text').prop('checked', true);
		  		}
		  		else {
		  			jQuery('#bold-text').prop('checked', false);
		  		}
		  		if(options.target.fontStyle == 'italic'){
		  			jQuery('#italic-text').prop('checked', true);
		  		}
		  		else {
		  			jQuery('#italic-text').prop('checked', false);
		  		}
		  		jQuery('.image-edit-panel').slideUp('slow');
		  		jQuery('.text-edit-panel').slideDown('slow');

		    	// Edit Text
		    	jQuery('#edit-text').keyup(function() {
		    	var this_object = canvases[activeCanvas].getActiveObject();
		    		this_object.set({text: jQuery('#edit-text').val()});
		    		canvases[activeCanvas].renderAll();
		    	});

		    	// Changing Text Styles
		    	jQuery('#change-text-styles').on('change', 'input', function() {
		    		var this_object = canvases[activeCanvas].getActiveObject();
		        		if(this.checked){
				            switch (jQuery(this).attr('id')) {
				            	case 'bold-text':
					            	this_object.set({fontWeight: 'bold'});
						        	canvases[activeCanvas].renderAll();
						        	break;
				            	case 'italic-text':
					            	this_object.set({fontStyle: 'italic'});
						        	canvases[activeCanvas].renderAll();
						        	break;
				            }
				        }
				        else {
				            switch (jQuery(this).attr('id')) {
				            	case 'bold-text':
					            	this_object.set({fontWeight: 'normal'});
						        	canvases[activeCanvas].renderAll();
						        	break;
				            	case 'italic-text':
					            	this_object.set({fontStyle: 'normal'});
						        	canvases[activeCanvas].renderAll();
						        	break;
				            }
				        }

				        if (jQuery(this).attr('id') == 'color-text') {
			            	this_object.set({fill: jQuery(this).val()});
				        	canvases[activeCanvas].renderAll();			        	
				        }
				        if (jQuery(this).attr('id') == 'font-size') {
			            	this_object.set({fontSize: jQuery(this).val()});
						    canvases[activeCanvas].renderAll();			        	
				        }
		    	});


		    	// Changing Text Styles
		    	jQuery('#change-text-styles').on('change', 'select', function() {
		    		var this_object = canvases[activeCanvas].getActiveObject();
			            switch (jQuery(this).attr('id')) {
			            	case 'text-decor':
				            	this_object.set({textDecoration: jQuery(this).val()});
					        	canvases[activeCanvas].renderAll();
					        	break;
			            	case 'font-famil':
				            	this_object.set({fontFamily: jQuery(this).val()});
					        	canvases[activeCanvas].renderAll();
					        	break;
					    }

		    	});

		  	}

		  	if (options.target != undefined && options.target.type == 'image') {
		  		jQuery('.text-edit-panel').slideUp('slow');
		  		jQuery('.image-edit-panel').slideDown('slow');

			    jQuery('.image-edit-panel').on("change", "input", function () {
			    	if(jQuery(this).attr('type') == 'checkbox'){
				        var isChecked = jQuery(this).prop("checked"),
				            filter = jQuery(this).val(),
				            obj = canvases[activeCanvas].getActiveObject();
				        
				        obj.filters[filter] = isChecked ? filters[filter] : null;
				        /*obj.applyFilters(function () {
				            canvases[activeCanvas].renderAll();
				        });			    		*/
			    		obj.applyFilters(canvases[activeCanvas].renderAll.bind(canvases[activeCanvas]));
			    	}
			        if (jQuery(this).attr('type') == 'color') {
				            current_color = jQuery(this).val(),
				            obj = canvases[activeCanvas].getActiveObject();
				        
				        obj.filters[4] = new fabric.Image.filters.Tint({
											  color: current_color,
											  opacity: 1
											}),
				        obj.applyFilters(function () {
				            canvases[activeCanvas].renderAll();
				        });
			        }			    	
			    });
		  	}

		});	

		canvases[activeCanvas].on('selection:cleared', function(options) {
			jQuery('.text-edit-panel').slideUp('slow');
			jQuery('.image-edit-panel').slideUp('slow');
			jQuery('#delete-it, #clone-object').addClass('disabled');
		});	

}

function saving_canvas(cid, dataUrl){
	
	//console.log(dataUrl);
	
   //sending to server
   jQuery.ajax({
  	    beforeSend: function(xhrObj){
			xhrObj.setRequestHeader("Content-Type","application/json");
  	    },

  	    type: "POST",

  	    url: nm_wcpd_vars.ajaxurl+'?action=nm_wcpd_save_canvases&canvas_id='+cid,       

  	    //data: canvas_images,               
  	    data: dataUrl,

  	    success: function(resp){

			resp = jQuery.parseJSON(resp);
			
			saved_canvas.push(resp);
	       	
	       	console.log(saved_canvas);
	       	if(saved_canvas.length === templates.length){
	       		console.log(saved_canvas);
	       		jQuery(".flex-active-slide img:first-child").attr('srcset', saved_canvas[0].thumburl);

	       		saveToJson();
	       		jQuery("#saving-canvases").find('.progress').hide();
	       		jQuery("#saving-canvases .progress-bar").width('0%');
	       		
	       		// Appending hidden input containing array of thumbs for cart
				jQuery.each(saved_canvas, function (i) {
	       			jQuery('form.cart').append('<input type="hidden" name="_canvas_image['+i+']" value="'+saved_canvas[i].thumburl+'">');
				});
	       		window.tb_remove();
	       	}
  	    	//jQuery("#saving-canvases").append('<br>'+resp+'<br>');
  	    }

  	});
}