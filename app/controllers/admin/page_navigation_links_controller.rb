class Admin::PageNavigationLinksController < AdminController
  
  def show
    if params[:link]
      redirect_to :action => :index, :link => params[:link]
    end
  end

  def index
    @group = @school.page_group.find_all_by_content_type(params[:link])
  end

  def edit
    @page = StaticPage.find(params[:id])
    @documents = @page.document
  end

  def update
    @page = StaticPage.find(params[:id])
    if @page.update_attributes(params[:static_page])
      redirect_to :action => :index, 
        :link => @page.page_group.content_type
    else
      render 'edit'
    end
  end

  def new
    @link = @school.page_group.find(params[:group_id])
  end

  def create
    @group = @school.page_group.new(params[:page_group])
    @group.content_type = 'about'
    if @group.save
      redirect_to :action => :index
    else
      render 'new'
    end
  end
  
end