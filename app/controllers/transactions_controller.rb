class TransactionsController < ApplicationController
  before_action :instructor_logged_in?

  def index
    @instructor = Instructor.find(current_user.id)
    @transactions = @instructor.transactions.reorder(:created_at).reverse
    @transaction = Transaction.new
    @periods = @instructor.periods
  end

  def new
    @transaction = Transaction.new(transaction_params)
    @periods = [@transaction.student.period, Student.find(@transaction.recipient_id).period]
    respond_to do |format|
      if @transaction.finalize
        @transaction.save!
        @transaction = Transaction.new
        format.html { redirect_to transactions_path, notice: "$#{@transaction.amount} sent." }
        format.js
      else
        format.html { redirect_to transactions_path, notice: "Transaction failed." }
        format.js
      end
    end
  end

  private def transaction_params
    params.require(:transaction).permit(:recipient_id, :student_id, :amount, :reason)
  end

end
