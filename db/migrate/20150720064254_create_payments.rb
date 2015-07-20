class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :company_id
      t.datetime :from
      t.datetime :to
      t.decimal :amount, precision: 8, scale: 2
      t.boolean :paid, default: false
      t.decimal :net_commission, precision: 8, scale: 2

      t.timestamps
    end

    add_foreign_key :payments, :companies, dependent: :delete, column: :company_id
  end
end
