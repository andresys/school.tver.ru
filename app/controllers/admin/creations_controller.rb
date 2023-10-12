class Admin::CreationsController < AdminController

  def index
    @news_models = @school.creation
  end

  def new
    @news_model = @school.creation.new
  end

  def edit
    @news_model = Creation.find(params[:id])
  end

  def create
    @news_model = @school.creation.new(params[:creation])
    if @news_model.save
      redirect_to :action => :index
    else
      render 'new'
    end
  end

  def update
    @news_model = Creation.find(params[:id])
    if @news_model.update_attributes(params[:creation])
       redirect_to :action => :index
      else
        render 'edit'
      end
    end

  def destroy
    @creation = Creation.find(params[:id])
    @creation.destroy
    redirect_to :action => :index
  end

end