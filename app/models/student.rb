class Student < ActiveRecord::Base
  has_secure_password

  def richest?
    true
  end
end
