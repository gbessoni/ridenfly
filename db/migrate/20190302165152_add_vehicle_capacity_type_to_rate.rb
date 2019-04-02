class AddVehicleCapacityTypeToRate < ActiveRecord::Migration
  def change
    add_column :rates, :vehicle_capacity_type, :string
    add_index :rates, :vehicle_capacity_type
  end
end
