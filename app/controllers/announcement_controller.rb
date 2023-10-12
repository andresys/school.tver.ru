# coding: utf-8
class AnnouncementController < ApplicationController
include ApplicationHelper
  def show
    @news_data = @school.announcement.find(params[:id])
  end

  def index
  	@type_news = 'announcement'
    @news_data = get_news()
    @next_page = check_next_page()
    if params[:ajax]
      render 'announcement_block', :layout => false
      return
    end
  end
end