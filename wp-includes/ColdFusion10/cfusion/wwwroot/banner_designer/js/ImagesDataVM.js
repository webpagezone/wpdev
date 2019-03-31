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
                designCanvasFront.renderAll();
            }
        });
    }
}


//ko.applyBindings(new Model());
//Model.showing('Trees');



var model = new Model();
//model.showing('Trees');
ko.applyBindings(model,$('#ImagesSelector')[0]);

//model


//Model.showing('Trees');

//var model = new Model(data);
//ko.applyBindings(model, $('#EmployeeSelector')[0]);
//model.showing('Trees');


//ko.applyBindings(new ViewModel());

//function ViewModel() {
//    var self = this;

//    self.category = ko.observableArray([]);
//    self.image = ko.observableArray([]);

//    $.getJSON("/banner_designer/xml/ImagesData.js", function (data) {
//        self.category(data.Category);
//        self.image(data.image);
//    });

//    self.getCategory = function (event) {
    
//        $.getJSON("/banner_designer/xml/ImagesData.js", function (data) {
//        self.category(data.Category);
//        self.image(data.image);
//        console.log(data.image);
//        });
//    };


    







