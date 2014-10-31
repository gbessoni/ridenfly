json.array!(@companies) do |admin_company|
  json.extract! admin_company, :id, :name, :contact_first_name, :contact_last_name, :email, :address, :street, :state, :zipcode, :phone, :mobile, :dispatch_phone, :website, :description, :reservation_notification, :blackout_dates, :airports, :hours_of_operation, :hours_in_advance_to_accept_rez, :pickup_info, :after_hours_info, :excess_luggage_charge, :luggage_insured, :child_rate, :child_car_seats_included, :luggage_limitation_policy, :company_reservation_policy, :company_cancellation_policy, :child_safety_policy, :pet_car_seat_policy, :vehicle_types, :other_vehicle_types
  json.url admin_company_url(admin_company, format: :json)
end
