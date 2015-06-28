class Extra < ActiveRecord::Base
  validates :amount, presence: true
  validates :student_id, presence: true
  validates :instructor_id, presence: true
end
