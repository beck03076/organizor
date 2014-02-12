class AddDefProSearchColAndProColsToUserConfigs < ActiveRecord::Migration
  def change
    add_column :user_configs, :def_pro_search_col, :string
    add_column :user_configs, :pro_cols, :text
  end
end
