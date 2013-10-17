class InspectionSerializer < ActiveModel::Serializer
  attributes :id
  has_many :inspected_rooms
end
