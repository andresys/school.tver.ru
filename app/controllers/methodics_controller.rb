class MethodicsController < ApplicationController
  def index
    @methodics = @school.methodic
  end

  def show
    if params[:id] != 'none'
      @methodic = Methodic.find(params[:id])
    else
      @doc = []
      @school.teacher.each do |teacher|
        if !teacher.methodic_document.blank? && teacher.teacher_methodic_link.blank?
          @doc = @doc + teacher.methodic_document
        end
      end
    end

  end

end
