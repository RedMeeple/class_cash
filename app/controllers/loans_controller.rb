class LoansController < ApplicationController
  before_action :set_loan, only: [:show, :update, :destroy, :confirmation, :pay]
  before_action :student_logged_in?, except: [:index, :destroy, :permissions]
  before_action :instructor_logged_in?, only: [:index, :destroy, :permissions]

  def confirmation
  end

  def pay
    @transaction = Transaction.new(recipient_id: @loan.student.id,
        student_id: Student.find_by_id(@loan.recipient_id).id, reason: "Loan Payment")
  end

  def permissions
    @period = Period.find_by_id(params[:id])
  end

  # GET /loans
  # GET /loans.json
  def index
    @instructor = Instructor.find_by_id(current_user.id)
    @loans = @instructor.loans
  end

  def all
    @student = Student.find_by_id(current_user.id)
    @loans_given = @student.loans
    @loans_received = Loan.where(recipient_id: @student.id)
  end

  # GET /loans/1
  # GET /loans/1.json
  def show
  end

  # GET /loans/new
  def new
    @loan = Loan.new
    @lender = Student.find_by_id(current_user.id)
    @periods = Period.where(instructor_id: @lender.period.instructor_id)
    unless @lender.can_loan
      redirect_to dashboard_student_path
    end
  end

  # POST /loans
  # POST /loans.json
  def create
    @loan = Loan.new(loan_params)

    respond_to do |format|
      if @loan.save
        format.html { redirect_to dashboard_student_path, notice: 'Loan was sent for confirmation.' }
        format.json { render :show, status: :created, location: @loan }
      else
        format.html { render :new }
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /loans/1
  # PATCH/PUT /loans/1.json
  def update
    respond_to do |format|
      if @loan.update(loan_params)
        @loan.finalize
        format.html { redirect_to @loan, notice: 'Loan was successfully updated.' }
        format.json { render :show, status: :ok, location: @loan }
      else
        format.html { render :edit }
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /loans/1
  # DELETE /loans/1.json
  def destroy
    @loan.destroy
    respond_to do |format|
      format.html { redirect_to loans_url, notice: 'Loan was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_loan
      @loan = Loan.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def loan_params
      params.require(:loan).permit(:student_id, :recipient_id, :amount, :interest, :end_date, :accepted)
    end

end
