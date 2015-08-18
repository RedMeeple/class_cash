class DashboardController < ApplicationController
  before_action :instructor_logged_in?, only: [:instructor]
  before_action :student_logged_in?, only: [:student]
  before_action :nav_links_instructor, only: [:instructor]
  before_action :nav_links_student, only: [:student]


  def student
    @student = Student.find_by_id(current_user.id)
    @period = @student.period
    @bonuses = Bonus.where(period_id: @student.period_id).last(5).reverse
    @extras = @student.extras.last(5).reverse
    @sent = @student.transactions.last(5).reverse
    @received = Transaction.where(recipient_id: @student.id).last(5).reverse
    @awards = @student.awards
    @daily_balances = @student.daily_balances.map { |db| [db.date, db.amount] }
    @student_rights = @student.student_right_assignments.where(right_id: !nil)
    @new_rights = @student.student_right_assignments.where(right_id: nil)
  end

  def instructor
    @instructor = Instructor.find_by_id(current_user.id)
    @new_rights = @instructor.unassigned_rights.count
    @transactions = @instructor.transactions.where("DATE(transactions.created_at) >= ?", Date.today).count
    @loans = @instructor.loans.where("DATE(loans.created_at) >= ?", Date.today).count
    @unentered_periods = @instructor.unentered_periods
    @bonuses = Extra.where("DATE(extras.created_at) >= ?", Date.today)
    @class_bonuses = Bonus.where("DATE(bonuses.created_at) >= ?", Date.today)
  end

  private def nav_links_instructor
    @dashboard_instructor = true
  end

  private def nav_links_student
    @dashboard_student = true
  end

end
