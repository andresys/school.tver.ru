class Admin::StaticPagesController < AdminController
  
  def show
    @page = StaticPage.find_by_id(params[:id])
    p "============"
    p params

    @pages = @school.page_group.where(published: true).find_all_by_content_type(params[:as])
    @groups = @school.page_group.where(published: true).find_all_by_content_type(params[:link])

    redirect_to :action => :edit if @page
    render "static_pages/#{[params[:group], params[:id]].compact.join('/')}" unless @page
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
      if !params[:static_page][:title].nil?
        @page.page_navigation_link.update_attributes(:title => params[:static_page][:title])
      end
      redirect_to admin_school_page_groups_path(@school, :action => :index, :link => @page.page_navigation_link.page_group.content_type)
    else
      render 'edit'
    end
  end

  def new
    @group = @school.page_group.find(params[:group_id])
    @page = StaticPage.new
    # @page.content_type = params[:link]
  end

  def create
    @group = @school.page_group.find(params[:groups][:group_id])
    params[:static_page][:page_navigation_link_id] = 0
    @page = StaticPage.new(params[:static_page])
    if @page.save
      @link = @group.page_navigation_link.create(:title => params[:static_page][:title], :link => "static_pages/#{@page.id}")
      @link.save
      @page.page_navigation_link_id = @link.id
      @page.save
      redirect_to admin_school_page_groups_path(@school, :action => :index, :link => @link.page_group.content_type)
    else
      @link.destroy
      render 'new'
    end
  end
  
  def destroy
    @page = @school.static_page.find(params[:id])
    if !@page.default
      @page.page_navigation_link.destroy
      @page.destroy 
    end
    redirect_to admin_school_path(@school)
  end

end