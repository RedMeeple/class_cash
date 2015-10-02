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
  has_many :purchases, dependent: :destroy
  has_many :store_items, through: :purchases
  has_many :purchase_trackers, dependent: :destroy

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
    if Date.today.wday != 6 && Date.today.wday != 7
      Student.all.each do |student|
        student.save_balance
        student.check_rights
      end
    end
  end

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def richest?
    self.richest ? '#C8E6C9' : ''
  end

  def behaved?
    self.behaviors.last.well_behaved ? '<i class="fa fa-star-o fa-2x" style="color:GoldenRod"></i>' : ''
  end

  def make_password
    if "#{self.first_name}#{self.id}".length >= 8
      "#{self.first_name.downcase}#{self.id}"
    elsif "#{self.first_name}#{self.last_name}#{self.id}".length >= 8
      "#{self.first_name.downcase}#{self.last_name.downcase}#{self.id}"
    else
      "#{self.first_name.downcase}#{self.last_name.downcase}#{self.id}0000"
    end
  end

  def get_purchase_information
    information = []
    purchases = PurchaseTracker.where(student_id: self.id)
    total_spent = purchases.sum(:amount)
    purchases.each do |purchase|
      information << [purchase.item, purchase.amount, (100 * purchase.amount / total_spent)]
    end
    information
  end

  def make_instant_purchase(amount, item)
    if purchase = PurchaseTracker.where(student_id: self.id).find_by_item(item)
      purchase.update(amount: purchase.amount + amount)
    else
      PurchaseTracker.create(student_id: self.id, item: item, amount: amount)
    end
    self.update(cash: self.cash - amount)
  end








end
