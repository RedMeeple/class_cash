class DashboardController < ApplicationController
  before_action :instructor_logged_in?, only: [:instructor]
  before_action :student_logged_in?, only: [:student]
  before_action :nav_links_instructor, only: [:instructor]
  before_action :nav_links_student, only: [:student]


  def student
    @period = @student.period
    @bonuses = Bonus.where(period_id: @student.period_id).reorder(:created_at).last(5).reverse
    @extras = @student.extras.reorder(:created_at).last(5).reverse
    @sent = @student.transactions.reorder(:created_at).last(5).reverse
    @received = Transaction.where(recipient_id: @student.id).reorder(:created_at).last(5).reverse
    @awards = @student.awards
    @jobs = @student.jobs
    @daily_balances = @student.daily_balances.map { |db| [db.date, db.amount] }
    @student_rights = @student.student_right_assignments.where.not(right_id: nil)
    @new_rights = @student.student_right_assignments.where(right_id: nil)
    @periods = Period.where(instructor_id: @student.period.instructor_id)
    @transaction = Transaction.new(student_id: @student.id)
  end

  def instructor
    @new_rights = @instructor.unassigned_rights.count
    @transactions = @instructor.transactions.where("DATE(transactions.created_at) >= ?", Date.today).count
    @loans = @instructor.loans.where("DATE(loans.created_at) >= ?", Date.today).count
    @unentered_periods = @instructor.unentered_periods
    @bonuses = @instructor.extras.where("DATE(extras.created_at) >= ?", Date.today)
    @class_bonuses = @instructor.bonuses.where("DATE(bonuses.created_at) >= ?", Date.today)
    @awards = @instructor.awards.where("DATE(awards.created_at) >= ?", Date.today).count
  end

  private def nav_links_instructor
    @dashboard_instructor = true
  end

  private def nav_links_student
    @dashboard_student = true
  end

end
