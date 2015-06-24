class AwardsController < ApplicationController
  before_action :set_award, only: [:show, :edit, :update, :destroy]
  before_action :logged_in?

  # GET /awards
  # GET /awards.json
  def index
    @awards = AwardType.all
  end

  # GET /awards/new
  def new
    @award = Award.new
    @awards = AwardType.all
    @periods = Period.where(instructor_id: session[:user_id])
  end

  # POST /awards
  # POST /awards.json
  def create
    @award = Award.new(award_params)

    if @award.save
      @award.assign
      redirect_to new_award_path, notice: 'Award was successfully created.'
    else
      render :new
    end
  end

  # DELETE /awards/1
  # DELETE /awards/1.json
  def destroy
    @award.destroy
    respond_to do |format|
      format.html { redirect_to awards_url, notice: 'Award was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private def logged_in?
    unless Instructor.find_by_id(session[:user_id]) && session[:user_type] == "instructor"
      redirect_to sessions_login_path, notice: 'User or Password does not match our records.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_award
      @award = Award.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def award_params
      params.require(:award).permit(:student_id, :award_type_id, :reason, :payment)
    end
end
