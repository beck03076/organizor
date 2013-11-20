class Student < ActiveRecord::Base
  attr_accessible :creator, :name, :updator
  
  belongs_to :createdby, class_name: "People", foreign_key: "creator"
  belongs_to :updatedby, class_name: "People", foreign_key: "updator"
end
