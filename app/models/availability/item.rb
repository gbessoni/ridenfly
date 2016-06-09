class Availability::Item
  include Virtus.model
  include ActiveModel::Validations

  attribute :search, Availability::Search
  attribute :rate, Rate
  attribute :flight_time, Time

  delegate :num_of_passengers, :trip_direction, to: :search
  delegate :service_type, :vehicle_type_passenger,
    :base_rate, :additional_passenger, :airport, :company, :zipcode,
    :hotel_landmark_name, :hotel_landmark_street, :hotel_landmark_city,
    :hotel_landmark_state, :capacity, :company, :distance, to: :rate

  validates :rates, presence: true

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
    @rates ||= [first_leg, second_leg].compact if search.present?
  end

  def total_charge
    base_rate + (additional_passenger * (num_of_passengers - 1))
  end

  def pickup_times
    if rez_acceptable?
      filter_times(
        possible_pickup_times,
        hoo_in_timezone(company.hoo_start, airport&.timezone),
        hoo_in_timezone(company.hoo_end, airport&.timezone),
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
    return nil if search.roundtrip? && !trip_direction_active?(search.second_leg)

    self.class.new(
      search: search.first_leg,
      flight_time: search.flight_time,
      rate: rate,
    ) if trip_direction_active?(search.first_leg)
  end

  def second_leg
    return nil unless search.roundtrip?

    self.class.new(
      search: search.second_leg,
      flight_time: search.return_flight_time,
      rate: rate,
    ) if trip_direction_active?(search.second_leg) && trip_direction_active?(search.first_leg)
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
    times.select do |pt|
      pt.in_working_hours?(stime, etime)
    end
  end

  def trip_direction_active?(search)
    (search.to_airport? && rate.company.active_to_airport) ||
    (search.from_airport? && rate.company.active_from_airport)
  end

  def hoo_in_timezone(hoo_time, timezone)
    return hoo_time if timezone.nil?
    ActiveSupport::TimeZone[timezone].parse(hoo_time.asctime)
  end
end
