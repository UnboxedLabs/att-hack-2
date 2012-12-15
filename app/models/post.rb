class Post < ActiveRecord::Base
  make_voteable
  attr_accessible :description, :latitude, :longitude, :user_id
  belongs_to :user, :dependent => :destroy
end
