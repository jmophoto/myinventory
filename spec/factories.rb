FactoryGirl.define do
  factory :user do
    first_name "Jason"
    last_name "Olson"
    email "jason@jmophoto.com"
    password "foobar"
    password_confirmation "foobar"
  end
end