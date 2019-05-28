FactoryGirl.define do
  factory :company do
    name                        'MyString'
    contact_first_name          'MyString'
    contact_last_name           'MyString'
    city                        'City'
    street                      'MyString'
    state                       'MyString'
    zipcode                     '123123'
    phone                       '1231231312'
    mobile                      '12312312322'
    dispatch_phone              '12312312234'
    website                     'MyString'
    description                 'MyText'
    notification_fax            'true'
    notification_email          'true'
    blackout_dates              ''
    airports                    'MyText'
    hours_of_operation          '0:00AM-23:59PM'
    pickup_info                 'MyText'
    after_hours_info            'MyText'
    excess_luggage_charge       'MyString'
    luggage_insured             false
    child_rate                  'MyString'
    child_car_seats_included    false
    luggage_limitation_policy   'MyText'
    company_reservation_policy  'MyText'
    company_cancellation_policy 'MyText'
    child_safety_policy         'MyText'
    pet_car_seat_policy         'MyText'
    other_vehicle_types         'MyText'
    no_pickup_message           'We will call you one day before flight'
    commission                   10
    hours_in_advance_to_accept_rez 'MyString'
    confirmation_emails         'test@test.com,test2@test.com'

    trait :with_vehicle_capacity_types do
      after(:create) do |company, evaluator|
        {
          'Private Van' => 4,
          'Shared Van' => 8,
          'Limousine' => 12,
        }.each do |name, capacity|
          FactoryGirl.create(:company_vehicle_type,
            company: company,
            name: name,
            num_of_passengers: capacity
          )
        end
      end
    end
  end
end
