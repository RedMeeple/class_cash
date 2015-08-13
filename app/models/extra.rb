class Extra < ActiveRecord::Base
  belongs_to :student

  validates :amount, presence: true
  validates :student_id, presence: true
  validates :instructor_id, presence: true
end
