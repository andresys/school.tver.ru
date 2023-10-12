class FoodController < ApplicationController
include ApplicationHelper
  def index
    @type_news = 'food'
  	@news_data = get_news()
    @next_page = check_next_page()
  	if params[:ajax]
  		render 'news_block', :layout => false
  		return
  	end
  end

  def show
    if params[:id] == 'findex'
      send_file @school.findex.file.path, filename: "findex.xlsx"
      return
    end

    @food = Food.get_by_menufilename(@school, params[:id])
    respond_to do |format|
      format.html {}
      format.all do
        send_file @food.file.path, filename: "#{@food.menufilename}.#{@food.get_file_ext}"
      end
    end
  end

end