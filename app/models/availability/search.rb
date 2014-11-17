class Availability::Search
  include Virtus.model

  TO_AIRPORT = 'to_airport'
  FROM_AIRPORT = 'from_airport'

  DOMESTIC = 'domestic'
  INTERNATIONAL = 'international'

  attribute :airport, String
  attribute :trip_direction, String, default: TO_AIRPORT
  attribute :to_airport_flight_time, Time
  attribute :from_airport_flight_time, Time
  attribute :flight_type, String, default: DOMESTIC

  attribute :hotel_landmark_name, String
  attribute :hotel_landmark_street, String
  attribute :hotel_landmark_city, String
  attribute :hotel_landmark_state, String
  attribute :street_address, String
  attribute :zipcode, String

  attribute :adults, Integer
  attribute :children, Integer
end
