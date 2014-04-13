# encoding: utf-8
require 'carrierwave/processing/mime_types'

class AssetUploader < CarrierWave::Uploader::Base

  include CarrierWave::RMagick
  include CarrierWave::MimeTypes
  
  process :set_content_type

  storage :file
  # storage :fog

  def store_dir
    "images/#{model.id}"
  end

  version :thumb do
    process :resize_to_limit => [150, 100]
  end
  
  version :small do
    process :resize_to_limit => [300, 200]
  end
  
  version :medium do
    process :resize_to_limit => [600,400]
  end

end
