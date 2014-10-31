FactoryGirl.define do
  factory :company do
    name "MyString"
    contact_first_name "MyString"
    contact_last_name "MyString"
    email "MyString"
    address "MyString"
    street "MyString"
    state "MyString"
    zipcode "MyString"
    phone "MyString"
    mobile "MyString"
    dispatch_phone "MyString"
    website "MyString"
    description "MyText"
    reservation_notification ""
    blackout_dates "MyText"
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
    vehicle_types ""
    other_vehicle_types "MyText"
  end

end
