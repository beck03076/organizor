class Contract < ActiveRecord::Base
  attr_accessible :commission_rate, :current_contract_end_date, :current_contract_start_date,
  :desc, :initiate_date, :partner_id,
  :internal_target, :invoicing_deadline, :name,
  :partners_target, :recruitment_territories, :renewal_reminder_date,:notes_attributes,
  :created_by,:updated_by,:documents_attributes,
  :all_prohibited_country_ids,:all_prohibited_region_ids,
  :all_permitted_country_ids,:all_permitted_region_ids,
  :prohibited_countries,:prohibited_regions,
  :permitted_countries,:permitted_regions,
  :commission_specified,:territory_specified,
  :sliding_scales_attributes, :contract_status_id

  has_many :notes,as: :noteable

  has_many :documents, dependent: :destroy

  belongs_to :partner

  has_many :sliding_scales

  belongs_to :contract_status

  attr_reader :prohibited_countries,:prohibited_regions,
  :permitted_countries,:permitted_regions

  # this is renamed to all_* in order to maneuver token input methods
  has_and_belongs_to_many :all_prohibited_countries,
                           class_name: "Country", join_table: :prohibited_countries
  has_and_belongs_to_many :all_permitted_countries,
                           class_name: "Country", join_table: :permitted_countries
  has_and_belongs_to_many :all_prohibited_regions,
                           class_name: "Region", join_table: :prohibited_regions
  has_and_belongs_to_many :all_permitted_regions,
                           class_name: "Region", join_table: :permitted_regions

  accepts_nested_attributes_for :notes,:documents, :sliding_scales,:allow_destroy => true


  def prohibited_countries=(ids)
    self.all_prohibited_country_ids = ids.split(",")
  end

  def prohibited_regions=(ids)
    self.all_prohibited_region_ids = ids.split(",")
  end

  def permitted_countries=(ids)
    self.all_permitted_country_ids = ids.split(",")
  end

  def permitted_regions=(ids)
    self.all_permitted_region_ids = ids.split(",")
  end

  def assigned_to
    partner.assigned_to
  end

end
