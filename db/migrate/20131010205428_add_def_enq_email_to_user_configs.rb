class AddDefEnqEmailToUserConfigs < ActiveRecord::Migration
  def change
    add_column :user_configs, :def_enq_email, :string
  end
end
