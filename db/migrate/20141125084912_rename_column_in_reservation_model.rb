class RenameColumnInReservationModel < ActiveRecord::Migration
  def change
    rename_column :reservations, :service_type, :trip_direction
  end
end
