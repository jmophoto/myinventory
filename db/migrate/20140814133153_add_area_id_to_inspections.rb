class AddAreaIdToInspections < ActiveRecord::Migration
  def change
    add_column :inspections, :area_id, :integer
  end
end
