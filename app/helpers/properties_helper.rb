module PropertiesHelper
  
  def full_address(property)
    full_address = property.address
    full_address += ", " + property.city unless property.city.blank?
    full_address += ", " + property.state unless property.state.blank?
    full_address += "  " + property.zip unless property.zip.blank?
  end
  
end
