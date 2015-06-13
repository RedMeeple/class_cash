class Period < ActiveRecord::Base
  has_many :students, dependent: :destroy
  belongs_to :instructor
  accepts_nested_attributes_for :students

  def pay_students
    @students = Student.where(period_id: self.id).all
    @students.each do |student|
      if student.good_behavior
        student.update(cash: (student.cash + self.payscale))
      end
    end
  end
end
