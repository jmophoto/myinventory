class AddRoomTypeToInspectedRooms < ActiveRecord::Migration
  def change
    add_column :inspected_rooms, :room_type, :string
  end
end
