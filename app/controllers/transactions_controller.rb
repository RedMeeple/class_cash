class TransactionsController < ApplicationController
  before_action :instructor_logged_in?

  def index
    @instructor = Instructor.find(current_user.id)
    @transactions = @instructor.transactions
  end

end
