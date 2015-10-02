class TransactionsController < ApplicationController
  before_action :instructor_logged_in?

  def index
    @transactions = @instructor.transactions.reorder(:created_at).reverse
    @transaction = Transaction.new
    @periods = @instructor.periods
  end

  def new
    @transaction = Transaction.new(transaction_params)
    if @transaction.recipient_id
      @recipient = Student.find(@transaction.recipient_id)
      @periods = [@transaction.student.period, @recipient.period]
    else
      @periods = [@transaction.student.period]
    end

    respond_to do |format|
      if @transaction.finalize
        @transaction.save!
        format.js
      else
        format.js
      end
    end
  end

  private def transaction_params
    params.require(:transaction).permit(:recipient_id, :student_id, :amount, :reason)
  end

end
