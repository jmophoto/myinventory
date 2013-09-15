class Inspection < ActiveRecord::Base
  attr_accessor :template, :date_string
  
  has_many :inspected_rooms
  belongs_to :property
  
  after_create :add_rooms
  
  def create_from_template(property_id)
    property = Property.find(property_id)
    self.property_id = property_id
    self.address = property.address
    self.city = property.city
    self.state = property.state
    self.zip = property.zip
  end
  
  def add_rooms
    self.property.rooms.each do |room|
      inspected_room = self.inspected_rooms.create!(name: room.name)
      room.features.each do |feature|
        inspected_room.inspected_features.create!(name: feature)
      end
    end
  end
    
end
