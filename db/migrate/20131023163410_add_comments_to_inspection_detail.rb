class AddCommentsToInspectionDetail < ActiveRecord::Migration
  def change
    add_column :inspection_details, :comment, :string
  end
end
