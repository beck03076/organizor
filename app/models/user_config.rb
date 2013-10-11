class UserConfig < ActiveRecord::Base
  serialize :reg_cols,Array
  serialize :enq_cols,Array
  attr_accessible :def_follow_up_days, :user_id,:def_note,:reg_cols,:enq_cols,:def_enq_email,:def_reg_email
end
