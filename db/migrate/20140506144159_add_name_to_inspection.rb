class AddNameToInspection < ActiveRecord::Migration
  def change
    add_column :inspections, :name, :string
  end
end
