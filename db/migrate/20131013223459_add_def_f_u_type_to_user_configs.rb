class AddDefFUTypeToUserConfigs < ActiveRecord::Migration
  def change
    add_column :user_configs, :def_f_u_type, :integer
  end
end
