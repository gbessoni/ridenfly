FactoryGirl.define do
  factory :reservation do
    flight_datetime DateTime.now
    pickup_datetime DateTime.now
    passenger_name "passenger name"
    phone "+48123123123"
    num_of_passengers 1
    net_fare 9.99
    gratuity 8.99
    addresss "MyString"
    cross_street "MyString"
    airline "MyString"
    flight_number "MyString"
  end
end
