json.array!(@rates) do |admin_rate|
  json.extract! admin_rate, :id, :airport_id, :vehicle_type_passenger, :service_type, :base_rate, :additional_passenger, :zipcode, :hotel_landmark_name, :hotel_landmark_street, :hotel_landmark_city, :hotel_landmark_state, :trip_duration
  json.url admin_rate_url(admin_rate, format: :json)
end
