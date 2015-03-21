class Document < ActiveRecord::Base
  attr_accessible :category_id, :name, :path,
  :registration_id, :remove_path,:contract_id,
  :contract_category_id,:doc_type, :partner_category_id, :partner_id,
  :crop_x, :crop_y, :crop_w, :crop_h

  validates :name, uniqueness: {scope: :registration_id}

  belongs_to :registration
  belongs_to :category,class_name: "DocCategory",foreign_key: "category_id"
  belongs_to :contract_category,class_name: "ContractDocCategory",foreign_key: "contract_category_id"
  belongs_to :partner_category,class_name: "PartnerDocCategory",foreign_key: "partner_category_id"
  belongs_to :contract
  belongs_to :uploader, class_name: "User", foreign_key: "created_by"

  mount_uploader :path, DocumentUploader

  before_create :default_name
  after_update :reprocess_profile, :if => :cropping?

  def default_name
    self.name = File.basename(path.filename) if path
  end

  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end

  def profile_geometry
    img = Magick::Image::read(self.path.current_path).first
    @geometry = {:width => img.columns, :height => img.rows }
  end

  def img?
    if %w(jpg jpeg png gif JPG JPEG PNG GIF).include?(path.file.extension)
      true
    else
      false
    end
  end

  private

  def reprocess_profile
    self.path.recreate_versions!
  end

end
