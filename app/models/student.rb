class Student < ActiveRecord::Base
  has_secure_password
  belongs_to :period
  has_many :jobs, dependent: :destroy
  has_many :behaviors, dependent: :destroy

  accepts_nested_attributes_for :behaviors

  default_scope { order('last_name') }

  def self.richest?
    Student.update_all richest: false
    Period.all.each do |p|
      rich = Student.where(period_id: p.id).order(:cash).last
      rich.update(richest: true) if rich
    end
  end

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
