class AddDefaultsToCompany < ActiveRecord::Migration
  def change
    change_column_default :companies, :child_car_seats_included, false
    change_column_default :companies, :luggage_insured, false
  end
end
