class Transaction < ActiveRecord::Base
  validates :amount, numericality: { greater_than: 0 }
  validates :recipient_id, presence: true

  def finalize
    sender = Student.find_by_id(self.sender_id)
    transaction do
      if self.amount <= sender.cash
        sender.update(cash: (sender.cash - self.amount))
        recipient = Student.find_by_id(self.recipient_id)
        recipient.update(cash: (recipient.cash + self.amount))
        Period.find_by_id(sender.period.id).find_richest
        Period.find_by_id(recipient.period.id).find_richest
      end
    end
  end
end
