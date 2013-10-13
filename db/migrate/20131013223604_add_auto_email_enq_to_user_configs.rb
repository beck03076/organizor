class AddAutoEmailEnqToUserConfigs < ActiveRecord::Migration
  def change
    add_column :user_configs, :auto_email_enq, :boolean
  end
end
