class Admin::FoldersController < AdminController

  def index
    redirect_to admin_school_folder_path(@school, @school.folder.find_all_by_parent_id(nil).first)
    #@folder = @school.folder.find_all_by_parent_id(0).first
  end

  def new
    @folder = Folder.new
    @folder.parent_id = params[:parent].to_i
  end

  def edit
    @folder = @school.folder.find(params[:id])
  end

  def show
    @folder = @school.folder.find(params[:id])
  end

  def create
    @folder = @school.folder.new(params[:folder])
    if @folder.save
      redirect_to admin_school_folder_path(@school,@folder.parent)
    else
      redirect_to :action => :new, :parent => params[:folder][:parent_id]
    end
  end

  def update
    @folder = @school.folder.find(params[:id])
    if @folder.parent_id.nil?
      redirect_to admin_school_folder_path(@school,@folder)
      return
    end
    if @folder.update_attributes(params[:folder])
       redirect_to admin_school_folder_path(@school,@folder)
      else
        render 'edit'
      end
    end

  def destroy
    @folder = @school.folder.find(params[:id])
    if !@folder.parent_id.nil?
      @folder.destroy
    end
    redirect_to admin_school_folder_path(@school, @school.folder.find_all_by_parent_id(nil).first)
  end

end