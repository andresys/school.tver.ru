class GlobalPagesController < ApplicationController
  def show
    @group, @path = (params[:path] || '').split('/', 2)
    @group, @path = ['default', @group] if @group && @path.blank?

    @page = GlobalPage.find_by_permalink(@path)

    render 'global_pages/' + params[:path] unless @page
    # if 'about'.in?request.url
    #   # @page = GlobalPage.find_by_permalink('about')
    #   @page = GlobalPage.find(1)
    #   return
    # end
    # @page = GlobalPage.find(2)
    # @page = GlobalPage.find_by_permalink('to_teacher')
  end
end