json.set! :id, item.id

json.airport do
  json.extract! item.airport, :id, :name, :code
end

json.rates do
  json.array! item.rates do |rate|
    json.extract! rate, :rate_id, :description, :base_rate,
      :additional_passenger, :total_charge, :trip_direction, :zipcode,
      :hotel_landmark_name, :hotel_landmark_street, :hotel_landmark_city,
      :hotel_landmark_state, :capacity

    json.company do
      json.extract! rate.company, :name, :description,
        :phone, :mobile, :dispatch_phone, :pickup_info
    end

    json.pickup_times do
      json.array! rate.pickup_times
    end
  end
end
