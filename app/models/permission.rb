class Permission < ActiveRecord::Base
  has_and_belongs_to_many :registrations
  has_and_belongs_to_many :institutions
  has_and_belongs_to_many :users
  has_and_belongs_to_many :roles
  attr_accessible :action, :description, :name, :subject_class, :subject_id, :user_id,:subject_var

  def self.registrations
  	where(name: ["update_registrations","upload_documents","download_documents",
  		           "read_documents","update_documents","delete_documents","approve_registrations",
  		           "update_doc_categories","create_comments"]).all
  end
end
