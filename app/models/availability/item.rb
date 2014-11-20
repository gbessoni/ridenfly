class Availability::Item
  include Virtus.model

  attribute :search, Availability::Search
  attribute :rate, Rate
  attribute :flight_time, Time

  delegate :adults, :trip_direction, to: :search
  delegate :service_type, :vehicle_type_passenger,
    :base_rate, :additional_passenger, to: :rate

  def rate_id
    rate.id
  end

  def description
    [ service_type,
      vehicle_type_passenger
    ].reject(&:blank?).join ' '
  end

  def rates
    @rates ||= [first_leg, second_leg].compact
  end

  def total_charge
    base_rate + (additional_passenger * (adults - 1))
  end

  def pickup_times
    Availability::TimeGenerator.new(
      flight_time,
      search,
      self,
    ).generate
  end

  def first_leg
    self.class.new(
      search: search,
      flight_time: search.flight_time,
      rate: rate,
    )
  end

  def second_leg
    self.class.new(
      search: search.second_leg,
      flight_time: search.return_flight_time,
      rate: rate,
    ) if search.roundtrip?
  end
end