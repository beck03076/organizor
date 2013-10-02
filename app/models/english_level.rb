class EnglishLevel < ActiveRecord::Base

  belongs_to :proficieny
  
  attr_accessible :created_by, :desc, :name, :updated_by
end
