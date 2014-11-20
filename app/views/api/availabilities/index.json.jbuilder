json.availabilities do
  json.array! @items do |item|
    json.set! :id, item.id

    json.airport do
      json.extract! item.airport, :id, :name, :code
    end

    json.rates do
      json.array! item.rates do |rate|
        json.extract! rate, :rate_id, :description, :base_rate,
          :additional_passenger, :total_charge, :trip_direction

        json.pickup_times do
          json.array! rate.pickup_times
        end
      end
    end
  end
end
