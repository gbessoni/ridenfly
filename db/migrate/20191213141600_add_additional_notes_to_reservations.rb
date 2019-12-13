class AddAdditionalNotesToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :additional_notes, :string
  end
end
