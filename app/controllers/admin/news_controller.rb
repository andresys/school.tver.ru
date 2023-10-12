class Admin::NewsController < AdminController

  def index
    @news_models = @school.news
  end

  def new
    @teacher_groups = @school.teacher_group
    @news_model = @school.news.new
  end

  def edit
    @news_model = News.find(params[:id])
  end
 
  def create
    @news_model = @school.news.new(params[:news])
    if @news_model.save
      redirect_to :action => :index
    else
      render 'new'
      end
  end 
 
  def update
    @news_model = News.find(params[:id])
    if @news_model.update_attributes(params[:news])
      if !'teacher_ids'.in?(params[:news])
        @news_model.news_link.find_all_by_link_type('Teacher').each { |link| link.destroy }
      end
      if !'section_ids'.in?(params[:news])
        @news_model.news_link.find_all_by_link_type('Section').each { |link| link.destroy }
      end
        redirect_to :action => :index
    else
      render 'edit'
    end
  end

  def destroy
    @news = News.find(params[:id])
    @news.destroy
    redirect_to :action => :index
  end
  
end