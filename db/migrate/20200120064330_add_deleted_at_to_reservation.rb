class AddDeletedAtToReservation < ActiveRecord::Migration
  def change
    %w[
      reservations airports companies payments
      rates users company_vehicle_types
    ].each do |table_name|
      add_column table_name, :deleted_at, :datetime
      add_index table_name, :deleted_at
    end
  end
end
