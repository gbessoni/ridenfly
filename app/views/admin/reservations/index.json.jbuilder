json.array!(@reservations) do |reservation|
  json.extract! reservation, :id, :airport_id, :company_id, :flight_datetime,
    :pickup_datetime, :passenger_name, :phone, :num_of_passengers, :net_fare,
    :gratuity, :addresss, :cross_street, :airline, :luggage, :cancelation_reason,
    :flight_number, :status, :service_type
  json.url admin_reservation_url(reservation, format: :json)
end
