class Export::Reservation < Export::Base
  self.columns = {
    id: 'Rez ID',
    airport_name: 'Airport (a-arrival d-departure)',
    flight_datetime: 'Arrival / Departure Time',
    pickup_datetime: 'Pickup Date / Time',
    passenger_name: 'Name',
    phone: 'Phone',
    num_of_passengers: '# of Passengers',
    gratuity: 'Gratuity Collected',
    net_fare: 'Net fare',
    addresss: 'Addresss',
    cross_street: 'Cross street',
    airline: 'Airline',
    flight_number: 'Flight Number'
  }
end
