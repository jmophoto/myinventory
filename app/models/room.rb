class Room < ActiveRecord::Base
  belongs_to :property
  
  scope :bedrooms, -> { where(room_type: "bedroom") }
  scope :bathrooms, -> { where(room_type: "bathrooms") }
end
