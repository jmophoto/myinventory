class InspectedRoomSerializer < ActiveModel::Serializer
  attributes :id, :name, :inspection_id, :room_type
  has_many :images
  has_many :inspected_features
end
