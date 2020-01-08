class AddSubStatusAndNotesToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :sub_status, :string
    add_column :reservations, :notes, :string
  end
end
