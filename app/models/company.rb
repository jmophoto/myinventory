class Company < ActiveRecord::Base
  belongs_to :users
  has_one :address, as: :addressable
  has_one :logo, as: :imageable, class_name: "Image"
  
  after_create :set_up_new_company
  
  def set_up_new_company
    create_address!
  end
  
end
