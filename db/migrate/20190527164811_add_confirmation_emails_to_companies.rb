class AddConfirmationEmailsToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :confirmation_emails, :string
  end
end
