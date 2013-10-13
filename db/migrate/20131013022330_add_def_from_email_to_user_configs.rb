class AddDefFromEmailToUserConfigs < ActiveRecord::Migration
  def change
    add_column :user_configs, :def_from_email, :string
  end
end
