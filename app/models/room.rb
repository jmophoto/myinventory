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
      self.features.merge!(bedroom_features)
    elsif room_type == "bathroom"
      self.features.merge!(bathroom_features)
    elsif room_type == "kitchen"
      self.features.merge!(kitchen_features)
    end
  end
  
  def base_features
    { "base" => ['walls', 'baseboards', 'doors', 'floors', 'ceiling', 'light fixtures'] }
  end
  
  def bedroom_features
    { "bedroom" => ['windows', 'screens', 'blinds/drapes', 'closets/shelves'] }
  end
  
  def bathroom_features
    { "bathroom" => ['tub/shower', 'toilet', 'countertop', 'sink', 'cabinets/shelves', 'mirrors', 'fan'] }
  end
  
  def kitchen_features
    { "kitchen" => ['fridge', 'range/oven', 'dishwasher', 'disposal', 'countertop', 'sink', 'cabinets/shelves'] }
  end
  
  def window_features
    { "kitchen" => ['windows', 'screens', 'blinds/drapes'] }
  end
    
end
