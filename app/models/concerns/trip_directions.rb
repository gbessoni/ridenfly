module TripDirections
  TO_AIRPORT = 'to_airport'
  FROM_AIRPORT = 'from_airport'

  def from_airport?
    trip_direction == FROM_AIRPORT
  end

  def to_airport?
    trip_direction == TO_AIRPORT
  end
end
