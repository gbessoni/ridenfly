class Export::Rate < Export::Base
  self.columns = {
    id: 'ID',
    airport_name: 'Airport*',
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
    pickup_time_list: 'Pickup times'
  }

  PICKUP_TIMES_SEP = Rate::PICKUP_TIMES_SEP

  def to_csv
    generate do |csv|
      csv << header
      resources.each do |resource|
        csv << build_row(resource)
      end
    end
  end

  def header
    self.class.columns.values
  end

  def build_row(resource)
    resource.as_json(methods: columns).values_at(*columns)
  end

  def columns
    self.class.columns.keys.map(&:to_s)
  end
end
