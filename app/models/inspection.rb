class Inspection < ActiveRecord::Base
  attr_accessor :template, :date_string
  
  has_many :inspected_rooms, -> { includes :inspected_features }
  belongs_to :property
  belongs_to :user
  
  before_save :parse_date
  after_create :add_rooms
  
  default_scope order('inspection_date DESC')
  
  def create_from_template(property_id)
    property = Property.find(property_id)
    self.property_id = property_id
    self.address = property.address
    self.city = property.city
    self.state = property.state
    self.zip = property.zip
  end
  
  def add_rooms
    unless self.property.nil?
      self.property.rooms.each do |room|
        inspected_room = self.inspected_rooms.create!(name: room.name)
        room.features.each do |feature|
          inspected_room.inspected_features.create!(name: feature)
        end
      end
    end
  end
  
  def parse_date
    unless self.date_string == ""
      self.inspection_date = Date.strptime(self.date_string, '%m/%d/%Y')
    end
  end
  
  def full_address
    full_address = self.address
    full_address += " #" + self.unit unless self.unit.blank?
    full_address += ", " + self.city unless self.city.blank?
    full_address += ", " + self.state unless self.state.blank?
    full_address += "  " + self.zip unless self.zip.blank?
  end
    
  
end
