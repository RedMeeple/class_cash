class Instructor < ActiveRecord::Base
  has_secure_password
  has_many :periods
  has_many :students, through: :period
end
