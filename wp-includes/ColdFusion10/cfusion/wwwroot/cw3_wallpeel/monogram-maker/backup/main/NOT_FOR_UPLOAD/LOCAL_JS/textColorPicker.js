/**
 * Really Simple Color Picker in jQuery
 *
 * Licensed under the MIT (MIT-LICENSE.txt) licenses.
 *
 * Copyright (c) 2008-2012
 * Lakshan Perera (www.laktek.com) & Daniel Lacy (daniellacy.com)
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to
 * deal in the Software without restriction, including without limitation the
 * rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
 * sell copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
 * IN THE SOFTWARE.
 */

(function ($) {
    /**
     * Create a couple private variables.
    **/
    var selectorOwner,
        activePalette,
        cItterate       = 0,
        templates       = {
            control : $('<div class="TextColorPicker">&nbsp;</div>'),
            palette : $('<div id="TextColorPicker_palette" class="TextColorPicker-palette" />'),
            swatch  : $('<div class="TextColorPicker-swatch">&nbsp;</div>'),
            hexLabel: $('<label for="TextColorPicker_hex">Hex</label>'),
            hexField: $('<input type="text" id="TextColorPicker_hex" />')
        },
        transparent     = "transparent";

    /**
     * Create our TextColorPicker function
    **/
    $.fn.TextColorPicker = function (options) {

        return this.each(function () {
            // Setup time. Clone new elements from our templates, set some IDs, make shortcuts, jazzercise.
            var element      = $(this),
                opts         = $.extend({}, $.fn.TextColorPicker.defaults, options),
                defaultColor = $.fn.TextColorPicker.toHex(
                        (element.val().length > 0) ? element.val() : opts.pickerDefault
                    ),
                newControl   = templates.control.clone(),
                newPalette   = templates.palette.clone().attr('id', 'TextColorPicker_palette-' + cItterate),
                newHexLabel  = templates.hexLabel.clone(),
                newHexField  = templates.hexField.clone(),
                paletteId    = newPalette[0].id,
                swatch, controlText;


            /**
             * Build a color palette.
            **/
            $.each(opts.colors, function (i) {
                swatch = templates.swatch.clone();

                if (opts.colors[i] === transparent) {
                    swatch.addClass(transparent).text('X');
                    $.fn.TextColorPicker.bindPalette(newHexField, swatch, transparent);
                } else {
                    swatch.css("background-color", "#" + this);
                    $.fn.TextColorPicker.bindPalette(newHexField, swatch);
                }
                swatch.appendTo(newPalette);
            });


            newHexLabel.attr('for', 'TextColorPicker_hex-' + cItterate);

            newHexField.attr({
                'id'    : 'TextColorPicker_hex-' + cItterate,
                'value' : defaultColor
            });

            newHexField.bind("keydown", function (event) {
                if (event.keyCode === 13) {
                    var hexColor = $.fn.TextColorPicker.toHex($(this).val());
                    $.fn.TextColorPicker.changeColor(hexColor ? hexColor : element.val());
                }
                if (event.keyCode === 27) {
                    $.fn.TextColorPicker.hidePalette();
                }
            });

            newHexField.bind("keyup", function (event) {
              var hexColor = $.fn.TextColorPicker.toHex($(event.target).val());
              $.fn.TextColorPicker.previewColor(hexColor ? hexColor : element.val());
            });

            $('<div class="TextColorPicker_hexWrap" />').append(newHexLabel).appendTo(newPalette);

            newPalette.find('.TextColorPicker_hexWrap').append(newHexField);
            if (opts.showHexField === false) {
                newHexField.hide();
                newHexLabel.hide();
            }

            $("body").append(newPalette);

            newPalette.hide();


            /**
             * Build replacement interface for original color input.
            **/
            newControl.css("background-color", defaultColor);

            newControl.bind("click", function () {
                if( element.is( ':not(:disabled)' ) ) {
                    $.fn.TextColorPicker.togglePalette($('#' + paletteId), $(this));
                }
            });

            if( options && options.onColorChange ) {
              newControl.data('onColorChange', options.onColorChange);
            } else {
              newControl.data('onColorChange', function() {} );
            }

            if (controlText = element.data('text'))
                newControl.html(controlText)

            element.after(newControl);

            element.bind("change", function () {
                element.next(".TextColorPicker").css(
                    "background-color", $.fn.TextColorPicker.toHex($(this).val())
                );
            });

            element.val(defaultColor);

            // Hide the original input.
            if (element[0].tagName.toLowerCase() === 'input') {
                try {
                    element.attr('type', 'hidden')
                } catch(err) { // oldIE doesn't allow changing of input.type
                    element.css('visibility', 'hidden').css('position', 'absolute')
                }
            } else {
                element.hide();
            }

            cItterate++;
        });
    };

    /**
     * Extend TextColorPicker with... all our functionality.
    **/
    $.extend(true, $.fn.TextColorPicker, {
        /**
         * Return a Hex color, convert an RGB value and return Hex, or return false.
         *
         * Inspired by http://code.google.com/p/jquery-color-utils
        **/
        toHex : function (color) {
            // If we have a standard or shorthand Hex color, return that value.
            if (color.match(/[0-9A-F]{6}|[0-9A-F]{3}$/i)) {
                return (color.charAt(0) === "#") ? color : ("#" + color);

            // Alternatively, check for RGB color, then convert and return it as Hex.
            } else if (color.match(/^rgb\(\s*(\d{1,3})\s*,\s*(\d{1,3})\s*,\s*(\d{1,3})\s*\)$/)) {
                var c = ([parseInt(RegExp.$1, 10), parseInt(RegExp.$2, 10), parseInt(RegExp.$3, 10)]),
                    pad = function (str) {
                        if (str.length < 2) {
                            for (var i = 0, len = 2 - str.length; i < len; i++) {
                                str = '0' + str;
                            }
                        }

                        return str;
                    };

                if (c.length === 3) {
                    var r = pad(c[0].toString(16)),
                        g = pad(c[1].toString(16)),
                        b = pad(c[2].toString(16));

                    return '#' + r + g + b;
                }

            // Otherwise we wont do anything.
            } else {
                return false;

            }
        },

        /**
         * Check whether user clicked on the selector or owner.
        **/
        checkMouse : function (event, paletteId) {
            var selector = activePalette,
                selectorParent = $(event.target).parents("#" + selector.attr('id')).length;

            if (event.target === $(selector)[0] || event.target === selectorOwner[0] || selectorParent > 0) {
                return;
            }

            $.fn.TextColorPicker.hidePalette();
        },

        /**
         * Hide the color palette modal.
        **/
        hidePalette : function () {
            $(document).unbind("mousedown", $.fn.TextColorPicker.checkMouse);

            $('.TextColorPicker-palette').hide();
        },

        /**
         * Show the color palette modal.
        **/
        showPalette : function (palette) {
            var hexColor = selectorOwner.prev("input").val();

            palette.css({
                top: selectorOwner.offset().top + (selectorOwner.outerHeight()),
                left: selectorOwner.offset().left
            });

            $("#color_value").val(hexColor);

            palette.show();

            $(document).bind("mousedown", $.fn.TextColorPicker.checkMouse);
        },

        /**
         * Toggle visibility of the TextColorPicker palette.
        **/
        togglePalette : function (palette, origin) {
            // selectorOwner is the clicked .TextColorPicker.
            if (origin) {
                selectorOwner = origin;
            }

            activePalette = palette;

            if (activePalette.is(':visible')) {
                $.fn.TextColorPicker.hidePalette();

            } else {
                $.fn.TextColorPicker.showPalette(palette);

            }
        },

        /**
         * Update the input with a newly selected color.
        **/
        changeColor : function (value) {
            selectorOwner.css("background-color", value);
            selectorOwner.prev("input").val(value).change();
            $.fn.TextColorPicker.hidePalette();
            selectorOwner.data('onColorChange').call(selectorOwner, $(selectorOwner).prev("input").attr("id"), value);
        },

        /**
         * Preview the input with a newly selected color.
        **/
        previewColor : function (value) {
            selectorOwner.css("background-color", value);
        },
        /**
         * Bind events to the color palette swatches.
        */
        bindPalette : function (paletteInput, element, color) {
            color = color ? color : $.fn.TextColorPicker.toHex(element.css("background-color"));
            element.bind({
                click : function (ev) {
                    _nhd_lastColor = color;
                    var _curColor = Number('0x'+color.replace("#", "")); 
                    $.fn.TextColorPicker.changeColor(color);
                    if(isFront){
                        var obj = designCanvasFront.getActiveObject();
                        if(obj){
                            if((obj.get('type') === 'text') || (obj.get('type') === 'Curvedtext')){
                                if(_isStroke){
                                    designCanvasFront.getActiveObject().set("fill", "transparent");
                                    designCanvasFront.getActiveObject().set("stroke", _nhd_lastColor);
                                    designCanvasFront.renderAll();  
                                    designJson = JSON.stringify(designCanvasFront);
                                }else{
                                    designCanvasFront.getActiveObject().set("fill", _nhd_lastColor);
                                    designCanvasFront.getActiveObject().set("stroke", '');
                                    designCanvasFront.renderAll();  
                                    designJson = JSON.stringify(designCanvasFront);
                                }
                            }
                            if(obj.get('type') === 'image'){
                                designCanvasFront.getActiveObject().filters.push(new fabric.Image.filters.Tint({color : _curColor}));
                                designCanvasFront.getActiveObject().applyFilters((function(){
                                    designCanvasFront.renderAll();
                                }));
                            }
                        }
                    }
                    if(isBack){
                        var obj = designCanvasBack.getActiveObject();
                        if(obj){
                            if((obj.get('type') === 'text') || (obj.get('type') === 'Curvedtext')){
                                if(_isStroke){
                                    designCanvasBack.getActiveObject().set("fill", "transparent");
                                    designCanvasBack.getActiveObject().set("stroke", _nhd_lastColor);
                                    designCanvasBack.renderAll();  
                                    designJson = JSON.stringify(designCanvasBack);
                                }else{
                                    designCanvasBack.getActiveObject().set("fill", _nhd_lastColor);
                                    designCanvasBack.getActiveObject().set("stroke", '');
                                    designCanvasBack.renderAll();  
                                    designJson = JSON.stringify(designCanvasBack);
                                }
                            }
                            if(obj.get('type') === 'image'){
                                designCanvasBack.getActiveObject().filters.push(new fabric.Image.filters.Tint({color : _curColor}));
                                designCanvasBack.getActiveObject().applyFilters((function(){
                                    designCanvasBack.renderAll();
                                }));
                            }
                        }                        
                    }                    
                },
                mouseover : function (ev) {
                    _nhd_lastColor = paletteInput.val();
                    $(this).css("border-color", "#598FEF");
                    paletteInput.val(color);
                    $.fn.TextColorPicker.previewColor(color);
                },
                mouseout : function (ev) {
                    $(this).css("border-color", "#000");
                    paletteInput.val(selectorOwner.css("background-color"));
                    paletteInput.val(_nhd_lastColor);
                    $.fn.TextColorPicker.previewColor(_nhd_lastColor);
                }
            });
        }
    });
    /**
     * Default TextColorPicker options.
     *
     * These are publibly available for global modification using a setting such as:
     *
     * $.fn.TextColorPicker.defaults.colors = ['151337', '111111']
     *
     * They can also be applied on a per-bound element basis like so:
     *
     * $('#element1').TextColorPicker({pickerDefault: 'efefef', transparency: true});
     * $('#element2').TextColorPicker({pickerDefault: '333333', colors: ['333333', '111111']});
     *
    **/
    $.fn.TextColorPicker.defaults = {
        // TextColorPicker default selected color.
        pickerDefault : "000000",
        // Default color set.
        colors : [
            '000000', '993300', '333300', '333399', '333333', '800000', 'FF6600',
            '808000', '666699', '808080', 'FF0000', 'FF9900',
            '99CC00', '339966', '33CCCC', '3366FF', '800080', '999999', 'FF00FF', 'FFCC00',
            'FFFF00', '993366', 'C0C0C0', 'FF99CC', 'FFCC99',
            'FFFF99', 'CCFFFF', '99CCFF',  '129A12', 'FFFFFF'
        ],
        // If we want to simply add more colors to the default set, use addColors.
        addColors : [],
        // Show hex field
        showHexField: true
    };
})(jQuery);
