class AddDefFUAssToToUserConfigs < ActiveRecord::Migration
  def change
    add_column :user_configs, :def_f_u_ass_to, :integer
  end
end
