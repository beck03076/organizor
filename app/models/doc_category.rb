class DocCategory < ActiveRecord::Base
  attr_accessible :desc, :name
  has_many :documents
end
