class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.integer :airport_id
      t.integer :company_id
      t.datetime :flight_datetime
      t.datetime :pickup_datetime
      t.string :passenger_name
      t.string :phone
      t.integer :num_of_passengers
      t.decimal :net_fare, {precision: 8, scale: 2}
      t.decimal :gratuity, {precision: 8, scale: 2, default: 0.0}
      t.string :addresss
      t.string :cross_street
      t.string :airline
      t.integer :luggage, default: 0
      t.string :cancelation_reason
      t.string :flight_number
      t.string :status, default: 'created'
      t.string :service_type, default: 'to_airport'

      t.timestamps
    end

    add_foreign_key :reservations, :airports, dependent: :delete, column: :airport_id
    add_foreign_key :reservations, :companies, dependent: :delete, column: :company_id
  end
end
