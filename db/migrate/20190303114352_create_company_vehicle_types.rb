class CreateCompanyVehicleTypes < ActiveRecord::Migration
  def change
    create_table :company_vehicle_types do |t|
      t.integer :company_id
      t.string :name
      t.string :how_many
      t.string :num_of_passengers
    end

    add_index :company_vehicle_types, :company_id
    add_foreign_key :company_vehicle_types, :companies, dependent: :delete, column: :company_id
  end
end