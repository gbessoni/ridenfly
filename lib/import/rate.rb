require 'csv'

class Import::Rate < Import::Base
  AIRPORT                = 0
  VEHICLE_TYPE_PASSENGER = 1
  SERVICE_TYPE           = 2
  BASE_RATE              = 3
  ADDITIONAL_PASSENGER   = 4
  ZIPCODE                = 5
  HOTEL_LANDMARK_NAME    = 6
  HOTEL_LANDMARK_STREET  = 7
  HOTEL_LANDMARK_CITY    = 8
  HOTEL_LANDMARK_STATE   = 9
  TRIP_DURATION          = 10
  PICKUP_TIMES           = 11

  PICKUP_TIMES_SEP = '|'

  def perform
    read do|row|
      objects << build_object(row)
    end
  end

  def build_object(row)
    self.class.import_model.new(
      airport:                find_airport(row[AIRPORT]),
      vehicle_type_passenger: row[VEHICLE_TYPE_PASSENGER],
      service_type:           row[SERVICE_TYPE],
      base_rate:              row[BASE_RATE],
      additional_passenger:   row[ADDITIONAL_PASSENGER],
      zipcode:                row[ZIPCODE],
      hotel_landmark_name:    row[HOTEL_LANDMARK_NAME],
      hotel_landmark_street:  row[HOTEL_LANDMARK_STREET],
      hotel_landmark_city:    row[HOTEL_LANDMARK_CITY],
      hotel_landmark_state:   row[HOTEL_LANDMARK_STATE],
      trip_duration:          row[TRIP_DURATION],
      pickup_times:           pickup_times(row)
    )
  end

  def pickup_times(row)
    row[PICKUP_TIMES].to_s.split(PICKUP_TIMES_SEP) || []
  end

  def read
    CSV.foreach(import_file.path, csv_options) do |row|
      yield row
    end
  end

  def csv_options
    {headers: true}
  end

  def find_airport(name)
    Airport.where(
      "name = ? OR zipcode = ? OR code = ?", name, name, name
    ).first
  end
end
