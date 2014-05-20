class RemoveColumnsFromInspections < ActiveRecord::Migration
  def change
    remove_column :inspections, :address, :string
    remove_column :inspections, :city, :string
    remove_column :inspections, :state, :string
    remove_column :inspections, :zip, :string
  end
end
