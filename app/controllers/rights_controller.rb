class RightsController < ApplicationController
  before_action :set_right, only: [:show, :edit, :update, :destroy]
  before_action :instructor_logged_in?

  def index
    @instructor = Instructor.find(current_user.id)
    @rights = @instructor.all_rights
  end

  def show
    @students = @right.students
  end

  def new
    @instructor = Instructor.find(current_user.id)
    @right = Right.new
  end

  def create
    @right = Right.new(right_params)

    respond_to do |format|
      if @right.save
        format.html { redirect_to @right, notice: 'Right was successfully created.' }
        format.json { render :show, status: :created, location: @right }
      else
        format.html { render :new }
        format.json { render json: @right.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @right.update(right_params)
        format.html { redirect_to @right, notice: 'Right was successfully updated.' }
        format.json { render :show, status: :ok, location: @right }
      else
        format.html { render :edit }
        format.json { render json: @right.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rights/1
  # DELETE /rights/1.json
  def destroy
    @right.destroy
    respond_to do |format|
      format.html { redirect_to rights_url, notice: 'Right was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_right
      @right = Right.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def right_params
      params.require(:right).permit(:description, :teacher_id)
    end
end
