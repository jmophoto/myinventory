json.array!(@images) do |image|
  json.extract! image, :inspection_id, :user_id
  json.url image_url(image, format: :json)
end