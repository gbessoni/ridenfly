class RemovePickupTimesFieldFromRate < ActiveRecord::Migration
  def change
    remove_column :rates, :pickup_times, :text, default: '[]'
  end
end
