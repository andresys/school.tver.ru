class Admin::MethodicDocumentsController < AdminController

  def index
    @doc = @school.methodic_document
  end

  def new
    @doc = MethodicDocument.new
    if params[:teacher_id]
      @doc.teacher_id = params[:teacher_id]
    end
  end

  def edit
    @doc = MethodicDocument.find(params[:id])
  end

  def create
    @doc = MethodicDocument.new(params[:methodic_document])
    if @doc.save
      redirect_to :action => :index
    else
      render 'new'
    end
  end

  def update
    @doc = MethodicDocument.find(params[:id])
    if @doc.update_attributes(params[:methodic_document])
       redirect_to :action => :index
      else
        render 'edit'
      end
    end

  def destroy
    @doc = MethodicDocument.find(params[:id])
    @doc.destroy
    redirect_to :action => :index
  end

end