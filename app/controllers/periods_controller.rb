class PeriodsController < ApplicationController
  before_action :instructor_logged_in?
  before_action :set_period, only: [:show, :edit, :update, :destroy, :enter_behavior, :update_behavior, :disable_accounts]

  def enter_behavior
    @students = @period.students
  end

  def update_behavior
    if @period.update(period_params)
      @period.pay_students
      redirect_to root_path, notice: 'Today\'s behavior has been updated.'
    else
      @students = @period.students
      render :enter_behavior
    end
  end

  def class_bonus
    @bonus = Bonus.new(bonus_params)

    respond_to do |format|
      if @bonus.save && @bonus.period.students.count > 0
        @period = Period.find(@bonus.period_id)
        individual = @bonus.amount.to_i / @period.students.count
        @period.students.each do |student|
          student.update(cash: (student.cash + individual))
        end
        format.js
      else
        redirect_to students_path, notice: "This bonus did not go through."
      end
    end
  end

  def index
    @periods = Period.where(instructor_id: current_user.id)
    @bonus = Bonus.new
  end

  def show
    @students = @period.students
    @bonuses = Bonus.where(period_id: @period.id)
  end

  def new
    @period = Period.new
    @instructor = Instructor.find_by_id(current_user.id)
    30.times { @period.students.build }
  end

  def edit
    @instructor = Instructor.find_by_id(current_user.id)
    up_to = 30 - @period.students.count
    up_to.times { @period.students.build }
  end

  def create
    @instructor = Instructor.find_by_id(current_user.id)
    @period = Period.new(period_params)

    respond_to do |format|
      if @period.save
        @period.students.update_all(cash: 0, can_loan: false)
        format.html { redirect_to students_path, notice: 'Period was successfully created.' }
        format.json { render :show, status: :created, location: @period }
      else
        @instructor = Instructor.find_by_id(current_user.id)
        30.times { @period.students.build }
        format.html { render :new }
        format.json { render json: @period.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @period.update!(period_params)
        if request.xhr?
          @period.students.build
          @period.students.update_all(cash: 0, can_loan: false)
        end
        @instructor = @period.instructor
        format.html { redirect_to students_path, notice: 'Period has been updated.' }
        format.js
      else
        format.html { redirect_to students_path, notice: @periods.errors }
      end
    end

  end

  def disable_accounts

  end

  def destroy
    @period.destroy
    respond_to do |format|
      format.html { redirect_to students_url, notice: 'Period was removed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_period
      @period = Period.find(params[:id])
    end

    def bonus_params
      params.require(:bonus).permit(:period_id, :amount, :reason)
    end

    def behavior_params
      params.require(:behavior).permit(:student_id, :well_behaved, :did_job)
    end

    def period_params
      params.require(:period).permit(:instructor_id, :payscale, :name,
          students_attributes: [:id, :first_name, :last_name, :password, :disabled, :email, :can_loan, :cash,
          behaviors_attributes: [:id, :well_behaved, :date, :student_id],
          jobs_attributes: [:id, :last_date_done]])
    end
end
