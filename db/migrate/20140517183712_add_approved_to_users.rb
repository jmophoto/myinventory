class AddApprovedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :agent_status, :string
  end
end
