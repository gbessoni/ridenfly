class Reservation < ActiveRecord::Base
  include TripDirections

  belongs_to :rate
  belongs_to :sibling, class_name: 'Reservation'

  validates :net_fare, presence: true, numericality: true
  validates :rate, :email, presence: true

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

  def num_of_children
    "NOT IMPLEMENTED YET"
  end

  def flight_type
    "NOT IMPLEMENTED YET"
  end

  protected

  def set_price
    return if rate.blank? || net_fare.present?
    self.net_fare = rate.base_rate +
      (rate.additional_passenger * (num_of_passengers - 1))
  end
end
