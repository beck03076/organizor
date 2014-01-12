class AllowIp < ActiveRecord::Base
  attr_accessible :desc, :from, :to
end
