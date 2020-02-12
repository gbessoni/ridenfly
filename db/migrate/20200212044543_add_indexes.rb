class AddIndexes < ActiveRecord::Migration
  def change
    # add_foreign_key :companies, :users
    add_index :companies, :user_id

    add_index :payments, :company_id
    add_index :payments, :from
    add_index :payments, :to

    add_index :rate_pickup_times, %i[rate_id direction]

    add_index :rates, :airport_id
    add_index :rates, :company_id

    add_index :reservations, :rate_id
    add_index :reservations, :sibling_id
    add_index :reservations, :created_at, order: { created_at: :desc }
    add_index :reservations, :pickup_datetime # for payments
  end
end
