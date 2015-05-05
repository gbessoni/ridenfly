class AddActiveDirectionsToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :active_to_airport, :boolean, default: true
    add_column :companies, :active_from_airport, :boolean, default: true
  end
end
