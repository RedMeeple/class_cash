class TransactionsController < ApplicationController
  before_action :instructor_logged_in?

  def index
    @transactions = @instructor.transactions.reorder(:created_at).reverse
    @transaction = Transaction.new
    @periods = @instructor.periods
  end

  def new
    @transaction = Transaction.new(transaction_params)
    @recipient = Student.find(@transaction.recipient_id)
    @periods = [@transaction.student.period, @recipient.period]
    respond_to do |format|
      if @transaction.finalize
        @transaction.save!
        @transaction.student.check_rights
        @recipient.check_rights
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
