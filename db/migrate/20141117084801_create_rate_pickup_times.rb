class CreateRatePickupTimes < ActiveRecord::Migration
  def change
    create_table :rate_pickup_times do |t|
      t.integer :pickup
      t.integer :rate_id
    end

    add_foreign_key :rate_pickup_times, :rates, dependent: :delete, column: :rate_id
  end
end
