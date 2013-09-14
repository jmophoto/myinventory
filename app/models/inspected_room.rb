class InspectedRoom < ActiveRecord::Base
  belongs_to :inspection
  has_many :inspected_features
end
