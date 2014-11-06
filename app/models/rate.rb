class Rate < ActiveRecord::Base
  validates :base_rate, presence: true
end
