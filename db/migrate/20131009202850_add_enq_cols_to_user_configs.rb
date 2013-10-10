class AddEnqColsToUserConfigs < ActiveRecord::Migration
  def change
    add_column :user_configs, :enq_cols, :text
  end
end
