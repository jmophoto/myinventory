class Address < ActiveRecord::Base
  belongs_to :addressable, polymorphic: true
  
  after_initialize :set_defaults
  before_save :set_country
  
  def update_from_braintree(data)
    if self.street1.blank?
      self.street1 = data[:street_address]
    end
    if self.city.blank?
      self.city = data[:locality]
    end
    if self.state.blank?
      self.state = data[:region]
    end
    if self.zip.blank?
      self.zip = data[:postal_code]
    end
    self.save
  end
  
  def set_defaults
    self.country = "USA"
  end
  
  def set_country
    self.country = self.country || "USA"
  end
  
  def full_address
    full_address = ""
    full_address += "#{self.street1}" unless self.street1.nil?
    full_address += ", #{self.street2}" unless self.street2.blank?
    full_address += ", #{self.city}" unless self.city.nil?
    full_address += ", #{self.state}" unless self.state.nil?
    full_address += "  #{self.zip}" unless self.zip.nil?
    full_address
  end
  
  def city_state
    city_state = ""
    city_state += "#{self.city}" unless self.city.blank?
    city_state += ", #{self.state}" unless self.state.blank?
    city_state
  end
  
  def street_address
    full_address = ""
    full_address += "#{self.street1}" unless self.street1.blank?
    full_address += ", #{self.street2}" unless self.street2.blank?
    full_address
  end
  
end
