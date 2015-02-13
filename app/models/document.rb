class Document < ActiveRecord::Base
  attr_accessible :category_id, :name, :path,
  :registration_id, :remove_path,:contract_id,
  :contract_category_id,:doc_type
  validates :name, uniqueness: {scope: :registration_id}

  belongs_to :registration
  belongs_to :category,class_name: "DocCategory",foreign_key: "category_id"
  belongs_to :contract_category,class_name: "ContractDocCategory",foreign_key: "contract_category_id"
  belongs_to :partner_category,class_name: "PartnerDocCategory",foreign_key: "partner_category_id"
  belongs_to :contract
  belongs_to :uploader, class_name: "User", foreign_key: "created_by"

  mount_uploader :path, DocumentUploader

  before_create :default_name

  def default_name
    self.name = File.basename(path.filename) if path
  end
end
