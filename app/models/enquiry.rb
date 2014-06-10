class Enquiry < ActiveRecord::Base  
  include CoreModel
  
  after_create :create_email,:create_follow_up
  
  validates :first_name, on: :create,
            uniqueness: {scope: [:surname,:date_of_birth], 
                         message: " Surname and Date of Birth already exists as another enquiry, please check!" }

  notifiably_audited alert_for: [[[:mobile1,:email1,:surname],"Contact Details","Primary mobile/email is changed for this enquiry"],
                                 [[:assigned_to],"Re-assigned","This Enquiry has been reassigned to you"],
                                 [[:notes_count],"count","Count of notes"]],
                                 title: :first_name,
                                 create_comment: "New <<here>> has been created", 
                                 update_comment: "Custom: Values of <<here>> has been updated" 

  mount_uploader :image, HumanImageUploader

 
  
  belongs_to :branch
  belongs_to :country_of_origin,
             :class_name => "Country",
             :foreign_key => "country_id"
  belongs_to :status, class_name: "EnquiryStatus",foreign_key: "status_id"
  # ========= Duplicate additions will be useful in reports ==============
  belongs_to :enquiry_status, class_name: "EnquiryStatus",foreign_key: "status_id"
  belongs_to :user, class_name: "User",foreign_key: "assigned_to"
  # ======================================================================
  belongs_to :contact_type  
  belongs_to :student_source,:foreign_key => "source_id"   
  
  has_many :preferred_countries
  has_many :countries, :through => :preferred_countries  
  has_many :programmes
  
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
    includes(:branch,
             :status,
             :follow_ups,
             :country_of_origin).where("enquiry_statuses.name != 'deactivated' AND enquiries.branch_id = #{user.branch_id}")
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
                  :image,:remote_image_url,:branch_id,:registered_at,
                  :registered_by,:response_time,:assigned_at,
                  :todos_attributes
                  
  accepts_nested_attributes_for :programmes,:emails,:follow_ups,:notes,:todos, :allow_destroy => true  

  

  def create_email
    if !self.created_by.nil?
      c = User.find(self.created_by).conf
      if c.auto_email_enq
        temp = c.def_create_enquiry_email
          to = c.def_enq_email
          etemp = EmailTemplate.find_by_name(temp)
          smtp = Smtp.find(c.def_from_email)
          self.emails.create!(subject: etemp.subject,
                             body: etemp.body,
                             signature: etemp.signature,
                             to: send(to),
                             smtp_id: smtp.id,
                             from: smtp.name,
                             auto: true)
      end    
    end
  end

  def create_follow_up
    if !self.created_by.nil?
      c = User.find(self.created_by).conf
      if c.auto_cr_f_u
          s = (Date.today + c.def_follow_up_days.to_i)
          self.follow_ups.create!(title: c.def_f_u_name,
                                     desc: c.def_f_u_desc,
                                     event_type_id: c.def_f_u_type,
                                     starts_at: s,
                                     ends_at: s + 1,
                                     assigned_to: c.def_f_u_ass_to,
                                     assigned_by: self.created_by,
                                     auto: true)
      end
    end
  end  
  
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

  def self.bar_chart(cond,asso,asso_name,col,*dummy)
    includes(asso).where(cond).group(["#{asso.to_s.pluralize}.#{asso_name}","enquiries.#{col}"]).count.reject{|k,v| k[0].nil? }
  end  
end
