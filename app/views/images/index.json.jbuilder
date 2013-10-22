json.array!(@images) do |image|
  json.extract! image, :id, :asset, :comment
  json.url image_url(image, format: :json)
end