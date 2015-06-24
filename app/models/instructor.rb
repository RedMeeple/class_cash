class Instructor < ActiveRecord::Base
  has_secure_password
  has_many :periods, dependent: :destroy
  has_many :students, through: :periods
  has_many :bonuses, through: :periods

  def find_students_with_award(award_type)
    self.students.select { |s| s.awards.map(&:award_type_id).include? award_type }
  end

end
