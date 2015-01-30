class Qualification < ActiveRecord::Base
  belongs_to :registration
  belongs_to :qualification_name 

  attr_accessible :desc, :name, :partner,:subject, :grade, :exam,:score, :graduated_out, :registration_id, :qualification_name_id 
end
