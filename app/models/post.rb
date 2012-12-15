class Post < ActiveRecord::Base
  make_voteable
  attr_accessible :description, :latitude, :longitude, :user_id, :avatar, :avatar_image_url
  belongs_to :user
  reverse_geocoded_by :latitude, :longitude

  default_scope order('created_at DESC')

  mount_uploader :avatar, AvatarUploader
end
