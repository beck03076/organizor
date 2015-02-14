class Partner < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,:async,
         :recoverable, :rememberable, :trackable,
         :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  include CoreModel

  before_create :set_permissions #:set_password

  validates_uniqueness_of :name, on: :create, message: " already exists as another partner, please check!"
  validates_uniqueness_of :email, on: :create, message: " for the partner is already exists, please check!"

  mount_uploader :image, HumanImageUploader
  # ============== Elasticsearch ===============
  include Tire::Model::Search
  include Tire::Model::Callbacks
  mapping do
      indexes :id, :type => 'integer'
      [:name,:email,:phone,:website,:address_line1,:address_line2,:address_post_code].each do |attribute|
        indexes attribute, :type => 'string'
      end
  end
  # ============================================

  belongs_to :type, class_name: 'PartnerType', foreign_key: 'type_id'
  belongs_to :group, class_name: 'PartnerGroup', foreign_key: 'group_id'
  belongs_to :category, class_name: 'PartnerCategory', foreign_key: 'category_id'
  belongs_to :country
  belongs_to :city
  belongs_to :person

  # ==== Duplicates for Reports ============================================
  belongs_to :partner_type, class_name: 'PartnerType', foreign_key: 'type_id'
  belongs_to :partner_group, class_name: 'PartnerGroup', foreign_key: 'group_id'
  # ========================================================================

  has_many :people
  has_many :contracts
  has_many :programmes,dependent: :destroy
  has_many :registrations, through: :programmes
  has_many :enquiries, through: :programmes
  has_many :application_statuses, through: :programmes,:foreign_key => 'app_status_id'
  has_many :course_levels, through: :programmes
  has_many :fee, through: :programmes
  has_many :users, as: :userable
  has_many :documents, dependent: :destroy
  has_and_belongs_to_many :permissions

  attr_accessible :city_id, :country_id, :created_by,
  :name, :poc, :type_id,
  :updated_by,:contracts_attributes,:people_attributes,
  :image,:remote_image_url,:email,
  :website, :address_line1, :address_post_code,
  :desc, :phone, :fax,
  :address_line2,:assigned_to,:assigned_by,:prohibited_country_ids,:prohibited_region_ids,
  :permitted_country_ids,:permitted_region_ids,:group_id,:assigned_at,
  :person_id, :category_id, :documents_attributes

  accepts_nested_attributes_for :contracts,:people,:documents,:allow_destroy => true

    # ========= delegating _name methods for assoc in array ================
  [:country,:city,:type,:group,:person].each do |assoc|
    delegate :name, to: assoc, prefix: true, allow_nil: true
  end
  # ======================================================================
  # ========= aliases for methods delegated above ========================
  alias_method :poc, :person_name
  alias_method :creator, :cby
  alias_method :owner, :ato
  # ======================================================================


  # new function to set the password without knowing the current password used in our confirmation controller.
  def attempt_set_password(params)
    p = {}
    p[:password] = params[:password]
    p[:password_confirmation] = params[:password_confirmation]
    update_attributes(p)
  end
  # new function to return whether a password has been set
  def has_no_password?
    self.encrypted_password.blank?
  end

  def only_if_unconfirmed
    pending_any_confirmation {yield}
  end

  def tit
    self.name rescue "Title Unknown"
  end

  # def set_password
  #   self.password = self.email
  #   self.password_confirmation = self.email
  # end

  def set_permissions
    self.permissions << Permission.where(subject_class: "Student",action: "read")
  end

  def my_enqs(user_id)
    self.enquiries.where(assigned_to: user_id)
  end

  def my_regs(user_id)
    self.registrations.where(assigned_to: user_id)
  end

  def my_peos(user_id)
    self.people.where(assigned_to: user_id)
  end

  def self.bar_chart(cond,asso,asso_name,sub_asso,cat1,cat2)
    c1 = cat1.to_s.pluralize
    cats = cat1.to_s.camelize.constantize.all.map &cat2
    includes(asso,
             sub_asso).where(cond).where(c1.to_sym =>
                             {cat2 => cats}).group(["#{asso.to_s.pluralize}.#{asso_name}","#{c1}.name"]).count.reject{|k,v| k[0].nil? }
  end


  def self.total_fee_commission(ids,direction)
    hsh = {}
    joins(programmes: [:fee])
    .where(fees: {id: ids})
    .group("partner_id")
    .select("sum(fees.tuition_fee_cents) as result1,
             sum(fees.commission_paid_cents) as result2,
             sum(fees.commission_amount_cents - fees.commission_paid_cents) as result3,
             partners.name as name,
             partners.id as id")
    .order("result2 #{direction}")
    .map {|o| hsh[o.name] = [o.result1,o.result2,o.result3,o.id]}
    hsh
  end

  def self.total_commission_paid_cents(ids)
    where(id: ids).joins(programmes: [:fee]).group("partner_id").sum("fees.commission_paid_cents")
  end

  def self.sta(i)
    self.h_chart(:application_statuses,i)
  end

  def self.cou(i)
    self.h_chart(:course_levels,i)
  end

  def self.h_chart(i,j)
    includes(i).where({i =>  {name: j}}).size
  end

end