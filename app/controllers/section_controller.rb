class SectionController < ApplicationController
  def show
    @section = @school.section.find(params[:id])
  end

  def index
    @sections = @school.section
  end
end