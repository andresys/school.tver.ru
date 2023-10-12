$(function() {
	var first_tab = $('.b-tabs-compact .item:first .link').attr('href');
	if(first_tab){
		run_tabs('#tabs', '.b-tabs a', '.js-tab', first_tab.substr(5));
	}
	
	run_tabs('#tabs-area', '.b-tabs-area a', '.js-tab-area', 'area-1');
	run_tabs('#tabs-schedule', '.b-tabs-schedule-compact a', '.js-tab-schedule', 'schedule-1');
	
	$('.b-gallery').tileGallery();

	function run_tabs(name_tabs, links, tab_selector, _hash){
		$(name_tabs).tabs({
			linkSelector: links,
			tabSelector: tab_selector,
			onSwitchTab: function(){
				$.history.load($(this).attr('href').substr(5));
			}
		});
		$.history.init(function(hash){
			if( hash == '' ){
				hash = _hash;
			}
			hash = hash.replace('tab-', '');
			$(name_tabs+" a[href='#tab-" + hash + "']").trigger('clickOnly');
		});
	}




	
	var fotorams = $('#my-fotorama, .fotorama-news')
	run_fotorama($('#my-fotorama'), 84, true);
	run_fotorama($('.fotorama-news'), 120, false);
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
	run_full_fotorama($('#my-fotorama'),'#my-fotorama');
	run_full_fotorama($('.fotorama-news'),'.fotorama-news');

	var i0 = $('.i0')
	i0.bind('click', hideFotorama);







	$('.b-add-news').click(function(){

		
	});
	$(document).keydown(function(e) {
	    if( e.keyCode === 27 ) {
	        fotorams.addClass('fotorama-list').show();
	    }
	});


	function hideFotorama(){
		$('#my-fotorama, .fotorama-news').addClass('fotorama-list').show();
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


	form_input()
	function form_input(){
		var form = $('.b-form-input')
		var height_form = form.height();
		centering_form(form,height_form);
		$(window).resize(function(){
			centering_form(form,height_form)
		});
	}
	function centering_form(form,height_form){
		var window_height = $(window).height();
		var margin = (window_height-(height_form+83))/2;
		if(margin <= 0){
			margin = 0;
		}
		form.css('marginTop',margin+'px');
	}
	substr();
	function substr(){
		var str_array = $('.b-events-list .month');
		str_array.each(function(event){
			_this = str_array.eq(event).text()
			if(_this.length > 3){
				str = _this.substr(0,3);
				str_array.eq(event).text(str+'.')
			}
		});
	}
});




(function($){
	$.fn.tileGallery = function( userSettings ){
		var SETTINGS = {
			framesSelector: '.link',
			imageSelector: '.image',
			distance: 6,
			alignLimit: 50,
			idealLimit: 3
		};
		
		return this.each(function(){
			if( userSettings ){
				$.extend( SETTINGS, userSettings );
			}
			
			var _galleryContainer = $(this),
				_galleryWidth = _galleryContainer.width() - SETTINGS.distance,
				
				_frames = $(SETTINGS.framesSelector, _galleryContainer);
			
			if( _frames.length ){
				var _firstFrame = _frames.first(),
					_firstFrameWidth = _firstFrame.width(),
					_firstFrameImage = $(SETTINGS.imageSelector, _firstFrame),
					
					_firstRowHeight = _frames.last().height(),
					_secondRowHeight = _frames.last().height();
					_rowsCount = 0;
				
				_galleryContainer.css('margin-right', -SETTINGS.alignLimit);
				assignPositions();
				tile();
			}
			
			function assignPositions(){
				var row = 1;
				
				// Для каждой картинки указываем её ряд и номер
				_frames.each(function( index ){
					var thisFrame = $(this),
						thisImage = $(SETTINGS.imageSelector, thisFrame);
					
					thisFrame.width(thisImage.width()); // Ширину задаём только из-за IE7
					
					if( index > 0 ){
						if( thisFrame.offset().top !== thisFrame.prev().offset().top ){
							row++;
						}
						
						thisFrame.attr('row', row);
					}
				});
				
				_rowsCount = row;
			}
			
			function tile(){
				var firstRowDiff = _galleryWidth - calculateRowWidth(1),
					secondRowDiff = _galleryWidth - calculateRowWidth(2),
					
					isFirstRowIdeal = firstRowDiff <= SETTINGS.idealLimit,
					isBothRowsIdeal = firstRowDiff == secondRowDiff && firstRowDiff <= SETTINGS.idealLimit && secondRowDiff <= SETTINGS.idealLimit,
					isFirstRowAlign = firstRowDiff <= SETTINGS.alignLimit,
					isSecondRowAlign = secondRowDiff <= SETTINGS.alignLimit;
				
				if( _rowsCount == 1 ){
					if( isFirstRowIdeal ){
						// Идеальная ситуация: край первого ряда очень близок к границе
						
						changeFirstImageWidth(firstRowDiff);
					}
					else if( isFirstRowAlign ){
						// Нужно выравнивать первый ряд и главную картинку
						
						tileRow(1);
						changeFirstImageHeight();
					}
				}
				else if( _rowsCount == 2 ){
					if( isBothRowsIdeal ){
						// Идеальная ситуация: края первого и второго ряда равны и очень близки к границе
						
						changeFirstImageWidth(firstRowDiff);
					}
					else{
						// Нужно выравнивать первый ряд и главную картинку
						
						tileRow(1);
						
						if( isSecondRowAlign ){
							// Второй ряд нужно выравнивать
							
							tileRow(2);
						}
						
						changeFirstImageHeight();
					}
				}
				else if( _rowsCount > 2 ){
					if( isBothRowsIdeal ){
						// Идеальная ситуация: края первого и второго ряда равны и очень близки к границе
						
						changeFirstImageWidth(firstRowDiff);
					}
					else{
						// Нужно выравнивать первый и второй ряд, а также главную картинку
						
						tileRow(1);
						tileRow(2);
						changeFirstImageHeight();
					}
					
					// Выравниваем остальные ряды
					for( var i = 3; i <= _rowsCount; i++ ){
						tileRow(i);
					}
				}
			}
			
			function tileRow( rowNumber ){
				var rowWidth = calculateRowWidth(rowNumber),
					rowDiff = _galleryWidth - rowWidth,
					rowFrames = _frames.filter('[row=' + rowNumber + ']');
				
				if( rowNumber <= 2 ){
					rowWidth -= _firstFrameWidth + SETTINGS.distance;
				}
				
				if( !(rowNumber == _rowsCount && rowDiff > SETTINGS.alignLimit) ){
					// Ряд нужно выравнивать
					
					var framesWidth = rowWidth - (SETTINGS.distance * rowFrames.length),
						lastFrameDiff = rowDiff,
						frameMinHeight = 9999;
					
					// Задаём ширину картинкам. Широкоформатные получают больше.
					rowFrames.each(function( index ){
						var thisFrame = $(this),
							thisDiffRatio = thisFrame.width() / framesWidth,
							thisDiff = 0;
						
						if( index != rowFrames.length - 1 ){
							thisDiff = Math.round(rowDiff * thisDiffRatio);
							
							changeImageSize(thisFrame, {
								widthDiff: thisDiff
							});
							
							lastFrameDiff -= thisDiff; 
						}
						else{
							changeImageSize(thisFrame, {
								widthDiff: lastFrameDiff
							});
						}
					});
					
					// Считаем минимальную высоту картинок
					rowFrames.each(function(){
						var thisFrameHeight = $(this).height();
						
						if( thisFrameHeight < frameMinHeight ){
							frameMinHeight = thisFrameHeight;
						}
					});
					
					// Запоминаем высоту первого и второго ряда
					if( rowNumber == 1 ){
						_firstRowHeight = frameMinHeight;
					}
					else if( rowNumber == 2 ){
						_secondRowHeight = frameMinHeight;
					}
					
					// Обрезаем картинки по минимальной высоте в ряду
					rowFrames.each(function(){
						var thisFrame = $(this);
						
						thisFrame.height(frameMinHeight);
					});
				}
			}
			
			function calculateRowWidth( rowNumber ){
				var result = 0,
					rowFrames = _frames.filter('[row=' + rowNumber + ']');
				
				if( rowNumber <= 2 ){
					result += _firstFrameWidth + (SETTINGS.distance * rowFrames.length);
				}
				else {
					result += SETTINGS.distance * (rowFrames.length - 1);
				}
				
				rowFrames.each(function(){
					result += $(this).width();
				});
				
				return result;
			}
			
			// TODO: единый механизм изменения размеров фрейма, изображения и его позиции во фрейме
			
			function changeFirstImageWidth( diff ){
				changeImageSize(_firstFrame, {
					widthDiff: diff
				});
				
				_firstFrame.height(_firstRowHeight * 2 + SETTINGS.distance);
			}
			
			function changeFirstImageHeight(){
				var originalWidth = _firstFrame.width(),
					originalHeight = _firstFrame.height(),
					newHeight = _firstRowHeight + _secondRowHeight + SETTINGS.distance;
				
				if( newHeight > originalHeight ){
					changeImageSize(_firstFrame, {
						height: newHeight
					});
						
					_firstFrame.width(originalWidth);
					_firstFrameImage.css('margin-left', Math.round((_firstFrameImage.width() - originalWidth) / 2) * -1)
				}
				else if( newHeight < originalHeight ){
					_firstFrame.height(newHeight);
					_firstFrameImage.css('margin-top', Math.round((originalHeight - newHeight) / 2) * -1);
				}
			}
			
			function changeImageSize(frame, params){
				if( typeof params === 'object' ){
					var image = $(SETTINGS.imageSelector, frame),
						originalWidth = image.width(),
						originalHeight = image.height(),
						newWidth = originalWidth,
						newHeight = originalHeight;
					
					if( params.hasOwnProperty('widthDiff') ){
						newWidth = originalWidth + params.widthDiff,
						newHeight = Math.round( newWidth * originalHeight / originalWidth );
					}
					else if( params.hasOwnProperty('height') ){
						newHeight = params.height;
						newWidth = Math.round( newHeight * originalWidth / originalHeight );
					}
					
					frame.width(newWidth); // Только из-за IE7
					image.width(newWidth).height(newHeight);
				}
			}
		});
	};
})( jQuery );