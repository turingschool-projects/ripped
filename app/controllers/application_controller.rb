class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :student_notifications


  require 'cancancan'
  rescue_from CanCan::AccessDenied do |exception|
      respond_to do |format|
        format.json { head :forbidden, content_type: 'text/html' }
        format.html { redirect_to main_app.root_url, alert: exception.message }
      end
    end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
