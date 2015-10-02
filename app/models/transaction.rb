class Transaction < ActiveRecord::Base
  validates :amount, numericality: { greater_than: 0 }

  belongs_to :student

  def finalize
    sender = self.student
      if self.amount <= sender.cash
        sender.update!(cash: (sender.cash - self.amount))
        sender.check_rights
        if self.recipient_id
          recipient = Student.find_by_id(self.recipient_id)
          recipient.update!(cash: (recipient.cash + self.amount))
          recipient.check_rights
          Period.find_by_id(recipient.period.id).find_richest
        end
        Period.find_by_id(sender.period.id).find_richest
      end
      if self.reason == "Loan Payment" or self.reason == "Automatic Loan Payment"
        loan = Loan.where(student_id: self.recipient_id).find_by_recipient_id(self.student_id)
        loan.update!(balance: loan.balance - self.amount)
        loan.destroy if loan.balance <= 0
      else
        return true
      end
  end
end
