class Programme < ActiveRecord::Base
  include CoreModel
  
  validates :registration_id, on: :create,
            uniqueness: {scope: [:institution_id,:level_id], 
                         message: "with same Institution and CourseLevel already exsits!" }  

  validates_presence_of :start_date, on: :create

  belongs_to :enquiry
  belongs_to :registration
  belongs_to :course_level, :foreign_key => 'level_id'   
  belongs_to :institution
  belongs_to :country
  belongs_to :city
  belongs_to :ins_type, class_name: "InstitutionType",:foreign_key => 'type_id'
  belongs_to :course_subject, :foreign_key => 'subject_id'
  belongs_to :application_status,:foreign_key => 'app_status_id'
  belongs_to :claim_status,:foreign_key => 'claim_status_id', class_name: "CommissionClaimStatus"
  
  has_many :status_diagrams
  
  has_one :fee
  
  has_many :commissions, through: :fee
  
  monetize :p_fee_cents, :allow_nil => true
  
  belongs_to :p_fee_type, :foreign_key => 'p_fee_id', class_name: "ProcessingFeeType"
  belongs_to :p_fee_status, :foreign_key => 'p_fee_status_id', class_name: "ProcessingFeeStatus"
  

  attr_accessible :city_id, :country_id, :created_by, 
                  :end_date, :enquiry_id, :institution_id, 
                  :level_id, :start_date, :subject_id, 
                  :type_id, :updated_by, :course_subject,
                  :app_status_id,:ins_ref_no,:registration_id,
                  :course_subject_text,:notes_attributes,
                  :fee_attributes,:claim_status_id,
                  :p_fee_id,:p_fee_status_id,:p_fee_cents,
                  :currency,:p_fee,:p_fee_bank_details
                  
  accepts_nested_attributes_for :notes,:fee
  
  after_save :set_status_diagram_conversion_time 
  before_create :set_country_city

  def set_country_city
    self.country_id = institution.country_id
    self.city_id = institution.city_id
  end 
  
  def set_status_diagram_conversion_time
    return if !app_status_id_changed?

    status_name = ApplicationStatus.find(app_status_id).name
    diagram = StatusDiagram.create!(status_id: app_status_id,
                                    user_id: created_by,
                                    programme_id: id,
                                    status_name: status_name)
    if (status_name.downcase == "joined")
      reg = registration
      conversion_time = ((diagram.created_at - reg.created_at) / 86400).round(3) rescue 0
      update_column(:conversion_time,conversion_time)
      if !reg.nil?
        if reg.conversion_time.nil?
          reg.update_column(:conversion_time,conversion_time)
        end
      end
    end    
  end

  def self.joined?(id)
    ApplicationStatus.find_by_name("joined").id == id    
  end
  
  def self.joined_ins(ins_id)
    includes(:application_status).where(institution_id: ins_id,application_statuses: {name: "joined"})
  end

  def self.deferred
    includes(:application_status).where("application_statuses.name != 'joined'")
  end

  def self.joined
    includes(:application_status).where("application_statuses.name = 'joined'")
  end
  
  def course_level_name
    course_level.name rescue "No Course"
  end 
  
  def p_fee_type_name
    p_fee_type.name rescue "Unknown"
  end
  
  def p_fee_status_name
    p_fee_status.name rescue "Unknown"
  end
  
  def institution_name
    institution.name rescue "Unknown"
  end 

  def ins_type_name
    ins_type.name rescue "Unknown"
  end 
  
  def registration_name
    registration.name rescue "Unknown"
  end 

  def owner
    registration.owner
  end

  def name
    course_level_name + ' ' + institution_name
  end

  def assigned_to
    registration.assigned_to
  end

  def self.countries_processing_fee(ids,direction)
    hsh = {}    
    joins(:country)
    .where(id: ids)
    .group("country_id")
    .select("sum(p_fee_cents) as result1,countries.name as cname")
    .order("result1 #{direction}")
    .map {|o| hsh[o.cname] = o.result1.to_i }
    hsh
  end 

  def self.course_level_weight(ids,direction)
    hsh = {}    
    joins(:course_level)
    .where(id: ids)
    .group(:level_id)
    .select("count(programmes.id) as r1,course_levels.name as cname")
    .order("r1 #{direction}")
    .map {|o| hsh[o.cname] = o.r1.to_i }
    hsh
  end   
end
