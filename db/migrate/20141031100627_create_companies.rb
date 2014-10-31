class CreateCompanies < ActiveRecord::Migration
  def change
    enable_extension :hstore

    create_table :companies do |t|
      t.integer :user_id
      t.string :name
      t.string :contact_first_name
      t.string :contact_last_name
      t.string :email
      t.string :address
      t.string :street
      t.string :state
      t.string :zipcode
      t.string :phone
      t.string :mobile
      t.string :dispatch_phone
      t.string :website
      t.text :description
      t.hstore :reservation_notification
      t.text :blackout_dates
      t.text :airports
      t.string :hours_of_operation
      t.string :hours_in_advance_to_accept_rez
      t.text :pickup_info
      t.text :after_hours_info
      t.string :excess_luggage_charge
      t.boolean :luggage_insured
      t.string :child_rate
      t.boolean :child_car_seats_included
      t.text :luggage_limitation_policy
      t.text :company_reservation_policy
      t.text :company_cancellation_policy
      t.text :child_safety_policy
      t.text :pet_car_seat_policy
      t.hstore :vehicle_types
      t.text :other_vehicle_types

      t.timestamps
    end

    add_foreign_key :companies, :users, dependent: :delete, column: :user_id
  end
end
