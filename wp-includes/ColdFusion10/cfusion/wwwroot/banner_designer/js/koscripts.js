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

    $.getJSON("/banner_designer/xml/ImagesData.js", function (data) {
        self.category(data.Category);
        self.showCategory('Icons');//show this category
               
    });

    self.getImage = function (event) {

        fabric.Image.fromURL(this.Url, function (img) {
            var oImg = img.set({ left: 280, top: 260 });
            if (isFront) {

                oImg.scale(0.2);
                designCanvasFront.add(oImg);

            
            items_len += 1;

            //designCanvasFront.item.length;
            console.log(items_len);
            var len = items_len;
            designCanvasFront.setActiveObject(designCanvasFront.item(len - 1));
                
            }
        });
    }
}

var model = new Model();
//model.showing('Trees');
ko.applyBindings(model,$('#ImagesSelector')[0]);






