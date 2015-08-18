class Instructor < User
  has_many :periods, dependent: :destroy
  has_many :students, through: :periods
  has_many :bonuses, through: :periods
  has_many :loans, through: :students
  has_many :transactions, through: :students
  has_many :rights, dependent: :destroy
  has_many :student_right_assignments, through: :students

  def find_students_with_award(award_type)
    self.students.select { |s| s.awards.map(&:award_type_id).include? award_type }
  end

  def all_rights
    Right.where(instructor_id: [self.id, nil])
  end

  def unassigned_rights
    self.student_right_assignments.where(right_id: nil)
  end

  def unentered_periods
    periods = []
    self.periods.each do |period|
      periods << period if period.students.first.behaviors.last.date != Date.today
    end
    periods
  end

  def wealthiest
    students.order(:cash).last.full_name
  end

end
