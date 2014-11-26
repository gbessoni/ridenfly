class ChangeDefaultStatusInReservation < ActiveRecord::Migration
  def change
    change_column_default :reservations, :status, 'active'
  end
end
