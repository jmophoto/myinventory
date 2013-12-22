class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :title
      t.decimal :price, precision: 8, scale: 2
      t.integer :inspections_per_month

      t.timestamps
    end
  end
end
