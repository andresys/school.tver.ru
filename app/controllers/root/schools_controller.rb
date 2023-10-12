# coding: utf-8
class Root::SchoolsController < SuperAdminController

  def index
    @schools = School.all.sort {|a, b| a.string_to_sort <=> b.string_to_sort}
  end

  def new
    @school = School.new
    @school.n_cordinate = 56.85
    @school.e_cordinate = 35.89
  end

  def edit
    @school = School.find_by_permalink(params[:id])
  end

  def create
    # @district = District.find(params[:district])
    @school = School.new(params[:school])
    if params[:school][:n_cordinate].blank?
      @school.n_cordinate = 56.85
      @school.e_cordinate = 35.89
    end

    if @school.save
      redirect_to :action => :index
    else
      render 'new'
    end
  end 

  def update
    @school = School.find_by_permalink(params[:id])
    temp = @school.permalink
    if @school.update_attributes(params[:school])
      redirect_to :action => :index
    else
       @school.permalink = temp
      render 'edit'
    end
  end

  def destroy
    @school = School.find_by_permalink(params[:id])
    @school.update_attribute(:archive, !@school.archive)
    redirect_to :action => :index
  end

end
