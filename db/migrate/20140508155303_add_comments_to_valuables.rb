class AddCommentsToValuables < ActiveRecord::Migration
  def change
    add_column :valuables, :comments, :string
  end
end
