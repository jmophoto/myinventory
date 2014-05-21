class AddCompletedByToInspections < ActiveRecord::Migration
  def change
    add_column :inspections, :completed_by, :string
  end
end
