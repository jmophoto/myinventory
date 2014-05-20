class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :account_id, :phone_number, :full_name, :agent_status, :agent, :admin, :user_type,
             :display_agent_status
  has_one :account, :address, :company
end
