class AddAgentIdToInspections < ActiveRecord::Migration
  def change
    add_column :inspections, :agent_id, :integer
  end
end
