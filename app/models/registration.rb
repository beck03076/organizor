class Registration < ActiveRecord::Base
  include CoreModel

  notifiably_audited alert_for: [[[:mobile1,:email1,:surname],"Contact Details","Primary mobile/email is changed for this registration"],
                                 [[:assigned_to],"Re-assigned","This registration has been reassigned to you"]],
                                 title: :first_name,
                                 create_comment: "New <<here>> has been created", 
                                 update_comment: "Custom: Values of <<here>> has been updated",
                                 except: [:follow_ups_count,:todos_count,:notes_count,:emails_count]

  before_create :set_ref_no
  after_create :set_enquiry_fields
  
  validates :first_name, on: :create,
            uniqueness: {scope: [:surname,:date_of_birth], 
                         message: " Surname and Date of Birth already exists as another registration, please check!" }  
  
  mount_uploader :image, HumanImageUploader
  belongs_to :qualification, foreign_key: 'qua_id'


  has_many :programmes, dependent: :destroy
  has_many :institutions, through: :programmes
  has_many :application_statuses, through: :programmes,:foreign_key => 'app_status_id'
  has_many :course_levels, through: :programmes
  has_many :fee, through: :programmes
  
  has_many :exams
  has_many :proficiency_exams,class_name: "Exam", dependent: :destroy
  belongs_to :sub_agent
  belongs_to :student_source, foreign_key: 'reg_source_id'  
  
  has_many :documents, dependent: :destroy
  
   belongs_to :country_of_origin,
             :class_name => "Country",
             :foreign_key => "country_id"
   belongs_to :address_country,
             :class_name => "Country",
             :foreign_key => "address_country_id"
             
  belongs_to :english_level, foreign_key: 'prof_eng_level_id',class_name: "EnglishLevel"
  
  belongs_to :branch
  belongs_to :user, foreign_key: "assigned_to"
  belongs_to :progression_status

    
  attr_accessor :_destroy

  attr_accessible :address_city, :address_country_id, :address_line1, 
  :address_line2, :address_others, :address_post_code, 
  :assigned_by, :assigned_to, :country_id, 
  :course_id, :created_by, :date_of_birth, 
  :email1, :email2, :emer_email, 
  :emer_full_name, :emer_mobile, :emer_relationship, 
  :first_name, :flight_airport, :flight_arrival_date, 
  :flight_arrival_time, :flight_no, :gender, 
  :home_phone, :mobile1, :mobile2, 
  :passport_number,:prof_eng_level_id, :prof_exam_id, :qua_exam, 
  :qua_grade, :qua_id, :qua_institution, :qua_score, 
  :qua_subject, :ref_no, :reg_came_through, 
  :reg_direct, :reg_source_id, :sub_agent_id, 
  :surname, :updated_by, :passport_valid_till, 
  :visa_valid_till, :visa_type, :work_phone,
  :programmes_attributes,:proficiency_exams_attributes,
  :note,:documents_attributes,:_destroy,:enquiry_id,
  :notes_attributes,:image,:remote_image_url,
  :progression_status_id,:branch_id,:assigned_at,
  :impressions_count, :response_time,:registered_by,
  :nationality,:todos_attributes
  
  accepts_nested_attributes_for :programmes,:emails,:follow_ups,
  :notes,:todos,:proficiency_exams, 
  :documents, :allow_destroy => true
  
  
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
      conv_time = (enq.registered_at.to_date - created_at.to_date).to_i 
      enq.update_attributes(registered: true,
                            active: false,
                            status_id: deact,
                            registered_at: Date.today,
                            registered_by: self.created_by,
                            conversion_time: conv_time)      
      enq 
    end
  end

  def set_ref_no
    # creating new reference number logic
        ref_temp = (Registration.select("max(ref_no) as ref_no").map &:ref_no)[0]
        ref_temp_no = ref_temp.nil? ? "0000" : ref_temp.to_s[4..7]
        ym = Time.now.strftime("%y%m").to_s
        self.ref_no = ym + "%04d" % (ref_temp_no.to_i + 1)
  end

  def self.sco(i)
  end
   
  
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
  
  def country_of_origin_name
    self.country_of_origin.name rescue "Unknown"
  end
  
  def qualification_name
    self.qualification.name rescue "Unknown"
  end
  
  def english_level_name
    self.english_level.name rescue "Unknown"
  end
  
  def address_country_name
    self.address_country.name rescue "Unknown"
  end
  
  def tit
    self.first_name rescue "Title Unknown"
  end
  
  def self.tit
    "Registrations"
  end
  
  def a_city
   self.address_city.name rescue "unknown"  
  end
  
  def a_country
   self.address_country.name rescue "unknown"  
  end
  
  def nationality
    country_of_origin.name rescue "Unknown"
  end

  def nationality=(i)
    self.country_id = i
  end
  
  def source
    self.student_source.name rescue "Unknown"
  end
  
  def quick_st
    total = self.programmes.size
    j = self.programmes.includes(:application_status).where(application_statuses: {name: "joined"}).size
    [total,j,"joined"]
  end

  def branch_name
    self.branch.name rescue "Unknown"
  end

  def owner
    self._ato.first_name rescue "Unknown"
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

end
