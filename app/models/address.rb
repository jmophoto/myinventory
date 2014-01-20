class Address < ActiveRecord::Base
  belongs_to :addressable, polymorphic: true
  
  after_initialize :set_defaults
  before_save :set_country
  
  def set_defaults
    self.country = "USA"
  end
  
  def set_country
    self.country = self.country || "USA"
  end
  
  def full_address
    full_address = ""
    full_address += "#{self.street1}," unless self.street1.nil?
    full_address += " #{self.street2}," unless self.street2.blank?
    full_address += " #{self.city}," unless self.city.nil?
    full_address += " #{self.state}" unless self.state.nil?
    full_address += "  #{self.zip}" unless self.zip.nil?
  end
  
end
