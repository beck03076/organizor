class UserConfig < ActiveRecord::Base
  serialize :reg_cols,Array
  serialize :enq_cols,Array
  attr_accessible :def_follow_up_days, :user_id,:def_note,
  :reg_cols,:enq_cols,:def_enq_email,
  :def_reg_email,:def_create_enquiry_email,:def_from_email,
  :def_f_u_name,:def_f_u_desc,:def_f_u_type,:auto_cr_f_u,
  :auto_email_enq,:def_f_u_ass_to,:def_enq_search_col, :def_reg_search_col
  
  belongs_to :user
end
