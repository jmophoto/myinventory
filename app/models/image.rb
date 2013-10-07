class Image < ActiveRecord::Base
  belongs_to :inspection
  belongs_to :user
  
  mount_uploader :asset, AssetUploader
end
