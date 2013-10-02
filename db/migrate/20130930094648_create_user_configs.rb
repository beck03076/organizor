class CreateUserConfigs < ActiveRecord::Migration
  def change
    create_table :user_configs do |t|
      t.integer :def_follow_up_days
      t.integer :user_id

      t.timestamps
    end
  end
end
