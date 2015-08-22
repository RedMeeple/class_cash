class Period < ActiveRecord::Base
  has_many :students, dependent: :destroy
  has_many :behaviors, through: :student
  has_many :bonuses, dependent: :destroy
  belongs_to :instructor
  accepts_nested_attributes_for :students, reject_if: :all_blank

  validates :students, presence: true

  def find_richest
    self.students.update_all(richest: false)
    if self.students.count == 1
      return
    elsif self.students.order(:cash).first.cash == self.students.order(:cash).second.cash
      return
    else
      rich = self.students[0]
      self.students.each do |s|
        rich = s if s.cash > rich.cash
      end
      rich.update(richest: true) if rich
      if Award.where(student_id: rich.id).where(award_type_id: 1).count == 0
        Award.create(student_id: rich.id, award_type_id: 1,
            reason: "being the richest on #{Date.today}", payment: 100)
      end
    end
  end

  def pay_students
    @students = Student.where(period_id: self.id).all
    transaction do
      @students.each do |student|
        a = Behavior.where(date: Date.today, student_id: student.id).first
        if a && a.well_behaved
          student.update(cash: (student.cash + self.payscale))
        end
        student.jobs.each do |job|
          if job.last_date_done == Date.today
            student.update(cash: (student.cash + job.payscale))
          end
        end
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
