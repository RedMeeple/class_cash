class Period < ActiveRecord::Base
  has_many :students
  belongs_to :instructor
  accepts_nested_attributes_for :students
end
