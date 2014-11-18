class Availability::Item < Rate
  scope :by_airport, ->(s) do
    joins(:airport).where(
      "airports.name = ? OR airports.zipcode = ? OR airports.code = ?",
      s.airport, s.airport, s.airport
    )
  end

  scope :by_zipcode_or_hotel_landmark, ->(s) do
    if s.zipcode.present?
      where(zipcode: s.zipcode)
    else
      where Hash[Availability::Search::HOTEL_LANDMARK_ATTRS.map do |name|
        [name, s.send(name)]
      end]
    end
  end

  scope :by_search, ->(s) do
    by_airport(s).by_zipcode_or_hotel_landmark(s)
  end

  FLIGHT_TIME_MARGIN = 2.hours
  PICKUP_TIME_MARGIN = 1.hour

  attr_accessor :search

  delegate :adults, :trip_direction, to: :search

  def rate_id
    id
  end

  def description
    [ service_type,
      vehicle_type_passenger
    ].reject(&:blank?).join ' '
  end

  def rates
    @rates ||= [self]
  end

  def total_charge
    base_rate + (additional_passenger * (adults - 1))
  end

  def avl_pickup_times
    Availability::PickupTimeGenerator.new(
      search.flight_time,
      search,
      self,
    ).generate
  end
end
