class CreateAirports < ActiveRecord::Migration
  def change
    create_table :airports do |t|
      t.string :name
      t.string :street_address
      t.string :city
      t.string :state, limit: 2
      t.string :zipcode, limit: 5
      t.string :code, limit: 3

      t.timestamps
    end
  end
end
