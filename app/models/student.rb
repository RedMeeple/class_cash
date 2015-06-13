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
    Job.where(student_id: id).all
  end

  def completed_job_task
  end
end
