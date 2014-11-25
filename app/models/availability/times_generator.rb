class Availability::TimesGenerator < Struct.new(:flight_time, :search, :rate)
  DOMESTIC_TIME_MARGIN      = 1.hour + 30.minutes
  INTERNATIONAL_TIME_MARGIN = 2.hours + 30.minutes

  def generate
    if search.from_airport?
      from_airport_pickup_times
    else
      to_airport_pickup_times
    end
  end

  def to_airport_pickup_times
    if rate.pickup_times.present?
      rate_pickup_times
    else
      std_pickup_times
    end
  end

  def from_airport_pickup_times
    [time_attrs(flight_time)]
  end

  def rate_pickup_times
    rate.pickup_times.map do |pt|
      time_attrs pt.to_time(flight_time)
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
    interval_times_attrs(
      flight_time - (trip_duration_in_minutes + DOMESTIC_TIME_MARGIN)
    )
  end

  def internationals_pickup_times
    interval_times_attrs(
      flight_time - (trip_duration_in_minutes + INTERNATIONAL_TIME_MARGIN)
    )
  end

  def interval_times_attrs(time, interval=15.minutes)
    t = time.dup
    (0..3).to_a.map do |i|
      time_attrs(t - (i + 1) * interval, t - i * interval)
    end
  end

  def time_attrs(startt, endt = nil)
    { start_datetime: startt, end_datetime: endt || startt }
  end

  def trip_duration_in_minutes
    rate.trip_duration * 60
  end
end
