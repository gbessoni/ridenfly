class AddAirportPickupFeeToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :airport_pickup_fee, :decimal, precision: 8, scale: 2, default: 0.0
  end
end
