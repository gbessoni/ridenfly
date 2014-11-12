class AddPickupTimesToRate < ActiveRecord::Migration
  def change
    add_column :rates, :pickup_times, :text, default: '[]'
  end
end
