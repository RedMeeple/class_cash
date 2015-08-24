class StudentsController < ApplicationController
  before_action :instructor_logged_in?, except: [:send_money, :sent_money, :behavior]
  before_action :student_logged_in?, only: [:send_money, :sent_money]
  before_action :set_student, only: [:show, :edit, :update, :destroy, :behavior]
  before_action :logged_in?, only: [:behavior]

  before_action :nav_links_instructor
  before_action :nav_links_student

  def index
    @instructor = Instructor.find_by_id(current_user.id)
    @periods =  @instructor.periods
    @students = @periods.joins(:students)
    @extra = Extra.new(instructor_id: @instructor.id)
    @bonus = Bonus.new
  end

  def show
    @received = Transaction.where(recipient_id: @student.id)
    @sent = @student.transactions
    @awards = @student.awards
    @bonuses = @student.extras
    @daily_balances = @student.daily_balances.map { |db| [db.date, db.amount] }
  end

  def new
    @student = Student.new
    @periods = Period.where(instructor_id: current_user.id)
  end

  def edit
    @periods = Period.where(instructor_id: current_user.id)
    respond_to do |format|
      format.js
    end
  end

  def create
    @student = Student.new(student_params)

    respond_to do |format|
      if @student.save
        @student.update(cash: 0, can_loan: false)
        format.html { redirect_to students_path, notice: 'Student was successfully created.' }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to students_path, notice: 'Student was successfully updated.' }
        format.json { render :show, status: :ok, location: @student }
      else
        @periods = Period.where(instructor_id: current_user.id)
        format.html { render :edit }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @period = @student.period
    @student.destroy
    respond_to do |format|
      format.html { redirect_to students_url }
      format.js
    end
  end

  def sent_money
    @student = Student.find_by_id(current_user.id)
    @transaction = Transaction.new(transaction_params)
    if @transaction.finalize
      @transaction.save!
      redirect_to dashboard_student_path, notice: "$#{@transaction.amount} sent."
    else
      redirect_to dashboard_student_path, notice: "Transaction failed."
    end

  end

  def gave_bonus
    @extra = Extra.new(extra_params)
    if @extra.save
      @student = Student.find_by_id(@extra.student_id)
      @student.update(cash: (@student.cash + @extra.amount))
      redirect_to students_path, notice: "$#{@extra.amount} sent to #{@student.first_name}."
    else
      render :give_bonus, notice: "Please try again."
    end
  end

  def behavior
    @all_days = @student.behaviors.map { |b| [b.date, b.well_behaved] }
    if current_user == @student
      @transaction = Transaction.new(student_id: @student.id)
      @periods = Period.where(instructor_id: @student.period.instructor_id)
    end
  end

  private def set_student
    @student = Student.find(params[:id])
  end

  private def transaction_params
    params.require(:transaction).permit(:recipient_id, :student_id, :amount, :reason)
  end

  private def extra_params
    params.require(:extra).permit(:instructor_id, :student_id, :amount, :reason)
  end

  private def student_params
    params.require(:student).permit(:first_name, :last_name, :email, :cash,
        :period_id, :password, :richest, :can_loan, :diabled,
        behaviors_attributes: [:id, :well_behaved, :date],
        jobs_attributes: [:id, :last_date_done, :description, :payscale])
  end


  # navigation links for the instructor's view relating to the students controller
  private def nav_links_instructor
    @students_instructor = true
  end

  # navigation links for the students's view relating to the students controller

  private def nav_links_student
    @students_student = true
  end

  private def logged_in?
    unless current_user.type == "Instructor" or current_user == @student
      redirect_to user_session_path, notice: 'Please login to view this page.'
    end
  end

end
