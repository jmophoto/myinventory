json.array!(@images) do |image|
  json.extract! image, :id, :asset
  json.url image_url(image, format: :json)
end