class AddUniqIndexesToAirport < ActiveRecord::Migration
  def change
    add_index :airports, [:state, :code], unique: true
    add_index :airports, :name, unique: true
  end
end
