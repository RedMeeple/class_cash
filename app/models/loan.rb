class Loan < ActiveRecord::Base
  belongs_to :student

  def finalize
    lender = self.student
    transaction do
      if self.accepted
        self.update(end_date: Date.today + self.weeks * 7)
        lender.update(cash: (lender.cash - self.amount))
        recipient = Student.find_by_id(self.recipient_id)
        recipient.update(cash: (recipient.cash + self.amount))
        Period.find_by_id(lender.period.id).find_richest
        Period.find_by_id(recipient.period.id).find_richest
        self.update(balance: self.amount)
      end
    end
  end

  def start_date
    self.end_date - self.weeks * 7
  end

  def final_total
    (self.amount * ((self.interest.to_f / 100) / ( 1 - (1 + (self.interest.to_f / 100)) ** (self.weeks * -1)) )) * self.weeks
  end

  def calculate_new_balance
    if (Date.today != self.start_date) && ((Date.today - self.start_date) % 7 == 0)
      self.update(balance: (self.balance + (self.balance * self.interest.to_f / 100)))
      make_payment
    end
  end

  def calculate_payment
    if self.balance and self.balance <= self.final_total / self.weeks
      self.balance
    elsif self.balance and self.end_date < Date.today + 7
      self.balance
    else
      self.final_total / self.weeks
    end
  end

  def make_payment
    t = Transaction.create(reason: "Automatic Loan Payment", recipient_id: self.student_id,
        student_id: self.recipient_id, amount: calculate_payment)
    t.finalize
  end

  def self.update_balances
    Loan.all.each do |loan|
      loan.calculate_new_balance
    end
  end

end
