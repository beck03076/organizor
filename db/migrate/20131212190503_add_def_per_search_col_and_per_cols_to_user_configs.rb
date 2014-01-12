class AddDefPerSearchColAndPerColsToUserConfigs < ActiveRecord::Migration
  def change
    add_column :user_configs, :def_per_search_col, :string
    add_column :user_configs, :per_cols, :text
  end
end
