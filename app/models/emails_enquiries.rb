class EmailsEnquiries < ActiveRecord::Base
  attr_accessible :email_id, :enquiry_id
  belongs_to :enquiries
  belongs_to :emails
  


end
