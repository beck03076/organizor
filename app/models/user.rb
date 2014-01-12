class User < ActiveRecord::Base
  audited
  mount_uploader :image, HumanImageUploader
  before_save :default_values
  
  def self.current
    Thread.current[:user]
  end
  def self.current=(user)
    Thread.current[:user] = user
  end
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, 
                  :remember_me,:branch_id, :created_by, 
                  :email_signature, :image, :role_id, 
                  :updated_by,:first_name,:surname,
                  :permission_ids,:role,:gender,
                  :date_of_birth,:address, :remote_image_url,
                  :skype,:facebook,:linkedin,:twitter,:website,:gplus,:blogger,:is_active,
                  :permission_ids,:mobile
                  
  has_one :conf, class_name: "UserConfig"
  has_and_belongs_to_many :permissions
  belongs_to :role
  has_many :invitations, :class_name => self.to_s, :as => :invited_by
  
  belongs_to :_invited_by, class_name: "User",foreign_key: "invited_by_id"
  
  has_many :todos, class_name: "Todo",foreign_key: "assigned_to"
  has_many :emails, class_name: "Email",foreign_key: "created_by"
  
  
  accepts_nested_attributes_for :permissions

  def name
    (self.first_name.to_s + ' ' + self.surname.to_s).titleize.strip
  end
  
  def role?(role_sym)
    role.name == role_sym.to_s
  end 
  
  def active_for_authentication?
    super and self.is_active?
  end
  
  def adm?
    self.role.name == "agency_administrator"
  end
  
   def update_conf
     self.conf = UserConfig.first.dup
     self.save!
   end
   
  def tit
    self.first_name rescue "Title Unknown"
  end
  
  def default_values
    self.permissions << Permission.where(subject_class: "User", action: ["update","read"])
  end

end
