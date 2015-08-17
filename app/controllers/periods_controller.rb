class PeriodsController < ApplicationController
  before_action :instructor_logged_in?
  before_action :set_period, only: [:show, :edit, :update, :destroy, :enter_behavior, :update_behavior]

  def enter_behavior
    @students = @period.students
  end

  def update_behavior
    if @period.update(period_params)
      @period.pay_students
      redirect_to periods_path, notice: 'Today\'s behavior has been updated.'
    else
      @students = @period.students
      render :enter_behavior
    end
  end

  def class_bonus
    @bonus = Bonus.new(bonus_params)

    if @bonus.save && @bonus.period.students.count > 0
      @period = Period.find(@bonus.period.id)
      individual = @bonus.amount.to_i / @period.students.count
      @period.students.each do |student|
        student.update(cash: (student.cash + individual))
      end
      redirect_to periods_path, notice: "$#{@bonus.amount} has been distributed."
    else
      redirect_to periods_path, notice: "This bonus did not go through."
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
    @period.students.build
  end

  def create
    @instructor = Instructor.find_by_id(current_user.id)
    @period = Period.new(period_params)

    respond_to do |format|
      if @period.save
        format.html { redirect_to @period, notice: 'Period was successfully created.' }
        format.json { render :show, status: :created, location: @period }
      else
        format.html { render :new }
        format.json { render json: @period.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @period.update(period_params)
    @instructor = @period.instructor
    @period.students.build
    respond_to do |format|
      format.html { redirect_to periods_path, notice: 'Loaning Permissions Updated.' }
      format.js
    end

  end

  def destroy
    @period.destroy
    respond_to do |format|
      format.html { redirect_to periods_url, notice: 'Period was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_period
      @period = Period.find(params[:id])
    end

    def bonus_params
      params.require(:bonus).permit(:period_id, :amount, :reason)
    end

    def behavior_params
      params.require(:behavior).permit(:student_id, :well_behaved, :did_job)
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def period_params
      params.require(:period).permit(:instructor_id, :payscale, :name,
          students_attributes: [:id, :first_name, :last_name, :password, :email, :can_loan, :cash,
          behaviors_attributes: [:id, :well_behaved, :date, :student_id],
          jobs_attributes: [:id, :last_date_done]])
    end
end
