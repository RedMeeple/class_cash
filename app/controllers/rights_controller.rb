class RightsController < ApplicationController
  before_action :set_right, only: [:show, :destroy, :fire]
  before_action :instructor_logged_in?

  def index
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
        format.html { redirect_to rights_path }
      else
        format.html { render :new }
        format.json { render json: @right.errors, status: :unprocessable_entity }
      end
    end
  end

  def assign_right
    @student_right_assignment = StudentRightAssignment.find(params[:assignment_id])
    @student_right_assignment.update(right_id: params[:right_id])
    @right = @student_right_assignment.right
    render layout: false
  end

  def fire
    StudentRightAssignment.where(student_id: params[:student_id]).find_by_right_id(@right.id).update(right_id: nil)
    @new_rights = @instructor.unassigned_rights
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @right.destroy if @right.instructor && @right.instructor == @instructor
    respond_to do |format|
      format.html { redirect_to rights_url, notice: 'Right was successfully removed.' }
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
    params.require(:right).permit(:description, :instructor_id)
  end
end
