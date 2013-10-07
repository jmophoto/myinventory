class AddAssetToImage < ActiveRecord::Migration
  def change
    add_column :images, :asset, :string
  end
end
