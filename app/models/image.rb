class Image < ActiveRecord::Base
  belongs_to :imageable, polymorphic: true
  
  mount_uploader :asset, AssetUploader
  
  def thumb_url
    asset.url(:thumb)
  end
  
  def small_url
    asset.url(:small)
  end
  
end
