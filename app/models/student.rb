class Student < User
  belongs_to :period
  has_many :jobs, dependent: :destroy
  has_many :behaviors, dependent: :destroy
  has_many :awards, dependent: :destroy
  has_many :loans, dependent: :destroy
  has_many :transactions, dependent: :destroy
  has_many :extras, dependent: :destroy
  has_many :daily_balances, dependent: :destroy
  has_many :student_right_assignments, dependent: :destroy
  has_many :rights, through: :student_right_assignments

  accepts_nested_attributes_for :behaviors
  accepts_nested_attributes_for :jobs

  default_scope { order('last_name') }

  def save_balance
    DailyBalance.create(student_id: self.id, date: Date.today, amount: self.cash)
  end

  def check_rights
    levels = [1000, 10000, 25000]
    levels.each do |level|
      assignment = self.student_right_assignments.find_by_cash_level(level)
      if self.cash > level && !assignment
        StudentRightAssignment.create(student_id: self.id, cash_level: level)
      elsif self.cash < level && assignment
        assignment.delete
      end
    end
  end

  def self.save_all_balances
    Student.all.each do |student|
      student.save_balance
      student.check_rights
    end
  end

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def richest?
    self.richest ? '<i class="fa fa-money fa-2x"></i>' : ''
  end

  def behaved?
    self.behaviors.last.well_behaved ? '<i class="fa fa-star-o fa-2x"></i>' : ''

  end

end
