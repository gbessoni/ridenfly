class ChangeTypeOfVehicleTypes < ActiveRecord::Migration
  def up
    remove_column :companies, :vehicle_types
    add_column :companies, :vehicle_types, :hstore, array: true
  end

  def down
    remove_column :companies, :vehicle_types
    add_column :companies, :vehicle_types, :hstore
  end
end
