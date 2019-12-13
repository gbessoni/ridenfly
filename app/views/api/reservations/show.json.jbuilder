json.set! :id, @reservations.map(&:id).join('-')

json.reservations do
  json.array! @reservations do |reservation|
    json.extract! reservation, :id, :airport_name, :flight_datetime,
        :pickup_datetime, :passenger_name, :phone, :num_of_passengers,
        :net_fare, :gratuity, :address, :cross_street, :airline, :luggage,
        :cancelation_reason, :flight_number, :status, :trip_direction,
        :additional_notes
  end
end
