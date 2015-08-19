class Right < ActiveRecord::Base
  belongs_to :instructor
  has_many :student_right_assignments, dependent: :destroy
  has_many :students, through: :student_right_assignments

  def available_students(id)
    self.students
  end
end
