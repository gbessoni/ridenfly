class AddIndexForScheduledRates < ActiveRecord::Migration
  def change
    add_index :rates, :vehicle_type_passenger
  end
end
