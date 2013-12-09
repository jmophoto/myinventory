class AddPhoneEmailToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :email, :string
    add_column :companies, :phone_number, :string
  end
end
