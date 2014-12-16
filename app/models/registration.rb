class Registration < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :async,
         :recoverable, :rememberable, :trackable, :confirmable


  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :permission_ids
  include CoreModel

  notifiably_audited alert_for: [[[:mobile1,:email,:surname],"Contact Details","Primary mobile/email is changed for this registration"],
                                 [[:assigned_to],"Re-assigned","This registration has been reassigned to you"]],
                                 title: :first_name,
                                 create_comment: "New <<here>> has been created", 
                                 update_comment: "Custom: Values of <<here>> has been updated",
                                 except: [:follow_ups_count,:todos_count,:notes_count,:emails_count]

  before_create :set_ref_no,:set_permissions #:set_password
  after_create :set_enquiry_fields

  validates_uniqueness_of :email
  
  validates :first_name, on: :create,
            uniqueness: {scope: [:surname,:date_of_birth], 
                         message: " Surname and Date of Birth already exists as another registration, please check!" }  
  
  mount_uploader :image, HumanImageUploader
  # ============== Elasticsearch ===============
  include Tire::Model::Search
  include Tire::Model::Callbacks

  settings analysis: {
    filter: {
      ngram_filter: {
        type: "nGram",
        min_gram: 1,
        max_gram: 15
      }
    },
    analyzer: {
      index_ngram_analyzer: {
        tokenizer: "standard",
        filter: ['standard', 'lowercase', "stop", "ngram_filter"],
        type: "custom"
      },
      search_ngram_analyzer: {
        tokenizer: "standard",
        filter: ['standard', 'lowercase', "stop"],
        type: "custom"
      }
    }
  }

  mapping do
      indexes :id, :type => 'integer'
      indexes :date_of_birth, type: 'date',search_analyzer: 'search_ngram_analyzer',index_analyzer: 'index_ngram_analyzer',boost: 100.0      
      [:ref_no,:first_name,:surname,:mobile1,:mobile2,:email,:alternate_email].each do |attribute|
        indexes attribute, :type => 'string',search_analyzer: 'search_ngram_analyzer',index_analyzer: 'index_ngram_analyzer',boost: 100.0
      end
  end
  # ============================================

  #=== BELONGS TO =====
  belongs_to :qualification
  belongs_to :sub_agent,class_name: 'Person',foreign_key: "sub_agent_id", conditions: 'people.sub_agent=TRUE'
  belongs_to :student_source
  belongs_to :contact_type
  belongs_to :country_of_origin,
             :class_name => "Country",
             :foreign_key => "country_id"
  belongs_to :city
  belongs_to :exam_type
  # ==== duplicate of country of origin for reports ===           
  belongs_to :country,
             :class_name => "Country",
             :foreign_key => "country_id"
  # ==== duplicate of country of origin for reports ===
  belongs_to :address_country,
             :class_name => "Country",
             :foreign_key => "address_country_id"
  belongs_to :english_level, foreign_key: 'prof_eng_level_id',class_name: "EnglishLevel"  
  belongs_to :branch
  belongs_to :user, foreign_key: "assigned_to"
  belongs_to :progression_status   
  belongs_to :enquiry       
  #==================
  #=== HAS MANY =====
  has_many :programmes, dependent: :destroy
  has_many :institutions, through: :programmes
  has_many :application_statuses, through: :programmes,:foreign_key => 'app_status_id'
  has_many :course_levels, through: :programmes
  has_many :fee, through: :programmes  
  has_many :exams
  has_many :proficiency_exams,class_name: "Exam", dependent: :destroy  
  has_many :documents, dependent: :destroy
  has_many :users, as: :userable
  has_many :approve_requests, :dependent => :destroy
  #==================
  has_and_belongs_to_many :permissions
  
  attr_accessor :_destroy

  attr_accessible :address_city, :address_country_id, :address_line1, 
  :address_line2, :address_others, :address_post_code, 
  :assigned_by, :assigned_to, :country_id, 
  :course_id, :created_by, :date_of_birth, 
  :email, :alternate_email, :emer_email, 
  :emer_full_name, :emer_mobile, :emer_relationship, 
  :first_name, :flight_airport, :flight_arrival_date, 
  :flight_arrival_time, :flight_no, :gender, 
  :home_phone, :mobile1, :mobile2, 
  :passport_number,:prof_eng_level_id, :prof_exam_id, :qua_exam, 
  :qua_grade, :qua_id, :qua_institution, :qua_score, 
  :qua_subject, :ref_no, :reg_came_through, 
  :reg_direct, :sub_agent_id, 
  :surname, :updated_by, :passport_valid_till, 
  :visa_valid_till, :visa_type, :work_phone,
  :programmes_attributes,:proficiency_exams_attributes,
  :note,:documents_attributes,:_destroy,:enquiry_id,
  :notes_attributes,:image,:remote_image_url,
  :progression_status_id,:branch_id,:assigned_at,
  :impressions_count, :response_time,:registered_by,
  :nationality,:conversion_time,:contact_type_id,
  :student_source_id,:qualification_id,:last_seen_at,
  :direct
  
  accepts_nested_attributes_for :programmes,:proficiency_exams, 
  :documents, :allow_destroy => true


  # ========= delegating _name methods for assoc in array ================
  [:student_source,:branch,:contact_type,
   :english_level,:qualification,:country,
   :address_country,:enquiry,:progression_status,
   :exam_type].each do |assoc|
    delegate :name, to: assoc, prefix: true, allow_nil: true
  end  

  delegate :first_name, to: :sub_agent, prefix: true, allow_nil: true
  alias_method :sub_agent_name, :sub_agent_first_name
  # ======================================================================

  # ========= aliases for methods delegated above ========================
  alias_method :channel, :contact_type_name

  alias_method :nationality, :country_name  

  [:source_name,:source].each do |c|
    alias_method c, :student_source_name
  end

  alias_method :creator, :cby
  alias_method :owner, :ato
  # ======================================================================
  
  
  scope :mine, lambda{|user|
  if user.adm?
   includes(:follow_ups,
            :country_of_origin,
            :branch,
            :progression_status,
            :_ass_to).scoped
  else
   includes(:follow_ups,
            :country_of_origin).where("registrations.branch_id = #{user.branch_id}")
  end
  }

  def set_enquiry_fields
    if !self.enquiry_id.nil?
      enq = Enquiry.find(enquiry_id)
      deact = EnquiryStatus.find_by_name("deactivated").id
      conv_time = (Date.today - enq.created_at.to_date).to_i 
      enq.update_attributes(registered: true,
                            active: false,
                            status_id: deact,
                            registered_at: Date.today,
                            registered_by: self.created_by,
                            conversion_time: conv_time)      
      enq 
    end
  end

  def set_permissions
      self.permissions << Permission.where(subject_class: 'Document')
  end

  def set_ref_no
    # creating new reference number logic
        ref_temp = (Registration.select("max(ref_no) as ref_no").map &:ref_no)[0]
        ref_temp_no = ref_temp.nil? ? "0000" : ref_temp.to_s[4..7]
        ym = Time.now.strftime("%y%m").to_s
        self.ref_no = ym + "%04d" % (ref_temp_no.to_i + 1)
  end

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
  # def set_password
  #   self.password = self.ref_no
  #   self.password_confirmation = self.ref_no
  # end 
  
  def name
    (self.first_name.to_s + ' ' + self.surname.to_s).titleize.strip
  end
  
  def statuses
    self.programmes.includes(:application_status,:institution).map{|i| [i.institution.try(:name),i.application_status.try(:name)]} rescue ""
  end

  def address
    [self.address_line1.to_s,
     self.address_line2.to_s,
     self.address_city.to_s,
     self.address_country.try(:name).to_s,
     self.address_post_code.to_s].join(', ').strip
  end
  
  def tit
    self.first_name rescue "Title Unknown"
  end
  
  def self.tit
    "Registrations"
  end
  
  def nationality=(i)
    self.country_id = i
  end

  def quick_st
    total = self.programmes.size
    j = self.programmes.includes(:application_status).where(application_statuses: {name: "joined"}).size
    [total,j,"joined"]
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
    .group("level_id")
    .select("sum(fees.tuition_fee_cents) as result1,
             sum(fees.commission_paid_cents) as result2,
             sum(fees.commission_amount_cents - fees.commission_paid_cents) as result3,
             registrations.first_name as rname,
             registrations.id as id")
    .order("result2 #{direction}")
    .map {|o| hsh[o.rname] = [o.result1,o.result2,o.result3,o.id]}
    hsh
  end 

end
