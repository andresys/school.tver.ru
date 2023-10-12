class MethodicDocumentsController < ApplicationController
  def index
    @methodics = @school.methodic
  end

  def show
    @doc = MethodicDocument.find(params[:id])
  end
end
