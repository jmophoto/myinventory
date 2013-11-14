class AddCardholderNameToPaymentMethod < ActiveRecord::Migration
  def change
    add_column :payment_methods, :cardholder_name, :string
    add_column :payment_methods, :default, :boolean
  end
end
