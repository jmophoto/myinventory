class CompanySerializer < ActiveModel::Serializer
  attributes :id, :title, :email, :phone_number
  has_one :address
  has_one :logo
  has_many :images
end
