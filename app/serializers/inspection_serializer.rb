class InspectionSerializer < ActiveModel::Serializer
  attributes :id, :name, :inspection_type, :unit, :tenant, :inspected_by, :inspection_date, :report_date, :agent_id, :status, :completed_by
  has_one :address
  has_many :inspected_rooms
  has_many :valuables
  has_many :images
  has_many :inspection_details
  has_one :agent
  has_one :user
end
