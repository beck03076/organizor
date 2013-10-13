class AddDefFUDescToUserConfigs < ActiveRecord::Migration
  def change
    add_column :user_configs, :def_f_u_desc, :text
  end
end
