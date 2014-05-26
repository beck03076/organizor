class SavedReport < ActiveRecord::Base
  
  attr_accessible :created_by, :desc, :name, :q, :heading, :module
end
