class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!, except: [:instructor_logged_in?, :student_logged_in?]

  private def instructor_logged_in?
    unless current_user.type == "instructor"
      redirect_to user_session_path, notice: 'Please login to view this page.'
    end
  end

  private def student_logged_in?
    unless current_user.type == "student"
      redirect_to user_session_path, notice: 'Please login to view this page.'
    end
  end
end
