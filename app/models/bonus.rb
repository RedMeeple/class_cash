class Bonus < ActiveRecord::Base
  belongs_to :period
  validates :amount, presence: true
  validates :period_id, presence: true
end
