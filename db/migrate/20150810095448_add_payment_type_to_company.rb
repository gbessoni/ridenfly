class AddPaymentTypeToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :payment_type, :string
  end
end
