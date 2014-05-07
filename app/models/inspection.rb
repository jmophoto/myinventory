class Inspection < ActiveRecord::Base
  attr_accessor :template, :date_string
  
  has_many :inspected_rooms, -> { includes :inspected_features }
  has_many :inspected_features, through: :inspected_rooms
  has_many :inspection_details
  has_many :valuables
  belongs_to :property
  belongs_to :user
  has_many :images, as: :imageable
  has_one :address, as: :addressable
  
  serialize :details, Hash
  
  accepts_nested_attributes_for :images, allow_destroy: true
  accepts_nested_attributes_for :address
  
  # before_save :parse_date
  after_create :add_rooms
  # after_create :add_details
  
  default_scope order('inspection_date DESC')
  
  def display_type
    if inspection_type == "self"
      "Self-Completed"
    elsif inspection_type == "agent"
      "Agent-Completed"
    else
      ""
    end
  end
  
  def create_from_template(property_id)
    property = Property.find(property_id)
    self.property_id = property_id
    self.address = property.address.dup
  end
  
  def add_rooms
    unless self.property.nil?
      self.property.rooms.each do |room|
        inspected_room = self.inspected_rooms.create!(name: room.name)
        # room.features.each do |feature|
        #   inspected_room.inspected_features.create!(name: feature)
        # end
      end
    end
  end
  
  def add_details
    if !self.property.nil? && !self.property.details.nil?
      self.property.details.each do |detail|
        self.inspection_details.create!(name: detail)
      end
    end
  end
  
  def parse_date
    if self.date_string
      unless self.date_string == ""
        self.inspection_date = Date.strptime(self.date_string, '%m/%d/%Y')
      end
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
