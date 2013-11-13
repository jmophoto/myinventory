class ChangeCommentType < ActiveRecord::Migration
  def self.up
   change_column :inspection_details, :comment, :text
   change_column :images, :comment, :text
   change_column :images, :asset, :text
   change_column :inspected_features, :comment, :text
  end

  def self.down
   change_column :inspection_details, :comment, :string
   change_column :images, :comment, :string
   change_column :images, :asset, :string
   change_column :inspected_features, :comment, :string
  end
end
