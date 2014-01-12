class AddDefInsSearchColToUserConfigs < ActiveRecord::Migration
  def change
    add_column :user_configs, :def_ins_search_col, :string
  end
end
