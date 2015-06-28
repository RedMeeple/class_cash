class Loan < ActiveRecord::Base

  def finalize
    lender = Student.find_by_id(self.lender_id)
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
end
