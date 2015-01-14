class Availability::PickupTime
  include Virtus.model

  attribute :start_datetime, Time
  attribute :end_datetime, Time

  def as_json
    { start_datetime: start_datetime,
      end_datetime: end_datetime
    }
  end

  def in_working_hours?(start_t, end_t)
    (start_t <= start_datetime && end_t >= start_datetime) ||
    (start_t <= end_datetime && end_t >= end_datetime)
  end
end
