class Student < ActiveRecord::Base
  has_secure_password

  def self.richest?
    Student.update_all richest: false
    rich = Student.order(:cash).last
    rich.update(richest: true)
  end
end
