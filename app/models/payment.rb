class Payment < ActiveRecord::Base
  belongs_to :company
  has_many :reservations, ->(payment){
    where("reservations.pickup_datetime >= :from", from: payment.from)
      .where("reservations.pickup_datetime <= :to", to: payment.to)
  }, through: :company

  validates :company, :from, :to, :amount, presence: true

  before_validation :prepare_from_and_to, :prepare_amount

  def prepare_from_and_to
    self.from = from.to_date.beginning_of_day if from.present?
    self.to   = to.to_date.end_of_day if to.present?
  end

  def prepare_amount
    self.amount = reservations.sum(:net_fare)
  end
end
