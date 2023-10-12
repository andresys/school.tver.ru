class DocumentsController < ApplicationController
  def index
    @folder = @school.folder.find_all_by_parent_id(nil).first
  end

  def show
    @folder = @school.folder.find(params[:id])
  end
end
