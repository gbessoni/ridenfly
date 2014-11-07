class AddForeignKeysToRate < ActiveRecord::Migration
  def change
    add_foreign_key :rates, :airports, dependent: :delete, column: :airport_id
    add_foreign_key :rates, :companies, dependent: :delete, column: :company_id
  end
end
