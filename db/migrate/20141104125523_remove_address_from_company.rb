class RemoveAddressFromCompany < ActiveRecord::Migration
  def change
    remove_column :companies, :address
  end
end
