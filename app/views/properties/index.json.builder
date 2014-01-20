json.array!(@properties) do |property|
  json.extract! property, :name
  json.url property_url(property, format: :json)
end