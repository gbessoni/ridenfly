class AddNoPickupMessageToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :no_pickup_message, :string
  end
end
