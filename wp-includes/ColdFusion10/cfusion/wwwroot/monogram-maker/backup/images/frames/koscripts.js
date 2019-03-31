function Model() {
    var self = this;

    self.category = ko.observableArray([]);

    self.showing = ko.observable('');

    self.categoryShown = function (title) {
        return self.showing() == title;  
    };

    self.showCategory = function (title) {
        self.showing(title);
        //console.log(title);
    };

    $.getJSON("/Monogram/xml/ImagesData.js", function (data) {
        self.category(data.Category);
        self.showCategory('Icons');//show this category
               
    });

    self.getImage = function (event) {

        fabric.Image.fromURL(this.Url, function (img) {
            var oImg = img.set({ left: 200, top: 250 });
            oImg.scale(1);
            designCanvasFront.add(oImg);
            
            designCanvasFront.setActiveObject(designCanvasFront.item(designCanvasFront.getObjects().length-1));

            //items_len += 1;

            //designCanvasFront.item.length;
            //console.log(items_len);
            //var len = items_len;
            
           // designCanvasFront.setActiveObject(designCanvasFront.item(len - 1));
   
        });
    }
}

var model = new Model();
//model.showing('Trees');
ko.applyBindings(model,$('#ImagesSelector')[0]);






