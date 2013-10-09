class UserConfig < ActiveRecord::Base
  serialize :reg_cols,Array
  attr_accessible :def_follow_up_days, :user_id,:def_note,:reg_cols
end
