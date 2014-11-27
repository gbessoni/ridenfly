class RenameAddressColumnInReservation < ActiveRecord::Migration
  def change
    rename_column :reservations, :addresss, :address
  end
end

