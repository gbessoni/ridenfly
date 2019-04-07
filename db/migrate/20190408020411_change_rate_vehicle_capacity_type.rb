class ChangeRateVehicleCapacityType < ActiveRecord::Migration
  def change
    remove_column :rates, :vehicle_capacity_type, :string
    add_column :rates, :vehicle_capacity_type_id, :integer
    add_index :rates, :vehicle_capacity_type_id
  end
end
