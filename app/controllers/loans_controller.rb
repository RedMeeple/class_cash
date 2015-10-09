class LoansController < ApplicationController
  before_action :set_loan, only: [:show, :update, :destroy, :confirmation, :pay]
  before_action :student_logged_in?, except: [:index, :destroy, :permissions]
  before_action :instructor_logged_in?, only: [:index, :destroy, :permissions]

  def pay
    @transaction = Transaction.new(recipient_id: @loan.student.id,
        student_id: Student.find_by_id(@loan.recipient_id).id, reason: "Loan Payment")
  end

  def permissions
    @period = Period.find_by_id(params[:id])
  end

  def index
    @loans = @instructor.loans.reorder(:created_at).reverse
  end

  def all
    @loan = Loan.new
    @periods = Period.where(instructor_id: @student.period.instructor_id)
    @loans_given = @student.loans
    @loans_received = Loan.where(recipient_id: @student.id)
    @transaction = Transaction.new(student_id: @student.id)
  end

  def create
    @loan = Loan.new(loan_params)

    respond_to do |format|
      if @loan.save
        @loan.update(end_date: Date.today + 7 * @loan.weeks)
        format.html { redirect_to all_loans_path, notice: 'Loan was sent for confirmation.' }
        format.json { render :show, status: :created, location: @loan }
      else
        format.html { render :new }
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @loan.update(loan_params)
        @loan.finalize
        format.html { redirect_to all_loans_path, notice: 'Loan was successfully updated.' }
        format.json { render :show, status: :ok, location: @loan }
      else
        format.html { render :edit }
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @loan.destroy
    respond_to do |format|
      format.html { redirect_to loans_url, notice: 'Loan was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end

  private def set_loan
    @loan = Loan.find(params[:id])
  end

  private def loan_params
    params.require(:loan).permit(:student_id, :recipient_id, :amount, :interest, :weeks, :end_date, :accepted)
  end

end
