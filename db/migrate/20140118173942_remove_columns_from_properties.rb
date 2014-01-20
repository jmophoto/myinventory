class RemoveColumnsFromProperties < ActiveRecord::Migration
  def change
    remove_column :properties, :address, :string
    remove_column :properties, :city, :string
    remove_column :properties, :state, :string
    remove_column :properties, :zip, :string
  end
end
