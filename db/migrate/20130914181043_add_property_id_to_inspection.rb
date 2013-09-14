class AddPropertyIdToInspection < ActiveRecord::Migration
  def change
    add_column :inspections, :property_id, :integer
  end
end
