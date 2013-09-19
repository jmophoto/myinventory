class InspectedRoom < ActiveRecord::Base
  belongs_to :inspection
  has_many :inspected_features
  
  before_create :check_for_name
  after_create :add_features
  
  def check_for_name
    if self.name.nil?
      if self.room_type.nil? || self.room_type == "base"
        self.name = "New Room"
      else
        self.name = "New #{self.room_type.humanize}"
      end
    end
  end
  
  def add_features
    if room_type == "bedroom"
      features = base_features + bedroom_features
    elsif room_type == "bathroom"
      features = base_features + bathroom_features
    elsif room_type == "kitchen"
      features = base_features + kitchen_features
    else
      features = base_features
    end
    self.create_inspected_features(features)
  end
  
  def create_inspected_features(features)
    features.each do |feature|
      self.inspected_features.create!(:name => feature)
    end
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
