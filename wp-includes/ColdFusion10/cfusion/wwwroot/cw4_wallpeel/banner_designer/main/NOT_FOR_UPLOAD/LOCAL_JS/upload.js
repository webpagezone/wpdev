document.querySelector('input[type=file]').addEventListener('change', function (event) {
    $('#blockArea').show();
    // Read files
    var files = event.target.files;
    var timestamp = $.now();
    // Iterate through files
    for (var i = 0; i < files.length; i++) {
        // Ensure it's an image
        if (files[i].type.match(/image.*/)) {
            $('.preloader').show();
            // Load image
            var reader = new FileReader();
            reader.onload = function (readerEvent) {
                var image = new Image();
                image.onload = function (imageEvent) {
                    // Add elemnt to page
                    //var imageElement = document.createElement('div');
                    //document.querySelector('div.motiveHolder').appendChild(imageElement);
                    // Resize image
                    var canvas = document.createElement('canvas'),
                        max_size = 1200,
                        width = image.width,
                        height = image.height;
                    if (width > height) {
                        if (width > max_size) {
                            height *= max_size / width;
                            width = max_size;
                        }
                    } else {
                        if (height > max_size) {
                            width *= max_size / height;
                            height = max_size;
                        }
                    }
                    canvas.width = width;
                    canvas.height = height;
                    canvas.getContext('2d').drawImage(image, 0, 0, width, height);
                    if(window.saveTime === undefined){
                        window.saveTime = $.now();
                    }
                    if(!designExist){
                        curName = window.currentName+window.saveTime;
                    }else{
                        curName = window.currentName;
                    }
                    $.ajax({
                        url: 'upload.php',
                        type: "POST",
                        data: ({
                            data: canvas.toDataURL('image/png'),
                            curDesignName: curName,
                            curTime: timestamp
                        }),
                        success: function (data) {
                            var src='uploadMotive/' + curName + '/' + timestamp + '.png';
                            fabric.Image.fromURL(src, function(img) {
                                var oImg = img.set({ left: 280, top: 260});
                                if(isFront){
                                    var _scaleY = designCanvasFront.height / oImg.width;
                                    var _scaleX = designCanvasFront.width / oImg.width;
                                    if(oImg.width>designCanvasFront.width*0.5){
                                        oImg.set('scaleY', _scaleY*0.4);
                                        oImg.set('scaleX', _scaleX*0.4);
                                    }
                                    designCanvasFront.add(oImg);            
                                    designCanvasFront.renderAll();
                                    designCanvasFront.calcOffset();
                                    totalPrice = parseFloat(totalPrice)+parseFloat(window.motivePrice);
                                    $('#priceView').text(totalPrice.toFixed(2)+currencySign); 
                                }
                                if(isBack){
                                    var _scaleY = designCanvasBack.height / oImg.width;
                                    var _scaleX = designCanvasBack.width / oImg.width;                        
                                    if(oImg.width>designCanvasBack.width*0.5){
                                        oImg.set('scaleY', _scaleY*0.4);
                                        oImg.set('scaleX', _scaleX*0.4);
                                    }   
                                    designCanvasBack.add(oImg);            
                                    designCanvasBack.renderAll();
                                    designCanvasBack.calcOffset();
                                    totalPrice = parseFloat(totalPrice)+parseFloat(window.motivePrice);
                                    $('#priceView').text(totalPrice.toFixed(2)+currencySign); 
                                }                                
                                $('.preloader').hide();
                                $('#blockArea').fadeOut();
                                activeMode();
                                isDesign = true;         
                            }); 
                        },
                        error: function (data) {
                            $('.motiveHolder').empty();
                            $('#resizeMotiveHolder').hide();
                        }
                    });

                    function activeMode(){
                        $('#saveBtn').css('opacity','1');
                        $('#saveBtn').css('cursor', 'pointer');        
                        $('#deleteDesign').css('opacity','1');
                        $('#deleteDesign').css('cursor', 'pointer'); 
                        $('#previewBtn').css('opacity','1');
                        $('#previewBtn').css('cursor', 'pointer');
                        $('#formBtn').css('opacity','1');
                        $('#formBtn').css('cursor', 'pointer');      
                    }

                    function inactiveMode(){
                        $('#saveBtn').css('opacity','0.5');
                        $('#saveBtn').css('cursor', 'default');       
                        $('#deleteDesign').css('opacity','0.5');
                        $('#deleteDesign').css('cursor', 'default'); 
                        $('#previewBtn').css('opacity','0.5');
                        $('#previewBtn').css('cursor', 'default');
                        $('#shareBtn').css('opacity','0.5');
                        $('#shareBtn').css('cursor', 'default');
                        $('#formBtn').css('opacity','0.5');
                        $('#formBtn').css('cursor', 'default');                   
                    }
                }
                image.src = readerEvent.target.result;
            }
            reader.readAsDataURL(files[i]);
        }
    }
    // Clear files
    event.target.value = '';
});