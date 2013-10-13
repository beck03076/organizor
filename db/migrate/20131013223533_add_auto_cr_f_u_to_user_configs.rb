class AddAutoCrFUToUserConfigs < ActiveRecord::Migration
  def change
    add_column :user_configs, :auto_cr_f_u, :boolean
  end
end
