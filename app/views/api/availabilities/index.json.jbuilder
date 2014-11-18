json.availabilities do
  json.array! @items do |item|
    json.array! item.rates do |rate|
      json.extract! item, :rate_id, :description, :base_rate,
        :additional_passenger, :total_charge, :trip_direction
      json.pickup_times do
        json.array! rate.avl_pickup_times
      end
    end
  end
end
