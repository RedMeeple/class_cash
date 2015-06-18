class PeriodsController < ApplicationController
  before_action :logged_in?
  before_action :set_period, only: [:show, :edit, :update, :destroy]


  private def logged_in?
    unless Instructor.find_by_id(session[:user_id])
      redirect_to sessions_login_path, notice: 'User or Password does not match our records.'
    end
  end

  def enter_behavior
    @period = Period.where(instructor_id: session[:user_id]).last
    @students = @period.students
    @students.each {|s| s.behaviors.build }
  end

  def update_behavior
    
  end

  def class_bonus
    @bonus = Bonus.new(bonus_params)

    if @bonus.save
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

  # GET /periods
  # GET /periods.json
  def index
    @periods = Period.where(instructor_id: session[:user_id]).all
    @bonus = Bonus.new
  end

  # GET /periods/1
  # GET /periods/1.json
  def show
    @students = @period.students
  end

  # GET /periods/new
  def new
    @period = Period.new
    @instructor = Instructor.find_by_id(session[:user_id])
    20.times { @period.students.build }
  end

  # GET /periods/1/edit
  def edit
    @instructor = Instructor.find_by_id(session[:user_id])
  end

  # POST /periods
  # POST /periods.json
  def create
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

  # PATCH/PUT /periods/1
  # PATCH/PUT /periods/1.json
  def update
    respond_to do |format|
      if @period.update(period_params)
        format.html { redirect_to root_path, notice: 'Period was successfully updated.' }
        format.json { render :show, status: :ok, location: @period }
      else
        format.html { render :edit }
        format.json { render json: @period.errors, status: :unprocessable_entity }
      end
    end

  end

  # DELETE /periods/1
  # DELETE /periods/1.json
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
      params.require(:bonus).permit(:period_id, :amount)
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def period_params
      params.require(:period).permit(:instructor_id, :payscale, :name, students_attributes: [:id, :first_name,
          :last_name, :password, :email, behaviors_attributes: [:id, :well_behaved, :date, :did_job]])
    end
end
