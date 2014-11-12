require 'csv'

class Import::Rate < Import::Base
  attribute :company_id, Integer

  ID                     = 0
  AIRPORT                = 1
  VEHICLE_TYPE_PASSENGER = 2
  SERVICE_TYPE           = 3
  BASE_RATE              = 4
  ADDITIONAL_PASSENGER   = 5
  ZIPCODE                = 6
  HOTEL_LANDMARK_NAME    = 7
  HOTEL_LANDMARK_STREET  = 8
  HOTEL_LANDMARK_CITY    = 9
  HOTEL_LANDMARK_STATE   = 10
  TRIP_DURATION          = 11
  PICKUP_TIMES           = 12

  PICKUP_TIMES_SEP = '|'

  def perform
    valid? && read do|row|
      objects << build_object(row)
    end
  end

  def build_object(row)
    o = self.class.import_model.where(id: row[ID]).first_or_initialize
    o.assign_attributes(
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
    o
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
