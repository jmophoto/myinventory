class AddressSerializer < ActiveModel::Serializer
  attributes :id, :street1, :street2, :city, :state, :zip, :country, :full_address
end
