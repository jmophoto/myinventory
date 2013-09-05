class Room < ActiveRecord::Base
  belongs_to :property
  
  validates :property_id, presence: true
  
  scope :bedrooms, -> { where(room_type: "bedroom") }
  scope :bathrooms, -> { where(room_type: "bathrooms") }
  
  def self.type_count(type)
    where(room_type: type).count
  end
  
end
