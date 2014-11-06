class CreateRates < ActiveRecord::Migration
  def change
    create_table :rates do |t|
      t.integer :airport_id
      t.string :vehicle_type_passenger
      t.string :service_type
      t.decimal :base_rate, {precision: 8, scale: 2}
      t.decimal :additional_passenger, {precision: 8, scale: 2, default: 0.0}
      t.string :zipcode
      t.string :hotel_landmark_name
      t.string :hotel_landmark_street
      t.string :hotel_landmark_city
      t.string :hotel_landmark_state
      t.integer :trip_duration

      t.timestamps
    end
  end
end
