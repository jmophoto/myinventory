class AddDetailsToProperty < ActiveRecord::Migration
  def change
    add_column :properties, :details, :text
  end
end
