class Valuable < ActiveRecord::Base
  belongs_to :inspection
  belongs_to :room
  has_many :images, as: :imageable
end
