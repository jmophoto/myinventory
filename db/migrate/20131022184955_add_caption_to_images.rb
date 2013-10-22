class AddCaptionToImages < ActiveRecord::Migration
  def change
    add_column :images, :comment, :string
  end
end
