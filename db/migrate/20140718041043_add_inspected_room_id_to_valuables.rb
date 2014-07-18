class AddInspectedRoomIdToValuables < ActiveRecord::Migration
  def change
    add_column :valuables, :inspected_room_id, :integer
  end
end
