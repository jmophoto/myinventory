class Room < ActiveRecord::Base
  belongs_to :property
  
  validates :property_id, presence: true
  
  serialize :features
  
  before_create :load_features
  
  scope :bedrooms, -> { where(room_type: "bedroom") }
  scope :bathrooms, -> { where(room_type: "bathrooms") }
  
  def self.type_count(type)
    where(room_type: type).count
  end
  
  def add_features
    if room_type == "bedroom"
      self.features = base_features + bedroom_features
    elsif room_type == "bathroom"
      self.features = base_features + bathroom_features
    elsif room_type == "kitchen"
      self.features = base_features + kitchen_features
    else
      self.features = base_features
    end
  end
  
  def load_features
    self.features = ROOM_FEATURES[self.room_type]['features'] unless ROOM_FEATURES[self.room_type].nil?
  end
  
  def base_features
    ['walls', 'baseboards', 'doors', 'floors', 'ceiling', 'light fixtures']
  end
  
  def bedroom_features
    ['windows', 'screens', 'blinds/drapes', 'closets/shelves']
  end
  
  def bathroom_features
    ['tub/shower', 'toilet', 'countertop', 'sink', 'cabinets/shelves', 'mirrors', 'fan']
  end
  
  def kitchen_features
    ['fridge', 'range/oven', 'dishwasher', 'disposal', 'countertop', 'sink', 'cabinets/shelves']
  end
  
  def window_features
    ['windows', 'screens', 'blinds/drapes']
  end
    
end
