class Payment < ActiveRecord::Base
  belongs_to :company
  has_many :reservations, through: :company

  validates :company, :from, :to, :amount, presence: true
end
