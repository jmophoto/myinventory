json.array!(@companies) do |company|
  json.extract! company, :title
  json.url company_url(company, format: :json)
end