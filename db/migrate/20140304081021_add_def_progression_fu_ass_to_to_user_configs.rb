class AddDefProgressionFuAssToToUserConfigs < ActiveRecord::Migration
  def change
    add_column :user_configs, :def_progression_fu_ass_to, :integer
  end
end
