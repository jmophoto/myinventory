class Company < ActiveRecord::Base
  belongs_to :users
  has_one :address, as: :addressable
  has_many :images, as: :imageable
  has_one :logo, class_name: "Image"
  
  after_create :set_up_new_company
  
  def set_up_new_company
    create_address!
  end
  
end
