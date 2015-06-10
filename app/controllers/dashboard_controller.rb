class DashboardController < ApplicationController
  before_action :instructor_logged_in?, only: [:instructor]
  before_action :student_logged_in?, only: [:student]


  private def instructor_logged_in?
    unless Instructor.find_by_id(session[:user_id])
      redirect_to sessions_login_path, notice: 'User or Password does not match our records.'
    end
  end

  private def student_logged_in?
    unless Student.find_by_id(session[:user_id])
      redirect_to sessions_login_path, notice: 'User or Password does not match our records.'
    end
  end

  def student
    @student = Student.find_by_id(session[:user_id])
  end

  def instructor
    @instructor = Instructor.find_by_id(session[:user_id])
  end
end
