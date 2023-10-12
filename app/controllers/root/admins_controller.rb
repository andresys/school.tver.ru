# coding: utf-8
class Root::AdminsController < SuperAdminController

  def index
    @admins = Admin.all
  end

  def new
    @admin = Admin.new
  end

  def edit
    @admin = Admin.find(params[:id])
  end

  def create
    @admin = Admin.new(params[:admin])
    if @admin.save
      redirect_to :action => :index
    else
      render 'new'
    end
  end 

  def update
    @admin = Admin.find(params[:id])
    if params[:admin][:password].blank?
      params[:admin].delete :password
    end
    if @admin.update_attributes(params[:admin])
      redirect_to :action => :index
    else
        render 'edit'
    end
  end

  def destroy
    @admin = Admin.find(params[:id])
    @admin.destroy
    redirect_to :action => :index
  end

 end
