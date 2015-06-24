class Award < ActiveRecord::Base
  belongs_to :award_type
  belongs_to :student

  def assign
    self.student.update(cash: (student.cash + self.payment))
  end
end
