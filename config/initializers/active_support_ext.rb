ActiveSupport::JSON::Encoding.use_standard_json_time_format = false

class Time
  def as_json
    in_time_zone(Time.zone)
  end
end
