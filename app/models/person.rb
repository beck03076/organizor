class Person < ActiveRecord::Base

  include CoreModel


  notifiably_audited alert_for: [[[:mobile,:email],"Contact Details","Primary mobile/email is changed for this enquiry"],
                                 [[:assigned_to],"Re-assigned","This Enquiry has been reassigned to you"],
                                 [[:notes_count],"count","Count of notes"]],
                                 title: :first_name,
                                 create_comment: "New <<here>> has been created", 
                                 update_comment: "Custom: Values of <<here>> has been updated" 
  
  validates :first_name, 
            uniqueness: {scope: [:surname,:date_of_birth], 
                         message: " Surname and Date of Birth already exists as another person, please check!" }
  
  attr_accessible :address_line1, :address_line2, :address_post_code, 
  :blogger, :city_id, :country_id, 
  :date_of_birth, :desc, :email, 
  :facebook, :first_name, :gender, 
  :gplus, :home_phone, :image, 
  :linkedin, :mobile, :skype, 
  :subject_class, :subject_id, :surname, 
  :twitter, :website, :work_phone,
  :created_by,:updated_by,:assigned_by,
  :assigned_to,:type_id,:notes_attributes,
  :job_title, :institution_id,:remote_image_url,
  :assigned_at,:sub_agent
  
  mount_uploader :image, HumanImageUploader
  
  belongs_to :country             
  belongs_to :city  
  belongs_to :person_type, class_name: "PersonType",foreign_key: "type_id"
  belongs_to :type, class_name: "PersonType",foreign_key: "type_id"  
  belongs_to :institution   

  has_one :programme, through: :institution
  has_many :enquiries, foreign_key: "sub_agent_id"
  has_many :users, as: :userable

  before_save :update_sub_agent

  # ========= delegating _name methods for assoc in array ================
  [:country,:city,:person_type,:type,:institution].each do |assoc|
    delegate :name, to: assoc, prefix: true, allow_nil: true
  end   
  # ======================================================================

  alias_method :nationality, :country_name  
  alias_method :creator, :cby
  alias_method :owner, :ato
  

  def update_sub_agent
    sub_agent = PersonType.find_by_name("unofficial sub agent").id
    return if type_id != sub_agent
    self.sub_agent = true
  end

  def address
    [self.address_line1.to_s,
     self.address_line2.to_s,
     self.city_name,
     self.country_name,
     self.address_post_code.to_s].join(', ').strip
  end
 
  def name
    (self.first_name.to_s + ' ' + self.surname.to_s).titleize.strip
  end
  
  def self.sub_agent
    type = PersonType.find_by_name("unofficial sub agent").id
    where(type_id: type).order(:first_name)
  end

  def self.sub(i)
    where(sub_agent: i).size
  end

  def self.sub_agents
    where(sub_agent: true)
  end

  def self.bar_chart(cond,asso,asso_name,sub_asso,cat1,cat2)
    p cat1
    c1 = cat1.to_s.pluralize
    cats = cat1.to_s.camelize.constantize.all.map &cat2
    includes(asso,
             sub_asso).where(cond).where(c1.to_sym => 
                             {cat2 => cats}).group(["#{asso.to_s.pluralize}.#{asso_name}","#{c1}.name"]).count.reject{|k,v| k[0].nil? }
  end 

  def self.enquiries_registered(ids,direction)
    hsh = {}    
    joins(:enquiries)
    .where(enquiries: {id: ids},people: {sub_agent: true})
    .group("sub_agent_id")
    .select("count(enquiries.id) as tcount,
           sum(case when enquiries.registered = 1 then 1 else 0 end) rcount,
           people.first_name as sname,
           people.id as sid")
    .order("rcount #{direction}")
    .map {|o| hsh[o.sname] = [o.tcount,o.rcount,o.sid]}
    hsh
  end 
  
end
