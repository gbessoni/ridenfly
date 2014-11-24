class Rate < ActiveRecord::Base
  belongs_to :airport
  belongs_to :company
  has_many :pickup_times, class_name: 'Rate::PickupTime', dependent: :delete_all

  validates :airport, :company, presence: true
  validates :base_rate, :additional_passenger, presence: true, numericality: true
  validates :trip_duration, presence: true, numericality: {only_integer: true, greater_than: 0}
  validate :check_pickup_times

  accepts_nested_attributes_for :pickup_times, allow_destroy: true

  PICKUP_TIMES_SEP = '|'

  HOTEL_LANDMARK_ATTRS = [
    :hotel_landmark_name,
    :hotel_landmark_street,
    :hotel_landmark_city,
    :hotel_landmark_state
  ]

  CAPACITY = 4

  scope :by_airport, ->(airport) do
    joins(:airport).where(
      "airports.name = ? OR airports.zipcode = ? OR airports.code = ?",
      airport, airport, airport
    )
  end

  scope :by_zipcode_or_hotel_landmark, ->(s) do
    if s.zipcode.present?
      where(zipcode: s.zipcode)
    else
      where Hash[HOTEL_LANDMARK_ATTRS.map do |name|
        [name, s.send(name)]
      end]
    end
  end

  scope :by_search, ->(search) do
    by_airport(search.airport).by_zipcode_or_hotel_landmark(search)
  end

  def pickup_time_list=(list)
    attrs = {}

    list = (list || '').split(PICKUP_TIMES_SEP).uniq.map(&:strip)
    list += [nil] * (pickup_times.size - list.size) if pickup_times.size > list.size

    list.zip(pickup_times).each_with_index do |(t, obj), i|
      oid = obj.try(:id) || i
      attrs[oid] ||= {}
      attrs[oid].merge!(id: oid) if obj.present?
      if t.present?
        attrs[oid].merge!(pickup_str: t)
      else
        attrs[oid].merge!(_destroy: 1)
      end
    end

    self.pickup_times_attributes = attrs
  end

  def pickup_time_list
    pickup_times.map(&:pickup_str).join(PICKUP_TIMES_SEP)
  end

  def airport_name
    airport.name
  end

  def capacity
    CAPACITY
  end

  protected

  def check_pickup_times
    if pickup_times.any?{|pt| pt.errors.present?}
      errors.add(:pickup_time_list, :invalid_format)
    end
  end
end
