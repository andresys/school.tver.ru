class AdminController < ActionController::Base
  before_filter :authenticate_user!
  before_filter :check_permission
  protect_from_forgery

  def check_permission
    if params[:school_id]
      @school = School.find_by_permalink(params[:school_id])
      if @school.nil?
        @school = School.find(params[:school_id])
      end
      raise ActiveRecord::RecordNotFound, "Page not found" if @school.nil?
    else
      if params[:id]
        @school = School.find_by_permalink(params[:id])
        if @school.nil?
          @school = School.find(params[:id])
        raise ActiveRecord::RecordNotFound, "Page not found" if @school.nil?
      end
      end
    end

    if current_user.school != @school
      redirect_to admin_school_path(current_user.school.permalink)
    end
  end

end