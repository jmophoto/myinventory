class CreateValuables < ActiveRecord::Migration
  def change
    create_table :valuables do |t|
      t.string :name
      t.string :serial_number
      t.integer :value
      t.references :inspection, index: true

      t.timestamps
    end
  end
end
