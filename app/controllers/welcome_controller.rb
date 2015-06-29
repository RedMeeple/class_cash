class WelcomeController < ApplicationController

  def home
    if current_user
      if current_user.type == "instructor"
        redirect_to dashboard_instructor_path
      elsif current_user.type == "student"
        redirect_to dashboard_student_path
      end
    end
  end
end
