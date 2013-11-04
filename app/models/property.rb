class Property < ActiveRecord::Base
  belongs_to :user
  has_many :rooms
  has_many :inspections
  has_many :images, as: :imageable
  
  # validates :user_id, presence: true
  
  attr_accessor :room_count, :other_areas, :detail_list
  
  serialize :room_count, Hash
  serialize :details
  
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
  
  def process_other_areas(other_areas)
    if other_areas
      other_areas.each do |key, value|
        self.rooms.create(name: key.humanize, room_type: key)
      end
    end
  end
  
end
