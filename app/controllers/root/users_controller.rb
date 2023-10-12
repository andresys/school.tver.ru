class Root::UsersController < SuperAdminController

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
  end

  def create
    @school = School.find_by_permalink(params[:school_id])
    @user = @school.users.new(params[:user])
    @user.root = true
    if @user.save
      redirect_to :action => :index
    else
      render 'new'
    end
  end 

  def update
    @school = School.find_by_permalink(params[:school_id])
    @user = User.find(params[:id])
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
    @user.destroy
    redirect_to :action => :index
  end


 end
