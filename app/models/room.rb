class Room < ActiveRecord::Base
  belongs_to :property
  
  validates :property_id, presence: true
  
  serialize :features
  
  before_create :add_features
  
  scope :bedrooms, -> { where(room_type: "bedroom") }
  scope :bathrooms, -> { where(room_type: "bathrooms") }
  
  def self.type_count(type)
    where(room_type: type).count
  end
  
  def add_features
    self.features = base_features
    if room_type == "bedroom"
      self.features << bedroom_features
    elsif room_type == "bathroom"
      self.features << bathroom_features
    elsif room_type == "kitchen"
      self.features << kitchen_features
    end
    self.features.flatten!
  end
  
  def base_features
    ['walls', 'baseboards', 'doors', 'floors', 'ceiling', 'light fixtures']
  end
  
  def bedroom_features
    ['windows', 'screens', 'blinds/drapes', 'closets/shelves'] + window_features
  end
  
  def bathroom_features
    ['tub/shower', 'toilet', 'countertop', 'sink', 'cabinets/shelves', 'mirrors', 'fan']
  end
  
  def kitchen_features
    ['fridge', 'range/oven', 'dishwasher', 'disposal', 'countertop', 'sink', 'cabinets/shelves'] + window_features
  end
  
  def window_features
    ['windows', 'screens', 'blinds/drapes']
  end
    
end
