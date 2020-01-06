require 'csv'

class Import::Rate < Import::Base
  attribute :company_id, Integer

  ID                        = 0
  AIRPORT                   = 1
  VEHICLE_TYPE_PASSENGER    = 2
  SERVICE_TYPE              = 3
  BASE_RATE                 = 4
  ADDITIONAL_PASSENGER      = 5
  ZIPCODE                   = 6
  HOTEL_LANDMARK_NAME       = 7
  HOTEL_LANDMARK_STREET     = 8
  HOTEL_LANDMARK_CITY       = 9
  HOTEL_LANDMARK_STATE      = 10
  TRIP_DURATION             = 11
  TO_AIRPORT_PICKUP_TIMES   = 12
  LAT_LNG                   = 13
  FROM_AIRPORT_PICKUP_TIMES = 12
  HOTEL_BY_ZIPCODE          = 15

  def perform
    valid? && read do|row|
      o = build_object(row)
      (o.valid? ? valid_objects : invalid_objects) << o
    end
  end

  def build_object(row)
    o = self.class.import_model.where(
      id: row[ID], company_id: company_id
    ).first_or_initialize
    o.company = find_company
    o.update_attributes(
      airport:                       find_airport(row[AIRPORT]),
      vehicle_type_passenger:        row[VEHICLE_TYPE_PASSENGER],
      service_type:                  row[SERVICE_TYPE],
      base_rate:                     row[BASE_RATE],
      additional_passenger:          row[ADDITIONAL_PASSENGER],
      zipcode:                       row[ZIPCODE],
      hotel_landmark_name:           row[HOTEL_LANDMARK_NAME],
      hotel_landmark_street:         row[HOTEL_LANDMARK_STREET],
      hotel_landmark_city:           row[HOTEL_LANDMARK_CITY],
      hotel_landmark_state:          row[HOTEL_LANDMARK_STATE],
      trip_duration:                 row[TRIP_DURATION],
      to_airport_pickup_time_list:   row[TO_AIRPORT_PICKUP_TIMES],
      lat_lng:                       row[LAT_LNG],
      from_airport_pickup_time_list: row[FROM_AIRPORT_PICKUP_TIMES],
      hotel_by_zipcode:              row[HOTEL_BY_ZIPCODE],
    )
    o
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

  def find_company
    @company ||= Company.where(id: company_id).first
  end
end
