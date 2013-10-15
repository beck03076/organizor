class AddDefRegSearchColToUserConfigs < ActiveRecord::Migration
  def change
    add_column :user_configs, :def_reg_search_col, :string
  end
end
