class Admin::DocumentsController < AdminController

  def index
    @doc = @school.document
  end

  def new
    @folder = @school.folder.find(params[:folder_id])
    @doc = Document.new
  end

  def edit
    @folder = @school.folder.find(params[:folder_id])
    @doc = @school.folder.find(params[:folder_id]).document.find(params[:id])
  end

  def create
    @folder = @school.folder.find(params[:folder_id])
    @doc = @folder.document.new(params[:document])
    if @doc.save
      redirect_to admin_school_folder_path(@school,@folder)
    else
      render 'new'
    end
  end

  def update
    @folder = @school.folder.find(params[:folder_id])
    @doc = @folder.document.find(params[:id])
    if @doc.update_attributes(params[:document])
       redirect_to admin_school_folder_path(@school,@folder)
      else
        render 'edit'
      end
    end

  def destroy
    @folder = @school.folder.find(params[:folder_id])
    @doc = @folder.document.find(params[:id])
    @doc.destroy
    redirect_to admin_school_folder_path(@school,@folder)
  end

end