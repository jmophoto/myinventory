class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :name
      t.references :property, index: true

      t.timestamps
    end
  end
end
