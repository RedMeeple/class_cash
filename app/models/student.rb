class Student < ActiveRecord::Base
  has_secure_password
  belongs_to :period
  has_many :jobs, dependent: :destroy
  has_many :behaviors, dependent: :destroy
  has_many :awards

  accepts_nested_attributes_for :behaviors
  accepts_nested_attributes_for :jobs

  default_scope { order('last_name') }

  def completed_job_task
  end

  def good_behavior_yesterday(id)
    if a = Behavior.where(date: Date.yesterday, student_id: id).first
      a.well_behaved
    end
  end

  def good_behavior_today(id)
    if a = Behavior.where(date: Date.today, student_id: id).first
      a.well_behaved
    end
  end

  def save_balance
    DailyBalance.create(student_id: self.id, date: Date.today, amount: self.cash)
  end

  def self.save_all_balances
    Student.all.each do |student|
      student.save_balance
    end
  end

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

end
