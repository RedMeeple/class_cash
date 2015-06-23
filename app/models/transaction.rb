class Transaction < ActiveRecord::Base
  validates :amount, numericality: { greater_than: 0 }

  def finalize
    sender = Student.find_by_id(self.sender_id)
    sender.update(cash: (sender.cash - self.amount))
    recipient = Student.find_by_id(self.recipient_id)
    recipient.update(cash: (recipient.cash + self.amount))
  end
end
