class AddDetailsToInspection < ActiveRecord::Migration
  def change
    add_column :inspections, :details, :text
  end
end
