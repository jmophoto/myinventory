class Account < ActiveRecord::Base
  
  has_many :users
  has_one :logo, as: :imageable, class_name: "Image"
  
end
