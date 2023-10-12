class Admin::FindexController < AdminController
  def change
    @findex = @school.findex || Findex.new(params[:findex])
    @findex.school = @school
    if @findex.update_attributes(params[:findex])
      redirect_to :action => :edit
    else
      render 'edit'
    end
  end

  def edit
    @findex = @school.findex || Findex.new(params[:findex])
  end
end
