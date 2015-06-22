class Period < ActiveRecord::Base
  has_many :students, dependent: :destroy
  has_many :behaviors, through: :student
  has_many :bonuses, dependent: :destroy
  belongs_to :instructor
  accepts_nested_attributes_for :students, reject_if: :all_blank

  def pay_students
    @students = Student.where(period_id: self.id).all
    @students.each do |student|
      a = Behavior.where(date: Date.today, student_id: student.id).first
      if a && a.well_behaved
        student.update(cash: (student.cash + self.payscale))
      end
      if a && a.did_job
        pay = Job.where(student_id: student.id).all.sum(:payscale)
        student.update(cash: (student.cash + pay))
      end
    end
  end

  def class_average
    students = Student.where(period_id: self.id).all
    total = students.sum(:cash)
    if students.length > 0
      total / students.length
    else
      0
    end
  end

end
