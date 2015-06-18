class Instructor < ActiveRecord::Base
  has_secure_password
  has_many :periods, dependent: :destroy
  has_many :students, through: :period
  has_many :bonuses, through: :period
end
