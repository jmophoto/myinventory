class Address < ActiveRecord::Base
  belongs_to :addressable, polymorphic: true
  
  before_save :set_country
  
  def set_country
    self.country = self.country || "USA"
  end
  
end
