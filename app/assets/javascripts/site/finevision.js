$(function() {
    this.window.finevision = this;
    var finevision = !($.cookie("finevision") === null);
    var finevision_size = $.cookie("finevision_size");
    var finevision_color = $.cookie("finevision_color");
    var finevision_image = $.cookie("finevision_image");
    var f = {
        toggle: function(button) {
            $('i', button).toggleClass('collapse');
            $('ul.toolbar').toggleClass('collapse');
            
            finevision = !finevision;
            $.cookie("finevision", finevision ? "" : null, {
                expires: 365,
                path: '/'
            });
            if (finevision) { fOn() } else { fOff() }
        },
        size: function(size) {
            finevision_size = size;
            $.cookie("finevision_size", finevision_size, {
                expires: 365,
                path: '/'
            });
            if (finevision_size != null) {fSize(finevision_size)}
        },
        color: function(color) {
            finevision_color = color;
            $.cookie("finevision_color", finevision_color, {
                expires: 365,
                path: '/'
            });
            if (finevision_color) {fColor(finevision_color)}
        },
        image: function(image) {
            finevision_image = image;
            $.cookie("finevision_image", finevision_image, {
                expires: 365,
                path: '/'
            });
            if (finevision_image) {fImage(finevision_image)}
        }
    }
    function fOn() {
        $('body').addClass('finevisioncontent-on');
    }
    function fOff() {
        $('body').removeClass('finevisioncontent-on');
    }
    function fSize(size) {
        $('body').removeClass('finevisioncontent-size1');
        $('body').removeClass('finevisioncontent-size2');
        $('body').removeClass('finevisioncontent-size3');
        $('body').addClass('finevisioncontent-size' + size);
    }
    function fColor(color) {
        $('body').removeClass('finevisioncontent-color1');
        $('body').removeClass('finevisioncontent-color2');
        $('body').removeClass('finevisioncontent-color3');
        $('body').addClass('finevisioncontent-color' + color);
    }
    function fImage(image) {
        $('body').removeClass('finevisioncontent-image1');
        $('body').removeClass('finevisioncontent-image2');
        $('body').removeClass('finevisioncontent-image3');
        $('body').addClass('finevisioncontent-image' + image);
    }
    if (finevision) { fOn() } else { fOff() }
    if (finevision_size) {fSize(finevision_size)}
    if (finevision_color) {fColor(finevision_color)}
    if (finevision_image) {fImage(finevision_image)}
    for (var a in f) { this.__proto__[a] = f[a]; }
}(window));