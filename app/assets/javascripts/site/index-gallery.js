$(function() {
	var $document = $(document);
	var fotorama_index = $('#fotorama-index');

	var activeIndex;
	var arrows = $('#fotorama-arrows').find('.link');
	var arrows_prev = $('#fotorama-arrows').find('.link-prev');
	var arrows_next = $('#fotorama-arrows').find('.link-next');
	var size = fotorama_index.find('.applead__item').size();
	if(size == 1){
		$('#fotorama-arrows').hide();
		add_fotorama('none');
	}
	else {
		add_fotorama('dots');
	}
	// FOTORAMA
	function add_fotorama(nav_value){
		fotorama_index.fotorama({
			width: 620,
			height: 263,
			arrows: false,
			nav: nav_value,
			hash: false,
			fitToWindowHeight: true,
			autoplay: 5000,
			background: '#fff',
			onShowImg: function(data, auto) {
				activeIndex = data.index;
				if(activeIndex == 0){
					arrows_prev.addClass('disabled-prev');
				}
				else{
					arrows_prev.removeClass('disabled-prev');
				}
				if(activeIndex == size-1){
					arrows_next.addClass('disabled-next');
				}
				else{
					arrows_next.removeClass('disabled-next');
				}	
			}
		});


		// CUSTOM THUMBS AND ARROWS
		arrows.bind('click', function(){
			var index = $(this).attr('data-action');

			if (index == 'next') {
				index = activeIndex + 1;
			} else if (index == 'prev') {
				index = activeIndex - 1;
			}

			if (index > size - 1) {
				index = size - 1;
			}

			if (index < 0) {
				index = 0;
			}

			fotorama_index.trigger('showimg', index);
			return false;
		});
	}
});