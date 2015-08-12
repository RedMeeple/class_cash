class Transaction < ActiveRecord::Base
  validates :amount, numericality: { greater_than: 0 }
  validates :recipient_id, presence: true

  belongs_to :student
  
  def finalize
    sender = self.student
    transaction do
      if self.amount <= sender.cash
        sender.update(cash: (sender.cash - self.amount))
        recipient = Student.find_by_id(self.recipient_id)
        recipient.update(cash: (recipient.cash + self.amount))
        Period.find_by_id(sender.period.id).find_richest
        Period.find_by_id(recipient.period.id).find_richest
      end
      if self.reason == "Loan Payment"
        loan = Loan.where(student_id: self.recipient_id).find_by_recipient_id(self.student_id)
        loan.update(balance: loan.balance - self.amount)
        loan.destroy if loan.balance <= 0
      end
    end
  end
end
