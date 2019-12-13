json.reservations do
  json.array!(@reservations) do |reservation|
    json.extract! reservation, :id, :rate_id, :flight_datetime,
      :pickup_datetime, :passenger_name, :phone, :num_of_passengers,
      :net_fare, :gratuity, :address, :cross_street, :airline, :luggage,
      :cancelation_reason, :flight_number, :status, :trip_direction,
      :additional_notes
    json.url api_reservation_url(reservation, format: :json)
  end
end
