class Availability::PickupTime
  include Virtus.model

  attribute :start_datetime, Time
  attribute :end_datetime, Time

  def as_json
    { start_datetime: start_datetime,
      end_datetime: end_datetime
    }
  end
end
