# coding: utf-8
class Admin::UsersController < AdminController
  before_filter :check_root

  def check_root
    if !current_user.root
      if action_name != 'edit' || params[:id].blank?
        redirect_to admin_school_path(current_user.school.permalink)
        return
      end
      Rails.logger.debug(current_user.id)
      Rails.logger.debug(params[:id])
      if current_user.id != params[:id].to_i
        redirect_to admin_school_path(current_user.school.permalink)
      end
    end
  end

  def index
    @school = School.find_by_permalink(params[:school_id])
  end

  def new
    @school = School.find_by_permalink(params[:school_id])
    @user = User.new
  end

  def edit
    @school = School.find_by_permalink(params[:school_id])
    @user = User.find(params[:id])
    if @user.root && current_user.id != @user.id
      redirect_to :action => :show, :id => @user.id
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @school = School.find_by_permalink(params[:school_id])
    @user = @school.users.new(params[:user])
    if @user.root
      render :inline => "Permission denied"
      return
    end
    if @user.save
      redirect_to :action => :index
    else
      render 'new'
    end
  end 

  def update
    @user = User.find(params[:id])
    if current_user.id != params[:id].to_i
      if @user.root || params[:user][:root]
        render :inline => "Permission denied"
        return
      end
    end
    if params[:user][:password].blank?
      params[:user].delete :password
    end
    if @user.update_attributes(params[:user])
      redirect_to :action => :index
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.root
      render :inline => "Permission denied"
      return
    end
    @user.destroy
    redirect_to :action => :index
  end

 end
