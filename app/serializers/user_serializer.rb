class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :account_id, :phone_number
  has_one :account, :address, :company
end
