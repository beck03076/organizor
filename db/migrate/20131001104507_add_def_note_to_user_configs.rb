class AddDefNoteToUserConfigs < ActiveRecord::Migration
  def change
    add_column :user_configs, :def_note, :text
  end
end
