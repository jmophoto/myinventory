json.array!(@properties) do |property|
  json.extract! property, :address, :city, :state, :zip, :user_id
  json.url property_url(property, format: :json)
end