class AddLatLngToRate < ActiveRecord::Migration
  def up
    enable_extension 'cube'
    enable_extension 'earthdistance'

    add_column :rates, :lat, :float
    add_column :rates, :lng, :float

    execute 'CREATE  INDEX  "index_rates_on_lat_and_lng" ON "rates" USING gist(ll_to_earth(lat, lng))'
  end

  def down
    remove_column :rates, :lat
    remove_column :rates, :lng
    # Index will be removed automagically
  end
end
