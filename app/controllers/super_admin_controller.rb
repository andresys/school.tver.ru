class SuperAdminController < ActionController::Base
  before_filter :authenticate_admin!
  protect_from_forgery
end