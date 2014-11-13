FactoryGirl.define do
  factory :rate do
    airport_id 1
    vehicle_type_passenger "MyString"
    service_type "MyString"
    base_rate 25.5
    additional_passenger 0.0
    zipcode "MyString"
    hotel_landmark_name "MyString"
    hotel_landmark_street "MyString"
    hotel_landmark_city "MyString"
    hotel_landmark_state "MyString"
    trip_duration 60
    pickup_time_list ['10:00AM', '11:00PM'].join(
      Rate::PICKUP_TIMES_SEP
    )
  end
end
