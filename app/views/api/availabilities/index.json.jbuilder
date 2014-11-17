json.availabilities do
  json.array! @items do |item|
    json.array! item.rates do |rate|
      json.extract! item, :rate_id, :description, :base_rate,
        :additional_passenger, :total_charge, :trip_direction
      json.pickup_times do
        json.array! rate.pickup_times do |pickup_time|
          json.extract! pickup_time, :start_datetime, :end_datetime
        end
      end
    end
  end
end
