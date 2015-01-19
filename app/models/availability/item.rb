class Availability::Item
  include Virtus.model

  attribute :search, Availability::Search
  attribute :rate, Rate
  attribute :flight_time, Time

  delegate :adults, :trip_direction, to: :search
  delegate :service_type, :vehicle_type_passenger,
    :base_rate, :additional_passenger, :airport, :company, :zipcode,
    :hotel_landmark_name, :hotel_landmark_street, :hotel_landmark_city,
    :hotel_landmark_state, :capacity, :company, :distance, to: :rate

  def id
    rates.map(&:rate_id).join('-')
  end

  def rate_id
    rate.id
  end

  def scheduled
    distance.present?
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
    if rez_acceptable?
      filter_times(
        possible_pickup_times,
        company.hoo_start,
        company.hoo_end,
      ).map(&:as_json)
    else
      []
    end
  end

  def possible_pickup_times
    @possible_pickup_times ||= Availability::TimesGenerator.new(
      flight_time, search, rate,
    ).generate
  end

  def first_leg
    self.class.new(
      search: search.first_leg,
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

  def rez_acceptable?
    rate.rez_acceptable?(search.flight_time)
  end

  def rez_acceptance_message
    "We apologize, however we need #{company.hours_in_advance_to_accept_rez.to_i}" +
    " hours advanced notice to make this reservation." +
    " Hours of operation #{company.hours_of_operation}"
  end

  def filter_times(times, stime, etime)
    times
    # times.select do |pt|
    #   pt.in_working_hours?(stime, etime)
    # end
  end
end
