class AddSiblingIdToReservation < ActiveRecord::Migration
  def change
    add_column :reservations, :sibling_id, :integer

    add_foreign_key :reservations, :reservations, dependent: :delete, column: :sibling_id
  end
end
