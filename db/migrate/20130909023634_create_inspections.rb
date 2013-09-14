class CreateInspections < ActiveRecord::Migration
  def change
    create_table :inspections do |t|
      t.string :inspection_type
      t.string :unit
      t.string :tenant
      t.string :inspected_by
      t.datetime :inspection_date

      t.timestamps
    end
  end
end
