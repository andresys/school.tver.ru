class Admin::MediaLinksController < AdminController

  def index
    @media_link = @school.media_link
  end

  def new
    @media_link = @school.media_link.new
  end

  def edit
    @media_link = MediaLink.find(params[:id])
  end

  def create
    @media_link = @school.media_link.new(params[:media_link])
    if @media_link.save
      redirect_to :action => :index
    else
      render 'new'
    end
  end

  def update
    @media_link = MediaLink.find(params[:id])
    if @media_link.update_attributes(params[:media_link])
       redirect_to :action => :index
      else
        render 'edit'
      end
    end

  def destroy
    @media_link = MediaLink.find(params[:id])
    @media_link.destroy
    redirect_to :action => :index
  end

end