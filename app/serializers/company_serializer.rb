class CompanySerializer < ActiveModel::Serializer
  attributes :id, :title, :email, :phone_number
  has_one :address
end
