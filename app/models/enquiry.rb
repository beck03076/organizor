class Enquiry < ActiveRecord::Base
  include CoreExtension
  
  validates :first_name, on: :create,
            uniqueness: {scope: [:surname,:date_of_birth], 
                         message: " Surname and Date of Birth already exists as another enquiry, please check!" }

  notifiably_audited alert_for: [[[:mobile1,:email1,:surname],"Contact Details","Primary mobile/email is changed for this enquiry"],
                                 [[:assigned_to],"Re-assigned","This Enquiry has been reassigned to you"]],
                                 title: :first_name,
                                 create_comment: "New <<here>> has been created", 
                                 update_comment: "Custom: Values of <<here>> has been updated" 

  mount_uploader :image, HumanImageUploader
  
  belongs_to :branch
  belongs_to :country_of_origin,
             :class_name => "Country",
             :foreign_key => "country_id"
  belongs_to :status, class_name: "EnquiryStatus",foreign_key: "status_id"
  belongs_to :contact_type  
  belongs_to :student_source,:foreign_key => "source_id"
  belongs_to :users, class_name: "User"  
  
  has_many :preferred_countries
  has_many :countries, :through => :preferred_countries  
  has_many :programmes
  has_and_belongs_to_many :emails
  has_many :follow_ups
  has_many :todos
  has_many :notes,foreign_key: "sub_id",:conditions => 'notes.sub_class = "Enquiry"'  
  
  has_many :institutions, through: :programmes
  has_many :institution_city, through: :institutions, foreign_key: "city_id"
  
  scope :inactive,includes(:status,
                           :follow_ups,
                           :country_of_origin).where("enquiry_statuses.name = 'deactivated'")
  scope :active, includes(:status,
                          :follow_ups,
                          :country_of_origin).where("enquiry_statuses.name != 'deactivated'")
                          
  belongs_to :branch
  belongs_to :student_source, foreign_key: 'source_id'
  
  #scope :inactive,includes(:status).where("enquiry_statuses.name = 'deactivated'")
  
  scope :myactive, lambda{|user|
  if user.adm?
    includes(:status,
             :follow_ups,
             :country_of_origin,
             :_ass_to,:_upd_by).where("enquiry_statuses.name != 'deactivated'")
  else
    includes(:status,
             :follow_ups,
             :country_of_origin).where("enquiry_statuses.name != 'deactivated' AND enquiries.assigned_to = #{user.id}")
  end
  }


  
  attr_accessible :emails_attributes,:programmes_attributes,
                  :assigned_by, :assigned_to, :created_by, 
                  :date_of_birth, :email1, :email2, 
                  :first_name, :gender, :mobile1, 
                  :mobile2, :score, :source_id, 
                  :surname, :updated_by,:country_ids,
                  :name,:address,:status_id,:country_id,
                  :follow_ups_attributes,:active,:notes_attributes,
                  :todos_attributes,:contact_type_id,:registered,
                  :image,:remote_image_url,:branch_id
                  
  accepts_nested_attributes_for :programmes,:emails,:follow_ups,:notes,:todos, :allow_destroy => true  
  
  
  def dob
   self.date_of_birth.strftime("%d-%m-%Y") rescue "Not Captured"
  end
  
  def name
    (self.first_name.to_s + ' ' + self.surname.to_s).titleize.strip
  end
  
  def contact_type_name
    self.contact_type.name rescue "Unknown"
  end
  
  def status_name
    self.status.name rescue "Unknown"
  end
  
  def cur_cl
    @current_cl
  end
  
  def country_of_origin_name
    self.country_of_origin.name rescue "Unknown"
  end
  
  def tit
    self.first_name rescue "Title Unknown"
  end
  
  def self.tit
    "Enquiries"
  end
  
  def source_name
    self.student_source.name rescue "Unknown"
  end
  
  def nationality
    self.country_of_origin.name rescue "Unknown"
  end

  def channel
    self.contact_type.name rescue "Unknown"
  end

  def source
    self.student_source.name rescue "Unknown"
  end

  def owner
    self._ato.first_name rescue "Unknown"
  end

  def branch_name
    self.branch.name rescue "Unknown"
  end

  def self.reg(i)
    where(registered: i).size
  end
  
  def self.sco(i)
    where(score: i[0] - 1..i[1] + 1).size
  end

  def self.chart_self_asso(asso,sub_asso_inc,sub_asso_qua)    
    includes(sub_asso_inc).group_by(&asso.to_sym).map {|k,v| [k,v.size] if !k.nil?}.compact       
  end 

end
