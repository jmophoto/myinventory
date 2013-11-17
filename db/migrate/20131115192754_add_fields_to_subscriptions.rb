class AddFieldsToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :next_billing_date, :datetime
    add_column :subscriptions, :next_billing_period_amount, :decimal
    add_column :subscriptions, :payment_method_token, :string
  end
end
