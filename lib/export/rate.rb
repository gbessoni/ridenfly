class Export::Rate < Export::Base
  self.columns = {
    airport_id: 'Airport*',
    vehicle_type_passenger: 'Vehicle Type / Passenger',
    service_type: 'Private or Shared',
    base_rate: 'Base rate',
    additional_passenger: 'Additional passenger',
    zipcode: 'Zipcode*',
    hotel_landmark_name: 'Hotel / Landmark name*',
    hotel_landmark_street: 'Hotel / Landmark street address*',
    hotel_landmark_city: 'Hotel / Landmark city',
    hotel_landmark_state: 'Hotel / Landmark state',
    trip_duration: 'Trip duration',
  }
end
