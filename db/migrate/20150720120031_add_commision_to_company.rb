class AddCommisionToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :commission, :decimal, {precision: 8, scale: 2, default: 0.0}
  end
end
