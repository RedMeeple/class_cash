class JobsController < ApplicationController
  before_action :instructor_logged_in?
  before_action :set_job, only: [:show, :edit, :update, :destroy]
  before_action :set_students, only: [:new, :edit]

  def index
    @periods = Period.where(instructor_id: current_user.id)
    @students = @periods.joins(:students)
    @job = Job.new(student_id: params[:student_id])
  end

  def show
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def create
    @job = Job.new(job_params)

    if @job.save
      redirect_to jobs_path, notice: "#{@job.student.first_name} was hired."
    else
      render :new
    end

  end

  def update
    respond_to do |format|
      if @job.update(job_params)
        format.js
      else
        format.html { redirect_to jobs_url, notice: 'Job failed to be updated.' }
      end
    end
  end

  def destroy
    @job.destroy
    respond_to do |format|
      format.html { redirect_to jobs_url, notice: 'Job was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private def set_job
    @job = Job.find(params[:id])
  end

  private def set_students
    @periods = Period.where(instructor_id: current_user.id).all
    @students = []
    @periods.each do |period|
      @students += Student.where(period_id: period.id).all.to_a
    end
  end

  private def job_params
    params.require(:job).permit(:student_id, :description, :payscale)
  end
end
