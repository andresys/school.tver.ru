class Admin::SectionsController < AdminController

  def index
    @sections = @school.section
  end

  def new
    @section = @school.section.new
  end

  def edit
    @section = Section.find(params[:id])
  end

  def create
    if 'teacher_ids'.in?(params[:section])
      test = params[:section][:teacher_ids]
      params[:section].delete :teacher_ids
    end
    @section = @school.section.new(params[:section])
     if @section.save
      params[:section][:teacher_ids] = test
      if @section.update_attributes(params[:section])
        redirect_to :action => :index
      else
        render 'new'
      end
    else
      render 'new'
    end
  end

  def update
    @section = Section.find(params[:id])
    if !'teacher_ids'.in?(params[:section])
      params[:section][:teacher_ids] = []
    end
    if @section.update_attributes(params[:section])
      redirect_to :action => :index
    else
      render 'edit'
    end
  end

  def destroy
    @section = Section.find(params[:id])
    @section.destroy
    redirect_to :action => :index
  end

end