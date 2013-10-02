class Property < ActiveRecord::Base
  belongs_to :user
  has_many :rooms
  has_many :inspections
  validates :user_id, presence: true
  
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
  
  # def check_rooms(room_count)
  #   if room_count
  #    room_count.each do |key, value|
  #      diff = value.to_i - self.rooms.type_count(key)
  #      if diff > 1
  #        (1..diff).collect { |x| self.rooms.create(name: "#{key.humanize} #{x}", room_type: key) }
  #      elsif diff == 1
  #        self.rooms.create(name: key.humanize, room_type: key)
  #      elsif diff < 0
  #        self.rooms.where(:room_type => key).slice!(diff)
  #        self.save!
  #      end     
  #    end
  #   end
  # end

end
