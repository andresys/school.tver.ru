class SchoolController < ApplicationController
  layout 'school'
	def index
		# @schools = School.all
    @district = District.all
    @count_of_district = 0
	end

	def show
    if params[:permalink]
      @school = School.where(archive: false).find_by_permalink(params[:permalink])
      raise ActiveRecord::RecordNotFound, "Page not found" if @school.nil?
    else
      @school = School.find(params[:id])
    end
		@district = @school.district
	end

  def contact
    @school = School.find_by_permalink(params[:id])
  end

  def folders
    redirect_to school_document_path(@school, '')
  end

  def food
    @food = Food.get_by_menufilename(params[:menufilename])
    send_file @food.file.path, filename: @food.menufilename
  end

end
