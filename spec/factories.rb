FactoryGirl.define do
  factory :user do
    first_name "Jason"
    last_name "Olson"
    email "jason@jmophoto.com"
    password "foobar"
    password_confirmation "foobar"
  end
  
  factory :property do
    address "123 Main"
    user
  end
end