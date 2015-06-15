class StudentsController < ApplicationController
  before_action :logged_in?, except: [:send_money, :sent_money]
  before_action :student_logged_in?, only: [:send_money, :sent_money]
  before_action :set_student, only: [:show, :edit, :update, :destroy]

  # GET /students
  # GET /students.json
  def index
    Student.richest?
    @students = Student.where(instructor_id: session[:user_id])
  end

  # GET /students/1
  # GET /students/1.json
  def show
    @received = Transaction.where(recipient_id: @student.id).all
    @sent = Transaction.where(sender_id: @student.id).all
  end

  # GET /students/new
  def new
    @student = Student.new
    @periods = Period.where(instructor_id: session[:user_id])
  end

  # GET /students/1/edit
  def edit
    @periods = Period.where(instructor_id: session[:user_id])
  end

  # POST /students
  # POST /students.json
  def create
    @student = Student.new(student_params)

    respond_to do |format|
      if @student.save
        format.html { redirect_to students_path, notice: 'Student was successfully created.' }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1
  # PATCH/PUT /students/1.json
  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to students_path, notice: 'Student was successfully updated.' }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    @student.destroy
    respond_to do |format|
      format.html { redirect_to students_url, notice: 'Student was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def send_money
    @student = Student.find_by_id(session[:user_id])
    @students = Student.where(period_id: @student.period_id).all
    @transaction = Transaction.new(sender_id: @student.id)
  end

  def sent_money
    @student = Student.find_by_id(session[:user_id])
    @transaction = Transaction.create(transaction_params)
    @student.update(cash: (@student.cash - @transaction.amount))
    @recipient = Student.find_by_id(@transaction.recipient_id)
    @recipient.update(cash: (@recipient.cash + @transaction.amount))
    redirect_to dashboard_student_path, notice: "$#{@transaction.amount} has been sent."
  end

  private def student_logged_in?
    unless Student.find_by_id(session[:user_id])
      redirect_to sessions_login_path, notice: 'User or Password does not match our records.'
    end
  end

  private def logged_in?
    unless Instructor.find_by_id(session[:user_id])
      redirect_to sessions_login_path, notice: 'User or Password does not match our records.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transaction_params
      params.require(:transaction).permit(:recipient_id, :sender_id, :amount)
    end

    def student_params
      params.require(:student).permit(:first_name, :last_name, :email, :cash,
          :period_id, :password, :richest, behaviors_attributes: [:id, :well_behaved, :date, :did_job])
    end
end
