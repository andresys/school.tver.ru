class Admin::TeachersController < AdminController

  def index
    @teacher_groups = @school.teacher_group
  end

  def new
    @teacher = @school.teacher_group.first.teacher.new
  end

  def edit
    @teacher = Teacher.find(params[:id])
  end

  def create
    @teacher = @school.teacher.new(params[:teacher])
    if @teacher.save
      redirect_to :action => :index
    else
      render 'new'
    end
  end 

  def update
    @teacher = Teacher.find(params[:id])
    if @teacher.update_attributes(params[:teacher])
      redirect_to :action => :index
    else
      render 'edit'
    end
  end

  def destroy
    @teacher = Teacher.find(params[:id])
    @teacher.destroy
    redirect_to :action => :index
  end

end