json.reservation do
  json.extract! @reservation, :id, :airport_name, :flight_datetime,
    :pickup_datetime, :passenger_name, :phone, :num_of_passengers,
    :net_fare, :gratuity, :addresss, :cross_street, :airline, :luggage,
    :cancelation_reason, :flight_number, :status, :trip_direction
end
