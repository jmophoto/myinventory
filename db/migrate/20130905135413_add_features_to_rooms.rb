class AddFeaturesToRooms < ActiveRecord::Migration
  def change
    add_column :rooms, :features, :text
  end
end
