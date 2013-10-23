class CreateInspectionDetails < ActiveRecord::Migration
  def change
    create_table :inspection_details do |t|
      t.string :name
      t.string :status
      t.references :inspection, index: true

      t.timestamps
    end
  end
end
