# coding: utf-8
class AnnounceToParentsController < ApplicationController
include ApplicationHelper
  def show
    @news_data = @school.announce_to_parent.find(params[:id])
  end

  def index
  	@type_news = 'announctoparent'
    @news_data = get_news()
    @next_page = check_next_page()
    if params[:ajax]
      render 'announce_to_parents_block', :layout => false
      return
    end
  end
end
