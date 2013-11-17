class AddMaskedNumberToPaymentMethods < ActiveRecord::Migration
  def change
    add_column :payment_methods, :masked_number, :string
  end
end
