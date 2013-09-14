class Property < ActiveRecord::Base
  belongs_to :user
  has_many :rooms
  has_many :inspections
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
  
  def check_rooms(room_count)
    if room_count
     room_count.each do |key, value|
       diff = value.to_i - self.rooms.type_count(key)
       if diff > 1
         (1..diff).collect { |x| self.rooms.create(name: "#{key.humanize} #{x}", room_type: key) }
       elsif diff == 1
         self.rooms.create(name: key.humanize, room_type: key)
       elsif diff < 0
         self.rooms.slice!(diff)
       end     
     end
    end
  end

end
