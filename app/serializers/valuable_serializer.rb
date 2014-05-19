class ValuableSerializer < ActiveModel::Serializer
  attributes :id, :name, :serial_number, :inspection_id, :comments
  has_many :images
end
