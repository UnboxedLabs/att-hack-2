class Device < ActiveRecord::Base
  attr_accessible :uid
  belongs_to :user

  validates :uid, :uniqueness => true, :presence => true
  # TODO - Whenever a device is created it creates temporary user

end
