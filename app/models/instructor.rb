class Instructor < User
  has_many :periods, dependent: :destroy
  has_many :students, through: :periods
  has_many :bonuses, through: :periods
  has_many :loans, through: :students
  has_many :transactions, through: :students
  has_many :rights, dependent: :destroy
  has_many :student_right_assignments, through: :students
  has_many :extras, through: :students
  has_many :awards, through: :students
  has_many :purchases, through: :students

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
    self.periods.order(:name).each do |period|
      if period.students.count > 0
        behavior = period.students.first.behaviors.last
        periods << period if behavior.nil? or behavior.date != Date.today
      end
    end
    periods
  end

  def wealthiest
    students.count > 0 ? students.reorder(:cash).last.full_name : "No students yet"
  end

end
