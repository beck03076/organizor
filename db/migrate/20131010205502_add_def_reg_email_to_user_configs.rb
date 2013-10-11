class AddDefRegEmailToUserConfigs < ActiveRecord::Migration
  def change
    add_column :user_configs, :def_reg_email, :string
  end
end
