class AddInsColsToUserConfigs < ActiveRecord::Migration
  def change
    add_column :user_configs, :ins_cols, :text
  end
end
