class TransactionsController < ApplicationController
  before_action :instructor_logged_in?

  def index
    @transactions = Transaction.where(sender_id: Student.where(period_id: Period.where(instructor_id: session[:user_id]))).last(100)
  end

end
