class Company < ActiveRecord::Base
  REQUIRED_FIELDS = [
    :name, :contact_first_name, :contact_last_name,
    :email, :address, :street, :state, :zipcode, :phone,
    :dispatch_phone, :website, :description, :airports, :hours_of_operation,
    :pickup_info, :hours_in_advance_to_accept_rez
  ]

  validates *REQUIRED_FIELDS, presence: true
end
