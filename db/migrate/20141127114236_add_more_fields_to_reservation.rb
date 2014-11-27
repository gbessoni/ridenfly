class AddMoreFieldsToReservation < ActiveRecord::Migration
  def change
    rename_column :reservations, :num_of_passengers, :adults
    add_column :reservations, :children, :integer, default: 0
    add_column :reservations, :email, :string
    add_column :reservations, :flight_type, :string, default: 'domestic'
  end
end
