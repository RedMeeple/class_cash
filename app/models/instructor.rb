class Instructor < User
  has_many :periods, dependent: :destroy
  has_many :students, through: :periods
  has_many :bonuses, through: :periods
  has_many :loans, through: :students
  has_many :transactions, through: :students
  has_many :rights, dependent: :destroy

  def find_students_with_award(award_type)
    self.students.select { |s| s.awards.map(&:award_type_id).include? award_type }
  end

  def all_rights
    Right.where(instructor_id: [self.id, nil])
  end

end
