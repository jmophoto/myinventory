class Property < ActiveRecord::Base
  belongs_to :user
  has_many :rooms
  validates :user_id, presence: true
  
  attr_accessor :room_count
  
  serialize :room_count, Hash
  
  def process_rooms(room_count)
    if room_count
      room_count.each do |key, value|
        if value.to_i == 1
          self.rooms.create(name: key.humanize, room_type: key)
        else
          (1..value.to_i).collect { |x| self.rooms.create(name: "#{key.humanize} #{x}", room_type: key) }
        end
      end
    end
  end

end
