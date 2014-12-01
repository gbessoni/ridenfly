class Reservation < ActiveRecord::Base
  include TripDirections

  belongs_to :rate
  belongs_to :sibling, class_name: 'Reservation'

  validates :net_fare, presence: true, numericality: true
  validates :rate, :email, presence: true
  validates :cancelation_reason, presence: true, if: proc{|rec| rec.canceled?}

  before_validation :set_price

  def airport_name
    airport.try(:name)
  end

  def company_name
    company.try(:name)
  end

  def airport
    rate.try(:airport)
  end

  def company
    rate.try(:company)
  end

  def rezid
    ['RF', id].join
  end

  def num_of_passengers
    adults + children
  end

  def total_net_fare
    [net_fare, sibling.try(:net_fare)].compact.sum
  end

  def cancel(params)
    self.status = 'canceled'
    self.update_attributes(params.slice(:cancelation_reason))
  end

  def canceled?
    status.to_s == 'canceled'
  end

  protected

  def set_price
    return if rate.blank? || net_fare.present?
    self.net_fare = rate.base_rate +
      (rate.additional_passenger * (num_of_passengers - 1))
  end
end
