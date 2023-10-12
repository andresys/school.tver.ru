class StaticPagesController < ApplicationController
  def show
    @page = StaticPage.find_by_id(params[:id])

    @pages = @school.page_group.where(published: true).find_all_by_content_type(params[:as])
    @groups = @school.page_group.where(published: true).find_all_by_content_type(params[:link])
    
    render "static_pages/#{[params[:group], params[:id]].compact.join('/')}" unless @page
  end

  def index
  	@pages = @school.page_group.where(published: true).find_all_by_content_type(params[:as])
    @groups = @school.page_group.where(published: true).find_all_by_content_type(params[:link])
  end
end
