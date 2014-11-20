class Availability::TimeGenerator < Struct.new(:flight_time, :search, :rate)
  DOMESTIC_TIME_MARGIN = 1.hour + 30.minutes
  INTERNATIONAL_TIME_MARGIN = 2.hours + 30.minutes

  def generate
    if rate.pickup_times.present?
      rate_pickup_times
    else
      std_pickup_times
    end
  end

  def rate_pickup_times
    rate.pickup_times.map do |pt|
      time_attrs pt.to_time
    end
  end

  def std_pickup_times
    if search.domestic?
      domestic_pickup_times
    else
      internationals_pickup_times
    end
  end

  def domestic_pickup_times
    [time_attrs(
      flight_time - (rate.trip_duration * 60 + DOMESTIC_TIME_MARGIN)
    )]
  end

  def internationals_pickup_times
    [time_attrs(
      flight_time - (rate.trip_duration * 60 + INTERNATIONAL_TIME_MARGIN)
    )]
  end

  def time_attrs(time)
    { start_datetime: time, end_datetime: time }
  end
end
