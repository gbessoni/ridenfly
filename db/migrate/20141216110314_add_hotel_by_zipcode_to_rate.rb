class AddHotelByZipcodeToRate < ActiveRecord::Migration
  def change
    add_column :rates, :hotel_by_zipcode, :boolean, default: false
  end
end
