FactoryGirl.define do
  factory :company do
    name "MyString"
    contact_first_name "MyString"
    contact_last_name "MyString"
    sequence(:email)      { |n| "company_#{n}@example.com" }
    street "MyString"
    state "MyString"
    zipcode "123123"
    phone "1231231312"
    mobile "12312312322"
    dispatch_phone "12312312234"
    website "MyString"
    description "MyText"
    notification_fax "true"
    notification_email "true"
    blackout_dates ""
    airports "MyText"
    hours_of_operation "MyString"
    hours_in_advance_to_accept_rez "MyString"
    pickup_info "MyText"
    after_hours_info "MyText"
    excess_luggage_charge "MyString"
    luggage_insured false
    child_rate "MyString"
    child_car_seats_included false
    luggage_limitation_policy "MyText"
    company_reservation_policy "MyText"
    company_cancellation_policy "MyText"
    child_safety_policy "MyText"
    pet_car_seat_policy "MyText"
    other_vehicle_types "MyText"
  end
end
