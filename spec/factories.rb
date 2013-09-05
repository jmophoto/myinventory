FactoryGirl.define do
  
  factory :user do
    first_name "Example"
    last_name "User"
    email "user@example.com"
    password "foobar"
    password_confirmation "foobar"
  end
  
  factory :property do
    name "Bachelor Arms"
    user
  end
  
  factory :room do
    name "Bedroom"
    room_type "bedroom"
    property
  end
  
end