# coding: utf-8
class Admin::AnnounceToParentsController < AdminController

  def index
    @news_models = @school.announce_to_parent
  end

  def new
    @news_model = @school.announce_to_parent.new
  end

  def edit
    @news_model = AnnounceToParent.find(params[:id])
  end

  def create
    @news_model = @school.announce_to_parent.new(params[:announce_to_parent])
    if @news_model.save
      redirect_to :action => :index
    else
      render 'new'
    end
  end

  def update
    @news_model = AnnounceToParent.find(params[:id])
    if @news_model.update_attributes(params[:announce_to_parent])
       redirect_to :action => :index
      else
        render 'edit'
      end
  end

  def destroy
    @announce_to_parent = AnnounceToParent.find(params[:id])
    @announce_to_parent.destroy
    redirect_to :action => :index
  end

end