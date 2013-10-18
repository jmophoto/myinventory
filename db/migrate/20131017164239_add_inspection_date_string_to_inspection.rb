class AddInspectionDateStringToInspection < ActiveRecord::Migration
  def change
    add_column :inspections, :inspection_date_string, :string
  end
end
