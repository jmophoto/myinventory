class ChangePlanIdInSubscriptions < ActiveRecord::Migration
  def self.up
   remove_column :subscriptions, :plan_id, :string
   add_column :subscriptions, :plan_id, :integer
  end

  def self.down
    remove_column :subscriptions, :plan_id, :integer
    add_column :subscriptions, :plan_id, :string
  end
end
