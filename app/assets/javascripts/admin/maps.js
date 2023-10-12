ymaps.ready(init);

function init () {
    var temp_n = document.getElementById("school_n_cordinate").value;
    var temp_e = document.getElementById("school_e_cordinate").value;
    var n_cordinate = temp_n;
    var e_cordinate = temp_e;
    if(!temp_n){ n_cordinate = 56.85; }
    if(!temp_e){ e_cordinate = 35.89; }
    var schools_map = new ymaps.Map("map", {
            center: [n_cordinate, e_cordinate],
            zoom: 12
        }),
        school = new ymaps.Placemark([n_cordinate, e_cordinate], {
            hintContent: 'Подвинь меня!'
        }, {
            draggable: true
        });

    schools_map.geoObjects.add(school);
    schools_map.controls.add('zoomControl', {left : '25px'});
    schools_map.controls.add(new ymaps.control.TypeSelector());
    schools_map.behaviors.enable('scrollZoom')

    school.events.add('drag', function (e) {
        var n_cordinate = document.getElementById("school_n_cordinate");
        var e_cordinate = document.getElementById("school_e_cordinate");
        var point = school.geometry.getCoordinates();
        n_cordinate.value = point[0];
        e_cordinate.value = point[1];
    });
}
