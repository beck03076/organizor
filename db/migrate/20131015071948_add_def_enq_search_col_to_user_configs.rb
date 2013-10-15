class AddDefEnqSearchColToUserConfigs < ActiveRecord::Migration
  def change
    add_column :user_configs, :def_enq_search_col, :string
  end
end
