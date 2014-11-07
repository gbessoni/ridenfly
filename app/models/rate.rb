class Rate < ActiveRecord::Base
  validates :base_rate, presence: true

  belongs_to :airport
  belongs_to :company
end
