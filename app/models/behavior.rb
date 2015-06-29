class Behavior < ActiveRecord::Base
  belongs_to :student
  validates :date, uniqueness: { scope: :student_id, message: "Behavior data has already been entered today." }
end
