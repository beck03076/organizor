class Smtp < ActiveRecord::Base
  has_many :emails  
  
  attr_accessible :address, :authentication, :created_by, 
  :domain, :enable_starttls_auto, :name, 
  :password, :port, :updated_by, :user_name
  
  
  
end
