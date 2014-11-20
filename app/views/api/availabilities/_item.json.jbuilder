json.set! :id, item.id

json.airport do
  json.extract! item.airport, :id, :name, :code
end

json.hotel_landmark do
  json.set! :name, item.search.hotel_landmark_name
  json.set! :street, item.search.hotel_landmark_street
  json.set! :city, item.search.hotel_landmark_city
  json.set! :state, item.search.hotel_landmark_state
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
