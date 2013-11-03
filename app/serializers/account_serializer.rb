class AccountSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_one :logo
end
