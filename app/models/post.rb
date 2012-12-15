class Post < ActiveRecord::Base
  attr_accessible :description, :latitude, :longitude
  belongs_to :user, :dependent => :destroy
end
