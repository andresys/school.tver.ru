class Admin::AnnouncementsController < AdminController

  def index
    @news_models = @school.announcement
  end

  def new
    @news_model = @school.announcement.new
  end

  def edit
    @news_model = Announcement.find(params[:id])
  end

  def create
    @news_model = @school.announcement.new(params[:announcement])
    if @news_model.save
      redirect_to :action => :index
    else
      render 'new'
    end
  end

  def update
    @news_model = Announcement.find(params[:id])
    if @news_model.update_attributes(params[:announcement])
       redirect_to :action => :index
      else
        render 'edit'
      end
    end

  def destroy
    @announcement = Announcement.find(params[:id])
    @announcement.destroy
    redirect_to :action => :index
  end

end