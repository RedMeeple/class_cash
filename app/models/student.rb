class Student < ActiveRecord::Base
  has_secure_password
  belongs_to :period
  has_many :jobs, dependent: :destroy
  has_many :behaviors, dependent: :destroy

  accepts_nested_attributes_for :behaviors

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

  def good_behavior_yesterday(id)
    Behavior.where(date: Date.yesterday, student_id: id).first.well_behaved
  end
end
