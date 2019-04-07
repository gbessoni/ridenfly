class ChangeCompanyVehicleTypesNumOfPassengers < ActiveRecord::Migration
  def change
    change_column :company_vehicle_types, :num_of_passengers, "integer USING NULLIF(num_of_passengers, '')::int"

    add_index :company_vehicle_types, :num_of_passengers
  end
end
