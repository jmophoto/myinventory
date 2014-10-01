class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.string :name
      t.string :code
      t.decimal :full_price
      t.decimal :self_price

      t.timestamps
    end
  end
end
