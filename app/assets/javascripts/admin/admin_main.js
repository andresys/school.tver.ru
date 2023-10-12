
function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).parent().before(content.replace(regexp, new_id));
}

$(function(){
	// add_files($('#photos .b-list-files'), 'photo', $('#photos .b-adding-file .link'));
	// add_files($('#docx .b-list-files'), 'docx', $('#docx .b-adding-file .link'));
	// add_links($('#links .b-parallel-input'), 'link', 'text-link', $('#links .b-adding-file .link'));
	example_tabs();
	textarea();
	change_hidden_text();
	removing_files('.b-removing-image');
	removing_files('.b-removing-files');
	removing_files('.b-links-removing');

	function add_files(list_files, name, link){
		link.live('click',function(){
			var new_index = list_files.find('.item').size() + 1;
			list_files.append('<li class="item"><input type="file" name="'+name+'-'+new_index+'"/></li>');
			return false;
		});
	}
	function add_links(list_links, name_1, name_2, link){
		link.live('click',function(){
			var new_index = list_links.find('.item').size() + 1;
			list_links.append('<li class="item"> \
									<input type="text" name="'+name_1+'-'+new_index+'" placeholder="Адрес ссылки" class="input-left" /> \
									<input type="text" name="'+name_2+'-'+new_index+'" placeholder="Текст ссылки" class="input-right" /> \
								</li>');
			return false;
		});
	}
	function example_tabs(){
		var container = $('.b-tabs-examples'),
			links = $('.title .link', container),
			examles = $('.b-tabs-examles', container),
			examples_close = $('.b-tabs-examples .item-close .b-tabs-examles');
			examples_close.hide();
		links.click(function(){
			_this = $(this);
			item_open = _this.parents('.b-tabs-examples').find('.item-open');
			parent_item = $(this).parents('.item');
			if(parent_item.hasClass('item-close')){
				item_open.find('.b-tabs-examles').slideUp(100,function(){
					item_open.removeClass('item-open').addClass('item-close');
				})
				parent_item.find('.b-tabs-examles').slideDown(100,function(){
					parent_item.removeClass('item-close').addClass('item-open');
				});
			}
			else{
				parent_item.find('.b-tabs-examles').slideUp(100,function(){
					parent_item.removeClass('item-open').addClass('item-close');
				});
			}
			return false;
		});
	}
	function textarea(){
		var code = $('.b-example-code-mini');
		code.click(function(){
			_this = $(this);
			/*code_text = _this.text().replace(/[ \t]{2,}/g, ' ');
			code_height = _this.height();
			code_width = _this.width();
			_this.empty().css('padding','0');
			_this.append('<textarea class="b-text-area-code">'+code_text+'</textarea>').addClass('textarea');*/
		});
	}
	function change_hidden_text(){
		var main_block = $('.b-hidden-text');
		var changing_link = $('.change-show-hidden-text a', main_block);
		var hidden_text = $('.hidden-text', main_block);
		hidden_text.hide();
		changing_link.toggle(function(){
			var _this = $(this);
			_this.parents('.b-hidden-text').find('.hidden-text').slideDown(100);
			_this.parents('.b-hidden-text').find('.arrow').css('backgroundPosition', '0 0');
			return false;
		},function(){
			var _this = $(this);
			_this.parents('.b-hidden-text').find('.hidden-text').slideUp(100);
			_this.parents('.b-hidden-text').find('.arrow').css('backgroundPosition', '-9px 0');
			return false;
		});
	}
	
	function removing_files(block){
		var icon = $('.b-removing-icon', $(block));
		var checkbox = $('.hidden:checked',$(block));
		checkbox.each(function(index, element){
		    $(element).parents(block).addClass('b-removed');
		});
		icon.click(function(){
			var _this_block = $(this).parents(block)
			if(_this_block.hasClass('b-removed')){
				_this_block.removeClass('b-removed');
			}
			else {
				_this_block.addClass('b-removed');
			}
		});
	}
	submit_interactive();
	function submit_interactive(){
		var interactive = $('.b-submit-interactive'),
			submit = $('.submit', interactive);

		submit.parents('form').submit(function(){
			interactive.hide();
			interactive.after('<div class="b-downloader"> <span class="loader"></span><span class="text">Сохранение информации...</span></div>');
			return true;
		});
	}
});


inputPlaceholder( document.getElementById('some_input') )

function inputPlaceholder (input, color) {

	if (!input) return null;

	// Do nothing if placeholder supported by the browser (Webkit, Firefox 3.7)
	if (input.placeholder && 'placeholder' in document.createElement(input.tagName)) return input;

	color = color || '#AAA';
	var default_color = input.style.color;
	var placeholder = input.getAttribute('placeholder');

	if (input.value === '' || input.value == placeholder) {
		input.value = placeholder;
		input.style.color = color;
		input.setAttribute('data-placeholder-visible', 'true');
	}

	var add_event = /*@cc_on'attachEvent'||@*/'addEventListener';

	input[add_event](/*@cc_on'on'+@*/'focus', function(){
	 input.style.color = default_color;
	 if (input.getAttribute('data-placeholder-visible')) {
		 input.setAttribute('data-placeholder-visible', '');
		 input.value = '';
	 }
	}, false);

	input[add_event](/*@cc_on'on'+@*/'blur', function(){
		if (input.value === '') {
			input.setAttribute('data-placeholder-visible', 'true');
			input.value = placeholder;
			input.style.color = color;
		} else {
			input.style.color = default_color;
			input.setAttribute('data-placeholder-visible', '');
		}
	}, false);

	input.form && input.form[add_event](/*@cc_on'on'+@*/'submit', function(){
		if (input.getAttribute('data-placeholder-visible')) {
			input.value = '';
		}
	}, false);

	return input;
}