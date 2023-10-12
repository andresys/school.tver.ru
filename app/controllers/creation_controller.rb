# coding: utf-8
class CreationController < ApplicationController
include ApplicationHelper
	def show
		@news_data = @school.creation.find(params[:id])
	end

	def index
	  	@type_news = 'creation'
	  	@news_data = get_news()
	    @next_page = check_next_page()
	  	if params[:ajax]
	  		render 'creation_block', :layout => false
	  		return
	  	end
	end
end
