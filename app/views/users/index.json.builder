json.array!(@users) do |user|
  json.extract! property, :first_name
  json.url property_url(property, format: :json)
end