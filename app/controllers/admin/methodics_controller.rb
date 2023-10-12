class Admin::MethodicsController < AdminController

  def index
    @methodic = @school.methodic
  end

  def new
    @methodic = @school.methodic.new
  end

  def edit
    @methodic = Methodic.find(params[:id])
  end

  def create
    @methodic = @school.methodic.new(params[:methodic])
    if @methodic.save
      redirect_to :action => :index
    else
      render 'new'
    end
  end

  def update
    @methodic = Methodic.find(params[:id])
    if !'teacher_ids'.in?(params[:methodic])
      params[:methodic][:teacher_ids] = []
    end
    if @methodic.update_attributes(params[:methodic])
       redirect_to :action => :index
      else
        render 'edit'
      end
    end

  def destroy
    @methodic = Methodic.find(params[:id])
    Rails.logger.debug(params)
    @methodic.destroy
    redirect_to :action => :index
  end

end