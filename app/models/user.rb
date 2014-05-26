class User < ActiveRecord::Base
 # audited
  mount_uploader :image, HumanImageUploader
  after_save :role_changed
  
  
  
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
  has_many :follow_ups, class_name: "FollowUp",foreign_key: "assigned_to"
  
  belongs_to :branch
  
  belongs_to :nationality,
             :class_name => "Country",
             :foreign_key => "country_id"

  has_many :enquiries, foreign_key: "assigned_to"
  has_many :registrations, foreign_key: "assigned_to"
  
  accepts_nested_attributes_for :permissions
  
  def br
    (self.branch.name) + "(#{self.branch.country.name})"  rescue "Unassigned"
  end

  def name
    (self.first_name.to_s + ' ' + self.surname.to_s).titleize.strip rescue "Unknown"
  end

  def fname
    (self.first_name).titleize.strip rescue "Unknown"
  end
  
  def role?(role_sym)
    role.name == role_sym.to_s rescue false
  end 
  
  def active_for_authentication?
    super and self.is_active?
  end
  
  def adm?
    self.role.name == "agency_administrator" rescue false
  end
  
   def update_conf
     self.conf = UserConfig.first.dup
     self.save!
   end
   
  def tit
    self.first_name rescue "Title Unknown"
  end
    
  def prog_fu_ass_to
    User.find(self.conf.def_progression_fu_ass_to).name
  end
  
  def role_name
    self.role.name.titleize rescue "Unassigned"
  end
  
  def branch_name
    self.branch.name.titleize rescue "Unassigned"
  end
  
  def role_changed
    if self.role_id_changed?
      self.permissions << Permission.where(subject_class: "User", action: ["update","read"])
      self.permissions << self.role.permissions
    end
  end
  
  def change_role(role)
    role_name =  role.gsub(/ /,'%')
    r = Role.where("name like '#{role_name}'").first
    self.role = r
    self.save
  end  

  def self.find_by_name(i)
    where(first_name: i).first
  end
end
