class Reservation < ActiveRecord::Base
  include TripDirections

  belongs_to :rate
  belongs_to :sibling, class_name: 'Reservation'
  has_one :company, through: :rate

  validates :net_fare, presence: true, numericality: true
  validates :rate, :email, presence: true
  validates :cancelation_reason, presence: true, if: proc{|rec| rec.canceled?}

  before_validation :set_price

  scope :by_day, ->(date) do
    where("created_at between ? AND ?", date.beginning_of_date, date.end_of_day)
  end

  scope :active, ->{ where(status: 'active') }
  scope :canceled, ->{ where(status: 'canceled') }

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

  def flight_datetime
    return read_attribute(:flight_datetime) if airport&.timezone.nil?
    read_attribute(:flight_datetime).in_time_zone(airport&.timezone)
  end

  def pickup_datetime
    return read_attribute(:pickup_datetime) if airport&.timezone.nil?
    read_attribute(:pickup_datetime).in_time_zone(airport&.timezone)
  end

  protected

  def set_price
    return if rate.blank? || net_fare.present?
    self.net_fare = rate.base_rate +
      (rate.additional_passenger * (num_of_passengers - 1))
  end
end
