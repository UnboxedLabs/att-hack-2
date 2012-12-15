# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  version :standard do
    process :resize_to_fill => [100, 150, :north]
  end
  version :thumbnail do
    process :scale => [50, 50]
  end


end
