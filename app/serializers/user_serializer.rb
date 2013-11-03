class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :account_id
  has_one :account
end
