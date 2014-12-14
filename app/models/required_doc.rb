class RequiredDoc < ActiveRecord::Base
  attr_accessible :created_at, :name, :updated_at, :desc
  has_many :required_doc_types


  def cname
  	name.titleize
  end
end
