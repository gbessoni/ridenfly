class AddDirectionToPickupTime < ActiveRecord::Migration
  def change
    add_column :rate_pickup_times, :direction, :string, default: TripDirections::TO_AIRPORT
  end
end
