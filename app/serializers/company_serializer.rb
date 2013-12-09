class CompanySerializer < ActiveModel::Serializer
  attributes :id, :title
  has_one :address
end
