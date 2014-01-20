class Property < ActiveRecord::Base
  belongs_to :user
  has_many :rooms
  has_many :inspections
  has_many :images, as: :imageable
  has_one :address, as: :addressable
  
  # validates :user_id, presence: true
  
  attr_accessor :room_count, :other_areas, :detail_list
  
  serialize :room_count, Hash
  serialize :details
  
  accepts_nested_attributes_for :address
  
  def process_rooms(room_count)
    if room_count
      room_count.each do |room|
        if room['count'].to_i == 1
          self.rooms.create(name: room['name'], room_type: room['type'])
        else
          (1..room['count'].to_i).collect { |x| self.rooms.create(name: "#{room['name']} #{x}", room_type: room['type']) }
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
