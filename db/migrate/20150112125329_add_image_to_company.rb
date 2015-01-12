class AddImageToCompany < ActiveRecord::Migration
  def up
    add_attachment :companies, :image
  end

  def down
    remove_attachment :companies, :image
  end
end
