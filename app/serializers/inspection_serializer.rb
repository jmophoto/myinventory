class InspectionSerializer < ActiveModel::Serializer
  attributes :id, :inspection_type, :unit, :tenant, :inspected_by, :inspection_date, :address, :city, :state, :zip, :report_date
  has_many :inspected_rooms
  has_many :images
end
