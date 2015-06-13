class Student < ActiveRecord::Base
  has_secure_password
  belongs_to :period
  has_many :jobs

  def self.richest?
    Student.update_all richest: false
    rich = Student.order(:cash).last
    rich.update(richest: true)
  end

  def jobs(id)
    jobs = Job.where(student_id: id).all
    jobs = jobs.map {|job| job.description}
  end

  def completed_job_task
    self.cash += 20
  end
end
