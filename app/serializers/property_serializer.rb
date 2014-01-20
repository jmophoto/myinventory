class PropertySerializer < ActiveModel::Serializer
  attributes :id, :name, :details, :description, :room_count
  has_one :address
  has_many :rooms
end
