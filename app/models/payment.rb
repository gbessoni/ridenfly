class Payment < ActiveRecord::Base
  belongs_to :company
  has_many :reservations, ->(payment){
    where("reservations.pickup_datetime >= :from", from: payment.from)
      .where("reservations.pickup_datetime <= :to", to: payment.to)
  }, through: :company

  validates :company, :from, :to, :amount, presence: true
  validate :check_company_payment_conflict

  before_validation :prepare_from_and_to, :prepare_amount

  scope :by_times, ->(from, to) do
    where('"from" >= :from AND "to" <= :to', from: from, to: to)
  end

  def prepare_from_and_to
    self.from = from.to_date.beginning_of_day if from.present?
    self.to   = to.to_date.end_of_day if to.present?
  end

  def prepare_amount
    self.amount = reservations.active.sum(:net_fare)
  end

  def check_company_payment_conflict
    return if from.blank? || to.blank? || persisted?

    if self.class
      .where(company_id: company_id)
      .where('"from" BETWEEN :from AND :to OR "to" BETWEEN :from AND :to',
        from: from, to: to
      ).present?
      errors.add(:base, :payment_conflict)
    end
  end

  def owed_amount
    self.class.where(paid: true).by_times(from, to).sum(:amount)
  end

  def unpaid_amount
    self.class.where(paid: false).by_times(from, to).sum(:amount)
  end
end
