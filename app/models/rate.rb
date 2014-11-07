class Rate < ActiveRecord::Base
  belongs_to :airport
  belongs_to :company

  validates :base_rate, :airport, :company, presence: true
end
