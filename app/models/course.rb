class Course < ActiveRecord::Base
  attr_accessible :apply_link, :bursaries, :contact_email, :contact_name, :contact_phone, :contact_web, :department, :desc, :fund, :gscholarships, :intake, :internfee, :intl, :name, :named_pathway, :new_enrollment, :qdmode, :requirements, :scholarships, :total_enrollment, :ukfee, :university
end
