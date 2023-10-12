# coding: utf-8
class Admin::SchoolController < AdminController

  def index
    @schools = School.all
  end

  def new
  end

  def edit
  end

  def create
    @district = District.find(params[:district])
  	@school = @district.school.new(params[:school])
    if @school.save
      redirect_to :action => :show, :id => @school.permalink
    else
      render 'new'
    end
  end 

  def update
    # @school = School.find(params[:id])
    if @school.update_attributes(params[:school])
      redirect_to :action => :show, :id => @school.permalink
    else
      if 'document_attributes'.in?params[:school]
        render 'documents'
      else
        render 'edit'
      end
    end
  end

  def show
    @folder = @school.folder.find_all_by_parent_id(nil).first
  end

  def contact
  end

  def documents
  end

  def sponsors
  end

end
