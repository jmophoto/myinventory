class Property < ActiveRecord::Base
  belongs_to :user
  has_many :rooms
  validates :user_id, presence: true
  
  attr_accessor :room_count
  
  serialize :room_count, Hash
  
  def process_rooms(room_count)
    if room_count
      room_count.each do |key, value|
        value.to_i.times { self.rooms.create(name: key.humanize, room_type: key) }
      end
    end
  end

end
