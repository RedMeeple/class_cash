class Loan < ActiveRecord::Base
  belongs_to :student

  def finalize
    lender = self.student
    transaction do
      if self.accepted
        lender.update(cash: (lender.cash - self.amount))
        recipient = Student.find_by_id(self.recipient_id)
        recipient.update(cash: (recipient.cash + self.amount))
        Period.find_by_id(lender.period.id).find_richest
        Period.find_by_id(recipient.period.id).find_richest
        self.update(balance: self.amount)
      end
    end
  end

  def calculate_new_balance
    if (Date.today != self.created_at.to_date) && ((Date.today - self.created_at.to_date) % 7 == 0)
      self.update(balance: (self.balance + (self.balance * self.interest / 100)))
    end
  end

  def self.update_balances
    Loan.all.each do |loan|
      loan.calculate_new_balance
    end
  end

end
