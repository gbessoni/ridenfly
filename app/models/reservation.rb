class Reservation < ActiveRecord::Base
  include TripDirections
  extend Enumerize

  belongs_to :rate
  belongs_to :sibling, class_name: 'Reservation'
  has_one :company, through: :rate

  STATUSES = %w[active canceled]
  enumerize :status, in: STATUSES, predicates: true, scope: :shallow

  SUB_STATUSES = %w[completed no_show]
  enumerize :sub_status, in: SUB_STATUSES

  validates :net_fare, presence: true, numericality: true
  validates :rate, :email, presence: true
  validates :cancelation_reason, presence: true, if: proc{|rec| rec.canceled?}

  before_validation :set_price

  scope :by_day, ->(date) do
    where("created_at between ? AND ?", date.beginning_of_date, date.end_of_day)
  end

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


# == Schema Information
#
# Table name: reservations
#
#  id                 :integer         not null, primary key
#  flight_datetime    :datetime
#  pickup_datetime    :datetime
#  passenger_name     :string
#  phone              :string
#  adults             :integer
#  net_fare           :decimal(8, 2)
#  gratuity           :decimal(8, 2)   default("0.0")
#  address            :string
#  cross_street       :string
#  airline            :string
#  luggage            :integer         default("0")
#  cancelation_reason :string
#  flight_number      :string
#  status             :string          default("active")
#  trip_direction     :string          default("to_airport")
#  created_at         :datetime
#  updated_at         :datetime
#  sibling_id         :integer
#  rate_id            :integer
#  children           :integer         default("0")
#  email              :string
#  flight_type        :string          default("domestic")
#  additional_notes   :string
#  sub_status         :string
#  notes              :string
#

