# coding: utf-8
class NewsController < ApplicationController
include ApplicationHelper
  def show
    @news_data = @school.news.find(params[:id])
  end

  def index
  	@type_news = 'news'
  	@news_data = get_news()
    @next_page = check_next_page()
  	if params[:ajax]
  		render 'news_block', :layout => false
  		return
  	end
  end
end
