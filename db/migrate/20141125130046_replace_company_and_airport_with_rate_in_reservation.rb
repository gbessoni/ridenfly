class ReplaceCompanyAndAirportWithRateInReservation < ActiveRecord::Migration
  def up
    remove_foreign_key(:reservations, name: 'reservations_airport_id_fk')
    remove_foreign_key(:reservations, name: 'reservations_company_id_fk')

    remove_column :reservations, :airport_id, :integer
    remove_column :reservations, :company_id, :integer

    add_column :reservations, :rate_id, :integer
    add_foreign_key :reservations, :rates, dependent: :delete, column: :rate_id
  end

  def down
    remove_foreign_key(:reservations, name: 'reservations_rate_id_fk')
    remove_column :reservations, :rate_id, :integer

    add_column :reservations, :airport_id, :integer
    add_column :reservations, :company_id, :integer

    add_foreign_key :reservations, :airports, dependent: :delete, column: :airport_id
    add_foreign_key :reservations, :companies, dependent: :delete, column: :company_id
  end
end
