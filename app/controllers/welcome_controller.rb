class WelcomeController < ApplicationController

  def home
    if session[:user_id]
      if session[:user_type] == "instructor"
        redirect_to dashboard_instructor_path
      elsif session[:user_type] == "student"
        redirect_to dashboard_student_path
      end
    end
  end
end
