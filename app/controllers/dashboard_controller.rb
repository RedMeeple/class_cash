class DashboardController < ApplicationController
  before_action :instructor_logged_in?, only: [:instructor]
  before_action :student_logged_in?, only: [:student]
  before_action :nav_links_instructor, only: [:instructor]
  before_action :nav_links_student, only: [:student]


  def student
    @student = Student.find_by_id(current_user.id)
    @period = Period.find_by_id(@student.period_id)
    @bonuses = Bonus.where(period_id: @student.period_id).last(5).reverse
    @extras = Extra.where(student_id: @student.id).last(5).reverse
    @sent = Transaction.where(sender_id: @student.id).last(5).reverse
    @received = Transaction.where(recipient_id: @student.id).last(5).reverse
    @awards = Award.where(student_id: @student.id)
  end

  def instructor
    @instructor = Instructor.find_by_id(current_user.id)
  end

  private def nav_links_instructor
    @dashboard_instructor = true
  end

  private def nav_links_student
    @dashboard_student = true
  end

end
