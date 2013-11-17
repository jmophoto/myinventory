json.array!(@payment_methods) do |payment_method|
  json.extract! payment_method, :id, :cardholder_name, :token, :last_four, :expiration_date, :masked_number, :is_default
  json.url payment_method_url(payment_method, format: :json)
end