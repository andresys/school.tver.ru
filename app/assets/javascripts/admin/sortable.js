$(function() {
	

$(function () { 
	var inner_sortable = $( ".b-inner-sortable" );


	

  /* Если у нас присутствует блок сортировки на странице */
	if(inner_sortable){
		var JSON_data = "";
		/* Показ кнопки после нажатия на изменение порядка страниц */
		var link_active = $('.b-enable-sorting .link'),
			input_submit = $('.b-enable-sorting .b-save'),
			hidden_class = 'hidden';
		link_active.click(function(event){
			event.preventDefault();
			var _this = $(this);
				

			_this.parent().find('.' + hidden_class).removeClass(hidden_class);
			_this.addClass(hidden_class);
			input_submit.removeClass(hidden_class);

			JSON_data = runSortable();
		});

		/* Ajax запрос */
		$(".b-form-sortable").submit(function() {
		  input_submit.addClass(hidden_class);
		  link_active.removeClass(hidden_class);
		  JSON_data = runSortable();
		  _stop($(".b-inner-sortable"))
      _stop($(".b-page-group"))
      $.ajax($(this).attr('action'),{
          url:'page_groups?link='+window.location.search.split('=')[1]
          , type:'POST'
          , data:'jsonData='+ JSON_data
          , success: function(res) {
              
          }
      });


      
      return false;
	  });
	}

	/* Функция запускающая возможность сортировки объектов */
	function runSortable () {
		var JSON_string = change_object ();
				page_group = $(".b-page-group"),
				inner_sortable = $( ".b-inner-sortable" );

		change_object();

		run(inner_sortable, ".item:not(.ui-disabled)")
	  run(page_group, ".item-page:not(.item-page-disabled)")

	  function run (field, text_item) {
	  	field.sortable({
		  	items: text_item,
		  	stop: function( event, ui ) { JSON_string = change_object (); },
		  });

		  
	  }

	  
	  /* Функция формирующая объект типа:
			inf_sort = {
				page_group_(value_id): {
					id: value_id,
					position: value_position,
					items: [{id: value_id, position: value_position},....]
				}
				.
				.
				.
			}
	  */
		function change_object () {
			var inf_sort = {},
					inner_sortable_items = $( ".b-inner-sortable .item" ),
					page_group_items = $( ".b-page-group .item-page" );

	  	page_group_items.each(function ( i, element ) {
	  		var page_group = $(element),
	  				page_group_id = page_group.attr('id'),
	  				title_group = 'page_group_' + page_group_id,
	  				inner_items = page_group.find(".b-inner-sortable .item");

	  		inf_sort[title_group] = {};
	  		inf_sort[title_group]['id'] = Number(page_group_id);
	  		inf_sort[title_group]['position'] = i + 1;
	  		inf_sort[title_group]['items'] = [];

	  		inner_items.each(function ( j, element ) {
	  			var item = $(element),
	  					item_id = item.attr('id');

	  			inf_sort[title_group]['items'][j] = {
	  				'id': Number(item_id),
	  				'position': ( j + 1 )
	  			}

	  		});

	  	});
	  	inf_sort['page'] = document.location.search.substring(1).split('=')[1]; 

	  	return $.toJSON( inf_sort );
	  }


	  return JSON_string;
	}

	function _stop(field) {
	  	field.sortable("destroy");
	  }


	
}());

});






















