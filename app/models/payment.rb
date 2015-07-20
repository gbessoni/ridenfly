class Payment < ActiveRecord::Base
  belongs_to :company

  validates :company, :from, :to, :amount, presence: true
end
