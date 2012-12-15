class Post < ActiveRecord::Base
  make_voteable
  attr_accessible :description, :latitude, :longitude
  belongs_to :user, :dependent => :destroy
end
