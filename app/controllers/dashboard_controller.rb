class DashboardController < ApplicationController
  before_action :instructor_logged_in?, only: [:instructor]
  before_action :student_logged_in?, only: [:student]
  before_action :set_up_menu_instructor, only: [:instructor]
  before_action :set_up_menu_student, only: [:student]

  def student
    @student = Student.find_by_id(session[:user_id])
    @period = Period.find_by_id(@student.period_id)
  end

  def instructor
    @instructor = Instructor.find_by_id(session[:user_id])
  end


  private def instructor_logged_in?
    unless Instructor.find_by_id(session[:user_id]) && (session[:user_type] == "instructor")
      redirect_to sessions_login_path, notice: 'User or Password does not match our records.'
    end
  end
  
  private def set_up_menu_instructor
    @dashboard_instructor = true
  end
  
  private def set_up_menu_student
    @dashboard_student = true  
  end
    
  
  private def student_logged_in?
    unless Student.find_by_id(session[:user_id]) && (session[:user_type] == "student")
      redirect_to sessions_login_path, notice: 'User or Password does not match our records.'
    end
  end
end
