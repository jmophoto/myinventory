class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.references :user, index: true
      t.datetime :start_date
      t.datetime :end_date
      t.string :subscription_id
      t.string :subscription_type

      t.timestamps
    end
  end
end
