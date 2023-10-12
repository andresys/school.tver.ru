class Root::GlobalPagesController < SuperAdminController
  def edit
    @page = GlobalPage.find(params[:id])
  end

  def update
    @page = GlobalPage.find(params[:id])
    if @page.update_attributes(params[:global_page])
      redirect_to :action => :index, :controller => :navigation
    else
      render 'edit'
    end
  end

end