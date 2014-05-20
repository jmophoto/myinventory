class Valuable < ActiveRecord::Base
  belongs_to :inspection
  has_many :images, as: :imageable
end
