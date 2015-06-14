class Period < ActiveRecord::Base
  has_many :students, dependent: :destroy
  belongs_to :instructor
  accepts_nested_attributes_for :students

  def pay_students
    @students = Student.where(period_id: self.id).all
    @students.each do |student|
      a = Behavior.where(date: Date.today, student_id: student.id).first
      if a && a.well_behaved
        student.update(cash: (student.cash + self.payscale))
      end
    end
  end
end
