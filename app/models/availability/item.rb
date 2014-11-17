class Availability::Item < Rate
  scope :by_search, ->(s) do
    joins(:airport)
      .where(
        "airports.name = ? OR airports.zipcode = ? OR airports.code = ?",
        s.airport, s.airport, s.airport)
  end

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

  def pickup_times
    [OpenStruct.new(start_datetime: Time.now, end_datetime: Time.now)]
  end
end
