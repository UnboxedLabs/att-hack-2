class User < ActiveRecord::Base
  attr_accessible :name, :temporary
  has_many :devices
end
