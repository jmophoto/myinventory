class AddColumnsToInspection < ActiveRecord::Migration
  def change
    add_column :inspections, :address, :string
    add_column :inspections, :city, :string
    add_column :inspections, :state, :string
    add_column :inspections, :zip, :string
  end
end
