class RightsController < ApplicationController
  before_action :set_right, only: [:show, :destroy]
  before_action :instructor_logged_in?

  def index
    @instructor = Instructor.find(current_user.id)
    @rights = @instructor.all_rights
    @new_rights = @instructor.unassigned_rights
    @right = Right.new
  end

  def show
    @students = @right.students
  end

  def create
    @right = Right.new(right_params)

    respond_to do |format|
      if @right.save
        format.js
      else
        format.html { render :new }
        format.json { render json: @right.errors, status: :unprocessable_entity }
      end
    end
  end

  def assign_right
    @student_right_assignment = StudentRightAssignment.find_by_student_id(params[:student_right_assignment][:student_id])
    @student_right_assignment.update(student_right_assignment_params)
    @right = @student_right_assignment.right
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @right.destroy
    respond_to do |format|
      format.html { redirect_to rights_url, notice: 'Right was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private def student_right_assignment_params
    params.require(:student_right_assignment).permit(:cash_level, :student_id, :right_id)
  end

  private def set_right
    @right = Right.find(params[:id])
  end

  private def right_params
    params.require(:right).permit(:description, :teacher_id)
  end
end
