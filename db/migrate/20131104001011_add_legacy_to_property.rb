class AddLegacyToProperty < ActiveRecord::Migration
  def change
    add_column :properties, :legacy_id, :integer
    add_column :properties, :description, :string
  end
end
