class Rate < ActiveRecord::Base
  acts_as_paranoid
  extend Enumerize

  include Rate::Relations
  include Rate::Validations
  include Rate::Scopes


  HOTEL_LANDMARK_ATTRS = [
    :hotel_landmark_name,
    :hotel_landmark_street,
    :hotel_landmark_city,
    :hotel_landmark_state
  ]

  before_save :set_hl_words
  before_save :fix_zipcode

  belongs_to :company
  belongs_to :vehicle_capacity_type, class_name: 'Company::VehicleType'
  has_many :payments, through: :company
  has_many :reservations

  def to_airport_pickup_time_list=(list)
    self.to_airport_pickup_times_attributes = Rate::PickupTimeMerger.new(
      list, to_airport_pickup_times
    ).attrs
  end

  def from_airport_pickup_time_list=(list)
    self.from_airport_pickup_times_attributes = Rate::PickupTimeMerger.new(
      list, from_airport_pickup_times
    ).attrs
  end

  def to_airport_pickup_time_list
    to_airport_pickup_times.map(&:pickup_str).join(Rate::PickupTimeMerger::PICKUP_TIMES_SEP)
  end

  def from_airport_pickup_time_list
    from_airport_pickup_times.map(&:pickup_str).join(Rate::PickupTimeMerger::PICKUP_TIMES_SEP)
  end

  def airport_name
    airport.name
  end

  def capacity
    vehicle_capacity_type&.num_of_passengers
  end

  def lat_lng
    [lat, lng].reject(&:blank?).join(', ')
  end

  def lat_lng=(arg)
    self.lat, self.lng = arg.to_s.split(',').map(&:strip)
  end

  def hotel_landmark
    [  hotel_landmark_name,
       hotel_landmark_street,
       hotel_landmark_city,
       hotel_landmark_state
    ].reject(&:blank?).join(', ')
  end

  def rez_acceptable?(time)
    hours_in_advance = (
      Time.zone.now + company.hours_in_advance_to_accept_rez.to_i.hours
    )
    time >= hours_in_advance
  end

  def distance
    attributes['distance']
  end

  def payment(from, to)
    payments.select do |pay|
      from.to_date == pay.from.to_date && pay.to.to_date == to.to_date
    end.first
  end

  protected

  def set_hl_words
    self.hl_words = Rate::WordsBuilder.new(
      [hotel_landmark_name, hotel_landmark_street].join ' '
    ).words
  end

  def fix_zipcode
    self.zipcode = zipcode.delete(' ')
  end
end




# == Schema Information
#
# Table name: rates
#
#  id                       :integer         not null, primary key
#  airport_id               :integer
#  vehicle_type_passenger   :string
#  service_type             :string
#  base_rate                :decimal(8, 2)
#  additional_passenger     :decimal(8, 2)   default("0.0")
#  zipcode                  :string
#  hotel_landmark_name      :string
#  hotel_landmark_street    :string
#  hotel_landmark_city      :string
#  hotel_landmark_state     :string
#  trip_duration            :integer
#  created_at               :datetime
#  updated_at               :datetime
#  company_id               :integer
#  lat                      :float
#  lng                      :float
#  hl_words                 :string
#  hotel_by_zipcode         :boolean         default("false")
#  vehicle_capacity_type_id :integer
#  deleted_at               :datetime
#

