FactoryGirl.define do
  factory :rate do
    airport_id 1
    vehicle_type_passenger "MyString"
    service_type "MyString"
    base_rate 25.5
    additional_passenger 0.0
    zipcode "90102"
    hotel_landmark_name "Vega"
    hotel_landmark_street "Grabiszynska 73/6"
    hotel_landmark_city "Wroclaw"
    hotel_landmark_state "Dolnyslask"
    trip_duration 60
    pickup_time_list ['10:00AM', '11:00PM'].join(
      Rate::PICKUP_TIMES_SEP
    )
    lat_lng '10.1,20.2'
    hotel_by_zipcode true
  end
end
