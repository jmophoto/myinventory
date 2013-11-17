class AddIsDefaultToPaymentMethods < ActiveRecord::Migration
  def change
    add_column :payment_methods, :is_default, :boolean
  end
end
