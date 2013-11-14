class CreatePaymentMethods < ActiveRecord::Migration
  def change
    create_table :payment_methods do |t|
      t.references :user, index: true
      t.string :last_four
      t.string :token
      t.datetime :expiration_date
      
      t.timestamps
    end
  end
end
