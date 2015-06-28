class TransactionsController < ApplicationController
  before_action :logged_in?

  def index
    @transactions = Transaction.where(sender_id: Student.where(period_id: Period.where(instructor_id: session[:user_id]))).last(100)
  end

  private def logged_in?
    unless Instructor.find_by_id(session[:user_id]) && session[:user_type] == "instructor"
      redirect_to sessions_login_path, notice: 'Please log in to view this content.'
    end
  end
end
