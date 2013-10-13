class Image < ActiveRecord::Base
  attr_accessible :desc, :path
  mount_uploader :path, ImageUploader
end
