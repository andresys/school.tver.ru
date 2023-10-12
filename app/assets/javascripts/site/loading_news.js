
var number_page = 1,
		fotorams = $('#my-fotorama, .fotorama-news');


function GetNextPage(url)
{
	var events_container = $('.b-events-container');
	var window_                 = $(window),
			events                  = $('.b-event', events_container),
			url_document            = document.location.href;
	
	getData ( url_document, number_page );
	number_page++;

	function getData (url, number, flag) {
		var url2 = url;
		if ( url2.search('year') >= 0){ url2 += '&ajax=true' } else { url2 += '?ajax=true' }
		var full_url    = url2 + "&page=" + number,
				string_page = $.get( full_url , function( data ){
					if( data.search('FORJS') >= 0 ){
						data = data.substring( data.search('FORJS') + 13 );
						data = data.substring( 0, data.search('FORJS') - 12 );
						var  new_data = events_container.append( data );

						fotorams = $('#my-fotorama, .fotorama-news')
						
						startFotorama ();
						$.get( url2 + "&page=" + (number + 1) , function( data ){
							if( data.search('FORJS') < 0 ){
								removeButton();
							}
						});
					}
					else {
						removeButton();
					}
				});
	}

	function removeButton()
	{
		var link_active = $('.b-enable-sorting');
		link_active.css('display', 'none')
	}

};


function startFotorama () {
	var new_events = $('.fotorama-news:not(.fotorama)');

	run_fotorama(new_events, 120, false);
	run_full_fotorama(new_events,'.fotorama-news');
	new_events.find('.i0').bind('click',hideFotorama);
}

function run_fotorama(_way, height, _thumbsCentered){
	_way.fotorama({
		width: '100%',
		height: 467,
		background: 'none',
		navBackground: 'none',
		thumbSize: height,
		fullscreenIcon: true,
		thumbMargin: 9,
		zoomToFit: false,
		cropToFitIfFullscreen: false,
		thumbsCentered: _thumbsCentered,
		shadows: false

	});
}

function run_full_fotorama(_fotorama,_fotorama_way){
	var left = 0, new_left = 0;
	$('.fotorama__thumb', _fotorama).mousedown(function(){
		left = $(this).parents(_fotorama_way).find('.fotorama__thumbs-shaft').offset().left;
		new_left = left;
	});
	$('.fotorama__thumb', _fotorama).mouseup(function(){
		var _this_fotorama = $(this).parents(_fotorama_way)
		new_left = _this_fotorama.find('.fotorama__thumbs-shaft').offset().left;
		if(left == new_left) {
			fotorams.hide();
			_this_fotorama.show().removeClass('fotorama-list');
			$(this).parents(_fotorama_way).fotorama().trigger('fullscreenopen')
		}
	});
}

function hideFotorama(){
	$('#my-fotorama, .fotorama-news').addClass('fotorama-list').show();
}


// $(function () {


// 	preloadEvents();

// 	function preloadEvents(){

// 		var events_container = $('.b-events-container');

// 		if( events_container ) {
			
			

// 			function runGetRequest () {

// 				var window_                 = $(window),
// 						events                  = $('.b-event', events_container),
// 						events_count            = events.length,
// 						events_height           = events_container.height(),
// 						events_container_top    = events_container.offset().top,
// 						events_container_bottom = events_container_top + events_height,
// 						url_document            = document.location.href,
// 						number_page             = 1,
// 						temp_scroll_top         = 0,
// 						scroll_top              = window_.scrollTop(), 
// 						preload_value           = 700,
// 						value_stop_preload      = false,
// 						value_stop_preload2      = true,
// 						loader                  = $('.b-ajax-loader');

// 				if( events_count >= 10 ) loader.css('display', 'block');

// 				console.log(events_count);


// 				/* Install the first value */
// 				window_.scrollTop(0);

// 				window_.scroll( scrolling );

// 				function scrolling () {
// 					scroll_top = window_.scrollTop();
// 					console.log("AAAAAAAAAAA");

// 					/* Only scroll down */
// 					if ( temp_scroll_top > scroll_top ) return;


// 					if ( scroll_top >= ( events_container_bottom - preload_value ) && events_count >= 10 && !value_stop_preload && value_stop_preload2) {
// 						value_stop_preload2 = false;
// 						console.log(value_stop_preload)
// 						console.log(events_count)
// 						console.log(number_page)
// 						getData ( url_document, number_page );


// 						events_container        = $('.b-events-container'),
// 						events                  = $('.b-event', events_container);
// 						events_count            = events.length,
// 						events_height           = events_container.height(),
// 						events_container_bottom = events_container_top + events_height;

// 						!value_stop_preload ? number_page++ : underfined ;
// 						value_stop_preload2 = true;
// 					}
// 				}

// 				/* Get a string with new news and return object:
// 				new_news = {
// 					news_(value_id): 'value_html',
// 					...
// 				}
// 				*/
// 				function getData (url, number) {

// 					var full_url    = url + "?page=" + number,
// 							string_page = $.get( full_url , function( data ){
// 								if( data.search('FORJS') >= 0 ){
// 									data = data.substring( data.search('FORJS') + 13 );
// 									data = data.substring( 0, data.search('FORJS') - 12 );
// 									events_container.append( data );

// 									value_stop_preload = false;
// 								}
// 								else {
// 									value_stop_preload = true;
// 									loader.css('display', 'none');
// 								}
// 							});
// 				}


// 			}

// 			runGetRequest ();




// 		}


// 	}
	

	
	

// });