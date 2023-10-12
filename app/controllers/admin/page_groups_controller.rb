class Admin::PageGroupsController < AdminController
  
  def show
    if params[:link]
      redirect_to :action => :index, :link => params[:link]
    end
  end

  def index
    @group = @school.page_group.find_all_by_content_type(params[:link])
  end

  def edit
    @group = @school.page_group.find(params[:id])
  end

  def update
    @group = @school.page_group.find(params[:id])
    if @group.update_attributes(params[:page_group])
      redirect_to :action => :index, :link => @group.content_type
    else
      render 'edit'
    end
  end

  def new
    @group = @school.page_group.new
    @group.content_type = params[:link]
  end

  def create
    @group = @school.page_group.new(params[:page_group])
    if @group.save
      redirect_to :action => :index, :link => @group.content_type
    else
      render 'new'
    end
  end

  def destroy
    @group = @school.page_group.find(params[:id])
    if !@group.default
      @group.destroy
    end
    redirect_to admin_school_path(@school)
  end

  def navigation
    if !params[:jsonData].nil?
      ActiveSupport::JSON.decode(params[:jsonData]).each do |data|
        if data[1].class != Hash
          @size = @school.page_group.find_all_by_content_type(data[1]).size
        end
      end
      ActiveSupport::JSON.decode(params[:jsonData]).each do |data|
        if data[1].class == Hash
          data_position = data[1].deep_symbolize_keys
          group = @school.page_group.find(data_position[:id].to_i)
          group.number = @size - data_position[:position].to_i
          data_position[:items].each do |item|
             item = item.deep_symbolize_keys
             item_position = PageNavigationLink.find(item[:id].to_i)
             size2 = item_position.page_group.page_navigation_link.size
             item_position.number = size2 - item[:position].to_i
             item_position.save
          end
          group.save
        end
      end
    end
    redirect_to :action => :index, :link => 'about'
    # render nothing: true
  end
  
end
