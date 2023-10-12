class ApplicationController < ActionController::Base
  before_filter :find_school
  protect_from_forgery
  helper_method :finevision?
  helper_method :finevision_class

  def find_school
    if params[:school_id]
      @school = School.find_by_permalink(params[:school_id])
      raise ActiveRecord::RecordNotFound, "Page not found" if @school.nil?
    else
      if params[:permalink]
        @school = School.find_by_permalink(params[:permalink])
        raise ActiveRecord::RecordNotFound, "Page not found" if @school.nil?
      end
    end
  end

  def finevision?
    !cookies[:finevision].nil?
  end

  def finevision_class
    ret = []
    ret << "finevisioncontent-on" if finevision?
    ret << "finevisioncontent-size#{cookies[:finevision_size]}" unless cookies[:finevision_size].nil?
    ret << "finevisioncontent-color#{cookies[:finevision_color]}" unless cookies[:finevision_color].nil?
    ret << "finevisioncontent-image#{cookies[:finevision_image]}" unless cookies[:finevision_image].nil?
    ret.compact.join(' ')
  end

  protected

  def ckeditor_filebrowser_scope(options = {})
    if 'global_page_body'.in?request.url
      super({ :school_id => 0}.merge(options))
    else
      super({ :school_id => current_user.school.id }.merge(options))
    end
  end
end