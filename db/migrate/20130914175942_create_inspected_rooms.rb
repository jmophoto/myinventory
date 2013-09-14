class CreateInspectedRooms < ActiveRecord::Migration
  def change
    create_table :inspected_rooms do |t|
      t.string :name
      t.references :inspection, index: true

      t.timestamps
    end
  end
end
