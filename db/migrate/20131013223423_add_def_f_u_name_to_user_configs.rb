class AddDefFUNameToUserConfigs < ActiveRecord::Migration
  def change
    add_column :user_configs, :def_f_u_name, :string
  end
end
