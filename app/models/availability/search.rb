class Availability::Search
  include Virtus.model

  TO_AIRPORT = 'to_airport'
  FROM_AIRPORT = 'from_airport'

  DOMESTIC = 'domestic'
  INTERNATIONAL = 'international'

  attribute :trip_direction, String, default: TO_AIRPORT
  attribute :flight_type, String, default: DOMESTIC

  attribute :airport, String

  attribute :flight_time, Time
  attribute :return_flight_time, Time

  attribute :hotel_landmark_name, String
  attribute :hotel_landmark_street, String
  attribute :hotel_landmark_city, String
  attribute :hotel_landmark_state, String
  attribute :hotel_landmark, String
  attribute :zipcode, String

  attribute :adults, Integer
  attribute :children, Integer

  def hotel_landmark=(full_name)
    list = full_name.split(',').map(&:strip)
    Rate::HOTEL_LANDMARK_ATTRS.each_with_index do |name, i|
      self[name] ||= list[i]
    end
    super(full_name)
  end

  def domestic?
    flight_type == DOMESTIC
  end
end
