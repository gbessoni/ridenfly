class AddCompanyIdToRate < ActiveRecord::Migration
  def change
    add_column :rates, :company_id, :integer
  end
end
