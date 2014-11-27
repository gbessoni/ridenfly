FactoryGirl.define do
  factory :reservation do
    flight_datetime DateTime.now
    pickup_datetime DateTime.now
    flight_type 'domestic'
    passenger_name "passenger name"
    phone "+48123123123"
    adults 1
    email 'customer@test.com'
    net_fare 9.99
    gratuity 8.99
    addresss "MyString"
    cross_street "MyString"
    airline "MyString"
    flight_number "MyString"
  end
end
