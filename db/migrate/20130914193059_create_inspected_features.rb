class CreateInspectedFeatures < ActiveRecord::Migration
  def change
    create_table :inspected_features do |t|
      t.string :name
      t.string :condition
      t.boolean :clean
      t.boolean :marks
      t.boolean :damage
      t.string :comment
      t.references :inspected_room, index: true

      t.timestamps
    end
  end
end
