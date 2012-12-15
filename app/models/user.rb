class User < ActiveRecord::Base
  make_voter
  attr_accessible :name, :temporary
  has_many :devices
  has_many :posts
end
