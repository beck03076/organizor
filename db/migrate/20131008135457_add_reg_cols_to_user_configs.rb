class AddRegColsToUserConfigs < ActiveRecord::Migration
  def change
    add_column :user_configs, :reg_cols, :text
  end
end
