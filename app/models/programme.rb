class Programme < ActiveRecord::Base
  include CoreExtension
  
  belongs_to :enquiry
  belongs_to :registration
  belongs_to :course_level, :foreign_key => 'level_id'
  belongs_to :country
  belongs_to :city
  belongs_to :institution
  belongs_to :institution_type, :foreign_key => 'type_id'
  belongs_to :course_subject, :foreign_key => 'subject_id'
  belongs_to :application_status,:foreign_key => 'app_status_id'
  belongs_to :claim_status,:foreign_key => 'claim_status_id', class_name: "CommissionClaimStatus"
  
  has_many :status_diagrams
  
  has_one :fee
  
  has_many :commissions, through: :fee
  
  monetize :p_fee_cents, :allow_nil => true
  
  belongs_to :p_fee_type, :foreign_key => 'p_fee_id', class_name: "ProcessingFeeType"
  belongs_to :p_fee_status, :foreign_key => 'p_fee_status_id', class_name: "ProcessingFeeStatus"
  
  has_many :notes,foreign_key: "sub_id",:conditions => 'notes.sub_class = "Programme"'
  
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
  
  after_save :set_status_diagram
  
  def set_status_diagram
    if self.app_status_id_changed?
      StatusDiagram.create!(status_id: self.app_status_id,
                            user_id: self.created_by,
                            programme_id: self.id)
    end
  end
  
  def self.joined_ins(ins_id)
    includes(:application_status).where(institution_id: ins_id,application_statuses: {name: "joined"})
  end
  
  def course_level_name
    self.course_level.name rescue "No Course"
  end 
  
  def p_fee_type_name
    self.p_fee_type.name rescue "Unknown"
  end
  
  def p_fee_status_name
    self.p_fee_status.name rescue "Unknown"
  end
  
  def institution_name
    self.institution.name rescue nil
  end 

  
end
