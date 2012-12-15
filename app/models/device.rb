class Device < ActiveRecord::Base
  attr_accessible :uid
  belongs_to :user, :dependent => :destroy

  # TODO - Whenever a device is created it creates temporary user

end
