class InspectedRoomSerializer < ActiveModel::Serializer
  attributes :id, :name, :inspection_id
  has_many :images
  has_many :inspected_features
end
